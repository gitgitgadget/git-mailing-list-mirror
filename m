Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50AAB1F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeAaLIe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:08:34 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45905 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbeAaLIb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:08:31 -0500
Received: by mail-pf0-f195.google.com with SMTP id a88so12238743pfe.12
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5aLdQeGMKNtyn0mHL3PtXqB45EME3G/bdgYewW6AEn4=;
        b=HbvSDPLaM8QCT7CTQQFh6TP0Ht5m2FeFxytrM1tW59EBy8Ns3FGjcOAQwjT13acOm2
         ddT4qnRR1ukfuFp7A2RLc82MyBAIA7Q4RTmdDOwX5hALfIibJlJBFnUh9yDSBzsvvv6+
         aFaxzWRBsJndF/MNj4B2/lP0FyBbVrdQTFilrbjr4kU4YzkfRvUKXUoZQeMvDKTHEjkI
         ZtOr93zR6N/UEsNrB6oOCqX5mLHHPjEJCT0a8cXdUNA9wbKvb2AgIVpOd4hLCWJJ06s1
         Vma1T8Z2jjqxRUw7eLsaikxOwmpU4tzuu3X2vmO7OjGkJobFUU5qvTO0iqW9IBjv7hdN
         TDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5aLdQeGMKNtyn0mHL3PtXqB45EME3G/bdgYewW6AEn4=;
        b=dj5YXf9kd/ajlDyjGkQfNltsuaH1j/do4icETRHXUgzxQbPcNRMvZwhZVOCc+tDzIk
         6vOVhj108x0awwe/o+yG03QhaINqxLCe0gmz4jp7FzjTwtt11urJVc5fr9KsGHnT00xi
         3EAYIwZbdc5+nXXX4gm7vDJd4OBGKpNebbpnFPT3Fu5Gna/SIFVdTFEmTbzBDjkpGoxe
         amhQkvMIDD5GwiNrBsCIqv11TzSf5YoSP29YXHReyrOHHyq2Z4K+DuqBrCbaERxgUtYq
         5h7z92g0qL2A+KdWvp1/BCjUF4SAGUtMt9lLbemL9kYzHXhcVhmZswixs+7E9xb3WakD
         oJFw==
X-Gm-Message-State: AKwxytfzeQc+HdTDj931ASekGlCCApZiZ3IRLf48czqLPNXvh9xnbDZ1
        mBWsHVA/HT+8QHcj036RJG2qdg==
X-Google-Smtp-Source: AH8x227fGEshMrPCX9Uc1CY/qVwjKj1Rj7LKGP4yO6l1RaTEq3CXNvkn9MVHoCBZrFTimt2HRjtZ3g==
X-Received: by 2002:a17:902:6c44:: with SMTP id h4-v6mr28657824pln.373.1517396910359;
        Wed, 31 Jan 2018 03:08:30 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id u26sm44035854pfk.126.2018.01.31.03.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:08:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:08:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 34/41] completion: use __gitcomp_builtin in _git_replace
Date:   Wed, 31 Jan 2018 18:05:40 +0700
Message-Id: <20180131110547.20577-35-pclouds@gmail.com>
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

The new completable option is --raw.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/replace.c                      | 3 ++-
 contrib/completion/git-completion.bash | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 10078ae371..0c1d8e1b08 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -439,7 +439,8 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('d', "delete", &cmdmode, N_("delete replace refs"), MODE_DELETE),
 		OPT_CMDMODE('e', "edit", &cmdmode, N_("edit existing object"), MODE_EDIT),
 		OPT_CMDMODE('g', "graft", &cmdmode, N_("change a commit's parents"), MODE_GRAFT),
-		OPT_BOOL('f', "force", &force, N_("replace the ref if it exists")),
+		OPT_BOOL_F('f', "force", &force, N_("replace the ref if it exists"),
+			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "raw", &raw, N_("do not pretty-print contents for --edit")),
 		OPT_STRING(0, "format", &format, N_("format"), N_("use this format")),
 		OPT_END()
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7431ffc750..2f3f11451d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2647,7 +2647,7 @@ _git_replace ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--edit --graft --format= --list --delete"
+		__gitcomp_builtin replace
 		return
 		;;
 	esac
-- 
2.16.1.205.g271f633410

