Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A957D208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbdHJSdT (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:33:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32973 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752639AbdHJSdR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:33:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id u185so1252306pgb.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xo254pwdulh69F7M1TyY8t/5hpaj9ORr4/spgFELk9k=;
        b=eqYT+sByEAJ7agHWJI3U2tgj6C2SzUX4EiftmcAwLvfa3anGKEGC1/Odqv3d1LDSop
         EbdF2zNBijq5RZMEJKxYlFHLxJYbajdBxoKmG30j9d9LPsPF/33HAb//fdm9/W1Y2SKE
         Bi+fpuMot4fcPh5dvV8BigOZ7HbqpPTNm2cRRIJptxk9QPYA5OU1h/vDQ/8cj7OyBusT
         ash/a8NmwF/Z5eWbOfLs+rGYxQ7J+e2l5WTIvwUGz9Vtv+/cipp1JPS14X+Ncc6iMn1R
         A+IKjcHsc3+b0fNIiXDWFcZ1pocHHUl0yRGLwBy3TxPXDUTslVyjvrzeCtH9XlYy/Cdj
         c52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xo254pwdulh69F7M1TyY8t/5hpaj9ORr4/spgFELk9k=;
        b=j5GkspFJtOougxoQUYIUu/6scmWKs8vxRLjLNpX24fzwdyWvtK4xdsr/6NXgvqZuKL
         rVlCXsPMt2Y3Q9gJ0dicywHYo194c1Hq122Ks/zJvqxVMofyegZccTZMMh+Kjp6bPzeO
         MVV3qtcDk0cJZ1VS3JpcKrSMa2rOXlbAeJibH8cJkyeA4CLPDTWRKRLb16T6iUF87OYs
         f4wBS+ab4IaQEwKhljdXkobS/lA8c2avpikhJI2bw07jMp17Fzdya8VyyhqpNW6+bdja
         swE12Nl3u5/jFtQannvTl/mv1BynqN4y/f3XQ+n73cQRIEDJQbAaJ60sRWHS9l/gNZXf
         wxHw==
X-Gm-Message-State: AHYfb5hYOdnY+6L2lPnSuTWr66DnKAgUqJThw07rfTe584pDTL1I84nM
        rreEk9hIGow+5sJEhDA=
X-Received: by 10.98.16.68 with SMTP id y65mr13465079pfi.165.1502389996641;
        Thu, 10 Aug 2017 11:33:16 -0700 (PDT)
Received: from kewillf-git01.redmond.corp.microsoft.com ([2001:4898:80e8:2::54f])
        by smtp.gmail.com with ESMTPSA id h14sm12953804pgn.34.2017.08.10.11.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Aug 2017 11:33:16 -0700 (PDT)
From:   Kevin Willford <kcwillford@gmail.com>
X-Google-Original-From: Kevin Willford <kewillf@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH v2 2/2] rebase: turn on progress option by default for format-patch
Date:   Thu, 10 Aug 2017 14:32:56 -0400
Message-Id: <20170810183256.12668-3-kewillf@microsoft.com>
X-Mailer: git-send-email 2.14.0.rc0.286.g44127d70e4
In-Reply-To: <20170810183256.12668-1-kewillf@microsoft.com>
References: <20170810183256.12668-1-kewillf@microsoft.com>
In-Reply-To: <20170531150427.7820-1-kewillf@microsoft.com>
References: <20170531150427.7820-1-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This change passes the progress option of format-patch checking
that stderr is attached and rebase is not being run in quiet mode.

Signed-off-by: Kevin Willford <kewillf@microsoft.com>
---
 git-rebase--am.sh | 1 +
 git-rebase.sh     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 375239341f..ff98fe3a73 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -53,6 +53,7 @@ else
 
 	git format-patch -k --stdout --full-index --cherry-pick --right-only \
 		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+		$git_format_patch_opt \
 		"$revisions" ${restrict_revision+^$restrict_revision} \
 		>"$GIT_DIR/rebased-patches"
 	ret=$?
diff --git a/git-rebase.sh b/git-rebase.sh
index f8b3d1fd97..ad8415e3cf 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -74,6 +74,7 @@ test "$(git config --bool rebase.stat)" = true && diffstat=t
 autostash="$(git config --bool rebase.autostash || echo false)"
 fork_point=auto
 git_am_opt=
+git_format_patch_opt=
 rebase_root=
 force_rebase=
 allow_rerere_autoupdate=
@@ -445,6 +446,11 @@ else
 	state_dir="$apply_dir"
 fi
 
+if test -t 2 && test -z "$GIT_QUIET"
+then
+	git_format_patch_opt="$git_format_patch_opt --progress"
+fi
+
 if test -z "$rebase_root"
 then
 	case "$#" in
-- 
2.14.0.rc0.286.g44127d70e4

