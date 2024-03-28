Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F59A1BF58
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611188; cv=none; b=Vp18J89V6PZUvxa9WHCX7orzFgFZAyDcsypUNBoECEvG52b9KzYcNszzgW4ehuGNl5j0tJgY54vtAFAJjlDj/SVZ/gAijvuPSu9t/EMVLd7hhwWn1JBcBcxfpZzNkQgMCf0CD2D9dpJd2n4P0eozXjbNF2DhxaBk9a0bvn2DJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611188; c=relaxed/simple;
	bh=FYfYBvCOpbntHhFKok4eOwtPMB+jV0VjCQqZnlDMLZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfpnnSAQhk2hsYRqOxoFnJwo5xHGfW7oAISKWer65HGVlpyxT+KMnDSTbD7tq9lw0NaDZaagxZAGtcULdTD/BWMxZyLnUhqvJwBU1mVeUh1i/SeD7mjQHEQU90cbs9w02tnE3gHX2YzlmxbvfQ76v1ZJQazmIKHEL1Dj3KSaYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BFGloNuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QmvXPWSK; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BFGloNuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QmvXPWSK"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 3DE861C000A2;
	Thu, 28 Mar 2024 03:33:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Mar 2024 03:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711611183; x=1711697583; bh=/kuqB/Cxaz
	WOUmCAyRLNx9G0r8dhZrX+g1mLZO1uu6Y=; b=BFGloNuDBsBXLlzxwG5Jdxquco
	2ujgos8hJeFQ6f9N/DCJTPvxfTo7xaiAlPx+EUs2Aq+eyI4+7aS4vDhAa2LB+gGT
	UAFo5jQl77FucvueT/BpqrZXFiRQkaH36i9KZArUAerOPvQwPd/YBuaZtyKEhFzX
	zWDqilC7g40yKCaXTTxpvIIKnetB7lbD9IohKg4pZH+UodzQxwl53vR4X6qy0NZY
	4qP6GXNuZt7KqPF2ohQQXZ0yheorlzkf+LlzOmjIoN641PBvXsFRnZLuTOffesiw
	WCw8k1ghJAG4NEgBUMNrR2zhSWzwgZUTtBvZ8paKVsJmfCDT+mj6RUuG+W7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711611183; x=1711697583; bh=/kuqB/CxazWOUmCAyRLNx9G0r8dh
	ZrX+g1mLZO1uu6Y=; b=QmvXPWSKT6A6GvQaydCu2Y97M54VbhNwICQKM8HpJaRA
	3+Aw/1JD+qoMBZ8OuoXDCxH1Kbg5uc/tOyvUTDI6Rmx9SSHev9tIWTZF0EVIHlrS
	e2ioCPtjxx1kLVxGUs/ubMu5NOX6MguHrGR9DfZ0zp7wF3RwXdsFZgkH+TT99hXj
	9U/FBVYb72kgIp3u4f+J3wWZIIY7JizqR4bEGjNtFdG/RYwPYtubOu1oXCeGLy1c
	sd1p7jDy9V6mrJVO3GQ371P6JTyoKEx5cACSZIaQwba7RsoaV2045bpPVdozxcwx
	ZPcFxP3r723Kani7CMUa6xD1BwV0/6oQg9tsX9gUIg==
X-ME-Sender: <xms:Lx0FZkIPRLje7ZvMKRr2SnFZpt4GXwAMZdXGWXa8LbKgytYzWfBZ7w>
    <xme:Lx0FZkLnfS9wa6XEahXzlZlggqd7S9C1oBs0BIhKkHntj-kwxcaQMiC6zzGFP-Ncn
    DH4quoTVczYIVrXNQ>
X-ME-Received: <xmr:Lx0FZksbmbrn8C6FBqEZ0xeeV-C0dBjhjpVHt6zzK-nKpL9bUh6TYh1eqv-60MBW7OU4O6oPiwOKlkvZ_ETOrCHvSH0suULNSe_qqoPOD4pYZvk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggt
    uggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguth
    cuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefhudeljeeuhfdviefhieei
    ieeigfeihedvvddvteeifffhkeekfeetgfdvffevleenucffohhmrghinhepghhoohhglh
    gvrdgtohhmpdhlihhnkhgvughinhdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Lx0FZhZtvXkbF7wB_cloimUc3Zz-aPzqxDR5sLIabz_ANttJOs1l8Q>
    <xmx:Lx0FZrb6NObuMWuxav_4lJe4GM8azk67h0CLxwwPtvwimt9JCsY0CA>
    <xmx:Lx0FZtDffBKqjHRxp0GZLwnCKmYCp5OB6ldt0qHg-OuBbmQ9hyM_3w>
    <xmx:Lx0FZha9nTap6FjsZVFbqLNGPILF8Jb9E5R8ydZ3tu-UaAi_kxQOSQ>
    <xmx:Lx0FZmwyS9x_g0DOadNv4X4rPC0iNWHeO-Q6LHlWoUM6ImMkDiKUcrm0-MQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 03:33:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e2d0f9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Mar 2024 07:32:58 +0000 (UTC)
Date: Thu, 28 Mar 2024 08:32:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sanchit Jindal <sanchit1053@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: Fwd: [GSOC][Proposal] Move existing tests to a unit testing
 framework
Message-ID: <ZgUdKU5uynGrJ33f@tanuki>
References: <CAN7Jk_2mMiVjXuF02S14OX6Rjq2jVjNxcUbZvTqhcz_YMnD=gg@mail.gmail.com>
 <CAN7Jk_0hyjx39rrO1PKbEcJQXLtCYkWP7A4mCv01DZu2ffGHyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qPhYIN9YOKR/KfK8"
Content-Disposition: inline
In-Reply-To: <CAN7Jk_0hyjx39rrO1PKbEcJQXLtCYkWP7A4mCv01DZu2ffGHyw@mail.gmail.com>


--qPhYIN9YOKR/KfK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 08:06:06PM +0530, Sanchit Jindal wrote:
> Hello,
>=20
> Please find my proposal for GSOC 2024 for the project "Move existing
> tests to a unit testing framework" at
> https://docs.google.com/document/d/1yWP5GFRksdQEOKtYIEXbNSVb1qlJ2szRvpTcX=
XVvgTk/edit?usp=3Dsharing.
> I am also adding the text version for convenience.

Thanks a lot for your proposal!

> Thank You,
> Sanchit Jindal
> --------------------
>=20
> Google Summer Of Code Proposal
>=20
> GIT (Move existing tests to a unit testing framework)

Sorry to be nitpicky, but it's spelled "Git", not "GIT" :)

> ### Personal Information
>=20
> Name:          Sanchit Jindal
> Email:         sanchit1053@gmail.com
> Qualification: B.Tech in Computer Science and Engineering
>=20
>=20
> Greetings,
>=20
> My name is Sanchit Jindal, currently pursuing my B.E. in Computer
> Science at the Indian Institute of Technology, Bombay, I will complete
> my degree in May 2024. I am writing to put forward my proposal for the
> Git Project to transition the unit tests to the new Unit Testing
> Framework.
>=20
> You can find my Resume at
> https://www.linkedin.com/in/sanchit-jindal-0a953621a/ in the featured
> section

I would recommend to include highlights of your resume in the proposal
directly, either instead or in addition to linking to it. Not everyone
has a LinkedIn account (I don't), and thus I'm unable to view most of
your profile.

If you already did that, then it might be worthwhile to point out that
you did include highlights already. Otherwise I'm left wondering whether
I miss out on any important information.

> Throughout my academic journey and internships, I've gained valuable
> experience across diverse domains, ranging from machine learning to
> fundamental system components like compilers and operating systems.
> This breadth of exposure has honed my ability to swiftly grasp new
> concepts and adapt to different codebases. Proficient in both C and
> C++, I am well-equipped to contribute effectively to the project.
>=20
> For this GSOC project, I aspire to make meaningful contributions to
> the open-source community. My interest in software development drives
> me to create solutions that will offer utility to others.
>=20
>=20
> ### Overview
>=20
> Proposed Abstract
> Git has a lot of test cases that need to be migrated to use a new unit
> testing framework. This typically involves moving code from both:
> * a =E2=80=9Ct/helper/test-*.c=E2=80=9D test helper in C, and
> * a =E2=80=9Ct/*.sh=E2=80=9D test script in shell that invokes the test h=
elper
>=20
>=20
> over to a single =E2=80=9Ct/unit-tests/t-*.c=E2=80=9D in C using the unit=
 testing framework.

I guess these formatting issues here come from the fact that you copied
the text over from the linked doc? Not a huge issue in that case.

> ### Details
>=20
> The Project entails porting the current testing framework (which is a
> collection of helper files written in c that provide various
> utilities, and various shell scripts) to using a new Unit-Testing
> Library. The shell scripts in the original code base setup the
> environment and , using the helper functions, test the functionalities
> provided by git. The new framework utilises the test-lib library that

s/git/Git

> will combine the functionality of both the helper functions and the
> shell scripts into one unit-test.
> Advantages of this approach
> * Unit Tests are a great way to check any program and to test all
> possible corner cases and functions
> * Using this new testing framework will provide a more modular
> approach to unit testing, allowing to create more extensive tests, and
> to provide better debugging features. Such as better debug Messages or

s/Messages/messages

> a better CLI to choose and run tests.
> * The tests will also improve the runtime as instead of running
> multiple process (with each use of shell commands), the program can
> compile and run a single process
> * The approach will also future proof the unit testing as having a c
> library will provide a better base than shell scripts to test
> libraries and other internal features

I wouldn't necessarily say "better" here. It's not like the unit tests
are expected to eventually replace all ouf our shell script tests. Those
test suites serve different purposes, and in general it is recommended
to continue writing shell script tests. They exercise the code at the
user level and thus directly mirror the experience a user would have,
which is generally more helpful than only asserting that one small part
of the codebase works. You can kind of think of these as integration or
end-to-end tests

So the unit testing framework isn't necessarily better or even preferred
in the general case. But it does allow us to exercise low-level
functionality or specific edge cases that were previously cumbersome to
test.

So I wouldn't say "better", but rather that those unit tests address a
different need than the scripts.

> ### Basic Structure of the Changes
>=20
> * For each file in the helper directory I will create a corresponding
> unit-test file. (Some files which are being used by multiple test can
> be ported later)

Not all files in the helper directory are actually unit tests. Some of
them are, some of them expose functionality that would otherwise not be
exposed by Git in a direct way. "test-tool refstore" comes to mind,
which allows you to munge the ref store in ways that git-update-ref(1)
wouldn't allow you to do. There are others.

Furthermore, it may not be realistic to port _all_ existing tests over
to the new functionality. It is perfectly fine to say that you plan to
only address a subset of unit tests, and you don't necessarily have to
say which ones exactly you want to port over now.

> * Each test in the script will be corresponding to a function that
> will be called in the format
>=20
> '''
> TEST(funtion_name(), =E2=80=9CSUCCESS MESSAGE=E2=80=9D);
> '''
>=20
> * The function body will contain the main implementation of the test
> corresponding to the c file ( The helper function will ideally be the
> same with no or minimal changes just to allow it to be called as
> required )

With "helper function" you probably mean the test logic, right? I guess
it depends on the function whether it would be ideal to have only
minimal changes. Given that we also convert them to use our new testing
framework I do expect that some of them may change significantly, which
wouldn't be all that bad, either.

> * Where the assert usually given at the end of the test will be made
> using the utility functions such as check_int, check_str and others,
> (or creating more function as they are required)
> * The Make files will be updated to remove the use of shell script
> with compiling and running the new c programs
>=20
> ### Previous Contributions
>=20
> I have worked on the micro-project
> Use test_path_is_* functions in test scripts
>=20
> Thread Link: https://lore.kernel.org/git/b8d0620d4104106210ecf6a34ada591a=
df01cff8.1711049963.git.gitgitgadget@gmail.com/
> Status: Open
>=20
> I had some difficulties in understanding the usage of gitgitGadget and
> git send-email which are being employed as the Pull request
> alternatives. Having tried gitgitGadget I am confident that I will be
> able to utilise it hereafter. I am having some trouble using git
> send-email with the network at my institute but I am optimistic that I
> will be able to use it after the completion of my degree.

While many folks use git-send-email(1) directly it is perfectly fine if
you don't and want to use GitGitGadget instead. As long as you are
familiar with one of those workflows you don't necessarily have to set
up the other one.

> With the guidance of Eric Sunshine and Junio C Hamano, I have iterated
> through different versions of the pull request, and familiarised
> myself with the git commit pattern and formalities
>=20
>=20
> ### Deliverables
>=20
> The plan is to port the helper functions from helper directory to the
> unit-test directory along with the test defined in the shell scripts.
> Some of the helper tools which have a more basic functionality and are
> being used by multiple test scripts can be left untouched.
> As a stretch goal I will try to port the shell scripts to the new
> testing interface creating new functions for the library as required
> I also plan to keep documenting all the changes made and to keep in
> constant contact with the mentors regarding any bugs or reviews
> regarding the code.
>=20
>=20
> ### Availability
>=20
> I am expecting to be free from my academic responsibilities by 4th
> May. I have no further commitments for the summer and will be able to
> provide about 40-50 hours of work per week. I am confident that I
> should be able to complete about 2-3 files each week depending on the
> files.

I would like to caution you a bit about the "2-3 files each week" goal.
The Git project is comparatively slow-moving, and it very often takes
multiple weeks for a patch series until it lands in the "master" branch.
Furthermore, the quality bar is quite high in the Git project, which may
require you to undergo several revisions for a patch series before it is
accepted.

So I would recommend to account for all these facts. It may make sense
to compare to below related work as an estimate of how much work you can
get done realistically.

> Related Work
> The project has been worked on by Achu Luma for the Outreachy Internship
> Test-ctype:
> https://lore.kernel.org/git/20240112102743.1440-1-ach.lumap@gmail.com/#t
> Test-advise:
> https://lore.kernel.org/git/20240112102122.1422-1-ach.lumap@gmail.com/
> Test-data:
> https://lore.kernel.org/git/20240205162506.1835-2-ach.lumap@gmail.com/
> Test-hash:
> https://lore.kernel.org/git/20240229054004.3807-2-ach.lumap@gmail.com/
> Test-strcmp-offset:
> https://lore.kernel.org/git/20240310144819.4379-1-ach.lumap@gmail.com/
>=20
>=20
> Another testcase has also been handled by Ghanshyam Thakkar
> Test=E2=80=93oid-array:
> https://lore.kernel.org/git/20240223193257.9222-1-shyamthakkar001@gmail.c=
om/
>=20
>=20
>=20
>=20
> Timeline (Tentative)
>=20
> Community Bonding
> (1 May- 26 May)
> Be in contact with mentors and figure out the best way to migrate the
> test-cases, Familiarise myself with the library and previous work done
> during the outreachy program.
>=20
> Phase I
> (27 May - 11 July)
> Begin tackling the harder or longer testcases that will require more
> knowledge of the implementation
>=20
> Phase II
> (12 July - 18 Aug)
> Keep working on the testcases following the mentors feedback

Note that you'll not only get feedback from mentors, but also from the
community.

> Final Week
> (19 Aug - 26 Aug)
> Finish up the remaining testcases, fixing any bugs that may be
> discovered in the earlier implementations
>=20
> ### Acknowledgement
> I would like to thank Eric Sunshine and Junio C Hamano for helping me
> with the microproject and for the guidance on the gitgitGadget and git
> send-email features, And also helping me get acquainted with the git
> PR guidelines.

Patrick

--qPhYIN9YOKR/KfK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYFHSMACgkQVbJhu7ck
PpRh/A//bPU6B+jf/1Dgjs4J+nhhPLobQneNGyg0644vLs6JaRWP1trOjkjQ4pWG
AHeyZIwJOXslkjFFG9hoIWN89iuyUCCLuw/0KlBFEDqcB+gCN8TiCdKmcPBxXsqo
TWDdlDD4gA/dcK/lvn5KRALvyjqoqTuuWkIrxG+mXjtejAQfiew4XCEjNL3nwkHV
Xpe/V1wb5aZwsNnYbMls9Gq/BRqLuKTokiHE6J0wFg0WcKNygEMueDues7W9R3iN
eHtYtpNxrUnmk9Q47c+4+mZpjjc6A1DjhzGBJVvofv/xbHN2BgI+4CTgdubaUxep
sC2oliufT3Xl0vwq5AmekNbZVLOWyLq3MoshQjKDR+FmfBMvcK9bTQTRwFht25y0
9+DS1u3g/JsgsK+kXaAV0fQH6gTRyzSMW/d3QO0G6dbxRUAV475Wcmw2xDvV+2Vl
cWSC2R1oMgPNIVS6XFs5Cw09/sGB8WEe/9hZn/GCKHVRzhltS7m0aa3LG/zmW091
rTo7IM9j2SYlc62YfRQ7FD4ToZ467+0ESdVTWM0mBgmW1R5fgQE9cHvReNEtZ7OA
EeVkIgsrII7U5MTS7PLx8DfqKXDmiqXKI9UBM0Ka19ACx8e8P9rNhISs1WnXdkUo
SZ/Vcqwc6hZNEhsi3eHK3c6f/Y0V3mrqBxqlirxWOmQKfFYaw64=
=wij7
-----END PGP SIGNATURE-----

--qPhYIN9YOKR/KfK8--
