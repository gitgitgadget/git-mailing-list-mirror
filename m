Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4BE27144E
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159838; cv=none; b=iqMtmNd+fbhijTVSkvh9Hfa24Kk5bvA2wXlQ3vzPQB8c1K41mM4NGLdRxKVuqQngFUTYMk5VxVy+ycHzFGLQD+WNtOdekvg5aj0BW23oS3hTF/gI5eoi9exE0L8y4bIiEgiliBpUotMktX4YhkzpELDYhJ6yIHQ1j7dMOjF/QVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159838; c=relaxed/simple;
	bh=SPpyG9/C2NIdA9KozZIGrr0SiNYQvyfls/+SvWHTOlQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEeWP//US6ouebJqjRBbNYZKoFXNIexPvjEZS0ymTCNEJOj/QGgYlZeHotppi60cH4DUUkXCOFj+smbF4gHy/SKvXyb/pNTIORKY1ACbTrriKd78pKNhnKsEQV5jSQtZnbjuLvNEi0c5R+2LfA0qo7na+zbJ1cPljJ1B+6QEkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW/f4dgr; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW/f4dgr"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso1098558137.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762159835; x=1762764635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HdgFkR7gE/Z1u0cXrOm5DXI2TOxJTBzZVS7MiscC4JE=;
        b=lW/f4dgrG6x38SYD/TpUu2vdp2GEOmGa6GCK77zkDiLTPfKSwmSYyHOZ20Bhd5RgJV
         CAOfvHb3TfGZBpPSRCy6Sqoy4wDBSilSqvQHfpAAlbMdoSQ1/LtC77Zt/nJ1Zylw5vaa
         sX/WqG3iABHJ2oe0ppxWDQsGazJ6zgWoezhpq4DLlWL8B7AdwXfMRNMVESCQ4F0xAB3A
         8AU2BKEd62G/PVt9PHYEja21Nw0ZGvH/+88hOm9p13dgdQ/g21iiUweD8GkhsxOcfsi7
         w1uRTa2c+a5a0GxsFvS7xnipUs0by9DEcKctvydEzdxQQWXFJozL6aKY7O8T3hfOLyYf
         BseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159835; x=1762764635;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HdgFkR7gE/Z1u0cXrOm5DXI2TOxJTBzZVS7MiscC4JE=;
        b=qRrjkBeX6LS8AN89y36w3IFJyAnNmISjsAhsg7VMWpFe/sfpvRPO1aeSgrZeu1tdZV
         x0oIMznjLsUnfuYlYYbTbhk7euZoSfkrQDXyL7FsCEARRVl+eMcgmEgbQ+DWFwxcY8cV
         bz4/02Ua5QaawrpdWQMIXeShzGeoCoS+qAMuk2zLPhvdNQ/5FzEiKFJW9TZhpCFXjUiQ
         ZPaI+6we0X7iLx+UCTuiKXit9ItVn1fuDZjNv6VHmXSSA2W33HjvelV5hpnDoHSSEAQ2
         mnnPS0YHeGKQCKZO1tDPpKjbTqmr3uCLXwm9lSrw8k8qZkts4TewszIS3665+Ro9Sjk4
         ijPw==
X-Gm-Message-State: AOJu0YwQsVwrA3vZDXadDkl4gdLyngUu2rTOA+RfTL9KD55Y8VJFUn2m
	p0GhyOsi81+X4DKlPUvOFn7hrKDmnB+4oM2GJ6xTt1Ax3kWPPKXXH05eindT7q+HD/AOnIPrYU/
	1/wXUBRfvlov3wQ2qObnUcn8NdQyf6hM=
X-Gm-Gg: ASbGncu1b/CabFqxznTBS9G4U7gz1qGG4mDWz32cZAPVpgUgfsXfQw5zBjUPOqOwurS
	669HBrTiQl9Fsu3Mv3sAVtCMheXUnNRoN3T2qai9OGIKIeAZt2ix9ZJaFNvcQg30ef1v71WLAB1
	PxnT1FFfThfmcFrhcLBR/LBFEOkjTCPtkthnCBRRM6n377i40oZivK0QhC3OzKOMt0Ag8179tqx
	hSrknRLiHOWgF8FcvdLbbDYqJaTMe6YZKc/dwnbpW79avu4H/EO0VENNRfwS/YRdISu3LMC3X3i
	EzX6Xl06kKVilWl68+1ICiDU92Y=
X-Google-Smtp-Source: AGHT+IEWxSc0Vms6n9AOwvLiJTfwjiLn26jTdZ0N/Vzsf4CJ42xrI40e1UlcFoB7z04Yd3jmOI8BoUZywrPLgvh498w=
X-Received: by 2002:a05:6102:5128:b0:5db:1e4e:6b04 with SMTP id
 ada2fe7eead31-5dbb02380b2mr3712724137.18.1762159835250; Mon, 03 Nov 2025
 00:50:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 00:50:34 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 00:50:34 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAB9xhmPAe1z8wqWnbpPuPE=y=nuKMsGG3_bk+DkGmXDfshaaiA@mail.gmail.com>
References: <CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com>
 <xmqqcy8418me.fsf@gitster.g> <CAB9xhmPw6P1J2a3P+btUT1chhNQrhcx3pSkq+vqZbhFhCqcX9w@mail.gmail.com>
 <CAB9xhmPAe1z8wqWnbpPuPE=y=nuKMsGG3_bk+DkGmXDfshaaiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 00:50:34 -0800
X-Gm-Features: AWmQ_bl8UL0vSN5bB5VfBryjgenrp0eZrFrDNleEranb-YtDUAuFcWRQqGemGC0
Message-ID: <CAOLa=ZT3abHfkNVzwpJyGEhvm5dijdaKSCkoEFgQuLhvab-=aQ@mail.gmail.com>
Subject: Re: git-2.51.0: Fetching tags does not work
To: David Bohman <debohman@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000498030642accf1d"

--0000000000000498030642accf1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David Bohman <debohman@gmail.com> writes:

> I am able to reproduce this locally using a bare main repository, a
> local bare clone of it, and a non bare clone of the main to insert
> revisions and tags into the main. If you move an existing tag in the
> main using push -f and then try to fetch --tags into the bare clone,
> it fails to insert a new tag into the bare clone:
>
> % ( cd test2.git; git fetch --tags )
> From /private/tmp/test
>  * branch            HEAD       -> FETCH_HEAD
>  ! [rejected]        stable     -> stable  (would clobber existing tag)
>  * [new tag]         v5         -> v5
> % ( cd test2.git; git fetch --tags )
> From /private/tmp/test
>  * branch            HEAD       -> FETCH_HEAD
>  ! [rejected]        stable     -> stable  (would clobber existing tag)
>  * [new tag]         v5         -> v5
> % print $?
> 1
> % ( cd test2.git; git fetch --tags )
> From /private/tmp/test
>  * branch            HEAD       -> FETCH_HEAD
>  ! [rejected]        stable     -> stable  (would clobber existing tag)
>  * [new tag]         v5         -> v5
> % ( cd test2.git; git tag ) | grep v5
> %
>

Thanks for reporting back, I missed your first email.

I can confirm that I could reproduce this too. I'm currently looking
into this and I'm certain that this is due to the transaction reference
updates. Nevertheless, I am looking into it and will come back when I
find the cause.

- Karthik

> On Sun, Nov 2, 2025 at 4:47=E2=80=AFPM David Bohman <debohman@gmail.com> =
wrote:
>>
>> I am sorry to have to bring this up again, but I am still occasionally
>> seeing this problem with git 2.51.2.
>>
>> What is happening is that I am cloning a repository as bare, and then
>> later I try to fetch the new content including the tags:
>>
>> % ( cd bind9.git; git fetch --tags )
>> From https://gitlab.isc.org/isc-projects/bind9
>>  * branch                  HEAD       -> FETCH_HEAD
>>  ! [rejected]              stable     -> stable  (would clobber existing=
 tag)
>>  * [new tag]               v9.18.41   -> v9.18.41
>>  * [new tag]               v9.20.15   -> v9.20.15
>>  * [new tag]               v9.21.14   -> v9.21.14
>> % ( cd bind9.git; git fetch --tags )
>> From https://gitlab.isc.org/isc-projects/bind9
>>  * branch                  HEAD       -> FETCH_HEAD
>>  ! [rejected]              stable     -> stable  (would clobber existing=
 tag)
>>  * [new tag]               v9.18.41   -> v9.18.41
>>  * [new tag]               v9.20.15   -> v9.20.15
>>  * [new tag]               v9.21.14   -> v9.21.14
>> % print $?
>> 1
>> % ( cd bind9.git; git tag ) | grep v9.20.15
>> %
>>
>> As you can see, it is getting an error for one of the tags, but it is
>> also failing to record the other new tags into the repository.

--0000000000000498030642accf1d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2a4affc6f2ffed8b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSWJOTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK1cxQy80bWtYVmN3UEhLNjB3YWdOUmxaeEhwenpGUwpjTlFxeW9jQWti
UnQ0SU8yZW5OTjIxWEhXTU1KQWFTL21ONW96d2lZRWhIeVdyeWRXYUtWUzJCb1FTRTlMQTBoCmpR
bmpvMTRLaiswcGwrRXcwTkk1aDhTdldUdVVIeXFVOHduNjB3aGdMT1lnYTNYT2ZCc2VNNDNsYzh1
ckh2MVgKZTNpZzNVSEVmc3h2Y0g0OUs2TlY0MTczeVo2cGYzWTVQbEtoUG40K3dEekp1M2FmdFFj
L3RILzgvTmNqeDE3TQpFNjR5NkNJaTBqTUo2cXowT3A4L1IyaEx4ekRCMXVGRkVoUWcyaWdqVXVD
M3FEYk1GaHpscDZBT0NnM250aXJaCjk0VmJlOUtqajVKSUtadWhmY0JQQ2tPSGVwZ0pLUFJIRmlk
S1NxU25TbFVEVEdkemk1VDVGUzR6M3o5UkM2QTUKSWhmaGdFbHp4TDBpNU9wUUgxS1ZGVkJ0MXFl
bjdnS0R3VFJVVVZZWmZ4MVZxaEFwcC9CTUFTVW43S0hjZHpGaQpRWTJNNnNWSXViZTErQXNuWUZu
U29rV0NUZGxkRUdrVjM1VWNFdXkvbkl2UDBOZE5TNllUY0Z2cmEzL3JaSStiCmFEWUtmWkFxa2ts
TGNyOFowSHV2VEt5Tm5qaWorNE1NTnhtZ1lBOD0KPW5MVW8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000498030642accf1d--
