Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FC5A796
	for <git@vger.kernel.org>; Sun, 11 Feb 2024 14:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707660029; cv=none; b=CvOT3/U6jdQ/MVlszxvvGtZxLxCm8fX/6GUyk2t2rsoFP5kngw1SQFo56SVJ8pzNv7JZYILytCaLx7qp1TS1e5Hyg6ItpOLdKw27F459ohSs0t651AANcpkCekEQRDW+r3GR6+/77hcRdEcjHWII+PTcP8/Dbbz0ITDKXQ5KCu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707660029; c=relaxed/simple;
	bh=TmZmMA9RmV++3D4eYvvf0Cu+r88UM3ceBhFJjUPu8c8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=u8/znFgm8Tbx70UAS/trqeV3106/NJeC3KWBRhRhPlvDNmhhKi+GY1eQpdx/NKvidj3JUUZWhmYyiBZNh0NPCf1ANIXIGkK4xTRCXT/EAxZbHgemIKgSKdkVcCc4GhyE74DCFS55RZ+t8T7aH7N3eo0eCmdXVWH7+yObEECXjRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXLToYc6; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXLToYc6"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-214def5da12so1553405fac.2
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 06:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707660027; x=1708264827; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmZmMA9RmV++3D4eYvvf0Cu+r88UM3ceBhFJjUPu8c8=;
        b=mXLToYc6981ziJH+3uTR44x5ig4nRFBAP66Lyf+4kx22uIyZ0HTfcBEN2pQdzGJFSP
         +9GJd/5OMrJNkWBym4xTuJdgAK5e9Weq8uN0xI1ylUCHFgcvwnN8IWKh13aHzOEmhwzB
         fcmwYOOwwm8HMwZgTWHu2fvjzru7VqKXURQ6BWu/HFEPCjCqMM0rq1jXuL+0BJ9enAdl
         8by1/qC3YvfVqL4fEfjE9NwzmVb0AgK6oS2rzHZ6OiA5BVbLDY5MYRL3LlhuuX3jrbgx
         Fvj0QSpADPMJm8ke6uGC/+wOrq5CURA0PW2nyeguRREJufaH+8u1xhIdH/O4hob93l7/
         Q4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707660027; x=1708264827;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmZmMA9RmV++3D4eYvvf0Cu+r88UM3ceBhFJjUPu8c8=;
        b=KLJU3x0lMHM0iBV2BE/hgHHVrYZIr0rsjzNZmsdXbU9iUd1Cdm+gIE27VYlRQ19KSw
         /qpFbnbn2OPaeM7d3CB5I5mFsZOw2SfmhdDBb/so1QvfcMQPdOH2E3A1Q+ybj3na1L91
         uFLwBjeuabkJfQrtr9ii0Z1SzV/APF8LF/xO3DDQTclLBySpKnX6ohteZUf16PSOi9Z4
         oXe2y9j62WrVrGsED9HcbOJMYx64RnUUJPdlgiBg2iyIIhsI0n2UNCc32erWIu4UEUSd
         pBnIQErlIW+I63IOma1ZVbcz0TQpZrMLG3Ydg3FqKG9Qo15FK9L8jtu6nkGpoTv1a/NX
         B8rg==
X-Forwarded-Encrypted: i=1; AJvYcCVod7KrxWTbUtauu9cV+avusZi1kdXr/XLpprX6K1spJqkI14mBIuRqyCw02CVV8ApnC5k9RZ2Z9cxE6bCjplzWs5sL
X-Gm-Message-State: AOJu0Yw2W53/yHGHCQdGsLk+Q1Vqxhxws5Q81xWPqueMKhkyeS735HeJ
	7cgVLdUTvJ+GcvOyUNEmLVJVqMWuY56e9zsVJHvut8scb+ZfzOT1l39M83IiX4SJ6ICgjLP9WYO
	pf/azrT86hd66iJZVDLl2FSS1RhHAfPf0
X-Google-Smtp-Source: AGHT+IFe01HHsC4KYugIcNcsbj+hLjvG5zyHurMpv2WYdarSor3Zq2XQVbdiw0Yf4L9Mvir0d5v/0uIiSHjytdrfSO4=
X-Received: by 2002:a05:6870:828c:b0:21a:3290:ab7e with SMTP id
 q12-20020a056870828c00b0021a3290ab7emr5147621oae.40.1707660026876; Sun, 11
 Feb 2024 06:00:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 11 Feb 2024 06:00:25 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Feb 2024 06:00:25 -0800
Message-ID: <CAOLa=ZS6tuM7hTMNQ5KRntP+bgrMHWuxDAHwz7QjRNNnkEN2Ug@mail.gmail.com>
Subject: Re: [PATCH 0/7] t: drop more REFFILES prereqs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004caf4706111b9556"

--0000000000004caf4706111b9556
Content-Type: text/plain; charset="UTF-8"

Hello,

Patrick Steinhardt <ps@pks.im> writes:
> Hi,
>
> this patch series is another step towards less tests with the REFFILES
> prerequisite. Some of the tests are simply moved into t0600 because they
> are inherently exercising low-level behaviour of the "files" backend.
> Other tests are adapted so that they work across both the "files" and
> the "reftable" backends.
>
> Patrick
>

I had a look at this series and have nothing to add. Looks great!

Thanks!
Karthik

--0000000000004caf4706111b9556
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3d7361a3d9816d24_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YSTB2Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK25tQy80MnNlV1VIbkVrK0FqSi92SzVqWDBpWW9vbgp3UGNONkpXOWk1
emMvUEtkTE81bkF3djlUQ1F5ZTh3NTJFZUVndWN0MFZkbm1pZ0ZCMHZuOGREN1JIK1BmUDhaCmNP
bDRjb2pXTzcyNFZTUmRUMzFMRGRTamRBc2orbFFmN0pHejhWK3FXZTU4TVovMUkzNXIrZnpQa2t5
VXh5QVUKWkdOS0lFaWtPcTV6NFBNdFdVNklEc0FDRXRva0pTcW5lay9nY1hmTmpRT29RcklyMk1h
OEhFMTBnd0ptbWUrOQorSHZqTnh2SndockwrSVZQVEVNMW4rb25jUzhDYlZ4Y0pvMzUrdkxWYzJV
dGx6SmY0TGRNdFF2TnZrU0k1SG9yCnZtdU1yTTF5OVN3eGs0N1djRWhpM295QzN1V0ZuWkZPMVp5
TFBYMlM3MjlEV3A2SVlJSFdKblFZNVYrZDFESVQKYUVDMDQzU3ZZcURZZk9PSFFtemZmQU1lbmRa
WW9NUUFSNG9UWEtOY3M5dDFTVnh2VWFvSDhCQ1ZWeG1XZjF6MwpQbTlXWmZ4UjVDQU9KVWFGWDZm
OVRQY0JtMHFZVW4yTVpCTzh4NUViMDdSR09Vdm83b3BqcXJwUTdTbFVPTWtHCm1jYmtMWEwvaEdX
V1d0aG92OThLaEVYSXFXZWxKQTNrY1BLZzA0ST0KPVE4TmIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004caf4706111b9556--
