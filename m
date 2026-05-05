Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A317A300
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008589; cv=none; b=u7IscZpLC48cyFPK6G3mVfeUGbA/glTsBKrXnU6SBp8eRIf0PJKw+oIQQX2lEwjXXCXJqUXss12+ryw3eJ03TCbmdrj8bMW2TNZfeGx57Lvw+0ocS8tz6AzmrhOIZP+4nd2SO/tfrQOQYw3I7CAB+sPDn5Jg1nbYOI8nL3SLMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008589; c=relaxed/simple;
	bh=oDngaAG+bPc3QSE/r/xQOmov05AMUP1r1zo9PcXBkbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNELeYRry4D/XE9CgTE0k+u/t9Yn1iLcYrfkmmUVCLNk0DaCWUMlVLSjX5lHU3wbWFUDNtLKFQkVwJQlD/BbKNuuNPNpuHGCTaRGozFTgisIu2JSMBEwAI0FeDSkM1jzVqGthTBypDYkbhu+IXatH0HyRXzmQY2V70DnuYjRqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=TpXgbHBF; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="TpXgbHBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778008580; x=1778613380; i=tboegi@web.de;
	bh=3anJ6X2GAgt6FggqTFqw35XiajNRs80NoXtTEVh6Y4g=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TpXgbHBFN87x6LgTbwoYR7TdKbBG66+dvHHZ3WG0Mni9XtPIUHppdO7bMhWGQJ7k
	 rltrv/WGnobzFF8lYGyOoeKhefabOGahWzoDZOVZejmuj6wli9gmNrkREFCZIugGv
	 QngasuDMnfoDO32pORSJWNz2eJQ9nLTAEkE/BlYyaUKc1c0lHDafoQ1cVmHD9/yQo
	 ZTC921bG2deJJLByFp5OlhRbJXnOgWxutefv5+Mh9NQIBUKSq53Zso9AnijgkGLZj
	 K+ElYMZcd2ndCSNu4sfrvJr3h8W5sR/7HPUoW6iZwoLk1+YQ/fmms1EpaC5si775Z
	 bo5nxr7OQ+gDGwgKNg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MmQYX-1vcn5g2K5h-00nSl2; Tue, 05
 May 2026 21:11:01 +0200
Date: Tue, 5 May 2026 21:11:00 +0200
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/11] index-pack, unpack-objects: use size_t for
 object size
Message-ID: <20260505191100.GA12275@tb-raspi4>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <pull.2102.v2.git.1777914508.gitgitgadget@gmail.com>
 <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777914508.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777914508.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:4Zh6fWHVQBptor/Cqh8r4hcou0hxftDxGEHHZJHfRHKGQIkDcXe
 SCd1aFZZ7FjuCz0Lf1ry0iCgeqG2DB2TyuIAJOKpnwNmiQjo1Bp0YWDeksmy7u2EiqPSRSo
 qr0oG5CLv5fkQxYhU29au2jo/cbEh/Vaq178cetp/ZkFojGl2kIKx4c+X+RL5U0CjeM45xm
 tkdDKD0BrLNE5SqK7uYFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GldzN9vq2rg=;DMVs0bkWpw60teU+e+RaxWDSxOp
 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
 8MjqWSopfrlkOEg==
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2026 at 05:08:18PM +0000, Johannes Schindelin via GitGitGa=
dget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> When unpacking objects from a packfile, the object size is decoded
> from a variable-length encoding. On platforms where unsigned long is
> 32-bit (such as Windows, even in 64-bit builds), the shift operation
> overflows when decoding sizes larger than 4GB. The result is a
> truncated size value, causing the unpacked object to be corrupted or
> rejected.
>=20
> Fix this by changing the size variable to size_t, which is 64-bit on
> 64-bit platforms, and ensuring the shift arithmetic occurs in 64-bit
> space.
>=20
> This was originally authored by LordKiRon <https://github.com/LordKiRon>=
,
> who preferred not to reveal their real name and therefore agreed that I
> take over authorship.
>=20
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/index-pack.c     | 9 +++++----
>  builtin/unpack-objects.c | 5 +++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index ca7784dc2c..cc660582e9 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -37,7 +37,7 @@ static const char index_pack_usage[] =3D
> =20
>  struct object_entry {
>  	struct pack_idx_entry idx;
> -	unsigned long size;
> +	size_t size;
>  	unsigned char hdr_size;
>  	signed char type;
>  	signed char real_type;
> @@ -469,7 +469,7 @@ static int is_delta_type(enum object_type type)
>  	return (type =3D=3D OBJ_REF_DELTA || type =3D=3D OBJ_OFS_DELTA);
>  }
> =20
> -static void *unpack_entry_data(off_t offset, unsigned long size,
> +static void *unpack_entry_data(off_t offset, size_t size,
>  			       enum object_type type, struct object_id *oid)
>  {
>  	static char fixed_buf[8192];
> @@ -524,7 +524,8 @@ static void *unpack_raw_entry(struct object_entry *o=
bj,
>  			      struct object_id *oid)
>  {
>  	unsigned char *p;
> -	unsigned long size, c;
> +	size_t size;
> +	unsigned long c;
Does this look a little bit strange ?
p points to an unsigned char (better would be *uint8_t)
then it is dereferenced into an "unsigned long".
Then it is masked with 0x7f
In short: should "c" be declared as uint8_t ?

>  	off_t base_offset;
>  	unsigned shift;
>  	void *data;
> @@ -542,7 +543,7 @@ static void *unpack_raw_entry(struct object_entry *o=
bj,
>  		p =3D fill(1);
>  		c =3D *p;
>  		use(1);
> -		size +=3D (c & 0x7f) << shift;
> +		size +=3D ((size_t)c & 0x7f) << shift;
>  		shift +=3D 7;
>  	}
>  	obj->size =3D size;
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index e01cf6e360..59a36c2481 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -533,7 +533,8 @@ static void unpack_one(unsigned nr)
>  {
>  	unsigned shift;
>  	unsigned char *pack;
> -	unsigned long size, c;
> +	size_t size;
> +	unsigned long c;
>  	enum object_type type;
> =20
>  	obj_list[nr].offset =3D consumed_bytes;
> @@ -548,7 +549,7 @@ static void unpack_one(unsigned nr)
>  		pack =3D fill(1);
>  		c =3D *pack;
>  		use(1);
> -		size +=3D (c & 0x7f) << shift;
> +		size +=3D ((size_t)c & 0x7f) << shift;
>  		shift +=3D 7;
>  	}
> =20
> --=20
> gitgitgadget
>=20
>=20
