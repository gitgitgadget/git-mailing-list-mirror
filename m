Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A2D72632
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113817; cv=none; b=ZBM4+IpIDeSdTEIeVszFImNcJQ42Hr4ecpctuNScMj0VIilbkjnqga9nsqcBDfDNETe5sEOz7yU0kuedYhRHHauc+QU4Ljda2Cvq+UaVgzKyveyfgW3K/8cfbTu97oO+dWHUVcFPzMY9QqcfChzE+jZ4RnJ12JMj3Zg3cehcofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113817; c=relaxed/simple;
	bh=1/2fLvRsxRZg3Lyz+1ghFc3EeytmhaudOv/uM+w5tPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPjp4KfqeEavFO2b8TQwXEY6RfQV4GVsL4S0KH4pK0O66il/IXHA1nM/4VPnuulvRojf1o6EGtdY59NLx7jvH5TJV/wpfxz4bzOL/wKbPLqrgvpKXzuBEud4C47WZHbHjusMuRJQbSLdKWnP4WBZ8w0PCpk/AIxSINjT5nKVh6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mbGSDjNd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xnuqe1Mn; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mbGSDjNd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xnuqe1Mn"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E53162540082;
	Thu,  5 Jun 2025 04:56:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 04:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749113812; x=1749200212; bh=JdOmCgNoqN
	5x12ANOEFJGHOHmUgpsTCaprsfDTJgNxo=; b=mbGSDjNdE5lo/fVj/oAuVrWxF6
	RBk9XZHsxPC5zuSRqtOUNw4349XhCnmVyXexXDYEwYgQ2ntH7sjEf/3JlrP0dmll
	yv69e6P+c32VxxrBcOU//OmAXippMeMnfx+Bvbl8z908PZjUVKE9RxE8SXQe0F9S
	bDH8DqX+T9Yhe5js8fKLLZdVLgWcIU5I/0DjKSp1v2kICsinSld0tWeyhKUe0RSB
	Wp9+Yg/sjyJ2vMNiyyZQ/mN4L/QYlRNBiEqbHNMx4enGWuBvDGt7K6YVd6VQyusw
	QOZn3PCCjL/bTrKWk8qD5coHjtAtbEOrPyRXjSZmjR8wc3wJqYPOEVh7BXuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749113812; x=1749200212; bh=JdOmCgNoqN5x12ANOEFJGHOHmUgpsTCaprs
	fDTJgNxo=; b=Xnuqe1MnXE+L9904dY1eVqKXC9e9Va0/g1NlMh8ydyXF+s+6J4n
	fGRrr0PDq8/ODTyIZuf6eWLDPsAeANGhNsu+4zNkAIgnP1EQcnjsD0Wbv4VBizTe
	aJAu/WfBnkuCFIzvF0MQYHWLnqDteCIxBro3vmebPtnaJVXwAFzdZUKbkpu05ILH
	H7/1giQerKJEjFPytnX+VnCpNvFHU+HxHc3GNHud/ZpAJFuxzt5CRiIP5bL0Nmci
	CfpjQ56E3xolW11Of4iLyQIq/DAkrh4gg0VMmmEMVUoP6rU9yJdc5TcvQ6lfOrgL
	KRa9dxdf8eQUhRaCdHnaA30jJOt+nlhh2ig==
X-ME-Sender: <xms:1FtBaPsTrkrT4xiAj9A4RovK3-zx4lqh6erCjLLVNrI0YBiLP3zGwQ>
    <xme:1FtBaAcgbI80YlcD-9uXwWnTm11Fmv3zJxqiT5gbqIFY9OYyixEOw4PENF31xWdhO
    lJQE_DwRZkhVDxffA>
X-ME-Received: <xmr:1FtBaCxFpMX8RzEKXaTOVZAvwNJR5dVD8kxwAeAsbITPiWzx3pRRNUoBEbWsufPV5VCIIcoA0gEyT5G6Ty597_bH-wibhQANJ6YAbR8nww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefgeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsg
    hrihgughgvrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthht
    ohepthhmiiesphhosghogidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:1FtBaONniu7WGg-GFo0aMi2UHLH2ZnOwMULZZuWHrsv7-iQX2-Qfrw>
    <xmx:1FtBaP_xy8UHQdRjAWwMDNjqaadJwlDMN-N7BMA9nxj-KSwrX5e_5Q>
    <xmx:1FtBaOW_Oy3V3yo64ZQF5gKVHZgUX3z6iEb0fQ0fYarytIfj1mJ6yw>
    <xmx:1FtBaAcEkuAIBlg4T6Ol0yFfJfdJskkKwTclQ7CqQ2HP7T6GBQryxA>
    <xmx:1FtBaNg17cfKfJY1FmQf3NrtM4aDRzt1AVLEw9UNotLs9qDGCoHRPpvR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 04:56:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bffd8957 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 08:56:49 +0000 (UTC)
Date: Thu, 5 Jun 2025 10:56:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Johannes Sixt' <j6t@kdbg.org>, 'Junio C Hamano' <gitster@pobox.com>,
	git@vger.kernel.org, 'Todd Zullinger' <tmz@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.50.0-rc1 - Test Failed
Message-ID: <aEFb0Sjj0Xuu-t7l@pks.im>
References: <xmqqsekgn4gk.fsf@gitster.g>
 <007a01dbd4d7$89ebf100$9dc3d300$@nexbridge.com>
 <007d01dbd4d9$356ded70$a049c850$@nexbridge.com>
 <aEBPdFXpIca7lMls@teonanacatl.net>
 <xmqqjz5rcz90.fsf@gitster.g>
 <44fe8627-5680-443d-bf02-a6e85afd46b4@kdbg.org>
 <010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010b01dbd5f1$3c26ec20$b474c460$@nexbridge.com>

On Thu, Jun 05, 2025 at 04:09:54AM -0400, rsbecker@nexbridge.com wrote:
> On June 4, 2025 3:25 PM, Johannes Sixt wrote:
> >Am 04.06.25 um 17:17 schrieb Junio C Hamano:
> >> So the build procedure for git-gui (but not gitk) has changed rather
> >> extensively after we tagged the preview before -rc1?  Honestly, I
> >> would have preferred to see a change with this impact go through the
> >> regular 'seen' to 'next' to 'master' way before -rc0, but that is
> >> water under the bridge.
> >
> >I don't think we ever had such a cycle for gitk and git-gui. I carry inofficial branches
> >'j6t-testing' in my repositories that interested parties could track instead of 'master'.
> >I would be happy to hear that people actually do use them.
> >
> >> I do not spot anything obviously wrong (and it is not expected that I
> >> would---we wouldn't have this code sent to me in the first place if
> >> this is something I can immediately notice).  git-gui/Makefile sets
> >> ALL_LIBFILES to $(wildcard lib/*.tcl) and then does
> >>
> >>     $(SHELL_PATH) generate-tclindex.sh . ./GIT-GUI-BUILD-OPTIONS
> >> $(ALL_LIBFILES)
> >>
> >> So the error message in Becker's message, i.e.
> >>
> >>> /usr/coreutils/bin/bash generate-tclindex.sh .
> >>> ./GIT-GUI-BUILD-OPTIONS
> >>> usage: generate-tclindex.sh <BUILD_DIR> <BUILD_OPTIONS> <LIBFILE>
> >>> [<LIBFILE>...]
> >>> Makefile:200: recipe for target 'lib/tclIndex' failed
> >>
> >> suggests that $(wildcard lib/*tcl) expanded to *nothing*, which sounds
> >> horribly wrong.  They are source material and should exist in an
> >> unmodified checkout or a tarball extract.
> >
> >I don't see anything wrong, either. I can easily verify your theory that the
> >$(wildcard) produces an empty list by modifying the pattern.
> >
> >Randall, would it be possible for you to find out why $(wildcard
> >lib/*tcl) produces an empty list in your case?
> 
> I can verify that $(wildcard lib/*tcl) is correctly reporting an empty list.
> 
> There are three directories name lib in the 2.50.0-rc1 commit:
> ./git-gui/lib
> ./gitweb/static/js/lib
> ./perl/build/lib
> None have any files ending in tcl:
> $ ls git-gui/lib
> git-gui.ico  meson.build  tclIndex  win32_shortcut.js
> $ ls gitweb/static/js/lib
> common-lib.js  cookies.js  datetime.js
> $ ls perl/build/lib
> FromCPAN  Git  Git.pm
> 
> If it possible that your workspace has extra stuff that does not exist at the time make
> is run. Note that I am using gnu Make 4.2.1 with bash to perform the built/test cycle.

Your "git-gui/lib" directory is missing a bunch of files:

    $ git ls-tree v2.50.0-rc1:git-gui/lib
    100644 blob cfa50fca87827f09b2fc93509e0f249cc03ca6cd	about.tcl
    100644 blob 8441e109be32822df003d3ab3a221d742a74a8b7	blame.tcl
    100644 blob 8b0c4858890f11cf0e3f31536b584e0596f3aba0	branch.tcl
    100644 blob d06037decc1a44ad0f0c153cd461a22a138f35ea	branch_checkout.tcl
    100644 blob ba367d551d217f12cfae3c2f99cd19da58f1226f	branch_create.tcl
    100644 blob a5051637bbc2388c4aab14479ded14d2c41df314	branch_delete.tcl
    100644 blob 3a2d79a9cc3a1ade90db21721f75266d797c26f0	branch_rename.tcl
    100644 blob a98298366763d841d3f88e4478f0afdc6e9a5653	browser.tcl
    100644 blob 21ea768d8036c0ae2ba6bd430c6c667b5ac30c4f	checkout_op.tcl
    100644 blob ebe50bd7d07e8a430096dc8f5813c781839bd0f6	choose_font.tcl
    100644 blob d23abedcb36fd93ab3f12694d607bf354d6cf208	choose_repository.tcl
    100644 blob 6dae7937d589c174132e9f8b9bd77133e189590f	choose_rev.tcl
    100644 blob e21e7d3d0b7924f85c29dad248492e22de0bf39b	chord.tcl
    100644 blob f08506f3834a1ec821390190b920146d83078997	class.tcl
    100644 blob a570f9cdc6a406ef9482802e16c4489cc9873c2c	commit.tcl
    100644 blob fafafb81f1269c1a1a130f66c335f7d4a6f27bb9	console.tcl
    100644 blob 85783081e0d887a7c7857f07670847ef1bc0629d	database.tcl
    100644 blob abe82992b6529cf49983029d85348df5d27ceaf5	date.tcl
    100644 blob d657bfec05b49865627f321ab260633f250f71c6	diff.tcl
    100644 blob d2e0fa60c3ba3f770f525a8d01c66f17826aea75	encoding.tcl
    100644 blob 8968a57f33e37584e3589f03918db2cb89db24e9	error.tcl
    100644 blob 334cfa5a1a59c320e86789ccf4ed3320584a0215	git-gui.ico
    100644 blob d2ec24bd80e12af37ca0099b8aca0bc471cb180f	index.tcl
    100644 blob a026de954c3d9cbfd03d4dec9a73a74647bf74ba	line.tcl
    100644 blob 5ff76692f5eeeb51bcca0905385f51963d1e6531	logo.tcl
    100644 blob 664803cf3fd14c496bbf4b87ca4f7e8e87503ba1	merge.tcl
    100644 blob 8b8c16b1d616b62e5141b4228f1152921bcb86f1	mergetool.tcl
    100644 blob 4b9efab774dc97546f41158ba56b19d20291acfb	meson.build
    100644 blob e43971bfa3e0084e1a306fc82111895a301f905e	option.tcl
    100644 blob ef77ed7399c5b0cc1bdd06f1471d275ffd0ab3ad	remote.tcl
    100644 blob 480a6b30d0a9c9aa4f667a618b0e852d637432dd	remote_add.tcl
    100644 blob 5ba9fcadd17f315a4a47220f91f81ba964d64b08	remote_branch_delete.tcl
    100644 blob ef1e55521d7cea10e280f720ad700a4cd4b71d65	search.tcl
    100644 blob 674a41f5e0c868b70d84202381fec8b5919f962f	shortcut.tcl
    100644 blob 538d61c792defa7a8e19736039fa5a9af630125c	spellcheck.tcl
    100644 blob 589ff8f78aba8273651b33005c6f6abd1db2fa27	sshkey.tcl
    100644 blob d32b14142ff8383bcdfddecd1d435fbea3260a51	status_bar.tcl
    100644 blob f43d84e54fba18b5e2ebf5f9dbf28f3f8db8593d	themed.tcl
    100644 blob 413f1a170079e0cec78ecdbd1adb7baeb83406f2	tools.tcl
    100644 blob c05413ce432d2d37cc2461f1f1a739001c2220f4	tools_dlg.tcl
    100644 blob a1a424aab540663957c96a37cd277ae666287051	transport.tcl
    100644 blob db91ab84a56d79be6a5497f885a9181f368b9cf2	win32.tcl
    100644 blob 117923f8860bb8f0f04c1664d8cbe38804a59831	win32_shortcut.js

It seems like your working tree is somehow broken?

Patrick
