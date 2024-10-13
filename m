Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00F132106
	for <git@vger.kernel.org>; Sun, 13 Oct 2024 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852771; cv=none; b=Vl7+ouxr0u2xXu4FRtCSbkg4GYlctx1bh+5M3KJ66AOM957oJobj2SsDMMd3E97LK55WLru7jZKViGpuRF9eZb2Cv2Bet1Lzh8yrCvaOwj/7mW+v0JKL80JhK5DCBOcuKoyTn1cu0dsYXzUdbxI6dD209x+mA7Ka4fKly+OBC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852771; c=relaxed/simple;
	bh=rFmLfXe9pwvWz8dEGnhXLoBrkXGwAYe+uquUmAPU39c=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=CjxwsHZ1KHg9/WqCpZyn2EltxuMg1XdiTpfDeiDkceK3mtQw60DnSqDYbwocmHe1nFGFPd0+mN7UoFcI4g+ly0SB7XiSRYciYQ6aDnv23HAn3v3IrIvBTDCOBHS95eAkyMswg3Uq39zjW4APlx/rYoppdSfVi8I4cT1JIHWm3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=DP5Pn/Uc; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="DP5Pn/Uc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=WAya84hxa0aCKG+0jmz55FA3+fJX8DCKZY2EfnFtLMY=;
 b=DP5Pn/UcctdRIg+ZdZkoMNEicdHQkKSzoXGc3PlTIeJJ4F7zMwFRDrVIkPJ7TYOvYjtfm5UBujv8
   c1Slm3cussrg+ABzoHprIcZkoGN7xdtM75CUKjg6kyTvh0LzmukMFcHepV5ZoMF8gMN4bDVSkN/E
   Hu6LWzcIjommDplbfqlaF/Fvr4f0bR2C3o1KQEF32b2T5mdUNpS3RZOU8411kSH8a0qs3c5QNE0N
   U0qXYyaZHHBhvSU7NitJ6LM3AwowAXvqgx69LwjkaB69rT0eZ0PkOdKG1GqlQsm7P1qHOI/N6hLJ
   pZRxwSQG/y8UMgLFrgo7dBatpvaam3LAoPrqdw==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240911 64bit (built Sep 11
 2024))
 with ESMTPS id <0SLB00NEMBBY7930@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Sun, 13 Oct 2024 20:52:46 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Sun, 13 Oct 2024 22:52:22 +0200
Message-id: <D4UZ5DJWM3WM.MYD9YL6SLE@ferdinandy.com>
Subject: Re: [PATCH v7 4/6] refs: add TRANSACTION_CREATE_EXISTS error
Cc: "Taylor Blau" <me@ttaylorr.com>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Junio C Hamano" <gitster@pobox.com>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241010133022.1733542-1-bence@ferdinandy.com>
 <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241012230428.3259229-4-bence@ferdinandy.com>
 <cf7c4831-a766-430c-aac6-5cd5c2ceabed@gmail.com>
In-reply-to: <cf7c4831-a766-430c-aac6-5cd5c2ceabed@gmail.com>
Reporting-Meta:
 AAG2WuwX+0TdiR1K2l5vLykhxTy9yHVqq8v4/IADvLNFY7HqXl5xzduuy2sMmN/T
 zBBhrvmcIwAHPOq+QnPgqsxpqmSaL5VaH7PfT9ays3+tya5ljSuTfEH8ZjKDgcxw
 AblCRQL2mQ3ufBCYQTiDDCyGxRAvAmTpm1F/4CTQAM/0KU8+AtJ6oes50mVx87m0
 aFgCFotz0p0uW3Wp4Tq9sGhEUptxaJ55aox8PftGskRu/Ue05gp4StZONRBf3W9N
 3qRyvlGoqWQvbUcoNrsEf2CDF0d40osKN41XqADYApChELb811Fec/yO+bVDKngJ
 FS1cIHVNJ+n9Snp/b6DOIphuhhdQfs/qYZW2FkwPGVMF2oP6TQzORDX1FhIGcymn
 1AfBG6zSLNLA8jSi5PwudX85ELdl/WWd5/cyhQ1zeZqhvvBBe7HTcQmFgKts/LYN
 1czpxtZcldQOa/nnXkqmxHTDcnTFd73NmAED1zwSuaCUtlBow+ZXrng=


On Sun Oct 13, 2024 at 16:03, Phillip Wood <phillip.wood123@gmail.com> wrot=
e:
> Hi Bence
>
> On 13/10/2024 00:03, Bence Ferdinandy wrote:
>> Currently there is only one special error for transaction, for when
>> there is a naming conflict, all other errors are dumped under a generic
>> error. Add a new special error case for when the caller requests the
>> reference to be updated only when it does not yet exist and the
>> reference actually does exist.
>
> This looks like useful improvement. Are the changes to=20
> reftable-backend.c correct - it looks like where it previously returned=
=20
> TRANSACTION_GENERIC_ERR it now returns TRANSACTION_NAME_CONFLICT which I=
=20
> think is used to indicate a file/directory conflict (e.g. trying to=20
> create refs/heads/topic/one when refs/heads/topic exists)

This passes:
GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable prove --timer --jobs 8 ./t[0-9]*.sh
so I'm hoping it's correct :)

[snip]

I guess you are referring to this part below:

>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index 3c96fbf66f..ebf8e57fbc 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -1206,10 +1206,13 @@ static int reftable_be_transaction_prepare(struc=
t ref_store *ref_store,
>>   				goto done;
>>   			}
>>   		} else if ((u->flags & REF_HAVE_OLD) && !oideq(&current_oid, &u->old=
_oid)) {
>> -			if (is_null_oid(&u->old_oid))
>> +			ret =3D TRANSACTION_NAME_CONFLICT;
>> +			if (is_null_oid(&u->old_oid)) {
>>   				strbuf_addf(err, _("cannot lock ref '%s': "
>>   						   "reference already exists"),
>>   					    ref_update_original_update_refname(u));
>> +				ret =3D TRANSACTION_CREATE_EXISTS;
>> +			}
>>   			else if (is_null_oid(&current_oid))
>>   				strbuf_addf(err, _("cannot lock ref '%s': "
>>   						   "reference is missing but expected %s"),
>> @@ -1221,7 +1224,6 @@ static int reftable_be_transaction_prepare(struct =
ref_store *ref_store,
>>   					    ref_update_original_update_refname(u),
>>   					    oid_to_hex(&current_oid),
>>   					    oid_to_hex(&u->old_oid));
>> -			ret =3D -1;
>>   			goto done;
>>   		}
>>  =20

This originally returned -1, and it still returns that if it doesn't return=
 -2,
I just used the named variable instead of the integer itself. It might stil=
l be
that this should be -3 GENERIC_ERROR, but if that is the case I think fixin=
g
that should be a different patch? I didn't check if changing that -1 to
something else breaks anything or not.

Best,
Bence

--=20
bence.ferdinandy.com

