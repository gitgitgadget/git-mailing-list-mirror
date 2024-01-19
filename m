Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368E4C602
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661792; cv=none; b=kMtZo294IT9yap9vjEZ+Zd8JyDOWqT/5R3SCIbtL8+JaLY37CP7ICxEsKlsPtV1iZdTOGoImAcAbGUbarDMS+TPd3OHuUc9pGEkp3mZpkdcCl0IE/bhtgwJ6Q9q8T6DhgnMOLUpxhXsTSircTZg/hl+wZLEi9Bc0H6g5WGCnEYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661792; c=relaxed/simple;
	bh=8NnbdJZI76H3onmh1RuzZmycgI6GufVe9LyBSQ7LuPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ohzw07WN8zsVj7CcChgN+eaOFd348hpvWcJrJHbQsywSQ5FbOOc9megxkBpzaDTCyCPcoVXgJ1D67Gm1nGhxfjb1mxSTlpFNR3OmByB++tDWSU9OypIRu9ZggTQNte5x2/q45BcqSAZsFZ/Iq4mN3cRyFc5apZlXPwRVLKX7kpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSfPdx6J; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSfPdx6J"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc2540a4c26so501289276.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 02:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705661790; x=1706266590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Pow81wnVJpGaMN2X5nC5ouFPiMdz3bTSnEtWAmybYU=;
        b=nSfPdx6JO/dRsdZPoYc42GeFtaEEYduBYdi5EVNyCJoV4XVRo553mgTmwKLXuD5Vqa
         +DrOTKQ7RP2fepgP93Fe3o4/ZYb2Kx8Ov23sxFcPqWzdWj4nXZQYHeiA2xR1KqXDPCts
         1V8XFYgXe5dpOj91TLAsL2AB+dObBF9JKL/0xQZK1PfhFDowxea2lJmhF8YQll+1h8Hs
         lwM0fJkqqLFU8OjDItCPf1jINaPY6HAJqUbLPrSNI0H+MqPs+F3NIFcaqpyXtRUlxB0Z
         UIQCg+NAXPnMPcYiy/JXUUfBvjPsXb2+wV0N65+xuW8/F0VA8hj9x4aMg0YLBslM/syF
         LFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661790; x=1706266590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Pow81wnVJpGaMN2X5nC5ouFPiMdz3bTSnEtWAmybYU=;
        b=RLvQSLYBBhGdGFTFioEe3o5qCfPyW/EOeihUXpCE8BnUZADQRKiDg5kpg+aTJv4khx
         vU1lWKXrxRrGWjmpBHIcxiWgQcwRvrMwzOfRHwcx1yNHxPRHCTNgLJLl0CqTffmBwx3P
         NltBRmsesEmsN5BXglgHqu8o1CLWacHJULuc4j1gCGXPjSwQ3V76RNp4lbKRbqwp0hbQ
         4T+2k+cZHuv+S/gAPVzKcIxeA5wkf4i+NmdmdV5TjALe1h2WzoWymn73QuYqvqjoTFuq
         8HqtHEaMEZqaEmBpXgVEkNh/HtYSn5glz0+NFHFi5k3ybXHF+atbK3MOTfgQNEH8+lSS
         H3mA==
X-Gm-Message-State: AOJu0Yz1xIMhIAxYk/ojL4368ROHAikI4+seLk86q7YVYTTPkS62mJ3p
	pLio0DhtN0eq7lBaAHXuf+766Ni+gpW+/X3P+udiUIkBO9n1q3dNhJTEmVs0v69oY6enGJi8OjJ
	Hj7FvhhPxJokri56lHI7Cg0+0Mx0=
X-Google-Smtp-Source: AGHT+IFknDCgdUeienzFccWkeMMxYmRdXDzp0ttKCAKzW1WgMcxkaws8xOuKuCwj4D+eQCx6SgqPUm+QWwcytvCTqKE=
X-Received: by 2002:a25:187:0:b0:dc2:4cf0:e7c6 with SMTP id
 129-20020a250187000000b00dc24cf0e7c6mr1745211ybb.124.1705661790356; Fri, 19
 Jan 2024 02:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1696432593.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702562879.git.zhiyou.jx@alibaba-inc.com> <d343585cb5e696f521c2ee1dd6c0f0c2d86de113.1702562879.git.zhiyou.jx@alibaba-inc.com>
 <owlyy1cvhua5.fsf@fine.c.googlers.com> <CANYiYbFOa-E8Pivhgn_nmy982fn7VPtb803bewnC_UV7qY3xcw@mail.gmail.com>
 <owly1qaei8hw.fsf@fine.c.googlers.com>
In-Reply-To: <owly1qaei8hw.fsf@fine.c.googlers.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Fri, 19 Jan 2024 18:56:19 +0800
Message-ID: <CANYiYbGy-APMD7Cw=m-=8dkMcXCp9c+x_6OCoBhWBfvUUWm2ow@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] transport-helper: no connection restriction in connect_helper
To: Linus Arver <linusa@google.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 6:26=E2=80=AFAM Linus Arver <linusa@google.com> wro=
te:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> >> > Remove the restriction in the "connect_helper()" function and give t=
he
> >> > function "process_connect_service()" the opportunity to establish a
> >> > connection using ".connect" or ".stateless_connect" for protocol v2.=
 So
> >> > we can connect with a stateless-rpc and do something useful. E.g., i=
n a
> >> > later commit, implements remote archive for a repository over HTTP
> >> > protocol.
> >> >
> >> > Helped-by: Junio C Hamano <gitster@pobox.com>
> >> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >> > ---
> >> >  transport-helper.c | 2 --
> >> >  1 file changed, 2 deletions(-)
> >> >
> >> > diff --git a/transport-helper.c b/transport-helper.c
> >> > index 49811ef176..2e127d24a5 100644
> >> > --- a/transport-helper.c
> >> > +++ b/transport-helper.c
> >> > @@ -662,8 +662,6 @@ static int connect_helper(struct transport *tran=
sport, const char *name,
> >> >
> >> >       /* Get_helper so connect is inited. */
> >> >       get_helper(transport);
> >> > -     if (!data->connect)
> >> > -             die(_("operation not supported by protocol"));
> >>
> >> Should we still terminate early here if both data->connect and
> >> data->stateless_connect are not truthy? It would save a few CPU cycles=
,
> >> but even better, remain true to the the original intent of the code.
> >> Maybe there was a really good reason to terminate early here that we'r=
e
> >> not aware of?
> >>
> >
> > It's not necessary to check data->connect here, because it will
> > terminate if fail to connect by calling the function
> > "process_connect_service()".
>
> In the process_connect_service() we have
>
>     if (data->connect) {
>        ...
>     } else if (data->stateless_connect && ...) {
>        ...
>     }
>
>     strbuf_release(&cmdbuf);
>     return ret;
>
> and so if both data->connect and data->stateless_connect are false, that
> function could silently do nothing. IOW that function expects the
> connection type to be guaranteed to be set, so it makes sense to check
> for the correctness of this in the connect_helper().

If both data->connect and data->stateless_connect are false,
process_connect_service() will return 0 instead of making a connection
and returning 1. The return value will be checked in the function
connect_helper() as follows:

        if (!process_connect_service(transport, name, exec))
                die(_("can't connect to subservice %s"), name);

So I think it's not necessary to make double check in connect_helper().

>
> >> But also, what about the case where both are enabled? Should we print =
an
> >> error message? (Maybe this concern is outside the scope of this series=
?)
> >
> > In the function "process_connect_service()", we can see that "connect"
> > has a higher priority than "stateless-connect".
>
> What I mean is, does it make sense for connect_helper() to recognize
> invalid or possibly buggy states? IOW, is having both data->connect and
> data->stateless_connect enabled a bug? If we only ever set one or the
> other (we treat them as mutually exclusive) elsewhere in the codebase,
> and if we are doing the sort of "correctness" check in the
> connect_helper(), then it makes sense to detect that both are set and
> print an error or warning (as a programmer bug).

The best position to address the bug that both data->connect and
data->stateless_connect are enabled is in the function get_helper() as
below:

        } else if (!strcmp(capname, "connect")) {
                data->connect =3D 1;
        } else if (!strcmp(capname, "stateless-connect")) {
                data->stateless_connect =3D 1;
        }
        ... ...
        if (data->connect && data->stateless_connect)
                die("cannot have both connect and stateless_connect enabled=
");

I consider this change to be off-topic and it will not be introduced
in this series.

--
Jiang Xin
