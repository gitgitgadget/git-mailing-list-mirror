Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E83164C5
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764946968; cv=none; b=bWb/LjcVV6sQGMAETEPyX6/mbKc9hIqLyxp/R1myhaJg/nwOb8o/q3h8dUAe5IeryOgUww1nJYDfBT0Fx78kHsX2Lo+mZA0JMsfN+dUsdoMDBfPNWH3026gDiP/Q3zuXpL2wTX3OJHTC8miW31OrokrWkKw4M5LS2t7d6JUSkzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764946968; c=relaxed/simple;
	bh=miKtS8gVeLBQxEb1qhafBvJeGFIR8q5A5wiQrIWCScE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q5v/KbiLcxSXaLbWMu6Dh+sVo8n9y//wS0ErrmOX4z3mFVMUx/uIktKuceKnxZhXrvMqWVB/WROudYjAElSkPHvw7rUinPnv6YTb6Kt2sEhSW2y/s+W33L98g81AOabQzeQRPz4bBNQl76A7Pq1QeRhnMNfA+fCiLw74ya7eVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPIjHmdU; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPIjHmdU"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b144ec3aa8so192690585a.2
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764946962; x=1765551762; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=QPIjHmdUYc8lu9SkY3ICQo57AAlVArl57kPj8xmu4xx1mV6zjKnhRUD7mktbLG8xR5
         +OFFvd7IJpZhIZs4IgCnmJuBbsQFuP3oH3MwiCymiObaxZ43DcvznE91X/03pL0lO3mD
         xci2AmTeyADvpZ5NlAc7EvSAbLPZQ3dvjLCugTkZ64hwfJdK7zWO7EO+sNLObQ3sdHme
         OQnOMSIECZQdwh2hKGWChuT4i4Vz9ccuNze4Kgom0E1tE+ClQA0fm4KxvO/jk6TcD/kH
         6beP2cIIDW6lqT1Lbbsa0LZ9ADfkssIek5XXd0Oz8yYLqho8ATt5ZmAFhmPPyu5ejbiw
         jfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764946962; x=1765551762;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rDI6RHdU35FaQH8EQ/fZmzFLT4U35ZFph/RzRv+jlX4=;
        b=IjIFnNTxem8D14QDuxBk6hRndW2VFAhtr3qimGt4K6QxKz3D7V6fwFSUAteJifR0nH
         cAJjwvbqJ6yYSepQjxV0TNx4g1cjslq1/mSSrdnHk40yKfW+MQbr1SDeS/sowBmNJV22
         gHCb/s+OfVsJLAioe0ybeK3IS/OtKfS0PZFvON01fD8fOjFq2ZujQBUwdyj864k25aPy
         yk209EBCG3CrcQrMHPeo6dNlO/lA1PeCzTvTyYD2BVWa6MAtRThRe7XHVELnKkyg7+f0
         fPqsCR1WHEpFNt+x8FCh2g3ncqIYTkTp7YR3N6G7xz8wooTBQeJmBQHCBByJnWRks7Qk
         uBBg==
X-Gm-Message-State: AOJu0YxjNjjwxTC+ZafDEIy/dpdjn6rNd+injqaVnsdPfR8Ovr2G8U7q
	++mW8kgGysTxptqnRRD3VKoQRojSYNU2D3Q5VvItg3NeaT06+2MUUMcBHYBCcQ==
X-Gm-Gg: ASbGncuwvpN0wEkzHgDDzeTulRtMFVm65ILxfICgd8XhOYwO12zSggb3slbUMlTXMLN
	4J6KwU1mVr6Bk1kMZFc6541FJ9Yy6fSkMsEvvol3Lrl+uHrC4DVr9wmoUlIBbo4039FcOmv6zvo
	Z8iy+8rU1Ruo1XN6glGcBZR9TGd8XiHcQtkM4ubdG24sRFcJ8Za+OSvWL+PCQ12o8+4dnqBsI9c
	94RiaLXTxL5FkChDW1mPcmsrY4gzhl0K5EYF0ZD2DgYBx5zFy839/eHPicuRtADXOzKswDzNLKL
	TRifAP92fj9AFlu76dYfl7FMMRFgksVyDJS1spKEkzcBJhKruGVlYJ/AExnDwCaswrZlG5b4kUw
	fY4+hrAuhKxs3X2UTyAFujN+Tc1GcTfBxYlI4N4yxXm//1d4Ib6miXyZuo/eDtWu6JGHyOa6Y3q
	ID0Hqa+Ib3KRDU
X-Google-Smtp-Source: AGHT+IHgU8evVNu+FAnABjKKb1PG20TpyyVyw6+LzjxkPocrncSDT4IqwgekA4fAD6cOeHCpLjhX0Q==
X-Received: by 2002:a05:620a:460d:b0:8b2:e9d2:9c69 with SMTP id af79cd13be357-8b5e535ec5dmr1508542985a.22.1764946960917;
        Fri, 05 Dec 2025 07:02:40 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.115])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b627a9577fsm403618185a.45.2025.12.05.07.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 07:02:40 -0800 (PST)
Message-Id: <807bb679cd8665007d207b8324d1d43e8a5d0fc9.1764946945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Dec 2025 15:02:24 +0000
Subject: [PATCH v2 09/10] t6423: introduce Windows-specific handling for
 symlinking to /dev/null
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The device `/dev/null` does not exist on Windows, it's called `NUL`
there. Calling `ln -s /dev/null my-symlink` in a symlink-enabled MSYS2
Bash will therefore literally link to a file or directory called `null`
that is supposed to be in the current drive's top-level `dev` directory.
Which typically does not exist.

The test, however, really wants the created symbolic link to point to
the NUL device. Let's instead use the `mklink` utility on Windows to
perform that job, and keep using `ln -s /dev/null <target>` on
non-Windows platforms.

While at it, add the missing `SYMLINKS` prereq because this test _still_
would not pass on Windows before support for symbolic links is
upstreamed from Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t6423-merge-rename-directories.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 533ac85dc8..53535a8ebf 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5158,13 +5158,18 @@ test_setup_12m () {
 		git switch B &&
 		git rm dir/subdir/file &&
 		mkdir dir &&
-		ln -s /dev/null dir/subdir &&
+		if test_have_prereq MINGW
+		then
+			cmd //c 'mklink dir\subdir NUL'
+		else
+			ln -s /dev/null dir/subdir
+		fi &&
 		git add . &&
 		git commit -m "B"
 	)
 }
 
-test_expect_success '12m: Change parent of renamed-dir to symlink on other side' '
+test_expect_success SYMLINKS '12m: Change parent of renamed-dir to symlink on other side' '
 	test_setup_12m &&
 	(
 		cd 12m &&
-- 
gitgitgadget

