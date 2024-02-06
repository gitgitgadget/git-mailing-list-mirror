Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E512A159
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210645; cv=none; b=QoQma/KktTKmfXiHuq9Xi8zCom2kFAKITFh9ZmkmFn5P2R7cXI5GSql5rY1mjnF5TTelSveM0QmXIMSvLTG2+N2StWpkU4vnkW0UsMGamwEfKub6jXWtGHQz57oiPjh5Dd4txlTocUo55e+7z1fojbPE+074Wf/WDZi3Fc/TB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210645; c=relaxed/simple;
	bh=2kA3uRnYvtvgqaGWP3G9upckOQJahsLxbMS7ApMGTGk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJw3SECdhzGiqnSXmvwyE5B+C7idOKxBrRQZBazxSPIr2et8My43RXhbmbDotfONZGHbFybbvgXCuLkHB5G+rRgWfMPsY//D1uNKZWNwiBy72AiWXMwb08vGVmI84+WgS4cz8fn/8NXmIBzwxOKLL5zzUC0wwvjzwMCEos/zmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Efy1T284; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Efy1T284"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e112826395so242159a34.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 01:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707210643; x=1707815443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2kA3uRnYvtvgqaGWP3G9upckOQJahsLxbMS7ApMGTGk=;
        b=Efy1T284Ea5wUOyhQ0OFc8oSU3ZUgqDp4C02/S2VgWusbqqpHyGCgXG81JsAVVPU8F
         n2J69UpMlslIAZiPNwyc3ggMSVy1mLBDbFD3oJHJuyZMCVF9bqMgd/wtognj5QMfWOlZ
         eR2CdvE0HxuldXrgqHdH/LKqdmltxgAYybEoS9Ky+DY6P3HEwYEvSqGTMLx4lwrYsR+9
         ARn7HKW/mQP71g2jyuhmXAX/dW4sOW+WgkIRwz9axEE+EqfoQvegvxwXx3/no+8at1yn
         HI+59GrsyDVVIzET3d0B9Yon6Kx709owWVDreNOuVRtQ2i0pq4yzimm6+7VeVmK5auyi
         i5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210643; x=1707815443;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kA3uRnYvtvgqaGWP3G9upckOQJahsLxbMS7ApMGTGk=;
        b=nmhT9jkljGtyAhEVYk0qOIq7cIRXTf5mW3v31eebtGp73KOTg6Fq7dRDLxIhYVEwPz
         KpVTRIpwgquEoyQnJfvGLSAUnShpK2OK7wF2XJLu99hz8WTKfkhGwNVkeY6prj/HaIm8
         cos5tu+whwn6o1z06rVk8vRmmHO/psBs+7pD/dpw2waEbEcHK/yg3vzB4VSuJn5wKMgB
         kU0qrSNRTSPt5o2Pe6dNFs6b0MYtxLqma1h90Pzvv+dQVSKluUiOvVMy9X0m/KbYOV3p
         usfvxEF18K5GMJXopCbuBKTkURjYYlGBH5Jp84ATpy0pmy0YWsr3oeyK7hkK86aNr9rG
         QjYw==
X-Gm-Message-State: AOJu0YzBmEFmw1Bcvc/WTkM/Qcs+FpqGqUyzSYWf/ICy6bQrg6brZFmZ
	pCSYf44JFQCY+8aC1c4FnHgNHTnfRkewlU0AFLaZRsa28pGGSkoWOzlAXSSyXvV3Wc/Vm9lfJis
	tKts+q7acOcqzMTDy77hu5U4pkf8=
X-Google-Smtp-Source: AGHT+IGL+3Moj7gvDJx+7EFNQhjsmEPvxlquFudnPW1ii0DJLAchbw3xI3scwn5O8AFyJM8/zkJyR8Oge7eiNSiHqRU=
X-Received: by 2002:a05:6870:7f0d:b0:219:6c0d:8b1a with SMTP id
 xa13-20020a0568707f0d00b002196c0d8b1amr2574978oab.50.1707210643100; Tue, 06
 Feb 2024 01:10:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Feb 2024 01:10:42 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im> <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Feb 2024 01:10:42 -0800
Message-ID: <CAOLa=ZRAZjEPYO3QdbqZrAxwmC0W5p9icg9tyA1yp68beSaYNQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] reftable: code style improvements
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Toon Claes <toon@iotcl.com>
Content-Type: multipart/mixed; boundary="000000000000f0737a0610b2f35c"

--000000000000f0737a0610b2f35c
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:
> Hi,
>
> this is the third version of my patch series that tries to align the
> reftable library's coding style to be closer to Git's own code style.
>
> The only change compared to v2 is that I've now also converted some
> calls to `reftable_malloc()` to use `REFTABLE_ALLOC_ARRAY`.
>

The range-diff looks good to me, since this was the only change I
requested, the patch series looks good now.

Thanks!

--000000000000f0737a0610b2f35c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dc4adad37f0c34f5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YQjk1QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekEwREFDSitDYkNGcUxyaS9XWW1aSXdvaXBhclQxNAp3S3RycFExb2JH
ODRtQWhub21aOVNjNFlVSzVrS1RBbnJmaDB3bm5uaGJPaFc1NU1aR2dlejhYSG5oYjkxZW5oCmc5
Q2MxUzhKeDFoU3FiOWgyWC9BRnA4NmYwbGM4VlBMSHNvTStVT1F4Vk94b2NRcE5ncEJFVGdJNXV5
YmJFcUwKWVBSM0JjS3lsTHY2a0ZZMmVFTmtubUtvZkM0NmpmRnBRS0oyQXRkRkRsMkpjSW9lak14
QjNmYWpvTmhIMjEvYgpQSDVuZHplRlRWc1pGVE93TjhXU2tYMHQyMVdSRGR0eU5BQW9ZZTh4QmdH
Q1o4RHNxcG50YWw5bkhRZnEvMUNOCkhGRzV0V0N1dXYzOFVTRy9CVFZkUENtQTNmeEcxc1VHSmFB
MmlJZktvdWt6ZkFHZlE1bVR0eEtvZzZBbXlpQkkKaTNmSjdkb0t4M3F5ekZYT3ZJZ3JUYWdmWnRN
dU1KM2RiQ21QSG5QYzJSTEJ0TE5MUXNPSTV6YjI3Y3c4bktLTAo1am11V0FSVmlPazVaMjF3T2Vs
MWUrU0NiZm4vSzRMcCt0cnhWc0taNzVjSldNdUdlVHpXWVZ1T1FwREtrRDdmCmxEZEM5WEdrR2xJ
YU54T2Q3c2ZocGNsblB0Z215L0FNL1ZZOEFPRT0KPU5qU0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f0737a0610b2f35c--
