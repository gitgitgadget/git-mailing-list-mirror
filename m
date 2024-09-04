Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0C1DA10D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459134; cv=none; b=K5P/S6PfnZ9oAJcdlJbJDW0zEPH/arH+93+W+8vSiKqZG2zg2f4zvAVjWNwQr4mPJuh14+KteCrrUSu/SrDUF/HE38sf/bAZze0JF0LpZ+f1daWE0Bg1YNNT8ozCYZyvnXOonMGdLiWD3y8I62+V9X7fSmcKDBjE0nSaWsRgjkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459134; c=relaxed/simple;
	bh=B8tVYtBYyY/USELIMnlcPdlA8Nk40RGkyDA72NMZvmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQsMH8DV2qdnEPE5SPJay7h+7XQ7tAuSIr9XrKsol/9PBaADzKAJYD/ogOIz53p7elV3xz4IHU7Uwx2wV3NTXGQloULcr3K1ex7sNTLxOXl2TuxZqfTn763e0fecXH2TYEnnxMV2uqIXZP8yR7C2S8T20YVXGF8LQ8rs8nWqvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HZZxqqbv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7kRA1+x; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HZZxqqbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7kRA1+x"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F07751380251;
	Wed,  4 Sep 2024 10:12:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 10:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725459130; x=1725545530; bh=wFaLkWvb53
	m97KbNideqPqGTzwk8uCJw3peMzsKmU9Y=; b=HZZxqqbvb4dKTu4kxf/fPkdEMN
	2BuKjl0ejslwM2I94eNdFuic9MNVCnSgBBX/0EJkO16MhDzrkpwywYMHEBR47F9r
	fPT2MpgMMUnwtS4lRmbecZbAQ1ZfQZLU1eK2OZZHxFwdVdY5XqWVtnVmfX9N7w7y
	CO/4jThCxhKqOiFk5/0abGjMOPSFHX9o3Vz993ClhPUWc4ebkcIX3O8qwfkTbqp0
	qTetlR+RDHA0mBrVx1SXUto3kxfLyerbWhlRIsBVcKxhm99MCMSycBy/nrNem4Hj
	YvN+n9cL1oRgdBI5WrrjBSLSfeKL9FtaO3UR2CpWrgGn76iMMXNHOZt+hIug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725459130; x=1725545530; bh=wFaLkWvb53m97KbNideqPqGTzwk8
	uCJw3peMzsKmU9Y=; b=Z7kRA1+xojJd7I9EkUlfJCbwu2NilQdIMDwX0fTZjLGI
	vwO1Qb2Iw5cQLJwSQI6mmswTK60l3LAh6qVoUZylGMEtLQDfISkuSQhKwrO1Mw3C
	UbvIBPdNV50SIce4pgSJ6blqOWSDRSy0FCgom0G0NsX9qmxdeGtYIewSylC1sRVW
	65KqJnbHoVzXaIqwe/RlofUMwmcSSBsYbOp8G+6T3A7aReIEGhprfHR3LA4QfhJF
	/YBmTrAMlcmx6mORmLPoFKJQYFWg3Rk3p3FFVgtrcqODmJNh9YkZj3th2jltb/Zz
	phra61YTpwvlYX+GvCeFf6VLxtvFk4ln4ujTuQJ08w==
X-ME-Sender: <xms:umrYZmfBVttu7XinfEQRekzb4YPHDwiQ4WRFUmi34PD3o50BqQgCog>
    <xme:umrYZgP_nDrLkCLKgPDwg_YlXc3SV3PGT7H5eZ9mMTyPe227kHhAHkxGEW6RCjlnn
    h-Gri3Ed0clgMFD6w>
X-ME-Received: <xmr:umrYZnieGapmXz1XTLvklTP3CAlW1hutrxNoS7GhpVe8w0V8fFQBRW-nD-GF8xllShTtUXS_AsUYOnV_Pp6lnubCOV2lQGSnWK5TiOy6YP8SlJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehrshgsvggtkhgvrhesnh
    gvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhgu
    vghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsphgvtghtrhgrlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:umrYZj-1y9zJwqoBt21XmqXASVudPlOckDpC4U3y9MrWrs7LlZrG-Q>
    <xmx:umrYZiuK6vtzq87-PMCvnPOXqbZpQWvpMKXFnw9rcH6N0aSrd74Tww>
    <xmx:umrYZqESiiUa1Tu20SXi4tsFUQj62kXdDpqRpR7swOA7C9aeipA3Wg>
    <xmx:umrYZhMmkEVhGuWbNVf14f8GvLICAzOZSogIxZ4I7k01eQFDKDOMug>
    <xmx:umrYZsKjxITRkeWkOLVSThk5S04UmwrbvwYVWgPh3DqSgyajLEpuxEKy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 10:12:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07b5d510 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 14:11:57 +0000 (UTC)
Date: Wed, 4 Sep 2024 16:12:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 11/14] t/unit-tests: implement test driver
Message-ID: <ZthqtWVntB-PgSH-@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1725349234.git.ps@pks.im>
 <8bd5b3e2b2989a30b597da2103eb8d9699cf3d7f.1725349234.git.ps@pks.im>
 <e435e05a-376c-4928-9852-6925df855399@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e435e05a-376c-4928-9852-6925df855399@gmail.com>

On Wed, Sep 04, 2024 at 02:35:20PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 03/09/2024 10:15, Patrick Steinhardt wrote:
> > The test driver in "unit-test.c" is responsible for setting up our unit
> > tests and eventually running them. As such, it is also responsible for
> > parsing the command line arguments.
> > 
> > The clar unit testing framework provides function `clar_test()` that
> > parses command line arguments and then executes the tests for us. In
> > theory that would already be sufficient. We have the special requirement
> > to always generate TAP-formatted output though, so we'd have to always
> > pass the "-t" argument to clar. Furthermore, some of the options exposed
> > by clar are ineffective when "-t" is used, but they would still be shown
> > when the user passes the "-h" parameter to have the clar show its usage.
> > 
> > Implement our own option handling instead of using the one provided by
> > clar, which gives us greater flexibility in how exactly we set things
> > up.
> 
> That makes sense
> 
> > We would ideally not use any "normal" code of ours for this such that
> > the unit testing framework doesn't depend on it working correctly. But
> > it is somewhat dubious whether we really want to reimplement all of the
> > option parsing. So for now, let's be pragmatic and reuse it until we
> > find a good reason in the future why we'd really want to avoid it.
> 
> I think that's fine for now. Using parse_options() gives a much nicer user
> experience than clar_test() as it supports long options and has more
> flexible support for option arguments. I'd expect the code that implements
> "struct string_list" and "struct strvec" to be pretty stable so its probably
> safe to rely on those.
> 
> Given there's only a couple of options it wouldn't be too bad to implement
> the parsing ourselves if we have to in the future. We might need to do that
> to support the libification work as I suspect we wont want to link tests for
> other libraries against libgit.a.
> 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >   t/unit-tests/unit-test.c | 43 ++++++++++++++++++++++++++++++++++++++--
> >   1 file changed, 41 insertions(+), 2 deletions(-)
> > 
> > diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> > index 3d12cde6dae..96fa64de71d 100644
> > --- a/t/unit-tests/unit-test.c
> > +++ b/t/unit-tests/unit-test.c
> > @@ -1,6 +1,45 @@
> >   #include "unit-test.h"
> > +#include "parse-options.h"
> > +#include "string-list.h"
> > +#include "strvec.h"
> > -int cmd_main(int argc UNUSED, const char **argv UNUSED)
> > +static const char * const unit_test_usage[] = {
> > +	N_("unit-test [<options>]"),
> > +	NULL,
> > +};
> > +
> > +int cmd_main(int argc, const char **argv)
> >   {
> > -	return 0;
> > +	struct string_list run_args = STRING_LIST_INIT_NODUP;
> > +	struct string_list exclude_args = STRING_LIST_INIT_NODUP;
> > +	int immediate = 0;
> > +	struct option options[] = {
> > +		OPT_BOOL('i', "--immediate", &immediate,
> > +			 N_("immediately exit upon the first failed test")),
> 
> This is unused. If we want to to behave like the "--immediate" option of our
> integration tests that's  hard to implement by wrapping clar_test() which
> requires "-i<suite>". The simplest thing would be to just drop it for now.
> Otherwise as the most likely use for "-i" is manually testing some tests in
> a suite we could require "--run" with "-i". Then we would have one or more
> suite names which we can append to "-i" when passing it to clar_test().
> Alternatively we could include "clar.suite" and wade through all the test
> suite names ourselves to construct a suitable list of "-i" options to pass
> to clar_test() but that would probably mean we have to parse the excludes as
> well which makes it all a bit of a faff.

Oh, that's a plain oversight on my side. It is easy to wire up given
that the clar already supports it via "-Q". Also made me notice that I
wrote "--immediate" instead of "immediate".

> > +		OPT_STRING_LIST('r', "run", &run_args, N_("name"),
> > +				N_("run only test suite or individual test <name>")),
> 
> It's nice that this option name now matches our integration tests. It would
> be helpful to show the syntax for "name" (I think it expects
> <suite>[::<test>]) but I failed to come up with a concise description to add
> to the help here.

Isn't `<suite[::test]>` concise enough? I certainly like it.

Patrick
