Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECF02FB087
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344866; cv=none; b=oQKmg1aAkx8bCPw/nL9NPTSQ0NXKTggdNHk4jDAnNfuo8SgILr6XAW5CfFoNasNuN640gBL9v2aQZdO2dSXuREab0n4RYDZ5VUxg4C/fF90Qhj31P6QcWOeBxFjRleS3J1XQHW7/MQvlC3qeycozACzdtdenqx1MP9qeFB89320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344866; c=relaxed/simple;
	bh=kRfkFYOu0j81robCLDiSmwACdUcwigUfdoA7f5X29Aw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DDAqrb3UpsDGbEOGxUaPHsgwT4Gqp80gSvqsoMhvH9jyDeGpkC6SlqCI2Un8RjJVNge6tymrPmpuqAWuWji37TN56QDsRXvKXdpXEPOpEMOAWKPBKFfXLY/8dqe+NndC7z9ZPsnnYRAuRjNncZk9iS4QMqHY14+qhfsUD3e7GTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3yRNbLt; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3yRNbLt"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7868b7b90b8so26580367b3.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2025 04:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762344864; x=1762949664; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQm4No/qkEihg4OfwP0Jf1bRAOG71B3rercpy64QQxc=;
        b=P3yRNbLtaG2ElhRN9HHXQehHr0+EyZ2PKKMy4jSe+Rg0+alkxYG1l8gpnxckOFks2T
         u/hOQQVTid6CNgFJAUUT1cXqYR+aelPYhz1B0wLgWJUWqrg68nGCxEwIA+VFE3on+JND
         fzWHbAOn8PlviCWVAk9LS34uGT4x06y07En/yVlPXyHpYr636XJJ5c6DcCRVJtjE+rbb
         ++ohzmvVhRPA9IEylVs70N11L/Ydvp/GeN9DV21Z1rT8kLslLuv/F+wQFirn1nbYpdu9
         gKRmth2RjIQDY0LNvWdWxOGr/uHCjJv7HZs1CbG54jZuBYkangcNUrHzkkrff7Dz8+p0
         YdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762344864; x=1762949664;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQm4No/qkEihg4OfwP0Jf1bRAOG71B3rercpy64QQxc=;
        b=vZ+AdrFHck3Bfuqf4AmGbqa/QKJlgBe+WEOB+RuUr1S9xnQhSXFpgOlwHFr+EhNUqd
         u1og4m6gLs8UGlQ8f/lLMT0yJmCWOLBLJfIQMYDW6C7wNWXuSR+62gGpOi2IC2ruybG2
         mhNy42v5NYLpJPiM/V9QGQuREgYrWxzlEANan9XWTCyBUwh+1RB0/yKVVaPXaBGiQ40k
         5jaXwerGn/fR8PPMarm6wv5N2Bt+lPyQ1d2HAx+rvjkPYSwx4Ucks7R8ORsSfDUwKGml
         TTZxcc8BNE7Wki83nFTqCbDirwG8/mBnq8rrLvGW4czw6IfiO3dcsXf4n4FKmrVaEmkF
         9pZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI+iI4gncrWHZORxrcYrgdQGV97F3TiYxvJ6WXnKwzJCBHdMv8l9biKEKd1m20koFIXa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGUPW5sVH3ihv4eue8UeTZlNE8vFstPU7uyRmo7Jd09FQTCrd
	zpZZqgFQiNw6K0o7tQZw9bQrOHT6YrPQEQoEk5lNdR8zjs4EsfAd1iNJ
X-Gm-Gg: ASbGncvOrT+b4OEjqvCi6fhCd5WCXifbgm26uB/Qb4JE6jjCwt7l0K1ifbUQvfxgPfh
	RPz49j3f9xR22bSVqfJMcWGqmrux3WuiLZylCcBjcEHaUDNs9QpzE+Rfyj2NPvyhO9xmyqlZMly
	S4ofyaD7nv38ppout3bLn8q1TNsRBaOnZk9suRM7FT/geEKSHzuFYbWwy/bY81mIStsgG/Df6cU
	ttLmYuofb5JxdGMz54HkV6M9annCnQaMCtmHMGZ9dryaWELVL3Y0Uc6Q14gxUmnii4Aljgz+ZNq
	rzKa8AEmDW7r9aQOSS2sxuZRIUZtbA8FFMTJBYqMOonhT/9zO/QWupCpKCu5APerZcGmUfp4mUC
	L3TXpsMbyHEkwmpyHDId+9fGsHXICbZECrQOhmnAp/tkT28cSyv4U1iMg8rOtLsVpZQ4Z9BsquS
	wtjNnihnmXGkg3014VK4RFCaM6Z0xt
X-Google-Smtp-Source: AGHT+IHaEOjL/fZ5phA5h4BVmsyYDdd6nv+88Bsdwqb1j7ss2HLqQpfJIt7Pef33BMhEtKfEFQFDNQ==
X-Received: by 2002:a05:690c:9a81:b0:786:2f01:16fb with SMTP id 00721157ae682-786a4473d88mr25498107b3.26.1762344863667;
        Wed, 05 Nov 2025 04:14:23 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:eccb:aea8:c690:2cd8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691dd54bdsm18323037b3.26.2025.11.05.04.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 04:14:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
Date: Wed, 5 Nov 2025 07:14:12 -0500
Message-Id: <D80AE9D4-EE8D-4CAE-9212-2A592F45AB90@gmail.com>
References: <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 karthik.188@gmail.com
In-Reply-To: <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
To: Justin Tobler <jltobler@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 4 nov. 2025 =C3=A0 19:17, Justin Tobler <jltobler@gmail.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFOn 25/11/03 08:44PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>> Justin Tobler <jltobler@gmail.com> writes:
>>>=20
>>>> I have a usecase where I would like to know exactly which files in a
>>>> diff pair are considered binary by Git when computing diffs. When
>>>> computing patch diff output, Git already omits filepair diffs where at
>>>> least one side is considered binary and prints a "binary files differ"
>>>> message instead. =46rom this message we cannot discern exactly which fi=
les
>>>> were considered binary by Git though.
>>>=20
>>> I have a usecase where I would like to know exactly which side of a
>>> diff filepair ends in an incomplete line in a concise format.
>>>=20
>>> Should we add yet another column to the raw output to indicate who
>>> is complete and who is incomplete?
>>>=20
>>> Where does it lead us and when will it stop?
>>>=20
>>> IOW, yuck ;-).
>>=20
>> My point being that it will be a huge mistake to do this only by
>> singling a trait that is not so special as if it is very special,
>> only because you have been thinking about it too long (the "ends in
>> an incomplete line" trait is what has been on my mind for the past
>> few days, "this side is binary" may be what you've been thinking
>> about).  There are many other things people would want to learn
>> concisely in machine readable format, like "where did the file stop
>> using CRLF line endings and swithced to LF line endings", that are
>> equally plausible as the question you are asking, or the question I
>> would be asking "which commit lost the final newline?"
>=20
> Completely fair. Having a bunch specific options for special info we
> want to add to the raw diff format would get messy quickly and is not
> very extensible.
>=20
>> Perhaps an extensible command line option syntax like
>>=20
>>    $ git log --raw-extended=3Dbinary,incomplete,crlf,...
>=20
> I quite like this and agree it would be better to have a single
> extensible option.
>=20
>> is in order, and the presense of these options would add "tt,ic,cl"
>> somewhere in the output to signal that both sides are text, preimage
>> ends in an incomplete line but not postimage, and preimage uses crlf
>> but postimage uses lf, or something?
>=20
> Maybe the output should be something like:
>=20
>  binary=3Dtt,incomplete=3Dic,crlf=3Dcl
>=20
> or something along those lines. That way we could freely extend in the
> future without having to worry about a specific order. If we think all
> of the raw diff extension modes would only report with yes/no for each
> file we could just do:
>=20
>  binary=3Dyn,incomplete=3Dyy,crlf=3Dnn
>=20
> but maybe we should be more flexible and leave it up to the mode to
> decide what its values can be?
>=20
> Also, maybe this info could be on a newline following each raw diff
> entry? Something like:
>=20
>  :100644 100644 a1961526 e231acb1 M    foo
>  binary=3Dyy
>  :100644 100644 31eedd5c 402a70d7 M    bar
>  binary=3Dnn
>=20

Whether combined or separate, self-documenting output is nice. Separate migh=
t be easier for line-oriented tools? Having to split on commas and loop look=
ing for keywords seems like more work than just processing a line at a time.=
 Idk.=
