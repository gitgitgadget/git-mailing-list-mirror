Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBF185B76
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935363; cv=none; b=LrM5HtPYt8d1/hYS3XGZrQ7K0pbky6p4Hlug/+P75X7VKwSL4suAHyypE6yMBv2bqddVingTJ2aTG5ALfafeL32UHyENtXp47sKliwWmto+Ew0DkuFs9YHGiq/JUdX2VqbLCrtFqV1EMwMrTEDrhksc4V20P8myFvbyizRDSc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935363; c=relaxed/simple;
	bh=KTtSSbyiJNA+n3owSfOQQhVgd5hIiKsUwGgXTh1PrnE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NhabeFOf4IfCrIkzpG8tslHRRwx7zr4A1Velyr0XOxxgBsuUh7rPpi8xPWioOA+Zo3SiWpfunDQLiWyxEf/Y1PZgWxERWdto1GFYASO7Z5GfVzBgmeJb7Y2whyatj7q3FjjsFCn6Bku3vbULANMwJSd2CEL2EPV5EivALVM0CAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU95lzWi; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU95lzWi"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so5320473a12.1
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935359; x=1726540159; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvBsYsvLR+bmYCeHxwTsXNEdbM76cKEWCFQQ2DVgrN0=;
        b=iU95lzWiCRoP0Llq+tKUPlSDz7+FCsj1WNx064FA8OQQ+v4lJ8Xh6dHs038I1ny3QR
         PU42Yx+LLC19FI2TVzibU+EPTrzW8APPuACiSodYRWAIPH9F4kWL5WE1gYPUk+8bFd6z
         kOSRE7JU6ts3whF4VnHNmwTWymQQgd2MXPEontmzEVzYaza6WdJq0vWYbhhOxzQvLQFe
         15DLvMo7j5HkXUnBIqsBFOFho4+/jwNfMaokzQxQ/9LJg3dbtqjYa9vcI8/g5Zu7/wPx
         rl2BB2K+U703WOupopxPYF0FRgZJUD6oi/EIhynh8ppr6sPWb0r8M7MN8elEJLolS0Hi
         +GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935359; x=1726540159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvBsYsvLR+bmYCeHxwTsXNEdbM76cKEWCFQQ2DVgrN0=;
        b=ETx9ntoLG2DSFNCVT1rlvnhroX2V4JXi9yqJxEVWG+67qkyhCeQm4Es5oDWaSNIDA9
         lL1DSczmd7S7IL+xdPvAaDnU4KpVOX/2XhyPO8JmLYRwcuTOlLhHvm6a0TtW3NgCFpoy
         hzHokCe6fQcQAYQoVE5hMMeb/avWQwHfeD31Ocfe3br7P6ZIaB1UXAipgcHmuKr/BndH
         ZZTP0/+C4jnUfiqYZrRlI1O4YIZ9hnG+c5ZIoBeM/yvGfw1uL6F6btgbs5f499gC7gwk
         tWza8UrzE4Kuo3iZCT/HuBh54jarmvmTPcgwkSEOeR53ve0a/9ZG5PBfp7j4KcJOh5jy
         A+9A==
X-Gm-Message-State: AOJu0Yx5GkhIfm8n9u07oV2z9E1mks5IrqYg7tXKSFA7AlLAi4FArAce
	dsXY5d5XBN9FtMEEAyZhezAlqrj/Rg7DH9EUjF2u0RbqkjdP8JVSEZU+pQ==
X-Google-Smtp-Source: AGHT+IFmEHVLdzIQhuIgOo1zYgpmsagzamLfiVaWHoKTeqQIGtIQXX9KWYU6saIK0s48HodSCYAWXQ==
X-Received: by 2002:a05:6402:50c6:b0:5c2:1043:b3e1 with SMTP id 4fb4d7f45d1cf-5c3dc7993e8mr7745844a12.18.1725935359449;
        Mon, 09 Sep 2024 19:29:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd8cc28sm3677498a12.83.2024.09.09.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:19 -0700 (PDT)
Message-Id: <54bd80701fb9b55910d6d8453f235872fe549fdd.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:48 +0000
Subject: [PATCH 23/30] p5313: add size comparison test
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

To test the benefits of the new --path-walk option in 'git
pack-objects', create a performance test that times the process but also
compares the size of the output.

Against the microsoft/fluentui repo [1] against a particular commit [2],
this has reproducible results of a similar scale:

Test                                            this tree
---------------------------------------------------------------
5313.2: thin pack                               0.39(0.48+0.03)
5313.3: thin pack size                                     1.2M
5313.4: thin pack with --path-walk              0.09(0.07+0.01)
5313.5: thin pack size with --path-walk                   20.8K
5313.6: big recent pack                         2.13(8.29+0.26)
5313.7: big recent pack size                              17.7M
5313.8: big recent pack with --path-walk        3.18(4.21+0.22)
5313.9: big recent pack size with --path-walk             15.0M

[1] https://github.com/microsoft/reactui
[2] e70848ebac1cd720875bccaa3026f4a9ed700e08

RFC TODO: Note that the path-walk version is slower for the big case,
but the delta calculation is single-threaded with the current
implementation! It's still faster for the small case that mimics a
typical push.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..fdcdf188f95
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+GIT_TEST_PASSING_SANITIZE_LEAK=0
+export GIT_TEST_PASSING_SANITIZE_LEAK
+
+test_perf_large_repo
+
+test_expect_success 'create rev input' '
+	cat >in-thin <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1)
+	EOF
+	
+	cat >in-big-recent <<-EOF
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1000)
+	EOF
+'
+
+test_perf 'thin pack' '
+	git pack-objects --thin --stdout --revs --sparse  <in-thin >out
+'
+
+test_size 'thin pack size' '
+	wc -c <out
+'
+
+test_perf 'thin pack with --path-walk' '
+	git pack-objects --thin --stdout --revs --sparse --path-walk <in-thin >out
+'
+
+test_size 'thin pack size with --path-walk' '
+	wc -c <out
+'
+
+test_perf 'big recent pack' '
+	git pack-objects --stdout --revs <in-big-recent >out
+'
+
+test_size 'big recent pack size' '
+	wc -c <out
+'
+
+test_perf 'big recent pack with --path-walk' '
+	git pack-objects --stdout --revs --path-walk <in-big-recent >out
+'
+
+test_size 'big recent pack size with --path-walk' '
+	wc -c <out
+'
+
+test_done
-- 
gitgitgadget

