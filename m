Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A1311C32
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602672; cv=none; b=G29/MY6JHxaRX0M/dK2kQoPTpuUrFqoPiATssUnafL5nTJp4fIzWMg+UbNqDfEfwruwnzbfd+iDikegLkTPQ2Qx1EnqUKxQZMjrq/le7XMMy+AQvPLnKAJghll9tpijVKAMeydhUDTlNc7CXnXZCcB7dD11rUsotTpgGAx2ZvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602672; c=relaxed/simple;
	bh=KD2RtFcwUeJkXktSOj6HvbXoWGmLF6gGN+QXt6P1/jc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=oAWALlKoB/TGX4T1/dQMyqmPFCnefne/zuHKtKDZa3VC5FPhqwy8hQCl6VQFdkJ+CZpigtsXKM099zM+dZLYkS19XL2VhRIGs1JOT7c8H7l5C7AP0aT2yC4e+bESh33fh/E7og02m5KvCPT1050j0ZnPwdcAEWTzVKUe5H3qlMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md9K5+eM; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md9K5+eM"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233c155a42so3385682c88.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 14:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602667; x=1769207467; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=md9K5+eMyF7GqQQpLXjj8EHp+t1CPjxFd+5HHgon49746BjPgpW9+dulGBWLUONehu
         RVUJ5eyvLXMAGvpG9bqqMsHB/7Dmq4PiuErJLt7LG2F91igvzW8W8phTgrDPPEYWHDy7
         75MsZmptduQU3y2DjiNrpCYcgp+DO6FeAIokTp8sUvqaD5RtMKgPB7mUFodsocbXzOcA
         gjJE/Lvw04xEHuwlpx8/vL6ClGyQS5Shxg8sB0fZFmJnrf6eEHjAnPZ9rubvk0s+ilFn
         LKFCgCgHxxBIFOq3D65GpmJA4vyc2fy6fVVc6sv2ypquaUNlWsq4OoofeI3fd9473P99
         rqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602667; x=1769207467;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Wu+WJEVcS+59yiwWCWqOgegceD0+jNFFCR6539Uxlo=;
        b=XeAaMAsJnf86uth+6vZwHwrgOApQ5sG/qRFmILJ0e2feftrZEFRQdjIpa59PRVjb0l
         eblpJ6seFNQ0G5tAgdqSTqcq/pI2/UyZJEnWg6Pm82Zm/bRVbSiNhU/aZ7WPoaB/zjQF
         mE7xFzQ6USgyHGJW4Wga/UrHPnzPStiXEUpoqUDq7AhOeJBP4xUEJ1PbMhtr7Hz91ZpR
         m4Ny27vjvWJwqMB7moLoMOpchL0gyfbZqkHeHXFOpbau7E7OlxjKafHnhRCxLNYeWNwr
         Uti16esTzgkOGACjBi+ypGHrEbIhSoagiJVcnUfcOvbAjqeYRRnLKHCueP/WJyAPtlwO
         IcRQ==
X-Gm-Message-State: AOJu0Yx9VAOrL5INRSj5SuylJJpAlH0rUN6XOvJ3JRPi8GEhpXL5J/wW
	LDUXLbZ4p2r/TmciGTfIvKtgkzM5Ciiuwb76O3Yb7smLI4i42hyMQMmm7JF3Qw==
X-Gm-Gg: AY/fxX5U3Mh8I+Ox5loP1VHzM1F8cx32XxxukYClrV11WPhW2c/QjS1mK0qakC/1/VV
	XYNSMDk26jMzWhdsMdFKLTRmTh2c8YZBjDiydBClTn4gD6UGS7nj2kt0qSSVvz30QcYHWNHnBzT
	rq4iDyQqlm1CeMP006y84frYxs1sC8pSsiVzNI4bTFSHa6luSEK+gvIhTmgcDgmLzGrGs8TzSHA
	O6pra7TT2LjNE85GGH1I3NnsFWxTcQlyH3KVdBjebTmM6fXhsOhYpSIEMtGrb15u+IVPtNa+qVD
	yKOKTfMbFi5gOfSyU7/ez3BO7J2owZ8cg6WBTfR7/eo+zhqWVCHiYd0V1BcYdVDeeKbVTQd1fTW
	1XWJ+nf6psLehOvjenvavE9COUa034gUYm81KZTxfwz6wQNmyVQcb3ks1nvyiUkIBFTnit5ZJ5W
	jquX78XPFIJw+8
X-Received: by 2002:a05:7022:920:b0:123:2d38:928d with SMTP id a92af1059eb24-1244a74528bmr4646231c88.36.1768602666922;
        Fri, 16 Jan 2026 14:31:06 -0800 (PST)
Received: from [127.0.0.1] ([52.159.247.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm4814804c88.5.2026.01.16.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 14:31:05 -0800 (PST)
Message-Id: <f8a8d077cd7203663406bf656287ed7e0d6e6d90.1768602661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
References: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
	<pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 22:31:00 +0000
Subject: [PATCH v4 1/2] shallow: free local object_array allocations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

The local object_array 'stack' in get_shallow_commits() function
does not free its dynamic elements before the function returns.
As a result elements remain allocated and their reference forgotten.

Also note, that test 'fetching deepen beyond merged branch' added by
'shallow: handling fetch relative-deepen' patch fails without this
correction in linux-leaks and linux-reftable-leaks test runs.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 shallow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/shallow.c b/shallow.c
index 55b9cd9d3f..497a25836b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -198,6 +198,7 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 	}
 	deep_clear_commit_depth(&depths, free_depth_in_slab);
+	object_array_clear(&stack);
 
 	return result;
 }
-- 
gitgitgadget

