Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2B18A93F
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850667; cv=none; b=hCaIC8SjgbnqX4j402A0PMEUQ9pzVGy76WdEIdBbT0U+tP5YI5sOL9jDbHHT7L6dudaTKzuEYNYctvxNnsvz4wEtJiUqcVxY5HE4XRr/s08RDqFyswdUa35WLcSYVJSOUSeDoWMYUPACJKMLHq9fF+9uiCJiVXU5dyKt38K+6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850667; c=relaxed/simple;
	bh=vssGAHCK3WuP9V7+b8IV6zaa+zgwDvdG2GTTPKDlNGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzKpaMlVHeV8w6GpMcEY7fdgDzfXcYrlN46Ex0as/tD3g05DpvwH2byeE5HRJbU4/XEDCNkmL1ccxxRa6TKbcjt0lRWianioB8NEfQEG9B1yk1wAxd/xUmIMmgjX+KuIAS+xLbsG0tAn7FdtQ1JZNrn8X0pKzCea+slTP3i3fSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VTj+ssv9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QPkGoqTu; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VTj+ssv9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPkGoqTu"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FAD5114012C;
	Fri, 25 Oct 2024 06:04:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 25 Oct 2024 06:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729850662;
	 x=1729937062; bh=1rmV7kRcLouGDhR4cbI+4WcGU491tTLktWpWIkQjYfU=; b=
	VTj+ssv9dM7prCKxsu2hcuty/FVQ7sL8M3Y9ZGURJtPpJUDYZ3bn11NuICcrPyOv
	XoU1c67vPeKQDlGqULz1AHlPvyjnlS2aN1R7pnqoP2tyKC26WeHTdlLUzQVR44yY
	Mj8dYvUsVt2ueGsV/iGnj/PtWI/Jgog3In+y+Rs8aWZDnlMYgsttc+OOK4Y36/fc
	v7Gj2Mgx/kkwRoKDHbSBov8XSqFv35O5AmNBAmR+F44j9/4r8OrGY6cztD0YsAas
	shjHXpvxp7PKNP9Io24JCIfumnYZBDr+qtziOzsYpaYPagRAMe3+k8GEwrRBeu8b
	GsM6vmJSj7L95i67Lim4bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729850662; x=
	1729937062; bh=1rmV7kRcLouGDhR4cbI+4WcGU491tTLktWpWIkQjYfU=; b=Q
	PkGoqTu7vw7/XOZhqzm8rjfIknXrfhXGD8OFY6uRGGaeA17mAcM1dky6qOnaoIHG
	Ka3xQFbeqe5O9vFJmtuvEKDEytHtRnVrlXyNXtB5LvA5YLaiqkbpIxvInn9TWf1S
	nHdJLAchy6iU9h0NDUnoYZEQO7RUT4D+7BxULgOv21KVQYnNhY2DwKQ6YYZfmEL4
	tmPRagWRZQvR716++QLH05QDFphsiS22s0XX3dfj8HiusUtGGWntsz7vrDXMxv9j
	D45rTR1DyC2OIOSx1WE5lFdpDQaKPpn4lckKl8wjYVmQ7A7cEACCEawMAD/UBFG8
	lTQULPf7H++dBLE3qlN9w==
X-ME-Sender: <xms:JW0bZ1UiEMB_vUGB54pnmsAyT7GBLc0BC7tA_Xuef6QkDFunMsYziQ>
    <xme:JW0bZ1kYCeqc7uDIXg8kWG7OZNNPxqeQDoweb0XabtIVX6PgA75BkEU3peysKlXwj
    -jjI6eKA-9rtagx2w>
X-ME-Received: <xmr:JW0bZxasK2kzcu0C9bSVyTEuWmhgUxRqjeowO_XUzUm9ElFiZ8OpHKQrghd046qUmqnYciyl_1FMuG0FsSjJ9Lf2MCpwESKYckse0z017adAzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedufedufeegheefueegiefhveelueejfefhtedtuddu
    ieegteegheetudfftdelieenucffohhmrghinhepmhgrrhhkughofihnghhuihguvgdroh
    hrghdpohhuthhrvggrtghhhidrohhrghdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrsghrrghhrghmrgguvghkuh
    hnlhgvhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorh
    hgrdhukhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:JW0bZ4V1XwHkYNPhQNN9xDdFd5v0XocmUp9CesXgdGeLjN6jk6pf-w>
    <xmx:JW0bZ_lLGkIcfYB37W_X5EF5VJ66qPkgXg_WVvoILCMhvMxJjkfRoA>
    <xmx:JW0bZ1er5j3ygQ3KqHzh-SsFzVpwcpFih5UKYIdPbGounJjy-7Wfmw>
    <xmx:JW0bZ5Gv-HGH7DhSjGHJUVzAbWVOs1_GPSonQkxnWbBL7kjFoCNTtg>
    <xmx:Jm0bZ6v_cJkTilrA0IUxFz6OcX03bD-z2WtuWbuiWlhBQMDh43q-X6uh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 06:04:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a8486ed2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 25 Oct 2024 10:04:17 +0000 (UTC)
Date: Fri, 25 Oct 2024 12:04:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Samuel Abraham <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	christian.couder@gmail.com
Subject: Re: [Outreachy][proposal]: Convert unit tests to use the Clar
 testing framwork
Message-ID: <ZxttGFtt5nnc7g9Z@pks.im>
References: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYq+fZBGZiTQduQ+4KcQ7H2Hysb04pg8YR++8PWAkQOM76OPg@mail.gmail.com>

On Wed, Oct 23, 2024 at 10:45:52PM +0100, Samuel Abraham wrote:

Thanks for your application!

> ## Project Overview - Convert unit test to use the Clar testing framework:
> 
> I understand that the Git project is in the process of converting its
> unit tests to the Clar testing framework to improve test readability,
> consistency and maintainability, a move away from homegrown unit test
> frameworks such as t/helper/test-tool.h and t/unit-test/test-lib.h.

Nit: we've basically moved away from test-tool for unit tests already,
to the best of my knowledge. So this is more about the second part,
moving away from our own test framework.

> Clar provides a structured and efficient way to write and execute
> tests and is well-suited for a project like Git where robust testing
> is essential to maintain quality and stability.

It would be nice to provide some pointers _why_ we think that clar is
better suited ;) Hint: you may have a look at the patch series that
introduced the clar for some ideas there.

[snip]
> ## Project Plan:

Formatting of this section is a bit funky, which makes it harder than
necessary to figure out which parts belong together. I'd propose to
first provide a high-level list of the steps you want to do with a
bulleted list and then maybe put more detailed explanations into
separate "### subsections". You may also want to convert links to use
[Markdown syntax](https://www.markdownguide.org/basic-syntax/#links),
which provides some structure aronud them.

> The first steps to migrating existing tests to Clar would be studying
> existing tests in the t/helper and t/unit-tests directory which will
> enable me to determine those appropriate for conversion.
> 
> Liaise with mentors and community members to determine the viability
> of converting the selected test for conversion.
> 
> Convert the selected test to Clar while in constant effective
> communication with the mentors and Git community, implementing
> feedback and review suggestions.
> 
> Properly test converted scripts to ensure validity and correctness.
> 
> Steps to converting the existing unit tests to the Clar Testing Framework
> 
>  From the project description in the Outreachy Project Description page,
> 
> 
> https://www.outreachy.org/outreachy-dec-2024-internship-cohort/communities/git/#convert-unit-tests-to-use-the-clar-testing-framewo,
> the goal is to convert all Git’s existing unit tests to use the Clar
> testing framework exclusively.

It might also make sense to plan some time to add missing features to
the clar if we hit anything during the conversion.

> The existing unit tests which would need to be converted to Clar are;
> 
> .c test files present in t/unit-tests: Tests in this directory use the
> t/unit-tests/test-lib testing framework and are “.c” scripts,
> converted from the shell-based testing which used the tests in
> t/helper/ and corresponding t<number>-<name>.sh test files. Examples
> of this conversion can be seen in the link below which references Achu
> Luma’s work
> 
> https://lore.kernel.org/git/20240226143350.3596-1-ach.lumap@gmail.com/.
> 
> 
> The link shows the work done in converting the test from
> t/helper/test-sha1.c and test/helper/test-sha256.c to use
> t/unit-tests/t-hash.c which uses the t/unit-tests/test-lib.h framework
> 
> 
> The steps to convert files located in this directory include;
> 
> - Identify the test files to be converted.
> 
> Examples of such files are the t/unit-tests/t-hash.c, t/unit-tests/t-strbuf.c
> 
> - Rename the test file from t-<name>.c to <name>.c. This pattern
> follows the style used by Patrick Steinhardt in his conversion of the
> t-strvec.c and t-ctype.c files to use the clar framework.
> 
> https://lore.kernel.org/git/604303e31aad3a9e74f7bdddc84f11d4d137c864.1725459142.git.ps@pks.im/
> and
> 
> https://lore.kernel.org/git/ba05b9f1eef8136e087846ee54a076558097a240.1725459142.git.ps@pks.im/
> 
> As a sample demonstration, we will convert the t/unit-tests/t-hash.c
> to use Clar.

I think the previous explanations are sufficient -- going into the
technical details like you do below is appreciated, but ultimately not
necessary in my opinion. What I'm after here is that you have a rough
understanding of what needs to be done for each of the tests, and that
is sufficiently demonstrated by a high-level explanation.

> The test scripts in the t/helper directory:
> 
> The tests in this directory are invoked by the corresponding shell
> scripts which spawn processes to test the different unit tests in the
> t/helper directory.
> 
> The process involved in converting these shell scripts to Clar
> framework will typically follow the same steps as illustrated above
> bar the following differences.
> 
> Identifying the tests to be converted to Clar
> 
> Create a new .c  file name which should be named appropriately to
> illustrate what the file is testing.
> 
> However, the shell-based script which tests the functions in t/helper
> will be studied for in-depth understanding and then refactored into a
> .c file which follows the steps above in converting to use Clar.

As mentioned above, I thought we didn't have any such tests anymore. If
we do, it might make sense to provide an example of such a thing that
needs to be converted.

> Project Timeline:
> 
> Community Bonding (Present - November 26):
> 
> Continue making contributions to the Git codebase working on different
> things within my capacity and getting more familiar with the codebase,
> participating in patches review.
> 
> Conversion of tests begins (December 9 - December 23): Familiarize me
> with the conversion process to further enhance my understanding,
> identify files for conversion and start the conversion process, and
> set up a blog for weekly updates on my conversion process.

Makes sense.

> Implementation of community and mentor reviews (December 27 - January 31):
> 
> Continue with conversions while testing converted tests, communicating
> with reviewers and implementing reviews.
> 
> Testing (February 1 - March 1): Continuously determine the correctness
> of the converted tests by continuously testing and also liaising with
> mentors constantly.

For this one here'd I'd recommend to start more iteratively. What you
have here sounds a bit like a waterfall model, where you first convert
all tests and then eventually test and send things over to the mailing
list.

In the Git community you will likely have more success if you work in
smaller patches. E.g. pick a small set of tests to convert, convert
them, polish the series and then send it to the mailing list. That cycle
would then repeat several times until you have converted all of the
tests.

> Availability:
> 
>  I am not currently enrolled in any academic program or have any jobs,
> and will be available to work on the project for a minimum of 45 hours
> per week.

You really shouldn't be working more than 40 hours per week ;) The
[Outreachy Internship Guide](https://www.outreachy.org/docs/internship/)
recommends 30 hours per week, and I don't expect any more of you,
either.

Other than that this document looks good to me, thanks!

Patrick
