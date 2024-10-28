Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093538DC0
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122614; cv=none; b=f+7kc6fXSlpq1QO7I6oENEchLhAsA421aYznvgN+cq868H0otGJ6hJfAM/18UTv9jsYkSBXDAlxIud7G9+6xOnlxIo/8Bncj0kfc8UF1aCs4LwUQt0BYaGEzCr/dJDIYX/yNex2J+py2u4QF9zZsfzHlccd7AZnUTM4Yh1uXcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122614; c=relaxed/simple;
	bh=W+DEhyGeY4mdB8Hj1sBjQmGXmWOedVZnpuC/xDkNpB0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E09PDCOk0XoLUZsPI5Fa2dc8KKyNUL6lPohou8jBtHHcLRitl0/XU7oyak8kLGgfFu+G+lAAoAGlYcRNAWUmyG/a0vOubl67Y6picpMi5S+Ruj1upn4mq6eDZbAOkq7Lwk5SM6npExRORhXBAYvs3Z2AKnyRnHPxQKJr+iDo1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIt83Ywr; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIt83Ywr"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71822fabf4fso2499833a34.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730122612; x=1730727412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=W+DEhyGeY4mdB8Hj1sBjQmGXmWOedVZnpuC/xDkNpB0=;
        b=EIt83Ywrgz0I0FOJHMMvR19VOqWzI7G7ABVKSrEAsLwlkM0jcheOwyu+Y5ioCVCrSj
         gmO6OMQs9aSzdEC1n6v+S5AdEV5VwAYpRfrfhuh1kNc82u1Sy6/+NlWuIpXiaT2ZSzD8
         FSEH+TVW943+p/ejNDcReVrkZPAHoc6zx4jkT2Pi00oNc/vfZqH1c6lW/umB1qzZgu8D
         YLV+l8rWQc5lavc3Xdit3ysjGxIeWF0ohnIHBxg3SCrVJInO71pdURWIjzfx/dmIEyTA
         AuUyfBKS/iyeXtQR7Iv+dmrgnpssoJHYQF2Ai50bx3tPyEi4Ln+2lsp+605jlfqInF8s
         opMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730122612; x=1730727412;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+DEhyGeY4mdB8Hj1sBjQmGXmWOedVZnpuC/xDkNpB0=;
        b=FyLDrjdD5ZLX3nJjOS7qPA3s1rMHh9HpIj1n6NmmirWnaj7lDO3Adqt9pIeKb+jQOw
         vFnC+mHj3mp11Lpz951LrVPzN3poM4sx0yCYP2tiF/GZhgEFOmyI8wuANTKNvQUON8+Z
         YqIHTljrFmh+WCjqSAJOkuj+yW3zubq5ucUPbr6xri5sZDUoz8o+YNZwqLIP5EbgSLfA
         wEw2f9KK3I/0ve4vDgQqvmu6nHI2UzMRVZzAtWoII46bjov6OQUhEO6M66SP1Dcrr0B+
         fCLnbyND0NOxGSJs/3rFCE2Q1Ldv07Hic2CIJ7INeM2MT55mOl9dcQAmVO2+AFWQNiIO
         LyjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4hsPWmOEmh7LZY2EaE8G98t/Pi85cjzrxhDRRiBlIH7BonSkM4u8K19ctC7F0w/Cyws4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVn3c9S1pMJOkVuSeogi5BJ9Fn4qUjwdm0Jwap/Xg2VzDqmI89
	hi0n8Wsv9jfVTrL9K9vTWkVsbF9kSvHYRxERhw6nv6+VVNq4H1Fdit37meRq6XI+btrh009G013
	LbtrcNNPNCFwlNcBDEt1UhgfChTtqUkmE
X-Google-Smtp-Source: AGHT+IEcY6n3UVFc/DEQDEPDckWpebeIGGplbv+I1B6g0iSrf3e2l6wSGjV5SY1Qn6RuXFNHsKQJEmcw0DLQVM8zZ6Y=
X-Received: by 2002:a05:6808:3c93:b0:3e6:3fa0:590a with SMTP id
 5614622812f47-3e63fa05b34mr4148467b6e.10.1730122611739; Mon, 28 Oct 2024
 06:36:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Oct 2024 08:36:50 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241028053140.GA2827326@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com> <ZxbBuyhfq1sFKBIU@nand.local>
 <CAOLa=ZS3XjxdeYxbZCTCdaUzW4jko8ZLaKMvQsvzUnsan2Ho9Q@mail.gmail.com> <20241028053140.GA2827326@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Oct 2024 08:36:50 -0500
Message-ID: <CAOLa=ZRzM8tka_VLc7gmcukCMchKDQu0htF3LT9yiYWW7iXEow@mail.gmail.com>
Subject: Re: [PATCH 00/20] packfile: avoid using the 'the_repository' global variable
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000b14c2d0625898fad"

--000000000000b14c2d0625898fad
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Sun, Oct 27, 2024 at 05:23:24PM -0400, karthik nayak wrote:
>
>> While thinking about this over the last few days and also getting some
>> advice from Patrick, I realized that we don't need to be this disruptive
>> by simply adding the 'repository' variable to the already existing
>> 'packed_git' struct. This allows us to leverage this information more
>> easily, since most of the functions already have access to the
>> 'packed_git' struct.
>>
>> This, plus the series by Jeff 'jk/dumb-http-finalize' which also removes
>> some existing functions. We reduce the impact to only 3 functions being
>> modified.
>
> Yeah, I noticed while working on that topic that we were dropping some
> uses of the_repository. And FWIW I had the same notion, that packed_git
> should perhaps refer to the repository struct in which it resides.
>
> As Taylor noted this is a tiny bit weird with respect to alternates,
> which could exist in another repository (but don't have to! It could be
> a bare objects/ directory). But I think from the perspective of a
> particular process, we only have one repository struct that covers all
> of its alternates for the duration of this process. So it would be OK in
> practice. You might be able to get away with just storing a hash_algo
> pointer in packed_git, which would be less weird (and is enough for the
> bits I looked at, but perhaps not in the more general case).
>

This was my thought as well regarding alternates. Also it should be
noted that currently we're using the_repository anyways, so we will be
in the same state as before.

In a general case it seems more necessary to add the repo and not just
the hash_algo. Mostly because there are parts which require access to
the repository and also because some of my patches add config changes
which also require access to the repository.

> Looking at odb_pack_name(), it will still need to take a repository
> struct, since we sometimes form it before having a packed_git. But for
> most calls, I suspect you could have an alternate function that takes a
> packed_git and uses both its "hash" member and the algorithm.
>

I have four functions which would still need to take in a repository:
1. for_each_packed_object
2. has_object_pack
3. has_object_kept_pack
4. obd_pack_name

> Anyway, just my two cents having worked in the area recently.
>
> -Peff

Thanks for your input!

--000000000000b14c2d0625898fad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8ba453d922cfb7de_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jZmsySVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3FVQy80dlVZUWNGSTZCay9TUUs0THd2TElIdzZBOApSTUpEVWJOUGsw
cEZjcGtmQjd0S3dmTkgwdDZ2L0tyaWh0S0V5NTI3S2lYK3VvMUYxVEt2WWFISWRueFJBUGZrClFD
TEZoeWlOQTlHMVNJU2NwYWl1VkxkUUE1bGsreGpjbnQvZlU3eUQ1ZGJ4T2V2eit2WmRBRmJNRWlI
SmpJYmcKOUhURVBOeVNKS1d6cmtWV1kvOTJweEJqbW5GRHF6eWtkRkg0aXV5VHkzMy8waXhlYkVI
U2hLSkhvekVxQ0hIRgp5cm5hdC9MaXM1RTlCa3daeVdNKzBWUHVtTEhTMjlTVGMzSGYxWXVHRU9C
UlFEZ0ttK0hXbWFXN2FsUGdZUGRoCnAvZmRBditsNjR1YWxMTGVacGxiVURIanh5YWxnWHBrOUxE
RkNQQjhtNWFFK2ptMGRGei9LWHhmNHVQMW80T1IKaFRxanZOaVhDL1JMWUtueDk4M3FHMU42RjRj
VGNFTTdHcVBpMXphaFNJS0hRSVplTnVLdkZGQ3hoNk03eGxJaQpmQUtJTnJ6b2hsNlBsaTk0VERH
dmh5dlNYUG4rVFdsTXcyY0Y2NGlzOW5rdlNjTEt6MU05WnFOLzRsYnRFSit2Ck9JTFliK2Eycncv
ZkhzTUtvdkNJcU8wSllpUWFPSmZaTjdhRjBUMD0KPUlmckQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b14c2d0625898fad--
