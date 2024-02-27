Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86A47E761
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022773; cv=none; b=p+MATMZw0UQNpzAAEwfs7gJP4yFRT30WArxy4TTtbEix2+GTYMRy62c3j6gumx1dHdnwKgcSnIaqSixzLLHqmClIHOv5JABBCPzM4vGh9qnJtageFoDIAHosA/ZEPP7ek5yC5+hAV2NBfUkAPVIcuZSUx+jVo2buCi5BHjZqI+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022773; c=relaxed/simple;
	bh=fQqX+rp7isDtnRdaQvrs94dTnVF/ZGktRTrP04Ovph4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2+pDFFQPDHItIqJAZSF60C+NhoqNmLZXjrCjkeCV+t4/yvcxkcNPSj0PM+/SigVq+NSZMJrbr6La34AL7K+zTtZxxIjYZE79igd1rf+clO/Ws6uzoJzhSd3TAwZbF42aXBI1p4iO9Kzq1ewFe4tbirrrrpsy/2F52VZws/QxQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=nCC663ms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E7wI3iYQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="nCC663ms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E7wI3iYQ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B2119138008B;
	Tue, 27 Feb 2024 03:32:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 03:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709022769;
	 x=1709109169; bh=V3+eOOe9i8PqZf4uzRCU1FDtRo8Hydrt/NSyw88+ETs=; b=
	nCC663msJd65qoTLUfZdtORqSfuAqcX1BAlMkQQlgbLZjFfg4LYjoDgITp4qSxR5
	sWbkZynQtPaXfvE7TRmsIPFdbFU8W6/cs3xUCt8CaYJTF2J8PAxQ/HiqcmkvIYaO
	YYkLgyYzod+uQ2bkud1eDBN+lhoNr2E5vSA6WJAZdCAxp/X9aY9fgbThGDhJDW9l
	/GY7sWCuDhMbEdBOGU/XnPy7y4YnraSYfBY2b6P73g23BGw81eRnl+4rPKP4aD7K
	c6MhgoCApgyTn26u6Y3AhB1vbdn5YcPXTMI91HAkn6/6ak1Ytxurj4oyFhGGzcLi
	DNVh50I3XQUT7p0DdOp7bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709022769; x=1709109169; bh=V3+eOOe9i8PqZf4uzRCU1FDtRo8H
	ydrt/NSyw88+ETs=; b=E7wI3iYQFPOauGtUZ3PBTN2bUF0mHWb63iKdHVfm8atw
	Pqeb3AYNg55wNyIrgbUfRgtbVMUCVroyLfelgkgqcd5HEjKAdJ9B/UWo1snFSwdV
	LfXDDP7mfGbljY4ni84Lep0gcBd1IdwL6UxLj3WGnUYzvS4gE3fAApN9NQYW/ReZ
	Ghgkvjcw1IjoA2obZD4BwEdYfc18yKn0r2NpqUZNi9H8R/NtnGu2d7euUqjlpNy/
	HGJbAD67aC9VLT/GcB4XgYT04ufH3yiz3B5to32XOAds6YMrnciSMrvX72A7sT5B
	Bu7No4XPw/m6yzdp9ziXdmTm1CZsQrSrpSopv9oOvg==
X-ME-Sender: <xms:MZ7dZRCb4rB-aMUc4J2C8tO9wHAkwv9sdw-tuDQRxI-XRvNZ-b9uUg>
    <xme:MZ7dZfiBggKfSxQp9CkqV2UWYbZ7JOjSsDOjoUXRo-q6LB6fEOb7zJrjviIFoRnqF
    _f0fBhN-CMwghcCfGw>
X-ME-Received: <xmr:MZ7dZcl-VioLmp8skhASi4jTNKoYwKgflZ3j68qaZOpA8QsXcm8IsVRWww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeflohhshhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhs
    hhhtrhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvghrnhepudeigeehieejuedvte
    dufeevtdejfeegueefgffhkefgleefteetledvtdfftefgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvg
    htthdrohhrgh
X-ME-Proxy: <xmx:MZ7dZbz96zCe24C2dIiKllYFEydAm6i2Mwi2X_xJ3EplPXphT7trgQ>
    <xmx:MZ7dZWS1BQg4mVrKBcJBjHSHzruJEMRTL9WFvlQHOPU2GE1_qxGhGg>
    <xmx:MZ7dZeavfPzqY2LWva_kuwHGynPTNjMMIQk0x44x6Y0G2taEjw1EIw>
    <xmx:MZ7dZReLpKSt7NyAfDDo0APW8bnXOj6dzb8JOoIboR-5xxEmT5ufwQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 03:32:49 -0500 (EST)
Date: Tue, 27 Feb 2024 00:32:47 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
Message-ID: <Zd2eLxPelxvP8FDk@localhost>
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
 <xmqqbk83nlw5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk83nlw5.fsf@gitster.g>

On Mon, Feb 26, 2024 at 10:03:22AM -0800, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > `git commit --cleanup=scissors -v` currently prints two scissors lines:
> > one at the start of the comment lines, and the other right before the
> > diff. This is redundant, and pushes the diff further down in the user's
> > editor than it needs to be.
> 
> Interesting discovery.
> 
> > diff --git a/wt-status.c b/wt-status.c
> > index b5a29083df..459d399baa 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1143,11 +1143,13 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
> >  	 * file (and even the "auto" setting won't work, since it
> >  	 * will have checked isatty on stdout). But we then do want
> >  	 * to insert the scissor line here to reliably remove the
> > -	 * diff before committing.
> > +	 * diff before committing, if we didn't already include one
> > +	 * before.
> >  	 */
> >  	if (s->fp != stdout) {
> >  		rev.diffopt.use_color = 0;
> > -		wt_status_add_cut_line(s->fp);
> > +		if (s->cleanup_mode != COMMIT_MSG_CLEANUP_SCISSORS)
> > +			wt_status_add_cut_line(s->fp);
> >  	}
> 
> The machinery to populate the log message buffer should ideally be
> taught to remember if it already has added a scissors-line and to
> refrain from adding redundant ones.  That way, we do not have to
> rely on the order of places that make wt_status_add_cut_line() calls
> or what condition they use to decide to make these calls.
> 
> This hunk for example knows not just this one produces cut-line
> after the other one potentially added one, but also the logic used
> by the other one to decide to add one, which is even worse.  I find
> the solution presented here a bit unsatisfactory, for this reason,
> but for now it may be OK, as we probably are not adding any more
> places and conditions to emit a scissors line.

I could add statefulness to wt_status_add_cut_line instead, on the
assumption that it's the only thing that should be adding a cut line,
and having it not add the line if previously added. For instance, it
could accept a pointer to the full wt_status rather than just the fp,
and keep a boolean state there.

> >  builtin/commit.c | 2 ++
> >  sequencer.h      | 7 -------
> >  wt-status.c      | 6 ++++--
> >  wt-status.h      | 8 ++++++++
> >  4 files changed, 14 insertions(+), 9 deletions(-)
> 
> If this change did not break any existing tests that checked the
> combination of options and output when they are used together, it
> means we have a gap in the test coverage.  We needs a test or two
> to protect this fix from future breakages.

I did run the testsuite, and it passed. I can add a simple test easily
enough.
