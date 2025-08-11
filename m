Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4BA1DE3CA
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950634; cv=none; b=U1y8N4W/zQDl1pzs+f5u4hZrOuJfcdQwZDJp9GgErUdfb+63a7e5HoV9inLAjeshutC6Zrs+PD9IyVEq1bGyr8wh7mjgalbbevPjNz9LT1zSu4e+3z5Olq97GUnt0KLBbp2JASvpKgAJb9fy0UIdViCrfgeQ0beO0I9WxGGnrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950634; c=relaxed/simple;
	bh=BZKJxln2bI0DvgJJwmnZ5j9BIdY7Qjc/Y2uMJx5oepw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEiARuKy76GikFLX5iIPLMRw5yWpXSm5zhpVWl+1Eki9cSoBRLnh7FxrHxi4U15amQeVZtJtf5hxkEGwFsYV0f3oAGkBwesAxLIT3OZ3TzUezo9FvMeSp1gAn8hgIWF/TulWBzI5Ej0TxITGd2xnHeG2VxS4Eb+x1BlGqUIv6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMONfn9U; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMONfn9U"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8fd07da660so3882028276.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754950631; x=1755555431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9+tjh3AIhC+lmPf35BckYk/sJMG1FLqsyuazudltuk=;
        b=GMONfn9Uk6a2THlQTEC2uPkT6AXOfZN+HDU5HZqvbCDgof77I1wc5fbZNPJcwY21aS
         pE3JrnqpVmJ8FgyZyLWK1m7DAjAzf97D4DNLX4GZG+/TNSiCEx8loVb4GZihZ41Smnxh
         qEXeQ8HlYzyF7QrjNJnsNS+HTKiBbHUgySkjziLzUSkHhHzQ0gr7XnYXH/JsiEwhH5Jq
         HgJ91Numy+b8avg4tmRZmpRWnxI6pRp1q6TSK75g8fv4hRzXmdNMnMobHd7FO1ah7Cqm
         z3JPzIaVRF4OSQozt9jMm+vEw+Swqk/1qbwIMNdgsbq82Lv2T0DA/5P4N9vZ7tl7A9wS
         aiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950631; x=1755555431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9+tjh3AIhC+lmPf35BckYk/sJMG1FLqsyuazudltuk=;
        b=wq2Y5DoRATkFr3DGCeFNKBjut3wVfj6bKg2Nx/UYGOmLNgBQjE9f5uMPe0YVYQETNX
         8T9sVTt8T/7N1Aladyr4QNFf8Rp/i999sIE6SjQZ06Hinn9AaAPDBDTeX0czoXq51zdk
         3YXgmmw5vuFjEJRexL2ekC1IcmJZY2iISaMBIZPqdH728iPWpnBGarU0g47o0RmS+gBG
         RFoHv5LjSbHduvmCPUVySDz6dMH+XyfMCq34H7mViYeMhKUNfrZr+0qIGMgzE7cROJlw
         oFIgYWPtEqygOogduGAd+UtlxmRedgurrZrwb0xrSUiRjapR2AbIUtlfwuojt855Yoz5
         +QCQ==
X-Gm-Message-State: AOJu0Yx3ZGuyTBr+zuyduQgBGX7yaC8dn8zgg4sqw5zDHzO0HR3nAV3n
	d62ejbrx+F1dC9NaCJWrl7IYS94ouQgtil4MEcI1ppTYjHKBHUPILExJS1ax1gjl
X-Gm-Gg: ASbGncs9HlvEnA/r3Q98v/iskX89r8Lg1RRyBRdPWDcubrPzI1wGv4JviLweRai6sWb
	0qJbC8W7xCY74Sgv5Add1+ehUoGageYGwnZXnB3I+25pSb2W2e+Q2cAUzyHqThgxeXh6aV0cYgm
	MdEwrnV0JIWdl1GswV38EFubyFdP1HyluoKx49h2VsbDuxO+WElJvv3CSAJsA6zE3PTrYHx65II
	YIuqnhG/DnTTOmIEN2mFhwCmsBmpMaUT1gRV49fQOSeo+BR/7epXXNoyCuOmTL+0d0FjQ2WWdbg
	sU/a/gMdJ8Ii50gAixDy1bsghI8dkpHAS15+mONM6swXFegTua8OdjxV6D2AO1BGGUDwbWNpvXI
	pgPEOrhLkGowtDv45ctGCWPA5mmFvyCuY7MDqF/G1SFAP2XExJsKgnm4Che0fNofcPoTPENw=
X-Google-Smtp-Source: AGHT+IHEPCiACUIMiXKtaohvs8XVeiO45n7PQp2xpqsGAwwOo00gpOnPRvDUsx3BikpfrqqMXxPZiA==
X-Received: by 2002:a05:6902:3110:b0:e90:5a65:24c7 with SMTP id 3f1490d57ef6-e905a65278cmr11902558276.24.1754950631037;
        Mon, 11 Aug 2025 15:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:7d40:489a:fc5:8804])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e917b3ec714sm176217276.11.2025.08.11.15.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:17:10 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/4] t7005: use modern test style
Date: Mon, 11 Aug 2025 18:16:52 -0400
Message-ID: <20250811221706.67168-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810160323.49372-1-ben.knoble+github@gmail.com>
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests in t7005 mask Git error codes and do not use our nice test
helpers. Improve that, move some code into the setup test, and drop a
few old-style blank lines while at it.

Best-viewed-with: --ignore-all-space
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 70 ++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 5fcf281dfb..791e2a0e74 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -7,62 +7,45 @@
 unset EDITOR VISUAL GIT_EDITOR
 
 test_expect_success 'determine default editor' '
-
 	vi=$(TERM=vt100 git var GIT_EDITOR) &&
 	test -n "$vi"
-
 '
 
-if ! expr "$vi" : '[a-z]*$' >/dev/null
-then
-	vi=
-fi
-
-for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
-do
-	cat >e-$i.sh <<-EOF
-	#!$SHELL_PATH
-	echo "Edited by $i" >"\$1"
-	EOF
-	chmod +x e-$i.sh
-done
-
-if ! test -z "$vi"
-then
-	mv e-$vi.sh $vi
-fi
-
 test_expect_success setup '
+	if ! expr "$vi" : "[a-z]*$" >/dev/null
+	then
+		vi=
+	fi &&
+
+	for i in GIT_EDITOR core_editor EDITOR VISUAL $vi
+	do
+		write_script e-$i.sh <<-EOF || return 1
+			echo "Edited by $i" >"\$1"
+		EOF
+	done &&
+
+	if ! test -z "$vi"
+	then
+		mv e-$vi.sh $vi
+	fi &&
 
 	msg="Hand-edited" &&
 	test_commit "$msg" &&
-	echo "$msg" >expect &&
-	git show -s --format=%s > actual &&
-	test_cmp expect actual
-
+	test_commit_message HEAD -m "$msg"
 '
 
 TERM=dumb
 export TERM
 test_expect_success 'dumb should error out when falling back on vi' '
-
-	if git commit --amend
-	then
-		echo "Oops?"
-		false
-	else
-		: happy
-	fi
+	test_must_fail git commit --amend
 '
 
 test_expect_success 'dumb should prefer EDITOR to VISUAL' '
-
 	EDITOR=./e-EDITOR.sh &&
 	VISUAL=./e-VISUAL.sh &&
 	export EDITOR VISUAL &&
 	git commit --amend &&
-	test "$(git show -s --format=%s)" = "Edited by EDITOR"
-
+	test_commit_message HEAD -m "Edited by EDITOR"
 '
 
 TERM=vt100
@@ -83,9 +66,7 @@
 	esac
 	test_expect_success "Using $i" '
 		git --exec-path=. commit --amend &&
-		git show -s --pretty=oneline |
-		sed -e "s/^[0-9a-f]* //" >actual &&
-		test_cmp expect actual
+		test_commit_message HEAD expect
 	'
 done
 
@@ -105,9 +86,7 @@
 	esac
 	test_expect_success "Using $i (override)" '
 		git --exec-path=. commit --amend &&
-		git show -s --pretty=oneline |
-		sed -e "s/^[0-9a-f]* //" >actual &&
-		test_cmp expect actual
+		test_commit_message HEAD expect
 	'
 done
 
@@ -115,17 +94,14 @@
 	echo "echo space >\"\$1\"" >"e space.sh" &&
 	chmod a+x "e space.sh" &&
 	GIT_EDITOR="./e\ space.sh" git commit --amend &&
-	test space = "$(git show -s --pretty=format:%s)"
-
+	test_commit_message HEAD -m space
 '
 
 unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
-
 	git config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
-	test space = "$(git show -s --pretty=format:%s)"
-
+	test_commit_message HEAD -m space
 '
 
 test_done
-- 
2.48.1

