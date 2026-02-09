Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB6929A9C3
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650499; cv=none; b=JCcshsvnQPrCZjmR/0WWnUyG2ujwtMAcJjFjIbjYvFN/p7qiieWmi+dna/2QavugpJmagR7bczODjBkS1JbXmngLuxkty3ep0FgufnNe8vt9LIPi1PXflzYjSywSuJNkawvdadq/f+IZW7BKlT4MhEEj3/aIJqLn2qCTtLq6W20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650499; c=relaxed/simple;
	bh=yuhvU10P2xYb5WTTrCoDYVn1dM80pbDnrvmeu67195I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQQWM9f5VK8siEGQ/ocEw35WgHx3duJOpy3jYYHNhywhj2u+rtwLYgjJaZdqHkyiEAXe3BKXNuKAZyKAbLwAyIudKuBRrjR2nbxFUU1rEobjSdj+yh8n3MYBR7YQKabGuR9mEKCBrw6YMMPqyhOY5QfPOehLzl/5UHtmJocbbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=u3UsBQsW; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="u3UsBQsW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770650496; x=1771255296; i=l.s.r@web.de;
	bh=P2nRuRMr6uFT3lBBUGW78ztQVi5l/DwpE4eTsOcMXlE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=u3UsBQsWrK/NsHucLSD7d9TURjuc/Ngckdo+1IbfZvCDMnT27VbjUGFKrasaxoOP
	 blZxAQEcm70LbYBZXA+q87rjfE3NUZRDoS2301y1dZNaHT1cKd3nijdh0VAxq2rmP
	 46Xk1389IhbLArrKd2zeBenpiostO52eBTCkClIwtQl+2zrb+mN2D8raxG56goYBS
	 59UD974IkBtL/bpCr2J6EDcBqZ0tsEpWpXXWQ1ybvYnfaH10ldInr/W2RbvE+XInU
	 Ke63IZm6ap/sLko+RciOhuMCV5dN+m77MnHYtx6DMzePGYHmztuMqZZJGAvBvPMvC
	 dUlEeSRXr6crvwOWCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB4F-1wJs0n3Ng1-00PInv; Mon, 09
 Feb 2026 16:21:36 +0100
Message-ID: <b05f81aa-6e8a-4e90-ac9e-85fb72784afb@web.de>
Date: Mon, 9 Feb 2026 16:21:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xdiff-interface: stop using the_repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
 <xmqqms1i6uc8.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqms1i6uc8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SqH817Ln7fZNpMzb5uFzAZhoIweuXOjUuyuX7uUirP4L6vYGnVU
 fhyfJDMkbpfFIF0X+qCyQHmLoAE5vs88TP/dKYGRTKeHvCHKTumhgcnmtBos37IlZKPv/W0
 w8VvcllBAEtIZbCWknP90gma+r+yD5GGkUmbjIn+LnbYbkUgoPk7eG+4c8QlWthxVNwiDdd
 xySjch5F+9zdneG4R4YUw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w1A1nFOqE4s=;zUXizEz+/t3VTvPXXtbRYzzeEkm
 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
 7vyGTi64=

On 2/9/26 12:15 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>> Use the algorithm-agnostic is_null_oid() and push the dependency of
>> read_mmblob() on the_repository->objects to its callers.  This allows i=
t
>> to be used with arbitrary object databases.
>=20
>> diff --git a/xdiff-interface.c b/xdiff-interface.c
>> index 1a35556380..cd7493730b 100644
>> --- a/xdiff-interface.c
>> +++ b/xdiff-interface.c
>> ...
>> -void read_mmblob(mmfile_t *ptr, const struct object_id *oid)
>> +void read_mmblob(mmfile_t *ptr, struct object_database *odb,
>> +		 const struct object_id *oid)
>=20
> A possible alternative may be to pass "struct repository *" here,
> but this passes the (current) smallest piece of data necessary to
> drive the helper function odb_read_object(), so it would be fine.
>=20
>>  {
>>  	unsigned long size;
>>  	enum object_type type;
>> =20
>> -	if (oideq(oid, null_oid(the_hash_algo))) {
>> +	if (is_null_oid(oid)) {
>>  		ptr->ptr =3D xstrdup("");
>>  		ptr->size =3D 0;
>>  		return;
>>  	}
>> =20
>> -	ptr->ptr =3D odb_read_object(the_repository->objects, oid, &type, &si=
ze);
>> +	ptr->ptr =3D odb_read_object(odb, oid, &type, &size);
>>  	if (!ptr->ptr || type !=3D OBJ_BLOB)
>>  		die("unable to read blob object %s", oid_to_hex(oid));
>>  	ptr->size =3D size;

My initial version did that.  Then I realized that read_mmblob() is just
a thin odb_read_object() wrapper that converts null_oid to
empty_blob_oid and dies on non-blobs, though, so requiring a full repo
pointer seemed excessive.  And all callers also use other odb_*
functions already.

Ren=C3=A9

