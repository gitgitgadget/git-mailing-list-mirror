Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F781D69E
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795632; cv=none; b=obXtaaCA1NrwoZdeSJT9Zg8+l9kCgFAFyKb+DeOI0RfCAIhWZcWSjGFk04J6c3oA3rhimTroCrQHIlBYNiFGpW4O6sPINzcEGo+C+Kbkz5xm4Lzwzl3EHvV5Z2Eg9niEPibqOJvf7iWUmM94ZYntpVZ8aGjCSgw6h2S4p3fhMD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795632; c=relaxed/simple;
	bh=rzrbYdcM3lSgEN/8Egt6WIcsWz9cqZxDkk56w5ndGZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmqPGyKkYvUcwk6OPKootBdJKKKjjRpQ3bSWG63fT3yqYigWeC91RZraOfILB1ey+TzwBi2BYpEpaZPK7oQpwtZjAQH85qJojOTUlBtuI8q+L6SUwTJ5eGuRgDJGm0Ww9klSZwVlEhNsNgU1mEXEjhzgIPzKrPXsA9rCXpnIMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dONiRmsF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QQF7dNtu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dONiRmsF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QQF7dNtu"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 10943138FF6C;
	Fri, 16 Aug 2024 04:07:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Aug 2024 04:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723795629; x=1723882029; bh=8g+y8ib3NE
	s4UV7qzTUsoL8Z9k8dz4GwqTXLgeg8iXU=; b=dONiRmsFS91wFftpek4oZ6Dj1Y
	p0C7qvp3WfxZiuH0DVExH7/4vARibVrlqcuFLmnsjuN9W+8s525AY1xpqIHLQPRg
	65tR3T6pi47DVZAKjP/qmw3JBft4OvEaYIyAyBht2OpNKkFr/FWtFNgqRZKgw3Af
	CiQpxSPlM2N5DuLWNVWvMSuzlGNlkExqKef/abtB6wCZUJtxwoF2vGLibLajULQY
	UrUba+jNTuA+vRU1rHw39IzTPnAn1WpZfzU3i0oaoK/2uMD3mlIKXOi2egE7/tvm
	clLgJFnpNaaIkjMNUoSH/XDPCcVSHPDduWvHH2sVm+SHqvWrKSzqu8vb5vsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723795629; x=1723882029; bh=8g+y8ib3NEs4UV7qzTUsoL8Z9k8d
	z4GwqTXLgeg8iXU=; b=QQF7dNtuaSds4nEFx+u81hIgI8drunQ0iVIPKTUPo5h5
	0ptyAYPkUFTYqrEgw3E7YY0GzBie0t7UYFSa6Ym6/drHUB9yQcmS7AUM58bNaVYo
	ttmtcyk/5yoPA1dR8/4KTtfRvumLpmm8A+bECSfJg2oGQfTmvSn/TgNU/nmnsLIT
	gyc4MeYqeIWmDKdrz5AJfxW1vdcQxxZwVFVtW7Ay/kRNGvK8DXWLRbN78yrvQqRP
	9ZC+BQoV4JbjB3M/URez3s/5VL+DxNimdvwpXHMVSqPnoNveJcfHn0EdtfX2pqQm
	CxIPXnC4kpwGKm23s2ZGdm3p/fiYvHOSi+6WtBnHNg==
X-ME-Sender: <xms:rAi_Zt-PAYhXAY_632I-qdHbegRE8AWKDjQfWbkmsmYhdbIGWI0Gsw>
    <xme:rAi_Zhu4dptJVY_RKrscqc4FZRgmZSdCe_w8XFldARIQRomDJD9JUJoGdqjN0zU0E
    cUeLUOntulaiAAk9Q>
X-ME-Received: <xmr:rAi_ZrD9OPXcRtmbfoDlMR7uSSf6nqHLn1e_hBVnfeDW1RTxKdRYTJyfZwKVLor4NUVe2DrwuoaeAsqwXMUHIIOqYtNgJliU99Yc_GLB1vPGHhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsshgt
    hhhusggvrhhthhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:rAi_ZheQU2AONj4KXieNK4yCP9XgJkurLQRmaZdiNQyiJbl3LZ8emQ>
    <xmx:rAi_ZiPIgBrV8jYH65tBlsPzUONxNXuFieTs-I8z8RWp4By3c-E-0Q>
    <xmx:rAi_ZjlFz1dHXNDvkex1AXxCn_FgvYTQ00rp9soFHR1bAmbBkUMQoA>
    <xmx:rAi_ZstAm0zmTCVw5AufQKVH8QS1ZKO36obC_izabyxOSoxreynOIw>
    <xmx:rQi_Zp21sNvkdo2BzVm12zQREpTvOUbl10gI9800dqdPxKCbnNbrrnZ8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:07:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 882c3c17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:06:44 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:07:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 0/5] Introduce configs for default repo format
Message-ID: <Zr8IpMXjN94xnC0W@tanuki>
References: <cover.1723708417.git.ps@pks.im>
 <Zr4dvybR6j6Ifyya@ArchLinux>
 <Zr5wODo8tgGtPEIM@tapette.crustytoothpaste.net>
 <xmqq4j7lsbca.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j7lsbca.fsf@gitster.g>

On Thu, Aug 15, 2024 at 02:52:21PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > On 2024-08-15 at 15:24:47, shejialuo wrote:
> >> If the user uses the following command:
> >> 
> >>   $ export GIT_DEFAULT_HASH_ENVIRONMENT=sha1
> >>   $ git -c init.defaultObjectFormat=sha256 repo
> >> 
> >> The repo would be initialized with the sha1 algorithm. I think we should
> >> think carefully which precedence should be higher. I cannot give an
> >> answer here. I am not familiar with the whole database and do not the
> >> concern. But from my own perspective, I think the precedence of the
> >> config should be higher than the environment variable. This is a new
> >> feature, the people who would like to use it, they will never use
> >> environment variable and we should ignore the functionality of the
> >> environment variable. But for people who do not know this feature, they
> >> will continue to use the environment variable and they will never be
> >> influenced by the configs.
> >
> > The standard behaviour we have with other environment variables is that
> > they override the config, such as with `GIT_SSH_COMMAND` and
> > `GIT_SSH_VARIANT`.  The reason is that the config in this case is
> > usually per-user or per-system, but it's very common to override
> > settings on an ephemeral basis with the environment.
> 
> Right.  It is good that somebody can give a clear answer when a new
> person says they cannot and then give an answer that contradicts
> with an established practice ;-).

Yeah, thanks for putting it so clearly. I'll also put a variant of this
into the commit message to clarify.

Patrick
