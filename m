Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C957155345
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729669445; cv=none; b=mZzSQpLh2A3ucqzM0g0fHwc4AyZOjfMaYIoX5S1AofEYGcp85SrDD2iuZMGuv6rGT7MXxDvFjR1bkOZu9beTUPduY+iS3F2VQXtxY97nrEJ9Jaw7pW7bEQ+GGTkOP82OAj6CC2WGEZZjjDwz9RIotjQNZCcAIAFIhvg58TIvxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729669445; c=relaxed/simple;
	bh=xBS1BfUzUvRP/Wn0SwufVu1rRfQ+ufXO/NMGYIJ0yy4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTllextWwwldvaMAXSOn5GucVKyYuYZT9426h2lqO3R0CmX4uwehC1pZT2B/RMW6V0r+S+dH9dssReaYuboXuKSbE2j9JZQISw0wSre9i2JAVSQnd04ua1gsMTE/I7SzL2TP5nOX0dSvqDowi2b0h94hZ3VXnZ13Kqyk3Cq8ODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InfvvGCQ; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InfvvGCQ"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50da1fceeacso2064621e0c.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729669442; x=1730274242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBS1BfUzUvRP/Wn0SwufVu1rRfQ+ufXO/NMGYIJ0yy4=;
        b=InfvvGCQiVslf1hHmtMwTY311OAofzgVhjfiEvp0VOwViJ7AuFkQ8DtChciXlHHLrb
         UsGpVWTx5Lt93Nu7EjxTHLmiui1RiXzModup/GTatpctZobpNVI9j+wArwtDHzEGS2vR
         iBVcTFDBm40CmF+FPLu9REcL7cLWKrH3ljvEGoj5c0sSTXe3qJTepYBWF2tpubVINFJv
         b0JM0DBE9u4r3cVdrLxAdgEIDiLeNImSyYXSGSXPfp1fQBSkc69OQxY2WdQ4R25ytpCy
         9QtTSq9PqooPJOODo9K4n+gFnRYIUPJpXPznFNg0t74sQprLRmuCTI7vXa3+keFJKL1Y
         v91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729669442; x=1730274242;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBS1BfUzUvRP/Wn0SwufVu1rRfQ+ufXO/NMGYIJ0yy4=;
        b=ltVrJ6Z3h+uWxuxjuJUt8vKrVIKwZa3MBb00l2oiYckvq94Tgwzc2nW0bsFcYkkSTd
         +7xnqtWg4DVILEYp7lGQeSv1Qnk0CN9R3/2EpPxs9iNYtlzC8IVo5rOp/uM4A4G3NEWj
         qUXD1hu/0yfqG45OcPJq+zjpUxUr+8SB5FfipjGZXVS0K45fxyGkqEWVN0pzVFEMkwbk
         25LNe+Sxbv5sT3twYEGUdBuclHa98f6PK6TkgJXxwmpIX6WjnhX5CXOgG/3ub8HF/ygx
         kcbRwlzUy2y9QZ6ABtn+ULLCHEg0IQL6DDrB6rEEW9sqoi0XH1sPPR3pmsc8RLIZ9SUR
         4TPg==
X-Forwarded-Encrypted: i=1; AJvYcCXFzipR3oeR/bSOkmufCkNSasSjC9MdahdHJ0eabEPtBUj+9IvXWn5ITYImEh1v5kuKWuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+pLjDSmRtKzfpbq4mZrivjK+oLFST7HWLEn8HhElJIbzpI2O
	k+kSmt7aJrBzI9Kff0NTBdzZuJvq7p95Y2HklCFm4TS7Xv2lVKk5mpqyAkMdFE6gEEokRPJVQk/
	TnvhjrNx8s2r8rihvyzsrF1DKOrxVCmCs
X-Google-Smtp-Source: AGHT+IEqSCjyoU05uAOf1X/I8JR+KlaBXq6AIL4xp805vd+z44mr3YRA7lvJFof1k5euaLZ1ABTis9MG97wNIRul4G0=
X-Received: by 2002:a05:6122:180a:b0:50d:35d9:ad60 with SMTP id
 71dfb90a1353d-50fd02052b7mr1960014e0c.5.1729669441716; Wed, 23 Oct 2024
 00:44:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Oct 2024 00:44:00 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxfVwQxMlcJbGt5D@nand.local>
References: <20241021124145.636561-1-karthik.188@gmail.com>
 <ZxZP01C-9RngukZy@pks.im> <ZxazVG65+W0qKLXh@nand.local> <CAOLa=ZSPmkdngn3=cksBM-syO94-zYANLk8FWBsQYpTR8XT9FA@mail.gmail.com>
 <ZxfVwQxMlcJbGt5D@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 00:44:00 -0700
Message-ID: <CAOLa=ZTSVmpDX-Os-0fs=-t4O5bN5H=aWSdxpMTSM1-UFFvfYQ@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a7203d0625200c1b"

--000000000000a7203d0625200c1b
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 22, 2024 at 03:45:38AM -0500, karthik nayak wrote:
>> >> So, that being said, I agree that we shouldn't use arbitrary suffixes,
>> >> as these are quite hard to understand indeed and typically don't really
>> >> provide any context. So as long as we interpret this rule leniently I'm
>> >> happy with it.
>> >
>> > I am not sure here... I think that using a "_1()" suffix means that the
>> > function is processing one of a number of elements that all need to be
>> > handled similarly, but where both the processing of an individual
>> > element, and the handling of a group of elements are both complicated
>> > enough to be placed in their own function.
>>
>> The crux here is that this meaning is internalized by people who know
>> the code through in and out. But for anyone new to the project, this is
>> not evident from the naming.
>
> Right. I think that with that in mind, a good goal might be to document
> that convention to make sure that newcomers to the project can easily
> interpret what foo() and foo_1() mean. Another approach is the one you
> pursue here, which is to change the existing convention in the name of
> making the code more approachable for newcomers.
>
> Both approaches meet the same end, but the former does not involve
> changing existing conventions, but instead documenting them. That seems
> like a more reasonable path to me.
>

I would disagree though. I think some conventions even though we've been
using them for a while, should be changed. I guess a good middle ground
is to document current behavior while also discouraging future use. I'll
add that in and push a new version.

>> > It's also a helpful convention when you have a recursive function that
>> > does some setup during its initial call, but subsequent layers of
>> > recursion don't need or want to repeat that setup.
>> >
>>
>> I get the usecase of having such functions. I totally see the need, it's
>> mostly the naming that I'm trying to change.
>>
>> Let's consider two of such functions:
>>
>> 1. mark_remote_island_1: This function is called to do _some_ work on a
>> single remote island when iterating over a list.
>> 2. find_longest_prefixes_1: This is a recursive function which is used
>> to find the longest prefix.
>>
>> If you notice, both use the "_1" suffix and do different things (operate
>> on a single instance from a list vs provide recursive behavior). So the
>> user has to read the code to understand, which makes the "_1" a bit
>> confusing.
>>
>> Second, this could have instead been named:
>> 1. mark_single_remote_island: Which reads better, giving the idea that
>> we are really working on a single remote island. Whereas having a "_1"
>> doesn't easily imply the same.
>> 2. find_longest_prefixes_recursively: Which also reads better, and gives
>> a hint on how the function operates and why it is split out from the
>> base function.
>
> I don't disagree that writing "single" or "recursively" can be
> considered clearer. I think that the convention to suffix such functions
> with "_1()" is more terse, but saves characters and can avoid awkward
> line wrapping.
>

But are those pros worth the ambiguity it brings?

> Thanks,
> Taylor

- Karthik

--000000000000a7203d0625200c1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e231946a67fa9204_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jWXFUd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMkttQy80NTdoL0VMZTY3SlZ0WVZTa0RNdFZjVEFsUwp4WG1VcjVTKzU5
ZnlRNjRoR2duNmluazhPWG5QaFJPQllJbnB0QlVNSzMvNWRoZXNZNXVtcWU2OTZUSU9wUGM5CnZx
UEJyWGNpK2ZYTXhzNTdLSUoyN21raVNsUzdibXUzRTJaVllLeGltY0QrK2kvTDg2SmUreCtOYlhZ
V2hWMHcKemdQY3FjSTNGeGJYcWdFalFQaWNBM2g0WU5yRWNWMFM4ejBkZ2ZGZUZvY3dXdStxYldH
VEtLdFZTeHZSZDI5TgplM3laeVAxYWJHTGpDRUVtU0NTVXVWbDltU3hpSncrWUFHSjcxaE9MeUJW
ajFMV2xLd3Q5YWM4T1BVT3h4K01JCmJvNWNyVTNsVURxWm9tWEk0anNzNDBqRFRiMXVNaUZFb0ow
ZWFmZldRaEhNelpoalZJblZXUjNYSlR5S25pZW8KMEZEREZXdWUrRDBLQUlhUUtTWGpPUnNwdEhp
WTBZWW9QVXpOMlV0VlRaZS9vSHVvVy9JMXhqSDg0V1hwaExOYQoybmxKRmR4TnR1NzhIZGNBVDdm
Ui9iOTBGNE90bkhGNmZuWDF6T3dDRkxjSi9HMkR4c1A3b1V1UVRHZmUySXR6CnhnU0svOHN2S1Ir
L2lLR0lHd1JEcXc0K3lPUFJLOVE4SmtaZ0Rpaz0KPUpTd3QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a7203d0625200c1b--
