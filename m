Received: from pfhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACD1D6786
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351143; cv=none; b=KDbojOlx0BD+6qevEdckZgnWtmrHvgde3MWmYesGNqtI1XVdGEqzn4miSSPFm3lWCew3sk+XKhZ6W96C6c7/xXxnYvAQRU5QOgyOFDkAo+nunMEMwHakwkhjDlxe2Gp7Im/uW4zn1/5Yml4zEhMe0E+em3loDQc9/48QIl3V9Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351143; c=relaxed/simple;
	bh=N16gRFAlLYmBWpldg2dA8QAM2VZnoaCamJZSGPSHjAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d35lpIZ8fbJ0Te4bOsNvVhmZK9fZirC39IFP7bpxpg/XaklyLBPO/TclrNM5ar+jbNSqoi9kLm+PiYM41sEKxxVgffKWgqCKCJAj7H69ZISKPLeEA3cZvyYuw7EnfksJAmJAomxPJEPEnQVqYS2VbCbgByFBUW7WjzrRHVnVMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dwVG6imv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjpRbQSN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dwVG6imv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjpRbQSN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 794C3114027F;
	Tue,  3 Sep 2024 04:12:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 03 Sep 2024 04:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725351140; x=1725437540; bh=c9EQmqlKiH
	eiODeYlZ16Qk+byFP3eCr2L9gK4KeWJJQ=; b=dwVG6imvu123PxqshASO7lnMKI
	Ghm0vI7v16CWnq28s26IJU/0F4eQzz5WQaZImlaUcacffnRveHN3Jl84UTE5RnLH
	PwUhNUF5Ry3upovh0RqoVARnGtBfw35utrCtQkkhfXA205NaKdgSRV6pSILKsGLS
	cO5o9hR9H7wO0j5xLmeYYY3UdlIQlJafEplvcYGnzubZAyT1lymsr1f7nQ4IbBL8
	LoCNWFDuDFRp/2Ts5TJmvTVQEreXVK1LVjDRKI++WWVk1KZF1Oy2spe5yyyDhz9N
	44JwONkWn1LmD5Isj1qelSLlT1fvjJK6Y+XODZriFJAxbKa+k0AG+MTFiwEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725351140; x=1725437540; bh=c9EQmqlKiHeiODeYlZ16Qk+byFP3
	eCr2L9gK4KeWJJQ=; b=EjpRbQSNfk+wEwDrg6aID1rHNwL1YllGmn+UUq77VoJI
	O1LZpCXOlaAzq0hrPET4VgM9HwVEyEdy1smQanrg3/uGBPtsH+fx/wi8amdclwmJ
	kh6Rg5BJRok1jTh5H1j0EnDJqjy/HoBjcKAzrn2A5vsDY8CFNoKPDS0v6gNzuzPd
	o588CiX27dXzrO62++W8AV9g23ln512tSecoQJdQISctA/v7Zeq0Mc/eckFCPZh3
	dWm+t05p/MSw9UvX1bxvKPjrZr9GhGm/3AUcHXbjvhlpJBjQM5wnb/ztVsxn98tB
	qiuBFJcIdOXsLMdH1wopkN0729ykuFM56Qba9nElJw==
X-ME-Sender: <xms:5MTWZo6xuEw_GjB6iQTbSvjgAfw8B9UTK4tWwx1aHy_NOAHWuTPMug>
    <xme:5MTWZp5JB7Ut1cln3uFXoRwJZZ6ZEFdEWbxc-UrYdjVSfBvQTwd29OrlTr6YjjxsL
    1vKXLdPGz7C1wCGkw>
X-ME-Received: <xmr:5MTWZnekRnmaFGyEPS90vYDGEmYlWxRbs0NjWlfd1-KMAjl58nR7LJHDCfWgORPKRROiBmnX23xgY1t3I2CG0ZEgnwjZD0WKd1Xe991w6-ha8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehlrdhsrdhrseifvg
    gsrdguvgdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdp
    rhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprh
    gtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:5MTWZtJcbi8rPabWQCVi9BgaW5yABB82kq-8Us6ntB2GQ2ujf-3fNg>
    <xmx:5MTWZsL1PUNSoKPLBP9j6RUAoLH57wF7Ga15hWfQrwfX3GFZA_BsSw>
    <xmx:5MTWZuyL7JdeOhsg2ut0KFjRD7RHxzKQOL92yiiTpx6nAlhVI9qM_g>
    <xmx:5MTWZgItm01PoGSm68X6Mwb3m3e3OADeGBCP2IHnYwh44OtaHTNiuw>
    <xmx:5MTWZhVW_NN8IaHSvPTvAYYb3PW-6Bp6liyuFhSDHPoPkTHusyVrjSTW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 04:12:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 943c0585 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 07:45:31 +0000 (UTC)
Date: Tue, 3 Sep 2024 09:45:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 12/13] t/unit-tests: convert ctype tests to use clar
Message-ID: <Zta-oVnKUNEE86q-@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
 <1ac2e48a7f2d41d60ff56890d8d87125f30c2f76.1724159966.git.ps@pks.im>
 <2dbdb173-9e31-4dbc-a65a-dd952ec1c213@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dbdb173-9e31-4dbc-a65a-dd952ec1c213@gmail.com>

On Wed, Aug 28, 2024 at 02:18:02PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 20/08/2024 15:02, Patrick Steinhardt wrote:
> > Convert the ctype tests to use the new clar unit testing framework.
> > Introduce a new function `cl_failf()`
> 
> This is a nice addition which somewhat mitigates the lack of an equivalent
> to test_msg() that adds addition context messages to test failures.
> 
> > that allows us to print a
> > formatted error message, which we can use to point out which of the
> > characters was classified incorrectly. This results in output like this
> > on failure:
> > 
> >      # start of suite 1: ctype
> >      ok 1 - ctype::isspace
> >      not ok 2 - ctype::isdigit
> >          ---
> >          reason: |
> >            Test failed.
> 
> "Test failed." is not the reason for the test failure

The clar expects two strings, one "general" description and the details.
I agree that it's a bit shoddy to have this as part of the reason, it
really should be a separate "field". But it allows us to distinguish
e.g. between test failures and tests which emitted a warning, only.

> >            0x61 is classified incorrectly
> >          at:
> >            file: 't/unit-tests/ctype.c'
> >            line: 38
> >            function: 'test_ctype__isdigit'
> >          ---
> 
> This is rather verbose compared to the current framework

I guess this is a matter of taste. I actually prefer the more verbose
style.

> # check "isdigit(i) == !!memchr("123456789", i, len)" failed at
> t/unit-tests/t-ctype.c:36
> #    left: 1
> #   right: 0
> #       i: 0x30
> not ok 2 - isdigit works
> 
> The current tests also shows which characters are expected to return true
> and distinguishes between the two possible failure modes which are (a)
> misclassification and (b) returning a non-zero integer other than '1' as
> "true". The new test output does not allow the person running the test to
> distinguish between these two failure modes.

This one is true though. Will amend.

> > diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
> > index 66ec2387cc6..4c461defe16 100644
> > --- a/t/unit-tests/unit-test.h
> > +++ b/t/unit-tests/unit-test.h
> > @@ -1,3 +1,10 @@
> >   #include "git-compat-util.h"
> >   #include "clar/clar.h"
> >   #include "clar-decls.h"
> > +#include "strbuf.h"
> > +
> > +#define cl_failf(fmt, ...) do { \
> > +	char *desc = xstrfmt(fmt, __VA_ARGS__); \
> 
> In our current framework we avoid relying on the strbuf api and functions
> like xstrfmt() that use it as we want to be able to test strbuf.c with the
> framework. We'd be better with a macro wrapping a new function that uses a
> stack allocated buffer and p_snprintf() like clar__assert_equal(). That
> would allow us to upstream this change as well.

I don't think it's all that important to avoid a low-level API like
`xstrfmt()`. But the second argument makes sense to me indeed.

> > +	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
> > +	free(desc); \
> 
> This is leaked on failure due to the use of longjmp.

As discussed elsewhere I don't think this leak matters all that much.
But it's getting fixed with your proposal, so that's that.

Patrick
