Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF328C2DD
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764701465; cv=none; b=JvW6On9NxOY/Vgz3lrpyr1IxiasNQFs5+NMnv23XjXoJUeza8zUgQA+WPpKFTsbrYzoXAknNNsQ9wa39Wz1MSBs670DJ0dk/5kPbYBP+sxIqQNhcbAVv97e83b9n7FQPHXtcYrYkI9axH3mt3relmiV8O1AWBO7HkamJltJlM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764701465; c=relaxed/simple;
	bh=cqZE9KFOaTrSgEoJfHX+/FPWJt/fkiCTfzuA4UX7hy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTx7ITLWc+PIXSGOkf9LGPh6br8Bu0yHdwPu5Ak3V1sJR2NYY2LLw/IYgYHuegFEVOgHGIY0QYvAYAg3rQWheeMrD1fdl369YPtOMWdjrx+MfAvn66HvbWcD8ZvgJt4ANKEINCXL0gFfQZlxJeb0N+5lvicnzizK/eC27atPY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XynRrK1k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDSMMaDu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XynRrK1k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDSMMaDu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 995DDEC05A8;
	Tue,  2 Dec 2025 13:51:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 02 Dec 2025 13:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764701460;
	 x=1764787860; bh=om/XzomeYOE2R0Qn5HF+5yDs+i4Tdx4Ls20lLXCf5Io=; b=
	XynRrK1k4PqArJTh4IIIbGKD197TRYihY6I1K7oB4nf7KwUKNFKruyxPHzIwcg8p
	AUvKgube9XLXJ7Qj0/3rmteIQZ8891XZp2aFao7gi5PQ8m1RyZminhAlHk/lmeNw
	HNMUKUdAk5KzsNJNKbZJea36mqMmlApieba9sjHxLaoJJfLb6YiYsgIhpkzfjfTA
	uOGWFS28cQ4gt26s/iKxsy367nljH3/Lad9ZgjzuN7pmopYQvW7lHU4IFpXz/jzL
	emAQT0rHi9lhFAnLi2ts1feU/JiinaJnr+/I9qalkb4RSfir6BtVU1jID34EDYUx
	cRtZkGqazJsaqVbYFb2huA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764701460; x=
	1764787860; bh=om/XzomeYOE2R0Qn5HF+5yDs+i4Tdx4Ls20lLXCf5Io=; b=W
	DSMMaDuPI0ZRFJqwwjUZwG0+EqEIO7RzWkXrquY92QouOigzu0IuvpFeX7eL70Lp
	8esWiQs8k8gDEwClD75mqjMgEFJUzlBW/WrP5dHa+NZlbHSvDRKzcP6FsNJtOt8f
	Ux4YSII8PVbchQFQC75FOj6mu+nCcgWP5Nu5CN8MbzgXEG/ji3WvENLShiYE6pG+
	eZmxGlbKy3+H8DbZgQfOx00kpvv3DNb6d+rAtdEeDSxlhj2IjAiNULZ/IZwvr0Ey
	ozuw6Fj0FvczDP42FjPwYnh0GOHu3U1kxzFM9UIfSOg1vHajZ4O/tU6PIuX69CSs
	4sTbVoyhPl2J3HkDVX/BQ==
X-ME-Sender: <xms:FDUvaWYvdett86udQ3YUN-J5k8B6uDrBfb9FkqElPWFRbXx_c-CPjw>
    <xme:FDUvaV-5TifEomBMQxR2DIyKMj9MuftDhUVEDWhc0EYSVJT-vLmCDvGxjVC139LBX
    zVWF8z2XVP6XqFOV3Suw3hDA3fjhtnJQHeW24l9q9YG7vAyrD7-pw>
X-ME-Received: <xmr:FDUvaVaASjA4FFHu7mT8bOt6qsi8GkyPTj4-m2Dcwj4BMFS-EJ2v7rWDHq7XKYMZ1sHI-5V7qsSsO4p1A3PxWgK1ObCxTG_Uv6hQU8MHYnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvd
    efjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepshhorhhgrghnohhv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:FDUvaffpwpIkt620mjkM1uIOufhqaKSvgIEzHHRqMX5diNScJslWbw>
    <xmx:FDUvaSlgA9n74zesl4Hy_p1tR4R-66yl693xQ1KdXvw_cJGj8KuXyA>
    <xmx:FDUvaf0-o3vWkVNa-ppnzSNV3jQbfjk9YiWtIqmapR0miJq7eHKNQg>
    <xmx:FDUvabeIFVqIDTdibngZQ9Y7eY0tmoJF2UWL29T8PEA0AVgqNkxZ1w>
    <xmx:FDUvaUoCvrYY3xIZhURSVIN3dj7O_Ncl9XA0kh3ic1wOKMvE30xQ17qB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Dec 2025 13:50:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84278f7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Dec 2025 18:50:57 +0000 (UTC)
Date: Tue, 2 Dec 2025 19:50:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 05/11] builtin/history: implement "reword" subcommand
Message-ID: <aS81CgKzerDkHlS1@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
 <aSVpXPtrqa0cBsEm@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aSVpXPtrqa0cBsEm@szeder.dev>

On Tue, Nov 25, 2025 at 09:31:24AM +0100, SZEDER Gábor wrote:
> On Mon, Oct 27, 2025 at 12:33:53PM +0100, Patrick Steinhardt wrote:
> > Implement a new "reword" subcommand for git-history(1). This subcommand
> > is essentially the same as if a user performed an interactive rebase
> > with a single commit changed to use the "reword" verb.
> 
> s/verb/instruction/
> 
> The behavior is not nearly "essentially the same", because 'git
> history reword' doesn't check out the reworded commit.

True, this is a leftover from before. I'll reword this.

> This is a substantial drawback when writing a commit message for
> anything non-trivial.  I, for one, often like to take a look at the
> "big picture", i.e. the actual file content in the reworded commit, in
> case the diff included in the commit message template doesn't show
> enough context, or even run Git commands built from that particular
> revision to be able to accurately describe its behavior.
> 
> OTOH, I understand that this might be deemed desirable in some cases,
> like when rewording a commit to correct a simple typo, because source
> file mtimes stay intact, or when the worktree contains modified files.
> 
> It would be great if this new command could somehow support both use
> cases.
> 
> In any case, this significant behavior difference (and its drawbacks)
> is not mentioned let alone justified in the commit message, it is not
> documented anywhere, and it is not really tested, either.

I guess it's a mixed bag. The big benefit of not having to check out the
commit is that it's as fast as it gets. All we need to do is to rewrite
commit history, and we don't need to check anything out. This has the
obvious benefit of being fast, but also the less-obvious benefit of
being able to deal with changes that exist in the working tree, only.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  Documentation/git-history.adoc |   7 +-
> >  builtin/history.c              | 331 ++++++++++++++++++++++++++++++++++++++++-
> >  t/meson.build                  |   1 +
> >  t/t3450-history.sh             |   6 +-
> >  t/t3451-history-reword.sh      | 237 +++++++++++++++++++++++++++++
> >  5 files changed, 573 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
> > index 6bdfeb50e8b..bd903875120 100644
> > --- a/Documentation/git-history.adoc
> > +++ b/Documentation/git-history.adoc
> > @@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history of the current branch
> >  SYNOPSIS
> >  --------
> >  [synopsis]
> > -git history [<options>]
> > +git history reword <commit>
> 
> I'm not sure I like this interface, because I have to know in advance
> how to specify the revision I want to reword, and I usually don't know
> that.  Choosing the commit from the rebase instruction sheet seems to
> be much simpler, more intuitive and less error prone.

Fair. For me I would very much prefer this new interface, but it's
certainly a matter of taste.

Patrick
