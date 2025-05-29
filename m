Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859D24E4B4
	for <git@vger.kernel.org>; Thu, 29 May 2025 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492617; cv=none; b=sJiFIhEWnotz4++rs6eelKrodZqLC+0kWRmVQnJaxJAjoefNYOv81td+PLd3zeWOJFhySK3RoGCGLnCBnXmw2T64WYIGuSfrkJIv5FklrXt06hDEGZGMJ+wY3d27tMeH8DGpLlRiriwSpykYFdYDO9oCYq9l2sAcvIi35IAHPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492617; c=relaxed/simple;
	bh=HXcD/szjizvWOTRpA5CHiRUb1s3+W5D7F8OExaFMwlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeljJz+Dav6YRIftuGxcSV0vLw58X7/l35KvBCSQOlX7LMqaTB1rjOkBMWwS9cmeirDo7T6jxwpxWP8EohrwwVyTM84gPtpOFHmCdoDE3vohIjSTHgK/nPm7GQFgc9tpPP2RkcKDTbd20QTuZaGW/3AQtns1pk9BFJVMQC3HhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvR2idpD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvR2idpD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476b89782c3so5908971cf.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748492615; x=1749097415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKe9MG3t4Epb5QGOcD+ceqm+AvwCVrBfx30ryv464r8=;
        b=WvR2idpDg9URJcAjTKHFF/vqWx+WmZcJuab0AUDRQLPQXKizkOqZsPTR9lUyg20+eI
         +iBK5Ghn8kqGsiPXJOdEFNOiti5RnvsgW51ZG+kD/XxEy/XHC50Z7kje70dZJ94vngDo
         yRZ4nG17Qf/xbSUDMPFswTP/qTo0l1t0wame0LIMgfty78aLfwQs9pozk/9RR+zZrf89
         2MHeKP1w33kngpYDtXjSWpmr6mb14bwnU4fgw6ccu9sLOtMbSpqgTb6ESque5ymWhiWR
         C1YLC0c7vCFUiRewx38RkI/yRbRCMH0KRRgYGT/bU05y6HjsyqImsjWZQuwT1HoRyJIq
         lqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748492615; x=1749097415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKe9MG3t4Epb5QGOcD+ceqm+AvwCVrBfx30ryv464r8=;
        b=ZGxtaUOvh2XJAuuNMFuPqwNG/DctiYQyF0Ano9N8HnFNAf7B0XMUpLPwEjG3dCTkBY
         MyFPgTgqPI0suIOcTY11/v2npyPVOtvgiZM9MyquzuNshslHjmWUAPD6888C01/ZOWW7
         srI3mOexLB5MCJi6noZ8HHUtwdVCZ0N5eAUS8jyh/LkK5LUD7P8CdMv4M1AkcS4w6kjC
         fWS3RDwqsaxgoROw6eRFggLwKvZ4d51mS9LVhr8DQCzSXbEVs0CFCVbmtVg5rrESWgY/
         P70t1K71O9EN6wf0Tgkj2eywgeuo/ETQ0jCT7ygx101QmB5lJJS+joc8ZykjZ4H3HGIQ
         cjqA==
X-Gm-Message-State: AOJu0YzoZThyzzntd+bxmIXkOJ+F/HWIU6D7JS/BuMKEAgquB7djRtcm
	pPxjYwNSQmXgIWVuUSLAlJ2tPpZj8wqbKrdT/wTW5NRw8cbL1CvFbrSbMm/VmIc/lsnymTJpDF7
	BMvGngc9c7L+Lse7EMjvk8tg/WEwVcfonBEk2UyI=
X-Gm-Gg: ASbGncsnSyQO0OZ1pAeIykoBgM5agm37pPS8TvNhZ8NAHCa2OfewkpZ5JMdoR8ioXhs
	HCK0i8DJp8qFL3qHlXwchoqny5WICO+jBJYjFC7CJqiWiiPvEeXEHuA/4nkquYMjmT/0BRdy9Sg
	EcajH1IP7ogXHQ5Je8DRl8CxdN+qdbRnPl9eR7KmCJFWQuV5AmoRKQhgkiH76pNcF+
X-Google-Smtp-Source: AGHT+IEkIgPcRinyG5UxeOTWNSG3TDycfyvsrzHJWaYMW1ybOSFbr2oiNfQeaZ+723Mzh3N8awrubvcjpnlS0Yq1HaA=
X-Received: by 2002:a05:622a:248f:b0:479:2509:528a with SMTP id
 d75a77b69052e-4a38c4d7aa5mr77859691cf.42.1748492614839; Wed, 28 May 2025
 21:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524073628.58944-1-jayatheerthkulkarni2005@gmail.com>
 <20250524073628.58944-3-jayatheerthkulkarni2005@gmail.com> <xmqqcyburu6z.fsf@gitster.g>
In-Reply-To: <xmqqcyburu6z.fsf@gitster.g>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Thu, 29 May 2025 09:53:23 +0530
X-Gm-Features: AX0GCFvtJcVQlWPHuMTlzBOJ-PvicZf42KUgv0uJFt4HZ4IhgovTFh86cPC6KF4
Message-ID: <CA+rGoLfpj2tepMSWLfNeVkwXfzHZB7Vc8_GJ+_=bWkQSzZ+Sjg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] submodule: skip redundant active entries when
 pattern covers path
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 8:12=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > configure_added_submodule always writes an explicit submodule.<name>.ac=
tive
> > entry, even when the new path is already matched by submodule.active
> > patterns. This leads to unnecessary and cluttered configuration.
>
> It might be less cluttered but is it a good thing?
>
> Earlier, if submodule.active were b* (as documented in the "git help
> submodules") and then you added submodule "baz", your "baz" would be
> kept active even after you reconfigured submodule.active to another
> pattern.  With this change, that is no longer true, which to existing
> users is a change in behaviour, and to some it may appear a regression.
>
> According to that documentation, presense of submodule.<name>.url is
> also a signal that the submodule is activated.  If we are going to
> omit setting .active because its path matches submodule.active,
> shouldn't we also be checking if .url exists and omit setting
> .active as well?
>
> > Introduce a single helper to centralize wildmatch-based pattern lookup.
> > In configure_added_submodule, wrap the active-entry write in a conditio=
nal
> > that only fires when that helper reports no existing pattern covers the
> > submodule=E2=80=99s path.
>
> The new helper is a maintenance burden to keep in sync with
> submodule.c:is_tree_submodule_active(); if we really want to go this
> route, the patch should extract that "ah, submodule.active is set so
> let's turn it into pathspec and see if the path matches" part of the
> logic to make sure the logic is shared.  But I am wondering if we
> can do this without any new helper.
>

I've actually done something like this, but I've wrapped the core logic wit=
hin
the if else after checking [1]

> > @@ -3370,17 +3390,7 @@ static void configure_added_submodule(struct add=
_data *add_data)
> >        * is_submodule_active(), since that function needs to find
> >        * out the value of "submodule.active" again anyway.
> >        */
> > -     if (!git_config_get("submodule.active")) {
> > -             /*
> > -              * If the submodule being added isn't already covered by =
the
> > -              * current configured pathspec, set the submodule's activ=
e flag
> > -              */
> > -             if (!is_submodule_active(the_repository, add_data->sm_pat=
h)) {
> > -                     key =3D xstrfmt("submodule.%s.active", add_data->=
sm_name);
> > -                     git_config_set_gently(key, "true");
> > -                     free(key);
> > -             }
> > -     } else {
> > +     if (!submodule_active_matches_path(add_data->sm_path)) {
>
> I.e.  Can we replace this if() condition with something like this?
>
>         /*
>          * Explicitly set 'submodule.<name>.active' only if it is not
>          * 'active' due to other reasons.
>          */
>         if (!is_submodule_active(the_repository, add_data->sm_path)) {
>
> That is, we ask if the submodule is already active (we are before
> adding submodule.<name>.active for this thing---if may be active due
> to submodule.active or submodule.<name>.url) and enter the block
> only when it is not yet.
>
> That way, this codepath does not have to worry about the exact logic
> that determines if a submodule is 'active' even when its .active
> configuration variable is not set.
>
> >               key =3D xstrfmt("submodule.%s.active", add_data->sm_name)=
;
> >               git_config_set_gently(key, "true");
> >               free(key);


I've done the exact thing in a bit different way
Should I add this in the second patch, because this passes the tests too
including the new one created.

1- https://lore.kernel.org/git/20250518075436.75139-1-jayatheerthkulkarni20=
05@gmail.com/
