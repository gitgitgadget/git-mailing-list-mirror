Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11364331212
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632139; cv=none; b=AMBWIkGIagGOYWWA0Ch53DFeQezk0RHZYwtHcJ/k8Prund3gwGahx2H/yTvp5RBls/Q1WKtHnaqyL1TA2sTmEVva0dxypqx/N6lsqMlEfKFyyXmzDlW75TMJMl4A2NB+w/xU6mSL+6D5hBFDajRxwjCDqaNqAiQFJcP4N4PIFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632139; c=relaxed/simple;
	bh=7KFlQGly0w3tLnYc8BjPoB448wiG9ot3aLA5EFzQB60=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=c4++CJ5OxDDRrVm4z3FFsTpU3eXs6Q1WriAZDGMBWcxwtCq+75WNzSrBk9ga/peensn26aZ+BTd1+CAW+ZIUZdwMGHdd3TubWAcmRg4tECmBmygETF6XRUJOQpUXPYkBNl9XC2M4kxNy5lk2WJOoEADSM/Mr6vZC2WBC6ZulzW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcRTlSix; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcRTlSix"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a7a94c6d4fso1003265ad.0
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 12:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769632137; x=1770236937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7KFlQGly0w3tLnYc8BjPoB448wiG9ot3aLA5EFzQB60=;
        b=TcRTlSixZCIG2POnGJMZvrfq7CePODu/28W7p1pJlxBAUt1QaLWIWm5eqbf8hL2867
         ZdenvDtniJkGVv2Fif/AMqD5HoanEJ5Z7rWPrmoUkonrFTgGs81J15pHGxJEqQNL5JmQ
         S6Tb5Wa/J8Ajo91C99EooQuuaMGYSCTXBlCQB7uCfjqU5WC2QNOKP/aRtmBxf14lElqE
         7GXdmadmiwAm7RqLvKb3wa5XI9E7XKAyCXmv/6JALrKaIszTfL0OQppMLym1Kpv6pWhc
         lllgb8W+Fu5Y0p73xk9iwt4P48OOKzum8autADlnlgY85SvnV0oRYc4kdbL5XRqILIPC
         5Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769632137; x=1770236937;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KFlQGly0w3tLnYc8BjPoB448wiG9ot3aLA5EFzQB60=;
        b=MExzSYA/EAK7HZrpVwj5X+vxcCsJ44T5KfiPwAxeXTDZJ2KmRUED0TUtPk9BNO6lI/
         KjWyOH2NzwmDUaFJt8h76vQRoo99Zfod61+8DMy0PttPfheBvjsS0nJXjsLq0ddpEB+c
         G/JPwH+bE4LZl0FfYfgZsRbR5QIRXxCcy530liuWnTykRfDgC5lCzLsj6X52gkly/k5e
         awTTH02viwQE3zZzHRfINQIIbm6QtvK933uImQ7ezwrfJjLk60v5N/V9odjMT0y9oOGf
         T3rMK6Ta1M8VczZtFMhjz/Q6biMCs+Lz4dz69tPWFn+epw8NdyLEHVhDO2qlfFqPf/Mq
         BIYA==
X-Gm-Message-State: AOJu0Yy8j2RnlLR32f1uan/SOLg3E/HnC8/bRHb+ARNMDNeN81dNCPN/
	lV8AwXmiF1uhQrEDv8qycFkDMu6Ixpm5PDKYj6rLlaR80jk9WcM6/3ll
X-Gm-Gg: AZuq6aI+qiRPiSczJTh7eCuMBrTMJuq0lssFWgQQuvWPcGfvF1zH1JU4qpm4lDfRyhL
	rLt5VhCVrdsz+6NIUJzcdVFd4vFCfJ+hGNlZIrsHLZjw///YBeUdUOf+jzqwyyYEXCQk/tBdRKn
	WOCmdLqgmwVlsKFR/rtwIZA5t+K7ENm1Guer06wCsL3O80XExy8UMIPZjU6xqMykwDM1ZNFo+Y0
	ruBKucNZvkrKwTZFOYbgc2QKlP+9nLFSVDE/5bJvzwRB6PAJCC4bRoW6orKLPadoXez2ffPaV6g
	pEGgKgdsMTvP0oZ+jQcW0vhNk1HGDFkH+DuLIiz08ZixPbA1tzaMGTnw8SFgI5c70CXJKXXCVcG
	hlYdwyJzhVgj+YdtZXQqlYMUOkivfMqV5eZddb/nM3YPMwZPA1Q2p2vr+vzmxtfvkqEXXdypEDa
	dFpraRTkBEoIeZVxGWLRdMfl7W62DbDdXrTlKZKUolKEE=
X-Received: by 2002:a17:903:98f:b0:2a7:90f2:2dea with SMTP id d9443c01a7336-2a870ddf241mr60029595ad.28.1769632137310;
        Wed, 28 Jan 2026 12:28:57 -0800 (PST)
Received: from ehlo.thunderbird.net ([2401:4900:ca8e:73eb:55c:ffe4:2790:e300])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4110sm29266345ad.84.2026.01.28.12.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 12:28:56 -0800 (PST)
Date: Thu, 29 Jan 2026 01:58:52 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
CC: git <git@vger.kernel.org>, karthik nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Meet Soni <meetsoni3017@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 Bello Olamide <belkid98@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: Git project and GSoC 2026
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com> <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CAP8UFD0kEATc6sU4r2pVq9k2X737Tk+_VXrxXx8K=M6=ciL=vQ@mail.gmail.com>
Message-ID: <BAD29E01-C358-456F-8E31-058AC0AED0C8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,


On 22 January 2026 1:03:26 pm IST, Christian Couder <christian=2Ecouder@gm=
ail=2Ecom> wrote:
>>
>> Wonderful to see that we already have 5 potential mentors! Keep them co=
ming! Also, it would be nice to hear potential idea suggestions too=2E The =
more the merrier :-)
>
>Yeah, project idea suggestions are very welcome=2E

Just a gentle nudge for the project ideas=2E The deadline to apply for GSo=
C is Feb 3 18:00 UTC=2E We need the ideas page ready a couple of days befor=
e it at least=2E

Feel free to chime in to suggest ideas that would be achievable by someone=
 new-ish to the community=2E If you're doubtful whether an idea would be re=
levant for GSoC, feel free to share the same and we can discuss it=2E

The same goes for micro project suggestions=2E Feel free to share new ones=
 that could be added to the following microprojects page:

<https://git=2Egithub=2Eio/SoC-2025-Microprojects/>

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
