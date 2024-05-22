Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39A7BB15
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364568; cv=none; b=VOnxJEUJsqd7LBub0wGiItf7hQRHIf/2w7pinXpy2s6cWNHP3PDVdToF7RiuWesA3uIeSD1qQ9HUHlOOZjQA90JELe6X2J3xx6b6gNRpmSC2Nqn7TnblnP6ATCoi9niAM7GaRt5o4vn//Wi4EIldv6NX4NC+X5XHtWxqVSvI6vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364568; c=relaxed/simple;
	bh=Ax1tNjW7IQhHLrL1wuktl2okBdAePLEvTLw5KfOR9K4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFWLPjfH+AvYCYmraQ1dQa8A0/xBMWF7MzKvUvIhYouMP8XwEi2WIwMFUwz4i6mJauZQPSq62hXxbdT9uvrJD+zyAgsXdcG9MHEdi8M+qn4mjRLFVoocFGiI7xLuhyx1yA6HtiruOVfc1XXYmyLMkAH8Qw98yO0F8QhDX8cR8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQgXPiFZ; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQgXPiFZ"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b680c1fdd4so358702eaf.1
        for <git@vger.kernel.org>; Wed, 22 May 2024 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716364566; x=1716969366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax1tNjW7IQhHLrL1wuktl2okBdAePLEvTLw5KfOR9K4=;
        b=fQgXPiFZ/PWQJY/hb5Uc3GUux0nH57NWnVV5TYaXv/62XDQIkOgmaB04rovFb9z4lZ
         u6599biOlaVO966LGuYauQWWk/NIpekitmizJYF7bIBWOEBySMnQa+o1vW7/eziYW7bX
         hR9Xr65DJrr7ZwA+KPDxygkSpqBr9O+lZrsSdKhU3h0hS2lDUnkTXbUClIargjJzQnhk
         wluRkthNDYQpcH5Ok0L2Nw0kMUg1i2YaqOhQAKqEvwdXC7GD6LEC90vElxte9/imNpLm
         Fs/oF+RJkjiMKfAxSL0w9W2mkQxruX+NFZX722WvUtI5nh0xsglynGVEiyf2n6trWO7E
         g4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716364566; x=1716969366;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ax1tNjW7IQhHLrL1wuktl2okBdAePLEvTLw5KfOR9K4=;
        b=NmhObC6ST37PVnhm7dYLV9K1oZwE1EkpESIWUSmOjZUZVroiRibhT3DN01Ph4nQLO4
         QTaVJF4stfwG+Rbv3xhCzFXfXESwOdO2DUuawPTaBVK5y3KbjgBRpYO35NgroNldABBn
         6HvqN8qFibewAjDf28TIiZ4Om4UiImGiIrSj1km4196DASllTb4VPvY6W1rjAt9KbROq
         V3Ngkk/7TGs2b4Qd2/G+Irk3jC4+fb4xjxwKm18spJsW+qdC3d6e7uOQP4Y7sI8OSJgw
         q+cqPvBmsVPNQBn1Ka4yBLxGq9QUaBM5l0ZrKzY86CHfkxN3coiZrcmx4sT6yhgqhGZH
         foKw==
X-Gm-Message-State: AOJu0YwdkbIi7o1o3zFmTLKvfV+bH2KWUQORhXwxdxuqKL6jVdq+bDgy
	IQBn1pgL5d1U0jFR2k7PYZUK+AtyT5NE5wYTcHk8x76xaXeqIkfZbKMxupnc/Ioc4lBsm3v5a6l
	edtzgP6n2o0r+91T4W3H+TEE1dghsKZ18
X-Google-Smtp-Source: AGHT+IEEIXjxqO9Mkev/IGbl1gJe1S8Ncw6F5bnjzn6JrqR2aW+A/q33hrzz6s0wp42XI4zs4OjW0bKOvpbmeKfgUjc=
X-Received: by 2002:a05:6870:6126:b0:245:4e2d:5d8e with SMTP id
 586e51a60fabf-24c68adf6damr1547580fac.6.1716364566329; Wed, 22 May 2024
 00:56:06 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 May 2024 07:56:05 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Zk2de9lNrNJRuwUp@tanuki>
References: <cover.1715166175.git.ps@pks.im> <cover.1715589670.git.ps@pks.im>
 <716863a580f9e1ef8ea796c25c97e50c63585a7b.1715589670.git.ps@pks.im>
 <CAOLa=ZSC4OF9b1STzEZfPjrJDbee04A-piNZ86kDS_GDij_3Jw@mail.gmail.com> <Zk2de9lNrNJRuwUp@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 May 2024 07:56:05 +0000
Message-ID: <CAOLa=ZR=681m_XE=-CRrEZfQLPdbSAm7S8M0b7ZotUSG9LbX+Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] reftable/reader: unify indexed and linear seeking
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000048289f061906440b"

--00000000000048289f061906440b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 21, 2024 at 02:41:27PM +0000, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > In `reader_seek_internal()` we either end up doing an indexed seek when
>> > there is one or a linear seek otherwise. These two code paths are
>>
>> Are we missing the subject here?
>
> Hm. "one" refers back to "indexed" and is supposed to mean "index" here.
> I agree that this is easy to misread though and may not even be proper
> English.
>
> It doesn't really feel worth it to rebase this series just for this
> issue, but if I did it would be 's/one/an index/'. Let me know in case
> you disagree though.
>
> Patrick

Okay that makes a bunch of sense, I think it is okay though and not
worth a reroll.

Karthik

--00000000000048289f061906440b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8b881909287955ea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aTnBSSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0FVQy80aytLeS9IblFxelBRb3F2UG5BQ05jeUpoWgp0RlljTDBRZVNG
NXhiRTNGQVRDTiszYWRyOTI2Vk9KMmlPRVVqNUZjbXJzRm5Da1RQVEdJY2oxOCtXeWlNYy9zCmlP
ZGswQ0I5N2ZsTjA0QXpacUc4cGpLdHNwRTdLWWJHUXhrRGdkMFB0eDNpNzlPd2NFWWN6bWJFOXZm
SVJKUzEKK0UxUDFNaEJGTElGeDNPVXJaend4OEg5SlZKUWkwcWZWYjJlZyttTU9yNkdXbTladXlt
bnE1cnE3bVZ2NmZuZApPcVZXK21kNjY3ZU4vYnRKNnBTNTdGRE5idWFhaXRNSjkyMkZPQklRbERZ
T084cnM2MUkwM1lTMEhqZVMxMkR5CmVLZEtUNnA0eXFlOC9sKzJUa0U1MzUyOG96SytWSE5VWGtT
MFJyVnVKUHVpWGVFYXBNaWxwaHpjQ2oycVpXaE8Ka3U2MGJtcWRCZWQ2Z285TlhoZEloSWlET1ZL
SjBuZlFqRm1SWlV5ODlzTmFXc28zVFl0dm5LQ1Bxb2dOYklWago5b2hLdGwyRmJIY2txdW1YZit0
eWFKWVk3SUc5SXFnT2FJTGV6b1BpeXh4MXNvUVdwRllIUEJxL3RLSTY0aVZGCmNWL0Fna2tJMFBz
cmQ3T01RV0JUdjlDd3dWQkRnVHFqekNNRnkwVT0KPWF6M3cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000048289f061906440b--
