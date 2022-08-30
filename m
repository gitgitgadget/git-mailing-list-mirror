Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A601ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiH3JfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiH3JeO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:14 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEACCE42E2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:01 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11f4e634072so1126760fac.13
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MQPMTQIwLdDmVBRI1pD0ywp0dt6ZsLI3M0bKtlfXG2s=;
        b=o7zAoxYVmfL5dVeuj0u9o9w/O3lxA8xBDj79cCyBSnUSQ9l4ZICycQPTuqizAMgegS
         9OlBX/ASdOu2rjyf0JsAVekTtH5dO23P0lisQipi+rPUVQMGL+8b2SZtTbvgSem2XOCb
         xZs7xg9gsTydzO7gX4TxgVJHszvLBVXcVSEVKUpklpJb0L1mNq6V0BtGZCsts3cTnE4N
         CZ4TOWr5dOkIUfh2x8FUcsm/vY2MPZ2XKC0+z5lIdh1IiOLwzXTX6an0yX7lVMjbvnSG
         x1FF/vQ1Xg4OSn7TWyDpEB7/Z6NNbdelYIdnrDHijPtOMcmxYfOdd3h6hLNRvgphBQ2+
         UoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MQPMTQIwLdDmVBRI1pD0ywp0dt6ZsLI3M0bKtlfXG2s=;
        b=XDIZfHB4ewIkaIA6fbHzN85ybBznhEES/gUnTvfPFw/kF80fg0I7QyuhVDFCfW9KF1
         MtlA/nEe66DLshBebbWEJDHRkVELgK6Vit11Vs52OFqEMVsCbrXrBnhVZfyHN1r6YzPB
         RbLNlIEboyYbluygPki5zgZpQ2KdzrfYJcYxe5P+nEICApoCGrCzjnSJikkf7hbbDAW/
         zPOz9VB8Vszkcd/MxPghQ04qdP10KBKGy1c43+OnZjnLRa4iI9Y2yAMo3VdQtlmEqTAQ
         X3UN84Ot+sbDA7vtq+pUpYm/LDJH29ZD7qITn9sY0T2+monphf3AAwSxQ2tgoAM+7ejP
         H2eA==
X-Gm-Message-State: ACgBeo3WJNdz+iTx1/m4VitMG/83bamsYv7KGJ6eGSj08ZkrNnHHURle
        WlHQGAkB38XpuRkx1OJrzrT2Ls6tZP4=
X-Google-Smtp-Source: AA6agR6vikPMrx+GtFlQA2YNevQiYZbzyXx8M2P2Pi79khmqlwRKF3EY9BfJXjQ9Sd2TRtspRJxnuA==
X-Received: by 2002:a54:4e8e:0:b0:343:fe9:9516 with SMTP id c14-20020a544e8e000000b003430fe99516mr9144806oiy.198.1661851976313;
        Tue, 30 Aug 2022 02:32:56 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y5-20020a056830208500b00636fd78dd57sm7135860otq.41.2022.08.30.02.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 44/51] completion: zsh: add correct removable suffix
Date:   Tue, 30 Aug 2022 04:31:31 -0500
Message-Id: <20220830093138.1581538-45-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Zsh has a nice feature that allows a suffix to be automatically removed
if followed by a space.

For example:

  git log --prety=

If a space is typed, the suffix '=' is removed.

But we have to set the correct prefix first.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index e66044ee89..7d34522621 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -52,7 +52,7 @@ functions[complete]="$old_complete"
 
 __gitcompadd ()
 {
-	compadd -p "${2-}" -S "${3- }" -- ${=1} && _ret=0
+	compadd -p "${2-}" -S "${3- }" -q -- ${=1} && _ret=0
 }
 
 __gitcomp ()
@@ -80,7 +80,8 @@ __gitcomp_opts ()
 
 		if [[ -z "${4+set}" ]]; then
 			case $c in
-			*=|*.) sfx="" ;;
+			*=) c="${c%=}"; sfx="=" ;;
+			*.) sfx="" ;;
 			*) sfx=" " ;;
 			esac
 		else
-- 
2.37.2.351.g9bf691b78c.dirty

