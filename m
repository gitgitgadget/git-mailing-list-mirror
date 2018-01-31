Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C27261F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeAaLG7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:06:59 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39979 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753594AbeAaLGz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:55 -0500
Received: by mail-pg0-f67.google.com with SMTP id g16so9755961pgn.7
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUMPwl2BhU4sFdA58zIbkm3Qo4TORS4zE11zeZ59uUI=;
        b=c6nRzDNi/FWuka05zKhFPrugl9I+T5XYzoxhDyU1PQMr02PoUGHt5ER3PdE4snpygC
         9UsKdqNy0CeHccgzymV1PZudhJsHj4ut1lJYBPpUYIMnWgzZAW3An3pRs+o4C1e4MUYT
         At2ZQvDWt6gUbRNcqYbVlJ1LPHxn+TzcgghbGkiwOeyqSfmn1DQ2cYIlhsnjQ663f/RB
         XJNvRGlHyIfdmyRUTYA6JWWklstgmH63pwYCjzitLhM2xlcuv99h46XfT5aRhEqDTiSS
         EqjuGpRqSpo8AsYEFcdwRY8sotkC9ZM7GgtuMI56ko1EV9n2nn0At3ei5XumxrNcHXjF
         LV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUMPwl2BhU4sFdA58zIbkm3Qo4TORS4zE11zeZ59uUI=;
        b=FneC+WbQHxksC+Y+6D5A9RJZLxZlJ+BU20YY5xUpH/VhdP1omKdhYrFw68TrRHEyx1
         U/HN6h2yp5bdrVKuVco1MkaOhVZEgAxyUnLFeRWTmX1cew95etDmMJGdPsID2w14BzKW
         a66ZnBwktF51/MVZGwkgnjtt3mkwpSTCexAoMSD+xBGJKvDWmwIF6YNozxVrNCZnj1W9
         zT4/rFyDiXxq9DM8be+PZjq08dWxtC3K0hjQhk+33XECuXLDWJC9pgpMmqKenllH7WPk
         U6ZEydkkygkZq6NG8OROsxdYcQDVla1suqaQouYwLx16qqOxtC6Mn/5BnBnOtZXgGA6V
         I+zA==
X-Gm-Message-State: AKwxytcldh7TlCHJOjKd9b2gAhjDNXkshXG64iq2jwu+Xh5A69gpxQN7
        +ZFX7rCiUBdHHqEKCtfsiiKhSg==
X-Google-Smtp-Source: AH8x2279lgRSsg023TmiITCPOCmRRufXiiIeOcJURFSJ8mfTe4ut3f3ybxmOD2k5l1RP+IpYw7HTnQ==
X-Received: by 2002:a17:902:2e03:: with SMTP id q3-v6mr19809684plb.362.1517396814681;
        Wed, 31 Jan 2018 03:06:54 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id z15sm26489711pgr.62.2018.01.31.03.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:54 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 12/41] completion: use __gitcomp_builtin in _git_clone
Date:   Wed, 31 Jan 2018 18:05:18 +0700
Message-Id: <20180131110547.20577-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable options are:

--config
--dissociate
--ipv4
--ipv6
--jobs=
--progress
--reference-if-able
--separate-git-dir=
--shallow-exclude
--shallow-since=
--verbose

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c0f6f76c3c..393f86619d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1306,26 +1306,7 @@ _git_clone ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--local
-			--no-hardlinks
-			--shared
-			--reference
-			--quiet
-			--no-checkout
-			--bare
-			--mirror
-			--origin
-			--upload-pack
-			--template=
-			--depth
-			--single-branch
-			--no-tags
-			--branch
-			--recurse-submodules
-			--no-single-branch
-			--shallow-submodules
-			"
+		__gitcomp_builtin clone "--no-single-branch"
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

