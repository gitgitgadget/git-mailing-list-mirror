Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843752F25EB
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 23:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741143; cv=none; b=PeZYt+BQWIyPP91LLQaiMiTFKuzf+n9f/w0enpHrdXyd3wHM1jt0CZhc8C7C2PVcUVzYRGzFbEpL0te3r6WoJoTi696pZRNA4XX0Ql5T/VHr/3XwnveeSNXSvkjH/xmoqA33dUzqgp7lTGz1tMYY1sZrOSFhXhZBRMXF5MNrkKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741143; c=relaxed/simple;
	bh=kaeSfKYi1ZjQMCViAcpPH8w/JOiBzbdJoNa51oJfeAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC87TUuTd0tEok59+pnB2dtCYFD1RUaMt4HPdBTIKLvdoX5rexsyFb5RO0zT+Fej3F1Z3YbNTqvBP6GHQHbnSKK4RG7Q3af3W6gMgTblEC/Nqg1KlXFootopieOF6RyDCmJNBfg0yfcOirqDFTTJcD10sRxLtSAN6eEmUeyXJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZqS8p4i; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZqS8p4i"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f0c93ecf42so136061fac.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 15:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767741140; x=1768345940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaeSfKYi1ZjQMCViAcpPH8w/JOiBzbdJoNa51oJfeAY=;
        b=VZqS8p4irWyijc7eRfOLOxFGGb1wNQHixmI4aUbjRiyQN3ftjhTuQdaP6mVmMaimbY
         wY1WyUjXnW4OwuJVRK8YrOSFY5+rgz86B/yv3ggKxgUbsAYzM5z8o6DLES21dDLAhd62
         bSBIpcShlZxHssNLGJPl9XvP2yGvDAglcPmMvCuaY4stkh1B4dkouBbHgR9AajLqeChU
         7brJp7NR+7JjpDfrrfwOZC4O9qTw6tvMhBC3wtl9eKKJLsOCyoceydjFb1MtMwTPnjrj
         xUA8/YaxxeWdVPMuWMERhdqyq5a75EyJh3mSAuEtcD4u+SXqjrw3nZjWf49D+AkwIkrG
         iX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767741140; x=1768345940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaeSfKYi1ZjQMCViAcpPH8w/JOiBzbdJoNa51oJfeAY=;
        b=RczoYOXe+94QnsEBeq94CckNWtwT9cCYg/RbdvbJmsDBUjIvKaFvtO4TkuELUA8cae
         BPacH5DUztzC49Jux/lr0JF4KtF0g9w/ye+OOgsnq/8LZrIcz+HXWHMSv6jnh6ueaemL
         aMoDD0WBhdjCnewdUmU2z6gLLCBcwHVZu9X3i/l4VhTUK6nTF6EAwYnWuJxdqSptR3iL
         p67D/zIoXPeG95muZxZMCne4uhf0QfnYA4Z/3o4ugbEcJETDW5X/SV1v45bQQS/wSGyO
         EKOMSdJZbMgGkuQPyGgftcZjcugf041HuuTE6+wc8S/9VzcJ+GLpDrTpuiJRkFwO5kL8
         mtIw==
X-Gm-Message-State: AOJu0YxGJu0NWxxnHZeNiiR3C2eMVXKH0mUS08JU3czepyODz7ppCXUk
	jS1fxuPynGjxJBBDHrZhtekOMBcrMTEm0YdEzhQTGsBaoWNU6VqzWBi0rsU2/WNX2Y5hLPnORtT
	qwrbzqRaDGA0zT+0E+6GOGWYC4w4Y+7c=
X-Gm-Gg: AY/fxX6hpdwfrQ3oa/9JvxqUOHUyFzjh3BjXxIFifIOZUbtSy4ZH30MVBTacauc0Z+m
	aPq3XPVaxUDC9gArOJWWFttfw/BpzJjuLMIMew9YD2/u91XmkMijh7VbkELpZXa4xV3LDQC0VmS
	32t59jiTb6afS+LJk0QbQRuEj2ycD2tLpOyGn2vXMgamd2kIa/P/ZOEMXOKWcOK53D+DvCsCtiV
	qsp3H3hcVMoCnh8NGU/j4yQeZU9hLUPkVSTn/qMyKle5uAfn9o6o8C2v3vsWXfY19Oyf3JVhEn6
	nZ+EFDXCc5C9DQuUEr8nr7VpvegW
X-Google-Smtp-Source: AGHT+IHu9biNclnrtOsC+FNDul4A8KsMp0g+t1pOr8nsSFGqWDDNkVPDgaDCrF1kKOOjhT7zWf2W4zZymff5hS6rVSs=
X-Received: by 2002:a05:6820:e009:b0:65e:d1ab:cbf with SMTP id
 006d021491bc7-65f482c2668mr2334690eaf.33.1767741140302; Tue, 06 Jan 2026
 15:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <V2_CV_replay_die_descr.17b@msgid.xyz> <V3_CV_replay_die_descr.1a4@msgid.xyz>
In-Reply-To: <V3_CV_replay_die_descr.1a4@msgid.xyz>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 6 Jan 2026 15:12:09 -0800
X-Gm-Features: AQt7F2qEwfKaSxO-X3xojTfQrS7FQGrQqmE9lQfZEDbYTCkR_YT7QCVnl_SZQVo
Message-ID: <CABPp-BGFNyKkpcWWksqvNqyXspMqfywbYyyhuSUaL41YHNHoNg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] replay: die descriptively when invalid commit-ish
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 11:53=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
[...]
> =C2=A7 Changes in v3
>
> Apply review feedback from Elijah. See patches for details.
>
> =E2=80=A2 Patch 1: More terse function name
> =E2=80=A2 Patch 2: Improve commit message
> =E2=80=A2 Patch 3: Improve commit message: fix outdated function name men=
tion
> =E2=80=A2 Patch 4: [new] Apply code comment/error message tweaks

This round looks good to me; thanks!
