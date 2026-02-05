Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A573ACF14
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290544; cv=pass; b=IFlzD7iTzkRdkp32hiOFC9PnzOep5ur7FC6KB/p/nLj5XBGq51dDFd+mxI4mG5fnor6UxOQ0lC2JKhJzdW2c5lIW4/Uebeuhby7MFz0Jr0G9/5Wpi/vvEnryI/iZY3/62FhQVZhuH8CkUwMJNOErYA3nbvcwIuZPMptM0JFOgCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290544; c=relaxed/simple;
	bh=ijZQKDrbhHGgmHr0w8vwrYzCU3QudqnxbHcl15pgs+o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAO387hJSyEg9FOlVfmjN0RNaKxiAxkbULS8jrUxKswJOQvrz6evJVN+v6TPqu6oysrdjIcLBWi/GOGgFTaiAUpFHq4L/qJq7USJIy7kwJImV9eywN7fWtVGrdQuLC1i64hJfPOJKueLyCeQatTJEIu6QzdCA4IszyRvUmFaZnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc8oisHv; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc8oisHv"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fa26e497abso299401137.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 03:22:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770290543; cv=none;
        d=google.com; s=arc-20240605;
        b=D52EBkX50RdEwWY7NLjdpAefuqE2uwZ5NN+xwhZEZKbtV2qLffv+Am/C38dHXa1DeG
         Kh6/69qScEOAHcG1ci8jn0UkLKgS5Q2Y9vdoLGrmTzEm9j4/bU9xEAG2uvC5LUzo6VRj
         JFT/hpMuU1QsmIOpfZtAZ+WiPcxFay4QHFH/TmoYzLlhvcgBHvQopcwwzTrnybJyw1ms
         HSjId08zTL0x1NpXtvRUhNyQoaxGieicNtoCtx2YY0oRwp2vaAycKubOU9tfS4KEgyEG
         QD19GTS4QsQpOOpjBwZPx5bifLfzeYRlRWQhXz0QONqspnQ2Y819ONO0BUi5Yw7C043r
         o3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ijZQKDrbhHGgmHr0w8vwrYzCU3QudqnxbHcl15pgs+o=;
        fh=5qca7/jlTeJ+EQxzugJG47P9PlCzUHj/yIqbONCC4Hw=;
        b=EfndYP3rRv4+IIoTO/3+0csB8obYw2hGZ1p4GN8f4WNTQcU1l2tnNimv4Ur2BE6Y3E
         MgRx071MZ8AfMS45/IBZK+8sOTZX4qXZtr6SOeNnjrjFhsJY5w1C0zdqp1nQBGuJHkyQ
         0yAZCE9lWEv3lNFLP+jT+U/tqpwYbzfGvc16nNjSMsvRFr3/OdZgj4k2OA7GwFk0Gkxm
         qoX2Vo+yMVdT+1PXINvzfgkFARaNox74Ms5zXVYrrZVhYfgLsp1q//SwNcj9fJuj2KzA
         IE12585DBoadRnz554yeJ+lYeXFJcpJpSvMsx7i1Wu9B9SKEFfCMSLY2ucB9YTSrRkAT
         Rsyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770290543; x=1770895343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ijZQKDrbhHGgmHr0w8vwrYzCU3QudqnxbHcl15pgs+o=;
        b=Sc8oisHvTsYP0QFc4uzSpJgo5LQDFu1hk6NGWbdcyZzx3MNMYNJtdf/WjIAGPA+vSk
         NWPQ0q9WJJlUFI/78lMTOJcDwflkzk4P/6pCbSgxL+3DgoE8cZ0yroOqjygxEfjQwYPZ
         cueHJf4+Jmo7weCiN0aWSTbVdQ0fhL8SIyTupQNmdby6LGgaRZg4s4ksgGBKAGAQBGmQ
         RDHAO1HIsSnSt4TqUOG4Zd/iHkN6MgGP8DAgQ8siZ4cDXPj0XQsM7STiDgqToLz8oAG5
         +WZAnNIaNV3ueA1bBuwLFMegQq288v60Xp5mfPIjAw1vhAGguXAUIml83C8zSAl9iDSF
         oacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290543; x=1770895343;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijZQKDrbhHGgmHr0w8vwrYzCU3QudqnxbHcl15pgs+o=;
        b=NElCZSaFco5c8a0985OHh7d3pReeLebok1U19XukMJNSuqijdNnxOium40uCNilPc8
         vW5/0sC8TYriRzz2RSCVu9ZnCLmDeQ0mfOXUiTjceblG38YUlSkJVdsljsSLUk4BNjq+
         Hfn00tQXtgTcVjA/0Q49N1ARKS0auYIh/IKGni8ho029O9Y/wRQ/7dlDpqQNnkmYmz/C
         TgOQHilmoe1M+qRxqU6JkqDNnoffdy1Ze9BFzPR35lu+JIW3+pFqEOoBZL9yALxZ/+pi
         pPJtZDtXscOp3uEJ6X1oWEUt64UD12qJUwEuFcZ9cBjYJtVivgtraD0dVqHPZPIzuiAH
         InNA==
X-Gm-Message-State: AOJu0YyVjwfAaX5ZkST2suNv5scbfuHBbI2qcmL0p3Eq9pZNF1HjYFIb
	ojTXbqPQ+ozHSxZe5tFX9HkNurhz1e0HbDo2RQzHq9hRTw2B0Z4DbTipS/F2QBnCAqBMQzl2mhX
	dRvOmZPlUjDg4b9dTZiio3NdKPpBLPvM=
X-Gm-Gg: AZuq6aIZqVJS0+5cccvpEOw+2MgCAkq7yjOBMrmCAIISf+sDHfjRFyeTYihAnorx8+o
	zCs7TtoIzPoWU93YvIF0JJQ+qgeQ0FQgSorzOUL2Jaqaym7FlinTqYhckB8tF1b5xp3w1P8EXHd
	dg38jSbMXSke8lOqI1qotWfWI6I4RaGJIjYqSBXSEDj0MjYDtlvKHnfYIDWpKMPRAq7+LX1XKXy
	FZNDOSM+w67fbGgocUcUMRCG9BzhKAyRaq7Jg9bkHPw595vh961jHpcjPx0lm5KaJcCpGGm60PS
	yDiiP7jwZNFF6GfJGJSNzcRAIvssgA==
X-Received: by 2002:a05:6102:2ac2:b0:5f5:3c96:983f with SMTP id
 ada2fe7eead31-5f93947defamr2141288137.1.1770290542773; Thu, 05 Feb 2026
 03:22:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 06:22:21 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 06:22:21 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aYOEQUIPXPIYeCw-@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com> <20260203001002.2500198-1-jltobler@gmail.com>
 <20260203001002.2500198-5-jltobler@gmail.com> <CAOLa=ZT_7o_YquQ_mAg6sn=gq0Rx4Tga4vNsVsPt3jCUh=3tzw@mail.gmail.com>
 <aYOEQUIPXPIYeCw-@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Feb 2026 06:22:21 -0500
X-Gm-Features: AZwV_Qj6cupxGHU9rvMCsfyr4Kg9SKcKUITKVX9rNDabVdZYLZmfTZXcWwdieq8
Message-ID: <CAOLa=ZQyW4VPuYC+isjx7h1m5-vix0N9M5+TsXocHaFU+Aydbg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] odb: transparently handle common transaction behavior
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000f3a2fd064a11e203"

--000000000000f3a2fd064a11e203
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/02/04 10:34AM, Karthik Nayak wrote:
>> Justin Tobler <jltobler@gmail.com> writes:
>>
>> > A new ODB transaction is created and returned via
>> > `odb_transaction_begin()` and stored in the ODB. Only a single
>> > transaction may be pending at a time. If the ODB already has a
>> > transaction, the function is expected to return NULL. Similarly, when
>> > committing a transaction via `odb_transaction_commit()` the transaction
>> > being committed must match the pending transaction and upon commit reset
>> > the ODB transaction to NULL.
>>
>> But isn't this merely a limitation of the current implementation of the
>> files transactions? Couldn't a potential ODB source support parallel
>> transactions where this might no longer hold?
>
> Just to clarify, this limitation exists per Git process.

I missed this, makes sense now.

> For the time
> being, we only support writing objects to a single ODB source so a
> single transaction for object writes seems reasonable for now.
> Furthermore, the current "files" transaction backend relies on the
> tmp_odjdir subsystem which means only a single temp odjdir may exist for
> a Git process to write objects to.
>
> -Justin

Thanks

--000000000000f3a2fd064a11e203
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c0c53cb68679aa8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRWZXc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meXpvREFDS21wYnZNNUg5djArVkZXODNIUHNZMEIwRQpTaklRd1dvWGZ1
OGtZMjJFMFJGVHZXcDAzeEVsQkZHK015cHFYclJFMnZQb3ViejJiWndCeFVXNytOYjV0cG91Cldk
QjFtZk9HWHVNRDIrL1luVk44Q2JYbkd1OTFLUFB5UU1kNEY5aUpTVmtNaklUL0NNcnlUWmtwUm4r
b3dDa24KbEJLUzVobUZNSUQrU0VGd3NsZ2FTQkVzZ2hsSTlPN3RERDhGTm1EVS9MSVlJRTcvdXpI
Wi9tMzBkOVRWTm91dwpvUm94UkYwWXVLcUMwUmRLQXJrYW1tRUJpWEIzODVtNTdkRWJubWp0RWNT
L3pCby9CbTZQa3VTQjlYZXliNjFwClhRa2tPWFkvb0NmQ3U5RnpXMlQ4d25pYk42Q1ZRcnU2MTlP
U2tRL25JdzdZUVJYMWVXZXBWZTRMUmdHOWI0eDEKazRsOUU5UTZ3d3dGSzlhZnlWYWlhTGdIQi8w
b2wvSkJNZzMwckxINWQxcjJyZTBnUzhsbTZiQ2owbDF2UStDcgp1VmhWWnJ4ZmRoR2hOTUJ4cUFa
cGgxUW5nR0g2dzNTL2VQMm9uREtqQkVBMGx3M0xpSVg5Ull2b0Y0N1V6Y0tMCnVidDc0bzk3Mmgw
cUdjTXdjQjd3elU1aUNQeHJBRnhSQnZxREJSUT0KPTV5U2EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f3a2fd064a11e203--
