Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759F27FB25
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770733383; cv=none; b=mdQ6G3unWSOhtipT8nGCwvqLJrrD5UhWJOx+ZgT77bduct71nJ4C0uhKQrsRbRvXLbcrAGrhqIenxsLHZ7VPPU2j9xn/bn0QS3vb1LsqRehyB7y/pRADt9UfuDzkQdjiVWrmRYYvjEykCAjZhrc7wtmjR5PaO8znBFWx0KqZENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770733383; c=relaxed/simple;
	bh=ZrnwOe+Bi8yZwxbkEIutR63VhDv0QuxGhiR0/TRemvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gz/Ec4pX2qyvLNYR5PZ9CBw7IVTd7mzkClWCzwCaAJr/aYSQNtKDLm94mHO3KytLX51j8B0850DjSB8sxltoC5ys8Y0ElWrASWrXcD5eo4NKoXjVHIArGY+D30TWog2CBAiz6jZ+K8yefQP+mPbfNuPchDwnuERXuG0c8diz4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MtOCpBYT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QTMOwsmB; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MtOCpBYT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QTMOwsmB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C4BBE14000CE;
	Tue, 10 Feb 2026 09:23:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Feb 2026 09:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770733381;
	 x=1770819781; bh=aIsq1LtzDH6D8hBKgc2AK/vmLXAUBAd5v+D1vBie8kc=; b=
	MtOCpBYTBIwBIqQtNhkbMJaCBV5rVbDqlzAlil7J/fT1xJdDZtGNKbzP5iWSYW+n
	WAhzWLm6MhaoAlElP0V5SUnN5u3/Cp6SnPIQDh0JWQ49tUusyUZEsVhU2jIh6udV
	25LqvRhRAjIuNCV4PZPh34VkneXDexCvQDo3kt0qKa+wBZsLrV9w3asKB6H98knC
	FOPOr+2MPvXzsQL5HW/9vGCn9D1+sutctSljkMRkuRxe5RXqG/iS5ZtKPQv4va5e
	RtBwnhbmQrXZoWqMDbsPR8Bx5p3wD1ZRoTkKFe9m8nbmGGURbFygtFyCSdH9lt1h
	uk7YgfHiyH/P95nSuAdWAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770733381; x=
	1770819781; bh=aIsq1LtzDH6D8hBKgc2AK/vmLXAUBAd5v+D1vBie8kc=; b=Q
	TMOwsmBHsuhOWRf8qXt+zai9xQND8ZtuJdWUfeTeXFP6fIV7VT5HJURgRjthLPxs
	klUuU9YBMsdleHiDxaNTna5/aMjipUentu01PTAsVA13rznpDkJDFS74Rr34mJX/
	gq5YmHxcQ7xzM7pzSSOMyF7Ag4rYS3wTAMONgdMOv9WoyhXx7EwK8BlWU5RbW+cY
	uBll+bxf1/USwZAyS1Aw4y4jHKOBt5XPtDD14RgWfTg5GpoFfHkJ6wYu1atHY0f+
	FAFbFZf07RODTwcVWXotE0WwA/23AwYRs6Onq8wPDkl993/cxHxYVRjaEd4ze5qF
	DiBdmdiFjAIvmZSUBmmTQ==
X-ME-Sender: <xms:RT-LaVNhJgzguY3vKZgUx5s3hW9OuRJNBEAYVkJakgpszNu-fJjfBg>
    <xme:RT-Lae3oeHXxBSfjyiSIGvhmChrHwue_GwbImG9LAxd5DjFgthZA7LOV5xBK_yQGU
    g9QPQlp7r_AwuCq4JdyPO46qbGCNKTXoJciO9MBbaZvsZmcNKp6qw>
X-ME-Received: <xmr:RT-LacmtTolw1Glx5fG8sEklHrSRqxAIot5Xz8Iq8uCj_Z7FRm7sxNZsvXF82stdm2Ucr8OwLZg_hdqkYcRhAYw7ysNgIG1I42eUbdwUShA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetheffvddtleettdetueeukedugeettedutdegueeukeetheefueevvdeitddtveen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphihohhkrghgrghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehj
    rggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrihhlsegsvgihvghrmhgrthht
    hhhirghsrdguvg
X-ME-Proxy: <xmx:RT-LadW-jy_CCXgvPKH4A82MI2QnfvEbrsrnnbWY3NAd1JD30LVNSg>
    <xmx:RT-LaatbGT3N8uU4HY0voI1DkYTB2cCdUDg3WieFxtRlbpjkxTodLA>
    <xmx:RT-LaYYDyJvBSAD7vgtb6-gCYG5cwnqEnsjFR-1xY7byUZ-T-6Q9kA>
    <xmx:RT-LaRUsFdEQCb6IlamxPYtJY1OxwxFVsbAwtipu52tGxXa8p5ZnrQ>
    <xmx:RT-LaW0J8MqxC1jt-nhbooMPbBLaK2w_nhEvtsaQcJvYpw9q0jabO-3_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 09:23:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d77ad16 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Feb 2026 14:22:58 +0000 (UTC)
Date: Tue, 10 Feb 2026 15:22:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Jeff King <peff@peff.net>, Matthias Beyer <mail@beyermatthias.de>,
	git@vger.kernel.org, pyokagan@gmail.com
Subject: Re: git-am applies commit message diffs
Message-ID: <aYs_P8QujA6mL81-@pks.im>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net>
 <aYoEO0CcVt2Qjgnb@pks.im>
 <CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>

On Mon, Feb 09, 2026 at 06:16:35PM -0800, Jacob Keller wrote:
> On Mon, Feb 9, 2026 at 7:59 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Fri, Feb 06, 2026 at 04:03:58AM -0500, Jeff King wrote:
> > > On Fri, Feb 06, 2026 at 09:18:50AM +0100, Matthias Beyer wrote:
> > >
> > > > That said, I am no expert in either C or the git codebase at all, but
> > > > from what I saw from reading the git-am codebase, it looks like it tries
> > > > to find the patch by looking for three dashes on a line with a linebreak
> > > > behind ("---\n").
> > >
> > > Yes, that is how the split is made.
> > >
> > > > From what I read, it looks for that from the first line.
> > > > What I would think of here is looking for that "patchbreak" from the
> > > > _end_ of the email rather than from the top, that would have prevented
> > > > this issue, right?
> > >
> > > The patch itself may legitimately contain "---" on a line by itself (it
> > > would indicate that the line "--" was removed from a file). That would
> > > confuse your parser, including in a way that we end up only applying
> > > part of the diff (everything before that fake "---" becomes commit
> > > message, and everything after becomes cover-letter material up to the
> > > next "diff" line).
> > >
> > > I suspect it also creates corner cases with cover-letter material
> > > (between the "---" and the diff itself) that itself contains any "---"
> > > marker.
> > >
> > > I don't think there is a way to unambiguously parse the single-stream
> > > output that format-patch produces. This is a reasonably well-known
> > > gotcha (at least around here). E.g., some earlier discussions:
> > >
> > >   2024: https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
> > >   2022: https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
> > >   2015: https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/
> > >
> > > There are probably more, but it's actually a tricky thing to search for
> > > in the archive, so I stopped digging. ;)
> >
> > Maybe we can't parse it unambiguously. But what we _can_ detect is that
> > a patch is ambiguous in the first place, right? So maybe we could extend
> > git-am(1) to bail by default with a hint that tells the user that:
> >
> 
> I think it might make sense in a breaking change to update format
> patch and git am to have an "unambiguous" mode which would allow
> somehow to unambiguously distinguish between commit message contents
> and patch data. I'm not 100% sure how to do this, and it likely
> requires some sort of breaking changes to both tools to allow
> distinguishing properly between the two points.

That is worth a thought indeed. I guess one of the biggest questions
here is whether we can introduce such an unambiguous mode in such a way
that old Git clients/patch(1) would continue to understand them. I
wouldn't mind much if they would still misinterpret the ambiguous parts.
But if so, we could make this unambiguous mode the default without a
breaking change.

This is all pure speculation though, I have no idea whether such a
backwards-compatible and forwards-safe mode exists.

> Obviously if you're sending the contents together, a malicious user
> could edit the formatted patch to move or copy whatever the
> "signifier" for patch vs commit separator is... but at least we'd
> prevent the cases where someone accidentally includes diffs without
> intending to.

Well, if we had such an unambiguous mode I would say that eventually,
Git should start to refuse patches that have been generated without this
mode by default.

Patrick
