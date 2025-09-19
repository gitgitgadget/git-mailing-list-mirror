Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D6E1DEFE8
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313488; cv=none; b=iGXyyCpcf24j9eIZ+tQcoGkYbiAE6ZVpE4QgCbtIj5rNchH8vZ/EaWUdt4L+Azlvp3NPpYBd3sdm+dRKESa/N+tbLQqn+MtFRrOtdqwr7cNVBwiFv51YgFx4lWUTEBd1YpoZa9PZQfdMIUdVfd549aA/oLvv8RpSUIRZKpQOihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313488; c=relaxed/simple;
	bh=OPBSRRF5fpsJ9tlB2/XejnaMW4XiE7ExPa+somEI7v8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as9It5gHgbgI5ss7VfnZK+ywK5zIuARIzo2HhCj9UYGzWU6ujXDC6aJnePOcrs2mwlWvhXioXInpzCs76dT3r1UwPsArLdb5AxavlIRLdO5M5N63TiW5fFQsqIyr8128Jf3b/GTlHU5AfSMOU/Pdkf+8VHpTuQI+OzZcGBC+TsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+tJKPM+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+tJKPM+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-745ade243edso2511876d6.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758313485; x=1758918285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqHyP3mugcJt7T9Kocp7IYJZ0N/g27l1cUHYoghhCoE=;
        b=h+tJKPM+CYG8Vqje3U3u/KksomMsFfmOcJbQADgk7Q+sM1dVkiNmUSY/qN4/6wxu0s
         sHbvtg6czUtUP8MFb2GBe37pwpHUGcFVqWHIO2rzy0pU3jJ406fnB1ACxIh/ga2DIq62
         lNsezDTDpYttQMYPKrKwviqsV+EK4+XlIyQE7TiKWjDR2Mc6RC9lIpCQQiR6yn8lUKBf
         KDGsuMXQPARtg+NNm0bQp6Q7JsALbHjMwy9FlWK3ubvLlJlU5CUt20p1xoFtR68Jchpm
         ljG1sc+hTJU5G+0UHZ1JO0h6G2Drp0ZlsqxAbwEm7IkTKjQRiPBxYOXs/nuv2SSnDHXF
         hbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758313485; x=1758918285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqHyP3mugcJt7T9Kocp7IYJZ0N/g27l1cUHYoghhCoE=;
        b=XbzGty7WtFyvjdM5o+Php1qKOcAjxzPHs/Z4OuHVgQarOg7qYKCDtrHjgL8vJuIGWp
         uw8iXSmdrSngnwkcRLWiSWzMiZstCpZwvNqIJ9JPj02CZX0GmmUEYy2RjPcfCJAQQMDf
         +oQqdsVnAp0Kw1paMkVqw7We5HGu+N6eDK4RK9l5fvXE3EwlmLvGF7QsM//D9KFnTSvX
         xiNRAQzwYfeOBaxhJYr8rTA2vgsI5t8XhH3WTeU2+gtmMDqraQkbL9AMcsDXp2C4eXZu
         pkB2LqjLtIKuVstMLVW3tw/mkl7QvSmytoQLYtDOLRDlunysFWjdOfrglmYguDdHUOWG
         84mg==
X-Forwarded-Encrypted: i=1; AJvYcCWcgdJEnyLJiL+TpzarvjsTAvdCg5r88gYFLjXd5JMl08+nkRXmnx43MRUOSIYnBzED5sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXN+Av95dk6RkG/cWWMABhgK07RZyl7T1qapQQXf0NLFM+F+p
	VGWs6egTtCyxg+uE//G+4zEuSnqYom6HAP9iu6qDlxfiy769O3woMvJznEowRXW0kpiPNyoTtM7
	05GVWDS0eOuGnrRsCoyvqw3U4oWukY5Us495P
X-Gm-Gg: ASbGncuzlKpG29l0NZakABOTsBwdwTjRBeWhmRTwu95ky8Zam1SuClvEgVsunVUkpRw
	DhP0luhnQABhifH4UWTozy102a0era2u+2EI5x+gGgXyQ4tp24b/7w3I2bKrQIud4u131zKoMGL
	lBv/T9a3lc+weWTomNizPNSNYXt0NiJY8iT+yLbKVBCpt6I0Ohyz9B/1h65yxSRGUUYX3/j7txJ
	FgeAeErDpTEGvoixCbsGvdMKczL+/182gGfWsA=
X-Google-Smtp-Source: AGHT+IHDWWZt1Ruau+i0qxNdVgb1EAw4dlbBEaulPduU3fpD8EiR3inS/6lnCsWP5uPz9mpEB1ywDVNsnzi2MgAanrQ=
X-Received: by 2002:a05:6214:518b:b0:70d:e7e1:840f with SMTP id
 6a1803df08f44-79919416e71mr34460126d6.3.1758313485298; Fri, 19 Sep 2025
 13:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com> <CAH=ZcbBBkk2B3PxKf54MRnAmURMK8W7ofFZBRS=ZzkuDNWsY9w@mail.gmail.com>
In-Reply-To: <CAH=ZcbBBkk2B3PxKf54MRnAmURMK8W7ofFZBRS=ZzkuDNWsY9w@mail.gmail.com>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Fri, 19 Sep 2025 16:24:34 -0400
X-Gm-Features: AS18NWCUtIq5lJ-j1HnNb1lmF0PjwUuAQKh75zXA4-W5PRGqt60a5YzjXqnk2Xg
Message-ID: <CAPig+cSBEX5QGnzpBnVs_hKM2iUqcmA4-DzKDgkwpG9ZzWZ__w@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] build: introduce rust
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:11=E2=80=AFPM Ezekiel Newren <ezekielnewren@gmail=
.com> wrote:
> On Wed, Sep 17, 2025 at 2:26=E2=80=AFAM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > Is ".idea" directory detritus from your chosen editor? If so, it
> > probably ought not be added to this list since we don't otherwise
> > ignore detritus from foreign tools such as that.
>
> Yes. I use the Jetbrains IDE's CLion and RustRover for C and Rust
> respectively. Jetbrains has an IDE for MANY languages and all of them
> use .idea/ as the folder for IDE specific configuration. I'm fine with
> keeping it out of .gitignore, but I wanted to know what the community
> thought. [...]

There is a bit of discussion about this later in this same email
thread. If the project does ultimately decide to accept these
.gitignore entries, adding them would be done via a patch or series of
patches specifically aimed at that goal. Hence, I'd recommend omitting
the ".idea" entry from this particular patch series.

> > > +if rustup show active-toolchain | grep windows-msvc; then
> > > +  libfile=3D"${crate}.lib"
> > > +  PATH=3D"$(echo $PATH | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr=
/bin)$" | paste -sd: -):/mingw64/bin:/usr/bin"
> > > +fi
> >
> > Please add either an in-code comment or a sentence/paragraph to the
> > commit message explaining why this PATH munging is needed.
>
> I will amend the commit with something like:
> On windows when building with msvc using shell scripts it looks for
> link in /mingw64/bin|/usr/bin when it actually needs to look somewhere
> else for the msvc linker program. Since removing these from PATH would
> break everything else in the shell; move them to be at the end of
> PATH.

I had to read and reread this several times but I think I get what it
is saying. To paraphrase your explanation...

When building with `cargo` (I presume), and it comes time to link the
program, the build process is looking for the Microsoft linker named
LINK.exe but, due to PATH order, is instead finding the Unix command
`link` (which is a specialized invocation of the more common `ln`
command). As such, the build process incorrectly invokes the Unix
`link` rather than the Microsoft LINK.exe and fails. To work around
this problem, you move the standard Unix command-containing paths to
the end of PATH so that the Microsoft LINK.exe is found first.

...does that sound correct?
