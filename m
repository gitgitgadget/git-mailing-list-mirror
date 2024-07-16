Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E671E198E80
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143412; cv=none; b=O3VYUpu225gr1ofXllEziS8BvBDcgR+9MqHA4+wvCIwU2jAvRRDL2/sgMUWgVo9/VPusEiY04GfaPLFr146lbICO+Wn6CfzkCyyQAamcO/GM+g5MT8yr3yTxN8xDQYGCwQvmbkcoSxsWJuJnBDI1P2InwjTTB0OaInOYcAU+JrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143412; c=relaxed/simple;
	bh=a56cq1+sSI/hwqOqf3sent/VOwsxLpRkdZPHNFnEa6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxdz+Xn0XFrYbuZ4Zv2uD9snhTtYdO21KabNQmhtGB1M+3bXErfQTom0GkV+kPCc3RcRKY15YHIu5MtOOKacUsxEnc3uvi0CRze+skCVhczIv/BYdZQ4yjpG+wvWxD7KvNzIipMvs+Xbz/cLSf07q6dlqmtDfzH/Y6XXpLasgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev; spf=pass smtp.mailfrom=chainguard.dev; dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b=eZnswdwF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainguard.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chainguard.dev header.i=@chainguard.dev header.b="eZnswdwF"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eede876fbfso41109541fa.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2024 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chainguard.dev; s=google; t=1721143407; x=1721748207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZuAYIighl+1IrxNi/s6wV2NTmRv3w2lw+fJ57LvyGU=;
        b=eZnswdwFep+Xxhg0D1pUx1pgQBGyoPojzKhYJ9X4VXlIADUNycaJ4SMdQFc4l0BzNv
         rOohgVmRl/unyPMRBj0FTH+9RrNruVD0gapAynkKFRH1Qq8lJEdTFkM3LijOp9ZmOwY3
         HS0ri4ZQKRiyJeZTD/EtzuXzY11KbKSq4gD4cpewcvODlAsoctVplZ2h7CbuoLrAHGM1
         iNiyNZE1QoHtfJ7donu4IYnCo01PZTmvb+YCxDpUXWWH5t0GoaDd5YkjHG/E8ux43abn
         rAWCei9s6z4KQDs0+/P/AD+8qzaX8YmLoH0i16GizoG0dBH3gEZN7erwCROOaU8AWYRi
         y1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143407; x=1721748207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZuAYIighl+1IrxNi/s6wV2NTmRv3w2lw+fJ57LvyGU=;
        b=HYIAP2IGD5jMgWjAZlQviRkF2+/sEDRDvnsggPRhV94vFcbDGd5eE+xrPGJqTevBGi
         ONOXWL6CzY9dL8ebgQ3Sd2oYyXXQwdTgXvs3LF/DyPNydbYOoWEYcSdRTfXxdnhUeMae
         kufYxNCa06Fjk77ua+ipYyGD72kimwPt4cvdEqjCZFwEflYKx8JDAzZn8IRmYhCoOzrZ
         sw91Qh426BQjK1Xh9QAPisv3hE1JG1J1apz5ntwhLGTSlWYohHfDVK2HT0NKE0tfpj+m
         gG1p8X06fcThOHCvbkkN+w4FkL4M4Vz1k/RpxANDNOqccvYTwa6mnoUG2SdimXAdDXvI
         Ef1A==
X-Forwarded-Encrypted: i=1; AJvYcCVPr48cxCOBmk0OxpiDgVRlD1YTNiSiD8/VCoUr5VANt2ZRvKR+t5aAMHp/HB0HRfMZn3qdyfqCOP4aGiTixlTUPX4c
X-Gm-Message-State: AOJu0Yw3lckh59VVWDmPJr4sZS3jZGzFAT+2nAd2FBO+TfC7P/rHrCSp
	3tNX4kuuUlU2wcmSzY6I6TAfgXZUZKwb4Xks6Sv1PmjWI0D6RKal/YAxdkxNAAefjkg1NJOwwYc
	woHZTF6aKgogF7u/UThX5R1vEyAmNo7VkthUY2A==
X-Google-Smtp-Source: AGHT+IHcIpVqN2alwbuBA406LOpDl37aR+6rHmPDniOx2NLFlLbDZk2Br/8Q99GeDQbfPJ/XuTyfPZ2QdbbbOGd/EIY=
X-Received: by 2002:a2e:9605:0:b0:2ec:500c:b2e0 with SMTP id
 38308e7fff4ca-2eef4191c4fmr17408011fa.22.1721143406699; Tue, 16 Jul 2024
 08:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADaTQqDZ_6wORXOFc2CE90aizgHJ116NDHZhNeY4Nx7NH8DHJw@mail.gmail.com>
 <xmqq8qy21k9f.fsf@gitster.g> <20240715235212.GA628996@coredump.intra.peff.net>
In-Reply-To: <20240715235212.GA628996@coredump.intra.peff.net>
From: Scott Moser <scott.moser@chainguard.dev>
Date: Tue, 16 Jul 2024 11:23:15 -0400
Message-ID: <CADaTQqB4wm5qzRzgRw7wz1L=Lju=X9iKtktLgdN2MfKf0kg3jA@mail.gmail.com>
Subject: Re: Can dependency on /bin/sh be removed?
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:52=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jul 15, 2024 at 01:18:52PM -0700, Junio C Hamano wrote:

> Yes, I think this is reasonable. You'd also perhaps want to have it set
> child->git_cmd as appropriate (though really, I do not think that does
> anything except stick "git" into child.args[0], so we could just do that
> ourselves).
>
> I'm actually a little surprised it was not written this way in the first
> place.

I was too.  It seems odd to combine the arguments into a single string
early.  I was also surprised / didn't realize that 'use_shell' might be
ignored.

> > Having said that, I do not think you can avoid /bin/sh if your goal
> > is "minimal image *to run git*", as there are many things we run,
> > starting from the editor and the pager and end-user hooks.  The
> > credential helper is probably the least of your problems.  What's a
> > minimum /bin/dash image cost these days?

Adding dash is ultimately what we're going to do at least for now.
That won't get us a pager or an editor.  That's fine.  The image will be
used in non-interactive environments such as c-i.

Not being able to utilize your custom hook that runs awk and sed
is one thing. Not being able to build your private repo from github
is another.

Thanks for your input.

On Mon, Jul 15, 2024 at 7:52=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jul 15, 2024 at 01:18:52PM -0700, Junio C Hamano wrote:
>
> > Even though the code path starting from start_command() is what
> > run_credential_helper() does use, what is run is NOT a simple
> > command "/bin/myhelper".  It will receive arguments, like
> >
> >       /bin/myhelper erase
> >       /bin/myhelper get
> >       /bin/myhelper store
> >
> > etc., because the caller appends these operation verbs to the value
> > of the configuration variable.  And as you found out, to tokenize them
> > into two, we need shell.
>
> It is also usually "git myhelper get", and so on (though you can
> configure a shell command).
>
> > We may be able to teach credential.c:credential_do() not to paste
> > the operation verb to the command line so early.  Instead you could
> > teach the function to send the command line and operation verb
> > separately down to run_credential_helper() though.  That way, we
> > might be able to avoid the shell in this particular case.  That is,
> > if we can
> >
> >  * Have start_command() -> prepare_cmd() -> prepare_shell_cmd()
> >    codepath to take the usual route _without_ the operation verb
> >    tucked to the command line, we would get cmd->args.v[] that does
> >    not rely on the shell;
> >
> >  * Then before the prepared command is executed, if we can somehow
> >    _append_ to cmd->args.v[] the operation verb (after all, that
> >    wants to become the argv[1] to the spawned command) before
> >    start_command() exec's it
> >
> > then we are done.
>
> Yes, I think this is reasonable. You'd also perhaps want to have it set
> child->git_cmd as appropriate (though really, I do not think that does
> anything except stick "git" into child.args[0], so we could just do that
> ourselves).
>
> I'm actually a little surprised it was not written this way in the first
> place. In the non-!, non-absolute-path case we are pasting together a
> string that will be passed to the shell, and it includes the "helper"
> argument without further quoting. I don't think you could smuggle a
> semicolon into there (due to our protocol restrictions), but it does
> seem like a possible shell injection route.
>
> I think it probably goes all the way back to my abca927dbe (introduce
> credentials API, 2011-12-10).
>
> > Having said that, I do not think you can avoid /bin/sh if your goal
> > is "minimal image *to run git*", as there are many things we run,
> > starting from the editor and the pager and end-user hooks.  The
> > credential helper is probably the least of your problems.  What's a
> > minimum /bin/dash image cost these days?
>
> Right. The bigger issue to me is that the credential helper "!" syntax
> is defined to the end user as running a shell (and ditto for all of
> those other spots). So any platform where we can't run a shell would not
> be fully compatible with git on other platforms.
>
> That may be an OK limitation as long as it is advertised clearly, but
> the use of a shell here is not just an implementation detail, but an
> intentional user-facing design.
>
> -Peff
