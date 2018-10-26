Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA7391F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbeJ0EGD (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 00:06:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54481 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0EGC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 00:06:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so2507470wma.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQXz5bBg3+FsZ88Gvjr1CGI1ouvqxDpoUZSFbGXdpVU=;
        b=uMjZsFT7bqYaLND/SdjE/4/zyViRNOedRy1oMn1g9MOi3f2fZZ3AWo+55THYlZzVW1
         VZomZnED+oPEky0kEGppzIFvLhbYOvKLIBiFbk7v0XSP0DK5J84gebDS4/XR/dYtmWBy
         F/XNPN5dNJGbfPEwfpzShRdzAmw8kGtey77d+zo9oT2FP1qflIuVNBt0X9RqJyYQPP0J
         Z1c30RQA64+zzg6x9EM8p8Y80GExsbX+VsryaoK032RDCjgLmCwVwnCJO1dBiTRDngCw
         RNfVyS6nS5I7RSRQtphUafpEyhn4RZN+n4hyu4hHPiq0H3NymTETOeJpDPe0blS+h9SH
         dcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQXz5bBg3+FsZ88Gvjr1CGI1ouvqxDpoUZSFbGXdpVU=;
        b=BwVlnSD1/p8tZWR5M9ab9pWrnecpR4hA84PtHyvXnDNm03DWdzeCvJW4Fu3hWI4lMY
         aFegoMHY2bqWwvF1i4SWkQqOtLS1HEUFOlnymDg7hOZ0vLNFLJo7xIJUxKdDuwqhQgsB
         VtFae4UXHCVEagVmaHxNBrf49ZkWv3Y+JZsdhl2RioW34Ezng4JqhqJYj3oPHFfQfZmX
         tqubpT9Wu3DylFAc58jsZRK6vYe3/jTxwNGCDqMnvwvA6To6p7kwQKBKcZOvvDHBBeKB
         b2gant9sLIb2TlaTzWsKPa810yegPq7f9WP7X/QxsK21Pc2+QJdAVPzf4zKZbRu1TKq/
         0WqA==
X-Gm-Message-State: AGRZ1gKrtCUv/SbJRhYNh6cHcRqbwWcJjbpdj2IGS5M3D3Vk7eZ+XBO/
        OZSLwIR5BNY0BwnaDAOglzOLPxvz
X-Google-Smtp-Source: AJdET5fmpymYAwQwRWJmtKueCfsTD/zcKWB5+C/DBP32wbXaKUmIS5bU+5PR+9iHowin/xwP33Sf7A==
X-Received: by 2002:a1c:bce:: with SMTP id 197-v6mr6205635wml.15.1540582064013;
        Fri, 26 Oct 2018 12:27:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e196-v6sm10738981wmf.43.2018.10.26.12.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 12:27:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/7] fixes for unqualified <dst> push
Date:   Fri, 26 Oct 2018 19:27:27 +0000
Message-Id: <20181026192734.9609-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
References: <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has grown to a 7-part series for v2 (from 2 patches). This
addresse all the feedback for v1 and then some.

Ævar Arnfjörð Bjarmason (7):
  remote.c: add braces in anticipation of a follow-up change
  i18n: remote.c: mark error(...) messages for translation
  push: improve the error shown on unqualified <dst> push
  push: move unqualified refname error into a function
  push: add an advice on unqualified <dst> push
  push: test that <src> doesn't DWYM if <dst> is unqualified
  push: add DWYM support for "git push refs/remotes/...:<dst>"

 Documentation/config.txt |   7 +++
 advice.c                 |   2 +
 advice.h                 |   1 +
 remote.c                 | 124 +++++++++++++++++++++++++++++++--------
 t/t5505-remote.sh        |  57 ++++++++++++++++++
 5 files changed, 166 insertions(+), 25 deletions(-)

-- 
2.19.1.759.g500967bb5e

