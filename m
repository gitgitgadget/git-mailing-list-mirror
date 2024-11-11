Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63670450EE
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350407; cv=none; b=g9NTHGujznIgfqpH6LJaBqUfJFS1r7nNknaeL4aUzEEj3fJskZ4AxXR709tOGHztU5OL2eKRuLpwfyyxLGFdpGqPbb+y+fEklVlHGBrh8xE3qTpD6LIIlyyA6DFzK9pqRUf77qf3Na7myRFYHTNoHSSTBqoNh2pSwGA/tqr5pL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350407; c=relaxed/simple;
	bh=OUM1/T6HjT4Of8VGBABupRLSL1qx5ZocIuzFqpoTNSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa5UlWOc2vBGAwfH2cXDKD5/GMC5uLsYeDIXOQAgz/MCpBm8wLQB6U+PpkG1QwePqZRync9fQXIU2GlB8jWxmdOxvUtwXwSqMofSPLWQ6+tyZGeMT3pPJJkVUJN1ss8UJdJjsm1fizPuJZSQWt721uHVLZMLJc6w52hohuagcLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4jDaqnv; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4jDaqnv"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e681ba70so2376e87.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731350404; x=1731955204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUM1/T6HjT4Of8VGBABupRLSL1qx5ZocIuzFqpoTNSI=;
        b=y4jDaqnv/TUUzZ+Du5iVLE/zQd4Zr6zOjk74ZEsGkf2Cecsb2oN7F7NtAHui9AQFlB
         5hmjNzXP6aVaJCl+EbF/e3fnoHKwx84TvAw7E91ssn4Jhs+28V6lJPwZLXlkeea06UeS
         ymmhvoaBj9O1xnL95rDdXhfpMJ73Vu/uZQdPfQlwJ8xCpbuw0Qn1OuLtvpfTNJ7IhZOb
         G/UAJShoU1gNpGPOHqEgGAt5mKAhyWeZSFr3/uFZG7rEJM4ZOpd0/ZHu85gyvhfwZnX3
         DtkuRMagm+P6M4EmYlHlVd9Xp8K65AJPI54TfdJd1DnQnIZxwy7jLdIPruKF8i1tfIRo
         VJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350404; x=1731955204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUM1/T6HjT4Of8VGBABupRLSL1qx5ZocIuzFqpoTNSI=;
        b=vSpQkAOtCKy9RkqY/6oxZAJu1ookihxKBq2tzIHK6s5t1YI+VREAjgJTuLSmlLnWNC
         rrlP+OJBjNnr3FnTcqUE+xpmxKfmP1k3lmW6JU8anUSwaG211bjuso0ktHsu8xwPxkrk
         YLAzyBMp7XwKFqwJNSnB+DdGV4xUz2uk6/NMoX4h7aAvY2N0ODLPJqhSx99qJr8MaDYP
         CDm1hHxD/HhyMZCEeJW3wBpQS+Iy2xuoTcHW0Q9ZP0/hZELTKlRKekTF9wfk3KzOjdYY
         Mx/hPIhqg6CPCcONXMpwVNOtkx0Ie3zFps2nrOJNE8AOHJgCuPt27t5SZKQ+TerFHQzg
         8Nxw==
X-Gm-Message-State: AOJu0YwVGeIXrpDefJSNnVDkgUQnamzgbTWs2/Bscs5f202zxndBJSQT
	KT4HuA8009Og0Pns5H9rhUEDJ8MO7AQ924W6jgphs8zrcFtINJl5qC8SqiIcVxIm4wVFawrMCwm
	LoJidCogLhh/+mji5iKdRaZjBkF7FhJi0v+hI
X-Gm-Gg: ASbGncvAnKtVKOcXU2JqXpszn/lmYzlTmOiZiXWFFqddJMqx0tJMN/btN2MlRiOE221
	9gfZ4TSUhsenBL7Zq6r5fvLyyxlLd+XiUT+FUW2/JzEThhnma+5wbHJgZoA==
X-Google-Smtp-Source: AGHT+IH4vgjmRFuYfhNlindbRmZ9Z7yRUWdsvaXRtDxI7FPUXbqSiVDrZVd48zm2UcLt4KXLI1gp9M6GwA5dYZTiQoU=
X-Received: by 2002:a19:ee1a:0:b0:530:ae18:810e with SMTP id
 2adb3069b0e04-53d8c42f8b3mr559060e87.5.1731350404362; Mon, 11 Nov 2024
 10:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108173112.1240584-1-calvinwan@google.com> <xmqqzfm6fk6z.fsf@gitster.g>
In-Reply-To: <xmqqzfm6fk6z.fsf@gitster.g>
From: Calvin Wan <calvinwan@google.com>
Date: Mon, 11 Nov 2024 10:39:53 -0800
Message-ID: <CAFySSZCirPpRgJC_zkfNoZZB105V=tu2R4FG43aqND=oDu2xtQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] maintenance: separate parallelism safe and unsafe tasks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, emrass@google.com, ps@pks.im, me@ttaylorr.com, 
	stolee@gmail.com, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 8:50=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > However, this is not the case as discovered earlier[1] -- certain
> > maintenance and gc tasks are not safe to run in parallel with other
> > commands. The consequences of such are that scripts with commands that
> > trigger maintenance/gc can race and crash.
> >
> > Users can also run into
> > unexpected errors from porcelain commands that touch common files such
> > as HEAD.lock, unaware that a background maintenance/gc task is the one
> > holding the lock.
>
> The symptom looks more like a controlled refusal of execution than a
> crash.

Correct, I also do think some responsibility should be on the scripts
to be able to both handle the "controlled refusal of execution" as
well as checking to see if those lock files exist first to avoid such
errors.
