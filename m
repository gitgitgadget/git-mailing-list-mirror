Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B7301498
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335064; cv=none; b=ejrIlJFPO/TOJ4XXUyxjreL5mnbDxKpaPqBh6qExxreqIEelJeVK0F1AElv+qZ9GVf10OHIU1/RDPt1Uprv5BdtZyxAXqkXUtf5itcXnFn8PLwoHsksYnmcg8K+jyvqHoPYUSN4vgU/52stBYeaeQIiuNxWvLXeaV7SYokv+R8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335064; c=relaxed/simple;
	bh=UaeYlNhF9s7jIdpWjGBoLmRaEc1SMUQPYhD8CUra1qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=If4xXkR1+8YlVvq2INnjlFYvEU10Yc2k8gO1eEQBEQp4lyQ98wxMDU5aWcWPEk5iqW7fN8UeeesYPsXsWfKFTX8QRA7fxR4nYJBXAVp9boZM35Tr4mh9dqK6KswHrE5zFqGA/zvq9BNZK5ZTcw85BVYFvBjyAcUJdCp/UcWYZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY5C2saF; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY5C2saF"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61cb4374d2fso6643065a12.2
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 05:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335061; x=1757939861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jh86decOUx0RmllvH8HlwqYZEqhZ5uHgZPpd4x8luEk=;
        b=WY5C2saFfeiHwqXD3VSl7q7aZVYvUNzTVWTlF1SfUMdgh1WuvHk4X+umP2dE9Cv7kf
         E/2k3EO7zplhjE0wj8ERcITa8RVU+A9ag6l/WCyn5fdTt9ivHkH8dN9QRq4wzCaFDaVR
         tn3PIz5qWwT4kX36tlMnM2MNtj1yVGJ33UovcaZiwwUVwnwYPQeLiU3NyzXGjPYOu3bS
         MMpu0RFB1NOKF3lUCGp0pG4ihw4HEnEMeobp5jFpHn9KQiIeuaWVBNQCHu6s79uf73PH
         EWa/d6RunBWjPOa18QQ3vu9D8Bcx5bgmajD/AWwTcWQaNwYmrX8XNz/FYk6Ybno0WLX7
         2dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335061; x=1757939861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh86decOUx0RmllvH8HlwqYZEqhZ5uHgZPpd4x8luEk=;
        b=flmoJvgYnKLuOZZCGzN6uX4GbOpu9b5s53CTc1Mn787MyFBnAnmyc4ax3kvk9iz/+/
         ChCgQZvo0LIEA/gM7yXf/UCRl3AJf9xfodotiMcWj9fmEDfXod7bOBqgt5xd0z0qu+Zg
         mVMthZu9zHCzJUvYoiYLld+Wly40ex95pe7Ad/6/2kzDbdylozbXDB5PmJejaJR9xoWu
         q5tsbHCnD0YTCmL+Q2n4KS80GsNJewfnAJZQpWpYR4ENl986jMdpK+WRhQwzkNdxPvr0
         ow1FTxF5zzePRz826Vcds3npaFHvaEjzoHVI+YqjwcpLi7p3Ou/iSJG03Lh4/iwhWCkL
         MwKA==
X-Gm-Message-State: AOJu0Yw1GN0yDxjVgV9g14MvgXBASgWdZ0SWo5YYfo4KOZJfYgZkgL5z
	XJykw6vN0nuT02vZFzGdSPtspOMszX9Zd7fQ+MCvVOMmTIzSssSmSGv6
X-Gm-Gg: ASbGnctvSkMQu//uaJ+hHr1zhCpiVn5dW6jc0Jm+NT4iNT1zdd1iFpPB7Jeqo11TTHq
	A//v6JP/3amRwsmx7vwg4NhdI42btTlsuY1w0V2PtwiF7zztGgm5b/7y63u1roPc3CZbJYemmob
	gdJS37ereCXaaypBnTQ/ojGIkGlm6WckyQYtBZwHG8IBaKV/PhtrJv60kOg55x2+HEabJ+JWMZ9
	V968e4X8lZE6WyBeat2szyJusxlVg1agqhh52xmwqEBlkh8kFralUvz66oXN7y8Bmwa05Ji9xDj
	/0QujUodj92O8OYFU0BGtvyU8l47OGpA4eL/ehWs+L2LE7amPV85GBpcn/KKX0d7UdrMxm1W2Oq
	VjHJtfM/bEhhprP37zJR69l81PK+n8swGGUbFVPtD5o2/WKUqpg==
X-Google-Smtp-Source: AGHT+IFJ3jK3tHrsQdC9CWROeeI1TcMw8SUZlFS/cPhdmL85CF0ueosD9+inPl6OtMoKvtholKW6GQ==
X-Received: by 2002:a05:6402:34d4:b0:627:c739:ee36 with SMTP id 4fb4d7f45d1cf-627c73a26d7mr4259259a12.14.1757335060613;
        Mon, 08 Sep 2025 05:37:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:c9f4:d82a:f11d:d7f9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm23257445a12.2.2025.09.08.05.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:37:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 08 Sep 2025 14:37:36 +0200
Subject: [PATCH v2 2/4] refs/files: use correct error type when lock exists
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-2-b2eb2459befb@gmail.com>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
In-Reply-To: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2514; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=UaeYlNhF9s7jIdpWjGBoLmRaEc1SMUQPYhD8CUra1qk=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi+zhE/jBnFpFddbfJyyA8AWsCenJih4CvWw
 lkQKCWrE0ABnYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJovs4RAAoJED7VnySO
 Rox/CFQL+wdP2+h5OYB+EAe/WGoDvEdCR8xpeY1cS7G88GxCKJWZnIWqKtQn7MafqecXYHI+JKX
 EfkWPwrR3ehmwp3WhRWGGsIzTizSkbG79xEVYz2vljUTUuUG/hFdtmCLLOy6cYH2HsPmC+51rYz
 qfOMOsxXGg/RSHEkGrWwYNN4Nk+X/vzLfwd4vpccQkiGLQ7NfnoEX+X4STuxxIVpSpmXuib29KL
 Op3IEsqWLPLiblMk+sep6oV/dbruPYXLluuoXSy6oOaUk6HXAX9KXm4EDkxXUUkmXH106yS/D1R
 mH9rWlIw+1HqWl78Skv1bWYt3+xs6bT0AGHCTZmGBNSVgoO1/2RGYEtjRztmc7J7cidDKALEiBn
 tG4GCcBahly6APQEN2XpzHeDIPxmnZnRM9QSV/GMxNWt7CUqlMPlvq4Lf9URbFX1Dv7LzJiyJbI
 iJqW2gecT3kp8rhE3oEMrYql59QvLkQiG7uxGW8PqFE9Dphcjt+tns7FZG+HyPlWcnTJ4OPDlU6
 s8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When fetching references into a repository, if a lock for a particular
reference exists, then `lock_raw_ref()` throws the generic error
'REF_TRANSACTION_ERROR_GENERIC'. This causes the entire set of batched
updates to fail.

Instead, return a 'REF_TRANSACTION_ERROR_CREATE_EXISTS' error. This
allows batched updates to reject the individual update which conflicts
with the existing file, while updating the rest of the references.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 10 +++++++---
 t/t5510-fetch.sh     | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 58005d2732..2730713d23 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -790,9 +790,13 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 			goto retry;
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
-			if (myerr == EEXIST && ignore_case &&
-			    duplicate_reference_case_cmp(transaction, update))
-				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
+			if (myerr == EEXIST) {
+				if (ignore_case && duplicate_reference_case_cmp(transaction, update))
+					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
+				else
+					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
+			}
+
 			goto error_return;
 		}
 	}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 57f60da81b..6f8db0ace4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1546,6 +1546,32 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
 	)
 '
 
+test_expect_success REFFILES 'existing reference lock in repo' '
+	test_when_finished rm -rf base repo &&
+	(
+		git init --ref-format=reftable base &&
+		cd base &&
+		echo >file update &&
+		git add . &&
+		git commit -m "updated" &&
+		git branch -M main &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @ &&
+		cd .. &&
+
+		git init --ref-format=files --bare repo &&
+		cd repo &&
+		git remote add origin ../base &&
+		touch refs/heads/foo.lock &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

