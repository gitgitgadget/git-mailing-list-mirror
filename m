Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707B146D6D
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256664; cv=none; b=UsKbENVpCttGaxdU55Sr0cMEkHq86QOxY++WDfgzpe/xtK2frPWGdEHUqFWany9ioaU5NR8U/FTpNEHMNDjwBlV+2Dl6Jqjr+KQwsduRma1ZKEExWuqCr4wO+3Pdd0xBVGYdfHiLDqe0IOet9EN+kGe8rtF0YObB/9cpWOvsP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256664; c=relaxed/simple;
	bh=wRyZ7rzB4EH7W1PjzP084c4mFme0G1hHQJasGvAts2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZqZvT3+Vfr93gnbkuGqRHOUS7VlrQfVakD+mbYdW9VZm/Wna+XoC8PlQ1jy8Sx4nLUwmbEM1H1QfTRID78sSHKMyvhVm/uoe/G/i9VRJCxMHJ6YohKgpSDjJ1oZFYpBpXmHh1LNmJ2wobc0OWJj3gLgN7YxIV+RLmFS6n41MFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c567b2e81fso3962416d6.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 12:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726256661; x=1726861461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qb7DztRepMhKYV+DS1jV9awQ6EMFDcyFTUtgJnyBILU=;
        b=KABuGzec1jhAsYaZPxxfn2352FHXg1w1HMiqDcmDUi9U9VyYFHLysP/6lcXTzlb58x
         OXJNrD1635nUaIDY2y46/b1kUgMjp+MEM+2ZGsfoxwoLzDsLVzAPUAxM5R4qhhaFGngs
         T8XXf26QPCDTWcFms9U3D7xNEzNvkstcEgxgdPZ9+FOJdlZeNC6n6sVOkeD0maJWH814
         Q7YSk75dHjySPsakJfJpZtKTNmIyCCoNIL+HFo0cpQkgl2jionVfxXodnN8F2WsqkWGK
         vu/7rwssw8Ok2NNuQaIMetD3sJrJj3e3KmcrlkNj22sxWPJGNNTay5xmf2+6db3FbFEJ
         LoaQ==
X-Gm-Message-State: AOJu0YySCSE42n9wgBp88o08M6XSo3NE+ukJtd0LYoz5/TCGD6qsoHIx
	+f4wOQtBz5ZEkHqW/XthXOJUd41STWSoLw14TRTAaf1TPHoKam8z95CaphH6VfZp+7qHyPhUc1A
	BuI06uD+WniTw5C/vzvHNRMf9/GwsaF/F
X-Google-Smtp-Source: AGHT+IHMDrazdkJsNaGoN+uKZdjXwX6Jzn+Okv+PIPruDHl70Y++8kLSJWvXbkuN8ue3/DMFr2NOHfM14MnpHAkFl5U=
X-Received: by 2002:a05:6214:1245:b0:6c3:5c78:ee9e with SMTP id
 6a1803df08f44-6c57357941dmr55126716d6.9.1726256661202; Fri, 13 Sep 2024
 12:44:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmskbwe1a.fsf@gitster.g>
In-Reply-To: <xmqqmskbwe1a.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 13 Sep 2024 15:44:09 -0400
Message-ID: <CAPig+cTj-6HQa4XToOTXZ2gsXKpgqxbUvRLoBLrTZ0VC3tJ6Mg@mail.gmail.com>
Subject: Re: [PATCH] t5512.40 sometimes dies by SIGPIPE
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 3:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> The last test in t5512 we recently added seems to be flaky.
> Running
>
>     $ make && cd t && sh ./t5512-ls-remote.sh --stress
>
> shows that "git ls-remote foo::bar" exited with status 141, which
> means we got a SIGPIPE.  This test piece was introduced by 9e89dcb6
> (builtin/ls-remote: fall back to SHA1 outside of a repo, 2024-08-02)
> and is pretty much independent from all other tests in the script
> (it can even run standalone with everything before it removed).
>
> The transport-helper.c:get_helper() function tries to write to the
> helper.  As we can see the helper script is very short and can exit
> even before it reads anything, when get_helper() tries to give the
> first command, "capabilities", the helper may already be gone.
>
> A trivial fix, presented here, os to make sure that the helper reads

s/os/is/

> the first command it is given, as what it writes later is a response
> to that command.
>
> I however would wonder if the interactions with the helper initiated
> by get_helper() should be done on a non-blocking I/O (we do check
> the return value from our write(2) system calls, do we?).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
