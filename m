Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63914B950
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490336; cv=none; b=cyT06pFAQIGhg5+jcJW/RugRej2ddSa7ynlee1folOWvwH+kExDXbOPI3uheg9BgM8fckMg6DJM5WeXsY7eIUekL3MvsP63pVjX79PDwBQy3naiRJr5183CfLgpiGs3F93YM88B/UCf+j8iYsbbxW60gfA5l9Glq1niKv2c1mQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490336; c=relaxed/simple;
	bh=k+YjLFP4mSWH8MnLYuwxi9YF1y6VfJ8l0dtQU+eifY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2nDepcB4VdZiyrCaZu8jcezhsqhE6scZKKXV4ghfhV4qgf6XWhGoMgLmSf1priYWDnuYpg1E5NQyh+qilDdjCjChzky5UTxwR3xEu6ltA+ZV6TcuEIZMWlwzAQAvMG3+6h57TKoUKAtfUlMdXbLVxMJdLwSzdbZ6Ioa4lMGauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=npAijgqO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQWmLwZK; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="npAijgqO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQWmLwZK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D1BF1D001E2;
	Mon,  6 Apr 2026 11:45:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 06 Apr 2026 11:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775490333; x=1775576733; bh=Eowrd1qIfq
	Xcd9IJiS3bqb5sEH7eP2uVAyUWvfL3LX8=; b=npAijgqOYVu3qPj3U1WgINWz+S
	5Zk613JJTP8YYJw27IS2xj/C2iO+YY+JwZPnQ7G5g2j6F/Fkcv/LXTHymIhDWMuE
	HfjFSVVD+DY/p/r6QT9ndsFrmRgbdyzufz7zue6fdO6vbnWQ/X9S2Anuo/Rw9Qwg
	f6ciMal3JQk/MTtyXy0VJawGySoY3rnrmZactH3/Iul4ojl7KOIK3mhw1L+8PrDR
	Ys3ZxBtHk0CZwPrHyx04SbC/5hxBiXHAsKYc0wkmxp2d4Ehr6ToLE8Ao+AbXAciI
	+79jerPls5OgXVmk96R8q2o79H0cuMxOL4yUBhIkeiey8kOa9W74VIye/H6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775490333; x=1775576733; bh=Eowrd1qIfqXcd9IJiS3bqb5sEH7eP2uVAyU
	WvfL3LX8=; b=dQWmLwZK7Ks07nNG5oxVkHnzrsVd9UIeGau57J5CMKSIXfmucZH
	eQ2I2dSLMyTVMdQ6uONDWwEjkx1XwAIJT7qI+TNmjc6S9Za76uHEBqrw5qofdrr7
	fy/77UgPpofzN2eR7/gxNuJZtUMTlwWqQVYmVmqWYN7dYUn1Gqw5pk4KZ63SNTDY
	fStVDu9TSf634uA9MRHPiI6xZBDvAwLJoYx96PWS5bl02wgZU6rDlDfb/3ndUaVe
	d5cxzyobHINmymIJEFPaWS6YMN3aWB9ece1GZf806kX1D/rj1mXWbNnEGYWSwzj3
	lLQjbG0Fol0hfF0P8nLdwxFzan+6jQdl/4w==
X-ME-Sender: <xms:HdXTaXCjzf73D4QXyO9V9aIHBnm314HW_x-UmqRkw8GFqyh2epWQaw>
    <xme:HdXTaUj302yBFohF77CYouZ_nwI-oAFdyl8abn1XAGf1iREY5oeGbwCxa6bWU9oyt
    42UpR0-xBNadiyYaI59fbWVgDTnwaPB60g5xLmfnGzkctDfiTn5kg>
X-ME-Received: <xmr:HdXTaXkHtZp9ohYn1QfPUD9ebU9CUxeKF3GnIcXUrG5Lt2P6J-WpRTQXkDVfmhAqb2ICgqW-420fP3njfCNaGJg3-X_F_TvVPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HdXTaYrydi7ue_3_6PQudTh9i2OydROQPqHe47QvAYaULI447Xz1aw>
    <xmx:HdXTaYF2BpeRy_yuuEV2RvOq3RPjEkTNDKzMO3ttBFDat1aJOwuBrw>
    <xmx:HdXTacyouofAyp0ToAJWFKUefyM8dGbU5sTfakP3yePLXlxgBm7BKQ>
    <xmx:HdXTaVo6HIr0zzn5HtKTPgikBCgJp1iC1Ee_63pvI20PUVCV1CtSSw>
    <xmx:HdXTac8XOID42NosMOsRizbgxmvItSUmGR-4g2Xg1v7QZAjSNsopcIDW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 11:45:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 00/17] tests: access bare repositories explicitly
In-Reply-To: <dcb8c6f1-1410-9f04-c389-6f69ac4fe842@gmx.de> (Johannes
	Schindelin's message of "Sat, 4 Apr 2026 21:45:31 +0200 (CEST)")
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<xmqqeckxqld8.fsf@gitster.g>
	<dcb8c6f1-1410-9f04-c389-6f69ac4fe842@gmx.de>
Date: Mon, 06 Apr 2026 08:45:31 -0700
Message-ID: <xmqq1pgsdrdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Shoudln't there be a patch [01/18] before everything else that
>> updates Documentation/BreakingChanges.adoc to propose the default
>> change?
>
> Well, yes and no. There should be an update to BreakingChanges to propose
> that default change, but obviously it should not only be a documentation
> change: It should also adjust `Documentation/config/safe.adoc` to mention
> the intended change of behavior, and it should introduce
> `WITH_BREAKING_HANGES`-specific conditional code in `setup.c`.

Ah, very true.

And of course we'd need some tests conditional to breaking-changes
prerequisite in the meantime, to make sure that the default is to
allow "all" before breaking changes, and with the prereq the test
checks the new behaviour is to deny by default.

As to the changes to existing tests (i.e., this patch series started
doing), they have a bit of balancing act.

 * Most importantly, they need to make sure their indivial
   operations, when working on a bare repository is allowed in any
   unspecified means, continue to behave sensibly.  "git log -p" in
   a bare repository should still produce patches, "git bisect" in a
   bare repository should work and assume --no-checkout, etc.

 * Then all of them would need to be somehow told that working on a
   bare repository is allowed in suitable way.  For most of then it
   should be done by setting safe.bareRepository in the global
   scope, just like many tests specify the default branch name
   upfront just once (this is a tangent, but we should find a way to
   get rid of GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME variable support
   in our binary and instead set it up in the test environment's
   ~/.gitconfig), some may add --git-dir=., etc.  But the primary
   focus with this change is to preserve what individual operation
   each test wants to validate (see above).

 * There may need to be some tests behind the WITH_BREAKING_CHANGES
   prerequisite that makes sure that the access to the repository is
   blocked without the configuration loosening the condition, but
   they hopefully would be minimum---unlike "how this particular
   command should operate in a bare repository?" that vary per
   command, "no command should work in a bare repository unless ..."
   that is enforced in the setup phase do not have to validate each
   and every command.

> And, crucially, it should pass the test suite under WITH_BREAKING_CHANGES.
>
> To do that, a lot more needs to happen than just the 17 patches in this
> here patch series. Most of the additional changes are quite mechanical,
> and can be validated relatively easily despite their sheer number. And
> only at the very end of those changes can that `safe.bareRepository`
> change even be proposed.

I agree with all the flow you propose here.  And for that process, I
think the early parts of the effort (i.e., there ~20 patches) that
prepare existing tests that make sure the operations of individual
commands in bare repositories should be kept to bare minimum by
freezing the world to allow bare repositories, just like initial
branch names are frozen to either 'master' or 'main' in many test
scripts.  Adding "--git-dir=." (regardless of the "-C there") you
proposed in the other thread is a valid way (but it may be tedious
to do and verify); doing "git config --global safe.bareRepository
all" upfront, if it works, might be simpler.  Any approach that
would achieve what we want is fine.

> I plan on proposing that patch in due time, to start the discussion
> whether or not it is a good idea to change the default of
> `safe.bareRepository` in Git 3.0.

Yup, I do not think it is a bad thing in the longer term, even
though I suspect it might be a bit more disruptive than others
we have in the breaking changes document.


Thanks for working on this.

