Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BF2BE0FC
	for <git@vger.kernel.org>; Tue, 13 May 2025 15:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150160; cv=none; b=nJ9vOBl98ChFcQ21zTRqhFy9WpiZ86xQvnFdxJlijV9L1Sby3s3aHCcNAv8Q3v6+u83X6uQ5RBTw5L42CgwJwBRw04Meu13Ocq/epE/jxPlUGRMuGHSawhyIDFiE07RgKbsvmj37QxKthV33A+tc9r21rwCEaEZ2HnibvTc3Z40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150160; c=relaxed/simple;
	bh=xm8gj6ZEo70Wwzp+Vn9BnXf4RGcvxy1tFNgS/xtBRkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJZX/M24OyLPbU7JgkWznngViLdZujceZEs+gfTkqtZoMnZC9GmFlTBAtjzDlwGwr+M4PWBKjK+wvELsuJ64spsJsALdwvDTNb2EJE/B+Kk8ob1flKu50N4Ejc+eCs3HClUqNTk39uMsUknsmx6VkC+jn3CEK9QUxDqzZ1VeIyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jISfbzwz; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jISfbzwz"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476af5479feso68055171cf.2
        for <git@vger.kernel.org>; Tue, 13 May 2025 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747150158; x=1747754958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjnGikvvv99icPL49LHs6vEnflqdAHYWUvysRlJTFrY=;
        b=jISfbzwzEHcKn6tvCiBgf9tsnRWq3NO29r2gW8yg6THlpJ5jBHYJfWeWMXkgNfcXXh
         62vGV3Qn4+RED92e3mABfervYrDBwtxZ80GjtXpU2NP0RvXyXUAgD8vstt8kpVMSn3m5
         TaGQX6F1hCl0mhcZMxawjnLbz9QjMnMLNimxiFxTCoEv+qrdEDzvyQY8MHo7Q7iXGk0c
         8xMZ2YMIk/ubp7Bd09AAHhIueOcqk3NdevrEL2sdf4g7XnnZcVqhs3QzreagZhZhjS5y
         TP5AbnLP03m4vJzsuoLePiBXVbM4qRat/ucOXdoPBWFV6dfxajRVd+42c6OtHG9AAEea
         qxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150158; x=1747754958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjnGikvvv99icPL49LHs6vEnflqdAHYWUvysRlJTFrY=;
        b=I8bX/31GAdsBqfbIFek+w/+9VkYNoBsSah85YU7PBQVngvN3/f1SW5j00TPfxBgBoS
         rvMX70lY71wMg6eRY/aK+ZrZ6r7TzU8jzXV9Ub5kIYyvzjwtm8jZVrMW7HXZ+ez2Loeh
         e49UlsXwXBWKGzANt5DJIx79NF2q61po4wuG+DjtuvBCeuvlt2fhG35MYvX1XpGXmYpZ
         unYlzjK/06QKmra282UHUuCAx9P6VPvtmSVPxiXi2M7z7ACFT9VbJiPyPseVq7wv1BOY
         sUwIM8DK4Zb+lKntYsFucme5li5U+7mh6C16lJU63aBPBX4uBT7KY8FSKnMQXSbHpYMX
         qdVw==
X-Forwarded-Encrypted: i=1; AJvYcCXSqbrxk1KTQh3l2aVr2Xw5dWKGmamPskDgjfC8aDk7S+yKyeWgsxZK/EUHykmW3lSyjUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykt5JNtbB0wm1NuIL+pHirF2lWS67qCfDA/L632MKxCVcCGW9f
	eL4eRviEqgf5OuUdVJFrAa2KulmvwP4BQJ0ZdVFD6KQ3FK1xnoqump/VRN6e/k4vvFXfDgbQC8k
	fuhZEvhp2VTI7YJbHMOIfDzo+PuLVHJ6A
X-Gm-Gg: ASbGncvBE7VA5xJ3nMvE+Hvg9UiXscQTR2+7WcKQjN7872FJZVMoBcn1HOxoxrgRXz1
	Ma5vN/NW7s1yVRlz3XeNOWNY/1vAi8wFd32DleW1FgvTmAZYH0NzxPXlkd0CbIaTQQ7sdP9mXi1
	20LMzXFYoRqQ9r/qpS0VBa/PnifP/r5iEI3wmnRZQMmK5uHyl249P3sBdWzf0jS4jSfA==
X-Google-Smtp-Source: AGHT+IH3lBPyl/qKtLZ5CMeQDjkRnu3tR8eDgB96wjsdlm+u+dGr2H/bkVAfoqB9MDtI8/T5NwnuykI31c44EdwGAnY=
X-Received: by 2002:a05:6e02:18c6:b0:3d8:1f87:9431 with SMTP id
 e9e14a558f8ab-3da7e1f44efmr207817665ab.12.1747150146939; Tue, 13 May 2025
 08:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com>
 <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com> <1d18ab7feb877a4173ac55814177aefe88cee658.1747093322.git.gitgitgadget@gmail.com>
 <fb1e64eb-3e38-4929-a7bd-09051490760d@app.fastmail.com>
In-Reply-To: <fb1e64eb-3e38-4929-a7bd-09051490760d@app.fastmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 13 May 2025 08:28:55 -0700
X-Gm-Features: AX0GCFtSzfzgfCIfBPGQwsyE2Nty4HDsiuvSqqnFwba5WuU3APmANGX04-pGWto
Message-ID: <CABPp-BGtNMTaZH3stP3EjNUFssyk20t8Q1+dCipA_L7zeQGbgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] merge-tree: add a new --dry-run flag
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:15=E2=80=AFAM Kristoffer Haugsbakk
<kristofferhaugsbakk@fastmail.com> wrote:
>
> On Tue, May 13, 2025, at 01:42, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> > +--mergeability-only::
> > +     Disable all output from the program.  Useful when you are only
> > +     interested in the exit status.  Allows merge-tree to exit
> > +     early on the first conflict it finds, and allows it to avoid
> > +     writing most objects created by merges.
>
> The previous name is being used here.

Oops; thanks for catching that.  I'll fix it up.
