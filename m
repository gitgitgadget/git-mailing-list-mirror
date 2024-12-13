Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095E1B392A
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086442; cv=none; b=cZvdsVHAWfA4LvuWSKSCwlm1+bZ+MkFbUxbqoai+xffCoq9QXy2I52QFBV3f26Q6PfHTEMO3Mzlv6ueLrmi0RyQMLdcsJbPBhha0JcE3t7vXAhafy1PflhwooL/AU7y1hup1PJ+4mCkrkCCDw772XoD9uWRxsH8w5aEG/Z/039I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086442; c=relaxed/simple;
	bh=22GD6LnWncGOQewWozOfwSsaak4mgZzorc6Gcq7eRZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgOMVUXJBI0ndjdJd7XgBbaEPnynYCyTwM8xgab3pTC2Oruqk1WKmRNxBYLHJ5xMWPulKF2bpuFaIaF+ztLBxsxFYqXaJIVozc+6AZOsuLHRPwoh5ecnJ6DclPI5lEfmEU9+dYLrqdcYY0/M1Vn+NUTDQ4xW3EjVVdvuWLynDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kkiFzLeg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P5Hh8lPi; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kkiFzLeg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P5Hh8lPi"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BFA062540211;
	Fri, 13 Dec 2024 05:40:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 05:40:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734086439; x=1734172839; bh=PymAAbL7LZ
	P12ODOO4yqInmYj+nkhv49iz/WcnG1IxY=; b=kkiFzLegzbI+OAkwUHvLcx6I40
	a2AQgj4LZFVUbnQtZI0/kOphH/oIGkx1NzFVAPj2pFQF3aGm536MTzjXugK9Eb9i
	Yr53ynoFjXqA+NI59vIOZXUnIVP5kLiwLwebRhMGhARUVa3tpIkXojvSl0nBzemp
	0fu6LUOHVzpFJF+bpHIW175/OHC6uMfBvF3/xL8mouYlHmCUndNfxS1DaqdIm+S5
	dKKbji0DspkhKIdmG44qlaa9o5JknFgACY9lCXKi3Bc9HDfGkOSIyY8/JLSLlgTO
	Khd20m7Ocdf+LBTxDaQ3qIRJc84aTS60swoOgQv8DlMFIpNA9tJoW4YuLhCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734086439; x=1734172839; bh=PymAAbL7LZP12ODOO4yqInmYj+nkhv49iz/
	WcnG1IxY=; b=P5Hh8lPiYXwFuXO0xJh6ZeKLsCIzzej39XqdGmI9kocbWb5sDYu
	xX7e6dfDEobxhI4CZHCdZSHZdztDQ7to0umwSnwzjyfS4D4dGS07fo7t13G6w8WN
	6H3vhW475lpKFCAq9Wyaw7niHpDmxFIl9eqls7gOBqb+uZDe76RWcvJfqSxdeTFK
	K2s9dvynEs/ldo4KbECmGvsq7q4EfG53A4MeCLSKNiEao4h1QjjfUz4v5mdOKAGP
	8GARK43zb9uze1L8rY11RaS3K8gcdifyrRrAVsQJrwtcgBMVRnbvLe3dGPjKkeTZ
	5DcTDQxZlqllxAaCrxvuxRXy/sNPxQUDSHg==
X-ME-Sender: <xms:Jw9cZ3BELcF4Q5GnWT4y1ix0qhZGXa3M1TYg_BKiHLjdsTOvllipMA>
    <xme:Jw9cZ9jf-GqGzlyq6eDDUrk50lE-Gq1iZf-11ImiqiQ9MCiqpn7JAbdLcQPqmFvfm
    KTYpnBbynnXrWz60g>
X-ME-Received: <xmr:Jw9cZym3k8dOmuNeZAeiF_C6n-u56No4GRTbW_5WOwhO0Ol_hYuKgN6OoRCfXxBAYaFEnb993IZS1qttqiKSwSRKTbewIaHCux1Ihlc0HynfdC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:Jw9cZ5w-I10jzKPZOsVzSICFS8s2DE2v91Bm43S9p7K6jH49EUOORQ>
    <xmx:Jw9cZ8SUVY5QCgr8qE7ZzfTZ9np-WORcphY-rh83GU3afEI2HLNM1A>
    <xmx:Jw9cZ8YLrxugXSlSuDNteyU9FMAvWWv3IW8Z4MXxg2VNzi4kVrDwJw>
    <xmx:Jw9cZ9R4QQ8lFHEjagSzXUmky-YeCzGBlv78xj71de0Ab9QkT4PxtQ>
    <xmx:Jw9cZ3f2jHntHFLHuFICA3yq0YjZI6MP-bqRn1YE7bPQmH0lQ_r3lLHI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:40:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 375c2e4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:38:54 +0000 (UTC)
Date: Fri, 13 Dec 2024 11:40:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] ci: wire up Meson builds
Message-ID: <Z1wPEmv8f-omCxUL@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-8-28d18b494374@pks.im>
 <877c83j40k.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c83j40k.fsf@iotcl.com>

On Fri, Dec 13, 2024 at 11:01:15AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > index a1bc92893f27d6dd404133686b71c8061e55618c..8163aacc8c8715d09f19bd1cc7199532fb5141e2 100644
> > --- a/.gitlab-ci.yml
> > +++ b/.gitlab-ci.yml
> > @@ -20,6 +20,7 @@ test:linux:
> >      - saas-linux-medium-amd64
> >    variables:
> >      CUSTOM_PATH: "/custom"
> > +    TEST_OUTPUT_DIRECTORY: "/tmp/test-output"
> >    before_script:
> >      - ./ci/install-dependencies.sh
> >    script:
> > @@ -31,6 +32,7 @@ test:linux:
> >        if test "$CI_JOB_STATUS" != 'success'
> >        then
> >          sudo --preserve-env --set-home --user=builder ./ci/print-test-failures.sh
> > +        mv "$TEST_OUTPUT_DIRECTORY"/failed-test-artifacts t/
> >        fi
> >    parallel:
> >      matrix:
> > @@ -67,6 +69,10 @@ test:linux:
> >          image: fedora:latest
> >        - jobname: linux-musl
> >          image: alpine:latest
> > +      - jobname: linux-meson
> > +        image: ubuntu:latest
> > +        CC: gcc
> > +        CC_PACKAGE: gcc
> 
> Is it needed to explicitly set the CC_PACKAGE? I see in other places we
> only set it when it's set to `gcc-8`?

Good point, it's not necessary.

Thanks for your review!

Patrick
