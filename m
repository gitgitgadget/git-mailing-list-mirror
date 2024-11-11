Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74368136E28
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348793; cv=none; b=RX2+j5NrgwZVJM7hnw0nbGs6o/2FMHIhlCSL6IlBR1jrx40IheNstzGMGta8Ahq5i1xXnOayfGSfbiUc2Hq9dKOMOjOiH1xn9yIm68uYO7MFSmE4hhL1z04umAx13AGyRH+Cd7fDHfgcj/FzJT9LEXmbntXMjxqKtaa6jww97Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348793; c=relaxed/simple;
	bh=Cio3+EO5adaekq03x1VSaC+fnn/yp8ZBgnKM3ei/Mvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtzQ2YZ0NL3q2q7kfCffnJb5hGx+PXkmjwjFvs/s7rPPsBV6pokjVx+E5O6E8ohNvIiObWoxYiJhXrVc4EO+rZuGmjBElu4uiQEOuObCY6992oiF+jqwu0wBtO1/J3ZMxvSv7FR/RKvKSewtGqy4CEmg6mVRDIOZe6RNhvHanVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+63yFUs; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+63yFUs"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e66ba398so1072e87.0
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731348789; x=1731953589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjkarCWJFR7lC7nr1F2RmBuVNJi6749/gCgTocMKmgk=;
        b=s+63yFUswxX0vl5/mc6WylLpl6ELP6TrsxCM/Gf7jwaF1jV/0vHOG1u7z+FRV6uKop
         +a7YQvnlCp+7LYsf1wWKCIpAYBQ1dKb+8sMj6xrO6AKHndz/iKgB8IPWPC0k3WCDCZpp
         fuFLil7oDPiUKr2jBY185TWI+lv38zHEJAYRnwX/59CpydRScdaZIrGc+Rls7PZNfSuc
         foWxyT7yc2CD/es6WMCX4s7U4dej4uRiJyjvNRnYYM92c/3FS+u41K+UmZlntMFZ6/+8
         tEAf/Dl4VZbbVeS5uPmRP7dGFMWwgmC40GvCrUWWMsQ/sI6lzlj2Sf2c8S/9n7a5U8QM
         adUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731348789; x=1731953589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjkarCWJFR7lC7nr1F2RmBuVNJi6749/gCgTocMKmgk=;
        b=dn4Zn9TMY0kM03Yn4Mw2PJXRafY1pg+xeIq04++YIi7Zs+DyQL1rhBmGTo2Qouh3S4
         4Tc67XRBxSJCY+OanpS58DvSChIQINdWbAi9FVinsqKCBtqZMQTCQ9PplG7x0t3dnxrW
         18If3Sw1xbrzVmFv8NUZcR+2lnUGgOC4NbmZtErF4dYEMAXf1TDbHrj4SQUyozILDvN/
         1ykSQU1iinA8MQw0auNgj0jD8lAKU0qge89cYmkFJLtrKym/w0GivQ/I8rxGI9nlY63f
         Xb7cdJOJtB9kPJHJu5+IJsAtgCCvvGyed8sUaP7oWeUjiYvbG0K8+vvGvUJTgbK0AHnp
         JD4w==
X-Gm-Message-State: AOJu0YzDpIbVPU8d25uOw5Y4x8sjaKM9Zj9lkG+vOYb/n3YgHcBiOcCd
	0YTzae9MlrGT78XP0HI++vggMOBOZCJ+UCAU49JigI5M7pDKKN2bqTmsRPlvIHDLYjDyOxIkVLG
	f3VG4Gpv1AyYGZAELwAR+jxcXvan3JNf1l/CK
X-Gm-Gg: ASbGncuMR3D5e3G5nI73W+ofZH803TzzDBZ7aTq7iUUNvFSLW/1f9T1dM2d4GGYgInq
	ohVVLF/anUhAVbo9girt02IUZDmf/NGzrdQucoz27xnb4JuGgvw76BbYXk8I=
X-Google-Smtp-Source: AGHT+IEQSek44oSHXcDXUr/oljn2MpXTJLDx7YYvG/JhzXHft1FJ3DM05RgO4zPGRffRKK+z1949Fg4lebNe9Ga9x6M=
X-Received: by 2002:a05:6512:211:b0:53b:5ae5:a9c8 with SMTP id
 2adb3069b0e04-53d8c42f936mr520146e87.7.1731348789266; Mon, 11 Nov 2024
 10:13:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108173112.1240584-1-calvinwan@google.com>
 <20241108173112.1240584-2-calvinwan@google.com> <xmqqv7wub08c.fsf@gitster.g>
In-Reply-To: <xmqqv7wub08c.fsf@gitster.g>
From: Calvin Wan <calvinwan@google.com>
Date: Mon, 11 Nov 2024 10:12:58 -0800
Message-ID: <CAFySSZC_rqGSXLZBQ78zTQ4Mt0+8Cs0OwmfwzKNvyiKoOQRX+g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and unsafe tasks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, emrass@google.com, ps@pks.im, me@ttaylorr.com, 
	stolee@gmail.com, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 1:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> So if the caller wants to eventually run both, it has to spawn this
> program twice, the first time with one option and the second time
> with the other option?  Somehow it feels a bit unsatisfying.  If the
> caller says "I want to run both classes", and if your safe/unsafe
> classification system knows which task belongs to which class and
> the classification system that unsafe ones should be run before safe
> ones (or whatever), wouldn't it be easier to use for the caller to
> be able to say "run both", and let your classification system take
> care of the ordering?

Yes this felt unsatisfactory to me as well for now. The issue is that,
when invoked from maintenance, whether gc is detached or not is
dependent on maintenance being detached or not. That is why in the
commit message of the first patch, I left a "WIP: automatically run gc
unsafe tasks when gc is invoked but not from maintenance". When I turn
this into v1, however, I do intend on making this satisfactory.
