Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB409C4332F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A75060F92
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhJGDjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 23:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbhJGDjt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 23:39:49 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4010BC061753
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 20:37:56 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id z15so3335185qvj.7
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 20:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5miaebffGepVtspgU2vqqslmRuZ5w1xZvjmaNwSWAk=;
        b=Pe+Rf5p4B0zpPRDRs34v58e5v0n/mL1iveMikJVZz4nWgoIPY1+6W+c8a1LKanCHYy
         MRB7zHpzLOJcc9X3/7DmDFfrOVO6M6K2PYwqCKgBsx4f1bqHFa1uAR01vjy2lYVNcLW4
         WHMxYtSYeiVuUnjfCeVrVtPTaqOqyE2v59swRHJEbJcbilvWGLcTVkUUj6XnPyVrSFab
         eBEfwIuQ0rNb5H/wCjXRLFwmUGj9Gt20yTNZ16RpxZYEMx732uP9KT9UQduhr6sVL0Lb
         nGJmh2eVnbkKj+SzD8H7sCQ18fEyqkiqV08Ob34RJAPAWBIOE0/F509G6erDr4oyUxtQ
         7vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5miaebffGepVtspgU2vqqslmRuZ5w1xZvjmaNwSWAk=;
        b=ROii/ga2uhmM+bnlWphpngVg8IfiK7h5KJ+u+oJLqaUSHnp5AyNclEdXR9DUxYP29v
         tFfgklM69H0lhk3wPlIjYdA+fiE0audl6vjN4CvrDJkgZmBnjg3zYU6esq5G5pAB5Njd
         QoiwFs50ErY8TZ/J+zWqB651zbME4BDKby8X+j6lbyTXbgKBHRMA4E0NqDjAkggj9yUA
         kYN/GGYJBDsyA9J7YXV/SyMVSzC9EnAFRFG3SAlKhuLGS10cDg7JIoL/VnJnHvJHdfV+
         HeSpgI7slgPs2xVCNBtPBTNj2W44MfVu7zCQIaltSSVm69/vhvgaNo7Qo1VTeyKEXEh6
         6EIg==
X-Gm-Message-State: AOAM532oZvI+2sAwdFLliYHBPrbnvBcCdl3h3O4RJEH4KfAVyqpSreET
        KN3MC/vk8xP/Cj7GoGusVw4=
X-Google-Smtp-Source: ABdhPJztJcutQsBmJFC8B68/YSWtrN4PPVyw9b4vPBa+gM2IL2OAMa61wOF6H3dLjmxtXlEGHVpTQA==
X-Received: by 2002:a0c:804a:: with SMTP id 68mr583652qva.27.1633577875409;
        Wed, 06 Oct 2021 20:37:55 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id x6sm13892860qts.79.2021.10.06.20.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:37:55 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v6 3/3] send-email docs: add format-patch options
Date:   Wed,  6 Oct 2021 23:36:52 -0400
Message-Id: <20211007033652.80793-4-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
References: <CABOtWuqXS_kJk2md=kgg-ReaWtKermpUW_Dk_bc0pMXQL+xMeA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-send-email(1) does not mention that "git format-patch" options are
accepted. Augment SYNOPSIS and DESCRIPTION to mention it.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 Documentation/git-send-email.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3db4eab4ba..41cd8cb424 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,7 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
+'git send-email' [<options>] <file|directory>...
+'git send-email' [<options>] <format-patch options>
 'git send-email' --dump-aliases
 
 
@@ -19,7 +20,8 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to git send-email, as well as options understood by
+linkgit:git-format-patch[1].
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
-- 
2.33.0

