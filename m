Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF001F4CB7
	for <git@vger.kernel.org>; Wed, 14 May 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248712; cv=none; b=POtcbbrNIt7alSnqsN9ujeeaTj+pQMHanCCtScpC//A37aeT5DOXvMarZnV1KtJPnGhcn2gsoTEfq5MrXgOr60I8Lj93FJRdwJPMt6iT3Y9N3ctQ+6nbMBzoX02icYTU7mqQnD83pRD9aa+duoU54SMfsk9RwC5FcKt4GwAw5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248712; c=relaxed/simple;
	bh=osoCpCBD+ISDohnTZfcrNOwWSZiupM7jADNINNVNI04=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=UZVjv9/J6ii3sNseA3HXzGd21MC4fWfJAXZlW8FHhUmImBWJDh/kh5lKZh2V4sV7xevwfPPaROKgsQe7f+G4L/aClirpzQy0Pdk6QyRY9nCROLlk0Ne+abwstnztA0kAKqi+l604S6itTpCpAMLqwl1GsnzxJjAmdpuuoYu6VZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2piwsiM; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2piwsiM"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so31011241.0
        for <git@vger.kernel.org>; Wed, 14 May 2025 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747248709; x=1747853509; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=osoCpCBD+ISDohnTZfcrNOwWSZiupM7jADNINNVNI04=;
        b=G2piwsiMoH7TBkKAeTz0Dph4ml2uxtlRIpa0EC4Yt9pRLGdlotok2PgoodcPpHzIOg
         1LnHyOYJ8oDoUpQyifVjSrESWkaFCyh+POX0oBIzOpbcEqYeZvEQu+tFGQ6YteUYs2sG
         fYoGK9gqeC4vHIp+qJKZTEuryLtBoDqphaHtHz0uYOBeLViJlziq/6G5LHwlOkU9HQrM
         n8WBkpYTYvIFtcrvdViJD3w+OYDayEbpZdItnjv20j/IzRtVfcwYqk5zyYHOX1lQ+wHH
         z1EUzSFqi7N0x1HX58rPrSX7mfY9OD6d+AESMqwcwJYxzD05aLAytjLSvTkUe3FgbNUG
         HiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747248709; x=1747853509;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osoCpCBD+ISDohnTZfcrNOwWSZiupM7jADNINNVNI04=;
        b=ZyGnsLs6HnoXQBDwwGrpYF/TGFDCBnIktqQ0+KR7uatkQK0TW/XFlhLmx0PXnjyIO9
         lESAcYhYXB5DAuiYRVO+WgkTWVIw6PlaXk+78Y6t94+GTDCM5HqvH9JA/VJLDOtFsh5d
         pajzpkKsYBQgS2KL8/1EIMIdie2hsIdJsnSZbClAAIPTuSxTS1xX5+Y/gtOSSW+XPVuJ
         3YXBcmH3IRydMgj88RIb0V2ZvN3xmI01J1n7/7y2IiJ6VaLCFE8U2uQfkdLqbcTEVoIe
         T6ZncR4IYnI6pwDKYIubv1W9EJIPaOcZGsU+Mj973WKbOvXSdU4wOK2k2jJrdU5Uo2RZ
         180A==
X-Forwarded-Encrypted: i=1; AJvYcCVPCNPYaYaqD7lvpaa+2wS9cZmTaXP08GgEfv6RbBJUD/TgpRfv8F3c0+NSaBYqaFNTvjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1x+ceOrbg/Ymt4WJjlUdQ8L4WoE/HlOsYMQE4/3MIdWZBcwP
	NgTYM9k/ZBOIZ9wZJOAEAmx7LbUEbQ6tj2DN7r29bHx0SlQGnka2ThnEk20/t7NRPoKCxaJ5JyG
	QD/ys0/McGgL16cEF6z7Qh6z7ugFGs6Sm
X-Gm-Gg: ASbGnctsQ0491RqY8a1wQw4Bpo88U8EAG31m05D3hX7ooUJPcGmDSbdTqbTIAOg8JNw
	1npi5Na7UC1KWsEkC7KN7r+qAJpv524p5AYs5civrLyhC5e7EVvRsrlnzBnrBA191Xh5knxwLa7
	Ugh7cSlXmV9QFOArtuBv//9pMWJioDTOBMIJBy5r4ho6WtNV7wAyyFN8Yz+UWwB5dn3m8=
X-Google-Smtp-Source: AGHT+IF+5HkXw18b/u2Epo2BhIYfaPTHCkf4SvNiQgQQagdmZ6P/KxFZJq5/w38vIqH3TUL7Ytz8WUQ7oaMHIA1ratw=
X-Received: by 2002:a05:6102:2c04:b0:4cb:5d6c:9944 with SMTP id
 ada2fe7eead31-4df7dc81800mr4701786137.3.1747248709322; Wed, 14 May 2025
 11:51:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 May 2025 11:51:48 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 May 2025 11:51:48 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250506-pks-meson-tap-v1-1-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im> <20250506-pks-meson-tap-v1-1-5aaab2942a4c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 May 2025 11:51:48 -0700
X-Gm-Features: AX0GCFvRgQQLTDRHIYhTzjhVL_dsgM9LdUklERbbqEJGHWId4Ki59fVMA2K51H8
Message-ID: <CAOLa=ZTN2V1DbWRBkhc+JiOeBnPQHNj6zBQwoKnXa-bqBm0NvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] t: fix cases where output breaks TAP format
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a76d9106351d0a5a"

--000000000000a76d9106351d0a5a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The TAP format does not allow arbitrary output outside of a specific
> test case. If a test suite wants to print any such diagnostic output,
> then this output has to be prefixed with "#" to mark it accordingly.
> A bunch of our tests generate output outside of `test_expect_*`
> testcases anyway without such a mark, which breaks strict TAP parsers.
>

This is different because `test_expect_*` sets up the stdout and stderr
redirection to new file descriptors, but any code outside that wouldn't
have that redirection. Okay.

> Upon further inspection, all of the output generated by such tests is
> rather uninteresting. Refactor them so that we don't break the TAP
> format.

The changes make sense WRT to the description.

--000000000000a76d9106351d0a5a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 29cbeec2bf486e6d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nazVrSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTU4REFDUHVyNC9ibk5zT3JjcmhTOXFVbDQ2ZDl3UApOSFkrMWlVc1RJ
YkxZeDJGV1I3SFZIRnVOR2MreHM1c1pYN0hreVR5am1lZmNBeEFhdlJpUUNKMmF3STNwSElTCktq
eWZnMnlBaDVUcHpDYmp4a0pVQURJNk9RVUZSV0xBZzR6WmFZblZUNVQ4Wnl5Z1lDRWQrUTllbkRy
VFNld3YKWUxZVnk4b1JhakZrMW5JcDYzZVdnRzBuMjFxV0lNZ000QVIrbWlpR0Y2OGRuajFranhx
R3gwN0UraytwWFVKcApBUi91dVYxSDRjNzk0QTZDdjE5blBQVU5LZVp6RHlEc2xVd3pHWWFMRGZT
U2VUcDRMb0krNmM4KzkvazJwdmN3Ci84eUZtUzJ3aUtMV1FtWGlGaVhVbmkvOVVxSmoyQzJpVEVF
VW5vZlVESHg3RGtWOUp4eXdmVm92S1R6RGxYd04KRDdGWjV2Y0dMQkVvWGR3bndnNE1La20reHNw
aStEbUp0d1Fkc0tWSGR3eGxLeFlHcEJlVVhUVkNMU0pZamJxeApRZVFsWkF6WjlYSGVXSmszTmZa
LzVzQVhVcWEyc254RHY1ejJqRDNXKzVPb29uZEcwdG1TbWt6Ujk0TC9BekxRCjgwM2VsTHFBMUMv
a01kM0cvT0Z1RisxK2lJQmRnV013akJucVZ4OD0KPTdBZzEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a76d9106351d0a5a--
