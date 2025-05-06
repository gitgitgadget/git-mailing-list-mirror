Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B07324BCEA
	for <git@vger.kernel.org>; Tue,  6 May 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520813; cv=none; b=TL1vr2o+npwZCtm1Nrum4vspKmkQ3fvv0mbOP2EMT+nrzbGDA0G6TgRxhmIXVC4uvhn47j7v3bTriKQgnBOqGPYZ/0cs5MdbswyBQ3NBfiTiZYXOE/Pyz6s1ey/TXCLvUynRu9T2x2CcwtKXUQzSK+tYEj+nefju25c21ip6AFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520813; c=relaxed/simple;
	bh=uLWOG4/v3fVFSob6IHV54Iu1IWKWFhT4CN3dqb7S5xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqyjGuRJFDusGTfjHtoPKviGg8FRzeqxHpClb33EhnEjFzNmWduG85PSpePneBDT3hhZHdn63Oy62r1DLSEWZmr7ctVPMisSHXK6zcSm2UpGpX7xUfZ2gRFkW3E9dthhHGSUHUHAFUDHHB/Ipk4G+k1gmSejo51iTFLGzTuyHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ay526IRr; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ay526IRr"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb39c45b4eso854284166b.1
        for <git@vger.kernel.org>; Tue, 06 May 2025 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746520810; x=1747125610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLWOG4/v3fVFSob6IHV54Iu1IWKWFhT4CN3dqb7S5xQ=;
        b=Ay526IRrKm46ncwzqd9ZAoyuHb3/YRv1TEOafDhZ6tDHzUkQDmmtZDdhipapv8Txew
         vc9Lh1RA2Hj8gcQq/FzqSTV+Ojo9bzawrFfLzR1SuZhSKq6se+xNRmCLsDcjYWLYtus/
         SLNE8UemcDUV0cuZLAMOdd/+9zkH0nnLNL2xUqnT1ZtWknAnfi/5lxmN3XNCf/JP8y+k
         xaaZgrHQClzAQpzYUouExISwQn44QyVXd2nRNUrL6Jo4o6XkijLlHm3Tdv3wVIXr5cpE
         ALmhk4ZOuWD0PNVAjAT3YyDtz4jLhUuD3Fj8WsIK9L8Q1dSVHyfd2l+nA2L6JzrGI9y+
         IEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746520810; x=1747125610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLWOG4/v3fVFSob6IHV54Iu1IWKWFhT4CN3dqb7S5xQ=;
        b=Bm48SrFkWOGzczZrUY4X97lTiyuSRx0XWq1miWj7No8JWNEtCyLaBw6VAyMDsJUNAf
         KMnf2maFzkEuIcCwDuU41NNQg0p7sY3ebRnBxFc6Vdh7wQYbMf6tk733XtVAIOM16r7J
         z+9e5wUG7wqYFUIRVyDAa3XR933jpWja/0HmC2pydpd7hLtZKS8wOg7OYTM/YPxDQOre
         uCQwRiFqTUlstT85hgHrfJnOqsFrj2as37WGu3lmA1U9DxXmay8DEZvZPdU1CXtGLaJ/
         JJtlv6cIhQevsWkC5XJhNJASXea9DEnFtUAsZHKDTlJ7F1DUFNPHSgWfib0XQ9OxFRm8
         G+0A==
X-Gm-Message-State: AOJu0Yy4uqEoSQCMqtIaqmBp3sxDx+9p5hfLytfLm+YMpYHWtrAhNcxv
	MWaMqXtLA69s4ometGqKTCxiYNa0pYL0Qp7qOMXGx3MuswwhM1G9D+AvYM9ckBnE/gfh8kHTaMY
	pmkGqGBF94zSmcjwmQOTMquqUSOwS67PM
X-Gm-Gg: ASbGncvsti6ToYtwkSdDr0inIKWuyUDRdFcWnLFhfptfDiKNz6iZYPlaOrhdug8evhC
	vASwQikJoUdY5gH0aTA5SdiKtJw7T9EH4bIayZA+j98dUGHjTkw9JYNuuq5eCKlbkKeYt0Mbdmh
	FObxsyJWforuRBEqEf07PInEEsK3iSvbzJlyHX80RC3mF5pwQs9x87jJU=
X-Google-Smtp-Source: AGHT+IEYurxUuEzHCmTqvw/IFjsoNMMzfAtwKPCx/x2NvudspKhti2J/p71rhwZFikPCrsTBtjp6P8XncKtucI7ttAc=
X-Received: by 2002:a17:907:7f88:b0:ace:c3a9:81bb with SMTP id
 a640c23a62f3a-ad17b471cb7mr1445959266b.5.1746520810191; Tue, 06 May 2025
 01:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im> <20250505-pks-maintenance-missing-tasks-v4-6-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-6-141f4df906a1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 10:39:57 +0200
X-Gm-Features: ATxdqUFv6vHidvAEG46aLQAAcrIGiEmzMygsjMIUZjjwusS2wNxEViItUnsbunw
Message-ID: <CAP8UFD0cKmL9e18bNGXOd0taahrK4Xx3CG+Z6BqDovAxbq0sYA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] builtin/gc: move rerere garbage collection into
 separate function
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> Move garbage collection of cached rerere entries into a separate
> function.

Nit: this is also repeating the commit message subject nearly as-is.

> This prepares us for a subsequent commit where we introduce a
> new "rerere-gc" task for git-maintenance(1).

So maybe something like:

"In a subsequent commit we are going to introduce a new "rerere-gc"
task for git-maintenance(1).

To prepare for this, refactor the code that garbage collects cached
rerere entries into a separate function."
