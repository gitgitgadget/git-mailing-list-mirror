Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB261891AB
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759826726; cv=none; b=f4zmmbb9V4C7JAxtcclBjOVz/43BYK/k5AX6YJNHmW1jKOc6KFOPWqzbZR6kexd7Ig49+6DLdjBtGJJqyzK4jfOHCs5Hc2n0B8aEHkmRFNSx4+QL/OMHo7ZKp8eQztwjrxy9q1ff0xrLcMzLFhwoeOK6Zh9t4btVLuHLH/vq9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759826726; c=relaxed/simple;
	bh=tvMYPtpFLGPHuANq3qYny/rqcp6F71ALpsNzb+xQ5Oo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHgr928HYqwEa8Xn6o5TCgapnMFNZrJMo2zHOBcU1N6yiZ5NzfMta6KVwQk7cNBf5S7uTXdEhiHIDo6zn1we8wgKrSm3MnMdZX7++OdbQ5wqKVglGVTI858ExPDPNv0f9owS0QTqmSD1dDYO/usS8bHn+pOZ7ME/C6EYIMC4MFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS2sLc4k; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS2sLc4k"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-59f64abbb61so2917435137.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759826724; x=1760431524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIcjfY0HzsfjM9uPmRXU/UP/6Hx7fVDUXOK/eimCVig=;
        b=PS2sLc4kMbTrgoEPZnxaRo0/tmD4hlmWO05BPcFuK0zNX2TIDGirC0+zMIoFGtmJDA
         eVhx7MgCjuP+qXIG5v0q0XIV/ODXCBTCq1jtGBC0GTAb2n2gsi7sI1ry7fMSQk81gvEF
         Nm/IivgUm5tYUNW/ze4MQbdqY+e7LJVSW3/5AmlPt06Hn9R84sWGQbbYjB4mMldDUJnr
         n+kOlEd/BVmKU6VMO8pOYcbpFKdRR729fs55AN9YnUfF2+DYlY/BdOxb/M77Muraj8Ty
         qJb/uKccVEbECwPYghSMnZ3RWDE6fogIjxdCiwLy06IGQF8cFvnz6S6m7m0hf4Myd44R
         WOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759826724; x=1760431524;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIcjfY0HzsfjM9uPmRXU/UP/6Hx7fVDUXOK/eimCVig=;
        b=g99w7mbZ8R9dTQGKuLlcrgjkEMWO4OHgXl8FIJsnE0Qqxben8a+/T4ef12HQaJ+VHu
         x8UqPjPO/psg7VGZwwqRcLmQyTTncOeqlUQB+cjNmAWgzwZ9xVv5UTbMmKwimPMl2PEf
         kHz+EXpCHqVtPXcE0Q+9IRp4ceC6u4CRxLXyVy/ijwEcgkzM3lEDFgdDlotsStiTAG+I
         EhcrV1bGJIsOPUsfQrmlOIVuPdnK17t+Bc+bCkvCujkBMLM85Dkx14DeZ3YfqrtBBGvt
         seuXCfc4ny6iUz8jMmWqtgOIfEn8a/A0wjiJQlBROd1e0eZpnZomkymXY0PJ5pR9KyDF
         5yYg==
X-Gm-Message-State: AOJu0Yy70OBTw+YNHDkKyqlZanbeQkZ3ZeIYYNXxkJLnndMUdRPyj49R
	93Vm8Ac1seNAnKqjoXAaJKF8ouRGBdkfdwcCbjSHDQoZ5ZauThFzubVp4MCEBwUsmSsuVYhHPVR
	plz8l9RUiD0ztOH5ya78tKgFM16XNeFM=
X-Gm-Gg: ASbGncuoN7/hhnYukFrRWVhNjLe3INLvToi2aWbd5P2/IybwS2DcWRDwhpXOjCVf4Sc
	FOxXJ+wiVJw7CAW+pvLZeAS0uOERQsaUANdei7CdDyK5PAoqGfw9rtv5m025n8yNIMB6VlyZXHj
	jfvMPYhCBaHWucd8/yDn9SwoULwY4V4bu3Wx0lKPRYsG/ZG3KRI+aevUS885WLfrARh7J0n8QNP
	Wfa/qxrdb/KoV6F0krtYRB6ryvVQPWEwDXwL5fV6CD3Kh1caSWA8xJBziUXP2JK/Q==
X-Google-Smtp-Source: AGHT+IH2VBhsRhBwMLEYJ4PmvFiCPmxqXWx3jKmqq4c3iugK8p3WS0O9y6tSV1t3rSkUk4J4oU2pbgFHVqnRd2Z8xQw=
X-Received: by 2002:a05:6102:5ccc:b0:523:863d:ece1 with SMTP id
 ada2fe7eead31-5d41d10dc30mr6088255137.17.1759826723576; Tue, 07 Oct 2025
 01:45:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 01:45:21 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Oct 2025 01:45:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251007023242.GA2747748@coredump.intra.peff.net>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
 <20251006-228-reftable-introduce-consistency-checks-v5-7-f196d386214f@gmail.com>
 <20251007023242.GA2747748@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 7 Oct 2025 01:45:21 -0700
X-Gm-Features: AS18NWCitoy9h3YNs4f86EqPbT_qHLwUbi6meWd_Zpy_Bu6xiH8NMj2Q1sDEu4M
Message-ID: <CAOLa=ZSGsfhUM+cn0XGDJnFHLswxYqSOePPk+LXK0g3cYjaXfA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] refs/reftable: add fsck check for checking the
 table name
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000b9ba3606408d9627"

--000000000000b9ba3606408d9627
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Oct 06, 2025 at 04:23:05PM +0200, Karthik Nayak wrote:
>
>> +test_expect_success "no errors reported on a well formed repository" '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		git commit --allow-empty -m initial &&
>> +
>> +		for i in $(test_seq 20)
>> +		do
>> +			git update-ref branch-$i HEAD || return 1
>> +		done &&
>
> Did you mean refs/heads/branch-$i here? As it is written, it creates a
> root ref, and the name does not conform to the usual rules (all-caps,
> and ending in _HEAD). There are some holes in our checks, which is why
> it doesn't barf yet, but I have a series to fix that which I hope to
> send out later this week.
>

Yeah, this was definitely a miss on my side. It works because currently
we haven't yet added reference level checks to reftables.

This series only adds stack/table level checks.

>> +		# The repository should end up with multiple tables.
>> +		test_line_count ">" 1 .git/reftable/tables.list &&
>> +
>> +		git refs verify 2>err &&
>> +		test_must_be_empty err
>> +	)
>
> Arguably this verify command should be complaining about the broken
> names, too.
>

Yes, eventually it will when we implement reference level checks. Since
that's missing, it currently doesn't barf.

It does work as-is and we could leave it at that, until we actually
implement the reference level checks. But I think a quick re-roll will
avoid future confusion.

> -Peff

Thanks for the review. Looking forward to your series.

--000000000000b9ba3606408d9627
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 22033c44f5364b11_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qazB4c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlR3Qy80djJNWVB5dGoxV1JuOXh2NkZBeDNITjI1Lwp5WUJvSEdQdnMy
aFJvR3JXVmhLUTJvaEFDQi9TOG03UHpiQURXSXFrMFA5SzJzM3FuSGx2SmJST054TXlWL1QyClNx
cnA1dTJ5NDJUSWo2eUZhSngzV2ovQWhwdGgwRlhxVGQ0UFp0TldlUmdhTURuWXRkNkthMEtoWEVi
VEwzYzAKZk80MC93bExsanUwVmJxTWUraVpzbDVNSzlJdlpTZk54V1kyV3A1SmVvdFRPejFUbTBx
ZDhGNE9HSWRkUEFwaApISDdlTS8xQjhoTjBBUlNydDQyNVduN3c5cUhvQ0k5cWpRRHdPNUIyekhx
QlE3dXp2RzhDZ3NMV0hYQkhIelZXCk9Db2F3THFNczJFem5tbEFxa3lSbGw5b0lycXd6ZkpHenVn
QitqUGkyL05GU0VVdkdRdm5uUlROVzBhYVB5OHIKT3gxaklnZ1NlNjIvdG5LQ3RtRkhOakg4VlFa
VXo2Nk1Td2p3WHZpWmEwSEkvZ3RuS041R3RKSEJiZ0dRK0tJOAo2VEgxM2ZGM256QUtpUVZEMUs2
S0oxd1RINzZZL3phR0VyY21YazhoZ3ZYMEpWNFhvSFFBZzlJOXRPTHdvRkllCmF3TWxZek9RY2wr
dWdxam51N2t5eW5jODFrOGdNbGEvWnZRc0xNdz0KPWRMelMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b9ba3606408d9627--
