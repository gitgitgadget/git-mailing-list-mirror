Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E20385D86
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517072; cv=pass; b=dDNvdfXOHEoX0v37l6Loe9FeXZFKOKBOK/qClbVND/IRBWzPhZ6ViskLI/BQr6krqFTFPTMrGY3UuYg+dW1WP7q0sLqNQvTjweQBIgd5xhEBCs7UQGUKE76UqEawAkbRbrq50MMCkI344qQv15Gn2Jv8cmr54I4NeGWIBAfepdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517072; c=relaxed/simple;
	bh=7ktieSx6MulrKvwqRiVpGI6rUoWNsOX+ZverdF4sguM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqCkPEQk7NrjZYjk56LYHJmtL7UEOY+k1wkfe72OhT55P9mIN63nk1Py4EFbnCKlhUSOTZRWKeqev6S9gNQGB6e9P9uLEPDRnjFMSq6fulQyGBlRPGTrEHsELbjhOUotitTqutQXgXo7S3lcxaa+PioUy6XGYU43jvFAi1NTD6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9ewJdS2; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9ewJdS2"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6c6507549c3so795020137.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 13:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780517070; cv=none;
        d=google.com; s=arc-20240605;
        b=R39JGAaCAYfEGd2VT3HXzxW0cMGO6Iqbk6l5spoq0E8JwjczLx0hzjQt1leh5Yefx9
         F3z33CVCIlOxElCdI/87ulh4o6Qp9kMqZxXTC5ofMt8W2UjFiE5SFmHrDYbD9DfwZGCl
         OLL61V4ABIrPH3IG+bRx+rsvVgymZOa0UhII+3q16fwerZQcbvVJfGktZLufjEGxFd73
         Mg3pQLN/kjxBoh7C93pvuFwStsOsRzhY75TnFCN2gU6nnPN84gVG6pCx4dRvsmIQPm4H
         p7gxURFac5bZREFayt4liPumCo/HSn3vloXAmf2iHbRxo9ql3K2royxKPLaQxqYoNS3T
         1D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=7ktieSx6MulrKvwqRiVpGI6rUoWNsOX+ZverdF4sguM=;
        fh=0oy4m1hL2rY5sX8wdEV4Hgv+nJv8fq8XCeSEuLWxwTU=;
        b=Fs8F5deNmbvwecc4dy07XxNIhhBzBweZ79cO538TSn7bf8bVgYyLeDrNvME0jZw0LV
         IeN59jDoACZD5KfcNe7megXmh972fYhEkjKZDcII23iRLkBrwQiYpoHhAVwaz1xaUeut
         DpG7lu28RtiLvcfrdG6fH9maVb1AJOZXtm3wdE1fcAZV2ZKiW57Z1egy7gnlBQWovzYT
         nV6l96/QjFwgXiFEmo/att63WE9KOA/sUcOQ07xrN41Wzjia1Oa+Mkt06QK1wmTvU0wQ
         L2nGkWH+bqMc47MZfBVIwIQQapaIhjrVFdcDbkGTZFbO14a1s/kn9hHqyPGSeT4rXsMB
         yfjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780517070; x=1781121870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7ktieSx6MulrKvwqRiVpGI6rUoWNsOX+ZverdF4sguM=;
        b=T9ewJdS26ejMCXyAIAsWNPTPsvKTMRNEbbLHi5czRC2dcwO9ojlhbQ2ds6Zx1JIHhU
         hyiAzLLQnuGUUsGg+eRZstb0wlaac8fOjVJExE7Rwu3SJRDUj4nt7oj6C98k8TPrVZ37
         IHo6HF5XHtPx9sVXJcL9FtDkU1OIKK/b8jCOMm7uAn/78HSEpcMxy8+6rukRpXoDprh/
         cYIzD4U3X1K7ifvRjOT46Jd+0//zzCwgRbMYXb4OBfzmDz5hVcDLrs+KxgPLk7FrrRsi
         SRuxwWGFKODIB86XO083RbCFoz3r24CWbX2SLhqQU/nJU3c58CD5vzyAttmjOOQqn+A8
         4RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780517070; x=1781121870;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ktieSx6MulrKvwqRiVpGI6rUoWNsOX+ZverdF4sguM=;
        b=ASXU2nB+iAmMMFfUkBo8oy/MeDBpEw5g5w1f4crtfZ1nu9MSpSIavWa49dRimZTggw
         1DTdy/DpmsxpKfX82ly/2Ns3zMHfx1Zqa90IZUOxIam2DyINy6dv7k7j+dV4glnSgzDO
         0AqY5sP7cl1XtBnQ//QVetd8smCC4Ua5tWjSkbVAARkPMPZhB9R1XLnszNBGyiTlbIV/
         bb6mKsUOq6Yyrc/fQgxU9NAzQ/FetBFg/prg5rHyD2AL6YhFVn0JrmUZ/nsAQ9HY+dLU
         f9IIRqa8hJKuWgeIaOc9chW1FPtZ43M+ek/a5EN5fvU4EXYYCoraCATlSdAQxbHEHZS8
         EfSg==
X-Forwarded-Encrypted: i=1; AFNElJ9YhO5rHzQd8Baif6plhFrFEqpinT8O3wQpY91lxWWoqnsmALfxzUbhU7+7w0Na3dDZjr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzju/xkYOzqAcf9JAAsyjmlkf2wS53pqfrWGmHCE+Eat+KYfKMn
	5RWjXvxfstGNS1IGbF7T3Ljl6bL6wlnQivPbshfCoT3NZmrnTWFsMIaVkJJAFXZW2w9c9SGsTd5
	aspM+eu+i6jGZHkL6FuYi0CqAnTPfUKE=
X-Gm-Gg: Acq92OEqSAq61UgWvdU2W5x0lOZvkeKJ9vDJUAg8yGslzme/rvI0etxKII0n7yTEZRm
	lklgwOyhOgc93omC5ei9prym/VrIZB3ZGeOnetkate+rMf65TjfLUXoDnbe8iJiQDmYsr++tWte
	3zDdv+7US6CANvamO9v6e288NA7n0GuThHrKhUrMxl4XktCobLrE1iedf86VKEAWVs5xG9PlGK/
	hitUmCfjgm+2TD+fK/kTv1R5Iu+9Ac2OhXUqWQSGitG9whJTFwPwxBlF9tEdNC8zmqEE04w1NrM
	ES5YfzdENb8LI2NM4XhjSXALszr5Y2BPeuVRfNKie2/otty9OK/nQ5qEJGtUua8KsKjfQ3TMHnW
	6J9X4hORC
X-Received: by 2002:a05:6102:b11:b0:633:4d1a:65f5 with SMTP id
 ada2fe7eead31-6f54fbcf344mr513923137.10.1780517069768; Wed, 03 Jun 2026
 13:04:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 13:04:28 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 3 Jun 2026 13:04:28 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZSRQpAMGDwfP8vAiJi+G=WPW=YPrrs21pVt1O4j2Uh-zQ@mail.gmail.com>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
 <20260601-b4-pks-odb-source-loose-v2-1-90ff159430af@pks.im> <CAOLa=ZSRQpAMGDwfP8vAiJi+G=WPW=YPrrs21pVt1O4j2Uh-zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 3 Jun 2026 13:04:28 -0700
X-Gm-Features: AVHnY4KdxxI83dHGUakSiTuesrOVBc4aUYNCaIVpv40p-LJIpskUBzPz4d1REbU
Message-ID: <CAOLa=ZTfL+MO_uF4SF-iRHbtwpk8TGU2CH1kHX59XuBeKbcyHQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] odb/source-loose: move loose source into "odb/" subsystem
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="00000000000075eae306535eefab"

--00000000000075eae306535eefab
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> In subsequent patches we'll be turning `struct odb_source_loose` into a
>> proper `struct odb_source`. As a first step towards this goal, move its
>
> s/its/this?
>

Post reading it again, seems like 'its' fits all along.

>> struct out of "object-file.c" and into "odb/source-loose.c".
>>
>> This detaches the implementation of the loose object source from the
>> generic object file code, following the same convention already used by
>> the "files" and "in-memory" sources.
>>
>> No functional changes are intended.
>>
>
> [snip]

--00000000000075eae306535eefab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e4437531568d1af_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vZ2lNc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meGt6Qy85Zit0b3Mya1JUSUc2NGNkYUh0dXdvdmJzcgpsVGVQV0txUXBm
VjU2dFF1V2I1ZElkUll5L3FPaDVtaHBBb2RYdGsyT3dKVnRjMFNrYi8rOUc4YkRYRUJsU3RSCkZi
VFdZMGNUeEZSRFhSVXp1SDlvZ3Z5b1JBNERVdlVMZFhLTGpDZWV4d0pRbFBvRDBFbjhGbVpKMXMy
TWlKNGoKNVU4QnpNYUVpR3Blc2VDbVptdEFzeHJUQ1JkS2ZoODJEMGhEY0JLaWV6S1R1MVFaTVNk
Nzk5bGlST1VnVzVBQQoySUFTcXJNaUlzcHBBcThVR0pRSHFlWXFiQ2p4SGhBL2RIbmt5VDBwem42
a3dUY1Flb0VVVlY2cWc0Uk1zcVpICjgwT1VOSmxSZ3JIT0w3ck5hZ0RMY0ZibUdOOEpkZWRHSzYw
RTN1eEpRSnRoQlFuWEErZDFza2RQcnNpY1NRMW8KRnpsZWc2WEp4QnBPNkFuWnF1b0xIMll5YnY1
eUdVNTlNa3dWMHhlbGZwQlBXalJZaUJUZHNMWERqSDBNNHpvZQpKZkNLT0RHOEl5N1BoREQvWHdN
QVI3SkltTTJKLzRrQWtXam1HS1VmeUY0NG9iT0svSGhVeGJraHF0RFNaRW5mCnpsaEV2L2J4U1dK
THE2dU5Xa2ZmSTAzVFhFRTN3NWVmYnl6QVZYRT0KPUhVQWkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000075eae306535eefab--
