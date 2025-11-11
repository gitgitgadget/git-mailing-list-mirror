Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6542853F7
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762887162; cv=none; b=NViU6b6CHee7TweVd4kKJucd81gRSfY/jf1hV48do+k4h5k44rzskJ6G1RdwD2KYoGf4pPAbOWCaz2N41z4irEjS9f/U2LwbX88kVH9+jfjGuloxx+WmQOnZ+rwVsstuVvNogIQ6U8TwfSngqZSnZMqBsDtQUHBbjpoj8AIIgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762887162; c=relaxed/simple;
	bh=bqBWCtx2YtgnFQ2oaFAvMFTlPEVdB+mJObqa974YrLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1fbGS1Qug9WmIpI0GogskKmGVAL3dvWY0kAm4qzjCafo/aWTGcQWW+nTeTnH5NgYWq/CX4dMVEpSSF2//DJRCrJo141k3rnWZYVVcMry8ayRWC1OvvA+JaD5bpt1ldTz/ShdyZDoR984s3NmQu46Q0oOeBoG/Fd7MA+9mWPVFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHobPN61; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHobPN61"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3437af844afso76174a91.0
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 10:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762887160; x=1763491960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmP8/CNDdQcIpve3bRLL5upRt5Yj+KphLlWkAzDktGQ=;
        b=JHobPN61CwWB5tfxPXvz8L5skKMLARSOdmp3QeZ0v18K6qj/XKphzzqumcwYeETOhv
         OBv/qn8/Ne6NMrXnfS3w2oGnb/rAFE/2YjWx3gPAtNSXH7aiNCNUu+gdHds9n07gheD8
         /qTw2QqVrM7vailnvBNmAkQS3SwS+NUPb6tOlAld4a5o5cSB849kWV6V3Nb5AedwP4Dr
         R/M0wkxsyyRIObvbnkihjXNM5J0T+WJ7uf/vpPmp0Qz/vWWmRgpB6CLr1e+6Heof+Txl
         sfy6M/gRgE30L3+2V8vcKY+8NsWzko5Y6ijXN/hGFC1NIDJ8c1Mwk2f3p6R8UQxDL0HM
         mXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762887160; x=1763491960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TmP8/CNDdQcIpve3bRLL5upRt5Yj+KphLlWkAzDktGQ=;
        b=Lc7ivnnZMKmQ7+SPgmNmKSXtr4Fp/LhCxcRDfxJQuKhm/L6qZvNbRNLy2P2VAzvGYf
         H5d3imf4wEgdK3HWSmDmX1RGBZCE22QIiJWd+cIdIxlQ9epUOjwatdxnkzymE0Xa+yaX
         pNWzjaoIesDOKy+Z8jI1CB6sidTm2/053hDd0RqV+giyd/iOQMv9xTkOJQAiXo3n19R6
         FM95bdFBrAo1YyZ1hXTa2xlfWvyChlJzI6Tk0+QHR25woCnhug3GeSbYFb03rdoAeuVj
         jF+JTOuMALIuAZ63Z/1S3jgleaniAeV+MCAbQP8C89mJWAFSQtgp1GvhVN5825PAGVty
         j82g==
X-Gm-Message-State: AOJu0YyWIduq0DLzKy5GVE2Fq5Ym36jMr8hb9gNDwLjTZg9Gk6g+nAhj
	ayK4GyxbQt1MJnWsq2IFhiKcS3WJZbPSt5fvvxn+/33U2RN6iKy0BJFqSk74kuZYMAjpN5Ho/s0
	2DtPVbkAQmz2xmPpZraDGU4FOzw72Cco=
X-Gm-Gg: ASbGnct7HXmnG8+/+PEjwnfnQDByStFpHM4JhJfaFD6O0MuiR34zd9cctaM6WblT8HT
	w+pZfei3kpbkUYH1/Ih9Gxqkkl4p+osm7eG3s/2Z0l6i5D1IQg0uDUxep2vBiI7aLRS6yHWo4z3
	RU9Cpf4XOL1TL8zxFGnCNyuwWHGgYCpgD2Ej+TpaSB3dcvj5p/1u29NTgXr+WZsb+BMBRlkse+u
	46n9UwZCxo5subWvqW2y9Va+f5FGrI22WNfw1SP+3/k8Keo0y9ZhnevvmcDqHGS/2y+ipmVfGxW
	jJ2TYz4=
X-Google-Smtp-Source: AGHT+IFrb5kdXh92xAqe0rsIiz7VqWrLDOjh4sjlipj3u90ghM6Bp1Wcw/68OPnRH1yH/WCLLpzhvihAo1DH//HX1ss=
X-Received: by 2002:a17:90b:51cd:b0:33b:cbb2:31ed with SMTP id
 98e67ed59e1d1-343ddcbbe8dmr537938a91.0.1762887159927; Tue, 11 Nov 2025
 10:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <385992f6020703558f0ba75a1be6c4f9dae08b83.1762264709.git.ben.knoble+github@gmail.com>
 <d6b86ed23e28c875b48fdc77095ace3f8ff4ee5d.1762820704.git.ben.knoble+github@gmail.com>
 <CAOLa=ZTViq=OYoMQNdvi3rV+iUucGZ4RN0c7X_Q0PEugaEqqJQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZTViq=OYoMQNdvi3rV+iUucGZ4RN0c7X_Q0PEugaEqqJQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 11 Nov 2025 13:52:27 -0500
X-Gm-Features: AWmQ_bl8NImH6x-CVC--BveRBZ0f98SCf1KYdf5H7ba8_QTNZvBOSlnwav_4aNo
Message-ID: <CALnO6CDwnSYr5bpSFNBTixa0dnJ3yDSy=fCRN19Aj4Ms=_mvPA@mail.gmail.com>
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Todd Zullinger <tmz@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 8:43=E2=80=AFAM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> [snip]
>
> > diff --git a/meson.build b/meson.build
> > index 2b763f7c53..1f95a06edb 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -768,13 +768,18 @@ if test_output_directory =3D=3D ''
> >    test_output_directory =3D meson.project_build_root() / 'test-output'
> >  endif
> >
> > +htmldir =3D get_option('htmldir')
> > +if htmldir =3D=3D ''
> > +  htmldir =3D get_option('datadir') / 'doc/git-doc'
> > +endif
> > +
> >  # These variables are used for building libgit.a.
> >  libgit_c_args =3D [
> >    '-DBINDIR=3D"' + get_option('bindir') + '"',
> >    '-DDEFAULT_GIT_TEMPLATE_DIR=3D"' + get_option('datadir') / 'git-core=
/templates' + '"',
> >    '-DFALLBACK_RUNTIME_PREFIX=3D"' + get_option('prefix') + '"',
> >    '-DGIT_HOST_CPU=3D"' + host_machine.cpu_family() + '"',
> > -  '-DGIT_HTML_PATH=3D"' + get_option('datadir') / 'doc/git-doc"',
> > +  '-DGIT_HTML_PATH=3D"' + htmldir + '"',
> >    '-DGIT_INFO_PATH=3D"' + get_option('infodir') + '"',
> >    '-DGIT_LOCALE_PATH=3D"' + get_option('localedir') + '"',
> >    '-DGIT_MAN_PATH=3D"' + get_option('mandir') + '"',
> > diff --git a/meson_options.txt b/meson_options.txt
> > index 143dee9237..e0be260ae1 100644
> > --- a/meson_options.txt
> > +++ b/meson_options.txt
> > @@ -1,4 +1,6 @@
> >  # Configuration for Git installation
> > +option('htmldir', type: 'string', value: '',
> > +  description: 'Directory to install HTML docs to. Defaults to <datadi=
r>/doc/git-doc')
> >  option('perllibdir', type: 'string', value: '',
> >    description: 'Directory to install perl lib to. Defaults to <datadir=
>/perl5')
>
> I guess meson doesn't allow recursive dependency for build options? I
> was hoping we could do `value: get_option('datadir') / 'doc/git-doc'`
> and remove the custom block which checks for empty value above.

The documentation [1] did not suggest that "default" could be
evaluated as an expression here, and I copied the pattern from
perllibdir [2]. If there's an alternative, I'm all ears.

[1]: https://mesonbuild.com/Build-options.html
[2]: https://github.com/git/git/blob/4badef0c3503dc29059d678abba7fac0f042bc=
84/meson.build#L1972-L1975

> Anyways the patch looks good.

Thanks!
