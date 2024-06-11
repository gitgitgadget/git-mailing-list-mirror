Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D083417995B
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104502; cv=none; b=ui3sWlTCrJoDZK9b2IXcoYjYxGZAtL4F99NBvScjzwLOJ6+8j6OobM7agEj3uaakwirOX+/ap3QQgQXtAoIKbsVI3/ivXFne8OpsnU7fOC05kDJQs3XFHW+WPF86meCjNMpV0lgwByAeucBjOeIyFGr3Qri8A4mnuPJgCZ7BoQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104502; c=relaxed/simple;
	bh=WQo6BBdE+6ZPmOGDxx8GZpmm9Fb2D8SRG+EOtiGB4+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJF0qXrpIlNLWJCwa9pF1aH4fL6BpyhGvHn54x65RlWEF2ZsfwJ0UU7GuL4/elmFjleyuvNrBHYpO3dOrItRZ+TW8uavezrZbg+5AXrWbrWjAzLzWMdcvComrkgthBLACQHKuA04++w45kk0+OFbIm6kec37fw8VZiDlp6Eux60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGy4iv3F; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGy4iv3F"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b08d661dbaso3898216d6.0
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718104500; x=1718709300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKVtA+8C6dUOTuTSJ3hbAMMRyX5Qr/6um0uqXRrdLQo=;
        b=iGy4iv3FLPACVlH/z2G+VuxO2YQMkCYvx2ZZZdBu5IaODnwlyuFVkzsTBr5gZ0hGHX
         bQETln1FxJAs4MG5arLLtLcTDucEFPI78A6I1xcj9jX9XENA9Ku+b+ql3z6b5SOLCu0J
         3hKFLWou4yt8RinA69KdlDkM7yphzssQQcIJ3kig/E0HKnHqUAIwXcyXAaBbnr7t+o5z
         3gya0/Jf8c0CUJlHA4fOuagXUN7KKHG9F0ur99HlIYgXVzraHFsKoHGnx+wVfvDpUqN7
         2CyiqaVDGGiurxAuvZDjQfa44OZKSMOE4kEJy/pjblm2ZloU6KWvl6L7N4X06ehqYEUG
         KaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718104500; x=1718709300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKVtA+8C6dUOTuTSJ3hbAMMRyX5Qr/6um0uqXRrdLQo=;
        b=VFO43W3JXIP36jkdRRxGz0a0x7jObpOZJKBlTH/dMovamJ88hOVLTwotbbt3vZ7Z6U
         KZSpvvy1/ZlNvUUuov9hqT6SZQAvzUURpAtg8hwti0cIYm16lbajdWwoPrDXWuuNIeAt
         itWyehbVy6jMQ2uCGbjmL6kcKZFLpF8vFWLXyPwJix/l7k2u+1dwc2SE3d+UIIkv3Y1Q
         gunYaK4FW+djwjQvAa0v5DKlqdotprP/HBJ5T8lr1mEWTiMylNtAEKaOogQ8eOfTAAPa
         0MeVvRFVNUsbhFhyJwPrfETFOGvf91PWZOz1QZjXEFPHRNnnBYMahW0QXyMnudzELrIw
         dxRg==
X-Gm-Message-State: AOJu0YxjL5ZcB/cv6cSnO+fmokGW94nLhZwedv48y/q+aPpsiGzVEYJs
	lptBy5CaPyuCjzIVREAnEDe6Z4gh3CxhBT3TmckhNGNOhTbT3+dMAA3JHNAL+RdCnk0fIvWTLjl
	rw+ZHrfy7Xv4Q0yVctcXnYhcvBlw=
X-Google-Smtp-Source: AGHT+IE4bh0EwXUfHL8TY6TEvdvFiln8dhOSigWbJzPH44k/3m8oOQjPQ7+u2x7IZQV+0y5m7OU9uz7ZETP8GtMKNl4=
X-Received: by 2002:ad4:5747:0:b0:6ab:9214:ffd3 with SMTP id
 6a1803df08f44-6b089f75071mr45226346d6.25.1718104499488; Tue, 11 Jun 2024
 04:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHKF-AsoF10coLP=+MV-NfkEvWzp2Xbucs7OwtOoCBs3TVMg3A@mail.gmail.com>
 <20240611072144.GD3248245@coredump.intra.peff.net>
In-Reply-To: <20240611072144.GD3248245@coredump.intra.peff.net>
From: matthew sporleder <msporleder@gmail.com>
Date: Tue, 11 Jun 2024 07:14:48 -0400
Message-ID: <CAHKF-AskyrhNYyzZytarKYbEUMz7MzWZhL9jNbk3VQi7s84ceg@mail.gmail.com>
Subject: Re: bundles discovery and clones
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 3:21=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 10, 2024 at 02:25:19PM -0400, matthew sporleder wrote:
>
> > I have recently been playing with git clone --bundle-uri and loving it
> > because I can clone with almost-*zero* resources being used on the
> > server!
> >
> > I am a little confused by https://git-scm.com/docs/bundle-uri
> > mentioning "discovery" and things. Is this something being added to
> > the git cli, a special feature for other clients, or is it still too
> > early-days to talk about much?
> >
> > I would love to produce bundles of common use cases and have them
> > auto-discovered by git clone *without* the --bundle-uri parameter, and
> > then let our CDN do the heavy lifting of satisfying things like:
> > git clone
> > git clone --depth=3D0
> > git clone --single-branch --branch main
> >
> > I'm not sure I hold out as much hope for pre-bundling pulls/updates
> > but any movement towards offloading our big-ish repos to CDNs is a win
> > for us.
>
> I don't think the server side is well documented, but peeking at the
> code, I think you want this on the server:
>
>   git config uploadpack.advertiseBundleURIs true
>   git config bundle.version 1
>   git config bundle.mode any
>   git config bundle.foo.uri https://example.com/your.bundle
>
> And then the clients need to tell Git that they allow bundle transfers:
>
>   git config --global transfer.bundleURI true
>
> I'm not sure if we'd eventually flip the client-side switch to "true" by
> default (which is what you'd need for this to happen without any user
> participation at all).
>
> One gotcha there is that clients are now accessing an arbitrary URL
> provided by the server, so there are cross-site security implications.
> It might make more sense to allow only relative URLs without ".." (so if
> I fetched from https://example.com/foo.git, the server could use only
> the relative "bundles/bar.bundle", which would then be found at
> https://example.com/foo.git/bundles/bar.bundle").
>
> -Peff


It wasn't clear to me what the <id> (bundle.foo in your case) referred
to. Where did 'foo' come from?

Anyway if people are taking suggestions for UX I'll give my $0.02:
git clone --try-bundle, with --bundle-uri overriding, to allow the
client to ask the server for bundles that satisfy their request.
