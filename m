Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC1502BE
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313834; cv=none; b=GOFCzen+bSUOyoeqk4kLYh1ucnXxgM3PzzG60I/re+LFi2LCNSt4sjkgMRA7+iV6+X4krl0I2CZzGs9RnUcyuCopDdyOKrqNZ7XYROwZp5Oba3inroPrR6m/M+YPz+7Ml/A92R2Uh5wLkk4UleWxf0WApBk0ePaFLI5R/bp85F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313834; c=relaxed/simple;
	bh=htiTKdZDr0H1iHwI8LoDAVpoEda5sOZE+Qen0SewfYI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NteWaDweXb5WzyeVl5lqmQ+qPUyE2OVbHhXqnMjwFx/aByGvkKtueTz7+qK+g4Eg8QkCeNo7M5OEUSPs66MT8oUrLo5wBqNQJ2u38ZSB4U3g+8ZFFcq9biE4XP5hyvX7P1GTpJ0zPFXas1XE+7XqEB1QfU+oiXObwxv/bL3kvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiSoa8js; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiSoa8js"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5ed6f51cfso350410eaf.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724313831; x=1724918631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/fgyYC04oo+zjg5zgxLbZlkpy6q/nKqr3zKCG430/0=;
        b=PiSoa8jsHTgGl+RoXweKpH+lFN17fnjXxXlHtQlqBd/3/NqQhteWLsKVT8wxfsoaQm
         nXPHOpqFX4XjvxO06lwRCYXR4ASbwMOI5yu+mgGDIPv6EohzvmX49/s+74I1zdF9ezbN
         9y1wXI+UCbiOnaOpWVEsaRfexTEcDbokCwCG8Xag9SZPquleDqL/mEiZca63Hpv+5DfW
         YN9pVWOCbIEyH6jlaAO1Ci4Q0nam8TqHDzlHBUmO84mb2RsjH6U3lU9UzzdRs+NS4rW1
         thpLpXyMQ5Z61/zDcc2w9UuY8osRv5+m0AzSuNVuXPgWBOQXWZlsC5bZNzfBFtUGnRvx
         M2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724313831; x=1724918631;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/fgyYC04oo+zjg5zgxLbZlkpy6q/nKqr3zKCG430/0=;
        b=fG6OSvTOwSIzeqVCOZgW1w2pKyva5ZkgKINesTGGsMqjEcQsy0oxCLNsjKUGvgeAbV
         Xv0qF6DrEzusOd164RpsFAgBpHbn4SDp/th35xuYqaIrPiMJHpzfKzo6r4A8t1e3be8Q
         La4pN6GHIybaQhM/zbqw4xgijNki3Mv1rL/U4molU0a/ayU0tZHVcV4OljBPkc8sHeoh
         2pX5jkNnYcifHsGCr+RwSJJqRM8NjZ6yzg0qnof+DoD0A0YG1zfK6lswJLkZHEboPj00
         uE/5/VhsuNVdennvXyxI3ey865MB6OA91A8ruj4jbrgBpearkS0FbavOasTp+cYiOmkT
         h5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXh/+T6ROt0L/0kNZ2LqSMphTC6wmXB6nDi+F20m6QAI8FcDQ186s+y3W1WZcUUUwrw7pk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/X5MoM7TmhUGaxI20c2WGGFmwhqiQJwOcN584/D54j23lNy+Q
	S/cE9yqbwTEAUZLJ4MF+FX6li5OgeBb4Wlte15YYcih5ax4mRjiynshEkrrl3upkLtI7RBGCz1X
	vN/rF/FVNd6xF5gebmTlaXjj4p7A=
X-Google-Smtp-Source: AGHT+IGf91HNnDmSt8RcJ+HkWVJTuYpCkJZnxNjx2FaTG2bHSe28ew7hp9Q8xVsbSAdJ0VUAQtNnqsIoZITjALTd53I=
X-Received: by 2002:a05:6820:180c:b0:5c6:60d9:b0e1 with SMTP id
 006d021491bc7-5dcb64fc8bfmr1458476eaf.2.1724313831597; Thu, 22 Aug 2024
 01:03:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Aug 2024 01:03:50 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im> <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Aug 2024 01:03:50 -0700
Message-ID: <CAOLa=ZSrL84a1=PBuhL-ddwgczi8N6H6PxsNuggN4G9mLvkORA@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] reftable: drop generic `reftable_table` interface
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000006a066506204119a4"

--0000000000006a066506204119a4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> Range-diff against v2:
>  1:  472c169b501 =  1:  472c169b501 reftable/merged: expose functions to initialize iterators
>  2:  bc6f1cd8c1b =  2:  bc6f1cd8c1b reftable/merged: rename `reftable_new_merged_table()`
>  3:  58e91ab4b34 =  3:  58e91ab4b34 reftable/merged: stop using generic tables in the merged table
>  4:  6ba3fcee411 =  4:  6ba3fcee411 reftable/stack: open-code reading refs
>  5:  cac08a934c5 =  5:  cac08a934c5 reftable/iter: drop double-checking logic
>  6:  103262dc79c =  6:  103262dc79c reftable/generic: move generic iterator code into iterator interface
>  7:  4011fa65d81 =  7:  4011fa65d81 reftable/dump: drop unused `compact_stack()`
>  8:  ceaa296bfd4 =  8:  ceaa296bfd4 t/helper: inline `reftable_dump_main()`
>  9:  a62e4612e97 =  9:  a62e4612e97 t/helper: inline `reftable_reader_print_file()`
> 10:  7acfe4fecc5 ! 10:  242c179df5f t/helper: inline `reftable_stack_print_directory()`
>     @@ Commit message
>          Move `reftable_stack_print_directory()` into the "dump-reftable" helper.
>          This follows the same reasoning as the preceding commit.
>
>     +    Note that this requires us to remove the tests for this functionality in
>     +    `reftable/stack_test.c`. The test does not really add much anyway,
>     +    because all it verifies is that we do not crash or run into an error,
>     +    and it specifically doesn't check the outputted data. Also, as the code
>     +    is now part of the test helper, it doesn't make much sense to have a
>     +    unit test for it in the first place.
>     +
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>       ## reftable/reftable-stack.h ##
> 11:  8bd53a1a656 = 11:  a05e2060996 t/helper: inline `reftable_table_print()`
> 12:  c50aabbb804 = 12:  ee22a08e11e t/helper: inline printing of reftable records
> 13:  5498395872c = 13:  0a3c619e842 t/helper: use `hash_to_hex_algop()` to print hashes
> 14:  5390be75c37 = 14:  8eab399dfc6 t/helper: refactor to not use `struct reftable_table`
> 15:  5aeab8ee077 = 15:  b5d7b5679b5 reftable/generic: drop interface
> --
> 2.46.0.164.g477ce5ccd6.dirty

This was the only change I requested in the previous version. So looks
good to me now!

Thanks
Karthik

--0000000000006a066506204119a4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 597bac8a1f7111f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iRzhPTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjBiQy8wWHF6OVN5UzFib1VmNkJoaUlIaGxzc2cwZwpkTjZRTGswV0k3
SjlZblRaU0pLRkdmSUZJek1RbGNsRGlHYjkrb3QvOHZsOGdBempPRjgrSUNyanZIV3dJZHd4ClJq
M0dPNGF2dWhnUTd5NkdNNFhFVWY5NFZFakRGTkxlY3VlSlZXcUdFbWUzbnZnQnR5YlN5LzZJSFZD
b0syV1kKdURTL3M0Y3FHeWcxcDhMeGtsbGVkTGpZMFBKNm0vSm1kTU90SjdSNVM3SkhwU1dhSUdK
b3ArUGVtdnVtRUNvQQpVZlBxYXk2Y3g3WVAvZlQwaGlTdE1QSFZpWElRRDdNM3ZNdTIxb1hZMS9r
UG80b3BadGw5LzY1c3ZacFhHei9aCnhCZU83ZHBBaldSK09pUkswN2c3KzFlUGVhcWd1b01wZDgr
WFAyemlLdWRETFUyK29SOUNudVFzWm96NnNVRm4KcGE0cGRKRnNuS0QwbHlwZVpucmc5UnhXbGFp
eWhteFBmMnBtRi9KUkNLaGFNYVBlZGlJRXFPMUV5dnpGR1l5Swo2UTJCeTVEc3Q3L3ZqQ2hIMTcv
eDdOWW8wSWJUZDhSZGFEekFsNW9kMlBIbERSSUk1ZWk0R0NVMURZTENSUk1qCkFhbGoyelVUQlhS
Nmp4R1JPY1JrSjkrWGIwaFpMcVUrNUpoV2Ixaz0KPWRLUmQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006a066506204119a4--
