Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEEB416D0A
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598859; cv=none; b=GhQm5/M8gnwkRgh7hiDgwABoI3OjiE1G64HbRk+qu8Tn6QAY1p/npd/Ttzl4AsMQucVvxzjvyQnXq2l7jRyvfwxfEwVrLXgyi8k4odWYJ83Ne6WTUDqIjU8lSH9l4gcwl9TD66Ia20/M1ZEPI9+GZN9dJ5fHbhkswDUll6AgqKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598859; c=relaxed/simple;
	bh=XuVLeNI6mhjsdIfpfw36LII0iWt0bb29TTYUBe2hO34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP7twYhxXttGBTfOEuC0wUcG5ljLiz1kMzXgPCGoj2XAn4V669lRQi/c3dBvkMcGMN3mSgnlMHCSQXX+rjOxIo4STdSeRgSdRrwFEb6Jir/LDb9q3+RNt+B+eO12OOveCsnYJGUCRxirN6lKB0qFJM6Mfr/vUm+Pi7u2m8x6kAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PI78TPRz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=issWr72/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PI78TPRz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="issWr72/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 946307A0049;
	Tue, 16 Jun 2026 04:34:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 04:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781598857;
	 x=1781685257; bh=mVSIIY+fom5jgDrNnfTZsA0IAHzrx49k10wl5jSZIKY=; b=
	PI78TPRzpWzgRT7JwcZHxPUCfy04BUbjTBF8J0N6ril049ozT78xGvTKB4iZmC7p
	IJfqd3QDgvKwmsMe6m0KglPJNm/9NwJufft9LqSXJpfHSBdUEU9riu0Jy3Jo6Wz+
	Kis12/Mgp7zcQijkTM1YcpegtqrVkRQTWkFbtE4hpvGalvfTjbxA8kBMKCRYlCR+
	Y2PJeGZgK0VLIZgQgz3V08QD4i+iHHLjr1zi5NE2pXAnr9y+VmD3DnwNC/rXSrFi
	TRYVZ3HuBD5XCDXMacIrI9gbuU8CWunZJ4rMDs3KNuACQPQqp9wuT3z860fzhXCt
	ETb1xrC+3Q330nt9LxHKxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781598857; x=
	1781685257; bh=mVSIIY+fom5jgDrNnfTZsA0IAHzrx49k10wl5jSZIKY=; b=i
	ssWr72/b98ckSEkQ65tGDfqpb/5ho1HI4NZ17qWKzdG7jBpaS8Gb73DfSr7a4ym8
	bCVdY8jm8oY0bOtKz5nyTrZOu8lvoZd54kaVGj6REZ2YvQWCNrWV7TximZBRp0es
	hOA2R0UAMZ37jHJDRL+E+VvPSTYqDdWYyqQt7zg9Q3ZXWyujUeFg1WJVVkPeUWli
	CJ8tzHoNpfnNzgyDs4bBONVbqIuVaw+XCB+C7P4JInygGDXNzqTczq6Wt5/QbcmO
	aUGLLsnN5EKqGeNvzpiUCFtfEkpS47jJLcsd7oRwC8jnnH3nvn4uSneEi9WAfHfT
	x3hCCii1V4nDaHLzZzEpA==
X-ME-Sender: <xms:iQoxaiURpOaMWSUsG0XaUD3lZuEZyvlAXI6CbvDH8aZtS_wMli5cBA>
    <xme:iQoxaldxi5o5RfYwy8aF9jz8zWJOGCsEZUdwj1UzYMWqNm0ZZX0t3B_ZPLRx1pk3B
    nuVabf1F_il0KXxkYPvey9uz6PLtPAeRnRLceDmZFIr5mMOg3AgHUw>
X-ME-Received: <xmr:iQoxauv-eaYLx6ibWKGiON-kzCEGW7JinQWaFvUvjj6Omdkl-ZvZ2my8LPxox3g3Wucg3x_iqHwzQhbXBtsrCqcG3hHilceFJ7StmRh3RM-X8w>
X-ME-Proxy-Cause: dmFkZTGVzjIlQsO2GVqWksYFIG6VJNp4lIb0nEh840w1zniixtei4YTZa6Ot29ZHd71qWB
    z2JoWfoLe8bHRsnBMUyAXxEYgpsHatGC81GJUws9P8cbK3e8xBgT/vEZeYBe90rnAtBJ0i
    ccXlkMTZoh37gqgdTFZ4oacvlKFNqQEDYFC4M/A/7gykrrSDI5TYc4RN/6nrmOZCaYi3b4
    nKSIcrDM9qul7ZFDXQ3RzyquALGKNOHuTGNAJFZXdrXezMqj5Y07zsGTZo/T17PayqsRXU
    0MzNAyuyrcPvckkTUl5Fn1UD+WQFajVOqPH80ZPTIotfwzLbQKlN8BWehx3j7coUji0kmL
    S+k54CdtodX6mjdHkFvR0WB+5LLyJ7cWskF7el8UlO4cRJobQcgbE4XVoFSOFkfs7ZmCzu
    gA6xkqm2S2uUG2ovrLTmB/5vep20Ob5hij3hmSuIHfYzkILanSLmeRf2FTdtYFM+FD8W3O
    XmNcWVpn4pn6DbQBWkK5MOeLELHYwYYqAvN2vHYfVcI90mYLPbJexf7mhCK8p4QQ8JSkmu
    LegQpMAjtubI9nahAfB4vl1lIscbcuT5MKUVZA7i8xdzPtvj72jjnBNYOAmItw2XzFGf1Q
    pg0TMJNCUDcf9PUIJiFg0mWkegw+scochqXnuCkAOh3C8FW6rtsUD8ZOaDaQ
X-ME-Proxy: <xmx:iQoxak_WPc2RSrKLIPG06cl2I9rPZvIP07W8kVDlaS_UbBobor68dQ>
    <xmx:iQoxap32yDkaf_9q7-RWg6uBvmJvNL0Dyr5F9KAj8Xfy7PwgoMh_tA>
    <xmx:iQoxapBo2qrod-jqIaTJafAj70D8SdG7AQ6xb0nCfY7oFoEGDBwfiA>
    <xmx:iQoxalct6ZM1ox1flUhw9hwpoQYTSTGYX6y94zcyWWyzViQzc-T4jw>
    <xmx:iQoxakOR-kkay0ifiqgA-3tThfunUVFxZKeW8S9gXZZzk76vtqpZJTy8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 04:34:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1d8893a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Jun 2026 08:34:14 +0000 (UTC)
Date: Tue, 16 Jun 2026 10:34:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] rebase: add --fixup to fold a range into its oldest
 commit
Message-ID: <ajEKf-jCIDVPQCeO@pks.im>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
 <xmqqqzm8d0j7.fsf@gitster.g>
 <CAHwyqnWa55xbTpzq-Nf6cMyvgR1yYgg8fhvgMFkquSEGPUwDmg@mail.gmail.com>
 <CALnO6CBgHz5d5BT5gCyqyhw_HpV733msWOnrxmu-TJ0QGHE9tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBgHz5d5BT5gCyqyhw_HpV733msWOnrxmu-TJ0QGHE9tA@mail.gmail.com>

On Mon, Jun 15, 2026 at 11:17:21AM -0400, D. Ben Knoble wrote:
> On Mon, Jun 15, 2026 at 4:22 AM Harald Nordgren
> <haraldnordgren@gmail.com> wrote:
> > > > Adds git rebase --autosquash --fixup [<upstream>] to fold a range of commits
> > > > into its oldest one, reusing that commit's message.
> [snip]
> > > I also wonder if we can do something like this without adding any
> > > new option or command.  E.g., if you have four patch series, where
> > > the initial implementation HEAD~3 is followed by "oops it was still
> > > wrong" fix-up HEAD~2, HEAD~1 and HEAD, then
> > >
> > >     git reset --soft HEAD~3 && git commit --amend --no-edit
> > >
> > > is what the user wants to do, no?
> >
> > I don't think it's enough. First of all the user has to know the N for
> > HEAD~N, and then 'git reset --soft HEAD~N && git commit --amend
> > --no-edit' is still quite ugly.
> 
> Well, there are a few ways to get this more easily than counting; for example,
> 
> - git rev-list @{u}.. | tail -n1
> - the lovely ":/<pattern>" or "@^{/<pattern>}" revision notations
> - etc.
> 
> ---
> 
> Stepping back a moment and assuming that the important thing you want
> is the "squash" (and not necessarily the "rebase" moving commits onto
> a new base), I wonder about
> 
>      git history squash <range>
> 
> which would squash all commits in the (now arbitrary!) range into the
> first. That makes it somewhat more versatile at selecting commits, I
> think, at the cost that re-basing is somewhat harder. That is, you
> could then do
> 
>     git history squash @~3..
> 
> and things like
> 
>     git history squash @~5..@~2
> 
> As a future extension, I think we could support merge commits: merges
> could be replayed as a merge into the final squash instead (creating
> an octopus merge if there are multiple merges to replay), though I'm
> hand-waving what we should do for conflicts. (We _do_ know what the
> final tree should look like—the same as the final commit in the
> range—so maybe we can actually avoid all conflicts?)
> 
> Anyway, I've cc'd Patrick for his opinion about whether this fits in
> "git-history".

Yes, it does fit into git-history(1), and I do indeed already have plans
to implement such a command going forward. I wouldn't mind at all though
if somebody else beat me to it, I want to implement at least one more
command before I get to this.

Patrick
