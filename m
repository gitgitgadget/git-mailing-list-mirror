Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EBD1F3BAE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366200; cv=none; b=WdBFqfqyisoc7pFyz/3fV+x9WeCmADHF2200C1tddFiEpkPUCofNIUX2Y7qlrXmvRUt5E+S4QOfRmwgZs9BYWLycInI9ew+yIBhoiII6e+z92QeDT82UdZRsJL4boAzwU2OmHTT+vIkUdKzTa0VcD8oX/lhOUOtV+UO4gi1nLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366200; c=relaxed/simple;
	bh=QO6wsllg7+Ko5aSE3yJJVtyNGHK3fhSCJRszfjgc6fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpANaBZWYCqFD9vlDa0GUNRZOK4BFbg88E1AfOEzEMxe1Z1u6Se1mxuFcm0B5TDJ7t8ZHkb7JRFADFMY85+8i2YtSQavfP+lLcAqah0CRtOg35EwJrvyBVK8HdmVCkQ0KhnvZq9HoCQbUK7nfmtJ4od3mNCEyY7dNlKgEAIm0lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JorZWsUr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JorZWsUr"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo5533437a12.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 03:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751366197; x=1751970997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vXPS7CN4ZN8lJoDN+l1HmFJWaOyq3dzWDl4kwahJOo=;
        b=JorZWsUrLyrTnbF+BmvTzQkYVjRMSY1PNfGQOENqQ2zZ9mpg2iSnL3ojyQqrjqm9RR
         y7bcJMSiaCuu0ykHVHx24CZwmJKzTV66Aa0TWJDmPDf70NtIqtj081XoEHpzQ4CNu08y
         201M4V+C+ARKJ1lY96Pc6SJEW+J+mGneiuCFPQoa/EEmmxYmuiKknnT9aBYAFBYBCsQn
         NABxkgzjKm+FkNh69biGng7++0FGn8+2K/PWknc2G8Rcpc2VJ/B4ZD2UGET4bOatvfC7
         gFYEh01iHJSo183Kt7WGRbhvAQXowAanfihuFdaPVgI+qqe4xd95NqNYhveg0bryMj0L
         +ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751366197; x=1751970997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vXPS7CN4ZN8lJoDN+l1HmFJWaOyq3dzWDl4kwahJOo=;
        b=alE80NTBKjY6XsQjP1H2nKABxOHfpcN7SeoSyTYxB6u9UbYDlGHfy3mO4Y/acUePwG
         SubconNbL2JOHBCK59nPumi27PMGVyT6rdJ1MWbxLze7agVckxYB4hQ3WU3G9N5AaDdi
         KXI0y9vMkIJbRpPxYfmKASCxao2WsZLaDiJecy/MQpr+H807UV84iaVhD1Tc8semOexE
         0eSd1uusyx+28TGzJxzI0xtnyaXCAcLb/pF5iA91KImqWWYXSVdOLTdLu6AsPac4QUma
         iApG03RwgWxLYgZV+A+2mBo+fPBZzBcYMSRcI4q8P53BkmrJuSeav/oxCLmYiM0ruzs8
         b+2w==
X-Gm-Message-State: AOJu0YyYaBFseniSZ+czjLlOXtveRz06OEUCfDOvlWVB8IjSy68KwtZM
	Xq9x16CxGEF4X+C5zkMjCQIqQhFOsiyVRnbLDrWze+ltmJkokl80LZjAVeDCMrx5jUPTZ/XrX8J
	QSeWDKMgoLQyZAtdu6l4ZJC6i4TlC2qI=
X-Gm-Gg: ASbGncsuLwFRhlXqUrdVp2dyKZ61BFiR/GNuNzd4MVvWf44JojTlUeUqtzEavOomAxE
	OUeE5rhTZUbzOG2RgrZ+efNUhY8DgM7vGN4qAQWkfx1/lCEKzxZ1lWqm9gJQE+pQUNrXM0CdOIu
	fcxrZTdmk4CKKSH9u2ibu37MT6+L6iXgh2fIewC4q5iv/epw==
X-Google-Smtp-Source: AGHT+IFEUIm8U6CPPqGBHNlf2Nj/usCloK5rl2Q3q5fMc29TZkxX7G0FQ1Mh6MSnS/TLRAC9oZFxsjiAIi3ub9NCGlo=
X-Received: by 2002:a17:907:3fa8:b0:ad8:9ab7:a270 with SMTP id
 a640c23a62f3a-ae3500b3f29mr1503149566b.38.1751366196972; Tue, 01 Jul 2025
 03:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcyalm0mh.fsf@gitster.g>
In-Reply-To: <xmqqcyalm0mh.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 1 Jul 2025 12:36:24 +0200
X-Gm-Features: Ac12FXyocedjWXlSs5JTxnVVSwyAvMr_r0qO1OhTbDpKDc57SwCb5goQU2w7osc
Message-ID: <CAP8UFD0bd1PD03VPaenAd+76Q6CeCOmDOJsso1nMKk4tZ4vbMg@mail.gmail.com>
Subject: Re: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate changes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Git PLC <git@sfconservancy.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:32=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Following the example set by QEMU folks, let's explicitly forbid use
> of genAI tools until the copyright and license situations become
> more clear.  Here is what QEMU folks say in their commit to adopt
> such a rule:
>
>     The DCO requires contributors to assert they have the right to
>     contribute under the designated project license. Given the lack
>     of consensus on the licensing of AI code generator output, it is
>     not considered credible to assert compliance with the DCO clause
>     (b) or (c) where a patch includes such generated code.

Here they forbid licensing any "AI code generator output" with the DCO.

> and it applies equally well to ours.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/SubmittingPatches | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPa=
tches
> index 958e3cc3d5..63fd10ce39 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -439,6 +439,23 @@ highlighted above.
>  Only capitalize the very first letter of the trailer, i.e. favor
>  "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
>
> +
> +[[ai]]
> +=3D=3D=3D Use of AI content generators
> +
> +This project requires that contributors certify that their
> +contributions are made under Developer's Certificate of Origin 1.1,
> +which in turn means that contributors must understand the full
> +provenance of what they are contributing.  With AI content generators,
> +the copyright or license status of their output is ill-defined, without
> +any generally accepted legal foundation.

Here we would forbid licensing any "AI content generator" output, not
just AI code generator output. So what we would forbid might be more
general than what QEMU folks forbid. For example they might still
accept a new logo, or even commit messages, made using an AI while we
wouldn't.

> +Hence, the project asks that contributors refrain from using AI content
> +generators on changes that are submitted to the project.

Here it looks like using an AI capable of generating content to just
check code that would be submitted could also be forbidden. I don't
think this is what we want, so I think we might want to reword this.

> +Contributions in which use of AI is either known or suspected may not
> +be accepted.

Here also "use of AI" might forbid checking what we submit using any AI too=
l.
