Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9E2F0C6E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323796; cv=none; b=rc9c7qbEXIj5v+cwF2AQbSJaNxPnNDzPc1JPTl4Gy9bBrUv1KUs6zM+u82vWA+0KGSEUCkxmNRHNTsz0oxrfnEuEqyRyZw9u2J3P8ApfcsxwIsQmB92yMwRyPGxqq/VbCyznB6l3cEi68nDf+r1IoU1vwHruCPdlAAeV127+qmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323796; c=relaxed/simple;
	bh=Z2NT50YANgE1rqihf2BYkq4TLfCA5dAqzDICyLGaLn0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MU5BmBLsSFYnARJovzm+nFMyvHHYT+Uzm8V7mRJ9VVpfOhyuTdF7ZhcHKrYFdowDeTPZgPaXm9tvYKMNqSThF4M0omrQfiNZWv/bkWvgkpuO7XVe6uqblQBojZZEa78wF0fmkgUGzRqpJ1LWd2oanbDVBvR8hfhotN+jrqaTDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGVNuWvw; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGVNuWvw"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53b09bdcb73so3893691e0c.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323794; x=1757928594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2NT50YANgE1rqihf2BYkq4TLfCA5dAqzDICyLGaLn0=;
        b=FGVNuWvw3pnDbZnfAbjFe2eH0thb/jZSSIWZTTAx1PNb9KvPJ7IAqvSQoGEMrVC7k0
         h7FsKbu5qZ0r5APJiV9vLuBunqAA8x7Z2PzKwCwgRsSP0vb5WGS3YIrrR9DjmbaAxPA+
         8YUWWKYy9pl39Juc4YX+vJY05OKOrbqQ8yw31NwMWAeZyjVr6anWm8NErGEARXS7CQPN
         59VzaI2wi+5QDxDHFDfxIqJJHLisp+WKIb6uUpV9Etl6RDm5eu42BJ4BuAJp7d3rJQjG
         QUODg0BAnNko2/7LtaViwNlXvaabrogBOps38Uk4dun4RMtiLg3yZKUi4pr4bYHv5Yjb
         PUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323794; x=1757928594;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2NT50YANgE1rqihf2BYkq4TLfCA5dAqzDICyLGaLn0=;
        b=ULUvVGkLjgFvp/xPW7AWtPucyICgzh0RzswboL8NrvyKveDl4hGjq0DHPz4Wu/ndzC
         iNKTGZVgvgLXFetmeUaJng66dL/beohTZ6E9E+LOI5Tup8IEYp1WJL5X+aS0fPCo6vE7
         1BrEsQV9RPjZ4mcziMMNhXoRK6wfALBi8txPK5YYUjv/8woGnp6Hfj6ET0HYvysLlPox
         s0SSKbK/5V3sLcbziEqddPrnx6mD/KbfxQyLEQ22zGmv0px9Xn/XIPx00MSGvdgE9+3a
         ip+1ZTs9G28DFnwxBrc/m9hdo/zxdfgFB1ijhLlBXvPWBUozNu4J7g0c9LmhZMtiE7qW
         qc6w==
X-Gm-Message-State: AOJu0YzalsWNRG6pHskjWrnScbIpyIuKNck2oX+x9nIec2k9QSknwSe5
	ydESnE7tMwkIrzX49LFzrYbpT7+y4wHQKacHmSruon6K+Md2aZxzA8VxHPTW+tRBzaKYQobLXvU
	H1+tAtb8qLve2DGTGBe8krqHXIawoXIE=
X-Gm-Gg: ASbGncuzpgAtefjzC5qY4p6RvZdHXsEskUwe8atHWDdG7lj7To6V35Wwg3kl0ppW30h
	rt3WBN+zK/cXXB7JMq29f3bOASBQkg8Vtl3eX8MdMU9lZ34VMejJ1NRMSQ9TZkDqOvG6ic7y+mN
	rsx7xlaFke40Nky6bLSE9jSenbiq4sZ9lPrQLzG+K/SXsYw36fMrOTRSa9oG+aCO9QwQCxjSlRY
	LBFX9uIlGhsaUmFS0UFO1O2/mkbJW3S9J/5etrTwCsPqnoEs0dxIw8cuVE290M=
X-Google-Smtp-Source: AGHT+IFJ5JCPe9cgpwOk1bFkejnH8S4tFk9oYTIr9qi+qtD4Fmyr3f79LR6fDbOM16hynQWszzTs47tWOODR0eOVmkk=
X-Received: by 2002:a05:6122:1828:b0:545:dc3c:a291 with SMTP id
 71dfb90a1353d-547a7344aafmr2135142e0c.6.1757323793740; Mon, 08 Sep 2025
 02:29:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 02:29:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Sep 2025 02:29:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZT7vUdkB_6YaK7P1P72VwvHjVxix36q+G3CEqfze8Km5w@mail.gmail.com>
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
 <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-2-35e69bbb507d@gmail.com>
 <xmqqms7bfll4.fsf@gitster.g> <CAOLa=ZT7vUdkB_6YaK7P1P72VwvHjVxix36q+G3CEqfze8Km5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Sep 2025 02:29:52 -0700
X-Gm-Features: AS18NWDkwdZsvB4hpmrU5v2hh7aZG9_jxOB_vEU0viLyAT_mxVu6HwUzBX5xxEE
Message-ID: <CAOLa=ZRshHZXWxTeNqgi253R2b0TB7o42sq6mPmNHQWN_T733g@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs/files: handle F/D conflicts in case-insensitive FS
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, joe.drew@indexexchange.com, peff@peff.net, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000007b6ba3063e46d438"

--0000000000007b6ba3063e46d438
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

[snip]

>>> Reported-by: Junio C Hamano <gitster@pobox.com>
>>
>> Hmph, I do not recall reporting anything, but perhaps it was a long
>> time ago...
>>
>

Reported-by might not be the right field here, You mentioned about the
D/F conflict in an earlier mail [1]. I would've missed it otherwise. So
I wanted to attribute you for that :)

[1]: https://lore.kernel.org/all/xmqq8qjbxn8n.fsf@gitster.g/

> [snip]

--0000000000007b6ba3063e46d438
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 938f69d1e5a71c4c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pK29nNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md21vQy8wVkdYN1BaMUhuU00yQ1N4NGZRYnhwUndBWgpnaGVMeUJMTlZB
QmNwMEdpQjh3WmlSR3ZtS3FIb044eHJnYlBiSnFhdFNzUlk1Rit4QnAyVUNnYkJzdVE0dDhxClp3
eWhuSHQwVVpXMW5USkl0S0I3OWFONXQ0cFlheWhHTGxGazBIRHY4cElKMkVEVTdLNi9TRVBDODIr
a1VhQ0EKT1FKbzVMR1UvU0RKNFVtM1JoTnN5UmtVcEhIazJFTTJ6SGMwb1BBZUJONmVBMHJ6MlNF
a1FKUkRkb2pmcDhRVAp4WE0wZWZPa2ZlWEVHaU9KdXdIUi90M0d1RWs1MTZmTWdDeTVUK0NXV2JS
TVJxYUxiTytaQUZycWdRM0JxeHZzCnQ3S3RQNWdNOWc0dlpzTG8vekQxS0hyTS9uV055MFBDcWNk
V29rMmdWaldBTGNYVDg5MHlUMTMwbFJYcCtUdnAKZGVLVkFxalpuVTQwZlJqTmtJSmVXRTh1YUFO
UDV2NW5MaDRkdXpDNHdqSUVzU1lsY1dkdW5vZnpYRUFabEdBKwpUOFJmUGFRbDBjQ21oUW93NVRR
b2dvcEwvNm5TUVBpeHVFSDA1NTNSQVBPR1VzNWpFVzE3alRmZWgzVXhFZFE4CmtGMDB3VWZqVTdy
TWp1RXdFMVlOMTNQQ0ZFa2pjcWJiOWYwUUxIdz0KPXlrWlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007b6ba3063e46d438--
