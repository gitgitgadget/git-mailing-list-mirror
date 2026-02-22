Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1E350A0F
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771785629; cv=none; b=pkXEeFI33Z4MTL1s2xyvD8MXP1AV2GPjnwIrDN8eQT73xmgf5/s+OAcq5EgKzFTZ4vsCjMkasIRmS7TQlQxGz8qKwFWpW8ontlJ9THyY+z08XCGDrNkYGb+vxnrh29vfljfZQbwA/uJhCddFc1ZfJ5EOxRIp5RZF/+Iquty6C8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771785629; c=relaxed/simple;
	bh=/FHUMY2PajwoqfgJ+EBE5Fg5DZmfBS+SDX6RmS7CKUs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NZdifmwFFAr6AjpL2bhGIhDfdo+DU2dsiFQRReN8jdiv8vbxn6zQO00f7iIdiuTglO97E+x7LRnug5AdmALyXL3UzP71/hjdXo4KGgvYZC9COMt5MPCjVBJzWJpfHX83qe0no51J2pOyNZ7wN5ERo0Twfo9jihl9sDw8Jgp+8+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3DUSuxq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3DUSuxq"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82311f4070cso2222111b3a.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771785628; x=1772390428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZ2fyJuBIX8X1UthMZruZIrHmDt4HEMLHrw9Pgtth0k=;
        b=m3DUSuxqn6SlRJOhvJvGgtUlIHM4PPE0XCk4S3Spg7Q0xy9UCKVaDItJrgjEURCbZq
         F/mMrzw1HcQAwzugrRycK1iwLBcoxpLWKwWe5B9FhdLfqqIvNgW1URriWAw1Ct9uccOZ
         8LDrVy5senP+FQVw4eyN8E7sP/ol1WkwCv4P7UVg03RwTWC6XyhsQr46lOBab4YEkHLv
         dN1syxZFQZFRE9j3W/9GIV2CkL1izoVUmCPvxGm4feP+hX9pczJYSWPQVP/czw6wAPRl
         6YIfVBAcZa1aqTtxjJ3k5QTlm+kQhlAVyOX6NDvfielTJ4KM5gFdCzZB7GCjFnxet5Hi
         Ex+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771785628; x=1772390428;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ2fyJuBIX8X1UthMZruZIrHmDt4HEMLHrw9Pgtth0k=;
        b=V/Hv4ZYCLVDmWf2FRl11GaQm5ZSSYnS4lEilnHhgiVj5p6IAhbGfWrRlx/4a9vPJyW
         C7Su6ohf0Yz9rPAwP22P5k7nQeMRREfjEK9SHuY1OF1E3qmLBteDhaUyQ6baMwZn4NEi
         LYlKa5C+VGKx6HfcCjkQQVkHr97lQ4kBVO736vpnonog2TZ9bAB2CxpFEobFMCR4o2VC
         aEx0q2uJklMeUqcGYaKsOuzZ3owetKarbuasFo42Z5ANRpRG5IGz80roYhTU0kh6U/Zn
         oT8f/eiYGPMt0U2YjaWCyeAXBjC92jro0QockOh6L6k6yoqNFEy8livqoFBzYvcPK8Wy
         1Q8g==
X-Gm-Message-State: AOJu0Yw/I1oXKj8DfJzQ3/nKaKEZC2FBEVStfKwH9HZD8Kpke2Hb+XzU
	8Ha4k9lALglD2AibnNQVuQ8x2aXB+ATzlmLnOXP5YwLf2EKfKBo30s4492+Q0w==
X-Gm-Gg: AZuq6aI33KV0s9Hxn+47TGD+Q1yKGd0g1RH44Yd6+ev6B/0WhrGVucUG37mReYQ5fnd
	EkNojrBYxyPEfrvP5Izpyb3UKeHtQIiGVHjgCcUkwRdaCk9YkQLXnvWV+hFKrRrBDs44DOVwjvB
	ohRhYS8RrgHJnXJF36p0NammKIq0cZb68Upp1+aUP+ke5TzurYBFCtimx9hYyINuqs48zJb1PFz
	5uDeB7A+HvD8Tjebsgrxq4vS4W3wc3dubqPj7ygzRXl4W7mBAWfpOPCBjhLKXiYwE+3eRikFy2a
	D7eGLVMK59dj4L+pn5wLQOHxehfGGaMnU6df/X39F1YOSNK+ffZy9dZ6ydwXMxPAief4VNukRZ0
	y9TwTEukSQJBZ9xSS0Z8OYTAo8/KZacApXvS4X0ODF7nlv5pc7N3DTonyZnT51+ngeuPcuA0kE/
	TNRzk/ILqpebdiE8x2mhHr0MsiiY1+S4TtbM2EX37Q0gG+7g==
X-Received: by 2002:a05:6a00:18a8:b0:823:5729:a125 with SMTP id d2e1a72fcca58-826db929763mr5650056b3a.30.1771785627703;
        Sun, 22 Feb 2026 10:40:27 -0800 (PST)
Received: from ehlo.thunderbird.net ([2401:4900:4def:1e47:6f96:4fd8:3122:12d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd692a54sm5533278b3a.21.2026.02.22.10.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 10:40:27 -0800 (PST)
Date: Mon, 23 Feb 2026 00:10:19 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: git <git@vger.kernel.org>
CC: karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Meet Soni <meetsoni3017@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 Bello Olamide <belkid98@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
Subject: Re: Git project and GSoC 2026
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
Message-ID: <A01D97A5-48EC-4633-B0BE-8C1541156C2A@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,


On 16 January 2026 4:36:13=E2=80=AFpm IST, Christian Couder <christian=2Ec=
ouder@gmail=2Ecom> wrote:
>
>The application period for mentoring organizations to participate in
>GSoC 2026 is from January 19 to February 3=2E Let's try to anticipate a
>bit and decide soon if the Git project wants to participate=2E
>

Just to keep this thread updated=2E Git has been successfuly accepted as a=
 mentoring organization for 2026=2E Thank you to Christian for organizing=
=2E Also, thank you to our community members who've volunteered to mentor s=
tudents this year: Karthik Nayak, Justin Tobler, Siddharth Asthana, Chandra=
 Pratap and Ayush Chandekar

Let us look forward towards a good summer of code experience for the new c=
ontributors who could potentially become long-term members of the community=
=2E
  <https://summerofcode=2Ewithgoogle=2Ecom/programs/2026/organizations/git=
>

It's good to see GSoC related contributions in the list already=2E Similar=
ly, we'll be seeing more candidates participating by sending out their micr=
o-projects=2E Let's give them a good guidance :-)

That said, we have the ideas listed in our ideas page=2E Feel free to sugg=
est more ideas if you have any=2E

  <https://git=2Egithub=2Eio/SoC-2026-Ideas>

Volunteer mentors willing to mentor students are always welcome=2E Let us =
know if you're interested=2E

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
