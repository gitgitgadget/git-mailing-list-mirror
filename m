Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26943C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9CE61AFA
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 11:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354078AbhJALjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353912AbhJALjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 07:39:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C7EC06177C
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 04:38:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1687871pjb.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfixD7QW71kfjKM+K3vl2N+YTOhYJZZiuSkJAx6rD1c=;
        b=OVioGVME2IqBgcWBqwzI0c9Fvjsxjdm4fcVb3fZXx21b+Sdj1iWtSJCbOrOc9eiqt8
         DeH763LWQxKOMp/IYOfOlFjmjR1hM4DmOpXKGiHtnLiejkbw+Qhso67MjuMaRlQN28Hq
         VKwHkQOuUEOji1nqxWQi4GJpRsY5FO4uA6ReqU09CWCmFC34RpWoPpNPnEflN4uCW2Qz
         vL+xnanUFbJEzq4U6D8O6gz92xUlyFNx6FD2JWoyF63JIppSpW0VrgKQdealkLChwQiO
         +fNQtRmfD1rgoxt9TnhSUQqSjxejcbKoF1YXHsnjulAANZLXHGydufqRzz88WaocDYto
         ButQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfixD7QW71kfjKM+K3vl2N+YTOhYJZZiuSkJAx6rD1c=;
        b=LSeG6Fl/CnLdmqw/mmK9zzwePzgFlxvKrQh31mVLvrS6PYbGCtKMOS39b++QZwh6xV
         Y998/OezOQ3MmfvJT7Ue/lX5BcavXQwtycIIS22ijgrJqdyS2rX7iiIQ2hBKa2+ewM0O
         TtXkcVXRYrO41OlNwX/wk674zfJyppOK6iGytlWOT0UJGHlcY6qJMN4XNdHO2MWS/MvV
         uepC4a/gLygx73ZYRzqGDrsvKww3WfwQN2v+T+J4thtX/GQQZUKz0k0Cu0e8axcasWQq
         9T6YixaIVKdXyDs48T6XMp5i121e9p8sb4RAWovOt2YOHCCxJScsDuo5vC7L3QeWNZ5S
         jOZA==
X-Gm-Message-State: AOAM532CxOPBUsa2GNgmCUpzHdwsBF4WfXdMeOpMU/2RQMQOvaMjIjz0
        dE8DOEfAxII/jWQ4pYS+Ze89xKg8TMRP7w==
X-Google-Smtp-Source: ABdhPJz71s2/uWWrJbIE9z/X8sf0s3DPIwRIV/WZeYQwwX1Q3Pz4F6aF//kaO05TEUgQeUvslD7qNg==
X-Received: by 2002:a17:90b:350d:: with SMTP id ls13mr8142143pjb.146.1633088280645;
        Fri, 01 Oct 2021 04:38:00 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-87.three.co.id. [180.214.232.87])
        by smtp.gmail.com with ESMTPSA id e7sm6066461pfc.114.2021.10.01.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:38:00 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v3 0/2] blame: documentation update
Date:   Fri,  1 Oct 2021 18:37:24 +0700
Message-Id: <20211001113725.13354-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the default output format for git-blame(1), as well as the
--color-* options which are currently undocumented but mentioned in
usage help.

Changes since v2 [1]:
  - describe that the default blame format has "author ident" (suggested
    by Junio)
  - s/they belong to/they come from/ (suggested by Junio)

Bagas Sanjaya (2):
  blame: Describe default output format
  blame: document --color-* options

 Documentation/blame-options.txt | 12 ++++++++++++
 Documentation/config/color.txt  | 12 ++++++------
 Documentation/git-blame.txt     | 17 +++++++++++++++--
 3 files changed, 33 insertions(+), 8 deletions(-)

Range-diff against v2 [1]:
1:  d6433fc682 ! 1:  2478909d67 blame: Describe default output format
    @@ Documentation/git-blame.txt: include::blame-options.txt[]
     +------------------
     +
     +When neither `--porcelain` nor `--incremental` option is specified,
    -+`git blame` will output inline annotation for each line with:
    ++`git blame` will output annotation for each line with:
     +
    -+- abbreviated SHA-1 of the commit the line is attributed to;
    -+- author name (or author email if `-e` or `--show-email` is specified);
    -+- author date; and
    ++- abbreviated object name for the commit the line came from;
    ++- author ident (by default author name and date unless `-s` or `-e` is
    ++specified); and
     +- line number
     +
    ++before the line contents.
     +
      THE PORCELAIN FORMAT
      --------------------
2:  5a5ca69012 ! 2:  a6f75786ec blame: document --color-* options
    @@ Documentation/blame-options.txt: take effect.
      	previously processed files.
      
     +--color-lines::
    -+	Color lines differently, if they belong to the same commit as the preceding line.
    ++	Color lines differently, if they come from the same commit as the preceding line.
     +	This facilitates distinguishing code blocks introduced by different commits.
     +	The color defaults to cyan and be adjusted using the `color.blame.repeatedLines`
     +	config option. Only the line annotation (see "The Default Format" section)
    @@ Documentation/config/color.txt: before the given timestamp, overwriting older ti
     -	Use the customized color for the part of git-blame output that
     -	is repeated meta information per line (such as commit id,
     -	author name, date and timezone). Defaults to cyan.
    -+	Use the specified color to colorize line annotations, if they belong to the
    ++	Use the specified color to colorize line annotations, if they come from the
     +	same commit as the preceding line (`git blame --color-lines`). Defaults to
     +	cyan.
      
[1]:
https://lore.kernel.org/git/20210929124935.41917-1-bagasdotme@gmail.com/T/#t

base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
An old man doll... just what I always wanted! - Clara

