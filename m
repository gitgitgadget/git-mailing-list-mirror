Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9586218EAB
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763210523; cv=none; b=n+EReD3Jb1uj/LOkLKK83gqVR7o/BqxlV5z89a94fc4UF+rq/wq4Ep/ewH2AfGD/zmKrwsLddnqLsgLrzATOedEpfofWzdx2PdnKcERCvAIPySGBVchJYWNU5yE6xu2Ji7xkgarfPjF7++DVaiyzlotZ9Ihz3/sqJZVSPyQ6FyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763210523; c=relaxed/simple;
	bh=SYYs2RZ6JoK3U/d2nE3ML1rTLrBU6d6ymV8ahIR42So=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyoMby6d/jB/tQKDl/aFibnAh5PDQ+vdvSJ/p9qGXES4Rd/AlWFRIRzlf7Y1aUoCQwYSaWpTigtW5bktDjcGMFzmjHlf9XjeK1oF1R7rvhDooT6NAnHyc/5SiHEbry9jdKaCsdyFw5bkY4m6fN0EAAAXsdVjKfvQbRj32En53Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si0aKZHM; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si0aKZHM"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640f2c9ccbdso2529278d50.1
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763210520; x=1763815320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YOZxHDtEcOnJqN6JHItzcyVuL9OjoQkGqJuro1fBR0=;
        b=Si0aKZHM9jCFRvbzGJOe2eJ0ODpFuXG2CyamoeIDKygLtDzlBxM/B2BofMUu7LKloY
         xeq/T8K8Tj/2fhUiadn2smeHXzypueZNQEZ7cvRGM7Obxqel6zsWMb+04kjjDL94Insy
         adbO+72nOQ1yjNWzmAlG3QsVPkK33QO/kJDRwc7a+BVov9bKGDOUb5BVtFpJ127bsaJ8
         FWclG7RbwSVwvKLboI9z6Duuca81KNCEfhbfxzUVxKSpQbbwjaNzdz/GQwIu0rhZoMjQ
         Gwk+QGB3WrhYOfmUIVPc4Hk5GEbEYhg1TVM1fu9eq6DfsvvhbnfdAOshpWku5MU2/Lkj
         636Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763210520; x=1763815320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7YOZxHDtEcOnJqN6JHItzcyVuL9OjoQkGqJuro1fBR0=;
        b=JIRjvRlDWJ+VU3oDXRZzximckrPfDntZguJO4cv4bzce5Gh3K/+BLh6P+YZmRoxMqk
         JwMcwr1BzLNvL+s0K5DvXvxx5KefOp8Jx1kckLP+23KrslPwTosKYkxVdt/WORnDYf7I
         7fE/XQi53BJpmGAIo2/i1DZKkG5cEuQA5DuW+LXPdxNHZqS+B1nfRFweCEly9KnhsXi+
         MPlZCx6vvjPknOt1xBZ30DMMgtreYHNBu2jtzoY3pJ7QML0W6MDB6F3Gwt5Cus4CquHx
         UKAdgt0B2FHY3v9+3pLPrzLHqAIq0FS/bUAiurkp4FbbWCNeNodBfqCsS4R6gjb/7x+T
         9Qpw==
X-Forwarded-Encrypted: i=1; AJvYcCUDqnlRn5nOLoNdT+IhkuVzYpQGshPCQsKWW9ZSnx3/tS7FosFRibFDlGw5uAFPz1cVP6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvwK1xIHoVfPqQWQysLgn2GlossIMLn8WGEfxtyCmkbXeZP3f
	IxkTGLkMQ+p49DL7MIypxdXfeyouT4Qn9eHIWads+NY4uoS8m8q2Iqda2xZDt58vJuHTUubeKlV
	yUTKFQd3V7p1+So98b7OtmbKTzGOSRHM=
X-Gm-Gg: ASbGnctFuGp74XUXNkr20o/kHcAYjzA7PBIh1ScpciWsQOsiykn3TS386dBVfU/T3UP
	GPQcxgCDG8gKxOV0rzx8+Wi601GELvDQp9mvmUt8MuH2Q+455UPLcacqnGqP86j31DeOq1Yjoz4
	P9Z6sbcd+xDLDBA//OhQ+3DCpWRVICl3b1tgGBamijMOeF/DAw2jC+YDfoj7GEgZsiaGqW/hz8E
	5ai/+Zk/EHZxLdIFPQsVA87iPKHAcK2dT/efBae4kw89FqUwP5GdCVzwpS7mg==
X-Google-Smtp-Source: AGHT+IErOxX7gE27Tdc7DbJ1sOFkLM+J4s/oMYHQAuuWNHvX/TRnYCR9plAtfVTsC00EMI5NGV/UUGgAufYqk2yNyBI=
X-Received: by 2002:a53:d007:0:b0:641:f5bc:68cc with SMTP id
 956f58d0204a3-641f5bc6e2fmr1596286d50.73.1763210520445; Sat, 15 Nov 2025
 04:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763098804.git.worldhello.net@gmail.com>
 <a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
 <wgxzx47nsro3h6ju3t2aatrygkr5g7i2dbl26fj53qh4f7jdxw@d233r7jflrke>
In-Reply-To: <wgxzx47nsro3h6ju3t2aatrygkr5g7i2dbl26fj53qh4f7jdxw@d233r7jflrke>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Sat, 15 Nov 2025 20:41:49 +0800
X-Gm-Features: AWmQ_bnJ0QF8Ji8TBl-JgMGur0iHFxwDZlMBHUn3wNwwCdsDmrVjNk44JFdcHwk
Message-ID: <CANYiYbFjShuKULNeyQBKmAb07gwEt5PZp8S_62v9E=eVWGr9-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8 characters
To: Justin Tobler <jltobler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 1:50=E2=80=AFAM Justin Tobler <jltobler@gmail.com> =
wrote:
> Ok, using strbuf_utf8_align() compensates the line width when using
> multi-byte UTF-8 characters to ensure the correct length. Looks good.
>
> > +     strbuf_reset(&buf);
>
> Do we need to reset the buffer here? In the following loop we reset it
> at the start of each iteration.

Will remove this line in next reroll.

--
Jiang Xin
