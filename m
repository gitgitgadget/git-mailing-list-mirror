Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE11263F22
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018182; cv=none; b=s1XWY3AVe9b3yitPwYvn8hytBMbzu8WoV14g63C/+QS/xst/cNvStsveDnOzbXAIlcYl2A1sgCvTf4AIzO+AtjBw1JvEGsH88IS1bFJyHMxO9TEPyZh+rObkUQqur2WAL1VodsCtrIJ8J6ezr4uD7WrpnK9qVmX4HsTO66DDZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018182; c=relaxed/simple;
	bh=BZKJxln2bI0DvgJJwmnZ5j9BIdY7Qjc/Y2uMJx5oepw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIzQ+YjmoJ0nmETlHxkbMxJAdO25dQH8i4NpjKBPvvEqX0iUIowcwFclzIEpaPTQIX6jPBUcocmebukCqvcmV4XggOyoCEgcptxh0WTayWEvFeKNGpF/EoRgz7WoCMmhGwtOypyhDK5BulofKBNKRYmJaBq8+sCtTy3rFTHQGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDBZ9sDY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDBZ9sDY"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71c44558215so10346067b3.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018180; x=1755622980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9+tjh3AIhC+lmPf35BckYk/sJMG1FLqsyuazudltuk=;
        b=aDBZ9sDYCevswW/9aoLQRlPAL7Y1vzsATz+re2tE+MBjyIMosQomSUghq3yfT87B/o
         FE9c+JctbZplCyBY2LVlCdPrjSpIrJUk8CkqEkfXDRb3cxxeHI+GQCel5lOGJlwjwpVb
         m3oSypU+PHbDMZ1frIzbpAUJNsC8q6iU/YmzAmqweW8uFtKNbnUINNZCKqArI4l60VYG
         xOzL2wwf0yIYQELsE8gvYoy48GQB1rx9B0H0rsFN0j1aTpplQ6lBEImu82fmLy4pGL2/
         RqrcRPRtWABWIT4TOJHnerd9/tI0h8SY/8oq6f1FewdUA/Z6JbpxI+77MzICVOTjG1TB
         me0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018180; x=1755622980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9+tjh3AIhC+lmPf35BckYk/sJMG1FLqsyuazudltuk=;
        b=HFhlc2IlWr4KsOQp/sFPNu0BsluZrF2b3bElL+v0uu0XD+Gk+4KI0zs4FYXGfZVW6L
         WBgUVFOT7bH67CAMPLDjPcggxUqCcEEgmqNJ7jHS/99SBRXnqbBfpquy7xiXu9ooVdtU
         1Hx0fG6SN7JwBRaiDBUfXVnYbClCZYmhG+ltonyh1qPwrS3iq3FtYQfAJnnrEFYDWGVs
         nN3TjyYmZJwkgIwy1ifhVvT4nOc6U8g9LePZSqZku6llEYd8QtRHabm/1gU2MoRewlhs
         KpYpKFDYcFKcN+1didXDrvrZJSlFzNJ/OYhWYWqwURZH/x3gfzcZrTTr6iPz8kjmRgp8
         FW/g==
X-Gm-Message-State: AOJu0Yx1tU0ideYgrP8Ta7i/48xK9z++bTz7DZofLvjwdxLjrFNzNE1+
	tRSAJMbHDUbyHpwBmRoNlwzkEWMxQlDGsY02yMw1Gq6bcEUD8ovHNF31jDOj/Urn
X-Gm-Gg: ASbGncvldtN8nQPFnf50OKgXDIu9z2zVt8aqEat4TbJl/QDcgsFSWV8z2JSpLpb45LF
	dIXG7CrUM5ue1+JUgFO1gcBgM/YpZnMq6DbL8wlAcaD6+xwGMPH/P+TWuk2beeu0rMSqWkjUCha
	vnULEc6pKej4yNhcFZ51L/IGyCHKsgzh0mYuXXwBdDGf3+RBOyPoSuj/W6h4aTqlhpRmyfuTqBC
	j5d0nFY73zvRPQlBdnHF1gl1WmRH/cL5dA3Ltvnpr84E5xOnlxtmLfF2GN9YiICJ1HMOXLGgYnf
	NGmeSvm05/pT/daEUIdeEJGY0ijtEysASqT1Nfxvpeipe//Xiv18KZLM6zKy4/aWNTfa+SBZwN6
	S5CH1AWhDDURor7HoWPoW+Az/teT8RX6bKCYaGDOGlOkB3ahoBvYqlmZv5pIa9+VENadlwvmKkb
	E=
X-Google-Smtp-Source: AGHT+IH/pvPCYaIWThH8YPt8Ea/SPoLn1VlY5RwRVMASoHXgjbelWSlgTHvaYkSCEXAg0RnGedgrHw==
X-Received: by 2002:a05:690c:fc7:b0:710:f46d:cec3 with SMTP id 00721157ae682-71d4cc8576cmr4635857b3.5.1755018179797;
        Tue, 12 Aug 2025 10:02:59 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:b54a:f21:a9f:3c85])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f6cfdsm76960927b3.24.2025.08.12.10.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:02:59 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/3] t7005: use modern test style
Date: Tue, 12 Aug 2025 13:02:16 -0400
Message-ID: <20250812170256.71751-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811221706.67168-1-ben.knoble+github@gmail.com>
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
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

