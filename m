Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1BC1C1F11
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732011084; cv=none; b=cJ1UxxSdoO5RHu5fI87SeTSdPdD6jBcshIi+bO6ovZLn2ZFq7OQtE735w+3FDT+2sx2mT6H7LAQL2Qb/yE2p0MKtatxD5aSNdeuajROXe8vIcWCEcnchWoGh6xKe1L2DwSmZmGfR8RO7H4EUP7BhSjp08Tito7f8Ypq1btKcLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732011084; c=relaxed/simple;
	bh=IqTsuFk3KydyFhc8zDTIjpRYYP1dC4KwhpUyx5TFrr8=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=g530vKiyJsSZz1pppYXP+TdvVqeblL1AMFh6vNQ6GI9Rw24p2dvMJ9l3ghxnBOE1bo9epu8gGQrkwRC+E3ITKZL2OvWysrQLa4NLW5C677e6BxAXyy+oA03CXyJzRP49q4e+2Axq7ChaSBV7AQE/crWnuxd8Xz4JCrKFurQ56Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=pziumPCL; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="pziumPCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=U5E1aIA7GiBHusap++m1yaIDIBS7kIl3N5EuT5/IVPE=;
 b=pziumPCLgU4wpJZBE9d44/3Vkq+UAW/duf7yMr5BkwWmy2vrvqVELsK3K2uxkAPAFf4js+z3xNTP
   Wsqa77PQp/g9jGHUxgzFy+VsaNozbDxyfoSOI4TsfWJF6fqMOTDl8atvSnE4ARKz9CROHNgQGW8c
   WQ5VBKah+IUXyYmSEo9YtXB4OckeDSg8Lu3VfcAMDBoz5O1Er9dKCs+GADbBD3LPLDCT5G+pI4h6
   MwBjAsi+sNUzLVHaYfTLufyiVUXf1XGDiwzkVuw9jd6lYp2QP+UjXBxzFi4aVO5EYAw8sIdEo2Ct
   0HIlwbS8d3/O3e09k90N2HjqS0ChSzfnxNnSNg==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN7005CU0AWJ630@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 19 Nov 2024 10:11:20 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 11:10:11 +0100
Message-id: <D5Q2NU9LJIVC.23QKQ2GWHUVFQ@ferdinandy.com>
Subject: Re: [PATCH v13 2/9] refs: standardize output of refs_read_symbolic_ref
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>
To: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-3-bence@ferdinandy.com> <xmqq4j44ggq0.fsf@gitster.g>
 <ZzwzrI6wJjY2dpp0@pks.im> <xmqqr077d88i.fsf@gitster.g>
 <Zzw9iqf5bcj5_lV8@pks.im>
In-reply-to: <Zzw9iqf5bcj5_lV8@pks.im>
Reporting-Meta:
 AAFxfWV/iJ+JjdyZ1bd7q+7AaNrqXyCOts7+CeKRtDckYqY8pIS2Zs+vSyERepBn
 7erBk8MphuFG/O4bHSbcqLbUhULVE2IoO5H0xGpv1NElM0D1xz2lbbcVA9hkk8Wz
 m7cVJPz2ykllLHzstZKU4qysoH0kasjwKSKixrvFl0pDto0N1ffRLElD/5k3mx03
 j+360ptRvJq289JjEXa40Dka+JOAjo+b/Q9RGWkD5xgIHqX3/uaF1avKSYFXCt3U
 q+m4sn/kobBi1cYaAWWl72GvLMjLRS97tF0r/Uul8fDZ+W3l4f28QCqStumG2hvr
 7uUZV8UbDxW94gFUx7MC5tzxs5TeVBt47PmR9jKvxTq61EDTNBlh6RNZVT59K27r
 zDWwktWNXg6pCYKY9dF3AyZTn1v9/JVYS6+dC8VBNb23wDu4w8QnmErrFstHsCqf
 B0bAV18bmfd4xRwH/bAD5/mN3RtqapYb8NqkDtrm1HA8ZtTDGf51BheK


On Tue Nov 19, 2024 at 08:26, Patrick Steinhardt <ps@pks.im> wrote:
> On Tue, Nov 19, 2024 at 03:54:05PM +0900, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > The reason why I've been proposing to return negative is because we ha=
ve
>> > the idiom of checking `err < 0` in many places, so a function that
>> > returns a positive value in the case where it didn't return the expect=
ed
>> > result can easily lead to bugs.
>>=20
>> I agree with the general reasoning.  I am saying this may or may not
>> be an error, and if it turns out that it is not an error but is just
>> one of the generally expected outcome, treating it as an error and
>> having "if (status < 0)" to lump the case together with other error
>> cases may not be nice to the callers.
>
> The question to me is whether the function returns something sensible in
> all non-error cases that a caller can use properly without having to
> explicitly check for the value. And I'd say that this is not the case
> with `refs_read_symbolic_ref()`, which wouldn't end up setting the value
> of `referent`.
>
> So regardless of whether we define this as error or non-error, the
> caller would have to exlicitly handle the case where it's not a symref
> in order to make sense of it because the result is not well-defined.

I agree with Patrick re the -1, -2 return values. The non-error behavior sh=
ould
be when referent is set, anything else is something the caller would need t=
o
consider if they want to do something with it or not.

