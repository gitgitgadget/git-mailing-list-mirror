Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87811D5161
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739255763; cv=none; b=ouGGEk77kTupofD+w19ctgyE9VlNFq8k1dt9It26nSdoBjLaTDqmiY7l+Jw9RoNene/AA6AuEPT9SGAqoniF4vEDpA+ODJ3GITf1syf98YZ8GOzYouQOatqZHTTWEyHUgGmBNjnI7t7PzPE4hxqCyQSZ7Um6J60vU8VJmboycUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739255763; c=relaxed/simple;
	bh=pgjFoYCdWPwHekqZDvrx3SYqO2BVHxsEd/g6bmt5B8I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdmJLJq4OdmTO9s2RXKjCNFwDvhuFE3vAfZYQbqvNS41s8P+anI3A4RZgMGXA2JH6Ph1NwHRrQdsVfMB8F1ASwRBeMQWZNOMYDMrkRb/zAwN3M/DQiBIsDkpc0J43gmzTA1bf+NxcvVUDDaoGv5bvVYwAiKebRPBxL29eMtFi+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWLNBift; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWLNBift"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4bbc047a3c3so1384162137.1
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 22:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739255760; x=1739860560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRByw5IeUcoeQl+0y7f3xbpXDhabhp8W+JU05AwJr9c=;
        b=mWLNBiftmDv8T9YjecUcsXvk9K34SXDplatNu0oEIhfaaa9CGZuhPZC3D3bddretnU
         nB3lQii5DpWgPrK+1CWO17HhJ8biLq22Dl2lVapfuZ3iCshgIo/OCMUTVauVqpEGi/cM
         sm79dXNjbTgeGNLfo6iea47LJlDHfTYtA+R5EGOm6mIeM/MorBvJQSH8zn05HLO3iDv8
         ahl8b05UYGzPRGgT0rxhbyodZI53SUwBJEFE1LeekeyIaWlKEIpAfte/0zYT+fWfE518
         WIxJWHyVmyjTyCkHdgqPrDNP9nzpeN0IgDl61EpGAFh0JeX3RvshwFkpE/F7fV0E8ZQM
         IwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739255760; x=1739860560;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRByw5IeUcoeQl+0y7f3xbpXDhabhp8W+JU05AwJr9c=;
        b=YrETui1iU2fFM00/3sxLQylBKNTSi+oAsk8cA/+rR0a2lmGW+TOp7+m1c70uh+OaxU
         avmvoTrjYzb+Wlihcx1ndR3bWmPCpFecHXsyCDiBGSQjgQON2MYFI+mzs9CbQ0bYjZfn
         xgZdf+mHOpAMSvjJy4vH7Edtwj3PDQ9Fy9vfjzLldBMTDd3/iyGQTKmANJnPMP7JDCQm
         dEvJJnPyR9KtLBw8WuGxVXZVPjKdR+CKx+Q4V+lC/VLhAUi1UdT1WIGkRxiRA6FJ/rhh
         R6abUET8jG/CYiEK5gW2oBkm/DtSsi4JOIlSLTeJFkn1E+KD4tktKBZFeyuDMZ6Surdm
         DOBA==
X-Gm-Message-State: AOJu0YwVEcGHJ5BaKd6HuAUNfPElSsrOVM/RUqrwszMyTQZaT1AO2o1n
	Q0rK0ix2R18xKfPxg5J5ib66xN48gd/sfW8pJJtxSNeEg1v46ju5hUN+2HqT27c+cJ7xrnocVq8
	LHOx4dgh/bYZbRe+S0HoKd7q2mAE=
X-Gm-Gg: ASbGnct/ht0F8nmiGEEaG+ies0fTzicWGmPFKjrlutE7sHv8xAgC3ayHe545dQn/vNn
	PO6JubuVXrShSNDUuIuqYCRRMRT8fj0bXcGBmJtjI6Lv0paSLvV6aMNOb7i7X6SuLxDONyuHj8h
	6eY7E8zCBrfGrmTa0dJHbbBdbSaScHcA==
X-Google-Smtp-Source: AGHT+IGe3Uha5dIeiLWnWNYA3uPM3tZR0AOZBnfCC4itzh9HskvebUVjPkm1IEHtLi/bkGX35VfmFXVuQGpFeW/2Vrs=
X-Received: by 2002:a05:6102:942:b0:4bb:dfd8:4175 with SMTP id
 ada2fe7eead31-4bbdfd846damr2426734137.19.1739255760511; Mon, 10 Feb 2025
 22:36:00 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Feb 2025 22:35:59 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z6Yw9RK6JRKERmn9@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-1-e6a3690ff23a@gmail.com> <Z6Yw9RK6JRKERmn9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Feb 2025 22:35:59 -0800
X-Gm-Features: AWEUYZlZJ-GI75kNwpOr7h4n7NTCLC-q4PcyTMrx1uYoiMsHn0NXQiSkxvIkqM4
Message-ID: <CAOLa=ZRYvLAEbaxMf=P2euh+QO00W5RAhDTF1v4YYj29yH0YHQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] refs/files: remove duplicate check in `split_symref_update()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="000000000000c78539062dd80917"

--000000000000c78539062dd80917
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 07, 2025 at 08:34:36AM +0100, Karthik Nayak wrote:
>> In split_symref_update(), there were two redundant checks:
>>    - At the start: checking if refname exists in `affected_refnames`.
>>    - After adding refname: checking if the item added to
>>      `affected_refnames` contains the util field.
>
> Okay, it took me a bit longer to understand what's going on here. What
> you're saying is that we already use `string_list_has_string()` at the
> start of `split_symref_update()`, and if that returns true then we would
> bail out. Consequently, it is impossible for `string_list_insert()` to
> find a preexisting values.
>
> Makes sense, but I think that could be explained a bit better.
>

That's correct.

I'll rewrite it to make it clearer. Thanks.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 29f08dced40418eb815072c6335e0c3d1a45c7d8..c6a3f6d6261a894e1c294bb1329fdf8079a39eb4 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2846,13 +2838,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>>  		if (update->flags & REF_LOG_ONLY)
>>  			continue;
>>
>> -		item = string_list_append(&affected_refnames, update->refname);
>> -		/*
>> -		 * We store a pointer to update in item->util, but at
>> -		 * the moment we never use the value of this field
>> -		 * except to check whether it is non-NULL.
>> -		 */
>> -		item->util = update;
>> +		string_list_append(&affected_refnames, update->refname);
>
>
> Nice to see this and other code removed.
>
> Patrick

--000000000000c78539062dd80917
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9d77390daa61d6bf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lcTc4MFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXZnQy85YWpjQUNqOEwzTTBpWW1abXdCemQzRXh6ZQpkZ2JSOGVzRXNW
Mm9XMWd1REt1amF5ZkdpUU9MSHhJbVNkNm1EMTZNSStmRnd0STMxTTlobGs4MnJHV25aNFhICmo1
bkFRNExPTFNtazZYZjNSQk9ydmhKTWE0Y2EzN1ZURXJ5aVdTYVJKUEJwWVFJQTJ0amM0WFFmc1hi
aXFIRncKMWR6RFowNDVaN1NZSEt2STV5MlRybnZsM2kvT3NwK1YvclV6QzZHQ0dkY1NFZWNDUzBZ
aDJ4T1JZQkNDczMzSQp1Y2tjVVNVMS8vSXFUMEc3MHczWjBURUVQdmNnZ3AzbWlsd1NJa2VkbDh1
UHJ5RDh6V3JBM3JhUkdXZGhhWjNNCjNtN045SGFxcnNVOVBidFFJV2UzZjAvWlZNbmxmZGVxMzBO
QS9rSndPSnlDN3o0RGhqcERSVnR2QWg4SURFM0kKNWlyVElYeVRHU0J2bi83YkVVQnlDanlaVjZL
QnY0YnZXd0xoclUwbWswWS9nM0pibngvay9EdjlwSTBaTVBoZApuOHY3MFZLalVVU2dRNHdFMU01
eStMYVQvNlF1bFhqaG9iM2hkcEcyL08wK1dYUktDaDl6ZlNFWlQ1eG5JNVVRCkZiMWFTdXJRRFZt
M2QyWUNSTXh2NjRKYm42bDZoMUE4UmtTeTNTcz0KPW95b0wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c78539062dd80917--
