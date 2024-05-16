Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9E1E511
	for <git@vger.kernel.org>; Thu, 16 May 2024 12:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862988; cv=none; b=Am4GHbqKhEl5LfA6+hFTc9HhppxxbKDRyuXoecB36juOqQroNk4bgf9QUTbMhvWZptsXEP259zyzSj3m5k2gUdgJb+OJ+I0UAq4bwKw1VIESH4vrB5rwKBpTqM3qFIrMuyXrC20CRYQ97kBABzu/GpAwwE81m3e5vJpqIoVGSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862988; c=relaxed/simple;
	bh=UfJGQq/uh25Qny1CGGOF71Iefz3paLTIXEYqsD1jufE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzxbWHpdNoF8GE4H0zZbT7Cw+5TLS9kWMxCLNbDj2nDCLQ+w+QPpGBQj4OheE5Y98dK0D72n+8TpWGlBWqH05EjwPVtLj9gyxdOclOXQysEmLvae0SUYE/pUq5F9JveCqDcW5Dfvbk1M1ejJNKj5Va/ELQnZiS9N2+k3tnOP2gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rB+YaLVk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Em6v9Qoh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rB+YaLVk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Em6v9Qoh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 854FC11400E0;
	Thu, 16 May 2024 08:36:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 May 2024 08:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715862985; x=1715949385; bh=XPMfxR/vWF
	r6mTBjtgwZFlCBf5Tc6ay9eVlk4/0mteA=; b=rB+YaLVkuvpBlC1UFoDFjYYjNC
	aK7nNDX+YMnDThL01MF2Gva37PqM3VPBLY6f8/FliBbuNzlAzQ6Fft78+7UI320D
	8xcoIJ7uSfx1RpbPjsXmbY7G7CDT8eJoGgtdOQO3sHZ8jMncsq3/Rd29nMi/OZHk
	5O5mDlhFcL8QDH1KimTl7Zkj3Jmf1ojw8kA7v1x1KZF4Q5jptKiBvi5l4TXTNINy
	HmgMDRKWLbVi0ux3B+HJIogMhJc1zer7sMDNUuDhrod0AfyVYZ/v54kK2qEa4iBl
	epAbt6ROf7OjdhGpmz9HyIedfnVSGjhfpigOZoNVBqkzPUyhTu3Yo6lDin3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715862985; x=1715949385; bh=XPMfxR/vWFr6mTBjtgwZFlCBf5Tc
	6ay9eVlk4/0mteA=; b=Em6v9QohnGrA/tvMpj2xqyfMZzyzCSyQ9uNWo5nKjyAd
	2Dw5p+y9DLk4bnMLZD/IijvmN3rrCkYGsWDphYYgYh41S3qZYo9zroi7wcGKcy89
	60hEp9+4xajyXDCmvzUAL9GgAH8P3+H5wdXS7lnk26TOuAIhqIYjnMvcvLM/iawi
	QKnzIYpJVBUFhO4BRLnMvT3MsaN/BHbuE//TYG2MdqVUr19aQ64GkgaF92YsD3hk
	ov/dCpQcCCFiHIPayqXccwYR4e8PcUnTyj5lTbfffO/xtN9mqUtdGDUr6/qceUjQ
	hMBFwltUgD/rPY6AZpkkva0Fm9WtiXGYydtLx+SJYA==
X-ME-Sender: <xms:yf1FZpxDrXDmV3RMOQ58QnJJGCdduRbmnX-c-EsWTZamdPUU_E6YHg>
    <xme:yf1FZpQNSogkio3Hel5L-K0L-7cSg13YBtd2SBNPbnxXOn9YaNkw9SQQaHYhUfz61
    Pj1qztpwIhDoB64VQ>
X-ME-Received: <xmr:yf1FZjUYi2Mh8QzVhw5vKhim-qbWTb_NH1G2EqMN1EhKL7YjZiUMjqo3qYDYh6eaNy0-ijUsQh10Nv1n-4ssN43YpcLN6HDflLGchkUIKzWelT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yf1FZrhYuOVycZ8pGZ7IiGzsYp5il82RAhi6N_LW2f8KRa41lsW_Ow>
    <xmx:yf1FZrDaFgW_l9tIum62e8wEhpCUv3qGylCaga8rj8dggSXv58ULtA>
    <xmx:yf1FZkLZW25L597KSZeCJ_9ANhfs3RNOyJxLx1lt9M_eCJPU7-kTIw>
    <xmx:yf1FZqBewnmdpT0JMxbeUdswlM-GH8OZha7Hf2jvfncdySxi6Wqh_g>
    <xmx:yf1FZiNl-Y8-SpWdYdXUrdtZHYUhg5ImfV75CU3QnHcflNopNwamGga4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 08:36:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e0fe0b25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 12:35:56 +0000 (UTC)
Date: Thu, 16 May 2024 14:36:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <ZkX9w6etjDVAh-ln@tanuki>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net>
 <Zj8blb0QqC2zdOAC@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iaS9b1jmsdSNI8Z5"
Content-Disposition: inline
In-Reply-To: <Zj8blb0QqC2zdOAC@framework>


--iaS9b1jmsdSNI8Z5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 09:17:41AM +0200, Patrick Steinhardt wrote:
> On Fri, May 10, 2024 at 04:13:48PM -0400, Jeff King wrote:
> > On Fri, May 10, 2024 at 09:00:04AM +0200, Patrick Steinhardt wrote:
> >=20
> > > On Thu, May 09, 2024 at 12:25:44PM -0400, Jeff King wrote:
> > > [snip]
> > > > I'd like to report that this let me get a successful CI run, but I'm
> > > > running into the thing where osx jobs seem to randomly hang sometim=
es
> > > > and hit the 6-hour timeout. But I did confirm that this lets us get=
 to
> > > > the actual build/test, and not barf while installing dependencies.
> > >=20
> > > Yeah, this one is puzzling to me. We see the same thing on GitLab CI,
> > > and until now I haven't yet figured out why that is.
> >=20
> > Drat. I was hoping maybe it was a problem in GitHub CI and somebody else
> > would eventually fix it. ;)
> >=20
> > It feels like a deadlock somewhere, though whether it is in our code, or
> > in our tests, or some system-ish issue with prove, perl, etc, I don't
> > know. It would be nice to catch it in the act and see what the process
> > tree looks like. I guess poking around in the test environment with
> > tmate might work, though I don't know if there's a way to get tmate
> > running simultaneously with the hung step (so you'd probably have to
> > connect, kick off the "make test" manually and hope it hangs).
>=20
> My hunch tells me that it's the Perforce tests -- after all, this is
> where the jobs get stuck, too. In "lib-git-p4.sh" we already document
> that p4d is known to crash at times, and overall the logic to spawn the
> server is quite convoluted.
>=20
> I did try to get more useful logs yesterday. But as usual, once you
> _want_ to reproduce a failure like this is doesn't happen anymore.

I was spending (or rather wasting?) some more time on this. With the
below diff I was able to get a list of processes running after ~50
minutes:

    diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
    index 98dda42045..d5570b59d3 100755
    --- a/ci/run-build-and-tests.sh
    +++ b/ci/run-build-and-tests.sh
    @@ -51,8 +51,15 @@ esac
     group Build make
     if test -n "$run_tests"
     then
    -	group "Run tests" make test ||
    +	(
    +		sleep 3200 &&
    +		mkdir -p t/failed-test-artifacts &&
    +		ps -A >t/failed-test-artifacts/ps 2>&1
    +	) &
    +	pid=3D$!
    +	group "Run tests" gtimeout 1h make test ||
        handle_failed_tests
    +	kill "$pid"
     fi
     check_unignored_build_artifacts

I trimmed that process list to the following set of relevant processes:

  PID TTY           TIME CMD
 5196 ??         0:00.01 /bin/sh t9211-scalar-clone.sh --verbose-log -x
 5242 ??         0:00.00 /bin/sh t9211-scalar-clone.sh --verbose-log -x
 5244 ??         0:00.00 tee -a /Volumes/RAMDisk/test-results/t9211-scalar-=
clone.out
 5245 ??         0:00.09 /bin/sh t9211-scalar-clone.sh --verbose-log -x
 7235 ??         0:00.02 /Users/gitlab/builds/gitlab-org/git/scalar clone f=
ile:///Volumes/RAMDisk/trash directory.t9211-scalar-clone/to-clone maint-fa=
il
 7265 ??         0:00.01 /Users/gitlab/builds/gitlab-org/git/git fetch --qu=
iet --no-progress origin
 7276 ??         0:00.01 /Users/gitlab/builds/gitlab-org/git/git fsmonitor-=
-daemon run --detach --ipc-threads=3D8

So it seems like the issue is t9211, and the hang happens in "scalar
clone warns when background maintenance fails" specifically. What
exactly the root cause is I have no clue though. Maybe an fsmonitor
race, maybe something else entirely. Hard to say as I have never seen
this happen on any other platform than macOS, and I do not have access
to a Mac myself.

The issue also doesn't seem to occur when running t9211 on its own, but
only when running the full test suite. This may further indicate that
there is a race condition, where the additional load improves the
likelihood of it. Or there is bad interaction with another test.

Patrick

--iaS9b1jmsdSNI8Z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZF/cIACgkQVbJhu7ck
PpTZqQ/+OuIPxXZODAVP3OTFs07ThmzsBJjSrZNxfd1dnqnRXG1FwPqIBm2aFBBE
COhgBpYjkxxUUJe4QDU6nJfgZwQI4u8WoaQNy+lRHw9wZBJSWSdz/Ee2Gmxpou/U
d1XBkXyrl1CCyiGgm8jIfWJnOMBu8BaQ/a/YCauaaQOC+3+oP8KsB0zpSJwiDaha
RbFG4jAYvfKQBsCsZAiYf4ywJnmiOluQT9TJBqXkLcAhR091EV1Ic08960CKsgjV
+LiS9AzSCTklo3IbR14IzWSYeaOIm74TW0XDHfyoLNWGIrgri9ALPzJiYhlDCY1W
J+EUY+SKPw70H+B8daXwDjtd0DVdjQ3lIsSsnA6dn4q5W35iDjXxjZvR0ej+uBab
zA/gJOGBFzezerB5FVVzJIkwuTAt9Up4birzDxsZ5mmP3mCcrXe8kgrrR5x+yvbx
1AWPTPGigqcOl6izJf9Wq4WhivEVNPZkzK4FOU652YIkWeXh3i8qmmejPpOwhhV2
obAjtaLJ0tM+37i/0nhcrW03ZyT8nbnD6UIWqgTke5BhoCafiX0fLwtFNE2KAEUq
ViSrF0aBtYx1YrJxIl4hzrTx8dkk1kUL5CKtgTCfGW855DyRDqESPOaujlsUhtg2
vkVF6Am/rm31rtslEOGgViw5+4K8TLktZ3ZDW6dY8wmy7sFtzy4=
=u2nH
-----END PGP SIGNATURE-----

--iaS9b1jmsdSNI8Z5--
