Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F41F3B8A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469875; cv=none; b=rHfFWRTZAD1iTVGFkwDptyw2Lyxv474iaPX+7ylXEq8CiYwh0zmBXBpaxSeW4qINBya7JnQWMCbdR2+Fjidg7qajO4tvAhBJfaL/3dv7z4ZQ9XbfMOlNO3t9a/XVHwjJKq+K1uPRgFsZC2t9sQuPdjvlDl8H0cfOAQoqbfPNY6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469875; c=relaxed/simple;
	bh=XBjR3WD+4HlxdpgQVUwVRU//pvexA1zSnd4e0iDekqw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=glMUj2bDZm+fAnToc+e8HMhihpcBmDK7mfJOZllnPlY5e8NeF6iD5rokE0RtZCJavSvuhdOMeWz48GYW4jUn/DXuRUmtteJQkPWv/+wuwjHwSpbSZQBrNrttIwLCcoMRutisRxAeEyUXmlmxG0m3e7W9j5iWN7m+q5vJtcuPpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U36jwSZm; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U36jwSZm"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e94d678e116so6360434276.2
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 19:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757469872; x=1758074672; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ei/eppV02tfBbr8jHXZw3qW3S6a+2i9ovvleJMWo+Ek=;
        b=U36jwSZmqacJdaJEFx6jj5dUFtvM1skBxDQjqJOdSJX8RhqFqrXb7+RkMGlkVCJXPy
         HfzTFzxwdqhW73F7JDhUjw2UI0D5UDzacOjm0dP/+HZa+HIywA2qR/KagCreg/GQoccd
         MuOo1dGPc/p2dBQ/AcnYnTOvEaKXw2fy5alduXiI9O9ZiFoUCNNa1a20jwutdwPt1k3g
         kjrDnrJJVW+XRfIte0FLGBB+W2nIVSlFIKuAjlxsgk9CoIEblmxV15fsKfHdkknxv7E2
         R7ncLX+06ZkAnW1OBqKHEMKcvohgx39X+dpxUbnH9rf4CtVcUo8zshmXrt2Ql7WtIFCZ
         aUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757469872; x=1758074672;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei/eppV02tfBbr8jHXZw3qW3S6a+2i9ovvleJMWo+Ek=;
        b=wCew/S7VmwKtukg/JHDNO4IhRIMfK+ZK/7r3e102M9jhI6e+U+8OvHHFQbzd9Wsfpz
         u2nBS6l3m08SOC+o+9fpNpALi/+y3/v8gpQBpnoj55rThzxRFzS5RRkRYSRcvVk/QNqD
         WEmy4W7opd0RKtB1rhcDtoJWL6+aWJ47vLiZqzUxL7FNrKtCo4W3+00xSz08AQPA8JVW
         QVFcmHVscqT7ojEgZSgvqW6TOw9tA5Ol3OAPsximrmUfgDJjCkkihJ/AqZWtKEmTSqPA
         QrgAUQyCZXpqEp/OP6t5MNmEib4fxIIB/JHeRBElKZYHyuO5OBJmqQKRckMJw0mOVe8/
         7jKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCxWyCvvYVYFmSKWzzRg0fJsUOrJWDOTdkqOpZcZ7QSLE3yM7KMUvfnD0wi56kTh9nQrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZcxur/jOSoi5TCN8LmbfW+44F7B5KzcQue5Do2Bj19c1vCG76
	pdcVBDRlqCzoToNWn1eYZO5f331T/c4mIsSuQNPTeNJc0D95YTonFVUB
X-Gm-Gg: ASbGncvQVwN5ypbGVc1p7vGVMNsUi6GpfsKaMjgdrrGnhIGrke9Omh8B7riC1Dbr8/+
	jsmOpuAZAEHpyKT4zV73wbdgdySorA/WjOp96TPF1IcnVh+tKHaOd4IwgQVySC8qoBGfJKS676b
	kbwaqfSuC84NHzxQP+lul2VRDottjXSMtnxsnzM1NePXLxpOntQM17abtM42iN+tCNqvr5vZUeF
	81Nkl/eb4+Tn35qYdlK7s9Kd/z4FlGUrv/xSmv9PBvYgKIgI0pEkuouksArC6+epWp1Tfc7NJ59
	bgelexdCYT7hvWlAW/OFzb1pLWGW7s7U0T1UBV+zqfSbIgGve9/4v0L6msNvxNXQY3+6u7eOJCc
	jYsno2gcNTdJgNQFhrsRVCDqGXphKvMyV41/RvYNwFPDgH3ajlySCJrPelhyrgw==
X-Google-Smtp-Source: AGHT+IGqugo0vr/r8kEz9L4Ue0m+Qa5bmZ/9EmVn+mxnBDvMQj5Ga4+p+WR0m5ad3Gr1fbm1HYT3kw==
X-Received: by 2002:a05:6902:18c9:b0:ea0:3d22:5162 with SMTP id 3f1490d57ef6-ea03d225f96mr9943940276.9.1757469871962;
        Tue, 09 Sep 2025 19:04:31 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:a4ed:b0d1:e879:d740])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf23067sm7066930276.2.2025.09.09.19.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 19:04:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/4] string-list: allow passing NULL for `get_entry_index`
Date: Tue, 9 Sep 2025 22:04:20 -0400
Message-Id: <DBE9993A-D6CC-4ABF-8D8B-18D54CF1B001@gmail.com>
References: <xmqqfrcvt7mf.fsf@gitster.g>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
In-Reply-To: <xmqqfrcvt7mf.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 9 sept. 2025 =C3=A0 21:32, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFBen Knoble <ben.knoble@gmail.com> writes:
>=20
>>>> Le 8 sept. 2025 =C3=A0 12:48, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>>>=20
>>> =EF=BB=BFshejialuo <shejialuo@gmail.com> writes:
>>>=20
>>>> Callers of `get_entry_index()` are required to pass a non-NULL
>>>> `exact_match` parameter to receive information about whether an exact
>>>> match is found. However, in some cases, callers only need the index
>>>> position.
>>>>=20
>>>> Let's allow callers to pass NULL for the `exact_match` parameter
>>>> when they don't need this information, reducing unnecessary variable
>>>> declarations in calling code.
>>>>=20
>>>> Signed-off-by: shejialuo <shejialuo@gmail.com>
>>>> ---
>>>> string-list.c | 6 ++++--
>>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>=20
>>> I do not quite see the point of adding these conditional assignments
>>> to clutter the control flow.  What benefit do these callers gain by
>>> not having to have a throw-away int variable on the stack and
>>> passing its address to the call chain?
>>=20
>> Wouldn=E2=80=99t the point be that (at the cost of slightly more interest=
ing library code) callers don=E2=80=99t need to introduce extra ceremony for=
 results they don=E2=80=99t use? In other words, take the boilerplate and pu=
sh it down rather than up?
>=20
> Yeah, but the point is in what situation does a caller *not* need to
> be able to tell between "we found an existing one and this is its
> index" vs "there is no such thing, but here is where it *would* fit
> if it were placed in the array"?  I do not think of any, so I
> doubted if it makes much sense to complicate the interface to make
> it optional.
>=20

Good question! Thanks for clarifying.=20=
