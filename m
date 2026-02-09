Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4242DCC08
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665094; cv=none; b=CEuBjYE6R1q+OxOkmIvhO5xcCjHuxZh1zWMTenTsPSIwW9ae7mO6CE/sQaC122ErUH9g3LW81lMt/NCjmuB8BZ59Rc5l/GyzQm5H7KBeY3MPzaJamz4nNphF5A/iiTjDdeK7nAktttIDd7OFhNbrHWtPasqwnxhXh/LO57AwiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665094; c=relaxed/simple;
	bh=s90POhmD1W3VsHWSP4zLJPH0PWVlhvZsupI3OEcH6QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5YtBaNOAarS/1tDkAbN4JsnO944/IAMAJqe6t9DwQcxy3rtHmwl+LhFDGlQxT+19nvW/IlTB9RRUHWJFUMT/obJ6MDZCpSO4S+dwUMK7oEIA7tyVnLTMd1kJxIawyAAYHnsVv5kbJT/+RG+wnR2IBATGIGK46lDsYKs4NiF4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=gv8HwT7B; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="gv8HwT7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1770665091; x=1771269891; i=l.s.r@web.de;
	bh=aqI2ddUI7lqSbEjzLZbrU82mkkjMimasMt1zF9KEpog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gv8HwT7BBsuVmLWIXAGp46rjCuprEKEgUuDUueIuesz7/RdeMeIeNgz75dqr2zJM
	 1slgBqNpSSi8wbn/zAW510oW+CgvKOjsaSF5xKatEthBBT/Zhh7Pubr4iY1UalNLj
	 4gvGV9m2rYdhUVr6MVlXyhqHYo2GmSj/8JGMnS6W5Si1O5tmBGx5jWLVPvc4s5MSr
	 mJ62e+swoZNMptYpRBf+h0fBupJLmDHLB2uPEg2A1UlcBchu8xyZPD2xvU9NLZtB6
	 DIQccuAE6X6NwVc7sl8o2NLbklrkFhXEHRyI0BSvrogZxGJVAw4MvGUO4rYk19/aW
	 tCHvCmYkv42IOm7ANQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.22.157]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1vdcAR2X1Y-016dvP; Mon, 09
 Feb 2026 20:24:51 +0100
Message-ID: <267102b2-3ec1-4508-bf90-ccc69516669c@web.de>
Date: Mon, 9 Feb 2026 20:24:51 +0100
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
 <xmqqms1i6uc8.fsf@gitster.g> <b05f81aa-6e8a-4e90-ac9e-85fb72784afb@web.de>
 <xmqqbjhx6cb5.fsf@gitster.g>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqbjhx6cb5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4AA83cHd5BzXosbeOUfECCLa+sJYy5Ep8MH2cGVwaHc5OBm/e4a
 1A5ylc2XxhnqceAJZkha6EtwVAyG4OODMB2Zl+zDPTQZL8QUB0I58Fdf4wHZScGt/s1c//0
 RunpvhLt1iGgSjXJAssQLVSYmMlApUOq3O815iaMZZ5y3wmkp9Zn8lqikXn/FmeZMRHX0IC
 MM2uy+agTdyzuIvyKFlOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6b3KC0ZBoRY=;0Wtva9h06r9f9k2Prn8Zaf5ROqh
 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
 JCbtY6JQ=

On 2/9/26 6:45 PM, Junio C Hamano wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
>>>> -	ptr->ptr =3D odb_read_object(the_repository->objects, oid, &type, &=
size);
>>>> +	ptr->ptr =3D odb_read_object(odb, oid, &type, &size);
>>>>  	if (!ptr->ptr || type !=3D OBJ_BLOB)
>>>>  		die("unable to read blob object %s", oid_to_hex(oid));
>>>>  	ptr->size =3D size;
>>
>> My initial version did that.  Then I realized that read_mmblob() is jus=
t
>> a thin odb_read_object() wrapper that converts null_oid to
>> empty_blob_oid and dies on non-blobs, though, so requiring a full repo
>> pointer seemed excessive.  And all callers also use other odb_*
>> functions already.
>=20
> Absolutely.  Passing the narrowest thing the callee needs is the
> right approach and that is what is done in the version posted.
>=20
> Thanks.  I presume that a small and final reroll is expected, if
> only to remove the now unnecessary #include, if not splitting it
> into three parts?

Right, and still keeping it all in one patch, now that it has become
slightly shorter. :)

Ren=C3=A9

