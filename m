Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D04A3E
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 01:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314510; cv=none; b=T/GWKpg8NJjhBZjB4dXT6sYXP0Yph6n5PlhMz7CJNrIL9+LfQSpQlfsmLd+yOD/VtQltsXIgLOpsP1tiWOOlzXUkIx5tc00gXNSZM/h01tdLeve1fWK0BZqFKQrpnSjLhqwjyGjF6PJUfJ+xxxZgand1Ngmk8/BIfG09gyOghho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314510; c=relaxed/simple;
	bh=Xny++cVjYweqgUN0vuGvOlSdlLjenzAuOaMVfph3w8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EnFKTzcTuyQMnWyPYOTou9n8sAZ4aNxy7DgUkxgtpz05iPb4skD5e6TfuVF7luxItKwl86fBpxl4fDLVhI8aQ5uILE89PNKDKH3A4NdQUOzNHCuFPROeS493kprKvIFgjPcZ2EecZrlrkyX7McrbkQnWRJsebubc8PjwhsBoa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpvdlAbo; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpvdlAbo"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9aec89347so33197985a.0
        for <git@vger.kernel.org>; Wed, 25 Sep 2024 18:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727314508; x=1727919308; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS9mPGycBr2cQr2sELhISCQQ1jdxeMVmRaU7Q4LpLME=;
        b=ZpvdlAbo6CBevttc8LKOPI/IUwRoWoxDMt5KX6Ohq2Al6+u4e87GVhRgQ7+Oh0KwLD
         XQPTgOUmluRa15HbRVPN1dEm2Smc6qSdyTd0SA05CYeFX3yUMj7TVW2EG6YZ685Otj69
         5Z7PA/IIfiUM1DVWcTeAVSV3vTBkc7ZA5DGKcLIpCJmWwY/r6dqGUD++OAg4ila01EZd
         YeJAcwv1gT1Yv6aiHmQiFYYsMI/ncIoVXhck1ySqPwv13PpqEIXr9jOw2O3UZsftf8DE
         4mKgrFwlnre7npANeU5wGfkXV1QBLbziXMAn2/vYKZzG6fogPSsY+00v1xzx6w2m+Noz
         Zu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727314508; x=1727919308;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MS9mPGycBr2cQr2sELhISCQQ1jdxeMVmRaU7Q4LpLME=;
        b=fvR5dMPm/2n7Qlk4I3BlCFAh81LXit3ga1LnHH6OHQmzjjGX3/xyBRxRsGvOiMjHZV
         sGh02JAA+jrHrXSzou4RG3r5GYczDVTQZetjGT1UhXbWJ1AT88FLqBAnsXajKCH/fR+M
         OWWuINVmHox/sgQVrIJb7ezIftNuxvs0O+WSEN7KNKnwRu8biQAaUHU3M8zzBIvykNPd
         PnEwxQAQx4iJ63j5h/mVwoXN1ydu1dYElNjFUYWI0pZyHRN8IGQfvaVBKvO8H6mCnWuE
         Y0IoMhF42hmAGRneBYq7RNS3PVKvWBnZvlyqZqTzk03XYZDoI4tRKOcH6Xxdgj2Otrne
         SCuA==
X-Forwarded-Encrypted: i=1; AJvYcCUIYcm458IVNsAddHrCV+44M75n+LjsONIbQrKaBVlvbsiqk4Jzx182FeWaVAPquqztY68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfuoHlvT/XBNZAsfk+mwZp7RRtLEdCfKZ6o86K/dOUlxaxQpDL
	gAascalvYjw5EXNT2GZnpfdPmFTlEz6J+JiRTWb70epcu7ORZ5L9SdyP4A==
X-Google-Smtp-Source: AGHT+IEZ2xuBJyybAuTc7Nn12qOFVmiY8Egk2xBhlKfL5n6LapwXRJiNLRY7J1apt/Cr08U/PcSI1Q==
X-Received: by 2002:ac8:5794:0:b0:458:5716:fbd8 with SMTP id d75a77b69052e-45b5def1c6dmr81833011cf.32.1727314507610;
        Wed, 25 Sep 2024 18:35:07 -0700 (PDT)
Received: from ?IPV6:2603:6011:3f0:6f00::12ac? ([2603:6011:3f0:6f00::12ac])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b526b0eb9sm20902451cf.94.2024.09.25.18.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 18:35:07 -0700 (PDT)
Message-ID: <6e3ac135-8357-4d2d-a49b-de7f1ab4da95@gmail.com>
Date: Wed, 25 Sep 2024 21:35:05 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ./configure fails to link test program due to missing
 dependencies
To: paul@mad-scientist.net, "git@vger.kernel.org" <git@vger.kernel.org>
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <xmqqwmj1t0hp.fsf@gitster.g>
 <5bd2f41c92a00f7799bc543e229b16fa7a473760.camel@mad-scientist.net>
Content-Language: en-US
From: Eli Schwartz <eschwartz93@gmail.com>
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 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
In-Reply-To: <5bd2f41c92a00f7799bc543e229b16fa7a473760.camel@mad-scientist.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------E8qeTfrVHDNSbVEBqePlzhEH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------E8qeTfrVHDNSbVEBqePlzhEH
Content-Type: multipart/mixed; boundary="------------NE0ulyirkaaRkuLYusV3H1dn";
 protected-headers="v1"
From: Eli Schwartz <eschwartz93@gmail.com>
To: paul@mad-scientist.net, "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <6e3ac135-8357-4d2d-a49b-de7f1ab4da95@gmail.com>
Subject: Re: ./configure fails to link test program due to missing
 dependencies
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
 <xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
 <29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com> <xmqqy13oa8oe.fsf@gitster.g>
 <ZvKsH1Ct-YwBPA_f@pks.im> <xmqqwmj1t0hp.fsf@gitster.g>
 <5bd2f41c92a00f7799bc543e229b16fa7a473760.camel@mad-scientist.net>
In-Reply-To: <5bd2f41c92a00f7799bc543e229b16fa7a473760.camel@mad-scientist.net>

--------------NE0ulyirkaaRkuLYusV3H1dn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9/25/24 11:33 AM, Paul Smith wrote:
> On Tue, 2024-09-24 at 10:39 -0700, Junio C Hamano wrote:
>> Our dependance of heavy use of GNU-ism in our Makefiles makes an
>> argument that make is the common denominator a fairly weak one, so
>> the single one that eventually we use does not have to be "make",
>> but it has to be something available widely and easy to learn.
>=20
> Regardless of what one might imagine :), I am not advocating GNU Make
> as the perfect solution: it certainly has downsides and disadvantages.


:)

I've read your article about why people should use autoconf!

(By the way: I had a bit of a... chuckle, when I read in your previous
email that as the GNU maintainer of Make, you build lots of projects
with Make or CMake, but not with GNU autoconf / automake. I assume that
was just bad wording?)


> But, it also has benefits that should not be ignored: for example, it's=

> highly portable and it consists of a single binary that can be copied
> anywhere and run from anywhere with no other prerequisites or need for
> any setup or privileges.  Also it's extremely flexible since it just
> runs shell scripts.  That also makes portability much more "do it
> yourself" than other tools of course.
>=20
> Meson is portable, but that's because it's written in Python: that
> means you have to have a Python interpreter already available
> (currently Python 3.7 or better), and the ability to add new modules to=

> it.  Admittedly this is not a super-high bar in 2024, but it's a non-
> trivial requirement if you're trying to start from scratch.


FWIW: you don't need the ability to add new modules to python, you can
run meson by acquiring its sources (tarball or git clone, either one
works) and running meson as

$ python3 mesonsources/meson.py ....

No installation required.

You can also make a single-file executable using the "create_zipapp.py"
packer that ships in the meson sources. It uses python's ability to
execute a .zip archive by expecting the root of the zip file to contain

a) the file __main__.py containing the program entrypoint
b) any additional modules that should be available at runtime

You do still need python3, sure.

There are a few different tools available for creating single-file
executables that don't require a python interpreter. What they do is
create a self-extracting executable that includes its own python and
internalized support files. Meson uses https://pyinstaller.org to do
this in order to create the Windows .msi and macOS .dmg installer
bundles without requiring the user to install python. I've used it to
create Linux executable installers of meson too -- but I have no strong
feelings about linux executable installers existing, so I only bother
doing so in order to run tests on the packing process e.g. when I want
to verify that the Windows installers are ok without actually running
Windows.

It's not that hard to build a more or less standalone python that only
depends on "glibc from CentOS 7 or newer" to use as your base. There's
an unofficial project that hosts some precompiled versions at
https://gregoryszorc.com/docs/python-build-standalone/main/index.html

Single-file executables are alive and flourishing. :)

The same could probably be done for other operating systems and not just
"the big 3", but I lack direct personal experience with deploying
software to such systems so I can't really say for sure.


--=20
Eli Schwartz


--------------NE0ulyirkaaRkuLYusV3H1dn--

--------------E8qeTfrVHDNSbVEBqePlzhEH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmb0ukpfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDYw
NDExMzA0QzA5RDM2NjI4MzQwRUVGRkNFQjE2N0VGQjU3MjJCRDYACgkQzrFn77Vy
K9ZRXw/8DAulAUqYaXqRyLPMHjDM6hDtyGhMjckumv0G/Mi5OU7AdrwYe4IRT64h
dr6Gb2f03aWPQaf23P/zHm1R1WePNUKhhIveFzR7C/2wodPCEClw42KJXgsxfu8R
4xvNW1B2CpD9nDS33Otw8zOljcgfrqEQ7nO3ygIHYkIZlJHzSjWpJsS7AcY0xbGO
9DpsjElpUAXn74DonUUF2kGsMuug+J45I4NbUMjVAmrmW/bFdBkBqPEQcxsNosfp
ldoCDGPh2JnjrRN6fV3NO7XVu0CV/pXfCRQtI7uiOdb/oHoY1XBvyFRHMcyR4z50
T7N44USsC4DHow5WX6mtMZzGHunNQUKTAnL6YqfO5VnAvv1segFX1BVvFbpc6pUG
3YBDLp6MyrbF6hIa3ZogEdmQVsrHFvJvy7/GKwhPOU6nXjn2PtY5g6BwTOfMba7H
74CF9Ps8MEE1Adze6nn5RiaJfXgpBkC+fBlgDNxGmR8Sb+eqcGEn/7kU9yCyJKSY
cqSDUElcS5rvOjowDw2RQ5DUUa1Mgn0RxYuINCYAJAMik2DeguB/VmIUqDcVgz8G
iKtMJgqXKlqJ8oFzH2wRjTUt3i5IJxmKf2CmvpaZ4AY6vBxFr0jOeBmIGIGuxrjg
HgFCcZEi3ZeYHESCuSXXVrQY076ZpiyaISD9ImLOAMwdDq6wQ1Y=
=DJyY
-----END PGP SIGNATURE-----

--------------E8qeTfrVHDNSbVEBqePlzhEH--
