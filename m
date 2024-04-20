Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB827702
	for <git@vger.kernel.org>; Sat, 20 Apr 2024 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713650313; cv=none; b=eDPxutJ14ljnGH2JwCWvDb+HqUfCvAm6D6uR4WTR9/4kwLIzfr2ACVCFm3oUICnUtSlsFKH9z//28vo2fq1kWcP1VMSsiYm2QNTfEC60oluHUGkOenuDtasBgQHc8g1AleZxl0LN82mUHTG9w4j4bJxncf0MjRA9q+OxEKIYI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713650313; c=relaxed/simple;
	bh=FdmQh9WjTEnhmqI9qfFAuoKuENbSj8YSaElg+MWWb1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/48nSQTHQIdKTXYCHGyMJiB0o/5EYYNAe/v4/XsdzioiI2r/oEzlwmhBxpVBSDMTKsuzKSdxbO7OuPiGe0SVbqxzlx5odaobzc7MgV8kLsfKL3WDkoIIijQeCWltPtdpcokjq+Bmsd3C8kUsiYwT0E4hNuomSvXd0F56YDrhAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ggm14DzI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ggm14DzI"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so3442353a12.3
        for <git@vger.kernel.org>; Sat, 20 Apr 2024 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713650310; x=1714255110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT+QGlT5+UuWsr+4PJjLNsvrXvx3RhtTTM28FGCd+Lg=;
        b=Ggm14DzItK/JSFdLzU18QBh9IJvIj/nHjZEI5wHwKlmt+fOUaf8+3zYARmrBY3INqb
         Mz4QRx7+SdVu7oD75KCWYlTYyTauqLTFABMNInvYUm8s59KrbHPYWkN6Pu/KEC+6IA+O
         aeTBs1dPyGC11N+JnHNIaNuV2ZdK6/3bm2XkpCBGjfwB0iMo5ZbL52UVxPnTV6P6uCKU
         qakIpERn2Hq+JGoNtTpT4HTO6PqiDKO6i71Pn39qaJGUl6KsiK43K7Upsdvhp+m8C8Y+
         YdCXUEyZVrl+MJrdggMc0Klrhqz0tJTABq9aNuIxEzYMvtAFhFDBouedlwk7HP5G6uRc
         jfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713650310; x=1714255110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT+QGlT5+UuWsr+4PJjLNsvrXvx3RhtTTM28FGCd+Lg=;
        b=bMHqDmSWReC2/0ra+2eHlmH0YyKHTmjsRbqX4i+YCJMEYV2h0w1GsA/nmNF/w1JoKr
         uXjbxi5WdegS9oJqdaWz140K18WXov3iPq3mQuCbIhg5rMSewazTOeZZYwHiCvshN8EM
         8Fbj6TIIA54oTA8x/RYL6zkKEgtuvr2xlekQIDp6zojj7Oxzu5e1nbyFhQwbxjJWbRLi
         ZvreMabFBW7miN//pI8tz7baYblFJytF6gJw9Zd4jBytAhvnwgx0boAWdd0cAR+tiopC
         rGqoYjn9x4WDfv3wbVGB6xWVCoOJk8AIWCo5f2DHwd3nxPAZcR4EXdIdxj3bNun3imR7
         Pghg==
X-Forwarded-Encrypted: i=1; AJvYcCWXmMWdIpndRyBPCEMVO9GHF9+7lmb9Sql1zHTBlihLwKWP4htWBMKvIyp+Rv3sTVeo7QvIuTNImxxAHoCmgG58xRpa
X-Gm-Message-State: AOJu0YytVapgaxJBvlm+9L/Ai4Zw3gJuPSjdYLpMGJf2LiuvJcTyLaG1
	Bnrq0IQMBFL4WfIxSitubBBAxt3kiPqroZ940FAMPfms0weFXiTJh7zreEgeXudUiz0JI9by+MZ
	92fvdtOaqe3044qP2BECplhGw3Xk=
X-Google-Smtp-Source: AGHT+IEQxaVwxt1tTIf7Vfr0dKpWSFJ6Mmm1WsLTWBomFm+rd0GXD+fpkGHmsextt7TNFRfiv9gnDEMTup5KHDqRRDA=
X-Received: by 2002:a17:906:f145:b0:a52:23b6:19c1 with SMTP id
 gw5-20020a170906f14500b00a5223b619c1mr3636433ejb.76.1713650309750; Sat, 20
 Apr 2024 14:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1446.git.git.1675239967804.gitgitgadget@gmail.com> <xmqqy1ph1esd.fsf@gitster.g>
In-Reply-To: <xmqqy1ph1esd.fsf@gitster.g>
From: Orgad Shaneh <orgads@gmail.com>
Date: Sun, 21 Apr 2024 00:58:18 +0300
Message-ID: <CAGHpTBKy9ABmHk32yKsj1C9d=OLZqSU8=ApduvpmyWqSAUjMQA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: fix inability to quit after closing another instance
To: Junio C Hamano <gitster@pobox.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org, 
	Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio/Yadav,

It's been more than a year since I opened a PR to git-gui upstream
(https://github.com/prati0100/git-gui/pull/91). I pinged several
times, but it looks like nobody's home.

Is it possible to accept it to git nevertheless? This is an annoying
issue, and the fix is trivial.

Thanks!

- Orgad


On Wed, Feb 1, 2023 at 7:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Orgad, thanks for a patch.
> Yadav, this came to git@vger.kernel.org, so I'm forwarding.
>
> cf. Documentation/SubmittingPatches
>
>     =3D=3D Subsystems with dedicated maintainers
>
>     Some parts of the system have dedicated maintainers with their own
>     repositories.
>
>     - `git-gui/` comes from git-gui project, maintained by Pratyush Yadav=
:
>
>             https://github.com/prati0100/git-gui.git
>
> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Orgad Shaneh <orgads@gmail.com>
> >
> > If you open 2 git gui instances in the same directory, then close one
> > of them and try to close the other, an error message pops up, saying:
> > 'error renaming ".git/GITGUI_BCK": no such file or directory', and it
> > is no longer possible to close the window ever.
> >
> > Fix by catching this error, and proceeding even if the file no longer
> > exists.
> >
> > Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> > ---
> >     git-gui: fix inability to quit after closing another instance
> >
> >     If you open 2 git gui instances in the same directory, then close o=
ne of
> >     them and try to close the other, an error message pops up, saying:
> >     'error renaming ".git/GITGUI_BCK": no such file or directory', and =
it is
> >     no longer possible to close the window ever.
> >
> >     Fix by catching this error, and proceeding even if the file no long=
er
> >     exists.
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
446%2Forgads%2Fgit-gui-no-quit-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1446=
/orgads/git-gui-no-quit-v1
> > Pull-Request: https://github.com/git/git/pull/1446
> >
> >  git-gui/git-gui.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> > index 201524c34ed..b00ee691e3b 100755
> > --- a/git-gui/git-gui.sh
> > +++ b/git-gui/git-gui.sh
> > @@ -2307,7 +2307,7 @@ proc do_quit {{rc {1}}} {
> >               #
> >               set save [gitdir GITGUI_MSG]
> >               if {$GITGUI_BCK_exists && ![$ui_comm edit modified]} {
> > -                     file rename -force [gitdir GITGUI_BCK] $save
> > +                     catch { file rename -force [gitdir GITGUI_BCK] $s=
ave }
> >                       set GITGUI_BCK_exists 0
> >               } elseif {[$ui_comm edit modified]} {
> >                       set msg [string trim [$ui_comm get 0.0 end]]
> >
> > base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
