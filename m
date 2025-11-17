Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6E26FDBF
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393922; cv=none; b=GV2yAQqSIEIhs8WPTmzEUltorQNf0DBXG0nAhvVaWc4taElzFbDtadqsNL3nL2s+y5IKKikdEl/hRTfu7rt7UYpkmmdAYkzJ+VQ/F3UzQjVZQerB84YRSUPASm64nfDWi/IJHDNCvT23iKA27lELPW9FOddey3NjLj8IOOdKW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393922; c=relaxed/simple;
	bh=e5aZiSQi+HWGnNy5K7wFQwywRFArFHabC7QFFIPzDDg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/E+6dPgLqj6jve7orTN4dmLcSQ14QPlDcR5B2rgPYBWLc8F0BtdC7QIs9zfS81+k206eaRF3bxrXBcy7/fd2MBSz0nfB9P2n3flcwO0cpBzT7t34Z13tavqXX4rMXPzN8/uMXMx/GeqHOTuPNZNJnYxBi71YnjQ+ITIjVQlmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPZ7KLhd; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPZ7KLhd"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-559a4d6b511so463316e0c.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 07:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763393919; x=1763998719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+X3qbtgaLLK2EwzC5lH7HDQ7AzidY4nQ6pn2/9DDRc=;
        b=JPZ7KLhdOBUA/Zgy3+eAqM1kwMczPjD2GrO6MvoScFfnWPEgRNx52IJV0j6LZWS8EV
         XL5gSkku37iaMoPV6RTTfiT178WU5JnmzvMAPpQIzhWS65QzQFGgjk+Qxv7uh6MeThsu
         KoULHNtpn6MR1o9n8GpGmlqkrAPusQxOuHeqBWv5G04IPHCzQcnw9cpOt4ppqB1ZhYwa
         M6gO/mwdChyAkUMnGriwx60V1rN7qmsYK0cxi03xB1G5sFvSTlJi07iefVp3/xL2C/xO
         ntKh58LCPhR68rwz18bv36hu2dvzKYjIuBH44mczTaYpIE40Jj8AyUH6NJMwWOZ5J/+7
         k19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763393919; x=1763998719;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+X3qbtgaLLK2EwzC5lH7HDQ7AzidY4nQ6pn2/9DDRc=;
        b=I6JuIjOEDh4Q4ZY4RsWAAeDrqUfxwUIFqWQymdSS8k29/EIKzWMvsPqBx1DAbF/1QR
         w+6LCetxvrgzhHzs3TyOL3qUnNKHKzikvFp1W069idU5ZPPANvns+J22dDmQ2g4oeVUR
         DRi44H41rBVZhO4NSxUKcE+adCEIx4QneKpKNCFyxRdvj2tRZdQADgmkBTam1KK5Zdgl
         Fw47ykQLUoCQNwM/7Q7KM2/NOjw/2AZM6gzDac/BOvJczUcm/4xFyXZENusdVFkBvdYa
         E0CFu1qRrKKIqBWp/ntcOw9ZxXo3jhRv/hTQDcgeptEe0k+JQ6o0gmwdg32E63ch9M6l
         /6sg==
X-Gm-Message-State: AOJu0YwFeLfsrSbc4knE+Lqf4zxS15KFnDGQz4bxUxRhq+aqkHOz54IS
	Ij67gqj0nn3pJxyWDxIVV4Be8YpiIsPDD6FqacDSIYjQZwHg8GatzA+mFsVLgjwIgsGr2A1HsFI
	F/qvS5QEyR2B0OdawZ7kNhHnB8YiFVVY=
X-Gm-Gg: ASbGncvtn8+jO7p5rD7rYJAVPPaZ2nX5nhIYW7Ef8pZ7VFdS1B6NrpCLLip0NloPNLa
	z9YMAAt5DjMKPn7hp0MUc8j1Fp+msLNqyWuFORzm239st46dtkmsBz+IMWWeGsFiySdqEyoqJqw
	COpBeLH6PI9A/ZROeZtR4gpxzoEbov2NRxQOjTK3drcgXtWUrK0BuOEiqLJDYnRitR8a/iMExo6
	pY6Tnli6aoiEyfrsQjnwjJ+KFvrdsRHnwWkl5SIG5/4jUKx/6Hapu5FfzuNKdKE2z/pUWSb
X-Google-Smtp-Source: AGHT+IGPw0eon5/71Y6Tpfq5L5EtSAir5GuwQrOugGtyBf03nGAsx2074NHD4Nz8sHH8gXaprVseAcivgIBXDerMwx0=
X-Received: by 2002:a05:6102:f07:b0:5de:62f:65b3 with SMTP id
 ada2fe7eead31-5dfc5b9271cmr4160758137.39.1763393918953; Mon, 17 Nov 2025
 07:38:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Nov 2025 07:38:37 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Nov 2025 07:38:37 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtsytbk5w.fsf@gitster.g>
References: <20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com>
 <20251113-fix-tags-not-fetching-v5-2-371ea7ec638d@gmail.com>
 <xmqq7bvtlj8v.fsf@gitster.g> <CAOLa=ZT9wv8B7EKXJQvwR07bUT7Jx0nJSwGGyUZ8+GN3-xdRag@mail.gmail.com>
 <xmqqtsytbk5w.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 17 Nov 2025 07:38:37 -0800
X-Gm-Features: AWmQ_bnEVzw8ObLB_PXB2hoOK7xjl8dwQrwJBeMugU9ATEw2IxQyoT9B6jgFcN8
Message-ID: <CAOLa=ZRn5=oK8+T-mt_nuWVDnVvLUMj6OkAMkD_ZTppnYKBJgg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] fetch: fix non-conflicting tags not being committed
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, ps@pks.im, 
	David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000238be00643cc2430"

--000000000000238be00643cc2430
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> perform.  Namely, we do not
>>>
>>>  - call commit_fetch_head()
>>>
>>>  - run set_upstream processing
>>>
>>>  - honor do_set_head flag that was left for remote that does not
>>>    have followremotehead=never
>>>
>>> but don't we want to do some of them at least?
>>>
>>
>> Thanks for bringing this up. I would think we should do all of these,
>> but not if the '--atomic' flag is used. If the '--atomic' flag is used,
>> we shouldn't do anything else and simply skip to the end.
>
> True.
>
> So when not "--atomic", the code with these two patches will still
> misbehave, but it is not a regression these two patches causes.
> Failing to do any of the above three when "--atomic" is not in
> effect is a part of original regression in the previous cycle caused
> by the "batched ref updates".  These two patches are trying to
> address the regression, but these three points are not covered.  Am
> I reading the situation correctly?

Yes you're.

>
>> That said, we could either append this change as a new commit with some
>> additional tests and re-roll the series or send it as a separate commit
>> based on this series. I'd prefer the latter so that we have the fix for
>> fetching tags merged sooner, but happy to do either.
>
> Either is fine, as this won't make Git 2.52, it seems.  It is OK as
> it is not a new regression, but it still is a recent one, and would
> be nice if we have something concrete to address it soon after 2.52.
>
> Thanks.

Ah well, I have something locally already. So will include it in this
series and push a new version with the once I see greens on the CI [1].

Thanks,
Karthik

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/444

--000000000000238be00643cc2430
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 240ba7a45055c15b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rYlFYc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEV4Qy93TXJLdDBxazR6SW0zc014RUtiRkNqcmN3SQpwdVdWWEsrT2NQ
N1RuT3dvMUJTUHhFMVllaCs5NUl2QjdQZ3ozWjdma2dyR3ppeFVMZStqNENnQ2g2R1ZsOXR0CjFN
Z3I0TWNEL2kvajBMbk1wL0QzM0w2V3hSdTBEL244VzBTczI1MGlDcXRJb2Q4V0c2LzBLRDU3TUFK
M2w2bTMKZUJyQjF1S3V5bFdjamx6aDEvbVBuU0hEcVVXelp4OFo4azNITytNMnh6SUJjVTdaQnJt
VnlRamxSTXdyTDk5bgp0Nko1ME1FYVY5N2JTdnVJNjVRbzEyZnFXNUlaeUwwV3YrVTQ1aTNqemhm
d1hxb1hwT1h6L1RsKzJhS2tOWUYvCi9pY2tiaDRKVURUcnNXZFJ4Z2VPRnlvc0EwL1NvWHgvTTl1
c1M0Z09RK3BhK3IrbzJHOFpHSFlibDBRZW1kZFUKUmFSek1FSGlTU2NzbkhyY2c0M0hFSEdaeHJv
ZkFrNTBwMTEvZ0NBY3RSVEU3RzJ0bS9yamcxUDBWZkM4TDZOeApXdmNEY0VmTzMvN3pyM0tzVW0w
TlplajRwVVlNZThqNHZqdWJQVFdNZjgzazdjWWlrMitSME1kazRsRm9sLzBRCmNTR0pYZUQ1NzlW
UG1VSGdQZGZoVUVVOUp5dzJNa2U5UTBjcUs2QT0KPTl5Mm0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000238be00643cc2430--
