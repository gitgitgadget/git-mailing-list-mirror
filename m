Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4959528727F
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107484; cv=none; b=p9osUX2Q45MJwpdAwSwlH1R/grq3dnYAdU+SAETQ4jCkJGfk4WZNFoI3mG/pwxQWuI4FUeU+BJUMMsiXke7oEwZQuSt7nQS06EG6MNXv7aM/01OaYh1C3WII1A9aV+I/Y9Dl827y/IzY+GGJOKgMdHPoh6WNg+GlZDH89EpD2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107484; c=relaxed/simple;
	bh=BZKJxln2bI0DvgJJwmnZ5j9BIdY7Qjc/Y2uMJx5oepw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPKrSnBYBR7GC3tDVmfTN6TDcEefh78jWMuqBl3U562I6lCBn0oIZdT1PukhaXqxPt8xXGgZNNiTzm6nZS5bKsiVFWPnonMoo/kAeXp1rKc0MFdzLfkGt9kG5XZrnOl4e1kK4QzEgDVb/HkL8T0ev5sc+sNSl0vmdIEvsiaYXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUfDftYO; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUfDftYO"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603cebd9so1688807b3.1
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755107481; x=1755712281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9+tjh3AIhC+lmPf35BckYk/sJMG1FLqsyuazudltuk=;
        b=SUfDftYOhYO5kiv/9A/1th+y2F40U/q5y3Y0FX9wXIIDrAmL8hqsfAdTkQiJZAglIr
         rFPoXJATBvR2l56FVRjP/nVO80K1Uf3mp+HQBQTJE1NABW/6CZSyPLWtCB9YAeWJELDl
         Zo8sBpUGv1dID/xvOymEfVBniDLOmUxJO9iQ1iEUavisBCjSWrbwp7inXKkRtNhdk9aL
         4K4vGG/Yc5LfyeM64xle4PcEVjzgU7CQm7wvZce98q7rDbSshWWJq1ODOfNAt6gDt5m/
         k8VfHMEAUdTXAJaorCbonvji1SYo95Snsh5hkuA9CQrGCwHaNWJRjEe17be1IU3sec0f
         i0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107481; x=1755712281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f9+tjh3AIhC+lmPf35BckYk/sJMG1FLqsyuazudltuk=;
        b=JRQa+qp6J9Q3v3J1iUXu6uR0/rCGWVk5XJzFmSLQh1PAIecc9wQGQWHtZ/UyiBR+W5
         BQFsg4J3IDqUs39Myiau6CTucqv3I2zAA4TCe7rtX32q1XcE4VKniFxDKNWYT8lYMjRO
         q4yHUT+gAG5fXqM8n3ebXEw+YMA1XtT8FxfF8bHVhQ/deLEGCtZVMef08cIn0CfY1XKz
         FmqbY9kKOSS+lXFOigKG1OIS5hFNk8BXoKhqbQiX+uAY2f24eNTV0kxUPY4GBHQSYn/A
         LkK+VtFs/x6MilOh1eUWthc04xwi9FH0dpxz88amkh11hltY/WL6CdOVWZHAFZ61euqN
         vlzw==
X-Gm-Message-State: AOJu0Yw6u1oJgKt1YVRg8lQ81kZK2DbhECIlBZQEVx0w9UBDQaI/11Yc
	qnPn10f0FhSlVsywbaervA0hIQ86lj2sLEgFGmeP77KysYVkNlHa+ELUA/Gb1IB3
X-Gm-Gg: ASbGncviwJ4J3jT3xPdm7bvIeLgIFbClF4JDZ+GFsYh/UwB1fHgc4W9sPBkc5M49ia2
	9gW6bY6I7HDQ72bQ98Y2bidaWIuudkTvrwlNZDRitct/WfQ7sD9WrVwBZ3Sr1NGRCD567HVmChb
	8Do7G5CN061I+c+LoLZaj4zlih/8JPrDnxnxZxZQJvFeIEPpyk6Xa4qbo7zlloU0uI7DcZNqE/X
	kequW1itOrHIC+UO+D4CjtPfJ3f8FCUp/1PWnZmn8gz5tSwGFMr87picUDiZmzo4XLYNhV4alXM
	XdPpIP4VJb7NhQjuxrLWI82zYCoaclVG0Odq7RULrPICL1Sezw3j+LLvNTfgDFltQYycSwGO7Ob
	M7eVyOs6MyMOVVDGZnzl7KylIKY12PLjNcyWHdGK8+EP8vCx5frNv/CsyWw39Rn/u5pbqblWw/N
	qfS6C0UYA=
X-Google-Smtp-Source: AGHT+IFbL3X8WzJAWR05CPjOhEGtUwNNYLLqbQEUf3lzXYxwTVTKKq3ArOfXwF6++yK+5aqcZHxfuA==
X-Received: by 2002:a05:690c:8d16:b0:71a:e2b:d927 with SMTP id 00721157ae682-71d4e3fd2cdmr43813257b3.3.1755107480603;
        Wed, 13 Aug 2025 10:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:1c37:18b4:a0bf:d7d3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71d60fe1936sm439957b3.38.2025.08.13.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:51:20 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 1/3] t7005: use modern test style
Date: Wed, 13 Aug 2025 13:50:03 -0400
Message-ID: <20250813175112.88435-2-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250812170256.71751-1-ben.knoble+github@gmail.com>
References: <20250812170256.71751-1-ben.knoble+github@gmail.com>
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

