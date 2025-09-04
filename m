Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F52ECD23
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990674; cv=none; b=bGdQsZd2ydFTIiMsVTM7iQNMfjm76vl2lxlh2da0Ek2j0OtupUnRHt/oigsvAfdHMqR7Bh/x/BJfHnc6dI8Hva3OsYlqmexL3rLjlbODtdsGUfGvflWvCF8szaD3ZzN/xBKrEAqNaq4tftzficWGpbFHFaANzTB9G8mrKxGs4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990674; c=relaxed/simple;
	bh=ISkp3Kv46PD6MO4yYrTfu35U/QzFDuEjb/kKQHcZzQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDf8iTbm2VFxS6XUPmXUfgVPqMs3L68psFX2n7l7zYw4mHTu1gF/1pW5TaW3ubOkJs4NWLKGW1y9I1aXVQtstqq676ehEjp1FOo1n4SWIMKNFD2LqqyWTaqV04usWLnPq8vSMyf/6yw05t+U/vRGA85wuMcvc0xqjKaC4oCOgaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UbEr+2Qg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ip3lFjsA; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UbEr+2Qg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ip3lFjsA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0E51C7A03A7;
	Thu,  4 Sep 2025 08:57:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 08:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756990670;
	 x=1757077070; bh=Q8Jki283nITuf99HazDLpSjVQujjIHEUsh6iAQq3lCg=; b=
	UbEr+2QgrYEvc0VnjU71X1SceuvB+CODp9hLnDLm72auwBU7oavsYwmVYyQmduDj
	+rjZejS8/4kQyJbchxQqrEmL6v81CmQiRaZxBEX4YCgwNy3fIx99Zgt915XSzJCO
	Z4thUT5heYuje2H1TeEtLUwVTQ5zBHuH+y4YAUDrhS29SCbjPB4OCS/MnViOzlwU
	+x/SJZx3Oym2HFvPlHvBM8kX4ujhbOynWRH8hfivciwdW2ZFFiHMtQlIS5U/G/dP
	PFRcz3ncEGyKC8y9F96MbzfbpeE/IjqEQI2VBpekWB6Solt6LlvBn5ViPOreCYat
	SH+/DOzrg/hpNcnlYB8xcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756990670; x=
	1757077070; bh=Q8Jki283nITuf99HazDLpSjVQujjIHEUsh6iAQq3lCg=; b=I
	p3lFjsA4YQhPqxP8LfvqVH74ljzaFJTNNxVZON59xXExd4F7juF4e4xPcJOmKV5q
	Ib0xkqvwnXeOqmP1RyWwAgsmplShHUF8wKlIV06erPvfBtW3TPW4rad1AUZu+4Ol
	0F6EcCF+LkrX7dcydEwFoZB973T04pNRqx6vm46TEBrZqVM69b+OoferjF0p9o4Y
	H4GPsqXK/eGd9hnHCKSI7M83xIUy2KnTayvzkiN+U44kRXzDuOqnAiG8QS4T+LCR
	oF0K6Qf/Vjfd8yV4mxs/1DeF8i9LP4MyDPsMQWv5v1lPDTfNpf123gTPa6eTq7BI
	AjbdOBpE9m55y4wesQ5Ig==
X-ME-Sender: <xms:zoy5aDQSxzCVb9iA1HNfrBQB6wKj4bWBNpvW1tYkv0gF0yUuds_k6Q>
    <xme:zoy5aCVUUWp1bxC81VS9S5vf_WCHsmzLRT0V1HrO7lcJP5TrNcYHcBA1UeO-Hd9eC
    dj6BdVeZNgLwRMzLQ>
X-ME-Received: <xmr:zoy5aPR_BY0sI1erpR3Os1qWUVX0VHIT0wr161rYkrdTI4Ydyd3KBMT9Eoz32RoNRfzMX9Gwbpw8AMiAisYNXzAIy_LRc1ZLqjnKgSlsm6cZGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    efheffgeeflefgieduleehueeugfeifeevjeejveelheetvdegjefgkeeguefgtdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:zoy5aEmH8dDTythbQgbO2ZucMXlmDFGdrojXEpTze7swjE1Q_w9C5A>
    <xmx:zoy5aN6P-03usSSc3KbjrpyoTeNIuJrx6T4SfTTK_wcZdyHHoB7eHQ>
    <xmx:zoy5aCgR4M9_WeXqE0KXwnRxh9ugpgwTqduTNLCcueGwongA93rDWA>
    <xmx:zoy5aCE5GuGQPaQUCHCT3-Xnskv2zuJoHgd7JkeNr8lMASlbQ1sB1g>
    <xmx:zoy5aIP8HW9txA1pRWrS9lhHODUpIhNOcyb6HM1AMGQVSWcRyXyv8tLS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 08:57:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc1cc1ff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 12:57:48 +0000 (UTC)
Date: Thu, 4 Sep 2025 14:57:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH RFC v2 15/16] builtin/history: implement "split"
 subcommand
Message-ID: <aLmMycWf-SMBw2bX@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
 <20250824-b4-pks-history-builtin-v2-15-964ac12f65bd@pks.im>
 <CALnO6CBRv-Jvm1FsUAkDSyaNNRXtMukReKzefvCw5-vj=-pnCA@mail.gmail.com>
 <aLgygyUuQCmR25qU@pks.im>
 <CALnO6CAjv0=99AcBLU=z71hGrk0fXp9pWm7wiBF-a1Xd_efrdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CAjv0=99AcBLU=z71hGrk0fXp9pWm7wiBF-a1Xd_efrdA@mail.gmail.com>

On Wed, Sep 03, 2025 at 05:55:28PM -0400, D. Ben Knoble wrote:
> On Wed, Sep 3, 2025 at 8:20 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Aug 26, 2025 at 09:14:49AM -0400, D. Ben Knoble wrote:
> > > On Sun, Aug 24, 2025 at 1:44 PM Patrick Steinhardt <ps@pks.im> wrote:
> > > > diff --git a/builtin/history.c b/builtin/history.c
> > > > index 16b516856e..6d3f44152c 100644
> > > > --- a/builtin/history.c
> > > > +++ b/builtin/history.c
> > > > @@ -517,6 +527,285 @@ static int cmd_history_reorder(int argc,
> > [snip]
> > > > +               wt_status_collect_changes_trees(&s, old_tree, new_tree);
> > > > +               wt_status_print(&s);
> > > > +               wt_status_collect_free_buffers(&s);
> > > > +               string_list_clear_func(&s.change, change_data_free);
> > >
> > > I think I'm supposed to see the changes between the old and new trees,
> > > right? Does this only happen if I use the interactive machinery to
> > > edit a hunk? When I try accepting some changes and leaving others for
> > > the next commit I get no diff in the template.
> >
> > Yeah, it's supposed to show the diff between old and new tree indeed. So
> > in theory you should see something.
> >
> > > I did try to add new diff lines to a hunk, and nothing showed up…
> > > maybe I'm holding it wrong? I'm pretty sure I compiled this version.
> >
> > Do you maybe have a reproducer for this? It seems to work alright for
> > me, but I wouldn't be surprised if there was a bug here. The wt-status
> > interfaces are quite something and I was tearing my hair while trying to
> > figure them out.
> 
> Hm. I have a copy of these patches at
> https://github.com/benknoble/git/tree/ps-jj. After "make DEVELOPER=1
> -j $(nproc)" on that branch, I did
> 
>     bin-wrappers/git history split @~3
>     <input y,q> # once I even used "e" and added new diffs to the patch
>     <type commit message> # no status info
>     <exit editor>
> 
> Then it looks like the 2nd commit gets created automatically. Maybe
> I'm just missing how this should work? Thanks for looking at it.

Weird. I used the exact same branch, command and input and did have
status information in my editor. Note that for now the editor only asks
for the commit message of the first commit. The second commit is
basically retained from the original: both tree and commit message are
the exact same, only difference is its parent.

Patrick
