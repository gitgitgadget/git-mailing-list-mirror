Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47D1DF977
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628078; cv=none; b=XXWk6CgzgaOtOe6Ythq5Ew8omX33ZRkzV9n1ORzetyb+Q7Sz/GSLy522PkUibtp3I0or/3uyxxJkjiV8iI/XSQ+Upj+LY9sLRvk7yapXpe2izagmKDMDbSkdHkQ5uTXusOiqUgiKF82jwsHfOYvoCl9jJvvnd1kPp1/cMBRBoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628078; c=relaxed/simple;
	bh=c3WOS1VSFcuTA0w6McjAFXRQwC0tL1cHNAU3wY+e/DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjCPoI5D+Svg8tZNsWYot5EAGFI2FqLyK5XyDhDqLKi3smMa7+izBa271Nsg/jDAPVMeC21ACWRWxjTMvmRV9rCX9Y0lkwtYAR/IPURBTnxDhJg0QpEN+YSAQEzLNt7JZoOGnBWmiK+fsfvRjdP7dmx4skUIFvE3D0/WgD51xp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJlfXpwb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJlfXpwb"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31ec977d203so292834a91.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 21:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754628076; x=1755232876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bbz7iUmGdp1vEvNMPa06+dfp0YdarHJxGyyUSLkMua0=;
        b=UJlfXpwbL7DVdTapbm8VA5kPJIjENIisU6Ufr4E3Cx3jHqwvUg+hqu5cGTUJnrhpR9
         yirpW/FsQHDpCnA9MXFYHFLNrWFS5XtaJPt5ULSdnNEJM3oUK73ju7ZoKJqFUoDSC31F
         VZKkqAeVmkInz9JZJGt2RP6cdwpjnDytaKtKQFgZc7BASv2PfCxG4nIRJF175Jav6tVD
         zcOfEKlRWyahvPkD6Nec+VKu9FOpJifRJ2YRWhpCzeCNt3/1ZyAj8t7v54yp39kGAsVe
         0CRO9Is2zJpv7Uiblgkx8HQWNIcHu4ZY/OGIRcdQMXKGuEo6Lh1Vp5E9tmnRx1So+rst
         jN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754628076; x=1755232876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bbz7iUmGdp1vEvNMPa06+dfp0YdarHJxGyyUSLkMua0=;
        b=R6pyizUr1P91dEXAVAhETqhT/4kn00uGogFMvUW50QhVgsvjKjPQIR6VNpzqsYy49Z
         xQtP+EnWsqcBLBF6eLsTl6M+HdsUA4u4UjfrugjAZxtH9fBExzivQAuxzmNvbGxRn4ER
         C17LETVypmMrwnhkUF6Qyi04b5rTW/bDcRsUyQbozWT+RGd0ZuG5sIYzxU0hRgdb+F22
         fy4/2ecwHpzvEh82rrV1yBv6sfRMKsL99WslPCvFevjBjqqU7z9aXPqzyRGdXtSUs5m8
         xZSkHeK5yvSDqzYPBqklhf2KvQAtRPYj/OMTC1Jx2r57+X8INPBABzamD8ulbTAAtxJn
         SNSw==
X-Gm-Message-State: AOJu0YzZbDPlg8Z5PZeqM5B2EAOWFBmrsXp/pnepCrmfmaUN7qlfKdO7
	20pO3rI/gxGCq1nsogsj4Hvrp7zibrPAoe/SoWTB9V2xwTlPWp0kojrtMpuiZA==
X-Gm-Gg: ASbGncvXGbnZJ3qmzumgSBtZ3WdRZeKo7PA6wOT7fLBrvoIvqKAkUnQxQlmtfUV36ZG
	X2ZtdRDcZYJ2dzkoCFdBp7kQUKnDIiYfGyeG9pigXqNUq43vg/YTuDUjltZFsWx/HnpAnFE7d/d
	Epj1RPFhdP7ka49f0vvqAtOMnmZbIIM10GvJqjA7k8ti+apr7kKMbrFImaolMYGI3UxM6sOaoCI
	PR6/sR72fRd0E0kCxoYtoLMCCi2ng34bdK8U+7xlp1JDp4PLNTN1oE5hE25qF1pjlUTlQXI1HYg
	TaUvTR3fJQdtCQFxHMV/ZSmtdy6UAgCUXecjBQOv6Wm8RUZ8TWetZUQqepvPx5c/4glAkLIb6DR
	8eOkPi6+jwzUgN7RkRl5C82+cYtwK5J5/EDjE8C/2
X-Google-Smtp-Source: AGHT+IFCEgk0hHHNC/cDhVCaqriz3kT58UflzN0k6mvz2uyOWI/2/OmJScqOzsaWXo5b9xI/Zk7Otw==
X-Received: by 2002:a17:90b:4d09:b0:321:2b89:95a8 with SMTP id 98e67ed59e1d1-32184dde408mr901903a91.8.1754628076283;
        Thu, 07 Aug 2025 21:41:16 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321611d6ee1sm7066147a91.4.2025.08.07.21.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 21:41:15 -0700 (PDT)
Date: Thu, 7 Aug 2025 21:41:14 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/3] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
Message-ID: <3d84072dc7910026e203ca35e32ef026d0efc131.1754627874.git.liu.denton@gmail.com>
References: <cover.1754455931.git.liu.denton@gmail.com>
 <cover.1754627874.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754627874.git.liu.denton@gmail.com>

When "git push <remote> <src>:<dst>" does not spell out the
destination side of the ref fully, and when <src> is not given
as a reference but an object name, the code tries to give advice
messages based on the type of that object.

The type is determined by calling odb_read_object_info() and
signalled by its return value.  The code however reported a
programming error with BUG() when this function said that there
is no such object, which happens when the object name is given
as a full hexadecimal (if the object name is given as a partial
hexadecimal or an non-existing ref, the function would have died
without returning, so this BUG() wouldn't have triggered).  This
is wrong.  It is an ordinary end-user mistake to give an object
name that does not exist and treated as such.

An example of the error message produced is as follows:

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote.c              | 6 ++++--
 t/t5516-fetch-push.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 61e2c9951a..df88914716 100644
--- a/remote.c
+++ b/remote.c
@@ -1222,8 +1222,10 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 		       matched_src_name, dst_value);
 		break;
 	default:
-		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
-		    matched_src_name, type);
+		advise(_("The <src> part of the refspec ('%s') "
+			 "is an object ID that doesn't exist.\n"),
+		       matched_src_name);
+		break;
 	}
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8eddf3e40d..46926e7bbd 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -471,6 +471,11 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 	test_must_fail git push testrepo main^:branch
 '
 
+test_expect_success 'push ref expression with non-existent oid src' '
+	mk_test testrepo &&
+	test_must_fail git push testrepo $(test_oid 001):branch
+'
+
 for head in HEAD @
 do
 
-- 
2.50.1

