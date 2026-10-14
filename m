Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881622FE05C
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962813; cv=none; b=Q69QAWNakawjmB5hl42EDWad3+RLDWADIvNsXUNMy1WU8YWBmXnZ5aKEfi2tWbLwl5SwwPIO7rnWF2+djxWCXnobUizcmZ6SxRgOHcQHG+WPLS7V+4G5b1LuUB/mrJ5Praj8jmOo6kdSSdlah5IN2JUeSA6YsEsoIJhuqduOtiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962813; c=relaxed/simple;
	bh=WxrhuwS8C4xz4oEM/Tbd0s2ghNTr8BcpMqNK7/AIj2w=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=eu9hV8vgiQDG42OvpX3G7R2VjR3wbf+bwvroA3xiPCvdeQ/Kn8DtsQ5H57rmvLiWhEwZK92lFRSsCc1ZQ0hZ1JVQGtuvJ8CUby6y9AVKrx2K6bzXgrdrqxVhGXQUDuT7CgzZk/9dAY8SPqzBZCKZwsb58s4tL94g4nJs2YB/hGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7s2nLiO; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7s2nLiO"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-49e1d10ccbdso871853fac.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962811; x=1792567611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BGWC5XEdRAvfnDgE87fR1GozKYOeZYncAM8/S7sx03g=;
        b=R7s2nLiO/x666oYqn/eFzMKkak90AMnkaXbTdTeaSdm7kCM7SIcQmj9Af+EryfGR7z
         MM/7wwuWEpwmYmcJv0ngNwV1P5ukqPfXp9M5ZPFkP9/kMr8g9yTZNrrE+oXjrUqU/uAU
         1/bMuAYklIVlsaL0HkuAKt0bFZ0Gqmteglumaox5ukZ7vz0f50Fu2ZakSEhOlCrOp7uy
         oJy7Cmb6N6+zhq9iqghNdskXkfLFQEU8EOHBu+3f2KP4O3aEQ19Ojjf6akNavlWy3vD4
         uN8jEo0RlRk0TGlEXc6UcNPAXmLEgutJTR2BBhUt8upGsSmo0IBXzPRsc0HBd6FWjJyB
         V64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962811; x=1792567611;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BGWC5XEdRAvfnDgE87fR1GozKYOeZYncAM8/S7sx03g=;
        b=KKvEhee0vxM6b/a3iy+sWiqInpkWu55kZuB057jBIC8W6GDt2A+Y2HDRjyax8i8l7L
         IYqqDaiRv30PkU3PH5FQ8tRb13Mqdq+wNPzlb0r0FStnsTQgc/QIjPBJkiIY7oKcSgvj
         +GcIzHvE2nO9KcPk+JsDJQwyUd2s81grCvRZ3d9yDCf9pSHPtmJxf0fqOx6EWsR+XWtb
         USpUvQfLkfRWFIyRD6l2WrsSrrVSX0tEBO8fOQBqtuRXZIMRvXifm5G3nKs1uZ7+uC65
         lla7D7Scm4kqgPX09Sv4nrzR4ZMQVNHScEEp+u1pTAyOdFLwK+au0+ePLjJi0X7xo+k/
         l3Jw==
X-Gm-Message-State: AFq9FYJg8Wwq0WZv+QPQIqZciDr6C1v3a/rKXYIGQ6+D231issIaGwRp
	b4is79iu1c5953ZQv5oNhnpRuOwzxGmjdKZAAdF+u1R7llc3hx9AXP6WESvL+V0b
X-Gm-Gg: AYBFou1MGQ26w09/1EhWgFI0uG6V/yG7LXVq7eIV5S9O5JOxMcWQTsA35v1v9Y9L80Q
	Oh5O51DITa+/gS/QYxmMFEV8QveegmFg5KDFSPtlsCK+zZSqBeqr0/TOlqYGcROwX+oQ0JOR2RK
	BXZaiPBfLNTXSaOWG5iIwNEcS2s/q+Sgz5CFd6tnnIW2ggnNCNfLjGnBZGxpXqE3//dAYkswdQ+
	akbfIP71VO+n8xQj7PmkiUbmPnowHKg+W2vKtkfFrZtUtV9revekRW0UQ1hvY1zU55beoBfwkfO
	HASIKvNTihAEJ7w52Hq9PZC7+2fXslOYMSXpoP65zF/TJB1tIkdYepAIGa51QliqsXJj3eNoVcp
	/35y3BF4d6LKSCVUm7JNLf0dAjDBQNSCySxFe8ib0qyCzZuD8yLlxy69+zsOAAnVF/mcExRkEec
	O/uvGj29JtTV59d5rA+4oQaQe0Pbf1aDnC0yst7LGZ+KWravXwMjypbomSADQAR6iZG0I3SIeYL
	n65H/Vrx5Nx
X-Received: by 2002:a05:6871:721:b0:475:e0a7:9f2f with SMTP id 586e51a60fabf-4a2a89387c4mr12356337fac.29.1791962810004;
        Wed, 14 Oct 2026 00:26:50 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.133.165])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfcc3671sm1525556fac.17.2026.10.14.00.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:26:48 -0700 (PDT)
Message-Id: <pull.2254.git.1791962806807.gitgitgadget@gmail.com>
From: "Shashank S via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:26:46 +0000
Subject: [PATCH] t0081: modernize the code testing whether a file exists
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
    Christian Couder <christian.couder@gmail.com>,
    Siddharth Asthana <siddharthasthana31@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Shashank S <shashu8660@gmail.com>,
    Shashank <shashu8660@gmail.com>

From: Shashank <shashu8660@gmail.com>

Replace the old-style shell `test -f` command with Git's modern
`test_path_is_file`.

This instance was found using:
`git grep "test -[efd]" t/'

Signed-off-by: Shashank <shashu8660@gmail.com>
---
    [outreachy] t0081: Replace the old style 'test -f' to new
    'test_path_is_file'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2254%2Fshashu8660%2Fupdate-t0081-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2254/shashu8660/update-t0081-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2254

 t/t0081-find-pack.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index ff9d56fbf1..7d5082c487 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -32,7 +32,7 @@ test_expect_success 'repack everything into a single packfile' '
 		".git/objects/pack/pack-"*".pack") true ;;
 		*) false ;;
 	esac &&
-	test -f "$head_commit_pack" &&
+	test_path_is_file "$head_commit_pack" &&
 
 	# Everything is in the same pack
 	test "$head_commit_pack" = "$head_tree_pack" &&

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
