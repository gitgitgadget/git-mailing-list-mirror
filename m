Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F0221701
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587909; cv=none; b=AAJyXLtQtFbqoKu/9fC01zpzU+UgVQNzu0OCNI3X/xB0Q+D0s8q1t7MW8dI33V99u8fUIZE94eAFZhvdtG/yNey14QdTs2/nDsP3JJ8+yhtK6O+q6WiKcyxQBl5ZgNjnggLupv1Y2hchQQb/Is1MAHHjAh64uSCGwQNYfi9Dx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587909; c=relaxed/simple;
	bh=NUJCieU83Aqe3lJta7IBhx6P+xKrbMaNrTy0UCodeCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwjyXRRgP/1EIWyyrOBEm/b+Nazi4hFN4h/HtB1Fwm+gWlyQLTAKz2RcRhblqOppNdq7zCAjiNbCWYb7ZPaRMzX2WOPHSrRzDSK7X7aE6sLQnlA4YoY0EjaNrn67T8m53cDKnQ3R3Wv4Jg0CKXRrz9Nc13InbseFdAR0ON2piyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3sOFdez; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3sOFdez"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f44353649aso120543a91.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 08:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740587907; x=1741192707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8yk4sojixDreAFuLA9isFZXqeeqKuMuTeVb7jORHJg=;
        b=Y3sOFdezh1cic7GWJDqDPxrUIo2zIWLLE8dVrPOJXn6ffyf4pqn3JqM6BvsE+Y915J
         7r2ruMJzTJ8xQFxflSXX8UpWqyt7G4JY3m6S4jbwuxCSffcHvpHSYv57mW12BW3BXRY3
         CH8bAON4TsF7BtxU8wpzJqxNx1wGtOvmjy9rn9Q/Rdj9pXGoB5YAtAyrHhzHZ8HskxBK
         refqpitJ74mK3RooW4ATOqsN72dtK3CePISMenZYnuXcC8+70FasKCY3OytF5EXvurQW
         LxuraPN7gscQNAD4IiRACVI9eFNZyib9AixZ4kj1kHlVWA2sSKpbojcjeYvni3z+e+vP
         TCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740587907; x=1741192707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8yk4sojixDreAFuLA9isFZXqeeqKuMuTeVb7jORHJg=;
        b=Ia852vCqhfhT31LYJ6pZaG2T2zM1VMQTmpMkiDL2T8YUctRGP7OymKhHBaqFAdMso9
         urHlhGpIr+zidPPVmf+b/tzaIibKbN9FHmMw3x+dCWpcSYriuDFtzEWGFV3oXQ5fiC9A
         TBoLP1n1kbB/EBsRLozBvbuE2ilLY4o35YryKEqLWRRhz3DEuZhjnAy5FmO1iuLmaiqy
         8TXzExvJEZxZpcCcNI+pa7SoBx5Y2HSN5+ftOaU1c5nNyFPot6IKn8haWWs8i+lvK1Ga
         TNzbyEfMv1m4UoAAG8bXJcQYQZsJzUX+eJpb29bNUGft7mF8chwecEHYl1Z/g13KqMZf
         j0zw==
X-Forwarded-Encrypted: i=1; AJvYcCVdGbZZEmHlyTRsyCk78uwJ9LZTWyx1Ye/2PRJph4LscuQZRWdjX6RaHb36cpRcCdS7l8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcIDsUTk/aNFLixTSF/kbJOSN1Vtus4TxwHYZR/L/q/2yr3BDi
	gMZeL2sWSuvJiiCK0z69F7jeX6gDVNBpL9cWJPIv4CKgI0eWDR47LnEyKDJbfFJ59pGNvJila2v
	s7rsLvsY8jCIwtiFZdzXmNW7hWjXGIg+WNGGm
X-Gm-Gg: ASbGncv3WdT6di/MQu6cZbcuO9K2amnAcQuCk2IzEZ5K6r2CG5i8+RPCWL3xfZpRS+N
	R1+V+zKiEd//dgI2uPT1a/F4vK7D0FF+UlUU7GeXET8gkRTRdsRFx1kiDRzVIe0pQhusGo2trW5
	O3bmtszyvyrWb8JU01w5jmhpCgoB+pzHloOMbOdQ==
X-Google-Smtp-Source: AGHT+IHZ/hTw1THO/IctXv2lBTlJo0yV2OdNCaCxbXaDdgvnUlozAqpZMQ2jrqMTA5q7QT3da8XUo0cEaqmhy84mwRY=
X-Received: by 2002:a17:90b:5106:b0:2fa:a58a:4c5f with SMTP id
 98e67ed59e1d1-2fce7b1f6a4mr35745759a91.29.1740587907371; Wed, 26 Feb 2025
 08:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
 <20250226073822.GA21138@coredump.intra.peff.net> <20250226080902.GA29996@coredump.intra.peff.net>
In-Reply-To: <20250226080902.GA29996@coredump.intra.peff.net>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 26 Feb 2025 08:38:15 -0800
X-Gm-Features: AQ5f1JpBv4GNDKWacG5Jbo2i9oSCYD_akxDMcssJwCvYAx_ZOXgAHByG_gEv-L8
Message-ID: <CAO_smVjC=CWeAEjZjr9PPuBTkyYus59o_J9hfnpJCB-AsBE0HA@mail.gmail.com>
Subject: Re: \b character escapes in CLI usage
To: Jeff King <peff@peff.net>
Cc: Yaakov Smith <Yaakov.Smith@wisetechglobal.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:09=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Wed, Feb 26, 2025 at 02:38:23AM -0500, Jeff King wrote:
>
> > I wonder if we should consider adding "U" to the default $LESS variable
> > we set.
>
> Having tried this for 5 minutes, the answer is a resounding "no". It
> also treats tabs as control characters, making source code diffs rather
> ugly. ;)
>
> In modern versions of less you can get around it with:
>
>   LESS=3D"-U --proc-tab"
>
> or:
>
>   LESS=3D"--PROC-BACKSPACE"
>
> but those are new in less 632, from the last year or two. So I don't
> think we can rely on it in our default variable, but people with recent
> versions of less should consider setting it.

From another issue (https://github.com/gwsw/less/issues/557) I learned
you can do this:

LESSKEY_CONTENT=3D'#env;#version>=3D632 LESS=3D${LESS} --PROC-BACKSPACE'

I haven't tested it yet, but that might be a decent solution? I don't
know how composable those are; e.g. if you wanted both
--PROC-BACKSPACE on >=3D632 and --no-poll on >=3D670, I'm *assuming* you
can do that, but I don't know what the syntax looks like.

>
> Looks like it was added for exactly this case:
>
>   https://github.com/gwsw/less/issues/335
>
> -Peff
>
