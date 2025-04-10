Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7520FABC
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276231; cv=none; b=IHqMYfIWcKJm6i5JQQDxY+87kdFZWNez4wo4Q3y13unqDEO14YR4c8UOYf3OKtDtRb+NsMuuEKkzpTEldP+av1irE7EVLiei5FSnt0QwWz2GxFf9E/URKK/BhP1V4eFLEmqSJT8kCdEFZBytCbXZ9+O0rkHb6jKXCa5YRm4kavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276231; c=relaxed/simple;
	bh=uSOuOFpN3GHpZc2Kr2wZ6mg34Q356K9ZaoWgbDH2MJc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auhXYyMRxy9bsf1GH7nJbVOn2crCyJCAipEWG1hEkz7xdIDgANW8Jc0yTEzyrOH4sKQpaMhh8U96rzEnWSxx9bt8Rj47/bYQfH1J9cja2AbrTA0WqVFeTBTjaxR0vKNVPIUpBisA15l8v9TmyBJDduXkLNEoWIJ7wVXlYPoVJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBjnyqnJ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBjnyqnJ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso668003e0c.3
        for <git@vger.kernel.org>; Thu, 10 Apr 2025 02:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744276229; x=1744881029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IaxWD5Zvio+ZwtUtW3/wSDxzajgA9V5gYdG7q0G2Wlg=;
        b=DBjnyqnJ5SQpOsb+3RQOrIfQpy8vnPyVm/twx5an/9rZ9FccOjQMLEKBJx2FMP/s+b
         isPOVv9XaPDkVBVEw83RCcv7VxCSJ4ox27+BZQ6EBCtVYBYExhiCt0uXBOCFRAflnOxa
         0a2t4PDNqAQvVac4y3nnAEMCO7e7i85yoRC+zZk/uAPU8+7t5kMDpOXZAw/7rWGbc8xT
         M7OX2/f6ctfCpWY873Zja5sx5Nc/ejeIMtRrP6z8ZrXgauuPtIROCQHmGAJLoVe6dyv6
         WTzolwO1GEQzwcY8xm0zl1PsEJX4LPXzKb0MkyEHguOQC7yh9EsNxTVTjTPH7BoZqLOe
         SDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744276229; x=1744881029;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IaxWD5Zvio+ZwtUtW3/wSDxzajgA9V5gYdG7q0G2Wlg=;
        b=nCKzdJTh/yG5lwdh0U1lPd/0HClK64D1p9KyRZbtq9lxYAzE4U/8xKWYdypakDE4vM
         F8zN+0fsHyM4tB0eeLxfTUDcKXECYX/LAmuIG17Mauk8Yks/84FvVeM9LvhcnkAeYAXN
         v1xWQI0pNDvgcBB05sL0QLIO30OJ4tXUD+hHw9XK+X/SaVYeCD0JleA25MjRoRc87jy2
         ECeyxhPmgsb+SxINd7cs15LbYPDtvCgjWRzu+ugSWhKonVQtbatlZ0B5KV1nytoTaUZG
         MO9nVn8dKzc0fcNSWfBcA54tSOGM99Pvu7XYyGsFQKktVctKgaSrDPmzsodgFwj+9AXb
         u96w==
X-Forwarded-Encrypted: i=1; AJvYcCVYg8ON2hOciFdn1i9eV6/ueyNkQr33W+XUp8pHvi+WjqTIDVzqRWIAZypmxnlLK3B5UsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCx6LQRbFzhhaZYcpA1ZDnzAFMWoFNKgWAstgrW+WshrK0HBF
	AQagnndx094KWeujmpJUKXQSXAkjrLhG8eCivm4wi40enrCFD0BAzl+7eiH2/VFTQL3n8qmkEGE
	6q/CvwtyJuncJIm0fuHD1iHr2fsg=
X-Gm-Gg: ASbGnctcuf1FzWi6YnOegZkdbKIXfYFaw2ZG1Uvft7QiKwxod+KgKeUTcZiuzs3XWXG
	J2HNKF5YAFm2sh6IbcoAaUeNkylrm8PfBOOGdwPuFxdQ6wYt8q4dwHqWc06xQ5xs/1a4H9A7VHJ
	v8UO7zrNtZGln73czwyqi2LQDSDY/qnNfgGdPf0746riTMJxjAnlm6h8o=
X-Google-Smtp-Source: AGHT+IFywfOI8DZs01QLSBjY/oXq87aUfSKGGfTrqBCNpMPeRuUdvpmM9pW6FjZFYeSz8syviRALjiDTGa0B5iQEH5M=
X-Received: by 2002:a05:6102:38ca:b0:4c1:9bdb:6188 with SMTP id
 ada2fe7eead31-4c9d34d40c7mr1352139137.13.1744276229105; Thu, 10 Apr 2025
 02:10:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 02:10:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Apr 2025 02:10:28 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0w9orsn.fsf@gitster.g>
References: <xmqqy0w9orsn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Apr 2025 02:10:28 -0700
X-Gm-Features: ATxdqUGic3PqgAC9PDNZhkm97vEQXYKNqaOdjxN0DcuhIobzrHpaiVRyEw3v7cI
Message-ID: <CAOLa=ZRMmEjPoD9-M=XFU37_VoGebYDnH-=nfCyPx0nTvD1=oQ@mail.gmail.com>
Subject: Re: "What's cooking" interim report
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Arnav Bhate <bhatearnav@gmail.com>, Christian Fredrik Johnsen <christian@johnsen.no>, 
	=?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000006e297063268f5d1"

--00000000000006e297063268f5d1
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Since the issue #02 of this month, a handful of topics have been
> picked up, a few topics have been replaced by their newer
> iterations, a topic that is already in 'next' gained an additional
> commit on top, and a topic got its description extended.
>
> --------------------------------------------------
> Born topics
>
> [New Topics]
>
>  * kn/bundle-dedup-optim (2025-04-08) 2 commits
>   - bundle: fix non-linear performance scaling with refs
>   - t6020: test for duplicate refnames in bundle creation
>
>   Optimize the code to dedup references recorded in a bundle file.
>
>   Will merge to 'next'?
>   source: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
>

Toon approved/tested the newer version. I'm still wary if some edge-case
was missed. However the series has added more tests and everything seems
to be good. So we could merge to next.

>  * kn/meson-hdr-check (2025-04-08) 4 commits
>   - meson: add support for 'headers-check'
>   - meson: move headers definition from 'contrib/coccinelle'
>   - coccinelle: meson: rename variables to be more specific
>   - Merge branch 'es/meson-build-skip-coccinelle' into kn/meson-hdr-check
>
>   Add an equivalent to "make hdr-check" target to meson based builds.
>
>   Getting there.
>   cf. <xmqqsemiuwhx.fsf@gitster.g>
>   source: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
>

Yeah, I need to send in a new version here. Will do that soon!

Thanks!

--00000000000006e297063268f5d1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8b15d598eb619ac4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mM2l3SVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md1FGQy85c0NzRXpxVVFLZkk5WkE4MDQxbHpZb2E5RQpUTm5lWWlOZ0w2
Zk01bDBEWU9EamhFMFphRWZHbHBBT3NoajlHZ1ZycXU2NkVoWEpYTjBTcHpQaitCNkJoYi9PCjRX
SkpqdDQ1SGFoNXA0SFJqS005T2Z4RmxJVU1XaEhIUXdKNU54aGtWdFFNSUdjUDdYT1VPdFloOFFC
aFBkQWIKNkNueklVSVBNSmFNSytlcGppVEs2RERNZmNIbmNycWRFRXJZUTJaVDcva1I2SWQ3cjlq
RzNDWDNQL2tzckFldQpJS1poYXM4c1UxNnkvWU93d2RPa0lISFZWb1QxWG5SK3RIZldEWW5xYzUz
VmdCYkh4UzdGRjFVdi9XcFNsOERPCmRwT0hxa2ZkbWdOOGsxQko3MWtKdXFWb25oTHRaSGZJbEtT
SVVsR3ZMOEFJdHdRaFZHTjZvcWRnQUpzTHdKdWYKTUh1bVNTelpBT2xuQTZTS1N3V0NhU2V6d0cy
ZVVsQnk1c2ZaLzVKRE1Yb2xRVUwvNW1ZM3QzN2w5L1ZqKzRDMgpLRWRndEd5MFZoSGZDai9TMlM1
ZWsxaWZqWHY5elBDSjA3bTd3MUQwL3BLY2JmaHU4SG15ZTBJVlMxQit1TTk5CmppMzdiZ1kxZzRt
eDdFYzVETEdWYndFZ3Fhc0dMNmR6aU5WeitnOD0KPXM5Z3EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000006e297063268f5d1--
