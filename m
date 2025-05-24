Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF8A1E51FB
	for <git@vger.kernel.org>; Sat, 24 May 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748104367; cv=none; b=bHAjvZl3jM9etGHly6P9UMJOtV87Vn9ke1GZ+1yrw4rK6tUcGImdjXczyxzEdEPVk3LHio0YsG+HMr819XdMNiMLxBM+ATbLlkyg6gdTZikEa1HCigGsiS4/mHRrif4DBp1xSr6DGh5ZTbePwshnRYvRGxt96YryRAF0fH5Vl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748104367; c=relaxed/simple;
	bh=oJqlFK0Exay8eVtjK0E/jFWrX6VDe5chPgZnY0ewIOw=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=BFebTSVJk+acBA8h3RyruqxPh3NEn/TPf5gC/aCRbAWM5hkNdidDs3oEJ+AN6A8vvAZdwc0wfclmdruGPKHQaLrndHZ3wBO5hf626AIVmClBG6XJG8jn+VzUn02SzfQbiovLCJfMFNyUG3IMZM0F8N0lnM+OI++04b85jjuFQ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA7QWvlG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA7QWvlG"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70cca430085so8075877b3.3
        for <git@vger.kernel.org>; Sat, 24 May 2025 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748104365; x=1748709165; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZnl4gNJqFXHAsNRVe5unJj3TtxLvYOSDlQ8QnhKEfk=;
        b=OA7QWvlGEgH7tgMvt0uN00nTQKCQvEMGlKEAToN317LuchST/pa//YR4SasWZkA8JS
         WnHSJMPZek8f/ahIo62LSu/2ucprAKQXFPIljPM8Y1jITlatsGDk8LT+KGDCGV7GIXkt
         YMQyKEVaJjlP7P8owcXR/G8e+5YkTVEv7j6I/rrC8yXYxrJoIn9RS4ybFggEP4Cd0IJE
         P/FSbvM+ooMkN0AG27mPzHPWo50w/KhnktpnXqwb+jrsCsBRl19RvNJm4iXf5oUuFhPo
         zrwF3jb/NtHWJmja7dEgEmB8Z1ja1xDvxUJuxtBw84Qr5Gj4JPU79sYqJS7dlxZ8gpHF
         oGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748104365; x=1748709165;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZnl4gNJqFXHAsNRVe5unJj3TtxLvYOSDlQ8QnhKEfk=;
        b=nhrhXkOCu4N7vJku82XJDGhxAtB5sjTMzz6QbBsZ8960/EU2rfztv8MkW/Fjtrw35l
         Ad+iVpeqPzmBOoo60aTTOxiNqq7t9IYufMnj3trVgNG4FA1iHIXr8YOiVq7xUQQQNnkH
         oQRNTMGbeVB97r8Juoy/qNIBP+ESApUk1/+d2yrj39FM1qA3oaGQh8pXnM1gpzZckIoo
         MeINvvhIgPD2zsjAkBUch3H1vN6uIU2OgJv88rmYWoWk2vHe4aYNeHd1MwQTznKsGl5u
         +3L4QNTzPf0A+AuJuRMdPu1rztNyN0UsieehNYZxRG/kcp9q6S9g2Bcvr4CwNvU8Fvp1
         3qXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlyAUJIlvjoTF0siM06rXCGiuhmmyKjsUREJ5AAONr6Ph/ZYHm7lZIXy6rSkBCq8sZvS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsG2Y/ftPI6cIeby2jN6wTCR3rM7CLs0LICXwUu6LOA7cYcnYX
	LFSZTIUAmqemPITE+r5rm82S6XmnGcFy/ikjm8pDEVMQuy6yE+g6kmDw
X-Gm-Gg: ASbGnctAYmMe4Gq6w/UUMxy4q4aUvhigWXou/3x4QLYZPpx3ub2khkdwzfJapU0Tih9
	Of/J5dcCqFSYlCa+FbzkJI9oktn0Ugm4/y7gixL9pQV2XJSiOMWtdUD2beUApMH2jgxeDfgZCkW
	fX9+1BqBuzzeWusKxhtHGnr4qTbMTU+SX8UTY1wUhTKm46rFBTSP9KroTOE7R9Wvm2MFlGKE1bs
	PaCCfgu8RjRoAxATl7WBsbiVis+vRGrpgeOW9dpMUMTrBMFZD2qP4z5Gxja2FeKL6+uWUs2VaqI
	N6SWD7rGmPz6ioTXUGPGxvXCyZJyhxy4Gv1HL7yaX68gPENBhR5BAJt4ZSWX3lKRju1EUoGYJgZ
	jPr/0bOdAzVZn86WggvkY9WV4tbHDKqCLCWIwJ8FpAzMY
X-Google-Smtp-Source: AGHT+IHf9nmskurxGFqOxT67zXgWM0TKN1Z0qJK0O415rr6vWWly8WqWpEQ+7eCV6K+1bDqYg5BF4A==
X-Received: by 2002:a05:690c:8c06:b0:70e:23e6:60f7 with SMTP id 00721157ae682-70e2dabb3a3mr24214337b3.27.1748104365203;
        Sat, 24 May 2025 09:32:45 -0700 (PDT)
Received: from smtpclient.apple (99-144-70-174.lightspeed.chrlnc.sbcglobal.net. [99.144.70.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70dff0227f3sm13881437b3.27.2025.05.24.09.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 May 2025 09:32:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to NULL
Date: Sat, 24 May 2025 12:32:34 -0400
Message-Id: <C0BA42B3-D312-4575-A326-23E56D0EE8B5@gmail.com>
References: <E78F34A7-359E-4049-9780-30FC290DA7E2@gmail.com>
Cc: Aditya Garg <gargaditya08@live.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
In-Reply-To: <E78F34A7-359E-4049-9780-30FC290DA7E2@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: iPhone Mail (21F90)


> Le 24 mai 2025 =C3=A0 12:28, Ben Knoble <ben.knoble@gmail.com> a =C3=A9cri=
t :
>=20
> =EF=BB=BF
>> Le 22 mai 2025 =C3=A0 14:26, Eric Sunshine <sunshine@sunshineco.com> a =C3=
=A9crit :
>>=20
>>   ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));=

>>   free(response);
>>   if (ret !=3D strlen(response))
>>       return error("IMAP error: sending response failed");
>>   return 0;
>=20
> Apologies if I missed something , but : strlen _after_ free?

Ah, others caught this already (and I hadn=E2=80=99t finished reading yet). I=
 really need to find a way to queue up my messages and then go back after fi=
nishing a thread and edit before sending ;)=
