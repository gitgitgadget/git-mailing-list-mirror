Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC04D0CCB
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771202; cv=pass; b=OGl3G8xy3O8JPrcO1ZGxPJnfs9cXuCD/anPWf3+0FSUigHiM7cKMGExdTJc5r5XkIQ/tvXfyf2D64mSB1TNtew5MW7Gx/kr0egyQy4/8O+9h638zy39jwqCqERzvtJ1ISXz2E2fBRpBWi7AiaPoszeTfguOTeDqq6BwTnQu9SgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771202; c=relaxed/simple;
	bh=3ywDYfrOb7UNWCUTkChDaW4KtfSfkyNhRsmh0NCu3+M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNARzsouNQ3NfouGZUHO5GLDdBAHLw9OB4pK1XWarKNSlrOlShEhPTj1OkybbTa5OMtWqNiUkLZWFxUCUQKCWzCpcN0f1Iq5DGRmXzO7eVJLFVFhxLTfJvB64xjQkj2W4MWeRAuv7WJ4+JQFVZ7hD9vNearQRsYAJvJ9z/OZChI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQuuGKWk; arc=pass smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQuuGKWk"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-988ba23f552so1048877241.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 05:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790771199; cv=none;
        d=google.com; s=arc-20260327;
        b=DDfh6ZfX8vP+rEyM+yWeyP1iFFGijTtXzf7u12yTclbRNg9qPGiFFx3Bq9XBq2Yucw
         umItdivYjRKHox02CKNvOF1ZcjAhDsHstbOX9U0psWVPvIv1D1A40LBznkgOLg3UWZcO
         5jvrtAvutH+JNWnOqURw6bSQczsEHz9/37R/zi4m0qaZJ1RNz7BJIepxf38jVrE91mwR
         bRR8NGBvmSQEpYALjv6QA73d1GRtQEPSkqPqI1zYl+wspRMF8SOyNQl84iUiR3qRg643
         v2vyl6SxIUFlsem/B2cYHkGXLJ0vxQ9bu4XSL8qhJ6fqf44/9ax5vbbH78ll5RED65GO
         Wrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1myGdVdrzPLWzgFRAYCAvWpoEdrF2CiHeyktdIoguJI=;
        fh=+RT+/ifrmydh+o2q3Dp+pZ0fW6fAFWmQjqhCuMSSa/A=;
        b=RhyMFbUjr73eJUxoJXOZTMwzOKXjgQ27B62j77M3wXLEwZGTMg3tNC03VI+ZQlNpM7
         xrSJg7diCC4yBCYud+AS01wbZP9ItS004D4AMehXpGcMfUHkPHlml3IKOAVg/yoXosec
         V9jzVq/+/AhXMCrNuaz2J4h/05w2EjHIZlK+Hfo00rp07/yr5hRzBRNbuL5YaqTrN5Qy
         dIy/MAxYvGTH2BKDUyPIodkw1060gI1b1+Qni6KSZXHdgF6Fob3e/E+jFbcMUoNdobLj
         FMUzY07tHBIpbC3NnfdwTB6qp5cwhGpU9zsDDdZflGTu4zM4HSW69I0i2MlzFElTDLcl
         ILAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790771199; x=1791375999; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1myGdVdrzPLWzgFRAYCAvWpoEdrF2CiHeyktdIoguJI=;
        b=RQuuGKWkQe5kRpV7AylgLLP2PQgVfk6RKSZj2nHG6LwZVlAMk3BOhKR6ROKVyeIXaE
         zyY4Nx02sb6lFA1B5AvaRkNr+db8Snhj6CjbekEqfBC3VlC5UF+5AjQV0RpuCjtqj0us
         q4cFFcNvwAlaY4+gzactZDg9tLuRTsTIvn7yJLnZz82iumjXXsVfueAB2Bhm6XgjmVDg
         Jp4+yTPgoL3IpYFU9sjBFAEMtfTrqRrk06CU6G0JmLGdjX7OUNDrtS/1y6q8Qmkm4BAU
         ihgGpT0z1VAqiRMvt9Z9fQj+MrIlFbZgBQnfsg7Ext23Qrq8gEPJ3/2mdE4PNmwqLfow
         BztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790771199; x=1791375999;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1myGdVdrzPLWzgFRAYCAvWpoEdrF2CiHeyktdIoguJI=;
        b=PW/pvjIoERLUn06qHEeSuq7h1uJmH7PL5R1scMcrf2UGzxjyTr+pUcKiZZcAL1WMt5
         OqDoOyfQaYylJXF6YqpUIGAD1phxNjFZxzcVsPbIJk6Xn5eFmccina02hhQwGAeemKN4
         bkZ44l6no/VTA80b9UGSbQBksiLnNo7UGbNaqiYZCt6AYjCGHwbsb1H1PQPf9COEcZ4K
         WkITF2DOlFsMzdcnQ3s8zmIKTHKgZJqaE0fq9Zq5wG4KcfmosYbWvAYaT/dgB+X2WfEw
         uyIweWb+SxZsf+INXxLYXqiZ5nzRtRw+mNfF5FNiNQC/18dbyDWC6IHuNdQCsFEjWbPE
         pymA==
X-Forwarded-Encrypted: i=1; AKwUvBwV9JrDF2gcJpW14U1I0hWdP30lfqClkBMYVX8t9hdtZWK/7RyMsc/9/wmweGIFHyBPqQc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5IeV9Eez7Z2Pp1Jtpaburcdzz7D3k1kpTHx9tj8CaJZcNHZVB
	cMI5lW+nPda1sdt+MTHFyKY/nmC/wNwsqidcgCQVp9OhMtJfwCKPt6pTo8ylBRKxvYHJTFUm4NS
	O7aBFsJ6diHMBMQK5ijjBnlO+vaPDpJs=
X-Gm-Gg: AYBFou18kCN6b8fr/5QQzsU15yoHoaGW70XtNMX/ltkaio1/bIkGvBjkSzZFT3S7AvU
	NCKHHquQoSs/4ODiF2qpwsjjMnVECXQt2iwobZj8gU5nrR9aIkzjSs9qRfgNa6bmmjpcdqZEO2D
	cCvonmT+YEyJHW6z/V/GXDh/j//kUMYG64bQAl9/nYSZubLiaqPMu+dLHAXVRiS46gOhgOxki4A
	wPWM2c5DRsBlUfrQUzQcedRRWid9U18Cih6b40iVpzt/NpVM1LBoVEpA0mseRdIdFwC809hwIe1
	5N9keuR4pnNlIhXSEB98EendB7OZ0dl7B+f+9Q4Lt1z+EHcbPT4kHSWxqLCIGKB2DJYihLWYZk/
	tk9+zCI95EsQoKyssIEOJMACql6hUrvFzBagjx9GWqYJ8Lw==
X-Received: by 2002:a05:6102:3f45:b0:7b3:5873:4b03 with SMTP id
 ada2fe7eead31-7be73e9a327mr260609137.29.1790771199367; Wed, 30 Sep 2026
 05:26:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:26:37 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 05:26:37 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
References: <20260924-pks-meson-improvements-v1-0-90b7f79f1c4e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 05:26:37 -0700
X-Gm-Features: AclHuK9KNJhIa3SClQ6bYZFOE2dZyc7ntqRMgZux0PbsZtbg43K3rZmHpwBPhzQ
Message-ID: <CAOLa=ZS8Exa_WkMLiFNspeYaKFf40eOM19ZgecC=yTnFEAhMzQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] A couple of Meson improvements
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: multipart/mixed; boundary="0000000000003678f7065cb26921"

--0000000000003678f7065cb26921
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series contains a couple of improvements for Meson:
>
>   - Clean build times are sped up, going from ~6.8 seconds to ~5.0
>     seconds for a full build.
>
>   - A test issue is fixed that causes shell completion tests to fail
>     because the scripts are not properly updated.
>
>   - Our subproject wrappers are updated to current versions.
>
>   - A fix for GitLab's msvc-meson jobs that are broken right now due to
>     a change in our runner images. See [1] for the now-working
>     msvc-meson jobs. Note though that the MinGW-based jobs are still
>     broken, but Dscho has been sending fixes for that already.
>
> Thanks!
>
> Patrick
>

The patches look good. The speedup is much appreciated.

> ---
> Patrick Steinhardt (7):
>       meson: avoid recompiling HTTP sources several times
>       meson: don't recompile git-remote-http(1) multiple times for tests
>       meson: use precompiled headers for our test-helper
>       meson: use precompiled headers for unit tests
>       meson: fix outdated completion helpers
>       meson: update wrappers
>       gitlab-ci: fix hanging MSVC jobs
>
>  ci/install-dependencies.ps1    |  8 ++++++++
>  contrib/completion/meson.build | 38 +++++++++++++++-----------------------
>  meson.build                    | 16 ++++++++++------
>  subprojects/curl.wrap          | 19 ++++++++++---------
>  subprojects/expat.wrap         | 21 +++++++++++----------
>  subprojects/openssl.wrap       | 23 +++++++++++------------
>  subprojects/pcre2.wrap         | 24 +++++++++++-------------
>  subprojects/zlib.wrap          | 21 +++++++++++----------
>  t/helper/meson.build           |  1 +
>  t/meson.build                  | 10 ++++++++--
>  10 files changed, 96 insertions(+), 85 deletions(-)
>
>
> ---
> base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
> change-id: 20260924-pks-meson-improvements-b7ed9a48ed4e

--0000000000003678f7065cb26921
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 25a1e1bf10f3517e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xOC8vd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDhTREFDYjFPWWF4Rkh6aGhqSnZQL0xtbURjRktFbApZd2ZPeEdWZis0
OXFycUNaN2J4ZkowRlVjZ2xITmNRamdhYXUzdkNDcVdzQkt4ZTB5WDhBTTdhWGVabWQ3S2xkClZl
dVhLTHc0clJScHpDUVdxWVBITG1vQzFJM1ZSeEJlK0paeG9raDVoZnBIZXJSaUFRa29GU1lmKzZX
VWs5Y2wKcXRUT242MitqTzlWQlJIQW9KN01YYmVhSjJYRGN4U05HZE9wcXFQL08yaTk0aFpLRjFZ
RktjVzM5azRNQzh1UQpTWVFXNVJUZzdjbzFGYVlBRFJwRzU2bU9zZVJxNkRLZ2NGSjlUWU53WFVo
OU1DRmE0OTVCQ2ozVFgyRU92elVxCi9Rd3JKcXZOTHg2c0JzV2hWbUtKNU1ORUdRbUpZSndoU2Jl
MzZ1RGlZanRkVU55OXM0cjZIT0VLY3VEd3QvYVEKMHR6Ulh3b3JwM3Y5QTdCS3hicVVUSDdZQTJP
WXk2dGQvbHAvMnc5YnBaN1NlSFBpZUswc3lRSFVjZXdMMnJQaAplT20xY1B6ZHRSL281QXRuU2pF
dDkzYW0zNFhiZkhxNEVkcm9HQWVhY2VOZVdmSXNkWTNGOXFacWplc3dkeUx2Cm03TVFzdTVVcTlm
ZnBzM2ZaRnZiL2tkbEhwWWxxQTJPNzhYaUFUVT0KPXFCQ0UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003678f7065cb26921--
