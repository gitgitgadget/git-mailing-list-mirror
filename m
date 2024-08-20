Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FE18E370
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153567; cv=none; b=kjblXqYi3Vr2Ldvdiw+asNPb5j3lQ+KTWfbY9D8a7EIZW/ch6sMnRvNXduD8KKSIC2LsZo1cAc9y941RJLVlfsiiGmgkK2YFoYXhPVaHLJtH7daqjc6Su7fYFysz0kv5TwdsJE5KNT5ZepV2lRBXxp5BwGvukbMZ8UkAryEBekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153567; c=relaxed/simple;
	bh=IzxHC4qBW2URWvqsJotzw8P0k3pn9CRJl2iMxBo0dO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksOnm9ENXNG8S3cp0wunaXpXqvF7sfRTfhnFv0FuVEIqqY4BQjKKtfGVcGIbkiZHWPh8vDAj0J9nUOe35sYoyE6xL7HEFZdtmnOM84/51S0X/VVOWcOzEUldXfQWBdF58eFK1Jn2kQlrR2U0fwGHroocY/66OKXecfHTIuYqNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krz0R9Vh; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krz0R9Vh"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf66fe9d8bso27637526d6.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724153565; x=1724758365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH3khXrWc7TafSRfyKQYz3FEAn5KTMWK8iXhWFiByPM=;
        b=krz0R9VhKpU0Qa8otgiGUHJWtNRejdx6xBq1bVSxtog9tqi9rEoEaJIyPcQsfhHijJ
         kUP9+x0/qMQALyQY94dediU3jakZ26UmofuGF8ruw1T4nO/AZjpMpp9P7veHlL8O/vgG
         B/9fekQpOgGxst1cAeVwotIJyegl65FyvCHWV+azFo+q4dm7qwQ3DdUnPXT/rJkcdjCH
         ho8VTsz8XNrOzAxkdI6McqgIk4dZgtQE6NV1xuwUUCScWMtPkn+gZb5qO3AGdNQl81tz
         15US+8WoaKl5X3U519vxUKnhgHfHJZLrzTFtvUsP4xWnwDQC0j74xm3uAhsoV6EBCfbN
         T8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724153565; x=1724758365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PH3khXrWc7TafSRfyKQYz3FEAn5KTMWK8iXhWFiByPM=;
        b=GWdIM5/Zh6J8KEnlkkF++8581u+8ac+F1JQ2RMPA7YmPHMx5fJExZgDkHLDpwLC7KW
         ORPk+pQobDdtgRdDPaxsopSr273u34kwN8uPbt15yNmV8/ooIF8ANMgCNTJ4DJB0Sstj
         R+hWBNeQyfCEpSDAFjZdoadOnCb/QrWNz0zlxWhwyoWGO40DeFD1ijX+YozOTocZw86v
         /by6vKpMO2x7ehj3mX06yYdui5023FNb1bCIlmQ0m6rQnFxkE8bWwOVXoimXJwLLUM3C
         g3w4IinJKJlu76zJkpVhDC066E6FY6FxGkSxOL32+If1fyH6dD2P4U8qLLH0mjboCo3p
         JVKg==
X-Gm-Message-State: AOJu0Ywz86E9drnA/wCLJav4zs5eOJ3Q1WGvMEO3YYhkj5Vum1dZEbOc
	mSjQ2JVyhS0nwKS71kcIPZsPBw9G6ycwo8SfuYI67JRgngcoPV8Pg0qF/XpiK+NQ/NCQE7kq7Bd
	6vvehY4MVG8YIalq3MbsFjLgKiSE=
X-Google-Smtp-Source: AGHT+IEv+NIjwgzuCoAIFFIQseuJoANuI3AEW/ScMMTNKbP96Jaoz5cKng+NqWAejV9ESuP5QYY+Jc7ynL87+ZkNZ7U=
X-Received: by 2002:a05:6214:5f10:b0:6bf:6604:c867 with SMTP id
 6a1803df08f44-6bf7ce5302bmr209374696d6.28.1724153564625; Tue, 20 Aug 2024
 04:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240731134014.2299361-4-christian.couder@gmail.com> <ZqpjV/A9ZVPDiGgA@nand.local>
In-Reply-To: <ZqpjV/A9ZVPDiGgA@nand.local>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 20 Aug 2024 13:32:30 +0200
Message-ID: <CAP8UFD2OR=5QvyFT6EGQkekFBtjRWoMShQ=_eT=ypH=FswUaRA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 6:16=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Jul 31, 2024 at 03:40:13PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotoc=
ol-v2.txt
> > index 414bc625d5..4d8d3839c4 100644
> > --- a/Documentation/gitprotocol-v2.txt
> > +++ b/Documentation/gitprotocol-v2.txt
> > @@ -781,6 +781,43 @@ retrieving the header from a bundle at the indicat=
ed URI, and thus
> >  save themselves and the server(s) the request(s) needed to inspect the
> >  headers of that bundle or bundles.
> >
> > +promisor-remote=3D<pr-infos>
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +The server may advertise some promisor remotes it is using, if it's OK
> > +for the server that a client uses them too. In this case <pr-infos>
> > +should be of the form:
> > +
> > +     pr-infos =3D pr-info | pr-infos ";" pr-info
>
> So <pr-infos> uses the ';' character to delimit multiple <pr-info>s,
> which means that <pr-info> can't use ';' itself. You mention above that
> <pr-info> is supposed to be generic so that we can add other fields to
> it in the future. Do you imagine that any of those fields might want to
> use the ';' in their values?

Yeah, but, as for the 'url' field where the value is urlencoded, the
value can be encoded if it could contain some special characters.

> One that comes to mind is the shared token example you wrote about
> above. It would be nice to not restrict what characters the token can
> contain.

I agree but I think urlencoding, or maybe other simple encodings like
base64, should be easy and simple enough to work around this.

> I wonder if it would instead be useful to have <pr-infos> first write
> out how many <pr-info>s it contains, and then write out each <pr-info>
> separated by a NUL byte, so that none of the files in the <pr-info>
> itself are restricted in what characters they can use.

I am not sure how NUL bytes would interfere with the pkt-line.[c,h] code th=
ough.

> > +static void promisor_info_vecs(struct repository *repo,
> > +                            struct strvec *names,
> > +                            struct strvec *urls)
> > +{
> > +     struct promisor_remote *r;
> > +
> > +     promisor_remote_init(repo);
> > +
> > +     for (r =3D repo->promisor_remote_config->promisors; r; r =3D r->n=
ext) {
> > +             char *url;
> > +             char *url_key =3D xstrfmt("remote.%s.url", r->name);
> > +
> > +             strvec_push(names, r->name);
> > +             strvec_push(urls, git_config_get_string(url_key, &url) ? =
NULL : url);
>
> Do you mean to push NULL onto urls here? It seems risky since you have
> to check that each entry in the strvec is non-NULL before printing it
> out (which you do below in promisor_remote_info()).

The code doesn't seem risky to me as it allows us to treat the case
when git_config_get_string() fails and when it succeeds but possibly
sets 'url' to NULL (not sure if it's possible though as I didn't
check) in the same way.

Yeah, it means that we have to check if each entry in the strvec is
non-NULL, but I think it's quite easy, and honestly I didn't want to
ask myself questions like should we treat an URL of a remote
configured as an empty string in the same way as the URL not
configured. I think it's much simpler to just pass as-is the content,
if any, that we get from git_config_get_string().

> Or maybe you need to in order to advertise promisor remotes without
> URLs?

Yeah, I think we should advertise promisor remotes that don't have an
URL configured. It might seem strange, but maybe servers might want in
the future to have hidden/secret URLs (URLs that they use, likely
internally on the server, but don't want to pass for some reason to a
client).

> If so, I'm not sure what the benefit would be to the client if it
> doesn't know where to go to retrieve any objects without having a URL.

The client might already have an URL for the promisor-remote (and it
might be a different one than the one the server would use if
hidden/secret URLs become a thing). That's why patch 4/4 implements
the "KnownName" value for the "promisor.acceptFromServer" config
option.
