Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179712356DE
	for <git@vger.kernel.org>; Wed, 21 May 2025 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822227; cv=none; b=fbDJ0X7bYhK4fE9R8y7VwIM9wqeG76kOQ/JqUezOZsujYd7+LlbCDWC9acL0kMQ7k1b5KtvVsdjLuY3WLTbiEjfSa7LqNonsaSIWrvSpAp1c8b1pgHDl2SRVH8ndIy0RFF9vqy7ZdGTVm7OniXhlSRZ5BqtBUQFl70ad1tS4P3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822227; c=relaxed/simple;
	bh=p3EUgh/myT1Z8C2z+2HidsoreTeSt5N8n/s7vimjF6U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=EilbMQ7G5RFEtGrjCO5cJ65Tj92I2CX8cPnlKGPJhzROMSxDS6eMVyQd9q3K88XmUsbbC+nKnYKq8YljprVEGeFVsgY/1LsnzsUhrHPYQB/Xhjb7R+JfgCMpPl3xsm0GkMXpiiOuRmfsc7TaY27tcSlfvdEV+VkAMGo0oZ4Q4uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erkLFCU4; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erkLFCU4"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-87bfe95868cso985734241.2
        for <git@vger.kernel.org>; Wed, 21 May 2025 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747822225; x=1748427025; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JB+1+RXHyBt+yie6RrqV9T1PB0tYW72qS/SCaR3A7Uw=;
        b=erkLFCU4R280DTny3YvsZhuq5RmsZUbVT3S/+ry2SvctyrTBHuLlQxxLpE/fGWnd9f
         PyUQcnL+hECcB5t3IRmCxJjKj+NTI7OGZ08/a4iZa+RPnb8+eoSqJyOU4AfL9HQpUXt6
         enVzb57wuUkpB/UqzoSnC4QVnt3PUdfecSdtVgc+lrqSPA4YLBr3IMpzuaFnyeOIibKl
         1suTPAnC/411grVuce2sHYlnVWzURiMWd3S6WzTUrpsSu1LBYrdB/26HXBA4dLnf03sJ
         vSazOgQeuyp+CiqAh3PlFx9Nauv5poX4QmMUk3ytnd/c3XJ2y1iVPJRai+Z9Ei57J8mz
         7lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822225; x=1748427025;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JB+1+RXHyBt+yie6RrqV9T1PB0tYW72qS/SCaR3A7Uw=;
        b=shqe0zFEc7BGhadfc7cZJDltiWG/w+Y08IUeS/OQ0lpThzCB8vziSHMOGh8E7nDra1
         bxIwWlsn5HH3MLB1FOCasb7ueyW8eqTX8A9klARPT3k+xP02504dQSbz/cD+cLgZ2uzw
         xXrr8bZznRSD0OyH+ne0KMYacTrCdiNGVhpbZOyP5lvB4RiOBX4zFlJr06ISskW0pJkA
         JBCQVzkWqt/HNqclMHXrGqMRiCB0qWvsSQdU87kiNbSpZj676DQFgvj4aTr3JvVtO/Qr
         PUuA81+cFJv9AyFGXCQo4aMGhPEmucoAxL33BLx75jjRyARMM83ownE+6hrw44Z4rp8T
         22OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8Undi9EwbBXmWvnFwhb1aQnN3CfUEwWjIhEQ3QE8PAbVfKhGWkYVXCoOxrc/ADrxsL6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnUXGy1i8HL1yKEOnIfE0KRs7RUDK9ufmqxs1n0H/rQL5VrZTm
	EKai7UZQGDII0bEG4iatgjNvvrUadf1TQfjM8fk6i5DMKQglQf4k7tmSxu0a2VPd6EznfHf94j0
	5Kn35biHWKhfPrCw6nK4tQWgWeoxL9FU=
X-Gm-Gg: ASbGnctBZEQ5rt0JR5jHtkKcweA3eoC/8zvH7u0KBWfkfpO9smp5oPKk3TEdmJZ8y5E
	gZdaJPLqzl0xENLLZHjvHmVzFQIlbpdhb583jMfqBKESGTqqN9aatBLzkVxlfWiO7F8R1/wjgPU
	z35nKMzrlIcxAclZGVtEN6QO9wO74f17edmUSDn700sJ3hJPDL/uKjNclD4uDX6N7A63c=
X-Google-Smtp-Source: AGHT+IHfryLce//bdtmmUC/PkMReaAIBVlEbkypbJpNCjRF1IzKQ1EuZup8p7rIoIg7klJpYeG6xvsVMLJe10PBFtAA=
X-Received: by 2002:a05:6122:a1f:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-52dbceb08d4mr16127658e0c.10.1747822224749; Wed, 21 May 2025
 03:10:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 May 2025 05:10:24 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 May 2025 05:10:24 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqy0uqg4w6.fsf@gitster.g>
References: <xmqqy0uqg4w6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 21 May 2025 05:10:24 -0500
X-Gm-Features: AX0GCFsCokRSQgO4a3-x5SsGOUeoxwzVgiteW5IojJpy3tgW5pqR1u9ywIoBmiU
Message-ID: <CAOLa=ZR-OaLPueyRcXYrN0rKPnVXPPmJ6drsmM4eRs-6yKEgQQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2025, #06; Tue, 20)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000d65bda0635a29270"

--000000000000d65bda0635a29270
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/fetch-push-bulk-ref-update (2025-05-19) 4 commits
>  - receive-pack: use batched reference updates
>  - send-pack: fix memory leak around duplicate refs
>  - fetch: use batched reference updates
>  - refs: add function to translate errors to strings
>
>  "git push" and "git fetch" are taught to update refs in batches to
>  gain performance.
>
>  Will merge to 'next'?
>  source: <20250519-501-update-git-fetch-1-to-use-partial-transactions-v3-0-6cdfd4f769b9@gmail.com>

Incase you missed the cover letter: I would say that while this can be
merged to 'next', we should delay the merge to 'master' for after the
2.50 release since it can be disruptive. Mostly letting it bake for a
longer time before hitting a major release.

That said, I think it should be good to go to 'next', since all reviews
were addressed!

Thanks
Karthik

--000000000000d65bda0635a29270
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c1bb3c7a1fbf8589_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ndHBvNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEFYQy85TFFhcTV0QTNRUHdUNS8zM1cyQytMOENGZQplZ2tPMW94SENU
STFTbnl2NDBlZXQyQkhTUi9IU1JoUUpIS2lQQVAxV2ZhSEROZFB1aVlxTkNOV3psNE9iQ2VECnlJ
WkZZa21kTTNuaDRZQ1BjYWxxR0Z1Zk9ic0kwd25GcDQvR05KaFIyQVdHUkVoMTJONWluTENyNWpF
RUQyVUoKVHkzUkFqODFzSGhNTjBaU2Rpajh6MThZeW1ldGg3RGVPWUM5MWwzZnluZldnbVFxQ3cy
dkhqSEdGYXdsVTVPZwo1WlplNGZWYUswNFZlSndTeFJwZkwrTWREZGs4RGZEOFEwTUt3ZFEyK1Z1
T0E0alczdE9lb2FPdEd3OHhLOVNpClJiV1REV3JHSExyUjllZk1vdFIzWFZodVE2dDJrbmxMWmdV
OXJ3U2NCa3lCSFRpajlKQjkvSm1MWnRKSFdJcFMKUlg4UllMQmhDcDJUNWU4eGNKd1AvaWtoWXdV
R0hCSVhKT09hQXVvVWw2MEN0M2VmRnMwTDB5WmVCUGg4WW5MNgpRd05vLzZCQWtpTktXdlozcTI4
Ym1BZy90N0NxaTZSVFhsd0d0VjNTMVlsZkJTeHkzZW41UGVMMGxXc3V6eHQvCis5YjlOaVdBYlBW
bldHSW5KVDZqZTB4eUJCNUlZallndjU1MDJVWT0KPVFJTWsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d65bda0635a29270--
