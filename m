Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6679F6
	for <git@vger.kernel.org>; Sun, 26 May 2024 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716705284; cv=none; b=YzFf1DjhV43xoj9m6NTW6hZJy8JHK1J3+Kro+D94BkChSPTK3GruFuE58rWDBkqIu/fsHbh1pldpDfiTjvWnXXTGc4JzyXbWR/7/k55sBbhY2aXQy3A+S/HdpHSJZHcVFw6dwVJjc5JTFVqItG5ME7pWTvnUoPf7OOEgJxl9lIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716705284; c=relaxed/simple;
	bh=JJSdmKSwXR3b5cq4gSXM6N96go6DYMSDdNOfZEHvIEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dedUh4k4rRoBqJWxgcJPWygrcqooJDjWhvWSVbGFyafkc7HWF9whFkEzxl+V+jTPD9BBUkztS/1n7aRDqHtnXuvIAkSR0AVVnJjE2VB2PPlY+iTU5n80peLcL4L6R400H0R2kQcP8XvJcMHNt7YL52vteE3d4ba9iXBayldeEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1iOWSuE; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1iOWSuE"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7fe97255d03so1769402241.0
        for <git@vger.kernel.org>; Sat, 25 May 2024 23:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716705281; x=1717310081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZaauq+2JVZs38t6B8XkGVYdzq0by0ueviR+iHtNyJE=;
        b=i1iOWSuE4RAxpAk5ub7Foc9ODS5QeCZXjgANs4LC2kZUytN76l9eWxyPQWplA7gRsN
         KLGK3K85ZE01QhAsnXlv4Wry0NW1cD3Gz+yE2hyDpnN1/BTNLdI1UqI3o9bNG/rY5ybo
         3xXn75Z8HL/RoOt84cTdPejjIp9MYTzhO3txFihfIQTPu26pSsm01qRU6y+yfgZzuMNA
         svrPEjkqwQwURtn2vviUNXmKzyyVqaRgPucndoti2NY/I/uTrlWDGTWu+HKKnEilfZVN
         zTv4e82YEzIbAFJ+NqoiXhJkeMGoHkGXyo1DezJUZ+uDZ4NKK3C5myxSZy6R8ib3GPoD
         TF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716705281; x=1717310081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZaauq+2JVZs38t6B8XkGVYdzq0by0ueviR+iHtNyJE=;
        b=dyez0fTBNQQi/BZxxyZhihtTVa0+RfYZNWbsDAKeYULGRsN7EWYULrQlVAlf7zfl79
         qAX3CF2sG3sTAErhpOxhwjlcW9CJHZfSYs+jwgaSoAL05UPBOlKWxiOQ5P4K4ggz0rDs
         uZMHFTeZ2y4aox20putyzugjRspGH/TKiElDw2c/L1rUjnwXRHTbyB1iK7EgS6A8kM2J
         ubagHhtopr+KlIVXGH5AGUKsa/7FAyX5o3r01zBvFoIrKRI0TE4kLJvwh0WL6H/wqRfx
         6A/kk2/E7c/omO7iCVp+JbZqLETiWsN39dLJtt5lr4vWuuByktU/ZbWgM2lFm/DBTouh
         K75w==
X-Forwarded-Encrypted: i=1; AJvYcCUJj6EHDJYylq1LcHcUVz9Mp4JBP9Sy4dj1bu+Zu9WUcRAn+xHkjWEr5gKpfiL6LrC6ujYWRUmfJxIYBfWV/ZMuIc/Q
X-Gm-Message-State: AOJu0YwEBaF8FBjPQqUKh1Bo0GwAUdi9QewzYGzt5po5gzra+9wJWev1
	vb9Ddj5S5nM8pNMyAAcS2v4f+BK5hzJCUJ8PbD5zKk1yuVwC+KIguFJUjfzZ0JNG+IOQHw1YT68
	DHpFE700I0YVHTJy6htMNKCzRCl4=
X-Google-Smtp-Source: AGHT+IFZebLqD2wjiEQ+O3i91NuB/NNCFM74tFcTIu0h2h29fbWgNZl2btmxSLJFXFk4ba2/uBGJavhu5LtmVhJSeQM=
X-Received: by 2002:a05:6102:510e:b0:48a:3550:a0cc with SMTP id
 ada2fe7eead31-48a38513915mr8114325137.2.1716705281240; Sat, 25 May 2024
 23:34:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net> <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net> <Zj8blb0QqC2zdOAC@framework>
 <ZkX9w6etjDVAh-ln@tanuki> <20240517081132.GA1517321@coredump.intra.peff.net>
 <ZkcUcPhrTrbSbZO8@tanuki> <Zkc_zJGjwg0fZkRG@tanuki>
In-Reply-To: <Zkc_zJGjwg0fZkRG@tanuki>
From: Philip <philip.c.peterson@gmail.com>
Date: Sun, 26 May 2024 02:34:05 -0400
Message-ID: <CAJ6X7_VSswj6pw2gyfEp=Hmx237MJEJA4bW+QkKNs88iRf=Hwg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Part of the problem seems to be that the Github actions runner has a bug
on OSX: https://github.com/actions/runner/issues/884

Based on investigating this for a while by setting up a self-hosted actions
runner, it seems to have to do with a broken pipe triggering incomplete
output capture / termination detection by either Github Action Runner (
see issue thread) or maybe even Dotnet Core's
System.Diagnostics.Process functionality.

As for the actual failing test, t9211, what I got on my machine was a
failure during clone: `unknown repository extension found: refstorage`.
In the trash directory, the .git/config did specify that extension.
Perhaps some interference coming from
t9500-gitweb-standalone-no-errors.sh, since it invokes:

> git config extensions.refstorage "$refstorage"

Cheers,
Phil

On Fri, May 17, 2024 at 7:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, May 17, 2024 at 10:25:20AM +0200, Patrick Steinhardt wrote:
> > On Fri, May 17, 2024 at 04:11:32AM -0400, Jeff King wrote:
> > > On Thu, May 16, 2024 at 02:36:19PM +0200, Patrick Steinhardt wrote:
> > [snip]
> > > One can guess that scalar is in waitpid() waiting for git-fetch. But
> > > what's fetch waiting on? The other side of upload-pack is dead.
> > > According to lsof, it does have a unix socket open to fsmonitor. So
> > > maybe it's trying to read there?
> >
> > That was also my guess. I tried whether disabling fsmonitor via
> > `core.fsmonitor=3Dfalse` helps, but that did not seem to be the case.
> > Either because it didn't have the desired effect, or because the root
> > cause is not fsmonitor. No idea which of both it is.
>
> The root cause actually is the fsmonitor. I was using your tmate hack to
> SSH into one of the failed jobs, and there had been 7 instances of the
> fsmonitor lurking. After killing all of them the job got unstuck and ran
> to completion.
>
> The reason why setting `core.fsmonitor=3Dfalse` is ineffective is because
> in "scalar.c" we always configure `core.fsmonitor=3Dtrue` in the repo
> config and thus override the setting. I was checking whether it would
> make sense to defer enabling the fsmonitor until after the fetch and
> checkout have concluded. But funny enough, the below patch caused the
> pipeline to now hang deterministically.
>
> Puzzled.
>
> Patrick
>
> diff --git a/scalar.c b/scalar.c
> index 7234049a1b..67f85c7adc 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -178,13 +178,6 @@ static int set_recommended_config(int reconfigure)
>                      config[i].key, config[i].value);
>     }
>
> -       if (have_fsmonitor_support()) {
> -               struct scalar_config fsmonitor =3D { "core.fsmonitor", "t=
rue" };
> -               if (set_scalar_config(&fsmonitor, reconfigure))
> -                       return error(_("could not configure %s=3D%s"),
> -                                    fsmonitor.key, fsmonitor.value);
> -       }
> -
>     /*
>      * The `log.excludeDecoration` setting is special because it allows
>      * for multiple values.
> @@ -539,6 +532,13 @@ static int cmd_clone(int argc, const char **argv)
>     if (res)
>         goto cleanup;
>
> +       if (have_fsmonitor_support()) {
> +               struct scalar_config fsmonitor =3D { "core.fsmonitor", "t=
rue" };
> +               if (set_scalar_config(&fsmonitor, 0))
> +                       return error(_("could not configure %s=3D%s"),
> +                                    fsmonitor.key, fsmonitor.value);
> +       }
> +
>     res =3D register_dir();
>
>  cleanup:
