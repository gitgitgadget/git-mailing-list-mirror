Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD1142E7C
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094522; cv=none; b=WJrASDa+6n+5SmqwJd1n462chTq5gYlSFirPAHYqJ4ngniR97NjLLWufrfWJn0nIcnS2geiGsFv0STsdP99xs8Qebq7rZtVaWPTDW8EQ8Yt+D7lROUY/Qp9uBocOM5DxHuvX7rUN+ZA4hGAXTMHguzLnZZ7Q/LU7SuLA2HqlR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094522; c=relaxed/simple;
	bh=g8td16JU0nXbadHU8DFz1O/rttlXnz+qhI8TmYMypDo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXmcB8YoaCoJJwIKku1d1KIqeK+zY10vM330Qe9QC8bP/mdoeUcubFIxr/kVjk/onNka4iVZS9YEJ4/uJw7kk6SWglM5GTZLWPPKQuNQEu+MKeurcvI6g2xijDbYlmiBDbhfo+da8dhbaekOCLZSLRfjp023amMka5HqVTd7UcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL8WwGCi; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL8WwGCi"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5174f9c0d2aso500615e0c.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 22:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737094519; x=1737699319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6QPaVwXumYjX4tBt0QIrw2IKF1bXZi2kskfNQl+48Y=;
        b=WL8WwGCiIr0iAtxCvrgFHx5/nNhnUy+mp9WfeUFXYm3wF4RDjmzw7UpgWAoBOxDA0o
         YmDhRovTia+E7H+x+PlOtBqrG5U5PfrSS3Kbk5+6qM/Wl6MoIVF7AA9ImWCxl96VVmZa
         q8F5CNewxvAmCS6T0nKZWUSk3mtwTH0t8q/yd3MU/L2zqcxLDcwXSiemRabcPZg9vokd
         b6Y0+ROstG7uTEsevuf7wPVXLHYqtOnolJgWY/mrnbYQQpAM+SaOGV8haWdM5V1bwq9l
         YM6MFqRny+VIOKVVTO5EHzL13TE4RQ/eQ4zHiIp2M6WYzEZZBVkejHCZQpC5WeRWg10H
         tkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737094519; x=1737699319;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6QPaVwXumYjX4tBt0QIrw2IKF1bXZi2kskfNQl+48Y=;
        b=op41rKimn7t2QRYayTM0i57RBZin8Jsw8erbOjHGLwjuxStmkche/8QofVcvAUNKwE
         g6TcnEOM8dxJ2iZN0KaaHg7y7ArS2WJCuPSt3au2vuKdWCekmKasx/D8oPDkMGtCReMh
         HlcFU+H+D7SzvtTvpO/L3GgMeUWX6WijfLsDD6xlHQcTza657mJRhxKTpdPvBVsoIYAd
         1WPRbaAIdyYpgSvXTcEY8BVxZwFcj6Q8ggCfp6V7iDR/ylyBO9ev6eR+FhhFRv1UrjlU
         DEfOYSocyXLZqxSWvVxs0PIHcEV2vipDBB1MCBelMSaAahTEPDrX3XxJVMt065qohA/a
         eGDQ==
X-Gm-Message-State: AOJu0YxqaeTiVE1m4bYoe+U42SkC/j+v8b4p726WM0KOE0RQ2qEZINjn
	6Lb6Pa+R3Vxbf8T/2BNWMWCq4lJYTL9pboQYv3iIgMGpnQRK+f1JJs5gX9Tzb5lthR0DyIsZYTh
	2HpKuz0nRO7nKBunr2Ha7p1YIlFlutiPB
X-Gm-Gg: ASbGncsG6qYg6YSCnMeh8p+wvdSHnc7V9N01VhxqerzOKQq8bj5DNftcg0KYqdq047U
	QpZu+J7pH7xYQltLtWHUZLOoS6Qu2uvVzPzbKa/8=
X-Google-Smtp-Source: AGHT+IFlpd00Rl9PtS2xrcO+EsW1iKGKxHZJHd801QLDuZ6+LPW2RNMHcrZbwCAKwKTKnNW7HscBnoUzxQ8Od9GHCc4=
X-Received: by 2002:a05:6122:370f:b0:514:eeba:517 with SMTP id
 71dfb90a1353d-51d5b3768ccmr1149991e0c.10.1737094519619; Thu, 16 Jan 2025
 22:15:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jan 2025 00:15:18 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
 <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com> <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 17 Jan 2025 00:15:18 -0600
X-Gm-Features: AbW1kvYRpZcTl0Z2eYW0V0CCysXVSPXxtDuqKWH6rLEY86kjI1530Id7MgoZ1q8
Message-ID: <CAOLa=ZQC9E6WnaD-aaNzOJnqjwvdccvopOkagRvKmsz7_U1V6A@mail.gmail.com>
Subject: Re: Bug in 2.48 with `git refs migrate`
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000c8a2cd062be0d500"

--000000000000c8a2cd062be0d500
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-01-15 at 11:54:51, Karthik Nayak wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> I'm attaching a patch below which should fixes the issue for me and also
>> adding a test to test against the same. I'd be grateful if you could
>> also test the patch against the repositoryies you mention.
>
> I can confirm that the patch did indeed fix the problem.  I was able to
> convert both repositories successfully (and very quickly, no less), and
> they both work fine (I did normal development activity with them) with
> an unmodified Git 2.48 after the migration process.
>

Wohoo!

> Thanks again for the quick fix.

Thanks for reporting and testing! I'm glad it fixed the issue.

> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

--000000000000c8a2cd062be0d500
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: daad2d2e9ce08df0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSjlYUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2VlREFDZTJ1dElCaXBJRzVNMFdjMnM2Qk9QYmV5OQoycXl5YjdxSkZP
WEc5WDlmSkZodFFFZE5JZ2pnb0dTaS92bDNhcmpTYU9uMDhpNEZmbkJVUXRqVWlXU3ZQdWxqClBE
eTVIMmp4WmFzN2xHMmIzKzNyV1VKUGVJdDlBb1JjUENPZUE0TjEvUmhZU2dIZjViMTRNUW9LSVdq
Z3FvczIKVk13Q3g2REZSYXBjNXNBVzNkQjNWOVdFQ2h0bWNsTlcxU2lTN0g5cDdOM1hBWXJuNElj
M213R2lDV0FST3Y5Zgpzb09WRUg5U2wzUlUzaUg5eWdUQmRhTWQ1NzNwZmkySGtUL1VwSmEwZVZu
dFJBdWdOYmJRM3hLeHN5MVIxVDV5CjY4aExzdmRiSEVtVnRzbzFNS1R0NjNicTBHZnV4b1g3SnV1
YTRiazBDZHV1dmpUNzR1MmRCbjJTd1YvQnlaODgKUlhJTzRUeEQwelcwZUpjTll6RVo0T2lhdGhz
eldaTnlCU0dFanppUEQxSGJHN3k3R3d2MXNMdU4xczhodEZqTwp3S0JEM0lXdFBZbDNLYWN1a1NV
ZElDRVFOQzBhWG5HcXRxc1ppRWlPOEFibnFjMzZ6T1JpNml0RHBVQlcxYTkyCnlIQVRCZmhiNEhO
TC9GSkdEbEdISWRnNC9zMTcyMXhPTDVpM1ZwVT0KPVJNdncKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c8a2cd062be0d500--
