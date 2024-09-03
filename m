Received: from pfhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715991D6786
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351147; cv=none; b=RTxrNxg23KkMvdfsDhi7yjh2GetWn1NVZJKuS6SNtij+U4PDM4Tt3J1CCd5wvhWE2SScLRw+Ww4P75t7JNyZQlBmxjcOgKzDs3b21/S4yIPElokRu5F5nxeEPiTtbFB7LBdfyl3MqKTEz++6poRZ9XOrrZXckzYOH+5B36pb7CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351147; c=relaxed/simple;
	bh=wNIraeVVjXJMXSbp6hASLO+hLuhq+myB6V5THArsqdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7VJnK1QCQV/JXLrAblb7EHUNTWn54hPPZGysFmOfLFb7JvS5dM+L7E1+D4RmKoiQEou1uC80ftVwZ5pha03qv+6UoMeqiH/MmUGyPBnh9q9/kEawwQXZnqggrtb0r+7egPZxH/29HRaV0HzmlgWM8KD71hqmtR+BGMlmOquI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QX4fNrek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUWxRKSC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QX4fNrek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUWxRKSC"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4149B11402B0;
	Tue,  3 Sep 2024 04:12:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Sep 2024 04:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725351144; x=1725437544; bh=W+UrVLKIra
	waYHSVpB0x5KCa3v8uVRy/mt0va1ndFPs=; b=QX4fNrekh6vX+7MfFJ0Jqc9GoQ
	sAiiojqMT33DzxK87aVxbdRHheGkGOYl4IK4pOTAOhXJALipowP5Kz1Vbfhc+ps7
	UqCPn315xv+eIocrVdcrfvGU9+IsfXlIjq8BSy41LmPDHUV5Vn7PIYwexIxRRzNu
	I//nsOqWJRAL/0dfThtppTN0hTRLwi57bjZ5i1OAZHJ1UrFfgynpodJglF05M5ZD
	x7eZDlbcMliC0bzYOPUk/xIZPYDyLGbT2O46sfBoutPcbZmAxETckkti8MzgDZck
	7V3xLWPcJjpEu2G9W1jLCCYFG4DAd95voZDKGSdje8hCtKSRyNgK9rYv0ZrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725351144; x=1725437544; bh=W+UrVLKIrawaYHSVpB0x5KCa3v8u
	VRy/mt0va1ndFPs=; b=gUWxRKSC6XybDa7QmoTzYwyOASfqeHgckDVgP/1hVMWj
	JI26i72/MaF2olTUIB8y+xM+w01PMqYe3gVZ6snKWflrKqZ4q/weu1iNQvYetnRO
	vgbIT4FGI2X1/CXrUeeNDmRpT7GJf1R6BXegdJq5qI4i0jK+ajEynGvt34Z0UloA
	YamklWwHhco+aw2C4yNjwPEtgw02s6VewPExNDAWUnYHufUKhk3r2Sj8yqPr6OXD
	y5vYS23B5Uxd24SJcNjUQHh70jLb3Ji90/mqD5gG+3V+rsl2XYLAsxLNtvQ7PgEd
	c8gJ7QjdZmNOxBV7iDEq/+1q+qQX7h9eI3XFPfJZ/g==
X-ME-Sender: <xms:6MTWZsLb67kqm5s55_6Edfrmu-zKL-ENHBgwTgtLdycFOJyZRctSRw>
    <xme:6MTWZsL5qivkWTeUmFtPE6vv53Mw-xXtqWv8_kGa0eH-wcS2YHcAbAZT7hD-VRZDH
    mRUIVolcrxIPYPJHg>
X-ME-Received: <xmr:6MTWZsv7aKYjCxg8ShQLAWq1bjeSiRoDJNN5muR7ZaliCUrL8fF6FVi2dgyp2yPuGoD8SyTBKoGE4HXVvJN5kPimS4inudyNjroppThTjNUvWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehrshgsvggt
    khgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtvg
    grughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:6MTWZpYD85r9u808k0gcVENoGYpl5C6R3fee-ZDcjBPQRB83aXnxEQ>
    <xmx:6MTWZjYPPe0IjeGfgbsDwwwjOIeOQxJcx3DU3vCmKDyWVH0qBX9yNQ>
    <xmx:6MTWZlCaWDnD5AdQrXPXLoCRI8XcHuJ0MDNO5dUF0MNKZOoAnODGLw>
    <xmx:6MTWZpYluxmbWRK3mpe9ZYpSJB4-JcgSjo-qcY8NlwvJ-NJnxs_BRg>
    <xmx:6MTWZtk1yDrAwemW0z2yVRAmNcLYX7Y4oHC_aWTPJqTTyAsuk4CWe962>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 04:12:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4bc690c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 07:45:35 +0000 (UTC)
Date: Tue, 3 Sep 2024 09:45:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 02/13] t: import the clar unit testing framework
Message-ID: <Zta-pKzaJtkedZTO@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1724159966.git.ps@pks.im>
 <1710e9f9ff75cee76be6d5c1311344c6564e3801.1724159966.git.ps@pks.im>
 <435e3840-ee46-4ca3-a525-747848da9930@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435e3840-ee46-4ca3-a525-747848da9930@gmail.com>

On Wed, Aug 28, 2024 at 02:16:52PM +0100, Phillip Wood wrote:
> Hi Patrick
> 
> On 20/08/2024 15:02, Patrick Steinhardt wrote:
> > Import the clar unit testing framework at commit 1516124 (Merge pull
> > request #97 from pks-t/pks-whitespace-fixes, 2024-08-15). The framework
> > will be wired up in subsequent commits.
> 
> I would be good to explain why we're doing this so we have a record in the
> project history. A summary of the advantages and disadvantages of using clar
> vs our current unit test framework would be helpful as well.

Will do.

> > diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
> > [...]
> > +static void
> > +clar_parse_args(int argc, char **argv)
> > +{
> > [...]
> > +		case 'q':
> > +			_clar.report_errors_only = 1;
> > +			break;
> 
> I think this option is incompatible with TAP output as when TAP output is
> selected the first error is printed as part of clar_print_ontest() and
> clar_print_errors() is a no-op. We should error out if it is given with '-t'

Yup. I'll address this by implementing our own option parsing.

The remainder of your concerns relate to the clar implementation itself,
and as such I won't yet address them. I'll work with upstream to get
these fixed after this series lands though, as outlined in [1].

[1]: <ZsSTOczuGhT5zwoV@tanuki>

Patrick
