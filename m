Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003426B74E
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871646; cv=none; b=kCI1g8YBY5coGHjr3pOPC9bQb4N7ADSrBm8TSDbFrEvxePtrMkjz/VLBPcIUW7cbpcCBqNQOBd3vG1QQfvLVbK7G0mqeEDyEy3nXOw8fG6Gs437/WR146H6ynWMmIfqVBNFPlneEDZQj9HgF3bCHNrD4XbzvtuCO7GJijMAZm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871646; c=relaxed/simple;
	bh=8SPjwrwSbZoDLnaQ3DVF5Xb6qdBfdvBw3JtJniGD0E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b110qqmtjnXW1jAksdZM63fLBJHoN90MsZ4aXVPXAmJTcy60zal+qGcde6fLy9losVokjNhS4qMSdr/awCP8yrWaAJKqLGH50O02rlJULluQr1xafO4biMd0/mQ79BVNPnhPZvpBOpEWSyfeOV2iyeBjUCnoTgE+ANDyiVbMXYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FUOoTN7I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dzkQhHeV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FUOoTN7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dzkQhHeV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 6029A1D02367;
	Wed, 30 Jul 2025 06:34:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 30 Jul 2025 06:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753871642; x=1753958042; bh=fG8FsVnPIg
	iL10+vTfoKRLoGH3A7FSJnIwGAfY5WMJQ=; b=FUOoTN7I9IMrbKvah1l5uS5SLn
	7pEZIAwAhAbii9xOxaW25BnvrSdHMngqAO0QWV7hEvDDsWUogSxaoE9bIf3h6xSM
	DqCF6hebPQacWMpuMOhXxl4QdV1DV4+Amrx7o1nXL91R+n2sEVDacxUlntRJcAaZ
	A239Q5qr1mG/WoxGO3JAbvC7h5JoS7zQ5Qv5UDe1425wEdDIVfB2a7LFJMaoht5V
	P1ZBM8TPFB8f4RmAAGfJhUQ/8B1PF7bYdlGH8LaxDdPBOIVbv/3rVeqWYrdI1XlP
	/qulKLyrjBEKNV259zayCsCosegLY1T61DuZAUvV+LYHvolEzkb94vd1CGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753871642; x=1753958042; bh=fG8FsVnPIgiL10+vTfoKRLoGH3A7FSJnIwG
	AfY5WMJQ=; b=dzkQhHeVCSusO9UquF0cL+nReawCT0v/pc0+/k72qgM4FM0qtk0
	vdX4Q07YBMXnX04fMTaPB/uWF3O6XH7uImp1bMePlyvqRBLjHjrM4r93kARessIO
	VgR8lYHzMmgcmmEzv9FDqFmjMsS0SDpNZhHgEYoXlJMAweGqJWd3liNqm3v+0Htt
	j3DpV0/ljLiQo0wOgG/Wn1pNZ6+/ai+tOiaIgfw98HP/P/XW+iQUhBMPEmE/oCs4
	iHYjw0T9Zc/m2QPCyfBUnn2QZwuP8hMA0RSe1jOOtyh6QtDCClvadTDJW79haIIV
	rLQQdUyDbv201PyiwLIJW5hEOiKAoo7wpSA==
X-ME-Sender: <xms:GfWJaJWnb8hXLwCAAfDMOb-uEQNo4fl4WGu6KJw6Hm0Kn0Uv7Xa10g>
    <xme:GfWJaGj2Au_FQ0gAkL1Cdh9sGn7nfIcu_mrxhUe_yeAxTvco4WOvZK-Jh1a095H1c
    QNvthRo5m42_rT7pA>
X-ME-Received: <xmr:GfWJaBB4bTpF0sSSgJ-nLXjT1N7O-WGMvcuaUBlhxewZrEmU0tGlB0RPTy89Nk5J6nmWAHlPsCmpgkLNlA08h8VEOzp6p9k1SDcNrVip>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeljeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GfWJaEsNefGSbNshJcE_IXtTuchcAORghxfZhh7D9CSX8ZW7V4Ic8Q>
    <xmx:GfWJaNcIWL4pf0ZIDiQ41-PdCaUjRBkwpuRuPnKqOeBKK9UBMiIHBA>
    <xmx:GfWJaB8-ZD5ntrNL7vE4bvj91co5ciJ16dBR_0YP9mbjLiPRq4Roig>
    <xmx:GfWJaIQtxvnvZxSBiHSC7re1phkwB5i_oZuBLUirvypkeYxFIxPHoA>
    <xmx:GvWJaN0QjN7kGosg-U9J02N8mZgA-U90Lm72LKQ95Gl6YLosw5HxGpUb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 06:34:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20f39582 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 30 Jul 2025 10:33:58 +0000 (UTC)
Date: Wed, 30 Jul 2025 12:33:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aIn1EqDARgpWMN5h@pks.im>
References: <6414dbfd-6f34-48d1-aa3f-3fe7998f80af@app.fastmail.com>
 <6E84D571-CC02-45E6-9E58-DD918B45998E@gmail.com>
 <aIhvcSHrRLG6wcMD@pks.im>
 <xmqqseifqbym.fsf@gitster.g>
 <aImup_QlY0tdBtJq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aImup_QlY0tdBtJq@pks.im>

On Wed, Jul 30, 2025 at 07:33:30AM +0200, Patrick Steinhardt wrote:
> On Tue, Jul 29, 2025 at 08:00:01AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > > There's a big difference though: `git reflog drop` won't ever do
> > > anything for a reflog that doesn't exist. Consequently, we know that our
> > > DWIM mechanism can kick in and resolve the reference properly if such a
> > > reflog exists.
> > >
> > > But for `git reflog write` that's not the case, as you can write a
> > > reflog message for a yet-nonexistent reflog. The DWIM mechanism cannot
> > > kick in here as there is no reflog. So what do we do in that case? We
> > > could of course just pick the first DWIM rule, which would be that we
> > > decide to write the reflog for "refs/heads/$REFNAME". But... I dunno,
> > > that feels too magicky to m
> 
> Gah, another cut-off mail. This is driving me crazy. I have an idea what
> the root cause could be that I've implemented yesterday an hour after
> this mail. So fingers crossed this that this will stop now.

Yup, I was finally able to reproduce the issue. I'm using msmtp to send
mail and have a `passwordeval` script that I use to yield the password.
Recently I've switched to a different password manager though, so I had
to adapt the script a bit. Basically, what the script does is to check
whether I'm already signed in -- if not, it spawns rofi to ask me for my
password.

But: rofi actually reads from stdin, and the `passwordeval` command in
msmtp explicitly must _not_ munge stdin, as stdin is where the mail gets
read from. So this is what caused the mail to get truncated.

So why wasn't I able to reproduce the issue? Well, because it only
happens in case the password store in locked and I need to input my
password. But when reproducing it I already had the password store
unlocked.

The fix is thus quite easy:

diff --git a/home-manager/profiles/graphical/workstation/gitlab/default.nix b/home-manager/profiles/graphical/workstation/gitlab/default.nix
index d47e95a83..3460a29fb 100644
--- a/home-manager/profiles/graphical/workstation/gitlab/default.nix
+++ b/home-manager/profiles/graphical/workstation/gitlab/default.nix
@@ -42,6 +42,8 @@ in
         pkgs.writeShellScript "op-mail-password" ''
           set -eo pipefail
 
+          exec 0<&-
+
           export OP_SESSION=$(systemctl --user show-environment | grep '^OP_SESSION=' | cut -d= -f2)
           if test -z "$OP_SESSION" || ! op vault list &>/dev/null
           then

Finally, another mystery solved. This really has been stressing me out
over the last two weeks.

Patrick
