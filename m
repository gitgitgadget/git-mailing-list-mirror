Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015A82D9EED
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787203498; cv=none; b=BL65W1uLh/q5RuiJYH5sb3yhFiwRXGP5OGzT9EK0CY90UUkBm8ygxo2tWoVE6PpLYZ5Hv9l2YXJW1mfd7ToKj+/8t3rCBQ3ZrcM1ETA6ts6uVEquJG2EPxB0UVPS475t3rmfK0HHPzEN+dWJA1HIP2zbZz+EW+F6MumGezj4Odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787203498; c=relaxed/simple;
	bh=rhhIyN255Bs1fdwVwYAuePCGb1KmW+hqFK+N5bht1hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvYk8GnAV+UOSGewuB4fY6JvJJPxrWOlffWgxcEYfnGj8GwZT0k0cJ1g6LPgV0lk/YXNMSkXK4d8YF3MkuDGBVWheclf3ptdfMcSv7dzsyHBO9etd69wst4Av6750Mr5h1k4yMr1eT72+FK+6xOmsQtXa2hhqSYz2tI1E70pdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pu+m9dyr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRZZXJfJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pu+m9dyr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRZZXJfJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E7472EC01EA;
	Thu, 20 Aug 2026 01:24:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 20 Aug 2026 01:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787203494;
	 x=1787289894; bh=nI86D/kVT0LsLayYKqIAJzfGDYs2jNhQUzOGxWKdX6Y=; b=
	Pu+m9dyrQo20xaap9VdPMKfF66V8rMjAO879rainrZUa3M4MDGhYhzr7Q2Hgx0OR
	i8sRkLLtIGZsi3KzwYMFWP/CqJMOivwMCzFA89e+uz0fwmDapTIl/6nJZ4lmBKyY
	adMpPD/cZnGdrtqCfX6v1A4b+00oNz/eXoqzHylI0WSekGqv37OhYN3EVbgi+VT1
	fh/wGtml8DwMk86BwlNp0rdCkUYMepC4YGOJd4j5V2VJVLGBAz6YI74PhU6j0ZWT
	Dl9uWfLpUE3I7apGjdXFDGGVPCvIM3kXRcadYdXB3aDGMXedX+xZogjX2kHybCJe
	HaHqu5Aydnyz4BPac4k0cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787203494; x=
	1787289894; bh=nI86D/kVT0LsLayYKqIAJzfGDYs2jNhQUzOGxWKdX6Y=; b=V
	RZZXJfJjldVW9VJAmJafJFPeRmoTHE5hh11+0dUl/pwZ6U9NwnBoty9ciAVJD1wh
	2kw+/LpjMrk9JX1D7e2osAaYSUirFhaPNbqP/jhCDqvxQx4itT5zB149kreDdgcN
	dFxFMurLfe1/87NLvUNA/FXHlMbyZa0qsOYm4WQqiNwAqzFqORRTS4tvt2p9xrIp
	42bt3OQINn5BQuBEFt3RUX8dqhSpk4BYTgzoGcfG63LL7jpDgOpFU5ywmZky4cSn
	fIyU1kRz/HOeSagja2EetcvptmlbcWZ8Zxj+fQ2b+kZOtUDk/kfHD+ABSsZeAZ91
	bAhbKVJcTL/iyU4H8GU2A==
X-ME-Sender: <xms:po-GaqQ6tAItBKdLoyfUhmynsP2bqCCXNxCVWYDEqCWeOq2YlRqbqQ>
    <xme:po-GaoOqX6PInnnTEddTu0Ez1y00ywuLZcA2CSkGx6MD4IZFgsWtS5hMtfw0txxLx
    aZ4INACFddBfpDgHMnbHkqCeqLVjZt2i9px40qCcEgyDbCbpBh40As>
X-ME-Received: <xmr:po-GaoS7njEQzy3om84LTDSrlpQMO015_ruj2w4oWtVkuSBGdQrt4jP-8N0-JoSvGQwz32MljbtYJ94O1ZZKJPo04-w1LSJbWOwhPn-VMw>
X-ME-Proxy-Cause: dmFkZTGEuUM5DUvtFJqvZXGl7VLFlN3XfYy9AGp7ekOpGH5jp3ipfAwlQWTM31lX61yq78
    Aq96IGi6ts3q/M/73Zzg8NbRV9iuRiPvmcfN7KtAnCqlDE6eqx0Eq4J1SfsXi57V4V0WZs
    0ZtCsB8V61opP/P+MvijzEk3U3RiXWdrZVEyepK7g3gyL9gyc83TaHLwnfRL4i7Benyfdz
    igXhoo75E9+MwlhLaTL7jvII1Lf33A2aj99E52pG/DIdKJT17dZ7vf2WYyvScdhit62hDc
    Gl6vshKOiDeMjB0lxbhzkZfOCeIhw1dtG3p3sHDxoGf1tdLAELg32XFcgo7EpeIwNlddh5
    v3diveKLvJFHEkcCvL4ofKziev2v783Somk/qF3kKQlcIu3QloZJaMaHfDBqey/rotSowZ
    stbR/D+p3w0ppf094CI4Q77cTXT2/s27id705OkMPw2otisnxcjUf+V7XHd3hFoq4QN8c9
    MbjS7RREYBPQ0cDE2vE7AB3h1VUlIDxJJn+p9rA0YUr4lOTWZB/RTcxwwNzXbSviSXfOS/
    OVlXOwo6oWvAOifJcgoGEL/tLoOB5Vuh2jau1DXa0kUk9F4vWnAVuoXxPzQCdVzOOR2Nne
    yYKGEL2NsRW/r0iEdT1NJ6vyPKbz6B/qRPmZG/A5UX1f5sn/1SK85QvvSyJw
X-ME-Proxy: <xmx:po-Gamg-NHk_rfSINPu-cNXENVK6RoLieQcjqa-8JGCx0f3c0FOwrg>
    <xmx:po-Gah8hYNKYBstSlHMQ4e1kQVCm2ZHhHfoUqTf-ybKxNL4LImdjUQ>
    <xmx:po-GatFqTGlWB22CgSpSyfJ5-7djuIQWb8_d0tzDVjXQ-iXsIlUrzg>
    <xmx:po-GaklF-zI3pNm-U8RMkPiI42Dj7cxowuQKBGiK6_gi59qn73uxAw>
    <xmx:po-GakYFmoy7H0OXkkdwGnn3RzqpST7MSgx3pqUCCBe82oFJEpgy64Vi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 01:24:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ab47885 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 05:24:50 +0000 (UTC)
Date: Thu, 20 Aug 2026 07:24:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v3 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <aoaPn0gaHIa9Utwu@pks.im>
References: <cover.1786103607.git.ben.knoble@gmail.com>
 <cover.1787065125.git.ben.knoble@gmail.com>
 <48fceb4b575ca39346cf2f59f621584a19049008.1787065125.git.ben.knoble@gmail.com>
 <aoVoJ3Ijoaj3u64e@pks.im>
 <CALnO6CDgfT+VXaBqSmStB8vNOwBpr5XMjvmxhMdc7v-ma-YwXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CDgfT+VXaBqSmStB8vNOwBpr5XMjvmxhMdc7v-ma-YwXg@mail.gmail.com>

On Wed, Aug 19, 2026 at 09:09:59AM -0400, D. Ben Knoble wrote:
> On Wed, Aug 19, 2026 at 4:24 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Aug 18, 2026 at 10:59:47AM -0400, D. Ben Knoble wrote:
> > > diff --git a/read-cache.c b/read-cache.c
> > > index 6c449f393d..31888f77ee 100644
> > > --- a/read-cache.c
> > > +++ b/read-cache.c
> > > @@ -353,12 +353,18 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
> > >  static int is_racy_stat(const struct index_state *istate,
> > >                       const struct stat_data *sd)
> > >  {
> > > +#ifndef NO_NSEC
> > > +     int use_nsec = repo_config_values(istate->repo)->use_nanosec;
> > > +#endif
> > > +
> > >       return (istate->timestamp.sec &&
> > > -#ifdef USE_NSEC
> > > -              /* nanosecond timestamped files can also be racy! */
> > > -             (istate->timestamp.sec < sd->sd_mtime.sec ||
> > > -              (istate->timestamp.sec == sd->sd_mtime.sec &&
> > > -               istate->timestamp.nsec <= sd->sd_mtime.nsec))
> > > +#ifndef NO_NSEC
> > > +             /* nanosecond timestamped files can also be racy! */
> > > +             use_nsec
> > > +             ? (istate->timestamp.sec < sd->sd_mtime.sec ||
> > > +                (istate->timestamp.sec == sd->sd_mtime.sec &&
> > > +                 istate->timestamp.nsec <= sd->sd_mtime.nsec))
> > > +             : istate->timestamp.sec <= sd->sd_mtime.sec
> > >  #else
> > >               istate->timestamp.sec <= sd->sd_mtime.sec
> > >  #endif
> >
> > I think this would be a bit more readable if we had a single NO_NSEC
> > block.
> 
> I'm not sure what "single block" means here, but I think the plan (see
> reply to Junio) is to make this more readable by not needing
> pre-processor directives at all.

That'd be quite welcome indeed. The less ifdeffery the bettery. :)

> > There's one more site in "builtin/update-index.c" where we mention
> > USE_NSEC that wasn't updated as part of this patch.
> 
> Oh, did I miss one? The only spot I saw in builtin/update-index.c that
> mentions USE_NSEC is a comment that I'm sure patch 3 updated. Maybe
> you were thinking of that, or maybe you know of something I left out?
> (That is, locally on this branch, "git grep USE_NSEC" returns one hit
> in Documentation/RelNotes/2.5.0.adoc.)

Oh, I guess I just missed it because I already trimmed context of this
mail. Never mind then.

Patrick
