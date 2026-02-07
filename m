Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78163559D1
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770501586; cv=none; b=VnSPeAw8r49sElo/6EQ6RHsjERkQUwK8xqaRAKXbxO9T99LXfVJe31UnTlgfWjjP5kL3olKSO3hGFeiH+R0Hq3lv39KfBJkvlAzbp6zfWr0t9sAyihPpJ2tiP9gnKvjWru5HfPIGifCGCqBSzCQg93sDqrYNH02K0SguLqN+TDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770501586; c=relaxed/simple;
	bh=mk8k73KKPBcEaIsxhb6MfjhOnMyOczOTKSXY5fBUWt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WPfEkei+LgSt5LAQU/ARACOxD2YLEzH5KQn4SPRp/qGJ0rlPDdkC6Db67EO+LwQROjMV9K7tl3c5UqwdE3O+NoH2jGk5F25F76wB5aHLy7J3Pze1DSh4iYBxBf9qW5igp87i+PK+FdkzrtBkMHPuPNLnxEPrfm6UFik6QVou570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks3vBXQn; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks3vBXQn"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-794fe698e36so36741307b3.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770501584; x=1771106384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=oxtiHWS2dyuHANwCIvRxRYdheCLObvLEbQmrvawLBQ8=;
        b=Ks3vBXQncfARREJGxt6ALVvQHU2sX4VueGGrh+eFQe/FOktFxB5UayJSKh09wEDwA0
         KwxKX3TIGt0AbrCL5vBRGhR+IEgfN1xXqHjHafy48Rrr9z3ug3wJ8ztVgfK55UHu7g+2
         q6jZgKWViR1EnHjRRMlGnj3KSXEVOIL0oJlBSYOFRj+O+w9VqsC3jjNrNKGS4T6fPtcp
         I+NlzY83JEaQ12qMvU9+3eGZ+ueagtObhYOdqzEEbfuXblfF7CT4bio5IgeRLb908BBx
         FIg0+rqjM4t0oFjwu4sM+SOsipqvi08CNTe+BMp+EhJcxsPXkbNoQo6Eq0hf595Mq5oo
         4X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770501584; x=1771106384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxtiHWS2dyuHANwCIvRxRYdheCLObvLEbQmrvawLBQ8=;
        b=blIaD12QDy4FTXQf7C5a0wy7YqQ7JkvIk11upkGrsDKpOTVKSCf3JxhIaPYpEmFgSi
         AGmHzuUKHVZ+O6v29LONgYTQ0qYRUURZdBw8VaL7ykYrZ19cnpGydTYqrcgjP0RaDGsh
         fL8iiRirUOnoa+OcZJxhYg1U+IeiZV/DiZ2FtjJfR6RrzwW610YKm/6j+JSsYpCgKQ0I
         ai7zTPydxsckbBd3Ol2m/Wh5La4LOdGu5WDIKJvY87U1mpOk4BNEJheJht177GDhvwqk
         PGIKiW/30HQ1yARKeV9KHzX0jF7Zt7lmBLrNZ23tKufOZk8cQIaN/u6dYxSx2c74CiQp
         uiRg==
X-Gm-Message-State: AOJu0Yxp+65Oqz8+DzgT6QtWK2wr9Z53m7rWKwxxI/zC1ftaBHDwN6PQ
	HEcBbm4YECqcPQU6j30iPdCYhEhIZqpbJy1WVVuCt2pbCY1O0DsLotOBlL4gYA==
X-Gm-Gg: AZuq6aKq6uiV2uINt4TZOV0l3IBFIunotZ9o86Wb7RkW+FkOON722Tf9E/DoAr/Eoy0
	Fx+sCd6jb1pQnmiT/P870Zq6Xi/ndzw3djR234ssa3agV8yea6Hz4cG4UYIfMvGn4K0ERAMLLMr
	zPvy0nWok6OL6q+Yqx8BYLiklT7sjUQHjObalmerMcbNIJ31+QEoI5uK/koVy7ZjlVhzYqsLnNL
	XMvQmsWHW9IFvk85wBvi4Sz+2IfPxUSvVsG67jNhk2CYYaliJvI4+CP4evX9d02L9hSXRJCpo+q
	IifGKOMBu3hISf9aVQSsSx/U+Oc327seDqAmdOM5EK23+zaczW+TdammC365lHWPBV5mwHAjP0Q
	nFNDsqoFMN5ZDVud/1FrM4xCFzVTRyG/fWHI98MlPy1hnigi4yt2YC1LnMRQrrAXvh/nOXxHDDx
	iL4YfeICMCwQ1uNNHKeBopolYnstIHvDSAejicn0KERu1v/OqW05YrPkLbRyu0bCA5eURRMRKgi
	7zT
X-Received: by 2002:a05:690c:9a0c:b0:796:2dfb:4b0f with SMTP id 00721157ae682-7962dfb57eamr35882347b3.2.1770501584555;
        Sat, 07 Feb 2026 13:59:44 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90eb:5600::9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649f255ea25sm6005262d50.17.2026.02.07.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 13:59:44 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] completion: add stash import, export
Date: Sat,  7 Feb 2026 16:59:16 -0500
Message-ID: <20260207215924.28863-1-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.971.g305ecc6b61.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These newer commands lack completion; implement basic support for
options and arguments.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    - t/t9902-completion.sh passes
    - advice on completing the --to-ref argument welcome, but I also think
      it's acceptable to not offer any completion there
    
    I happened to build this off of next, but it applies cleanly to master
    (which is probably the most appropriate base).

 contrib/completion/git-completion.bash | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 538dff1ee5..a8e7c6ddbf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3465,7 +3465,7 @@ _git_sparse_checkout ()
 
 _git_stash ()
 {
-	local subcommands='push list show apply clear drop pop create branch'
+	local subcommands='push list show apply clear drop pop create branch import export'
 	local subcommand="$(__git_find_on_cmdline "$subcommands save")"
 
 	if [ -z "$subcommand" ]; then
@@ -3491,6 +3491,9 @@ _git_stash ()
 	show,--*)
 		__gitcomp_builtin stash_show "$__git_diff_common_options"
 		;;
+	export,--*)
+		__gitcomp_builtin stash_export "--print --to-ref"
+		;;
 	*,--*)
 		__gitcomp_builtin "stash_$subcommand"
 		;;
@@ -3502,7 +3505,10 @@ _git_stash ()
 					| sed -n -e 's/:.*//p')"
 		fi
 		;;
-	show,*|apply,*|drop,*|pop,*)
+	import,*)
+		__git_complete_refs
+		;;
+	show,*|apply,*|drop,*|pop,*|export,*)
 		__gitcomp_nl "$(__git stash list \
 				| sed -n -e 's/:.*//p')"
 		;;

base-commit: 2a3d6836805534f45cf545da7be25ce1c759c514
-- 
2.52.0.rc0.971.g305ecc6b61.dirty

