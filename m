Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28C191F95
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 17:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949254; cv=none; b=NxW+QzWI0zojNoRVYSbVu3PF5sPLjmlJvUqCBU/44uLiqR9MrI1jP72jy12KPfk5Tpjzd8jVlc0n8KinMRmZd1aq73WDiIxJq2kpmwLBjxEgS9UH5fO8Aa7MIcWHcll5idDC7EzgOmXtOGlBoXwvV+MK5LLcPRCHcZhgyGEFS6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949254; c=relaxed/simple;
	bh=NumOYRMQ9Uw/1jb9eVM31y8pIUth0bNAIu3EcRauZmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3EuuNZWAu9QrN++8/bquHN7d9h4yqPsSH6cq+ZbkVB3OdVmzvH1LaacvnSKF+NY6keer3sv3qiwzWWJruLxzMezdi535k5MW01vDm+A1tMQcWLb41F5rIXDHyN7rHt+3dzs6AYgfYpmsjP5C3CGPtOzWtXSnCzFED9DDUpB1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGvOo1KC; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGvOo1KC"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-866d97710faso1114731241.3
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738949251; x=1739554051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PF48L8LOFkJwhTnkMOSLnwmQWSPAVvuIVrWGtMAEOdg=;
        b=YGvOo1KCnqpSm1N5DoTK2Nh2rzbZuoUi3kLPnJ6nK106zNXhXnTX+qvx48AlxHEmuQ
         oObO3RmN0xlAEJIzJ51HNtrM8oU2SPEhEfpOr/VoeCHtzBoFr6NlnCAJoVa0pukKWpho
         zoWfRrJM6dkLg1wbof1SZS4p7c+TTRyL6VXFSEaM0Gg23T2O4sifDBCIziDBwe+u4num
         598XRDUvQbCQF9KCvhc/Uc1zOKIheWze4Q/1+ix7u9fwmrSrx+ksp3Mc4wSgLhoHKyC1
         9SerpspukoIMNwA6dYA9+OXJyamKzgXyb7ZY3+21uRufCl41pXKqSmllJWLxFvDokAus
         jz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949251; x=1739554051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PF48L8LOFkJwhTnkMOSLnwmQWSPAVvuIVrWGtMAEOdg=;
        b=uFEv8s6YZ2ttVUx0PncgQfnA3LWeSy59Z6oMa0EUkGQtEULKKZuiEfAvAsY0BWg0Uq
         pOOytJHVL5aFWc+2MPBmZUORs6iodf4nbEKwsvVRP2fOJ0B877bVgbld8G76J+3fRfsq
         BC5qSMii+RD72ZfRTy45thpWmq7qF5r/NEwzTf18YNkRIEApIae6QQnKs78piDI10kE9
         +2/HcQ+inV9HW7/wVrrl14Dw5emi/gQexzBRJ1LXmuRf5zTrCkLQFe1695oQFUEEld66
         Uz9WqNVvDkZgnp3mcXpb3p6cqyA8qjj/5CoA7LwtkXoHjpEA3uxSqqkR0psNZueDVnBV
         ffzg==
X-Gm-Message-State: AOJu0YzMlHmSXCKJ6zPCs614spkdrxXuR30fWWVZYMF1Ybw6Bl5bC+dq
	CeouObdC5BzmgYNO6ynrCkx29MshkrIivN33zmHQCppbaVdTHdopOAHevLiV3m9QoJagKsynr/I
	SmWwQT/rmewqwzUHa/G3jbbo4BjI=
X-Gm-Gg: ASbGncuDeR6XAY2iSEUtNAf9mbkiCem2IQtUqm8THFrShrlxkosJFFrGmY/gRu0mcM3
	N26DHLEImSmM6tm/ML+AzAiAmBzcYd3+b2Zb2TPttrzuV7NZh1U0n8zWlFBmzT/Bfsfx9XTGD
X-Google-Smtp-Source: AGHT+IEf3ot1LQqEzDVCMEWLjv5oWLI/5Uzv6+8f7Iq8ih0Khq2ESMbTYjunu7ZWCizxbNkSM3ZSxSw/dllUbSoGPfQ=
X-Received: by 2002:a05:6102:9d4:b0:4b6:20a5:8a13 with SMTP id
 ada2fe7eead31-4ba85e4338emr3403863137.13.1738949251411; Fri, 07 Feb 2025
 09:27:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124122217.250925-7-usmanakinyemi202@gmail.com>
 <20250205185246.111447-1-usmanakinyemi202@gmail.com> <20250205185246.111447-7-usmanakinyemi202@gmail.com>
 <xmqqy0ykkqqc.fsf@gitster.g> <CAPSxiM9Yejt+Cgu_ekuQwhduf=JEmS1s+T+nc--SvNQqkQE82g@mail.gmail.com>
 <xmqqo6zfjec5.fsf@gitster.g>
In-Reply-To: <xmqqo6zfjec5.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 7 Feb 2025 22:57:19 +0530
X-Gm-Features: AWEUYZmL4QqODSnihRqUoYhL-l6f7qjsE-A0ewI8HCMglLRhYRo-lD6xUrU8W2c
Message-ID: <CAPSxiM_y6gUQVNt8kZXfrn2dxpM7RNNg5LZz0dZy+9nYy=hcgg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] agent: advertise OS name via agent capability
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Johannes.Schindelin@gmx.de, johncai86@gmail.com, me@ttaylorr.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im, rsbecker@nexbridge.com, 
	sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 8:43=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> >> I obviously agree with the benefits enumerated in the above
> >> paragraph.  The simpler, the better.
> >>
> >> I however wonder ...
> >>
> >> > Add the `transfer.advertiseOSInfo` config option to address privacy
> >> > concerns. It defaults to `true` and can be changed to `false`.
> >>
> >> ... if this configuration knob is at the right granularity.
> >
> > The conclusion now is that we should not add any config option since
> > the GIT_USER_AGENT could actually allow the user to hide whatever
> > info they do not want to share ?
>
> I wouldn't call that a conclusion (as you and I are the only people
> who expressed their opinion on this so far), but that is my take on
> it---tweaking only the (os) part in the agent string with a config
> smells like the tweakability is at a wrong level.
>
Hi Junio,

I was actually thinking about this inside the bathroom when it
occurred to me that,
according to the current implementation, GIT_USER_AGENT will not allow the =
user
to specify an empty string at all. It is either you specify some value
or we decide for
you. I think we can add the config at a level that can disable the
agent capability completely
instead of only tweaking the (os) part.

With this, the user can disable the agent  capability completely,
share whatever string they want using the GIT_USER_AGENT.

What do you think ?

Thanks.
