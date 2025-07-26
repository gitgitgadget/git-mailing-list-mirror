Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D211DE885
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753566822; cv=none; b=kI4Ts3/R76B0cKJ2uXjr6JN2jYIYRp9y0P6Ankxs6dTtThkuTswrH+nHkOuj+eq3WB6VoJGAiGXRjX4vGpFc7qeqfOeGf33iKCfPapbzQsYG5i4dliQEVsm//UIKvDFjblUCyf8xsWLfBjfTj2R7a+jU0fbX+z69gyrwxYWz84c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753566822; c=relaxed/simple;
	bh=eM1/NG7HtpthLBeGNUeUPWHcj9eows3kCocnyXLM87Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/xeMEuHHd3xGzPD8lnqVVmoLEYWs7axOI38Srvk7Yeu5fV8HDNtJQa/x+DmsXwjJI4+NQhNtov1WyViC1pucdcGwy9fo87+gH6EyEj8zVshygZTPUrFZ3fZXRvxMW5xTEOWaHXs8kDVFVAtXEU8KRb9WGMN75pnHax6PttKdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4+5H2EN; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4+5H2EN"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e80d19c7ebso2189133137.3
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753566819; x=1754171619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx08C7grtr/oVkurOLTthgMb6aRQn/Q2O6yyNrVd4q8=;
        b=B4+5H2EN10/IJvssx8rNrVZKmGNMl9AqdyP1fSA7QHcxZgV8AFS2SIETn4OqIx/N5H
         gixoH9d8AiAwIsc46w/0MV71GCmKrSecITpK3GQxF4mYb2ltASUmP7WyHOfmHP2MnFQA
         dJbkH714ihp4Xl7sc3PneXovH/gG5Z/7ERrrCYjcyccHfST7p5ea/oaIIU1g0nJOBtGb
         1PoBt9tjumjMIfjF5YZEZUIYcHQyETUxOEUfKQ9dLlbaSdlVydGZOnBEPbZ9bU4EUjnK
         9WB5/A8Io02/LFauOjigrYsQ2eswRDPEeko/83USAAfyCIuisCaFNQf7GnEbWbwkyAlU
         M8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753566819; x=1754171619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx08C7grtr/oVkurOLTthgMb6aRQn/Q2O6yyNrVd4q8=;
        b=bcl3K9ztjDR0ONtc/iDdr4H6K3TzisuG9yo8Q0T3UiSYWnVPPJ+tjuZRYrRRzg2lSP
         3bv2jMD1lFsrP68n2Z19uihSpjQWNu/IUQjulXXu2qBs7EkkfxdDxPe9jW0wewdJHHE9
         BhqK61/s6w5ULNTVGHrvYsx9MriCCtrR1n9wlCjFNsHKV60z3cb+R1PyOuTNKtV6XvDw
         s+FxvSF5fjI9oYUrNQNz0qqbQCxYzsPw1yMEQRyauChY8Hcq51HxRXshGstBZbPaD5EJ
         i0kbpwlavzDr9f0cI63lWi9nIo7CkqEhqpkoU4XXqZ02j3w5qZsSs1ycW4W53Nq/2Da3
         fOvw==
X-Gm-Message-State: AOJu0YySPpDMupqVcg3hDzgWs5dx1/RLCDAZwqThemvWj1i0NKYM0f4x
	nW97ebG8GP+P3c0mVGRMCmp5WRiz4M33lMP3IBeFwipA0DHEbM1kqTqwjF515NeE/rpsMnLKtyQ
	B5lMjOUlzaaI69KJgB/SAIQxgMKYGbZNROpJzRCY=
X-Gm-Gg: ASbGncsvmml9gz3ecZDLi15sta640LyibLaJRwuh+w28VvxppXDsiORGwBLucpEN4zD
	mKJgEPl2B41oAcXUGJEnEJ5BHaGgi0I59TR592vPBU2wNOuP96vl40kWgGhuqEQ4Tt8I9+00554
	YtnLs8hD8YBZN1XXOEdzsrVtZ5WV2f664jNsZoKUZoRxmzjIUMAhre0Fx13b6Md4PR3BEaCdnax
	lhHWBQ=
X-Google-Smtp-Source: AGHT+IGWKns6D+EmcjcFLIiRG6bhRYPDPfZVqKxO9GdDCohEDs+gD4/LGJc0WSp0k8YkSfd0W6dFxROgN80fgYsanNY=
X-Received: by 2002:a05:6102:8012:b0:4f9:69a9:4ec6 with SMTP id
 ada2fe7eead31-4fa3ff072damr3125742137.26.1753566819439; Sat, 26 Jul 2025
 14:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
In-Reply-To: <CALnO6CCN0HUXJVYmvAJO3EoQQZzHVjE0P=g+AUc9c5Ti0Rcm2w@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 27 Jul 2025 03:23:28 +0530
X-Gm-Features: Ac12FXxyfgkLZz7oN-YDnTphsnQDiQt43XNU5j9IQS8CZZm8TsI4aM-aETK36Iw
Message-ID: <CAPSxiM9UiCHEwdOuGi0LLQesvEnSLK+eC8ZfTEVQ+cdYedwuXQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +do
> > +       cmd=3D${cmd%.*} # strip .sh, .perl, etc.
> > +       case "$cmd" in
> > +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon |=
 \
> > +       difftool--helper | filter-branch | fsck-objects | get-tar-commi=
t-id | \
> > +       http-backend | http-fetch | http-push | init-db | instaweb.sh |=
 \
> > +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
> > +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remot=
e-ftps | \
>
> Hm=E2=80=94if we strip the suffix with ${cmd%.*}, do we need a p4.py patt=
ern
> too? Actually, at first I wondered why we need to strip the suffix at
> all. My local Git produces only unsuffixed commands. But
> bin-wrappers/git produces both p4 and p4.py; request-pull and
> request-pull.sh; and several others. So I think stripping is probably
> right, just drop the .py pattern.
Noted and thanks.
>
> > +       remote-http | remote-https | replay | request-pull | send-email=
 | \
> > +       sh-i18n--envsubst | shell | show | stage | submodule | svn | \
> > +       upload-archive--writer | upload-pack | web--browse | whatchange=
d)
> > +               expect_outcome=3Dexpect_failure ;;
> > +       *)
> > +               expect_outcome=3Dexpect_success ;;
> > +       esac
> > +       test_$expect_outcome "'git $cmd -h' outside a repository" '
> > +               test_expect_code 129 nongit git $cmd -h >usage &&
> > +               echo "Hello" &&
>
> Woops! While basing some work on this branch, I spotted this "echo"=E2=80=
=94I
> assume it's leftover and didn't mean to be included here? Will drop
> locally for my own work.
>
Since you based your work on mine, does it mean I do not have to send
the updated patch ?
