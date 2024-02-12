Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AF610E5
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 01:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707701750; cv=none; b=kEk2cZB66hWcLz+tOAIVXdIVUSZws3yG2EnT7kPgbwibH3dD58t92Qf9tAcKX/XCMtKFaeBpYJRYrrKgOpe3xoxcr0/BRgR0n3ekRmNQNYobmOKlF6/tFThoG+SPz5zLn52xwrPZWs5JidhnAVqPF2vkKu3mm98Gh5WPV/5Bbyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707701750; c=relaxed/simple;
	bh=y1KnwEp1juxpB4ui3ezDuHbkzS9Tj+w0426qfO2a4/s=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=RmljhQTvYjWpl3X99lfRKjIrRdJ6BtJ6TJazAzUQcsnyZl8Ts6RlpLEWN/lOXPltL7Ahi6Ggq3W4TaxK6KrvEUarep7leatHDAX9GaiDTfyh+9ZLgD5FZ+FI3maRNBaeLCorax4W/NCJuO9lrXjd+DjPZfvmRhQXDdCbNi9HdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHwjSFCb; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHwjSFCb"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e2dfaa93c5so348515a34.3
        for <git@vger.kernel.org>; Sun, 11 Feb 2024 17:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707701747; x=1708306547; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1KnwEp1juxpB4ui3ezDuHbkzS9Tj+w0426qfO2a4/s=;
        b=OHwjSFCb3gU0PJBkNtiHuZoflPcP6zEUyo7Yk6qQmbTxiVKMjtYp7tjIPh9u4+pkfi
         c2jYMnNo4nu5niiWdewRZU+HcK/zlphXnhF2gu1Ej03wYxzab46zL30r1nEOS5pBy2m5
         r5G+/a72dxHu9/Vomvvd1RX7MZfJB/T78qJN7SWGX55PVeawEqqGzqOcWn4t+ZWlD4vN
         YkjFV5HbQzuaxu7SySJDpPbmIXbQGOH+7sMKT7w8en5rUKQQMmNaxasKygQcNSx6tO21
         FislW74ET4hCeRlwCn5Q2fFOseKtnK2DlI7AQJC5BtDizzOrPRnDftrzcaU7I0pXTLp7
         TXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707701747; x=1708306547;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1KnwEp1juxpB4ui3ezDuHbkzS9Tj+w0426qfO2a4/s=;
        b=bHLvge3tjYR3ZvX/OrriH4vUJ50P+4oQqi7gAYRFdupbUlRPj8CoDUMxkFP6BgPui+
         vZKsV1U8EfzqZGSluLDdpPuVdeg1zn1YLKo/lT5wbypPMpPJ50k2NtHpBWLrOJOHEyHp
         V0BiIuzUAYwcFa32lvajCKua0bFfaF629sZ0jqZD3rq1FVQgbUduCVZXKy60TA8o6W+i
         W06aOQnFK0HaQwgHtcTIlt4uJAIj4GMfp+8W4bOHmyBwYA05KILHL0Zw4pOgJitH6+sB
         hIwKuPSFHwkfzbDEIeVwGuAyruAr8E0sgkU6Yx9motSKKgdRmb27vMi4B+/OVeijWwc5
         q6TQ==
X-Gm-Message-State: AOJu0Yw3EN5YrovfA+54Xrg9WQM2BDfDVMRwwOxcpFdio/NDmu1f2kbY
	BwP3OjNQfr97kCHTP4AOLBq3j0WsbDoWmvsNYKprxGLP18dP4Ye9dRz8s8+9
X-Google-Smtp-Source: AGHT+IH6k4QDXgV+T5jjeymDzSgY7kjr2hfulvR0rvYtWcSk+DKqO98AumA8DnuiVV0YSn/POTpVjg==
X-Received: by 2002:a9d:6302:0:b0:6e1:7b0:fb99 with SMTP id q2-20020a9d6302000000b006e107b0fb99mr4428611otk.21.1707701746962;
        Sun, 11 Feb 2024 17:35:46 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id y15-20020a9d634f000000b006e13c3274c2sm1312352otk.8.2024.02.11.17.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 17:35:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "=?utf-8?Q?Jean-No=C3=ABl_AVILA?=" <jn.avila@free.fr>
In-Reply-To: <2345401.ElGaqSPkdT@cayenne>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] cherry-pick: add `--empty` for more robust redundant
	 commit handling
Message-ID: <17b2f9b0a891ad00.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 12 Feb 2024 01:35:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 2:50=E2=80=AFPM Jean-No=C3=ABl AVILA <jn.avila@free.=
fr>
wrote:

> Hello,
>=20
> There's a typo.
>=20
> On Saturday, 10 February 2024 08:43:56 CET Brian Lyles wrote:
>> +--
>> ++
>> +Note that this option species how to handle a commit that was not initia=
lly
>=20
> this option *specifies*

Thank you for catching this, I'll correct it in v3.

--=20
Thank you,
Brian Lyles
