Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3E71C302C
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739210623; cv=none; b=gtqEDzipA04z4EPBHoK0ievGkdxw8soe6IUgwo6cAg2lRgbAVyh8PJ2PcROAYwY+9Y+EmveLSXG9hvEalxZHoLxGnTOABomoK/Tc9L578BCcgkkpoa79W8rBLIY/NyQRi32+E8XF7wg6n3ozBQXrsorAKK8cb2pWJHS0SY1Xm+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739210623; c=relaxed/simple;
	bh=GKIJMbW4psXc2rh3l011sSOsvudtPhrlHAj+Y3tp1ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WALJTFUlRS2+wk/RzZjgNJJkUwAQZg+oYpTQcXUzByWu4zgmXNUW61hIXj3NZWQw299i7ai4EI42GQ0jRP5ow223KJ99v7HyABzoq+RWth96D3lcinHNTnvfaPoSZBGRQFmJzRYimL7OtBuXPUP1e+pTiV5veoicxoFqoWve1j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJpAym+/; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJpAym+/"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4bbd554fe87so322295137.0
        for <git@vger.kernel.org>; Mon, 10 Feb 2025 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739210621; x=1739815421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4XtxJNMWlO2wR2LXt1RN7YGCixWBczuO4MOdGEFiBM=;
        b=GJpAym+/p6VEIQKu3e0ETvoUcGCW1mg+sXf0Ez4NRZuFDxoLONt77uElK5JlounQ2w
         3HJWsK0I/GCltIfrQds12Tgm5hfbEAkNhxGtz0/KApTSHLlJ06wg7q4Fl5X0cFjDPKwv
         ByVWPAhw/0qnzcrO48e+TCt+m4yTqwkCgnjo/rO8RXFG9Nzzek9X1Fx7QMpfES3ppiFI
         rvfa7iSUUdZBblFK8/qBLcoxLYGYUBBtxqQhmAOMG8gsN37QLstAVSjSi1s4L2VQYeQR
         1WloJjGvYn6dei0h60A67+3MwDIe4lmZiwBYX3dqlmp4TpzATXvbBgpQjks2XfLUeWSI
         iQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739210621; x=1739815421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4XtxJNMWlO2wR2LXt1RN7YGCixWBczuO4MOdGEFiBM=;
        b=plT2BmmvZeEKWVEHXa5rfnd96wQo94Mu4ar8NWYxwpOZnPCWUFtyt39tsp3h4ItfdJ
         +Ja8GoAsh1zTJv6Q8lUcevbeFcnnzxPIqHXQ2JgbdsjwydTfdWNd9yW8d9Yy9Al7YdmP
         u/fYSUsF7eQrXhqcVL1h4OxyUl9/7Ssns87q/KP9dx4QjOYsXLN4MngITvIQSuAWQijo
         ElK0Gn1pJNqfPy+fEmhRs82lMukaabbVUIEdLTlI1XxOvUmZTCBOUXb3DzbwYr9Gsdsv
         lYjh7LreRu/ncNzPRiyOWvtqGlR6yTXGpq0rgJS3nPiq1zdO4vUUzwCc/qFyNhlUctam
         yVbA==
X-Gm-Message-State: AOJu0Yx7kATLpJ/ZyzgjCp2DmGHCzeomVHkEeo+XUAbRLtmWrK+PhChe
	XSE0oFYi0cxbJhwMiPwRyCO6NFbBproIuCEKgMbKRx0ijZq0YY9v7Oeo0nY4e6zQB/FpQVEWa/I
	6EuRv08oTi0vn3s9MfQHnCGSr1/F1plew
X-Gm-Gg: ASbGncu8y7oPpz0u5JFO8Lbz1QST9k1Eo918bxOUqTf8xMdI788pSptoJM+VNkJxyJx
	csbosQ8nNRN9RvRBk8iu+Kscpkr6D5S+LCgEO9+a0aBpiUh9IzJr/2W5KQPQWxixCmjO3v1TZ
X-Google-Smtp-Source: AGHT+IG4eZ84vl3miWlULW9yP8AWJS6/RqBxInwOKALoKbeqXlLMVR9dQ7oF2FT41ux1ZGn8wk7UBy2g4vR/O1P8VrY=
X-Received: by 2002:a05:6122:1d55:b0:520:4539:4b4c with SMTP id
 71dfb90a1353d-520453960cfmr2917593e0c.9.1739210620887; Mon, 10 Feb 2025
 10:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210142820.3588250-1-usmanakinyemi202@gmail.com> <xmqqikphbu6b.fsf@gitster.g>
In-Reply-To: <xmqqikphbu6b.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 10 Feb 2025 23:33:30 +0530
X-Gm-Features: AWEUYZlKicstpt8negxbBsahmE4Pry8zN0iWC_Q8cLJNuMiatw_l4QcT0hpKXSc
Message-ID: <CAPSxiM8XOH9ueeYwhdQx6PKUWkRbzZh77ZxAmNjSjXrR0gd9_A@mail.gmail.com>
Subject: Re: [Outreachy][PATCH] builtin/update-server-info: remove
 the_repository global variable
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im, 
	shejialuo@gmail.com, johncai86@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
> > Remove the_repository global variable in favor of the repository
> > argument that gets passed in "builtin/upload-server-info.c".
>
> update? upload?
>
> I somehow thought that dumb HTTP walker support was on the chopping
> list for Git 3.0 but apparently it isn't, so updating this remote
> corner of the system I thought nobody cared about is a good thing.
Luckily, there are some other files that have similar structure. I
will be sending
patches soon for those also.
>
> I personally feel that from here ...
>
> > The RUN_SETUP macro is used in "git.c" when the 'update-server-info'
> > command is wired to the 'cmd_update_server_info()' function."
> > This means we can be sure that the `run_builtin()` function inside
> > "git.c" will always pass a valid `repo` variable to `cmd_update_server_=
info()`
> > when the `update-server-info` command is run inside a Git repository.
> >
> > When the command is run outside a Git repository without the `-h`
> > option, the command will fail (`die`) inside the `run_builtin()` functi=
on
> > when the `setup_git_directory()` is called. So, the `cmd_update_server_=
info()`
> > would not be called at all.
>
> ... to here are way too verbose and unnecessary.
>
> > When `-h` is passed to the command outside a
> > Git repository, the `run_builtin()` will call the `cmd_update_server_in=
fo()`
> > function with `repo` set as NULL.
>
> "set as NULL" -> "set to NULL"?
>
>    ... and then early in the function, "parse_options()" call will give
>    the options help and exit, without having to consult much of the
>    configuration file.  So it is safe to omit reading the config
>    when `repo` argument the caller gave us is NULL.
>
> and that would be sufficient.  All the rest of the proposed commit
> log message can also be removed, I think.
Yeah, thanks for the review. I will send the updated version.
Thanks.
>
> Thanks.
