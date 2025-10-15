Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258A2D9EF2
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516910; cv=none; b=PSY3tHsdz0ck3pOHDkpZ0Bs1HqK9z7q8G/HpvIYduDg74fLdjJHECmZTkUYMHyfJg04KTRbdIbq8cuPZmPVwUT3jjj4K6R625C7DsnRjM5raau7E7MQqCyGxSZVQgT4nDNro780Ohl5zsiyfYUpCTh9afIHd4PlY6iTA1brtTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516910; c=relaxed/simple;
	bh=aUnCj5mW+V5FN/ZuGBggrW3wslKgcKCwShqofArTIc0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ISTVrH4IyCMaIcIxm6v7jygF9GvX7mQ1kghtv9yDv5B2u+D9EdwhqUOT/vRc8tXkGcadesJ+ESFw2YpVAt6SfhnSdjx4e6Ym7oFSfWncwV5tKetSQHxJTby9//gPdYgqxx+3JW0Lflo/lVlwp4Nampy119hzlPAeJh7d6LQaJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV3xjwlu; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV3xjwlu"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-930e4af2535so705844241.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760516903; x=1761121703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aUnCj5mW+V5FN/ZuGBggrW3wslKgcKCwShqofArTIc0=;
        b=OV3xjwluG6QZyIi8px/Fk6yINI0JxPeHSSjnY4p/1ypJjh9CJDZP6kvMUzvEO0I/L2
         J/TKkoZil5oDyDLjI9CM8G8Jg9KvkEYcsQGUdmpMAjR0FkkeOzGryv4ksVO9wA8yuYki
         p9bNSdPgWm1b2GDGdozuec3nSrYjidIhb3jIkI++aosC5luSf1tTbP+ScMtUeJgHqxvm
         7fyr3+ny/B6Zp1k83wY9E+SxQV2GgL9SuG9O3p7PAR6vM1TmZpnB7x4R8KXdlATyavr4
         EdyS5fti/w2S9Sns/Zkavyk3pSPz4v03Xfsu49lebAcs6Efnocsm/fGD7OB0qIKCp1UO
         +w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516903; x=1761121703;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUnCj5mW+V5FN/ZuGBggrW3wslKgcKCwShqofArTIc0=;
        b=P45dS2l53oPAuKTkzq8PoQkaz006QYBk35SacQY2K0CdmSVw19EBaqTzI0QjP2bESm
         9N4m4E6eJ/ZHbEIAyLvT5LPeqHac+c28f2QwH4QZZbnAtQSqKYdb+KCpbxZhctR28JQ6
         REePTRrlhTywqW2W+4gp8QzXLnK7GS2d+IWvOhpluIqs2Kyqx/2MwUSSsJwmdygHwaGe
         t4m0cX0vpQbwpOY5GSnnGCoewly8YzYwGpCKYrDHPx//H9eeh9ja8zg0T6qRTTUVJ8Qc
         bijOnIEEX38x/jQC3EpFaFTUaqqFfy4PGJoINbemOrpRJMgHh9s8WhGiggtbG2uhUCgh
         gD1w==
X-Gm-Message-State: AOJu0YzzSMKCSgExnnLprn+8ezZwHZnNQjGUPmRGBo0CS79SGwREfXmv
	kwazorGsfhSgPSmMSGVT//oN3rJxDnkvHi5mifbb1o2M/ntisXU9fNFXVU/9F0uIYknQJqASKpl
	YSWzJpe2VPKEDyqngVr2rSDq+nbKQmkBe+XMI
X-Gm-Gg: ASbGncsb656yqotx5IvjMJWkWQ5bu63+zUHMDarSDy3Et6M3ldyOIKmuqVl5JW1X3W7
	ce/4q/hkaznZPnqy8yHYgq97Fu9a/b6S0UrIJ8aqcJmiyUolKZtiGts1VatQKQzmDenz5z/j0uA
	z8kATiFiJzFfwdJKG6uOS3jMn1Z3r2q2TaJb3MGZBjIBwsDjNH4HEJ4e8hF4tDB2IUkchq8IbYq
	FXHzix38qYo6coyWDsrb8Hkpi6MOfkAl/d2kw==
X-Google-Smtp-Source: AGHT+IFM4vgYy5gnwfsMcA1HGmijOUhvzr2/Fa19DXrmTMhZQFgajtAc/dhz9nxZJ0LRmdhGMXzETV1Grn5Q3WgPm1Y=
X-Received: by 2002:a05:6102:5488:b0:5d5:f6ae:74b2 with SMTP id
 ada2fe7eead31-5d5f6ae7571mr6636235137.38.1760516903066; Wed, 15 Oct 2025
 01:28:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Oct 2025 01:28:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 15 Oct 2025 01:28:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOZq3HlVV7tF4VSJ@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-4-916cc7c6886b@pks.im>
 <CAOLa=ZRQuLa_xD8GzynHNmNZuyoJeK9dCBOKbUfkCES4ejG0OA@mail.gmail.com> <aOZq3HlVV7tF4VSJ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Oct 2025 01:28:21 -0700
X-Gm-Features: AS18NWBJ5BDa0D3nYYzL-gs3ys38CWR0nLT-iy7XWwL4Uoh66pLM4Q0eeICMwNA
Message-ID: <CAOLa=ZSF25OG2T5cXtYArVxEqr-jRcMnha_yENTMnsG8sZ+6=A@mail.gmail.com>
Subject: Re: [PATCH 04/13] refs: expose peeled object ID via the iterator
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a1082d06412e485c"

--000000000000a1082d06412e485c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 07, 2025 at 07:52:43AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > Both the "files" and "reftable" backend are able to store peeled values
>> > for tags in the respective formats. This allows for a more efficient
>> > lookup of the target object of such a tag without having to manually
>> > peel via the object database.
>> >
>>
>> In the 'files' backend, I thought only packed-refs store peeled values?
>
> Yup, peeled values may or may not be available with the "files" backend,
> depending on whether or not a reference is packed. But the paragraph
> doesn't really contradict this, does it?
>
> Patrick

No it doesn't, was more rhetorical and self thought :)

--000000000000a1082d06412e485c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: cf7716c9a559a195_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdld5UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGJwREFDQkd5eXBYRkhmVkJKczljbWl5MkgrT0FRdApOTUFrVUZkaDZO
ODJ4cGpMUWlTTkZmZ1YzL3BYT3hWNkROYmpDcDlmbU93aklMeVBTVDlQK0xNSW5kVXpra292CnBU
dHF3NmxhYUE4STZYWVRUaEJSMkhVV3k0Mjhld1YyOHZvajFNaTZuUlpKTW5XS3ZQYVo5Y3YwRENM
c3BVdTQKMDdiUit2eHVFNFl3a1lEbi9YY2JmZ1RPTzlsL29ERkdLRHdTMDNzN2RucTlVUHBIVFNv
dUE4ZkszZ0RoSndONgpwdGFPWGlaK3VDbzRpb1VpbHBHdWxxbHdmbXg2enZoNDJkK3R0ei81VEdo
bjVIQSt6SC9oODVWQXlsR0N1UTZMCjJxamxpSXpnaFhTdlU3cUVTUko5MmlKbmEzakpDM1NiOUVX
VDBLZzFhY1Z4SStENnRycjI4WVluU250L0pUd04KazlqUDBWWmFOU2M1MWJSdzNtak8vaG1TbjVE
R1JacE85QjEwWVE4Q3pQT3Q1Y0I2UVZBNlBMZkJ1dU9wN0VTRwpNMlJWMGFOWWhScExXK3IxM0kw
WGhpeTlkOVltNGFjWFhIeVhNZzV5N1Exc1pkRDBKbmVTZiszZUZWQ3RWNFh3Cnc3VmhoMnJNV0Js
emlrV0hLdWw5bWdpWlM2cHB5NFpabStvMjR3TT0KPWNrSGoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a1082d06412e485c--
