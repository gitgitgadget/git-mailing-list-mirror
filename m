Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4304ECAAD4
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiH3JeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiH3Jcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:48 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401F5E0974
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:29 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11f4e634072so1124368fac.13
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=AYTAj8pNRPhv1uZS4iNq67j+h5ZYkolLi9KqWbVN8E0=;
        b=WBvsvLuchrWLZx5o0c5hNSbyi2zSidcsAky5FdS8qAaUq/VQf2gm6TUy5z/Gk02kMI
         mqIvZyfI/WRtlEnt9pxk4kunr/G16+pbD6eUfJA64PwEDkhT2kMA4AWBJWUMIV9aLqVh
         ppMJ7cCTMlcX1z43E0zzRqw/dGu6rlkCcFIXWmPqTtXRzMv0ju8K2ZlNYbCDlvL2H4K0
         RXXkDEvF9pP/+vwzMc/dLs2Pr3lMWaA4VGbqzu1VPM6i+ldXUR6wXtcHZRVbPz153elv
         pe+MIgdlFSczLRnksy3cBad7S/ErZzyRlxFNI2cKAtUBboO1XLNZZg3twA8vq33MS+LM
         /p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=AYTAj8pNRPhv1uZS4iNq67j+h5ZYkolLi9KqWbVN8E0=;
        b=0sf8+Q4aVPxEbn7YrHDqcMCKPWXAQPzC4L0dT8Kscv96Wt4WNey0Na12jqVg0uq6/z
         NODEnJfBeaosagJWEM5LyJVrpcsyhLsUQ4X+x7YvBg5JBKU1cCAVjC081h68/W2mwjPz
         Y0ZuK30kWzS8uO734czir+UIPgaetDu/ItyqxJVu/80jinzo3k44TDbfAS472Vyl5Kua
         gGIjHJqz+n3l59XPYCElTDVC93pf6Eg/AV/8/nSKyIL4HaYG6OSSlQlXTSOdOtd0JLGr
         uzGTpO5tvoLeHxfkKUBu6qzwjl8nqKbvgonblbL926xIbWbupF6olMhSYngBbmsFY4lc
         Kjcw==
X-Gm-Message-State: ACgBeo3dpt0REjbf/CgUSk1ijJjw6WT25B9ecNHBY2uy8SrG6XcABVPw
        NLJwC2hEeU/+28aPi7qgR97YjuTQsCI=
X-Google-Smtp-Source: AA6agR6EXza8UkxLN4zgv1kEF/udETt8B8Rz0tKucOMhquAVJR3BJd1Xg8E4LsovrTykeY+ybd8tjg==
X-Received: by 2002:a05:6870:8890:b0:101:db34:3ed6 with SMTP id m16-20020a056870889000b00101db343ed6mr10196912oam.151.1661851944466;
        Tue, 30 Aug 2022 02:32:24 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id e6-20020a9d7306000000b006393ea22c1csm6886888otk.16.2022.08.30.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:32:23 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 26/51] completion: zsh: always set compset
Date:   Tue, 30 Aug 2022 04:31:13 -0500
Message-Id: <20220830093138.1581538-27-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So we don't have to set it every time.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index d2eb221d79..41272b00e3 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -73,7 +73,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	*)
@@ -92,7 +91,6 @@ __gitcomp ()
 			esac
 			array+=("$c")
 		done
-		compset -P '*[=:]'
 		compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 		;;
 	esac
@@ -102,7 +100,6 @@ __gitcomp_direct ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S '' -- ${(f)1} && _ret=0
 }
 
@@ -110,7 +107,6 @@ __gitcomp_nl ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -Q -S "${4- }" -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -118,7 +114,6 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
-	compset -P '*[=:]'
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
@@ -136,6 +131,8 @@ __git_complete_command ()
 {
 	emulate -L zsh
 
+	compset -P '*[=:]'
+
 	local command="$1"
 	local completion_func="_git_${command//-/_}"
 	if (( $+functions[$completion_func] )); then
-- 
2.37.2.351.g9bf691b78c.dirty

