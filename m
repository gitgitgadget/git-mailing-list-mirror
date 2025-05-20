Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F157267F70
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732617; cv=none; b=jjijtIUpGRG9ejIE/odKZgMNYrMDdv2p4pYjKLLoI3MIhlXEVWPMLnsm2BfWutT38iUyqprQl05BjyKaD1TY3Yi2JEyNORDUSIKPeKia/InInuU0cZ0b2MQO6X+EOWfPW6vIn9WS3Bnc3bB/Ed/zH7ZDc7nP1+6bAIz6l0R1TDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732617; c=relaxed/simple;
	bh=26S/yt576/p5gUrgxoCAJisx9F8fWudieaCiqv89f/o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMzwJg57hDweiQabApsUECaHhTgN22uKMuhu9OZzatSH8Tpc0ujDW3M0zZV571PO+C/Aq9qhq/aTN+pj2AqIHMXsQH0IE6rxIZth2yYhSyFsesVwyumExoV2+A+EosxM5QCOL3fXcXdq9OQOf8Okse4jIPNSVSxg9fCSaZxoVbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m13/w3Jv; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m13/w3Jv"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4c4ecf86e8bso1834792137.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747732615; x=1748337415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=26S/yt576/p5gUrgxoCAJisx9F8fWudieaCiqv89f/o=;
        b=m13/w3JveT+tJD/g3vR0c3Jo0IJQuCF+fnGq8ER+Rune/KQFaEduHjrWNqs34fk+BB
         XEWTJeqYHftaRcCdGeuOZPMvwaAPiGav3raTYpE2CyTbE1osqn+5NNptverT/ynJjMdI
         DxOrqrf7V2htfhl+awk9YbXUUoDCM3mS6yKXCTkOBAmEy302Uk7CdMwm/Ji6Z89qKuUe
         MnEBcid+RoH8qNBfPkz0czkPN0LWQy84YUg7TPAqHhrk42zfgWzup1wgeemf0ukgOSmv
         j0XNI9zDeKVAditzdzsskY1JFOtFvlgCAcUVbJHrWEd4iTOTF7yPmAURk42vQbUbxS4d
         JJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732615; x=1748337415;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26S/yt576/p5gUrgxoCAJisx9F8fWudieaCiqv89f/o=;
        b=Ypb5VQMKksg6apo8lAZN2SVWnWCze4I4KmLCDjio/lutgxBRogAKAb9v0v54Grnl75
         5ex2eR6LrbtbMiktgkmlrzgLCAGkC6pIrsKDxjmjoWege5KxzShqqABe3VJ4rfnnxb5t
         5WabU7UWiYezSAezLrFFbBPf7SMvnKjh8+kX0Hq6gCAijpotCd7poGgulvNAXhqppJME
         G1eLeFDcHUBusq6YcDyu0MIFmUcCU3fYx5lP8BUzY8pQDj2cAMO6CU/zRMNUC0m1e8EC
         5hxy3BqJSS2naF2trooEWgo0AsNtUJaTdtBaU0c9pirRyADiDW06DYmWcsWx8o4AcHZw
         87ng==
X-Forwarded-Encrypted: i=1; AJvYcCXFwjhf7yaxNms5DtjNG2NIWDsQBNCVFR6kA2uYDMOIcneczNRnHpPfmdQ71IeadMI/vEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwArHZrhqZDci5dXtvmw9YmV6Vfc7apgB/dmU2ULYbUTzquSk4/
	8hjcJVFH5+1HVE4khvKn4bt2icc6F5AN1wAIC3ykn4BvRIqD29+feiTp0zUfALSRdRBzZ4d3DAC
	BPODVN68h465ePqkWl0xIqgb+eZanRtsgDvTv
X-Gm-Gg: ASbGnctqlFe9SHRqBFfNOqqIyFjBW0UfRgf1uytJLRF+H0u7AulpMWOHYcM3KZhdj97
	DRMvrIpHMxumQFx453jXqtAlcop3o/g5twHv+GCw8JFTldbfeBAk+bvY063tnw5VXRjHdIcXIh8
	VBW3oUDcfIlK7UV8zYvdg3jxhZAeshDdg=
X-Google-Smtp-Source: AGHT+IFqNSeyu5ysJRlmtT2ns0A0VAtvaCxW7keq4XHjht6CCd+aCS4HGus7JObaFmQciOHwXseQ92brZfzE7vb31ao=
X-Received: by 2002:a05:6102:6d3:b0:4e2:872a:857b with SMTP id
 ada2fe7eead31-4e2872a85f1mr6164175137.7.1747732614991; Tue, 20 May 2025
 02:16:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 02:16:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 May 2025 02:16:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250520014920.201736-3-jltobler@gmail.com>
References: <20250507030249.4802-1-jltobler@gmail.com> <20250520014920.201736-1-jltobler@gmail.com>
 <20250520014920.201736-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 May 2025 02:16:53 -0700
X-Gm-Features: AX0GCFtTN2cwRvNSQFg-j27XhWohSpNo-KCsllEYdilDq2ZOGlkmrmY7ZsntgEA
Message-ID: <CAOLa=ZR3kVG+ob-pzH+eB+0W6+mFMSe3CBKotiCOOZzff0U9nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/receive-pack: add option to skip connectivity check
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000adeede06358db5d7"

--000000000000adeede06358db5d7
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> During git-receive-pack(1), connectivity of the object graph is
> validated to ensure that the received packfile does not leave the
> repository in a broken state. This is done via git-rev-list(1) and
> walking the objects which can be expensive for large repositories.
>
> Generally, this check is critical to avoid an incomplete received
> packfile from corrupting a repository. Server operators may have
> additional knowledge though around exactly how Git is being used on the
> server-side which can be used to facilitate more efficient connectivity
> computatation of incoming objects.
>

s/computatation/computation

>
> For example, if it can be ensured that all objects in a repository are
> connected and do not depend on any missing objects, the connectivity of
> newly written objects can be checked by walking the object graph
> containing only the new objects from the updated tips and identifying
> the missing objects which represent the boundary between the new objects
> and the repository. These boundary objects can be checked in the
> canonical repository to ensure the new objects connect as expected and
> thus avoid walking the rest of the object graph.
>
> Git itself cannot make the guarantees required for such an optimization
> as it is possible for a repository to contain an unreachable object that
> references a missing object without the repository being considered
> corrupt.
>
> Introduce the --skip-connectivity-check option for git-receive-pack(1)
> which bypasses this connectivity check to give more control to the
> server-side. Note that without proper server-side validation of newly
> received objects handled outside of Git, usage of this option risks
> corrupting a repository.
>

I don't have any comments for the patch itself, looked good to me!

--000000000000adeede06358db5d7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fbd632fd395cffc5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nc1NJUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTEvQy85NDBBcTRydkZjR0RweVlVbmVsaFVyMm5nMAo5R0l4WkhzdVd4
aWpCMkc5ZkNuSmxraXVEc3BYUlJieFFySE53RnFPTXRqQ01BRmFKOXZQK05Gck5qcXRFRlBJCjdF
UG9ESWxBZ1h1eisrWXlNNlRpQWUzNnk0b2FrdmQ3Rytqc3plbnROdlBQbTdhWmFkU2EzWFM2WVNQ
bk1iRTgKS0syL09kZGNXL3Y0WmV1NGNZQUU2dW9FZGhQT1NBV2J4V1VsSHhkNmpMVDY0Um9zcXZo
UEhNdE5ESEZsb3h2SQpaVER0bXNUeHpBU2FMeEZzTTl0elRuYndNcHVUVjVBN2g3ZjFFT2o5dk1N
RTA1WGxnaVJxUjQ5aE16VFlGbXNICm45MlRySzRZSERldHFpclgvc2RYdnFWNnhUeWVJYWJpUDEw
MXREdGRMVDVITkR0K0Ruekkxc0lWZHdON3JYb0wKeGxweUdWaE92RHdnNVp2b1QwQkp5NnpZTDVx
TkJENitaVmppb1pFc2VNWkNmVjdCOUcvbUF3dWowVnVEeEtnQgo1Mm5FNGl5U2pXSVZSWmd6ckY1
dVkvazQxUHR0cGlhNFdMcG9mVVlHeFNNb1VuSkdncmMxOE9pWWQxL3BGMVZOCnRSS25leFNxZHl6
YnpnMSt2eVRYUDFNbER5ZG5Rd2F4SThDaWpIbz0KPXN5OGkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000adeede06358db5d7--
