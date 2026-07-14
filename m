Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A741B8E6
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069337; cv=none; b=RfxhVuYWc2g78CSIFM5pQHpqqCM4XdYCkfgoxvGH4oyfPYXSlY4z7Bl/oLgPjJUvXci9eI699+HF3SchyK29zfjOfExe3Rjez8gjGZaflbN1+2uyxMCB3ZAgQw56e6fBYUFUrasGBAi+7U81jVE5jVnmZbNN7i8z7W/rJrdW5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069337; c=relaxed/simple;
	bh=YuZdmJtWAH56WLbqJWyweyHSW7QAabiH0PVEsHBdonc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PZ7OQvHMx5pbd4Is7/2QTwW/HW+hZuWzE0/e+dqXeGe3HLTdjBQm8hhTmG9vlfm2G1BXi2kYqL9PZG4JjuGPh71Yr7eIW1pUdyUQnmj/bIZocthr+9x2GIJ5tCJxqVKFldgwbjQAclMJjywoRiUKna0Usibey0cVq3eFngBcB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5A0Q4bQ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5A0Q4bQ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ec58fa3e01so107287a34.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069335; x=1784674135; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qyFuMK1yo/xnP5V6pKD1c36GCJ+o2ocvuldTJW4PwWE=;
        b=J5A0Q4bQoCfFPugZ/Pg1WoDcXD1KHPiGA3Y5CqGRznAMUUBRFY8U5areu/ltuMJGMd
         mdUihKDs1tznTSDnNN54Ug0ImYitL6F3tVNNw2JriQZ29HwU2telJo6ALCbY9SGU7P+D
         IFXQLPDN2ZR7CR0/rYo3UiB/hwpUNOpVXoEJphtfCuhPRHbTwDamz0U9XMZNNrmAhhJS
         NFifVxXGBOZmwp+c+sKp1K3E7Ds3LBGKIhOPKo5tZ4+q7+tm99RNnWjsrGCVRh2p8vY6
         QUDHnWoZnwdslgPT1K9Qx17oT6+TmEvj8d1N3clWWjhbET9mFG9YR0nAGvq1VUgkbLvl
         nM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069335; x=1784674135;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qyFuMK1yo/xnP5V6pKD1c36GCJ+o2ocvuldTJW4PwWE=;
        b=e9p1wrSxkQSvlYmwgQrf/HqBJ3/3rbhBOcfxQKNd6y0h0Ht2spr44vTnqJeAyUe15s
         o6rATV1WMXNzf3sEpm7BYomXnfC9YZx0x5OOEBJcgsL7nEM22/VTOnzeI+C/MY3g+lAN
         wcZ3wPeSv5awnwb4MxAU8SZKtRwIfShA8MSCm3W8UkEcR90CNxk3EsY+/nWY84pCniTQ
         w+0WR0zxLgrQwBmQWqNL9wAcPkf9ik0S7daWfxOffDUIU3TNMqrPC7EQfHfGDn3fU1R2
         heSSEpYAEsysIiogIFsd2genoqm5IDJOmSnTa9O5EsxqcujR4eE6SS276uDTw5+TmOKR
         Rj4g==
X-Gm-Message-State: AOJu0YwIttRgOZJdFIvGOup2Zek7aUbgvE2d3kvmbMl3pfAyXgc648Yy
	J619HEeVOVWBksFApBwvKD14vetkl8bkWb8/C7MIxPKQ2Lu/mNCluALWNFXfJQ==
X-Gm-Gg: AfdE7clkChMxdUZ7SG512hmxghKV+axmZqoUXuikKo3dnCbvyBQzz12NWgGG5fxtIAZ
	pcWMt2YjA88sVc/223fY05bvddY3fwL7o9cyKzqrnXRKhkUBwr3ewyMckVKPHfgXsCoDfF7va//
	oZc3TJbkV3dCzRyfIlk0RnLrsDDfuk2J0DhwJjKJz6SBTwudD6Z8e6iCQXb+oQlnnYTvcFvCPH9
	DV2NKoxsj2NEol0EATPVMeWkgQia45ZDguK0su3bsB6wgU2UpAHjVvcw5gbvkgzrAHLijryhKJi
	GLXj/tW2VIoB5wC8UGzxDUci+o6Ucy2jvDQu+fKw+RVt0UFF/tRdCbnaZa0QjR1jb8qlG29stoQ
	Tuyv/D1/WJm2VBI3831rFdqfwk+cv81h3zCdzoz8YOweM3XTNihK42xbSX1CUH/uUdVSccCLPmp
	aPz96oWXqRujt7Vtvn
X-Received: by 2002:a05:6830:608d:b0:7e6:fa1b:d99d with SMTP id 46e09a7af769-7ec097a383amr9838768a34.17.1784069335012;
        Tue, 14 Jul 2026 15:48:55 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bae7fsm17585574a34.21.2026.07.14.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:54 -0700 (PDT)
Message-Id: <711671c3abac64d9bb0872a69d45df4f103afc66.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:37 +0000
Subject: [PATCH 04/11] reftable tests: check
 reftable_table_init_ref_iterator() return
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

test_reftable_table__seek_once() and test_reftable_table__reseek()
both call reftable_table_init_ref_iterator() without checking its
return value. This function returns an int error code (0 on
success, negative on failure). Every other reftable function call
in these same tests checks the return via cl_assert_equal_i() or
cl_assert(), making this omission inconsistent.

If the iterator initialization ever fails (e.g., due to a memory
allocation failure in the reftable internals), the test would
proceed to seek and read with an uninitialized iterator, producing
misleading test results or crashes rather than a clear assertion
failure.

Check the return value via cl_assert_equal_i(ret, 0), consistent
with the surrounding code.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/unit-tests/u-reftable-table.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/u-reftable-table.c b/t/unit-tests/u-reftable-table.c
index fae478ee04..6f444f8cf9 100644
--- a/t/unit-tests/u-reftable-table.c
+++ b/t/unit-tests/u-reftable-table.c
@@ -29,7 +29,8 @@ void test_reftable_table__seek_once(void)
 	ret = reftable_table_new(&table, &source, "name");
 	cl_assert(!ret);
 
-	reftable_table_init_ref_iterator(table, &it);
+	ret = reftable_table_init_ref_iterator(table, &it);
+	cl_assert_equal_i(ret, 0);
 	ret = reftable_iterator_seek_ref(&it, "");
 	cl_assert(!ret);
 	ret = reftable_iterator_next_ref(&it, &ref);
@@ -71,7 +72,8 @@ void test_reftable_table__reseek(void)
 	ret = reftable_table_new(&table, &source, "name");
 	cl_assert(!ret);
 
-	reftable_table_init_ref_iterator(table, &it);
+	ret = reftable_table_init_ref_iterator(table, &it);
+	cl_assert_equal_i(ret, 0);
 
 	for (size_t i = 0; i < 5; i++) {
 		ret = reftable_iterator_seek_ref(&it, "");
-- 
gitgitgadget

