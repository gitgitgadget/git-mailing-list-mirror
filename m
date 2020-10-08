Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD0C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 05:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6DC20725
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 05:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdHKEQrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgJHFsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 01:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgJHFsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 01:48:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A88EC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 22:48:25 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d6so2199449plo.13
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmBHaJiwH/h73Dv11noQSSciU42wVGIhTyC/ZBJtxVM=;
        b=QdHKEQrcGWhHtm5tzhDS2gjz3EQYlK5hCwYzDTWyGb0jtM5mA6sATGSk/CSVmmZOw3
         IA8iXJ/JlN3gNHSr42PenDGuCQLwpInDKWTTqyuNPnx82ZirV9iJjsVyDTXhDPIJd9SB
         VrL/b1pLd+lEGjBUMn1vpCfhDkTjwPVBVvk2ljTeTdH3GAbcniwR4KTgDax65mtc7WIP
         HXM2BNZuQULtNzhoFicq4QUIKf9DmIhagVI7gZzefJnlGZMmlawFcfcpYzQFEQebYCzf
         5t9Tyr8+kK7+z/ofX99w/JbUBnLHimUrXMOpwym/Hr+D9xfl1aTGFIgrmE7eCDsUmgwz
         W/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmBHaJiwH/h73Dv11noQSSciU42wVGIhTyC/ZBJtxVM=;
        b=CHstHmGv32Blx/RkiFs00Xp43ffbom483esu7/kFT/aTGe4IGjHhugMpgs+Har8Sdi
         qoWjFyMBuEdO0QQYT0t2hl0OHlLAo2X908VG89uQop2+vRjnUZ7+6AyRetzTdG5TkgMV
         b6R6U6rzrXvULdlcaQXPd8ofkcxFxbZH1jxDoYle4hKZ2OjZJ1d+PmnywAm9JN463frS
         xHqnOpoB703zD0aNU47p302oEIxQgRNydE+y7cITSZiNCD56aRgw/VAlZFjbpypnkh4l
         L1Ai0mFX0gWmRuD40FXaYTlLB4EFn5yFJhb7D4OQWouDkOGTcIkxSQAje3Qi3GHgfDWF
         9vMg==
X-Gm-Message-State: AOAM532FZO7WyTHaAxPIXWaW1GBzUCH5NGqrgeNSDOjlDNUm5VaJuxjF
        tP57DwVeHuIMBDZL6KY4s/aOE2ez4LE=
X-Google-Smtp-Source: ABdhPJw0F/GjvsL4NaALyW4k73N/5B+gEJSscEdxJsAxShVwTIULtAn5YKfaCVCmQVEbi4GGgaQK1A==
X-Received: by 2002:a17:902:6f08:b029:d2:ab80:4ac4 with SMTP id w8-20020a1709026f08b02900d2ab804ac4mr6137452plk.72.1602136104401;
        Wed, 07 Oct 2020 22:48:24 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id g4sm5706169pgg.75.2020.10.07.22.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 22:48:23 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] checkout: learn the checkout.guess config variable
Date:   Wed,  7 Oct 2020 22:48:13 -0700
Message-Id: <cover.1602136063.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.942.g77c4c6094c
In-Reply-To: <cover.1602047333.git.liu.denton@gmail.com>
References: <cover.1602047333.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a user does not wish to use DWIM behaviour, they must manually
specify git checkout --no-guess each time. Teach checkout and switch to
honour the checkout.guess config variable instead.

Changes since v1:

* Replace enumerated priority list with bullet points

Changes since v2:

* Clarify that `--guess` is the default for checkout in the docs

Denton Liu (2):
  Documentation/config/checkout: replace sq with backticks
  checkout: learn to respect checkout.guess

 Documentation/config/checkout.txt      | 21 +++++++----
 Documentation/git-checkout.txt         |  5 ++-
 Documentation/git-switch.txt           |  3 ++
 builtin/checkout.c                     |  7 +++-
 contrib/completion/git-completion.bash | 25 ++++++++-----
 t/t2024-checkout-dwim.sh               | 11 ++++++
 t/t2060-switch.sh                      |  5 ++-
 t/t9902-completion.sh                  | 52 ++++++++++++++++++++++++++
 8 files changed, 109 insertions(+), 20 deletions(-)

Range-diff against v2:
1:  f08d3f796a = 1:  f08d3f796a Documentation/config/checkout: replace sq with backticks
2:  2678680a08 ! 2:  eb9daf4bcd checkout: learn to respect checkout.guess
    @@ Documentation/config/checkout.txt: will checkout the `<something>` branch on ano
     
      ## Documentation/git-checkout.txt ##
     @@ Documentation/git-checkout.txt: branches from there if `<branch>` is ambiguous but exists on the
    + 'origin' remote. See also `checkout.defaultRemote` in
      linkgit:git-config[1].
      +
    - Use `--no-guess` to disable this.
    +-Use `--no-guess` to disable this.
    ++`--guess` is the default behavior. Use `--no-guess` to disable it.
     ++
     +The default behavior can be set via the `checkout.guess` configuration
     +variable.
-- 
2.28.0.942.g77c4c6094c

