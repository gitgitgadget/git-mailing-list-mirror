Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1B11E0B72
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862675; cv=none; b=RN5biNoT42Z/T82sKr6qItCBZWvvvJQxAHEFf4cwhM0U3OdKSmMTb9LUYQK/N/IeYp5Gc94oq4tbxXEWd78A5wYaMQn1MQxSLWs+Z9kM4UJS6IWZLJE9L0XIuXw/NSgz4SiEAFIyzGEPp0LBz/JsmsEoREXnKcHBIVsxwJ8/LTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862675; c=relaxed/simple;
	bh=3U4guj//Far3YkD6CWCAQK6DES51PHOsDDMegivpqec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXC1l14DTv1Pi8WmCHt+ayAxRhBSrqSEKNzY2ECThXmIKr0vhS1Xk4YiJvhE/g3gDShxyZot4ZfdzNZP8ZeUcKLlau5yXTc3lV8W4ALfvuB2k6R99cjebgVa++6bQG/ywOAAJybIyVu/MYudbhEou87/g5mYXKrvOXKGHvs0aWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=PxDjGRfx; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="PxDjGRfx"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e260b266805so4164335276.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 02:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1727862673; x=1728467473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3U4guj//Far3YkD6CWCAQK6DES51PHOsDDMegivpqec=;
        b=PxDjGRfxvGho6Ezm8+3cgtoft1on+LMEF5q8WhOdRVd/SyEe1sB/5F8na6tBsthP45
         n7HQGScdjGn5suuLG8mfb1paQwIeC9wqu6jH9AQdg+sTjpMQWYLaWdsEOgKNIqh8bN+g
         abG1PlGf9rNrGTfSM6MOj1gsZjqYdcJQlyVZqT+yMhQ2Ig/j1886Wwm+MWTF2yUC2vFd
         RKnTs5/1HTDgKtWGrDXDs8Zwo/LcCLE1KlkLfQpb22IZyi8Mzjq//toCEMhi8nOgkv96
         P69fz2UjvIUnhPFYPFc/7U7QSr5qJvnQVBNw28ru9my88RzLl8+JtM8pc/8GtbW5+3a8
         svvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862673; x=1728467473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3U4guj//Far3YkD6CWCAQK6DES51PHOsDDMegivpqec=;
        b=ljpyBy6zpQ96DQrAJfgbxFozZPk2heqG01qzjocMOMSBmo9Fa7ePlESVWhIsuXxGpw
         lotcjd8kz+tBgncuJ9mUZSJ2AbQsw+D/x+K1ggUoLuvnOtuK5kiLsHnYegfxT0kX+1jO
         IxwbHdOjQ4sA8ORomyQLmnzm/2fFQQI8/BIddpwrq5Z8B0UuKSwrC1nYtIlxZugJQLFV
         T9lPDRAkEUX2TqMFR3zV2tCkYBodKubI+ltgh8V7szZ/LQHdsQBpR4wF/ERzhidHtarq
         Zd4V0ysVqTC1n1y+622Zp4nuo0YWEEpvRYHRY/gUyvpoLLNg8H62SUBJDrjjeXXEoDIr
         bAXg==
X-Gm-Message-State: AOJu0YwidID0aEQKWDTQn+98tmsyajZmgGo+3L22mk8WOGpKMYoTGwZ7
	FRQNS0o/fXw9CH4WPWKoJ6K1ulStYGl7BGu3DVypWN+AJGH8tE+4gcBdc+b6cEmPc4w9bE2Hxqi
	5z7FEQlGn1rV7fHO8VGtIVInlDEj2HBYp3p9u2RlOLEcYoqpUIHzykBt0ARjVuFzUrlnWsmp7sa
	LEOQoPC2bBGv3KdBmgAdkkamMK7EacScIPyO9WbidmPETybJVzvJczYcBpQvrKvTfgUf6INQOtY
	aCSW3oqgmDKRjRb8dCFUyfVDNve5MTlcS6lVyireDxECxx1NnT/gGIAMEN5K1dMqzYUm6ixFtsq
	Jr5jOav25YI=
X-Google-Smtp-Source: AGHT+IE5JuPa3PAxHp6bx2bULPvWaVwKL3DIbpyrCTlmZzZ36NxGKcjdPgeQRTYlG2BCVbvK+M17mlJl9C/7xsNVE7I=
X-Received: by 2002:a05:6902:10c7:b0:e20:2876:8b6a with SMTP id
 3f1490d57ef6-e263843c008mr2418671276.48.1727862672645; Wed, 02 Oct 2024
 02:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930194600.GA1805534@coredump.intra.peff.net>
 <CAOTNsDykrEBGBnQJqmCghWBTgzirxHZQM25ohsCBysp8ZO1qLg@mail.gmail.com> <20241002062539.GA2863841@coredump.intra.peff.net>
In-Reply-To: <20241002062539.GA2863841@coredump.intra.peff.net>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 2 Oct 2024 18:51:01 +0900
Message-ID: <CAOTNsDy-0TMQMP-7kdLkvdCmXLhHbPJYewSrRZu9m3B=TgdFSA@mail.gmail.com>
Subject: Re: fsmonitor deadlock / macOS CI hangs
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 3:25=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> The solution then is to avoid letting any client threads run (or at
> least create cookies) until we know we're listening for fs events.
> Naively I would say we should just have the fs event thread signal us
> that it's ready before we spawn any of the client threads. But it looks
> like we explicitly start those threads first in fsmonitor_run_daemon_1():

I submitted a fix that followed this approach as it is easy to
understand and should not have any unexpected behaviour. Could you
please check it?

https://lore.kernel.org/git/pull.1804.git.1727862424713.gitgitgadget@gmail.=
com/

Koji Nakamaru
