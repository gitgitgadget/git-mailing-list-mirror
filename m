Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D01D0B8B
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883356; cv=none; b=I2wn5Iu+V8DB2j+pX1nwbM/o+VKlhGAXeRrNxePIWcZQccH+paaejVjHMnpzKMh+SiEqoLcFa7ibvlcQUxscdfxXI2Q0EAQbBvIEg08g+U5TqzcVRFc2Y2mX32RqQ8pPl82rSLkVW61uak+4H+HApwDAZl580SBT9smgg9eE278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883356; c=relaxed/simple;
	bh=kfLeAo8DgYi6fxUeCLzdePN5vTae0xoyzebwEK4I4K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swYjZPIwgDjjylnWD7kCjOyBYy307nk/qkO7u9BMuTXq6mTOzPYDbxIs/QcdwXb+DvwWD4TphO87xo5/9eZp11uvpDr6ke4HtLtsUmIw7+6MtU/rdBxuS3b0PNEsttCzAGFrKiZQsmQAQlXDnA9p0Myx1H5YDNKJAgzz32FtRvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4LexI02; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4LexI02"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a345142c25so20927145ab.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727883354; x=1728488154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfLeAo8DgYi6fxUeCLzdePN5vTae0xoyzebwEK4I4K0=;
        b=U4LexI02E5pJlxwKxzz7uyE+UzKJL2536gtp0JeASy01DRBTHr4jmCLDWP9ZdouSe7
         uJBbHalh6Cj5uz16mz9Wee+OjemrBPrryMGuEEQ/2YF+0E4i1yggth9vevi8yGy8VL/M
         aaDauzhCEPX0d+qCD9T/0IBCwXxHubNR/ETWYNKd12EignQNeyUZmsBjGXY1CkdTGuGl
         5CJXXMzN7xLdqdXfKLnbfCIkOZiUkyIt3S9mOSk63LUs45Mejm6YfUl1trpkwAXvCTyS
         1bSB0w7uFe3SyFSXff7As5azfr+DR14iFkFJ7Y+BFJsAqhZGSpuyFhBzlRPrpiWaVWCQ
         UgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883354; x=1728488154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfLeAo8DgYi6fxUeCLzdePN5vTae0xoyzebwEK4I4K0=;
        b=MqteXO6lTwkc3Nzsk4kc2HpNPOnbFFx6rDH6YntwbZXXMI9T4qi5jzL4zcyfG8yHnW
         4xQn3duAShjJO6mNGo9ez2jRL99oywnvaKqlb2eGP/omDS6NvGKY122UoVKoVvHN+hhy
         2mQhCGUqcGxzGSLiAyDybebL3zLk8v52no9NJgCGuPxED0qI3DytZVDCiPEeDYtIwpaA
         tNDiH7u6E/eqkt6zgsYKXjZy54Axi3fbnsV2v3kWY2SG2Wimmo7RBNhabocfnhxl7KS0
         GmktaDDD/ieyjQyQgh4hPGyEg0bJE2xcczphp/78gC8dGKBtRjoHKOcEUGUzVPip03xu
         utNw==
X-Gm-Message-State: AOJu0Yw+Sq5HaEG5PfxBBBfuzfCG/ksJ+VjLWeXDZPxSmi1Fq5/F/7UA
	PslAJvA/5TjldsgAuKt01HLfA9fxC86+i9rhOs0IuL/p8Hp1uSbxLB3sm2qFGE6Wmycu392MVLr
	+QY0vlSl7FR+0ehGFRGhqSXH2rlM=
X-Google-Smtp-Source: AGHT+IEsNXpt2mnS8xAWecDsfdj7JMzTHTGqpGo8IWhiSJLjk6Ak6f5wukvT0b72sDCMYPbI8KESe9vrkBVBfnPKZxs=
X-Received: by 2002:a05:6e02:184a:b0:3a0:9f71:c6e with SMTP id
 e9e14a558f8ab-3a36594ac7amr34959965ab.22.1727883353995; Wed, 02 Oct 2024
 08:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAECe19JKjsASasm4bxvsYxezj0L5_z=H=3VJ9CXzwdBCezRc+w@mail.gmail.com>
 <Zv0_FJVhnkkUKCS8@pks.im>
In-Reply-To: <Zv0_FJVhnkkUKCS8@pks.im>
From: N Alain Jr <njokomalain@gmail.com>
Date: Wed, 2 Oct 2024 16:35:42 +0100
Message-ID: <CAECe19LzdnSOtbgGNv+zrxkYrKCCr+EOQvewLrpL0-mR5xU49Q@mail.gmail.com>
Subject: Re: [Outreachy]
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick.
My apologies for not specifying earlier.
I would like to contribute to project [2]...

Finish adding a 'os-version' capability to Git protocol v2

Cheers.

On Wed, Oct 2, 2024 at 1:39=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Oct 01, 2024 at 10:54:44PM +0100, N Alain Jr wrote:
> > Hello.
> > I'm Alain, an outreachy Intern. I am very excited about the prospect
> > of contributing to this project for Outreach 2024
>
> Hi Alain,
>
> happy to hear that you are interested in contributing to Git as part of
> the Outreachy projet. To help us mentors, could you please clarify which
> of the two approved projects you are interested in?
>
> Other than that I would strongly recommend reading through [1] and [2],
> if you haven't already done so. They should give you some ideas for how
> the Outreachy application process is designed to work in the Git project
> and lays out the expectation of us mentors.
>
> Let me know in case you have any additional questions!
>
> Patrick
>
> [1]: https://git.github.io/Mentoring-Program-Guide/
> [2]: https://git.github.io/General-Microproject-Information/
