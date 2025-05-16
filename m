Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1872749DD
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419150; cv=none; b=EWV01T5Quc29O0Xn2mK94cKNoHH2x101F1GJb96k8WZ16eYtoNTDz/hO4gxcWsFXkPGmknpVGx/QbgQd+bJ/fI8V74vsP1TQ/tT/3zhTAXPP2rQ7+vQMyygWquu8BBjcPt/N2OJYDMdn2QipuPs9QWyXFZrMAWtdGa/DUdwR7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419150; c=relaxed/simple;
	bh=ZsDITxFZu5o6RoUA3ykAFP5S8KRHw5kELE8wctEgxcE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KK0nnssJczt21Agd47eP8WvPLhFRNZ/ZQT6W++IQxxfJyx/BmEADvzCWV2yHW1ViABcxS0Q942vz2Qfzod/A2Bw30i/BwoOpIof+yqBzSzCK5D3Jqy0Bb38No8g2D6WE1kKE3HiU1/AAchG/MpLuH7mh+TrjRSOKkm+g/K2traw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpTq16/9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpTq16/9"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so23947995e9.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419146; x=1748023946; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40luNWIYsyvVAlNGTmQRf99rIflEZGIDRTpFvlvGP6U=;
        b=mpTq16/9ynLl446/YQQXiTUVSB/RT2sYwoCCKWiIZsGi1lbzLYvxD0pV2tuxDUQA9+
         deKJOhYnwEkhUm8XlWumyb0e1sn4tkm2NlSRprQYZzU6zz4PGApSwhozitboeQjWFCQX
         M1iDP8Px69VBrYWs/TphszHQ0etBGBqyAHJBRxCQS0YftI7QkI4PZqH9dcitKE1XFb1F
         T6r38np/tosF8NrfIX7ffwU9xSRGPxfUMqhMfxgthF5RCce0zjP+OvwoePfaPYc8QK1Y
         up/Lk6cgpB/ukGWARXtaLq8sNPhb25qpJVwUmydI/heeoxcT3na7HHSDwh6f8B4FeSNz
         GecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419146; x=1748023946;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40luNWIYsyvVAlNGTmQRf99rIflEZGIDRTpFvlvGP6U=;
        b=T+QhxMTMf/pUgOejsBiEYA+/KiqJ9uIOUn9DN357bXkBr6+IOxIwZwi1c6LSYkw9c4
         VscqJrhFir9XI96Z+Z1jYG0hkMMdLVa8wl08mKvz+NDwrK5bB3Tc4NfLMjy5oSyfxLnd
         8gxY2tJuEKZNKAEmrgFaP+QKC3LZSiKc7DidxePwJ/ddUNZrlFJxDSLKJbSdHM8FVQ7T
         fFfaeLXs838jIUoN88/XaP/tiiPKF0JiAK+CYh40omEl396NFrFbi6GePl6dVBtd2SDP
         fFYO4xzGj8JXCCJIDjhJcwoouYD4CsuxlZfu3LK1EfZZMXGnTOSkvJsrIdGMPbjEHTe5
         mlnQ==
X-Gm-Message-State: AOJu0YyP9WQT5oJOipdp5VfNmwAs8iTdS64LAiIKv9lAUF4xzchbO9qF
	CsbRdUbEGdhCCJk/BVQaYkdGNaUyo8TGF/KI1Tj7RVqkF9BSpQ6y+9ZzobWUMA==
X-Gm-Gg: ASbGncuPsfe3wyzrh8md+wmT95/z7ITxnm1alkrMxgH/1NtA9RhBfte4Yq+Dg7yv5sT
	L3dhLwEhLjHh2SEL/icFEnMsfGqe1hGcBSAr+LfUwO2XhHAJ2SodoF8BDf9VmKs7OnfPJ5cWqZ6
	5E8NKLWs3uPs9/9j8xEKc/l2ld5K/VXzwHKSvUrDbKA41lMrI2hmbh186iEf5AJDCCUCBJktqjO
	ArZ6zEYY0R05z94XNYNGZ0pbCBdY/oxKCON/q2fBA0wOK5Q5qCX27qrE/8gbv5oNM95IZvZiWTX
	xNi6/8CJnVdF79s2NIWXX9I/qQJchsgg7S/U8BUYMDkgxLzvnNQ/TjB9NCgPxHA=
X-Google-Smtp-Source: AGHT+IFXuMNDJqsbXn9FUWttJTxVvu23VISZm6HMwmgnz6mRXJxc1MMJ0eHj13++sjFSYgXfh0JMRQ==
X-Received: by 2002:a05:6000:144e:b0:39f:7e99:5e8c with SMTP id ffacd0b85a97d-3a35c84ae15mr5594017f8f.51.1747419146317;
        Fri, 16 May 2025 11:12:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50eda6sm40799185e9.13.2025.05.16.11.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:12:25 -0700 (PDT)
Message-Id: <19c6651183a7daab4af7994f669aedc22f0a6746.1747419124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
References: <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
	<pull.1819.v3.git.1747419124.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 18:11:56 +0000
Subject: [PATCH v3 06/13] t5538: add tests to confirm deltas in shallow pushes
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

It can be notoriously difficult to detect if delta bases are being
computed properly during 'git push'. Construct an example where it will
make a kilobyte worth of difference when a delta base is not found. We
can then use the progress indicators to distinguish between bytes and
KiB depending on whether the delta base is found and used.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5538-push-shallow.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
index e91fcc173e81..c406f9d7ed5f 100755
--- a/t/t5538-push-shallow.sh
+++ b/t/t5538-push-shallow.sh
@@ -123,4 +123,37 @@ EOF
 	git cat-file blob $(echo 1|git hash-object --stdin) >/dev/null
 	)
 '
+
+test_expect_success 'push new commit from shallow clone has correct object count' '
+	git init origin &&
+	test_commit -C origin a &&
+	test_commit -C origin b &&
+
+	git clone --depth=1 "file://$(pwd)/origin" client &&
+	git -C client checkout -b topic &&
+	git -C client commit --allow-empty -m "empty" &&
+	GIT_PROGRESS_DELAY=0 git -C client push --progress origin topic 2>err &&
+	test_grep "Enumerating objects: 1, done." err
+'
+
+test_expect_success 'push new commit from shallow clone has good deltas' '
+	git init base &&
+	test_seq 1 999 >base/a &&
+	test_commit -C base initial &&
+	git -C base add a &&
+	git -C base commit -m "big a" &&
+
+	git clone --depth=1 "file://$(pwd)/base" deltas &&
+	git -C deltas checkout -b deltas &&
+	test_seq 1 1000 >deltas/a &&
+	git -C deltas commit -a -m "bigger a" &&
+	GIT_PROGRESS_DELAY=0 git -C deltas push --progress origin deltas 2>err &&
+
+	test_grep "Enumerating objects: 5, done" err &&
+
+	# If the delta base is found, then this message uses "bytes".
+	# If the delta base is not found, then this message uses "KiB".
+	test_grep "Writing objects: .* bytes" err
+'
+
 test_done
-- 
gitgitgadget

