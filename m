Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F82B192B96
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 06:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737009869; cv=none; b=sBq+oEyysn2E0IhOdcvDbG4ruGJc6lMc3HacsTfHpLGIxWPo0LT8yfH83Ek76kuP3CWMSWWWd11krKPvDCANISk/7t4mWywbICNz3wUhPiIURKVpJBHF793cc8irZFS4i4G8LO8u3j4WML0EwIF5eSB0tFWxWtM5MTlt+R5P5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737009869; c=relaxed/simple;
	bh=2trjwCPwrR6gwa6jU0OkJQ7IhBB06nIoZOvXqGBzBoU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJ7F8oh4K+4Ln4yPcwLtbSIbMNMu000ZTZ+YkxIhSxkIB7deTKTaWV4KYRPo3qn7imammZ3iM6f4tssziLLhQuRlSVytIy47Y28+SvreqJnSxCClVUlyvw2EPwH81sKw/hDYWiJ/XT7/3vgzqe0vTzLv0IMYy1xhj0kaUmZW6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCDqLi4C; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCDqLi4C"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f44353649aso866331a91.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 22:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737009860; x=1737614660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwyoMBSsnziIEeH74wm0O74bLvBEukb/+h6HuHGIqCg=;
        b=TCDqLi4CgzFznCnYkFSGz8qlUQPm0YOucpmuBx6aL2IoIsFT8Nm+i/LUQDqB8wGdfD
         qXhwZKVcyg5Y2eOufwJeOGxaQaRIMvK4my3m3umg1nQA2weben6NM1TIG2/aP4Hgp7Gs
         Mi3Vq66WHBnwOFl8838WkcyVb3VLBiGLxIm1kfLTvnOAEYuHqPD9weqMc4hHgQsDo3QH
         Bu7aYt4dN1qwmHlt+MjfNyfylxkJc1XC2TsrdSZWorooh9hWmSbaIZKyFONfeYuaYY1z
         SG1Y3Ioqis0CH44SN2etr0nVLsZZ+ttFhi98rTvlcvYL2E/dOYkKomRwFc2+ImXbDukZ
         mFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737009860; x=1737614660;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwyoMBSsnziIEeH74wm0O74bLvBEukb/+h6HuHGIqCg=;
        b=Wqdm76fGoXM9tl3J5nZXaqJUBhHK8Y0bIVi8NVRyCrLNiPExa58wFcD60zozF9cFof
         nJ4mQVILRM3999VCKqLfH2BwqpWkoN68xcjprut1aA7nDbr01kY8w8LkZBTj8FPH4XIC
         /HUi2ollLXcms+m658AeyzKX+z1OJti8FfFyRnDdqKG9kQuSSWaz436D2NAr53/OQnyG
         BAepFv3KMAriu+ZZpPBILeM9yswXbPvIk3hgjGFQ+kPdaz1qkUka//RBGUohYp+EucCW
         /AMbhfZoSfArdT+B2ex3xAVOQ0AWUUYijvrTG+M2w1ihdapchzBWthELc9rUw5pWXV1t
         jQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWVXROetrViPIhoRFF7r7AXtZJXaUQt+Bi5L8k5ByriAPUXZuL0DGI6iiac1mWRqV6xUQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2b7o5vXxRzs9ISprzd3x84CES6vuKOIqhmYUd04ITGTK4Myk
	p9K/aW1jcmULUgry9yRqGGbSOfNhWe/ecCFS8JPO47y1MwCJw83PYEG3psvKGsRmdKGY/4/HZC/
	Z1kGh8WILifWr9MVUZTsFmOSStiuCyYMK
X-Gm-Gg: ASbGnctj36PFe92XzZL3AOnMEdMSbQxjEZjN2x6MhjpPw5rfybX7uVbqzP8yR28HPQR
	hV7L0d4JqwH1lbQm3KYtkDixnmG+HJLrcY5iDia8=
X-Google-Smtp-Source: AGHT+IGVvx3Cb0a0dz3wFzBOPdVQKy2UlG69ruLkOIFbF9jCs2qtkuON+DbeK/R8y/v8OWXRAReNx/rlKdDnw82WxrM=
X-Received: by 2002:a17:90b:5403:b0:2ee:d371:3227 with SMTP id
 98e67ed59e1d1-2f548edf04fmr51100390a91.17.1737009859803; Wed, 15 Jan 2025
 22:44:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jan 2025 01:44:17 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqa5bsypht.fsf@gitster.g>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
 <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com> <xmqqa5bsypht.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 01:44:17 -0500
X-Gm-Features: AbW1kvbJR_BNsE2xgCJiwkr7sTiJI2hH7Tkrrm0_PFwFtu8ClLDJgyTBDFa0guA
Message-ID: <CAOLa=ZR6jbJwav0+3-A+3w=XRU02Lp_9Mm4RXbN6A00-N3Xq-g@mail.gmail.com>
Subject: Re: Bug in 2.48 with `git refs migrate`
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000aa5ab7062bcd1f0c"

--000000000000aa5ab7062bcd1f0c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Subject: [PATCH] reftable: write correct max_update_index to header
>>
>> In 297c09eabb (refs: allow multiple reflog entries for the same refname,
>> 2024-12-16), the reftable backend learned to handle multiple reflog
>> entries within the same transaction. This was done modifying the
>
> "done" -> "done by", I think.
>

Yup, thanks!

>> To fix the issue, the appropriate `max_update_index` limit must be set
>> even before the first block is written. Add a `max_index` field to the
>> transaction which holds the `max_index` within all its updates, then
>> propagate this value to the reftable backend, wherein this is used to
>> the set the `max_update_index` correctly.
>
>
>> diff --git a/refs.c b/refs.c
>> index 0f41b2fd4a..f7b6f0f897 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1345,6 +1345,13 @@ int ref_transaction_update_reflog(struct
>
> Not the focus of this topic/fix, but I notice that the only caller
> of this ref_transaction_update_reflog() function is a static
> function migrate_one_reflog_entry() in the same file.  Do we expect
> that we would add more callers?  Otherwise we should make it a file
> scope static and remove it from <refs.h> file.
>

I don't think we expect any other callers now. Maybe someday we'd expose
creating reflogs to the users. But for now, making it static is more
worthwhile.

Let's follow the boy scout rule and clean this up, I'll add a commit to
do the same in v2 of my patch.

>> ref_transaction *transaction,
>>  	update->flags &= ~REF_HAVE_OLD;
>>  	update->index = index;
>>
>> +	/*
>> +	 * Reference backends may need to know the max index to optimize
>> +	 * their writes. So we store the max_index on the transaction level.
>> +	 */
>> +	if (index > transaction->max_index)
>> +		transaction->max_index = index;
>> +
>>  	return 0;
>>  }
>
> So from the problem description, whenever we consume an index by
> assigning it to an update that belongs to a transaction, we must
> make sure that transaction's max_index covers that value of the
> index?  I was wondering if we should have a less error prone way to
> do that by having a helper function that takes ref_update and
> ref_transaction objects to do the above, but this is exclusively
> used by reflog migration code path and nowhere else, so it may
> probably be fine as-is.  I dunno.

Yup, that's correct. It should be okay, but let me do it anyways, makes
it safer for the future.

--000000000000aa5ab7062bcd1f0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9a92ca1021fffc88_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSXFyb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHB2Qy93SkM3U094WUxHS1pxZlp5OUdTVzdnbGZFWQphVUUwSVpzMDdJ
K001Q1JHWkpiWUc2eFpvWVN3cXhLRDJhVzdsRmxsUWg1UFIzMThzVFlBMEhLb01uaGJra2ZtCkJS
ZnBLelVBalhGRld3em1SY29iRmJlLzR0aXl2QTJ1cVFhcG9yckFuTkM2OHdJYnd6azJxNHRudm1V
c0dhYlgKeEpnZGg2OFRtc25iQ2pYbWhXc2xwdFp3bXNTOE5vUGM4bHRUdXJTRS9qSndteEhuSlZW
bTBnRko2Kzk5dGNZRgpXVlZSbVlaMGd3elMvSXE4Y2liNGpqbnlKRi9XdU9Jem5PZWw4VHQyY1Ur
TnBpMEtGUXNaSWVza0JMMlljWkNhCi9RMWU5WkV1MjhHaWpYUStPKytWMStVS1AzZmNiZ3crRDhW
TFVYS0tZc2FSalhNeGJ3cEd5N3RRdlBJbGpJWVcKZHhhVVJKSm12Q1ZkRU9Rb0N6SmVpNGlrMW1q
Y29pbm1aazdqQjMra1Z0MnlCUWpOdTlVRkliSXAxUDF3NUMrZgpBVlpYTllCTjRwSjR3dWhSOWsv
WmE2eDQxVnBhQTFjV1drUVFYR05meFl3L0ZqM2ZQamh5QlFKd0JvNlYxN3BiCnBSU004Yk9US3di
Z0txSXpKN2tuZndtWm12UFgvUEJ0RStQOFlZRT0KPVdDWGEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000aa5ab7062bcd1f0c--
