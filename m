Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B786341
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786606694; cv=none; b=Zh/OFK5O7VLDo7VZU+zeync1AR37tXAURQOCJeR4dQQiXB2MF2FrIQM/3KkFZx0/j8OfmH/eX4Mx9eLVheRIpdwlqUGfDin6yG6pQGzDgvUgGGFPJrip9zbnUOt9T9c1kRGxel3rQyAAJL6R/2aQkiTL7vzEzzPY6w0KcJ8Rctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786606694; c=relaxed/simple;
	bh=oweRJvxGjUcdGQfQItDRBrZJ1gg1O3jKbIq0JawqVGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzAAhgWhW08sMezmaCvP82C1kPhnUTOVXXepdp7X4J/pY76iYoRdbtJe28dhOGhe4HKInZTSsc0KMnBrFlT2c9cdHDoYYUPlZbc6PAvAVb74iA1/UiAQYoKM/yDWz5yrfZB7g/9PChcyTLw39VHR+AvzlJIwshDy/G+5vTPJe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mxODwJQk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PlL/8zYf; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mxODwJQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PlL/8zYf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FEB51D00153;
	Thu, 13 Aug 2026 03:38:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 13 Aug 2026 03:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786606692;
	 x=1786693092; bh=4Bx7grcZNWr/liyQwAig0fMdxjN1LnqLoB7nki6klvA=; b=
	mxODwJQk9XffGbgYx1bY6fgZPZHU2xE4FxQI8gzaja9DLUQrIwDGL2fbYlXSHSl9
	Ru6KS/PpU1U6Phs+qFS7S2hdsroAfk5786u+TB0ezlLoS4kUqTaOKeT65XE3FsiM
	313IL/U4mbfFIx5rb2Ocy5k3XmHGcP4kKNpTZrWHefMBX8D/dIGM6Xnui8BjvxEu
	kaqC0svkYH31xk7nFcFgHhs2QK79NUanuuZFF7eDxld8pMcVfxK1OCkBFniVMKvF
	y9YIiJPxSHsxkRvS1InFzJWFm64akZSlhLNzLkrQupI4W27IBGmB6ftV+WebzAk5
	kiMGTPqt/E2fQqw6EhqTHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786606692; x=
	1786693092; bh=4Bx7grcZNWr/liyQwAig0fMdxjN1LnqLoB7nki6klvA=; b=P
	lL/8zYfsItG3ayYcYaYDzfTaJTsmfnIlKCd28Ko4qrZaq/WRhNvsIiO0SoRyDkQP
	BBXmxI+CINsf+bn9iuYDdpoMQpZqGPf+7n/j7Xl8Aqp/VXakjCYepZdMiALw3Uzi
	u/LsvwTlJwxX4pxkxxLRiWIp00/1N4bZ5EkE2Z2dur/SpLhM6VHwrw4m0r+bTsoi
	nbfK4zweDwhKI9fIEtEdIeVm2nep1vrCKpXWkQoOcrnHhenoW2noyTpN4uc017qf
	re1PzTzyGczPoleFldaPuqVxycMjn+h7DalSPLba2nRODuuY9mVlwbDu5dYsQ6pP
	rOsSqcx9ESxLH4RWWwS2Q==
X-ME-Sender: <xms:Y3R9ajwRePZ5h1w8tFK4pTDRGbxPlQSc5q8sBeiwqruhB_rSn7m2CQ>
    <xme:Y3R9aqU5VEr8-61WW-I21Y9lj0i5hiVSH5EccbmuFwY7WcrHIKb33cSuxxeA3M3Sx
    GXdXn4bXofEfHw87fQb7LL044P5PADUzoFcjMWH-goBwHptR1UkV7o>
X-ME-Received: <xmr:Y3R9ajiHTx8GI2sTSEe_tTcxVaQP67jTYHLDfDiXcQoCTYWOOR4xrX1NVTucvSKUhrYR3biWfKY2hoVn-sLBmITAkm1PZRUHq02RaVr3wJKm>
X-ME-Proxy-Cause: dmFkZTEOd4TLJRZGn0868rcFO3WwOV438UKJ2oP2jtFgO9v/BcPpQYM5ddGziyTGRWrIh7
    l/pTznse9VLtNQ7UkLLlapD2WkC2wTNjNWl96ebB3lwx0k9wAOW08Ch3AFeXiRCgDJUvRJ
    e+1VOEYqGr1KVKQzREzTpr/m+Ot3TwPIOIFY5gJ5maqdgEecVOR+HIWyLr7410SLaPEq2t
    ptjtQei2bMSWf9jobF5tQVFh0onhoWxb1gT7XzxK7oZSRZXZdbCctssa7Vd0P7g0UCODyv
    RDKqV58HFuNFS80MxRFV4rjFBk/6G3eZPDB6RUwbQKnSLI5/gzNd739qaZLitIb5TbTcGa
    t2zpQjQlBffsCFMMn5VQEIGTUpsoUrEjJkriC+LO3b7CGgX4pOC+sVh4XS4UfKHUlQk6A3
    GK9SRA/sFcixr+wSQTk2Y7ZigmSYotBZJAxJFPFYfH8VnTXQjQ3UL0ba1AdU0MHQ54CCIV
    fAeVYUJYMvNghfbvurr/UHRzUfqOyBm8Gdoy93cduzdnoc0WhGgbEJllExe7OXa3UWLBI+
    q7qElWrg200XiG/nBytQoWxv8ALI5ah+FWBi8Lyl6pyzyn0Z8JJKN4bkNX0avS+BUKcsi3
    eSHv45oXVrs35K+ux6DQmOCy7FP5OG3f/dcqutd28sIn00ajn0bfD1hfXPsw
X-ME-Proxy: <xmx:Y3R9aqAA4nRh2Fj2vTMnGIArsCILcC-DeDlmvfBpKh1K8Oo_oV1oOA>
    <xmx:Y3R9apuSiEwPx-cV03iJ3FqMrS616CkEPp2dOLFIoaG5xCj282Ri_A>
    <xmx:Y3R9auerebuf8m95BlBz6ELJHKbnLsUed-rh4_shjMr7nUss9FhVoA>
    <xmx:Y3R9au8L93DI3s1LnWCYWcGhXJMzOi-zsYxkmCDnmNy3biyYrryiwA>
    <xmx:ZHR9ajyYWFpKHVTNUttc8xA05nY1Oeaaoc4gSI5W7XJ-ZlQHr2MthYSg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 03:38:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6146096d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 07:38:09 +0000 (UTC)
Date: Thu, 13 Aug 2026 09:38:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] git: avoid segfault on "git --shallow-file" without a
 value
Message-ID: <an10XhFPo0nJWJIV@pks.im>
References: <20260811121446.2080190-1-christian.couder@gmail.com>
 <anxXbnuRt4I4uPdI@pks.im>
 <CAP8UFD1XMY6N3UD5FhK_oeQDX7banP1e0oKM1WHUPhPv_vzbsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1XMY6N3UD5FhK_oeQDX7banP1e0oKM1WHUPhPv_vzbsQ@mail.gmail.com>

On Wed, Aug 12, 2026 at 05:42:00PM +0200, Christian Couder wrote:
> On Wed, Aug 12, 2026 at 1:22 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Aug 11, 2026 at 02:14:46PM +0200, Christian Couder wrote:
> > > diff --git a/git.c b/git.c
> > > index e5f1811b6b..96df15b5cd 100644
> > > --- a/git.c
> > > +++ b/git.c
> > > @@ -304,11 +304,15 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
> > >                       if (envchanged)
> > >                               *envchanged = 1;
> > >               } else if (!strcmp(cmd, "--shallow-file")) {
> > > -                     (*argv)++;
> > > -                     (*argc)--;
> > > -                     setenv(GIT_SHALLOW_FILE_ENVIRONMENT, (*argv)[0], 1);
> > > +                     if (*argc < 2) {
> > > +                             fprintf(stderr, _("no file given for '%s' option\n" ), "--shallow-file");
> > > +                             usage(git_usage_string);
> >
> > Should we maybe condense this into a single line?
> >
> >     usage(_("no file given for '%s' option\n")), "--shallow-file")
> >
> > I think that also printing the usage string is only distracting and
> > doesn't really give the user a lot of extra context.
> 
> The goal of this patch is to fix the bug by using the same code as the
> other options that can be passed a value like "--git-dir",
> "--namespace", "--work-tree", and so on. Now all these options use the
> same pattern for the error message:
> 
> git grep -A3 'if (\*argc < 2)' git.c
> git.c:                  if (*argc < 2) {
> git.c-                          fprintf(stderr, _("no directory given
> for '%s' option\n" ), "--git-dir");
> git.c-                          usage(git_usage_string);
> git.c-                  }
> --
> git.c:                  if (*argc < 2) {
> git.c-                          fprintf(stderr, _("no namespace given
> for --namespace\n" ));
> git.c-                          usage(git_usage_string);
> git.c-                  }
> --
> git.c:                  if (*argc < 2) {
> git.c-                          fprintf(stderr, _("no directory given
> for '%s' option\n" ), "--work-tree");
> git.c-                          usage(git_usage_string);
> git.c-                  }
> --
> git.c:                  if (*argc < 2) {
> git.c-                          fprintf(stderr, _("-c expects a
> configuration string\n" ));
> git.c-                          usage(git_usage_string);
> git.c-                  }
> --
> git.c:                  if (*argc < 2) {
> git.c-                          fprintf(stderr, _("no config key given
> for --config-env\n" ));
> git.c-                          usage(git_usage_string);
> git.c-                  }
> --
> git.c:                  if (*argc < 2) {
> git.c-                          fprintf(stderr, _("no directory given
> for '%s' option\n" ), "-C");
> git.c-                          usage(git_usage_string);
> git.c-                  }
> --
> git.c:                  if (*argc < 2) {
> git.c-                          fprintf(stderr, _("no attribute source
> given for --attr-source\n" ));
> git.c-                          usage(git_usage_string);
> git.c-                  }
> 
> So I don't think it makes sense for "--shallow-file" to not be
> consistent with these other options.
> 
> I could perhaps add a patch to the series to convert all of these to
> something like what you suggest, but it could also be done in a
> separate patch series by someone else.
> 
> Anyway thanks for reviewing this patch.

No, I don't think that's really necessary. Given the existing usage I
think your patch looks sensible. Thanks!

Patrick
