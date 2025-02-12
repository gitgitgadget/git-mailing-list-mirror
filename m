Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0592046A3
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363665; cv=none; b=UktqC43vgX23XVqYcqQQZg+QFfurx9DMzbB+3DltO+IxDvTaKyeWillxoYXIImpVYl8slvDtqzxpV6R+VUpzKBdUUpwrSMoUGUSlCbvNoX2WpVHvdH2jsmvV88VDzOyO/Pnng/Xn8lVo4/iemw4ekcUerC/pRXYPEYt8iWZsKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363665; c=relaxed/simple;
	bh=dbC9RmxlJV5l7JAYhggmTVeifrur7/K8IgEg/T5v3nk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZ7SjfcCnX7Qkmy3FbYQXz11zFlrkxZtjLA7B4wTrRt/wIXvvPLoE8SZtUhNwg3wXvBMKBP56Oty/d0f2JV9UE95/apAN7ZaQxN3GPbKqWtLcoXV/KRntOiAhqok0NFamxbOg8+jIo0RcGid9eQYdYZebiCQVi/c5cIX0cUczTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0AA2rs4; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0AA2rs4"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-867044e979dso1705060241.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 04:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739363662; x=1739968462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbC9RmxlJV5l7JAYhggmTVeifrur7/K8IgEg/T5v3nk=;
        b=C0AA2rs4pmV5YCn1ZUvY9CglOrag0tEczx6cEPDVst5oPQGqdOGcHJdvnsbUAslXQJ
         EtTZbybSny/1KfkJPgcVWsO0ptURUid8WOlyxsXU8qF2S1WmliIUU3msjNhiVuabAVxd
         WuMb7yzo3Qxl0kbbWMZzSTPHtOE/xmlEpgsEfRALAr4nj/ifj1ReBskzF+K5KYvvwiE4
         cG2JomFPS7b8ipR6aRLh8HGQK1D6J7S6HbezuobISTxVgHNnIvmxiaBb9qCIODjJwbK8
         CIOiZn0z/khPjeqIuxWhTxyrrJ4qmNDTiMG3FbdNcWk2dkCzobjbytHmbi5Xx/IPbtRk
         t8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363662; x=1739968462;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbC9RmxlJV5l7JAYhggmTVeifrur7/K8IgEg/T5v3nk=;
        b=qLBmFt1Nb7aRMbbzWPOY7e403XYObBt10RQ2ECi5LmomxIH6beO2fhBcKkI6rNGz1s
         QvCPTyuIfyqNz3266xbi5oUiH7i1XEjsZzeV2kEJM7Jd4qGQv0aG42kzt/lV9GvZxbKV
         rgUu3XLtlKf/AZqlVRmUmAjIfqnUVFV/IwTxBftvK/CVDlWcMuQkcpe+8rNrP/78vjot
         F7IEInuchNiQgS13N/CKhnkfbGY00Mg78EzlW4bqnl76bhyXs4pI7vX5JSGxPNQV0jy+
         quGN768rCAgeMJ7jEAagqacxgbSrcSk5feKMSBCJ8CdS8lwuP5sKnuG+R9rYofy5LKXa
         R4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5woIvzI5sC/f9CbJpU11SQRd45Nw5sUWT2uOKFWU2OfMlflG2+Km+IcwN6hvUsv8PfAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvxg3/GTx028XsrEnupzBdf5xggKyk0RWZPohv9Wi67jwdkVCW
	dB6Y+dWAT9lSTwdixuC3EcoSh7GCh9UxpFJb/jYzUNN2gBsTTIxXWuQXpW9wg6433xaRQmZbXiW
	iZ+q/1fSE2DBCnDPCDH+Dk3b2g9/LVmr0
X-Gm-Gg: ASbGncsCxJ+0pAkWeaBV2vXjXeDC2BSYQs34wUVxA+E4WrbysXJN6bzB+KmKqEbv9lw
	q1qQIl3p0G97Pn9QMT9Z2NTU5ro7uVhOQwlZg2YHOmXNbmAeSzK8724OIMch+UYs84srpDHbT5D
	yue/U3wo2CkIlsjbwkn+F2Vnp8R/9YDIM=
X-Google-Smtp-Source: AGHT+IEsoR3WuHD907TPJivYee0VHBtdgaMllNkReIW/EN32piydemI0ATGxAfofGxzdw5hOZtwvCnyreOFOw6H6UHA=
X-Received: by 2002:a05:6122:3d15:b0:520:420a:a07a with SMTP id
 71dfb90a1353d-52067c8b4f1mr1960123e0c.8.1739363662463; Wed, 12 Feb 2025
 04:34:22 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Feb 2025 07:34:21 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Feb 2025 07:34:21 -0500
X-Gm-Features: AWEUYZkjoOdcAGZlEVpSO3QqkTpPsOOg-6Cxsd8FinnRQki_7qgUmxdjpE2XLIk
Message-ID: <CAOLa=ZQF0=WgW-2HumRbSp4rUjXikEfecjp5Uxp+zJ+Tun5yzw@mail.gmail.com>
Subject: Re: [PATCH 0/6] refs: introduce support for partial reference transactions
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000003cb0f8062df129c2"

--0000000000003cb0f8062df129c2
Content-Type: text/plain; charset="UTF-8"

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Karthik
>
> On 07/02/2025 07:34, Karthik Nayak wrote:
>> Git's reference updates are traditionally atomic
>
> I'm nitpicking but the updates aren't actually atomic, if a transaction
> updates two refs then it is possible for another process to see the one
> ref pointing to the new value and the other pointing to the old value.
>

Good point. This is true in the case of the files backend, since updates
involve locking individual files and during the commit phase, there is a
possibility that one ref is updated while the other is yet to be
(committing of the lock is not global but rather per ref file).

However this is not the case with the reftable backend, there, updates
are written to a new table and committed at the end after locking the
table. So in the reftable backend, this is indeed atomic.

>> - when updating
>> multiple references in a transaction, either all updates succeed or none
>> do. While this behavior is generally desirable,
>
> Isn't that the whole point of transactions?
>

Yup, this is the point of having a transaction indeed.

>> it can be limiting in> certain scenarios, particularly with the reftable backend where batching
>> multiple reference updates is more efficient than performing them
>> sequentially.
>>
>> This series introduces support for partial reference transactions,
>> allowing individual reference updates to fail while letting others
>> proceed.
>
> This sounds like it's abusing ref transactions to implement a
> performance optimization.

I understand where you're coming from. This is definitely a stray from
the regular atomic behavior, that transactions promise. But I would say
this is more of an exception handling for the regular transaction
mechanism and AFAIK this is also something that some of the databases
support (see EXCEPTION in PostgreSQL).

Overall, we're adding an exception handling support to the existing
transaction interface.

> I wonder if it would be better to provide that
> via a different interface than shares the same underling implementation
> as transactions. That would make it clear to someone reading the code
> that individual ref updates can fail without affecting the rest. Burying
> that detail in a flag makes it rather easy to miss.
>

Thinking this out, having a different interface sound good, but I feel
we'd end up with the same structure as currently presented in this
series. Only other way is to really split the implementation to support
partial transactions as a entity of its own. In that case, we'd end up
with code duplication.

Do you think you can expand a little more here?

> Best Wishes
>
> Phillip
>

Thanks for engaging!

[snip]

--0000000000003cb0f8062df129c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d904b9ccdf163761_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lc2xVd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK25TQy85MVZLeEhnRlloT2NZNEhMY2c1RXM4WmFCVQpnNi9FU0FRNWdN
RitYUk1FdnRVMGtmNTQ3Q045djZxdWhtUGE0R1ZiQU5SSUZsQitMOHpnZm1ReDExV21YeG4yCk9H
bmJ2N25BZEpHdXA5anZsTkEvaXlKbTNiVGpLaUZOdE9CT3JGMm4rdzhTVkJGL05HSlZORHZjZjIy
OGdSMGsKeFRJQmt5TDNGNjZ6WmNXbjNSVnh3NUhXQXNremIwOFUzeFI3TXZTMkgxVUxLNE1Uc1Vy
OVRnbFR5K2VzWHdNSQorczFwM2RLOVpVaXdnQmQzd3NHRlg4RG5DVDV0czVHbDdXM21hWXNOVVZi
STBYTTBNRTZQN3RBdGwxZ2F3STlICmZscUx4WHBrYjNPM0tHWFZQMGIwTStjbjhEeDhtSVdQbHdG
MTllSk82SjdoeGNiSTFRMkYyTjA3UEF5eHBoeVoKQlFwTENKYXVJNUh0UzAzQUpsQ1VCNjk2aXZt
M0hkMjQ4bGlBeEw4NVNnRm0reTN6U1RSUTg5eGVFd0dGNkZLUwpqZEcrNjBQWFdvbmt4UTZMeHBx
SnVQNW1BaStibXNqc2RnRTAvbE90Sm4rdm9mWDJreGdJaXoyOUIvcTBXOVYwCnc4YlVpLzJ6bWlR
bUd2WnVidjhoN05WMVJHa3IvRmFPNXdWMkJUST0KPU9WVW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003cb0f8062df129c2--
