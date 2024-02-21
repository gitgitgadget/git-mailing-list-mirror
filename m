Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092E196
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476221; cv=none; b=mDA/QnbQYnWMkJgrE6N9botklj4jUILyUXLyMttPOpbANPgcZvXtMBgqA6UAwJc71UuczDIoOpXCrtlAp0L7elLCwbQ23xzAkjgNhNAO4ip+9tHZ/tVwFBeGhDx7AMLEjGrZKlLsJZgx3Xbm6hIZOSSSdKpHNT3FWVjaFykP9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476221; c=relaxed/simple;
	bh=tz+SsXH6JERQgdwtjAvcC9XuZtmyoeTEb7YBKGbfyNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/ST+2tpwte4fO/c6fSjZUPaKKxRSA2ymoyTGsCQmrEJQQTU1t0Kt9b/JmhcfrFOiskq9/U2ZLD2ol2fozltz66/v6uO00sNznIH1s7Y6ZtQdcfME/hsF9Z3ObiMiaRg8/cnejJgI/k90VManj2dKajr7Rxfa7iUMrHDGQz4Dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmyFf/Vw; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmyFf/Vw"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so827326366b.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 16:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708476218; x=1709081018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecBOglJNNiI0L9j4uOUC15OKVnhlaemV0G+Od63fHMc=;
        b=lmyFf/VwznyKETcGf+SoYfEic8rDAAu2HFenA11bn/W1mEte8pbQKQaA2EkHIkGytL
         hqgLUjcKcHZowIcJKkvGQlw4HTlu27pRkyeSrWDXURHPPZ/W6lwwcZVCEVbo8yY2lb5d
         BMDNwRgVuFsBlXEinLABrj/Dq1mP1yJ7Ij9EWm3OtPyN7XzN02/TPq+EFHaVhJgDxo29
         xCB3Qo7JXLh4fNTFhH1++mBFaKNVGOcJXlv9qw1sUyt2Y0OEdmg6v8J7lWdbVSPFgQfL
         1+j//gRfPGgiewnPvDebJlus8+Mz8v9kyzZWE8UlZVyVzTeC0QRIScs2RzTTP/+fDdZ9
         O2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476218; x=1709081018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ecBOglJNNiI0L9j4uOUC15OKVnhlaemV0G+Od63fHMc=;
        b=qraGms8mmhHfaxIIPZw27J2zRWbj+7BJkAzwa2G26xUXQdGs3el4keoqndcr2rW4ui
         Zlu2GnFBqKqVKOYjKA/7T/kEoRzzllvgmu7QKLZydkQ4YqZlRt5P3HUXX3HdB0bhQ/6W
         BWbeu5QogjJWD7Tn/IfzKFqWsTC49o8Uvixv7q0LVelL+TaAnpw78nVLzvw+kSUrnhVz
         v6++HvjV+oCMX6WM6Kzzetw449ngEQeqtHmfBLHwT1cz/UMG46JUCqbwSgnK6GTcdM7w
         0iLxRFDTkc7PH/FbAzDHm24owqsSXdqAPa8t751TfGxh3vVBdvyK5LaCE5fsGZtKUwoV
         Ay2w==
X-Forwarded-Encrypted: i=1; AJvYcCUfzZuVck1q2QT/gvudSRYGmBRn8DHRhw67AGkACxC7vwxkoLGeNa51FFg7LXHfMdb9lFiwSg4iUbYMbnP8wqrR/ra+
X-Gm-Message-State: AOJu0YxS/i1wckl2+gF50fTnF3oTzNwM903e0Xc5E8GgqktJzkotTj6y
	VtDGv3pq1ATv3GFr4b8dDAtv8qC3/cHNEf5boue2nMHtfLb7tdEAWkroAPsS7CoxB98zSXSyTbk
	FsLn7jbGhhqfCD6VOdKhZCfztT7A=
X-Google-Smtp-Source: AGHT+IGorX44bcjXuyALY6vFY7FIrX57jGI9sEmouAGiAJb7aGpucOqhfm3hfqu3dEI5v77WfVSIqnDDDo1FYMPlzio=
X-Received: by 2002:a17:906:b288:b0:a3e:8f38:cdad with SMTP id
 q8-20020a170906b28800b00a3e8f38cdadmr4468682ejz.70.1708476217926; Tue, 20 Feb
 2024 16:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
 <xmqqv86kx8h0.fsf@gitster.g> <33abb630c1d089e39ff48f04e586b1c0@manjaro.org>
 <xmqqo7cbt8a0.fsf@gitster.g> <9d0022ba5666223af94bbf450909b1ba@manjaro.org>
In-Reply-To: <9d0022ba5666223af94bbf450909b1ba@manjaro.org>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 20 Feb 2024 16:43:26 -0800
Message-ID: <CAPx1GvcGhZLqHVz9=ZW-w+ebP64-8FpPSb_ef7ygXzDDTze2bA@mail.gmail.com>
Subject: Re: [PATCH] documentation: send-email: use camel case consistently
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 8:42=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
> I've never ever seen anyone referring to email headers as "TO", "CC" or
> "BCC".  It's always referred to as "To", "Cc" and "Bcc".

I used some email system (back in the early 1980s) that did that.  It
felt weird even then. I can't remember if it was some CSMail (CSNet)
or MH(Rand Mail Handler) version that did it.

> Thus, "cc" stems from the old age of literal carbon copies ...

That's correct.  However:

> and "bcc" was seemingly coined when email took over.

"Blind Carbon Copies" predated email, but required adding the
notation separately, if it was to be added at all. (I'm just old enough
to remember using carbon copies myself, but not old enough to
know what Standard Office Practice was at that time.)

Whether adding a "bcc" notation was common I don't know;
it seems it would be easier to leave it off if you made, say, one
original and a total of 2 copies, one "blinded".

(As your Wikipedia link notes, there was a practical limit to how
many carbon copies one could make in the first place.)

Chris
