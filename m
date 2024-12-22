Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8825948C
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734851642; cv=none; b=VoCZpVpEgSjKPgEgmO/45ySd0h7nd2uK2RYXt5kYC0dsT8Rpam1nwFiShnfwgA3ffu/82QeDg0lM/yM5NCNjEdIBxEKTZuZEadzEIBNLrNVbSaD/dDry9zfZKV5oSsPM4oi2H2vlGPUCrPcQOgY8NO4pq4jQ+QhPIPY8x+oNT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734851642; c=relaxed/simple;
	bh=myjhVAWcmTkPE4zjV+15+fq+WZTf0g/YAbUonq8sSQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMaSdJ/rfSChEfaVmNkWwoezY4Sd8JdpqqSXDleXL/B3LUTQGlryL4f1UrWF/IMNvmsBRJWiZG3rUbTWkyT0BqVIMYzeJh3NK46wcJz8a4TA+rReswS8vOvOiFMje8KWmANYH/WYbB0DSD4UFwInjxOMvq9hidcNZRVV2UNluXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tgp7R/oK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xhz3a+oc; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tgp7R/oK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xhz3a+oc"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id BF4F51140165;
	Sun, 22 Dec 2024 02:13:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 22 Dec 2024 02:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1734851638; x=1734938038; bh=AtlGi2D0M8
	4CjMAM/3j6ryvXxJtX4hRl+r5bCgbhmdc=; b=tgp7R/oKhjgoQhzax+sHTJmE15
	GnYaAhOkoxXzkR5lJ4OyrtHAOtJZeAWq+DtbSrUCJQnMPJuA+tf+cMxKJcNJPCzu
	uX4NCjdkpTL6DHa3tddaOM23iFYtvh7OONK03OS+xUwx6z1Vz0z5oxlt5dNzQfkS
	wQ4DOtQZjgBndRngb6TZs/xvZ386XixvUoMSVyfGaJOB1uQALK2KDV7HKs2q6daC
	0yugK4Ut5NhdV2UMOTTTtktP/MqT0SR+vQR1CxtRBqx0zm0lf6OJJfz0/z/6AjQL
	/sQDHUKBP+6xqrBzQqzeOt3oxnh8yyOq6ZDCqNjcycEbiNpW2wmForS9DokQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734851638; x=1734938038; bh=AtlGi2D0M84CjMAM/3j6ryvXxJtX4hRl+r5
	bCgbhmdc=; b=xhz3a+oc4WzwvLIjwj1rI65iQYM/6KXtAkzgQ6fd0Quyfs/0xYz
	vknzmxCVLDi8jXjqEw2APNEZzNGUgEguFcLusXkXcXN+qKO/H+1htE74mN6uny1L
	Ds2p2Eadxlu6OLVjSNKYfJoBk6nQ4M8kQIxcGLScYPnGR/pkhC0atpo2wCOWmXdO
	pFYev7oxbhGb6j18BYY724g8K1Oaxqka0/9Mq5SIIXYQZtqqGm4H31K9Xq4W4Yi9
	EATNbqI5jFMP43MxgWya4I3Opjfs3yLxQJkp8oizVMzGAlsgk/9FBrcdbo/+RYCs
	1eEoMNPtmA8/j/+xXH8ueEuzyZpu4pewneQ==
X-ME-Sender: <xms:NrxnZ-P2fqzNhwYwpdrJM0DD4x-eR1WJWuAupHL-xDCuctObEMb71g>
    <xme:NrxnZ88sGT-x-wQv2juS0tOl0FTRAjnR2hlzx1jdmeNcMQYJZDyXiY8jGtcISxJ12
    68BPdYKGq1yNiIo5A>
X-ME-Received: <xmr:NrxnZ1RmLkRleFqbyPEZ7gfPZ7H5QcJNVaCa5kz8GzvBXRIqw9ColTwmudmuDegJ5BaQPZTu2dKRHTFAgST9cVu34np8HHZCIKHLGbpJ_xWlUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhgrnhgurghllhdrsggvtghkvghrsehnvgigsghrihgughgvrdgtrgdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NrxnZ-t1BCpugMRdPYtzgKYoPlxC85sNHzC5Y_OX1eU4zeh__6rSxQ>
    <xmx:NrxnZ2cbv6DqT8itZybIi5NsuiS6R_OgNg_-JLtuihpX2X-UV7zrAQ>
    <xmx:NrxnZy3R1zk6rSBQ-7VKgnHkBv3bKLvuf9z-fNYZvFoCBXs_wrlXrw>
    <xmx:NrxnZ68P7NSIO5unF2j1IXEY0sJtEiFCvRSt9CjdtqUG7yXEdY-Y6A>
    <xmx:NrxnZ25P5pPd5iUxMg6Q4R0G45-h3gq6qpRxoRfLC3bpRrr4BXQfrb-N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:13:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6542b1c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:12:00 +0000 (UTC)
Date: Sun, 22 Dec 2024 08:13:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 3/4] reftable/stack: fix zero-sized allocation when there
 are no readers
Message-ID: <Z2e8I6eGcTXL7uec@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-3-12db83a3267c@pks.im>
 <xmqq34ihc4zt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34ihc4zt.fsf@gitster.g>

On Sat, Dec 21, 2024 at 09:36:54AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Similar as the preceding commit, we may try to do a zero-sized
> > allocation when reloading a reftable stack that ain't got any tables.
> > It is implementation-defined whether malloc(3p) returns a NULL pointer
> > in that case or a zero-sized object. In case it does return a NULL
> > pointer though it causes us to think we have run into an out-of-memory
> > situation, and thus we return an error.
> >
> > Fix this by only allocating arrays when they have at least one entry.
> > Refactor the code so that we don't try to access those arrays in case
> > they are empty.
> >
> > Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/stack.c | 44 +++++++++++++++++++++++---------------------
> >  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> This somehow did not cleanly apply, so I whiggled it in manually.
> 
> I probably wouldn't mixed the "size_t i" changes into this fix if I
> were doing it.  To avoid "while (*names)" loop, I would have made it
> to "for (size_t j = 0; j < names_len; j++)" and kept the existing
> use of "i" intact, instead.  And reintroducing for() scoped "i"
> three times did not seem to make it easier to read the result.
> 
> I am not convinced we need to avoid "while (*names)", by the way.
> If "names" were NULL, names_length() would already have segfaulted
> anyway, and basics.c:parse_names(), when not returning NULL (which
> would have been caught by the sole caller of reload_once() as an
> error), makes sure it gives its caller a NULL-terminated array.

True. I was initially erring on the side of being overly cautious here
because I didn't yet have the idea to adapt `reftable_malloc()` and
`reftable_realloc()` so that they have the same behaviour as NonStop.
Let me redo this change and reduce it to the minimum required one.

Patrick
