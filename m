Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D43D1F0E3F
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254127; cv=none; b=G4bS1sQWdV2Swoo5FGsaXDmdJoMUBFpa1b7dqvvLgHIO3AtHrYPhya6GEGI3GqybgOT10GwnA2yrFtDvAHZXCfTTeXzAdmWJW4a/aaUvYcVmeCkBR6OLpZMS3UnAAk/TP185pjNjBnyIESYx1QBqX/arg7c+ikCwtxXZsFBpXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254127; c=relaxed/simple;
	bh=zVktgLgy43VFLMZPXg2kGThUwXZCEjcA08SAnmeEnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuDn7+Xmym3BxiNtYqHvIjTEeS0yCighfFmb1AaIgEvXKGLDrGcyCBoIuhG5FjpNE/56hkUIpBKLnFBd5syB7pek80v8xnZGoXPfeo4MEaKk0mMab7Mr49J/hAHwQVkXRZTtf4OOm3qQFQNmTbhxhdxyk1KaCs95+BdJgvfYQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VhmPMM04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NqUo4ru7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VhmPMM04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NqUo4ru7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 06C5F13800CB;
	Tue,  7 Jan 2025 07:48:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jan 2025 07:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736254125; x=1736340525; bh=LLeUiVCduQ
	cy2ic14imFDu4OG/Zk9M2ac9DjCvGcFZY=; b=VhmPMM04yEdqbhhDZ+1v+H2O+C
	bulX6i6MGpmW/+OSNr5tRWIfNsFzyOlgc0bcajrXwsaqNsMJfaZ173he8edl2Uch
	dDEO82dluwoDM+fRifDgdNiIPkcmWS1hOaBAbp/hQX8ZGv3Uz+z5UuonRHjufntK
	cO4903ro9Z1OjC10v+CFY2hSkKQIaiRLyAwPJrB3POl9dJoeZ2mtRq6Ghg8kHMZy
	noMW0Ko3TKUffMWBJiJo1hpRr1x7vOsv/VGljRTaFf/b+AkeeRoKbkG9wxxOSGRg
	siRVwPV91c1/D1wYtM0Q8+nB0hYvLPbNPLjnIp18aloPdPDw2kANncnSi2gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736254125; x=1736340525; bh=LLeUiVCduQcy2ic14imFDu4OG/Zk9M2ac9D
	jCvGcFZY=; b=NqUo4ru7/MR9U2oDYVNpCJDmirX/K8abN/o3laN8G3uB6aZEpOS
	oYAFau2KiU6xWcRkApNPwAnEB4zgQK1PAiCtluG8dpbr6ah2yv1lPAOuvvLGiVtK
	WV/hMCBZOE6nGk6kaYvdfd+EwLmVkKeXs1sHl2IWfGQe9LOky9JeWRdAXAQVur8n
	InISSdk+JU45CqQz2r9mdSYAB5BOae7XcNyBDrpCU3kLRGA0Yb7TC1wsq8upIdKl
	dkDpciUqv7OS+SySKXSQScCC51zDCyqz5EFhaiaH/DsSGctdJT2pmeVaaKGw3Prh
	X6i2Yr7+u0B8WbkLP7PUEjwnWmMlbj1cD6Q==
X-ME-Sender: <xms:rCJ9Z6PnCV9_fpRF4JZdhX9QJbdT6C93qKl_s_mt_XCOKrZkmnNuNw>
    <xme:rCJ9Z48ujolqphatbK-kofNz3pbeO5SewfjxV6DE3WtU96pGzSavbHaGSZkA44_Jn
    LZ52YpM_EVm8rmBgw>
X-ME-Received: <xmr:rCJ9ZxSlkjQhOa5DtSUjcjeSXHxIGjUquDkMUL2KCtcs4ug6KwunwCIXq5VhhWEhWTuV7gbg6DQq--2cFSOpyHy6vcr9zGS500m87dunPHbiEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rCJ9Z6utE-5ynxSxmfoh_7wc3VpAdBu9dbmP1sPCVRNO1-WUf8IaRg>
    <xmx:rCJ9ZydYUKzR14HIKYTP_GYzNQLuUnhj-vyH0qplU1z1_bm5aBmUsQ>
    <xmx:rCJ9Z-0uQyTPMknLkyUEPyULm6LPiCGffSVJqkNKm6R2laqZVpk41Q>
    <xmx:rCJ9Z2963QfalU7kqqDKKjrVetCGSpw80UxSuklahh_7Ki4ZhwEj2w>
    <xmx:rSJ9Zx5IlIqtq8_vedVmyHz9Zu64YVzMpr2xtq5IHtgYfH7RiVawHBoM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:48:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 371f12b7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:48:43 +0000 (UTC)
Date: Tue, 7 Jan 2025 13:48:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z30hnx43mEwjWqzA@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
 <CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
 <xmqq34hw0whh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34hw0whh.fsf@gitster.g>

On Mon, Jan 06, 2025 at 07:53:46AM -0800, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> > What I like about the removal of git-pack-redundant(1) in the previous
> > patch is that we started to emit a user-visible warning in 2020 and
> > now users even have to pass an `--i-still-use-this` option to be able
> > to use the command. This really makes sure users cannot ignore the
> > fact that the command is deprecated.
> >
> > Accordingly I think it would be nice if we started to emit warnings
> > (that could possibly be disabled) when we find a repo still uses stuff
> > in "branches/" and "remotes/". These would be much more difficult to
> > miss or ignore than doc changes.
> 
> That's an excellent suggestion.  Even though this topic is about
> introducing breaking changes, saying "we waited for long enough",
> making sure we have prepared the user base for such changes to
> lesson the impact of "breaking" changes is a very prudent thing to
> do.
> 
> I guess everything is contained within remote.c these days?
> Patches welcome ;-)

Makes sense indeed. We can easily add for something like below diff.
I'll roll that into the next version, thanks!

Patrick

diff --git a/remote.c b/remote.c
index 55e91fab47..8c104c6ee1 100644
--- a/remote.c
+++ b/remote.c
@@ -309,6 +309,13 @@ static void read_remotes_file(struct remote_state *remote_state,
 
 	if (!f)
 		return;
+
+	warning(_("Reading remote from \"remotes/%s\", which is nominated\n"
+		  "for removal. If you still use the \"remotes/\" directory\n"
+		  "it is recommended to migrate to config-based remotes. If\n"
+		  "you cannot, please let us know you still use it by sending\n"
+		  "an e-mail to <git@vger.kernel.org>."), remote->name);
+
 	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_REMOTES;
 	while (strbuf_getline(&buf, f) != EOF) {
@@ -338,6 +345,12 @@ static void read_branches_file(struct remote_state *remote_state,
 	if (!f)
 		return;
 
+	warning(_("Reading remote from \"branches/%s\", which is nominated\n"
+		  "for removal. If you still use the \"branches/\" directory\n"
+		  "it is recommended to migrate to config-based remotes. If\n"
+		  "you cannot, please let us know you still use it by sending\n"
+		  "an e-mail to <git@vger.kernel.org>."), remote->name);
+
 	strbuf_getline_lf(&buf, f);
 	fclose(f);
 	strbuf_trim(&buf);

