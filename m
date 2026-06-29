Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213113B5E19
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782720276; cv=none; b=qqClVYP6OxtuLJoBC+NFUplFachZT/jjO7x3yfrg6nRwdSeiTR4miJAgyTYOfHbnGOsOlI2RrnyuDWVW2/wdr4gw+RBPOhzgqTNd+GEa4PWvZJvWc3C8SvolZueeGLruji8z7FiZZgMha7a2nECIbozi7/seXveCg/9ynhcOXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782720276; c=relaxed/simple;
	bh=bjMNERxXdtFHiV/SBjI4rAcy4xzIiy0EksrtKyP/JZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK2sT4cmf9ZY9CJNtheybRCY0de3abKvt4A8iujE69gK/44ozCtYHaxiBynFJKHFkhr598Ukla/ggD7sR9Bvs9e4ODtTEMGM4cSgO4ahrD1sYUfkLkvb0J3oPis552EFx2EP7aE2NOLdtbRBmJne6YIihkGugM+3ho+TblVNv0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SKgJtiy3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1newggF; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SKgJtiy3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1newggF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 653B21D000DB;
	Mon, 29 Jun 2026 04:04:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 04:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782720274; x=1782806674; bh=E/7LEyfvFU
	yl2tSYhG3E24xueCqfoNDr27Tac7Ru6rQ=; b=SKgJtiy3dYQPoBDQTkhn8idYBc
	Si4ROnl+xWB63yPlk1KJma/ao8JjQWSGuWMiputV6OQSoDPp/9QH7E0WJXmU0Ipr
	zDIcQagFh9/9kQoFFgeukl64ftgg7xV5snRHDBkudlQLvhbM8p3ttqSYdaDK/0VX
	cn5Hbr09CksZXX+bMAVS8EB1Oeu70TTzN9rhN6tc+fxBheWJvhOi3oAsAA/9fQ8q
	uLePESToBEpyOB4/TvH6md2Ea9RfBoTvCCibOp+aZNE3Emdx2rngBf0+KR0LNCHv
	avDa8joe29cgtnC53CbVr89crevr1U57oyezqoHhIxNDjy1MaNmzXt1TlMrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782720274; x=1782806674; bh=E/7LEyfvFUyl2tSYhG3E24xueCqfoNDr27T
	ac7Ru6rQ=; b=G1newggFZJlM678IymcqeZ3032XyktY4EFqatLubm+UP2jr/dHg
	Qh/PWuTfpksDvxMlWg+AA1RSSSu+kMrImhJGU8Y43bJjcQjl1XhbnLUyQDqjpzXz
	bM0bS1tybesnLJkxI+t2Y73aDT7zCGnMQPxLHeZdEP8+te57z6H489ccTEgJBzuR
	a0wnqXKoJ+0Q+xo1Upw8yWcIBnhKCkrqGulOfVYzwJMe8Eao74SOs9Yma/l4mzPt
	Ptbccxdc1lZ+37BsfK0RWWVWdRrUsCEgKZ2BR3gcPf1PjZaZs+aBO+bP6gE/YbTK
	ygyK6paSct7H2RBfnzc168ejzAUf0J09rOw==
X-ME-Sender: <xms:EidCaqAxwIKr7SUooKCuLwP_45bTr4AxJ5610JikJeruMyAZCGtt_w>
    <xme:EidCarihGTsVwoCeHcKXhBom_YnyjwwxTg1jWnitEfZEUzNAV7ZdImwDK1248DD82
    WU3lFM6tIWYE0H1HSM2NN4LgRoGzSKH0xd3AiYIoBUyKVlCF82j8w>
X-ME-Received: <xmr:EidCaik5v0TWPgycYQrGVFspBSrPA1fhXuWhT4Colk0rhs2zCtlfopa6SBhrh8bp8269k4as1ghEsjK6_nt0xrQwzcwXXGk2c3Rj_CyDKyZH>
X-ME-Proxy-Cause: dmFkZTFXepKPI/uxgdQm/7zCqpK+VfkXR+wkEj1afnx/n31WbNsuUl1qtZCDTk0lKY5vgw
    kqJOtuOZN1WCL1jc+UWajTDIDAOAkhBLDCLb6AinML4WwdjM6C0QPnPaDUrxw+Kdq3CBPv
    INi9K2VzTj/iymghf8N7LuLEErF3l0QfnOIhJw2tRXviny0dcMNpfUVgb5cOONvqC3j4cG
    rVnKgzdlC7/6jN71vJPFDKVgrs3wxKH2o+IWlEFpZaJbR5bD8c19vF3+dP+3t8sqqcM4Iu
    PNzOr5kd4xzjZoYw3IaKr4WdfDGo7ObtkreTXyvCI6VMvKx1OUwZUaPY/buEG4sX4oQSQD
    lrhvn39SFG9AJIjJb/3JaqpcmxhF2Hs0E+7sH10SkXxbSFn2dPRS/3N58n+UYuaLYJCZlR
    Sp4xrYqlK/JGlCTz23ktW/lFhgHz6X5e6oINzhjwu912qaHxOrMEvZEKOmOp2ky0Liln5g
    hpPEXLjg+QNo2ot/LZyVTJsfmhAfpO2ZifqAi4sA5eH86dHvtjljHjDGuENod6NiNP9Mr0
    K5guwcfZv6uplaZG/URX3rF8RbAGj77DiBHe40mZXWL9OCzlSybN++Cx4faqwkf2Ukb8cN
    ENpRiH6VtkneyZH3t5Ftd9SaCUH7T/wha6S27v4cWwSf97uzZNqjn6tnquwg
X-ME-Proxy: <xmx:EidCano6sivxaHKGYMPJ9Gi4oxEVxlNaZbFZH7HICIz6F_N-1IT9_w>
    <xmx:EidCarG3JR1DfUQ9cSaaw0778SRVh1Blbk7Qa6axSOIJrVktVZ9I0A>
    <xmx:EidCajyK2m814srQzmPlL-yrPs8I4wcxP2MXI4SnEacHUHXPJPFI_Q>
    <xmx:EidCagrXefcklFxwc6fSaXoDB0iYgT9zXpK8otH9GV_NMi_BqyvwDg>
    <xmx:EidCan8Rhsa3L4SrGQDS1Ke_u3rckfhD07QXW0_8bmvmqOcnpnV0aP-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 04:04:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d16d08b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 08:04:31 +0000 (UTC)
Date: Mon, 29 Jun 2026 10:04:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 3/3] replay: offer an option to linearize the commit
 topology
Message-ID: <akInDBlyWbbRFcLH@pks.im>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260622-toon-git-replay-drop-merges-v4-3-ff257f534319@iotcl.com>
 <ajk-a4a3KSJ2u7Ju@pks.im>
 <87qzltyiao.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzltyiao.fsf@emacs.iotcl.com>

On Fri, Jun 26, 2026 at 07:36:31AM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > git-rebase(1) essentially knows about three different modes:
> >
> >   - "--no-rebase-merges", which is the default and maps to your
> >     "--linearize".
> >
> >   - "--rebase-merges", which by default doesn't rebase cousins by using
> >     "--ancestry-path" internally.
> >
> >   - "--rebase-merges=rebase-cousins", which doesn't pass the above
> >     option.
> >
> > So it's not a simple boolean there, which makes me wonder whether we
> > should mirror the same interface so that all of git-rebase(1)'s modes
> > can be represented, as well.
> 
> That's a valid question, although I don't know a good answer to that.
> 
> Basically you're asking for what the command line options will look
> like? Allow me to think out loud.
> 
> In this series I'm adding --linearize to git-replay(1). As mentioned, I
> don't think it makes sense to add it to git-history(1) as well. Without
> this option, the process aborts when it encounters a merge.
> 
> Dscho sent a patch series to properly replay (2-way) merges. I think
> this should become the default for both git-replay(1) and
> git-history(1).
> 
> But then, do we want to have an option that brings back the current
> behavior of aborting at merges? Maybe with --no-merges?

I think that would be a sensible option to have.

> Then there's the option of rebasing cousins left. That's something that
> isn't covered by Dscho's series yet. Maybe --replay-cousins?
> 
> To reiterate what the final design could look like:
> 
>  * <nothing>: replay merges preserving topology.
>  * "--linearize": flattens merges (only git-replay(1)).
>  * "--no-merges": dies when the process tries to replay a merge.
>  * "--replay-cousins": does what --rebase-merges=rebase-cousins does.

Right. And if we tried to be consistent with git-rebase(1), then this
could be done as:

  - "--rebase-merges" to replay merges preserving topology, which is the
    default once we support replaying them.

  - "--no-rebase-merges" to flatten commits.

  - "--rebase-merges=abort" to explicitly die when seeing merges.

  - "--rebase-merges=rebase-cousins"

> Now, all these options are (I think) mutually exclusive, so we could
> consider an option "--replay-merges=<mode>", but personally I find
> "--<option>=<value>" arguments harder to use than specifying separate
> options.
> 
> I think I'm avoiding your question, because the design of the command
> line parameters doesn't need tot 1-on-1 correlate to the internal
> datastructure. And I agree the mode isn't a boolean, but does that mean
> we want to use an enum internally? Well, I don't know. And I also don't
> think that matters right now. Code is easy to change, I think the
> command line options should be designed with the future in mind, which I
> believe we do with "--linearize".
> 
> Sorry for this long-winded rambling, but bottom line I think it's fine
> to add --linearize and in the future add more options and see how the
> code should evolve to support those.

Hm, I dunno. You basically reasoned that we potentially want to have all
of the same options that git-rebase(1)'s "--rebase-merges=" already
supports. So that begs the question why we need to reinvent the wheel
then and not just use the same syntax.

Note that I'm not arguing that we should support all of these options
now. I'm merely arguing that we should try to be consistent, unless
there is a good argument not to do that. I'm fine with the interface if
there indeed is a good argument, but if so we should document why we
think that the current interface in git-rebase(1) is not a good fit for
this command.

Thanks!

Patrick
