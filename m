Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53C1B0F0A
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753910085; cv=none; b=BWfaJ3HeGsjhmwWb27nhLwSPnwjya4b1FIp4SKIBIHT34T71eUlfsOWLooxkCcudqE0m4E9oi2CLLJVmMwwKJsUiFMGAs/BEFKixZJ9lPqHSoefFFsh9sWUxJpHRjUZMb0z0RSmWmfl8jq5hu5Ouh+Dc08tq5KQcJPBocA4i7/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753910085; c=relaxed/simple;
	bh=ovG2XUoiL/amN0L0twTsCBGWno6NAI0LErbTJ8a4H/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQC0JLCuTB0Zx9yHzQ1RrC5wtsC1JARidgfNK/RVwYk8SgV8qDszdaiyYl9Kzxr6eI+tMlMIGA9rJ18WpPc0Z2B/a2b13s/lJp5htGKOHAXXgF8HwK3nQDfLCl1f5yUZmO1ONKB1I3PKT+PcbHbyhPVrzt1hkSrW9LsUY74CKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIlEj8j2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIlEj8j2"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so42076366b.2
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753910082; x=1754514882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSCkDEDgGyeTQvejX66eVwwbg9PM3XH0u/5jocsEx9A=;
        b=dIlEj8j25t/EVhNNIjAJig2rYQVR/oevmgUBBpzolFjyrlveOtjuSiSn1YlrxGy0d8
         4KH5kB1ClrcEMRetVvKhIqoOAJyxuf6YlgvzrEAeB2pO1Nqd3C5KlLq2AP/70x3KvEr2
         BxDPTX6fxCZnWCqGiIaE/1Oy17KBXFlrhESiawcJwhkksbfZ/p7Mi3ocbcsHeeATYHnS
         YG8xqfKkOQMmS2OV2VGnfquJjK5Ng+joKmEx22aazSZwWuX1B8V3C6xoXYlH89YQsoV6
         Ao12ked3clsFbLa1UcyjsBeGHGbHjaH3PrqJhv93mY06vlzPXXG3YAtEPfHO2g7bhSWw
         J8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753910082; x=1754514882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSCkDEDgGyeTQvejX66eVwwbg9PM3XH0u/5jocsEx9A=;
        b=U53Z8CmJc8PaiNFkW6nJpEOdlxLb4YvJjwQxJWfYrh6RVC0BzYLlf4uT3+QcavY7Rv
         i7CY3ptQaZFToVfOJYL9wI951wvJA65A7qM7qDTXUiCwWHOUCGoxi+PnUO7cHTJNt6jP
         9YJcpoKDSlxRjzlNOpJ4FOy6Cpgoz/TYbEvpI56qjWxTkIT0Ppg6el1iqeEH/3bymlFO
         E0KaX1+d/bZWvcxHsPkLDUVwPWZctu+EIjfH/CMH5kQzhGBNGBNiF4gsv7VOg0MnLnux
         EeMW/LpRthjo2iHgPMotKt2zCPn206gf+WIljgq2X+7TOnaMH+8oYYoki5mIRy1f6DAv
         xJSw==
X-Gm-Message-State: AOJu0YwJKI5p8ePYa+p4YLUViO5zPOkqsxpR6NDTtwsoUYLm3goLR6s1
	puqSU1pilkCxkTCWRtEsqN6y8vqzkAIGm2Pq/GdZQqeU5XxQiKRCEJUEt03y8cvisvtEZcBstbt
	l5Qx0TdIbfwwV+ql20VTZrPJUUe7kutQ=
X-Gm-Gg: ASbGncs+pvD724xx7w7Hd2S1sw/LaufvNDnNLnDbbkN9i0cYpdc+yu2uNFC78xcB6cx
	xhOFSBEJ2vAXhohK8ZcQW1Sej/oIl9lAqALGD2WUKXYzuKBiRm1oXm/StBKGmo7arv3uAOJpzw4
	scEa496KoWmORUkZuGrjfvyDEh9MfpAIvuz2PjFsXgTuWScX6n2hpOV9mCMU32USol8q92LW8yZ
	swIcuQrGW9hnncGDVjbNU/0fL0qznNyiaUvDY/qonbW0J9H0jH0
X-Google-Smtp-Source: AGHT+IF78ykg4igtXQS4FPrS7wOB+SGhFaIP8LTv3cVndigMI9qLNrKGHYK7sqshN71Tpsa7g4kTtTqFEr8ulxRmEK4=
X-Received: by 2002:a17:907:7b91:b0:ae8:476c:3b85 with SMTP id
 a640c23a62f3a-af8fd58c2d7mr425254366b.8.1753910082200; Wed, 30 Jul 2025
 14:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
 <CAPSxiM9UiCHEwdOuGi0LLQesvEnSLK+eC8ZfTEVQ+cdYedwuXQ@mail.gmail.com>
In-Reply-To: <CAPSxiM9UiCHEwdOuGi0LLQesvEnSLK+eC8ZfTEVQ+cdYedwuXQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 30 Jul 2025 17:14:31 -0400
X-Gm-Features: Ac12FXwrI6bkz5u9g2lfmX7L3ZQCZJPknoqMcJ6au64eBJuZYdZkVU0cIugRI1E
Message-ID: <CALnO6CCJZ+knJr+ANLfNievB3krirDWcnaM7u_KYBRTcfGDE5A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 5:53=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
> > > +       remote-http | remote-https | replay | request-pull | send-ema=
il | \
> > > +       sh-i18n--envsubst | shell | show | stage | submodule | svn | =
\
> > > +       upload-archive--writer | upload-pack | web--browse | whatchan=
ged)
> > > +               expect_outcome=3Dexpect_failure ;;
> > > +       *)
> > > +               expect_outcome=3Dexpect_success ;;
> > > +       esac
> > > +       test_$expect_outcome "'git $cmd -h' outside a repository" '
> > > +               test_expect_code 129 nongit git $cmd -h >usage &&
> > > +               echo "Hello" &&
> >
> > Woops! While basing some work on this branch, I spotted this "echo"=E2=
=80=94I
> > assume it's leftover and didn't mean to be included here? Will drop
> > locally for my own work.
> >
> Since you based your work on mine, does it mean I do not have to send
> the updated patch ?

That's more a question for Junio than me, but I'm comfortable rebasing
my work on top of updated versions of your branch=E2=80=94and I would prefe=
r
to keep iterations of this series separate from my own, heh.

Really I hope you'll squash my fixes in, and possibly a few others,
and send another version? For example:
- pickaxe is a failure because the message is about blame;
- show is a failure because the message is about log _and_ show;
- init-db is a failure because the message is about init;
- whatchanged is a failure because the message is about log/show.
Maybe these are "out of scope," which is fine=E2=80=94but I think they are
working as intended?

--=20
D. Ben Knoble
