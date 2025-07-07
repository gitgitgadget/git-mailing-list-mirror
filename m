Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F28155757
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751868128; cv=none; b=D7YwBj7TvRGLPcLi3YApM8t4piZo3UIwJHOHoACDEVy2XCBsOOcLmtV3waQPXxcGcwQ62kJ1yhVR8aZ+wJY4RgmMucPLWtxsFqN7YWsmod0zkZShkykjZ5mgXbRF/1YNxWNV8Pwed2crgu+iXaCTmmWZs633YFhRzT/cPTVOMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751868128; c=relaxed/simple;
	bh=ubZ31+8Shnvc/VnQ10ETJ+nX4bqnQzpg1YPaURjcANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6peTH5Xoth/Km6EZsc56cv5CvnPByA+ZufLcTDns3fe4Y0jm2J1X60Ew557ceXIxH3DZm2Mo0qNviPPf9LPMuzsOqGTCcBKEY2d4cXHJOsc2gKFSoG4Jq7Vi2wA81wEMV0qhtHul0o//8uKtupew44PrbZ1fi6EYFCzRt9tcvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lCxsnilF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=caRfbDXF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lCxsnilF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="caRfbDXF"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E3DAEC023B;
	Mon,  7 Jul 2025 02:02:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 07 Jul 2025 02:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751868124; x=1751954524; bh=UTBIjDvhu9
	aAkwk0QAFqB/y/3L76epY78krd+D2phbg=; b=lCxsnilFfi5Ls9DEJjoPKHRcRl
	6iZfa6So6NrDKRetNGOjwWD8v/2+jdCW+YWdiph5eYNgP1C7cJ1l5iFyyqeuAgZd
	gUg6+SnqcXUpK5lAs50RYpilvFKUtYg+d2UfWhf50koxF4Jg07oZnOraoJj8RNFg
	6ZFDrG0+XN6cDK/jSGTCdK+J7r0We1dKBzJr7iVaqmmjAPB8GzXR0vJY5HCMzUI7
	iViHhhjP+7ZcUBD0XhUXhSDPYQEIrUDppz2Wu+MqHlUwffFIJAaMwAYaHfk5Bgfr
	RRdNFbcrEmmpQEVkMS+aUY45pFqFni+MZ7/ARGeXqNYcIXOQiLl4H+WQbXtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751868124; x=1751954524; bh=UTBIjDvhu9aAkwk0QAFqB/y/3L76epY78kr
	d+D2phbg=; b=caRfbDXFPAk59NLfwHUcda3A5zosUjxwPTpcpZl/+xPpOdkGRgV
	GOyjCN15q5z0TEr942V1RgAhsePdFQ0EpUnVx3Plar90hl3UULDPIYH4VTmJurD+
	u1qx8UCiRhWcPvuSAQ/kvVN030x+HIcZkthIqvEky21DzHGlN6suNd8ttUMJeNXw
	/vtFmp5VcTjpSSx56oGiMuzHLYxXm3CG1iicGYK46ne8ZA669aWwCdWdnJUFyzzf
	bK984rGZSe7j+f557+qKu6a1pXrL0dbaSKCkuEprrIPDks3YkaVSyrpN87Ejgjs1
	7+AhNRBGeAXBQYaVj878RDuMkf4coSUaRew==
X-ME-Sender: <xms:3GJraIMXPMWvlapnPEEh6ria5jjbLHbfWmtLLT00d9VwoQr4bH3FqA>
    <xme:3GJraMiQvSni9q0ndOaI92T7PSI2IotORozCdKzT8FK52MSDgiYYi5wLHGbl5T4zD
    cDCCieNSJQk2OIr3w>
X-ME-Received: <xmr:3GJraFvD2YwveeJUQhTKiPfz_TPxy5bBMNHbeY2Y01TlybQvHUlXNvaBFM1ihAlOF6HCwZUl5ICyxFQ2k4NQBMKdnlxi0c0jNVvWB5KCkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefuddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evhfeffedtteeluefgtdeugfdtkeeugfelkedtheegieekudduueevgeehudekffenucff
    ohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3GJraCTE1Oc2P3cDBnikS3MeVXmhxIAmGmQMtqT9gIkfO6wrs4rWTg>
    <xmx:3GJraB07TTknp8cyUCvcTCHP98yB58ttvuqmkAu70k9rdvwcLXweVw>
    <xmx:3GJraPuUlOHIthoG6mvpu4McXIi2p4QOZTGHaWWSnGOxA3cgzRncog>
    <xmx:3GJraPjr6Rn9Lfygq28-Bx_JnbtFUQiIC4bIOdKnkgKM0JFlfYrO9w>
    <xmx:3GJraCPc317CtTF9xcmbMdUhBRcFsZMMW4jUViWSurJ0qnSyVb7TRg3L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 02:02:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba423542 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 06:02:01 +0000 (UTC)
Date: Mon, 7 Jul 2025 08:01:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, ben.knoble@gmail.com,
	gitster@pobox.com, Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC RFC PATCH v2 1/7] repo-info: declare the repo-info command
Message-ID: <aGtiyGW4MIYUw3Ed@pks.im>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-2-lucasseikioshiro@gmail.com>
 <aGZqK5eBA18vHAa_@pks.im>
 <AD2EE71A-1395-4665-BB9C-38DD4B941574@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AD2EE71A-1395-4665-BB9C-38DD4B941574@gmail.com>

On Fri, Jul 04, 2025 at 06:40:11PM -0300, Lucas Seiki Oshiro wrote:
> 
> > One thing I wondered: Justin is currently iterating on git-survey(1),
> > which is the command Stolee proposed a while ago to gather repository
> > metrics.
> 
> I didn't find it in the mailing list, but I remember seeing it in the
> the GitLab's fork. Is it this unmerged MR? 
> https://gitlab.com/gitlab-org/git/-/merge_requests/369

Yup. It's been posted to the mailing list as part of [1].

> > Would it make sense to maybe have such whole-repo commands
> > grouped together in a `git repo` top-level command? E.g. `git repo info`
> > for your command, `git repo size` to gather information about the repo
> > size.
> 
> It seems to be very nice for me! In fact, this being a home also for
> statistics is something I considered while writing the first versions of
> my GSoC proposal.
> 
> And what about merging the two codes into a single API? Something like:
> 
> ```
> git repo-info layout.bare references.format survey.commit-count
> {
>   "layout": {
>     "bare": true
>   },
>   "references": {
>     "format": "files"
>   },
>   "survey": {
>     "commit-count": 42
>   }
> }
> 
> ?

We could in theory do that. But there's two things we need to be
cautious about:

  1. We should be mindful about what specifically this tool is about. It
     shouldn't become the next tool that does way too many different
     things.

  2. One of the idea of git-survey(1) is to eventually replace
     git-sizer(1). This will require very specific presentation formats
     that aren't really compatible with any of the other information.

Out of these two I think the second item is the more important one why
git-survey(1) should exist as a standalone tool, either as a top-level
command or as a subcommand.

> During our meetings, Karthik suggested (I'm planning to it later) to also
> allow to request an entire category instead of only the fields. Then, this
> would also be possible:
> 
> ```
> $ git repo-info survey
> {
>   "survey": {
>     "commit-count": 42,
>     "blob-count": 1234
> }
> ```

It raises another question though: if we ever were to add `--all` we'll
need to step a bit careful about what kind of information we add to this
tool. All of the information proposed so far can be computed rather
trivially. But computing repository sizes has way higher computational
complexity and may easily take seconds, maybe even minutes in large
repositories.

That to me further points into the direction of giving those two tools a
common top-level command (`git repo info`, `git repo survey`), but to
not mix concerns too much with one another.

> But I don't know what are Justin's plans for git-survey, if it would be a
> porcelain command for showing those stats to the user of if it is targeted
> for being parsed like this `repo-info`.
> 
> I'm just brainstorming because I liked the idea :-)

I've already pinged him on this and he liked the idea of having a common
top-level command. I guess he'll respond later today or this week.

Patrick
