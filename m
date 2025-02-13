Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC28227EBD
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448252; cv=none; b=fcHJ7rz84rxKjkj90Z7Qc4JM5EZiPxVmkevp78A0wcFDIDqNeVoJzplGQ1ApUdrU+EOMb8rEUVAevYHn8lu9upENbQtOgk/kv1NvrqLXW7a0e5NZHKQDhB/qdFQ1z0ozsnzkrxX/eFFj4ye1vKO1xzRIE2NHa1g2N/Z8q4tT32o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448252; c=relaxed/simple;
	bh=BTr5J0oUNiqMF92E0ja/h6/dgI+Bqb86qH+VGKhICtw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWoNnX/E+8GTg76KJEYDxybofhqjUbBzWEA9lJQSdutRNFVzbdKgw2bRKiacXUboKxZsE74JggABVQkw6y1XAVaYKoIDJ66eBHln96JP7mJ7AzPzbYkBDwjEcXT+tUN4gvz/uquv061NtKbiHJLuSvpOhHk3VbPW9Mf97ct/mGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=B2/sD8lp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="B2/sD8lp"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd14c9a66so421465f8f.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739448248; x=1740053048; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wCcUcgqd3duXqEZ7ktWDdy7+WP7HsdnFYBxIjeEwpUs=;
        b=B2/sD8lpjarOGs3CVYrC2ZWbsJdmasobB2b47D10Mskv8GyxVfre+Nbgqc4Z09heLX
         yKXVh943i8lXczjcFTu9LF5hyIs58cVJSt37zyy7YegQuNdbRFuDl0yQ+w+NqdWJBHtX
         dAecWW58WpbSapRSkYAjSI5iM20WmTRx6a24A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739448248; x=1740053048;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCcUcgqd3duXqEZ7ktWDdy7+WP7HsdnFYBxIjeEwpUs=;
        b=rU+PTDp8F3MBpbXFLJq496AzYpNHbREQKa/6HedULXlPnLzRcO2lrl3M5eorOPkZcL
         VRyZJgQ2F4e124Q2hOphatyrB/vPN+SrWy29NQy+rATz4XzHtDq1iMu2yc0GkdPcNWDw
         gUZdZSI8950aa/2LzCYrQjbAwzfQTfv61dg2J4Nh0UHJzzJbJSmWJxXjKXLrmc6Q5Vqk
         qLDMss/vnH3vjOkTG4CIAbPx76ZFkn0UfOxGk5fpqhY6kphZQm/UeCT4y9r4q6IfXvim
         dDPeTR1v8RHSEPZKKBSd5u4yT8HDuPhA3BeGWE2LHQpkP83MW7QBCdLPemY7InfM1wJx
         KRpA==
X-Forwarded-Encrypted: i=1; AJvYcCVrvnZUOqrB2V/V++zadMlS1AwZjiY7UAZ1/WWu6kPETDUfAk0h7ngZXBUAgRihOFDWhNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlnzTFPgSyL06zuGIc4YSOHuR+XT31lNKfz8eB1WH6SOryTy6e
	TrY/qd2JEkbTDwgvy0k2l2aRjaOJ6gb8X/YV03K4iZd/5ZYmMv58DgcFucwCWp4=
X-Gm-Gg: ASbGnctvi5VHWNIjaxHhVUxWxM3jqiDSGxx6My7oW9HdzEj2KkCv7tni6qbDqbkXCiy
	nd4AOJx1hgI0fvx9LCzUKYVT9fC6IUb/hp83FpaBefsdpGBrpWw38KwK5IgeQLkKTGEUnzC1SER
	fXNvMO1XLtUlYu+xLWa18EcCztEO6MXnv3Ce5hnX1Nj5u4ops5tMXk1HzwCuF0a23nXoN9JCVc9
	Dc36wkqmisUKMfcky5hmEHGhSQGC1TDnNM0ibjLl58heZx3v/MQFmDXir88tepFOoBpGkdzW5Nl
	IODPcErN2iZ3MOXtphIgKNnSrjFohQWLQnCKzoTD9RJ3IDOUeA==
X-Google-Smtp-Source: AGHT+IH7lCgdqhpUpjWMGLfav2H+wtbi6tRcT2FfUS2f4ERA+YyxKJfvb8dGNUk2ZCubsPdlv3AK4Q==
X-Received: by 2002:a05:6000:4027:b0:38d:e401:fd50 with SMTP id ffacd0b85a97d-38dea25a83dmr6451686f8f.6.1739448247860;
        Thu, 13 Feb 2025 04:04:07 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65dfsm1714472f8f.64.2025.02.13.04.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 04:04:07 -0800 (PST)
Message-ID: <1c69cee93c7edf62579d8eb3f40b0a98f3a5d075.camel@intelfx.name>
Subject: Re: [PATCH] rebase: add `--update-refs=interactive`
From: Ivan Shapovalov <intelfx@intelfx.name>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Alex Henrie <alexhenrie24@gmail.com>
Date: Thu, 13 Feb 2025 16:04:04 +0400
In-Reply-To: <8a259585-97f7-4756-a126-17a982da58d7@gmail.com>
References: <20250210191650.316329-1-intelfx@intelfx.name>
	 <1279671f-4063-4347-b153-9f6ff079bd77@gmail.com>
	 <f689c263ead8104ec42f63f1e9ed10350a27ae1d.camel@intelfx.name>
	 <5b605c3e-ef6a-433a-9637-1e8f277dfde9@gmail.com>
	 <f0fa961084281b1d5948f59c42cf0c87e731d9bc.camel@intelfx.name>
	 <8a259585-97f7-4756-a126-17a982da58d7@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Nh4G6sgEugtHDvGOVS+a"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Nh4G6sgEugtHDvGOVS+a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2025-02-13 at 09:43 +0000, phillip.wood123@gmail.com wrote:
> Hi Ivan
>=20
> On 12/02/2025 17:18, Ivan Shapovalov wrote:
> > On 2025-02-12 at 14:26 +0000, Phillip Wood wrote:
> > >=20
> > > Thanks for the explanation. So this is about copying a branch and the=
n
> > > rebasing the copy without updating the original. A while ago there wa=
s a
> > > discussion[1] about excluding branches that match HEAD from
> > > "--update-refs". Maybe we should revisit that with a view to adding a
> > > config setting that excludes copies of the current branch from
> > > "--update-refs".
> >=20
> > This idea stops working once you have a bunch of interdependent feature
> > branches (consider two branches work/myfeatureA and work/myfeatureB,
> > with the latter based on the former, with each having two versions as
> > described above, and then you rebase work/myfeatureB-v2 from v1 onto v2
> > and expect to update work/myfeatureA-v2 but not work/myfeatureA-v1).
> > Excluding branches that match HEAD is a very narrow workaround that
> > only fixes one particular instance of one particular workflow.
>=20
> Good point
>=20
> > I don't understand the opposition, really =E2=80=94 in my understanding=
, an
> > ability to restrict update-refs to interactive runs is a significantly
> > useful mechanism that does not impose any particular policy. It answers
> > the question of "I want git to _suggest_ updating refs by default, but
> > only if I have a chance to confirm/reject each particular update".
>=20
> I'm not opposed, I'm just trying to understand the problem and see if=20
> there are synergies with other issues people have brought to the list in=
=20
> the past. You've convinced me that supporting=20
> "rebase.updateRefs=3Dinteractive" is worthwhile but I do not think we wan=
t=20
> to change the commandline interface. I'd much rather reserve the=20
> optional argument to support filtering in the future so that
>=20
>     git rebase --update-refs=3D'*-v2' --update-refs=3D^not-me-v2
>=20
> would update all the branches ending in "-v2" except "not-me-v2". We'd=
=20
> want configure any default patterns separately to whether=20
> "--update-refs" was enabled by default which means we can add "rebase=20
> .updateRefs=3Dinteractive" without boxing ourselves into a corner.

Makes sense, that's indeed a better use of the optional argument.
Alright, I'll send a v2 with +stylistic changes and -CLI changes.

--=20
Ivan Shapovalov / intelfx /

>=20
> > > Maintaining multiple versions of the same branch sounds like a lot of
> > > work - whats the advantage over merging a single branch into each rel=
ease?
> >=20
> > Different people, different workflows.
>=20
> Fair enough, from what Junio said it may actually be less work anyway.
>=20
> Best Wishes
>=20
> Phillip
>=20

--=-Nh4G6sgEugtHDvGOVS+a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmet37QVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6d+egQAK2ex9vQ691Y6zBXn7Eo2bjZqk4V
V4+IOTmS5IfkqTWHff2C48T8qALib465xYhuLkDddLzzbDJGgugrzd1gx3sU/a+4
Ozz5iTZ+85F0MMRMs/xHEwvT+p4Yce+WOw8UDg4yLVJOIahPeYIfO76CB/s7lxW/
lwpWINyhv5J5+u7vr/9LsXMH1XBo37SIc1fGCCBBtm7oH7lRx/oAQKi1ct1vp2Vv
LTQZ+155JUxOk7HMBS2upU4FX+rp//lqOCBSBt6whhqvfQb0M5HDZ0kiGC+JbaXQ
tXg5N5+fIdHPzA3TRlNCXmI8xuJgVEbGTcW1znG91uFfRy3Mvj5xSJ1lpA2qg6AO
A/uyl4GiP3FQwq1UGlTqulsL8gSAy/n7VM1OjLcqkBy7L49vYGaqzD7Ye61KkrvT
mtT3Rv2ZW0N1sU2gbP5HVBwBPGp7AZ/7imJJp+FymdxVV5t5jWZQjU8la0EYlEJ4
aTBx19qUh1odxbrMahHz8v2euvHQTAUpYWLCEU7VD2kRsftEKHshGzUS6NBur2K4
UtzpeLXm9yc8UJSPHcqaUL0EdV9/EY4jTS99EZmiXc6GVXoa0DtLUQo42Vh33bol
E5MbM9SJZwfzr8H+27mhTzG8kAPx1F0T8K0jr02gVM8XMzL7ObbH1gUpS8DyG2jl
N5CmrWi7taPwn/1T
=C2+Y
-----END PGP SIGNATURE-----

--=-Nh4G6sgEugtHDvGOVS+a--
