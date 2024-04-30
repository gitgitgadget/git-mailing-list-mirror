Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384717BB0C
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714494917; cv=none; b=kKNpa6cBc7k5vRaV4L/lfk5FMqHCHk428rnUWFsXm+mp/NNzy0Qd+ZvdaUFAzS3FdWalYJUkgNZdYnnIBusfUCl+s37oaT+JKAm/nJ04IIlk8GpzYPivUTYKd/gUF78Di9vSr2KlDrcdhDngFxVZteAgVEVc5g4T7lXMWUGRKGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714494917; c=relaxed/simple;
	bh=fS5wlN1FoSWlStu34hfwn7MyUEMA6rM6vxfzmLUKEEc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j0iGUl79PEY7aqemWHjzcZ21pu70LBAlECoHWhrKjEzD2mapzlyrLi2cQ8jVek0Uvtk7AU0uY6cL8hBaxBASt6fJ022Md3GI1KWldrO8pSBHsA26F3hyveH+gNQezuvgyhvuT/9RhFZrGoZS8QZe8sW+btWokC0dm63HuKk+idQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6xKEbAc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6xKEbAc"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34d99ec52e1so452806f8f.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714494914; x=1715099714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6DXHVRwz9bd0ISMwmI+LXGBogC7UewAeP6+vmx9KUf8=;
        b=P6xKEbAcGiAS3/6spOxlv/hSJhe+6/aNmWIMvHNsqoP5OLcO5E2ISz0u5u1dUQtyl3
         Vqg+mVztXaFkUWP6azq/AfCNNXL8iloWIJkNmdgJVcxq9RmKj04SCQ5LF5zVmntxN40U
         chX0rzga7pIxeaA/fvh1I/UtWRLE3S+tuhq31nP5hJSnpoS+lSRH1nHVY+piJPnAko8E
         evRLWSYHnMz9y4UH56rtm6P9JVQPoURGU912ISWDcunKqfVMFSgjE7HmaFWmUkJQBB+7
         IjCGWq53mURebTdTTJ1tzO0kpFd3X1T9Szok2mmUNG2yieqnJCcfFL4QC9vfCHbBbaQj
         SANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714494914; x=1715099714;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6DXHVRwz9bd0ISMwmI+LXGBogC7UewAeP6+vmx9KUf8=;
        b=CGo5y6tCalQAkKGZP9nogvu5GiPKIznxHrJ98CRMFk/qCnB3vusoZ3Y7e+a8VRNE7g
         E5G5D7zTuyRwaQIHJbcdkc7N6Y8An6M+InPdOnf3DUU/Q9z7CQKKS3wBuz36N93SgRdY
         kuHcY4EdcuMeVGq6DTKEa+SOZcFuAiHiDAw8ixGYufILUGd8TqFWqTKTqebDbpYk3UAz
         DWXIOd7/HqACW+Ef+42+IOAo6QFF1F5S6+0uxir3sr2BsGec1uPa8+lUaAZCC2XVnfeO
         45KC33DART4Fj4HJCI3gN8D5swnghgvtdvo7W9rTMEeIjsjvkG3AdPYDhzFUTtSM0mwF
         +Uyg==
X-Gm-Message-State: AOJu0Yy1vaz7LgkxJWmVMmuxh5vcPKQBtCTPya5tPwJWJHDzhRCETOxD
	RWuFd07FK+MMY6D5Ve0c+KgOuvWgsX67mJ/G5/2mlqryL/irMus6
X-Google-Smtp-Source: AGHT+IGcWVr3YpJUC9uUXuRSedoGXdTpJSJSj19KyyTe2gRwkdr2m/kQKmS28nnTYrAnMjxwaMEQ5w==
X-Received: by 2002:a5d:6706:0:b0:33e:c410:a1cd with SMTP id o6-20020a5d6706000000b0033ec410a1cdmr111000wru.69.1714494914126;
        Tue, 30 Apr 2024 09:35:14 -0700 (PDT)
Received: from gmail.com (51.red-88-14-204.dynamicip.rima-tde.net. [88.14.204.51])
        by smtp.gmail.com with ESMTPSA id d15-20020adffbcf000000b0034b1bd76d30sm22670404wrs.28.2024.04.30.09.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 09:35:13 -0700 (PDT)
Message-ID: <90464326-0d0a-4cc6-84cd-eb1e5489a91a@gmail.com>
Date: Tue, 30 Apr 2024 18:35:12 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH v5 1/2] add-patch: do not show UI messages on stderr
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <952a9514-3cf1-4601-8f0d-db57adc750c3@gmail.com>
 <10905ab3-bb3c-4669-9177-84c8e6759616@gmail.com> <xmqqfrv4ug3l.fsf@gitster.g>
 <20240430105256.GH1279403@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240430105256.GH1279403@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Apr 30, 2024 at 06:52:56AM -0400, Jeff King wrote:
> On Mon, Apr 29, 2024 at 12:24:46PM -0700, Junio C Hamano wrote:
> 
> > Rubén Justo <rjusto@gmail.com> writes:
> > 
> > > diff --git a/add-patch.c b/add-patch.c
> > > index 0997d4af73..fc0eed4fd4 100644
> > > --- a/add-patch.c
> > > +++ b/add-patch.c
> > > @@ -293,10 +293,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
> > >  	va_list args;
> > >  
> > >  	va_start(args, fmt);
> > > -	fputs(s->s.error_color, stderr);
> > > -	vfprintf(stderr, fmt, args);
> > > -	fputs(s->s.reset_color, stderr);
> > > -	fputc('\n', stderr);
> > > +	fputs(s->s.error_color, stdout);
> > > +	vprintf(fmt, args);
> > > +	puts(s->s.reset_color);
> > 
> > I like the attention of the detail here ;-).
> 
> Indeed. I had to read this several times to wonder why it was not a
> mistake to leave the first fputs() but use vprintf() and puts() for the
> other two (for those just reading, the answer is that puts() prints an
> extra newline, so we can only use it at the end).

I did not know the details (or had happily forgotten them) but Junio
ignoring my comments in [1] intrigued me :-).  A simple test would have
been quick, but "man puts" was quicker;  my comments were not correct.

Just to be clear, and to extend your comment, in case any reader is
interested, this:

	vfprintf(stdout, fmt, args);

can be written as follows:

	vprintf(fmt, args);

And this:

	fputs(s->s.reset_color, stdout);
	fputc('\n', stdout);

can be shortened to:

	puts(s->s.reset_color);

The difference in vfprintf and vprintf is quite obvious IMHO, but not so
obvious with puts.  The documentation says:

  SYNOPSIS

       int puts(const char *s);

  DESCRIPTION

       puts() writes the string s and a trailing newline to stdout.



  [1] - https://lore.kernel.org/git/4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com/T/#m644a682364212729a2b21c052ef744039c26f972
