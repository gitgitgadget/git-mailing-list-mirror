Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC05845945
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010686; cv=none; b=Ud2PpWlkZCvpFpQduZDY+7PiJJMhk3tLOqyQt0rBG68QA5TLJZlTyzsUg4YxdMaAHB0OXq4NlBXx/EqJh8mXge1WGVTDobyx4h17N6QBKuj2Xoe0I1JuI0ltUHYdJVh90orw7BkL6b8PXqBIvRtAU9skcrbpq77RS4Enl4TwnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010686; c=relaxed/simple;
	bh=S8YEEUjli7gSP5yL6EG14CidTtvKOuCECBXt4pxY1Xk=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=MWFnByMZELSYcabJt5/zVRm1jF8mCWPScz+31fbpIlV7+Hf74R90QFAKlKoBdKwAqEYzl4Z2jdsbixpGsbHOE/ysW+6tc6u6caZvBNSmN9QOba5p0rLP0tcF7LQG7lGzVftmRC27Io9YftfPUU2ymgIKRqdXaZi1RlbY4qjCu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=fsMedUDU; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="fsMedUDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=+5eG4aQ36eho2K9NmDNUT+yuibqS7yYpaW7uc65GgNY=;
 b=fsMedUDUun0YLjh1gCaJvahuiJ42jBuXl6UfUyhbkyAsffsv3nwqIyuBdI99JvBP+GDnLNgGMaYd
   xfBoOK1U8QgQGfhwLKzmzbymxoel792bmB3BDy/eXp/VlvLNm5YBWBXoeJ/DIxCWntdCPQXQ0J+t
   z11bZVLE/A1yvlKKspz1/jF+erdXjEDqJJ8ge0qKMXNPE7XhHzNTZQa2Yg+pXXRc3rlf/amoCcMQ
   Kj13kbnCJdq9a/D2Kw9rKC5Kgpbwzw77uQuv+SMYfB2Bwolc205ntwTlmSYsQ1CNnM+Pb/X/uHwI
   p1IvlqrsK+74qs+SiAujIGouBHW/EEeZwajeKQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN600CS8ZZU67A0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 19 Nov 2024 10:04:42 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 11:04:21 +0100
Message-id: <D5Q2JDB367NI.2N8AQFKUC2533@ferdinandy.com>
Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-3-bence@ferdinandy.com> <xmqq34jnerlm.fsf@gitster.g>
In-reply-to: <xmqq34jnerlm.fsf@gitster.g>
Reporting-Meta:
 AAFxfWV/iJ+JjdyZ1bd7q+7AaNrqXyCOts7+CeKRtDckYqY8pIS2Zs+vSyERepBn
 7erBk8MphuFG/O4bHSaQprbUhULVE2IoO5Fm965Xu4/6Jf2I859P4gxXmmUEPe3Q
 UzOlrYZwplEZSULMpHXAi6GyqNfNguVD6ITgL1m7e4HMXmUYw8j/a5XfUrt9aZfi
 QuNkBtuAyHOYB2tEKasWNwVTV1pQuaUdHA2fHz7eRarg5b1F9Ei2UIDqutZEUGEa
 9n/WnvWcEbBzq3//GEtobZGZuRPMNQFWw/w26zFb6YKvGsMVHtyBLkvOHjj8M438
 ZOHSyE90N1T3B7YObUgVAfmBPTYNG1kd3/tGGwyNR9yM5k6uDV/GVZoFrO9+Jkif
 8aCVGBOH4o7WUbjSCjz2ea8gfuwIr/1OJHE0gF1WbffUakgf9M8VexD1RNv80YW/
 Ud1k8QTqN2d48nggscjQTgTX/KfT2SiWKRYGIEd2ympGfp2A1TBpTKiV


On Tue Nov 19, 2024 at 06:10, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 38eb14d591..60cb83f23a 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -830,7 +830,9 @@ static int reftable_be_read_symbolic_ref(struct ref_=
store *ref_store,
>>  		return ret;
>> =20
>>  	ret =3D reftable_stack_read_ref(stack, refname, &ref);
>> -	if (ret =3D=3D 0 && ref.value_type =3D=3D REFTABLE_REF_SYMREF)
>> +	if (!ret && (ref.value_type !=3D REFTABLE_REF_SYMREF))
>> +		ret =3D -2;
>> +	else if (!ret && (ref.value_type =3D=3D REFTABLE_REF_SYMREF))
>>  		strbuf_addstr(referent, ref.value.symref);
>>  	else
>>  		ret =3D -1;
>
> The ref.value_type can be either equal to REFTABLE_REF_SYMREF or not
> equal to it, and there is no other choice.

Ah, ok, I didn't realize this.

>
> Wouldn't it be easier to reason about if the above code were written
> more like this:
>
>         if (ret)
> 		ret =3D -1;
> 	else if (ref.value_type =3D=3D REFTABLE_REF_SYMREF)
> 		strbuf_addstr(...);
> 	else
> 		ret =3D -2;
>
> I found it curious when I read it again while attempting to resolve
> conflicts with 5413d69f (refs/reftable: refactor reading symbolic
> refs to use reftable backend, 2024-11-05).  The resolution has to
> update this part of code to use the new implementation that asks
> reftable_backend_read_ref() and becomes a lot simpler, so the way it
> is written in your topic does not make much difference in the longer
> term when both topics graduate.

I'll update the patch with the above,=20

>
> IOW, if we were rebuilding your topic on top of Patrick's topoic
> that includes 5413d69f, this part would read like so, I think.
>
> diff --git c/refs/reftable-backend.c w/refs/reftable-backend.c
> index 6298991da7..b6bc3039a5 100644
> --- c/refs/reftable-backend.c
> +++ w/refs/reftable-backend.c
> @@ -920,8 +920,10 @@ static int reftable_be_read_symbolic_ref(struct ref_=
store *ref_store,
>  		return ret;
> =20
>  	ret =3D reftable_backend_read_ref(be, refname, &oid, referent, &type);
> -	if (type !=3D REF_ISSYMREF)
> +	if (ret)
>  		ret =3D -1;
> +	else if (type !=3D REF_ISSYMREF)
> +		ret =3D -2;
>  	return ret;
>  }
> =20

but I'll save this as well, I would not be completely surprised if Patrick'=
s
topic makes it in sooner :)

Thanks,
Bence
