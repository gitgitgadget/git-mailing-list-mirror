Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3391684A3
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992185; cv=none; b=K7bPX5cgeK/S6R7FFaMFRJTtRSXBXkCseir5GyxuFDvyfIoMOjUUrgtpdzI1PE9qPH/1I/Oe0tb8jzxGPIB7wxIz+WbDHpqCCeUgO2ZS9ssoXY2q7Xr2r1hap57rnbfpqr32fNiDs5U52DqfpT22lwuzXIxkzMFCDwzOi0e/kno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992185; c=relaxed/simple;
	bh=y828w9kBJxC5bIBCB46HDE3mR0VNescxizLQKJORULY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2+o6hTqWnj7J9lDVfcTrK9bUTZ7NfFmQZmIUHx0rHv02krpSNrrSupqq/14ZO5JJrYCFyE1Ga6NxiJx+OnDDwkJJY/ZlL176Thu59z41/KpUt7RkJjV2WLZVkP3H1frQzyV4scXTETNJrY7PQQrU00eDosNHCPbekW+GIzu9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n654RRFk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k99tGhy+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n654RRFk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k99tGhy+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE10025400BF;
	Tue, 15 Oct 2024 07:36:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 15 Oct 2024 07:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992181; x=1729078581; bh=c3IM1QB9vK
	5qT7Qc2cEAJ4UVDOmKSaFHyBuZMZIAgPk=; b=n654RRFkoW0FITj+ieYVh1dM9O
	EJJ8I2PbDc3e0tPuqZhsZpq418rMLGh/ZzFPkC1chvNMX+eTQHUTlsmT2QkAU9HI
	0lSNURnZy6CqAMT2AZtOWr5bHVgmQYndOLevh8l9Xi9IwnNNwq3rSr+GNWwEFOOm
	uylMNuA70UUlp0h1h3WKCK+NRFqwHuxlE+253EoWzHUa5afnIHOBXq+jkK1xcJc0
	mnqY4QvigghJWs1zKv3kCw9c+KWbqhVjJ7KFQEyrW5SFYYdBZewJOLaGbq/vOs5m
	yJ+LgcmoOuaeyrGL/fULqO2EdFzB7Ike0vuw3ZBeU8VbyzaJhSEe0Zm4p8uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992181; x=1729078581; bh=c3IM1QB9vK5qT7Qc2cEAJ4UVDOmK
	SaFHyBuZMZIAgPk=; b=k99tGhy+mYNf48cbFdlA5RmeeAzFdeudIoAh/B3LjJXN
	X4j/JuGNwsQHWXKqdECxp/yh1u8CoYeqha9nECCdRUqFBptu8RH6iFwX/yAUPCJc
	vJygeHBwVN09RhYMKrYvh6rgI6PmlAig6+jST7PhHjzs1QbSwgbob0ml5AqBi1Dd
	+d7gvShuavhLClHWGV1WlqUmzXn2p6ZS8PKHT75vCr4M6Rr/9KLqJuAHsXb5Xv2M
	FzC+OdLPxjhMEOCRtOz/v0Er6iCak7A5wr3hgTw0F7XJ/HcU58KsSNp4MAoH8R+7
	dTLGNGWPXLyqv5ORbj8bK/lti1NuRqn+Z6Qahg0i/w==
X-ME-Sender: <xms:tVMOZzPnVLvRgYP5Yz_fHZyC-dc5Onz13FLOG0GwdM5xORviC8OkWQ>
    <xme:tVMOZ99e2K9UtxoBBE4lQUwNh0t1Xoktzv7KKVBIfilJXrS8OJUqR-DThPjN6Qdo4
    1qCMQbqqhWagdB9ww>
X-ME-Received: <xmr:tVMOZyQXURNXyMkdoArdjU1rnE5lLungrUSH149MwxNeFIfDSYFYRjLIf4LMIpJjGoA329cKuK5zqNogJ3SGbygZfeH899EkNICWy87Oe76JfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthht
    rgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:tVMOZ3ueZOZQRS2vzJRHvO4WdDWN_dUMH3UlE4PSg3OarpsqfRGbcA>
    <xmx:tVMOZ7fA4X5ynquaeJGMMm_tJ5IvkQ4knNvz4HrUysnnblMLEjCOEQ>
    <xmx:tVMOZz0U3rThGCiAcDXbzeM3UWIWcXXALScLKfhRnmQ3-3RdE9jRaQ>
    <xmx:tVMOZ3_9lol_EqP4Ll1Chk68ZPGXXQ5kQ-EpetgBnm7gkbIiA4NonA>
    <xmx:tVMOZ8qNCdJPweBahSL6qhxUgPeIqHwy5vSKxcnMkg-rXZnamcVo-VZ7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:36:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81afed69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:35:02 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:36:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/10] t/lib-gitweb: test against the build version of
 gitweb
Message-ID: <Zw5TqKtLOCvXeDEz@pks.im>
References: <cover.1728906490.git.ps@pks.im>
 <eda73d81139e640f4f942818f6035770b7bc9121.1728906490.git.ps@pks.im>
 <Zw2V/Xy5niJh9dr9@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw2V/Xy5niJh9dr9@nand.local>

On Mon, Oct 14, 2024 at 06:06:53PM -0400, Taylor Blau wrote:
> On Mon, Oct 14, 2024 at 02:21:18PM +0200, Patrick Steinhardt wrote:
> > When testing gitweb we set up the CGI script as "gitweb.perl", which is
> > the source file of the build target "gitweb.cgi". This works alright as
> > long as we run in-tree tests. But we're about to make out-of-tree tests
> > a reality, and there things will break because "gitweb.perl" will not be
> > found in the build directory.
> >
> > Fix this by using "gitweb.cgi" instead.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/lib-gitweb.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/t/lib-gitweb.sh b/t/lib-gitweb.sh
> > index 1f32ca66ea5..c64c87fb87d 100644
> > --- a/t/lib-gitweb.sh
> > +++ b/t/lib-gitweb.sh
> > @@ -49,7 +49,7 @@ EOF
> >  		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
> >  		say "# Testing $SCRIPT_NAME"
> >  	else # normal case, use source version of gitweb
> > -		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
> > +		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.cgi"
> 
> This one I am a bit confused above. Could the same thing not be
> accomplished with the '$GITWEB_TEST_INSTALLED' variable above?
> 
> If not, why not? And likewise, I believe the "source version" part of
> this comment would need an update.

In theory we can, but it goes against the spirit of its intent. We do
not want to test against an installed version, we want to test against
the built version. And the built version is not "gitweb.perl", which
still has the wrong shebang and replacement markers inside, but it is
"gitweb.cgi".

This used to work because with our Makefile, "gitweb.cgi" and
"gitweb.perl" live next to each other in the same directory. But as soon
as "$GIT_BUILD_DIR" points somewhere else that is not the source tree,
it fails because we cannot find "gitweb.perl" anymore.

Now this change here means that you cannot test gitweb without building
Git first anymore. But I doubt that really worked in practice anyway,
and I also doubt that this is something we want to cater towards in the
first place.

I'll update the commit message accordinly.

Patrick
