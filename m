Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF820DFF
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138660; cv=none; b=TEZB7ayrWEPDDIp6Qwd8Kpi9IlP96TsZD3mXFEzFYlDkAWMskuVjmnuoXmIz9+LyuNBl8PChQvXxwbmu0wWjNM15TEgDR7Oeyr1tUefvK4RuUbcMc64UZsgCGtj7Hk+WrbDD/esOcdCqGJUbe0MmZBT/UEtdANpMYf6tpa+jmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138660; c=relaxed/simple;
	bh=a0NzR5oFowpwcMr1enL14gXNCk8zsA2wr8CXshGvmJY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXqKJUWThpnFivRWqYZnJkinPigOmW1iTB9iVlNcOvAxCGa2w484HtpTZda6zD9Xe27WNHSNBFiQt9QZcEBlulxrYyKASd0u/AahOI0ucrJnrxxcqhjzNsREM7UZaOdMcN3ZK4Tqnxg3cQ8xTCXqxSjh46E+hLtFV9qo0u7jtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QotMVc//; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QotMVc//"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-204235d0913so2650068fac.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 05:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707138658; x=1707743458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3SABvqg/5ixY6fxHv5s1efe9RTlTdiIsmq6y+5I6nA=;
        b=QotMVc//1esxTD1eYKU3vx2JVnFStZQQZp6JZFgMnCwAPY1d84DZsnWtxCZSmqtEVj
         ParCGacrhuZNJwe8TqxPfCNFbMPsuG+aTkz6CcpNhER09JBvFWcn50dqWEx6cm5YxeO4
         YNajrylsfuc9x0vANINXodsSILLE7GO1rucpW4zKLYMrSke2ocAMMI3HySc0GFSwx2qQ
         rIrNsiWFbW0PELy+a/WR5HikG5pgIX9IZ8vStixl53rQBUVGH5kcUsLUT1ufNVlMnFl+
         aHpflg4CwfrDP2RN7BI6Zgmq3WRHYrOvJw+21Oxu98u1u5eFZ2M75rYwki5W0Yh/jYPK
         20mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138658; x=1707743458;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3SABvqg/5ixY6fxHv5s1efe9RTlTdiIsmq6y+5I6nA=;
        b=JdsekgJlbSt+5fdRm0tcCaYaxYEuhOZwRuXJnCampAyNUOFxJS4r74WT/eZ3kBEXbn
         2lCKGo0o3wIwAqr49pzeOTqjIHAMNXSg4yknkJHtcOnQUf6ekiEmno31bD0nqpa56oi/
         3CWwb8WXRSgRrtcL/jquYc29EJJ+rPjCuSlRR9yTdISnODti8E5+rj+EmBVQ5KUTuFsW
         AJKPkMGO2yJ0pd2NuGsp7jHl93m6ENmfgVIKlVVUioRG7kg8Y9pVkLgdyKVPrDT+HiIR
         Zg94wpdIvjzTt+kAH9ZHanUXncAYqzrWA1wenFuB9YMzdKaQxjnIaT1RoT/cz7MYyrEv
         sbpA==
X-Gm-Message-State: AOJu0Yzy/m++/mHFHGCeNPA3vG9UgyMqIieHWnkzooYJVRlHrbAaQ0Dv
	xtHRPquDErnv3RhkttV9xqcP6dA7gFIdo7C093fbzKva/ka0KSfIHVQg3D9R4Ikn+y+ry0l/wtl
	kKAj1LSWTQLQCRbMgxd3jZU+7FUBe9nMe
X-Google-Smtp-Source: AGHT+IGqz6XOZRRFKJMzS97+GUqcgVYZ0KohHolxUqh7xQdY76QEYIBE38/gEs4wMTY2lCQahVK028LS539xaHJyNeQ=
X-Received: by 2002:a05:6870:d88c:b0:218:f68f:db50 with SMTP id
 oe12-20020a056870d88c00b00218f68fdb50mr8218481oac.10.1707138658106; Mon, 05
 Feb 2024 05:10:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 5 Feb 2024 05:10:57 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1707109509.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im> <cover.1707109509.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 5 Feb 2024 05:10:57 -0800
Message-ID: <CAOLa=ZTtGJyzQqTTYfO2aypDU2-jDn2cehGGR3B4Vg-tFT0duA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] refs: introduce reftable backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Han-Wen Nienhuys <hanwen@google.com>
Content-Type: multipart/mixed; boundary="0000000000004c9d140610a2319b"

--0000000000004c9d140610a2319b
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:
> Hi,
>
> this is the third version of my patch series that introduces the
> reftable backend.
>
> The only real change in this version is that I've pulled in
> kn/for-all-refs at 693e807311 (for-each-ref: avoid filtering on empty
> pattern, 2024-01-29) as a dependency. This series introduces a new
> DO_FOR_EACH_INCLUDE_ALL_REFS flag that we need to handle in the reftable
> backend. With this change all tests should pass again.
>
> Patrick
>
> Patrick Steinhardt (2):
>   refs: introduce reftable backend
>   ci: add jobs to test with the reftable backend
>
>  .github/workflows/main.yml                    |    9 +
>  .gitlab-ci.yml                                |    9 +
>  Documentation/ref-storage-format.txt          |    2 +
>  .../technical/repository-version.txt          |    5 +-
>  Makefile                                      |    1 +
>  ci/lib.sh                                     |    2 +-
>  ci/run-build-and-tests.sh                     |    3 +
>  contrib/workdir/git-new-workdir               |    2 +-
>  path.c                                        |    2 +-
>  path.h                                        |    1 +
>  refs.c                                        |    1 +
>  refs/refs-internal.h                          |    1 +
>  refs/reftable-backend.c                       | 2297 +++++++++++++++++
>  repository.h                                  |    5 +-
>  t/t0610-reftable-basics.sh                    |  887 +++++++
>  t/t0611-reftable-httpd.sh                     |   26 +
>  t/test-lib.sh                                 |    2 +
>  17 files changed, 3248 insertions(+), 7 deletions(-)
>  create mode 100644 refs/reftable-backend.c
>  create mode 100755 t/t0610-reftable-basics.sh
>  create mode 100755 t/t0611-reftable-httpd.sh
>
> Range-diff against v2:
> 1:  d6548dcfad ! 1:  d83e66e980 refs: introduce reftable backend
>     @@ refs/reftable-backend.c (new)
>      +{
>      +	switch (log->value_type) {
>      +	case REFTABLE_LOG_UPDATE:
>     -+		/* when we write log records, the hashes are owned by a struct
>     -+		 * oid */
>     ++		/*
>     ++		 * When we write log records, the hashes are owned by the
>     ++		 * caller and thus shouldn't be free'd.
>     ++		 */
>      +		log->value.update.old_hash = NULL;
>      +		log->value.update.new_hash = NULL;
>      +		break;
>     @@ refs/reftable-backend.c (new)
>      +			break;
>      +
>      +		/*
>     -+		 * The files backend only lists references contained in
>     -+		 * "refs/". We emulate the same behaviour here and thus skip
>     -+		 * all references that don't start with this prefix.
>     ++		 * Unless DO_FOR_EACH_INCLUDE_ALL_REFS is set, we only list
>     ++		 * refs starting with "refs/" to mimic the "files" backend.
>      +		 */
>     -+		if (!starts_with(iter->ref.refname, "refs/"))
>     ++		if (!(iter->flags & DO_FOR_EACH_INCLUDE_ALL_REFS) &&
>     ++		    !starts_with(iter->ref.refname, "refs/"))
>      +			continue;
>      +
>      +		if (iter->prefix &&
> 2:  63eafc9f5b = 2:  146bb95c03 ci: add jobs to test with the reftable backend

This range-diff looks good to me. I'd already reviewed the previous
version, so overall looks good now.

--0000000000004c9d140610a2319b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 37edc14fbe2487e8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YQTNsMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMktUQy80L3RCeis1M0lrendxRy84WEVUV05nU0VvMgpMbnRBVFZwMGdv
ZDNvMXZ1SURJRUcxRlVNc05oVTFLTWlVMEJBUmZqMTdHQkVodlM3WXNSRUJ2ZjQvT2VMVTk1Cnpn
aXpUYlVzSGdRcnlsSy80UU1qS1JidFd5QjRhV1ozc0lSeTFTOWRET1NkdmxLdHJJOCszWVlvVThu
MWw1T04KN0dha2Zya1VYejk5eDUwcUZIQWFvaEQ3Y21udVh0bW1DT2QyRDhCVGRPcFRZWUhUSWpF
bGZlZU10aUMxcHFZMgpFR3A5ZFdiVUVsVlRvUm5xclJmeHg4RHlEZm13R3FYcldRaFhab0M2YnAy
dzJqdnQxMTFJdlNBb1Q1SU5qc1I2CnUwUWNuSnVmcS9xc0E0bkVjVTUzWmZCMW0wOVRLTjFXN1B6
SDI1YUozY3dqNWxtYnpxL3JSb0twczFmVmFUdEMKc21XYUxGdWlJUmZtQjVCWXFIM0dDbWxPUFlv
NW9DcGpUcDhWbXdxaWNleFl3WU03Y3RpVk9XRURUVE9RNnU1Vwo3aTI5Y2ZGOFVyN1lqbWlSUUVs
WmowL3pNRHFKZGZBVUxjd3U3ZFF2TFg3N3ZrUDlMS2IyODdUVDlmOVIzVGxYCnoybW5KZkVVT2Ji
N3NLRi9QdlZPb2VpVWR2dVNLTnM4TVBCV0I3VT0KPTR4eU0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004c9d140610a2319b--
