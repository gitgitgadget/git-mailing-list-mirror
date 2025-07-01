Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C62797AA
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383170; cv=none; b=p73T/uPzYrRmqqaEeSZdVKeArfODOjaTQd46n/7ifRdDQr4UK6fKptvzSWh4Mb6r+MdnBn7rF0KrCdxdAiIArmMjYQ9G9ERICXanJpfGkNyUBQZXyJYz+Y+8Tx4Y2Kpd/PFM1cZtbHhF08XyehHxy2KDduTM4kqfN0wb8X6KPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383170; c=relaxed/simple;
	bh=+K4U3K9H4U85QpceI0DfcYy+2Fz/F4ybknGfa7zISZA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfcNk+KWMO7C9qli7Gvd4t2KmolkrNIuwv9BewfbtL3fhMidWCB4bL+pSUMH5T1umG/6W+329wEBggi61dhVhmx5E5TwCMW9QAcsaJcvclzmDdZwiY2lb5lvnCs5Jz2j6r6o8oJ7HR8zOG4Sn87S4jWTG8B4VMyifMS2o5Uchgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4Z5Mg+9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4Z5Mg+9"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d3cc0017fdso366127285a.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751383167; x=1751987967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0BEpAqUtl1vezFpSj8HB0/aH627huvZ+51ebUeLMgz8=;
        b=N4Z5Mg+9dCLiO4YlAlkUkSbBFei+pRSCdj3DoU39CH0WHyToQr8P0OpJxKjWIlIRUj
         UCYRImjNWlzwKRxE/tgXOZen4pTMMgUAAZ6sIMEEBKHjPj2PZrmrlVrdNKc4KFQuLHDw
         JzLpMDuReBQZvCLU1k0Dc8U1umuU9kIRePhdo0YBbyENwkM3ZYowP/pcpefjERLWak2t
         L3cx7H+hIKxYC0bVf3K+MKi60Wx5BC9G8eUON0SXJpvudokWU4fcRj+nIwV5R42I1QO1
         qC48PA9GcUIkp/xh6rHoYcqUvn4snTUCmoNIMnkQ+1nh7YR0OzyM8NRI80ddiDzxi+5u
         P3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383167; x=1751987967;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BEpAqUtl1vezFpSj8HB0/aH627huvZ+51ebUeLMgz8=;
        b=cQ3qfskY0p0U44ZXXgQzE29Lbi21Xtpgmzf9l73gfy7uN4BnFmiu3eYzS3f0dU+wVq
         2NEPVWDty9rfau/lHL0qGd4P8WzDlrp2QAZvZNafb+B/Jf5LEnFPyN3CV/ocmKtRZLYI
         FjOVLoHWfPB1MwIvp5g5eEFGmN1efNfdJH7BVoOYVuzMh+goyKzjXPwndTypl/Q8lWpY
         rN6+usrXxhny81d6xqx7V+as79rXGIYSLciOn5KTfiIX4UALs4WvmWo21TWjwvwxfpUb
         +m2dc3RzXX1nSPUoyaOSxxe8qsdaJG/ZJe5fdlQUO+zK+WQo9NNm5eNxVi4WOATvJoeA
         g6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVY59frBGNl3d3n443Abb/9R/ZhlNDa15AxjPcme2HtVntDF3AhrVxB+n4gzKtLNlSJas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDgh5+4kzRcXN2P00iNx7lt0fKGM7FUCN+GcS4ELJWfDyGE7D
	sGbMwWRSF4dRVJG0H2mloIFXk5/cSOs4anWsndiXIVaPl4PvsTrxUscv8utSIcfg4dUqRJp4QRi
	Cqhgaa7KxEW2Acy5tbDYpWjtVp2tCKn4=
X-Gm-Gg: ASbGncvd+6/NcpW+yYrAvv7bVAIM2u2EyIdMVGmCY0uYzE69z5G87EWnUYeNJkBzftI
	b0TeKJGbU+LOtVSv9iqia2o5oW59W8v9Jo/N+PtrtjibVAaj1f14LRsRBZHKctznmFaCBMPjoGn
	apRc++XDFHimaUo1TYMNT52rbnKTw0JTOBK90h7WJ//kErwALBIbfZBzEE9+TCbg4/r1BsRnUBM
	4TY6A==
X-Google-Smtp-Source: AGHT+IFuC9ENj39ReKyqogNKcJfEPbl1FsCiZti5wNOSkKGprZCeHXailZHWF0wHKhmWWzpVtA/5++3z8YOX0ALmc2U=
X-Received: by 2002:a05:620a:ab07:b0:7d3:b292:84e0 with SMTP id
 af79cd13be357-7d4439a8324mr2103893085a.45.1751383167191; Tue, 01 Jul 2025
 08:19:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Jul 2025 11:19:26 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <878ql8qbhp.fsf@iotcl.com>
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
 <20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com> <878ql8qbhp.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 1 Jul 2025 11:19:26 -0400
X-Gm-Features: Ac12FXxDVWWxN_DVTHHf1hpnuZsZcxlr_VHX6NV_kLdYtqIXgYsJdBmnu_9ED8Q
Message-ID: <CAOLa=ZQr=JfKES6vMfROLsvO0egjwNun6oGkwJsN9_TkQkt3rg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] clang-format: modify rules to reduce false-positives
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org, jltobler@gmail.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000008c7c180638dfab87"

--0000000000008c7c180638dfab87
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This series is in response to an email thread [1] around the usage of
>> '.clang-format' and its effectiveness.
>>
>> The goal of the series is to improve the usage of 'clang-format' in the
>> repository. To do this we:
>> 1. Reduce the number of false positives. Majority of which is due to
>>    line-wrapping. We remove the 'ColumnLimit' from 'clang-format'. This
>>    removes the responsibility of line-wrapping from 'clang-format' and puts
>>    it into the hands of the user.
>> 2. Add a rule to 'meson' to run 'git clang-format' by running 'meson
>>    compile style'.
>> 3. Make the 'RemoveBracesLLVM' permanent by moving it to
>>    '.clang-format'.
>
> Thanks for working on this. While the changes are not huge, I appreciate
> them.
>
>> With this, running `git clang-format` for the last 25 commits in master,
>> seems to produce much less false positives.
>>
>> [snip]
>>
>>   diff --git a/pathspec.h b/pathspec.h
>>   index 5e3a6f1fe7..601b9ca201 100644
>>   --- a/pathspec.h
>>   +++ b/pathspec.h
>>   @@ -80,7 +80,7 @@ struct pathspec {
>>     * For git diff --no-index, indicate that we are operating without
>>     * a repository or index.
>>     */
>>   -#define PATHSPEC_NO_REPOSITORY (1<<7)
>>   +#define PATHSPEC_NO_REPOSITORY (1 << 7)
>
> I'm surprised, but I couldn't find a setting to change this...
>
>

I think spacing around binary operators is intrinsic and not an option
[1]. But I'm not sure...

[1]: https://github.com/llvm/llvm-project/issues/19412

> --
> Cheers,
> Toon

--0000000000008c7c180638dfab87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4a1dab7fe83e2cac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oai9Id1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNkpkQy85cFVaK0VCVjIzaDlvV3M2V0ZpVjhmVGVLNwpoTFo3SXJwMlJY
MmlXekRSUVpnZ2d0VWVEc0RlV1JkRkhuM1RqOEJOTEhnRDJMdlZKT2JnMk1kQ0xFbHNTa1cyCkRO
ZFRRWXpPRzlrMTJGcnBhcFJSbndxSDQ0ZzRxY1MyVXpnVnoyV1dsdW05NDMySjQyVlVvNllXOHcz
SnRXRWEKZXRqa0VPbzVUTkpIY1k3aEdlbHpXN2I4RlNSSEZoT0xIbXg1Uk16dXcvMjZTN3o0bnMv
TEhoYW90ekVJOThlRAplZ1FjVHJTVzBIaWUzTjB0endkZXJUSUwyTjBjLzlEYzZNdlFwVDE4QzFm
YmpTa05vcEZVWmZLa3hqZkVSODBHCnh4QXJqQUE5V1g4QVdRL255U3lxdXZJMXRMRnUrMUhvdU9X
dGVjcXA5RC9kV0ZMd3hKdWh6UU93VWtTY08yUTgKS0JacG4vc0JoSGNHa1pRY0JNQmJ3RkRXaEFj
UTROY1lmSzFqTzUra3p6NnhDS0I3S05hbFFSdjgvcFkvN3RPeQpPS3gwd1gxOXo1OEh2RHpVcXR1
ZEVIYllkYitteFAxS0VocTB0S3h3OHNkZnZhNVV5dnJUdTRKSk1ZdmNYd2xlCjBFOFoxMUtqMkUz
bWcrOFhvbUlzdjcxOVJwKzhEVHNvWC9FUkxpUT0KPVhjcUIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008c7c180638dfab87--
