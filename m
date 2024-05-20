Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78567139581
	for <git@vger.kernel.org>; Mon, 20 May 2024 20:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236536; cv=none; b=Id9l0GMNFN9/6X2X/h5Pogk//C2V9wbz86RyQZ7/EH2yy8z5nE3V8sFZgOY9do2qOrekCegvwqH3bfDNwJ0CqEBocmXxciWvXioIU20sPVAdSsc+5Njuo41B5MaxQHVhCOqvo1HOoOXFHbe0j4g8x1m2coKRH9VSt5xt1cu5GLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236536; c=relaxed/simple;
	bh=9GRY60ElemT9DHs8npnd8hLlNR8z3x1QzrFwTtQ6KpE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QGzeAeqJHrMMaNDWv2loBMNAcRHaGcEhxKLTXKTB5AwwdMwfXLvY3fW+yWYbYWt74zZQgOyjx0aeQW2UFwnD/pXzGZBpw6RpX/Sh5qg4gXbSXTpRfStxCe0LhWTxR+RjW9lXmM6dRjXdl3acocZFZN0JWURtLIg1vZBTGAT8TkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbLwqKS3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbLwqKS3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4202ca70270so33847865e9.3
        for <git@vger.kernel.org>; Mon, 20 May 2024 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716236532; x=1716841332; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Hh0zgo3PA9OZD3gGP/KbTGUs6ILXCU7En0Epx60GCc=;
        b=bbLwqKS3s1DO7PqVZcV6ILuR+F5uGfTVnLdMUJ9Lmn0UFzUPun5W9JvV0PtKqdb4Xd
         FLwKBmfhuqsNtZSEXDGQouDQZKmo+s2o5qCs61LEAOwqR9NE/h+tZ2x+bkrNIaJqCrVz
         P0dHG3uWqitCIPN574iUtz/9ABkfPz/1aWe99tBtODg55DRekZtWE9KOENktKIXO0aL1
         otmTN4MoFMV3m4VHLQB4jNLZxCa/HxQQaTaqiwKzbjifuXvKwuPTqcfqzYmJ/9L7d2iN
         P7hX4GkgH2KFPb5XNi3GonoP+g+sOA9ADhwAwm9aDBVUSVsTMDioRKPTQHasYHQhuHlO
         qmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716236532; x=1716841332;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Hh0zgo3PA9OZD3gGP/KbTGUs6ILXCU7En0Epx60GCc=;
        b=TwWOVN54Q8z0xPnfXlewqXwl52stNPv3vVflW7Eqqon6GvndZXaYGEIXtwJXDb4coF
         u0xwplxL4Er8yo93Y/dNKxjUZPaYER/on3sfQImjk53Bc029q/ViaboZ3CaU9Uc4GFeh
         vt0dyZcDCyfbqIDy2nVKYrFIdvwWuTmX2Lf3sNrYrwuEo3EXbspyW5JRBjhc8auDtfxY
         8i6OEUyUZaN/bz99rqqjM5Nlss7byJ4HMo5Rw1PZyT3fBtr7GhzOjhaAMuVtFk7CLhDz
         VQDHcMiPv2kQbGAqKB3D8SnG+QvSjXc4vD8UfsYLRi270u4CMuReOhqeDh9mVtek1VQw
         lYRA==
X-Gm-Message-State: AOJu0Yx2vaTNvmb9yW36j9RWqZDIJiGYSnNS0p9gGNGDhqz3jzvgxODv
	YFlfa4xRFNeWT8B5rLqki0cxiWNc1XVX5vtvfwwLTJeLgUz9APHxX7B5+A==
X-Google-Smtp-Source: AGHT+IFuofaJrwXZMOI09X/eB2mGNS8YIDXNn/ODv/kJeOy9GeAcwAJCSVCFdQ7wSLV8qxWV9SWwlw==
X-Received: by 2002:a05:600c:5116:b0:41b:fa34:9e48 with SMTP id 5b1f17b1804b1-41feac55e26mr293670415e9.30.1716236532414;
        Mon, 20 May 2024 13:22:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm434956365e9.2.2024.05.20.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 13:22:12 -0700 (PDT)
Message-Id: <cd14042b065e57f132c27d09005242fc500439e4.1716236526.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
References: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
	<pull.1732.v3.git.1716236526.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 May 2024 20:22:03 +0000
Subject: [PATCH v3 4/6] tests: verify that `clone -c core.hooksPath=/dev/null`
 works again
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As part of the protections added in Git v2.45.1 and friends,
repository-local `core.hooksPath` settings are no longer allowed, as a
defense-in-depth mechanism to prevent future Git vulnerabilities to
raise to critical level if those vulnerabilities inadvertently allow the
repository-local config to be written.

What the added protection did not anticipate is that such a
repository-local `core.hooksPath` can not only be used to point to
maliciously-placed scripts in the current worktree, but also to
_prevent_ hooks from being called altogether.

We just reverted the `core.hooksPath` protections, based on the Git
maintainer's recommendation in
https://lore.kernel.org/git/xmqq4jaxvm8z.fsf@gitster.g/ to address this
concern as well as related ones. Let's make sure that we won't regress
while trying to protect the clone operation further.

Reported-by: Brooke Kuhlmann <brooke@alchemists.io>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1350-config-hooks-path.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f6dc83e2aab..45a04929170 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -41,4 +41,11 @@ test_expect_success 'git rev-parse --git-path hooks' '
 	test .git/custom-hooks/abc = "$(cat actual)"
 '
 
+test_expect_success 'core.hooksPath=/dev/null' '
+	git clone -c core.hooksPath=/dev/null . no-templates &&
+	value="$(git -C no-templates config --local core.hooksPath)" &&
+	# The Bash used by Git for Windows rewrites `/dev/null` to `nul`
+	{ test /dev/null = "$value" || test nul = "$value"; }
+'
+
 test_done
-- 
gitgitgadget

