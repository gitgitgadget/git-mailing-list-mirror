Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985FD2B9A9
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740723389; cv=none; b=jm24D21s8VVBsAGtC4pWMHTMajBgTOKtQd2fnUr0GUCgA6l/1Iy1uPLA8AzSbeQ65vKOoK5KsbYWnBZ/GHGYdYjh3Z8ouHptLyegtElrfYp9nw1lDYHcZM+62aHMFP14qhcEi5Mu1KIVj+UH7ke8SoUvJ1ZqVlx2Vo/jS8/hUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740723389; c=relaxed/simple;
	bh=1KsFAsWgA7vBhdgGq4fXDFKvGLi4vO+b2+VyjItjjR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJ/9o5cyBgyfaTHFlWGXM/dqAH5846/cwmLNfWDJgn4D7KtLzyshjrIh5el5l3LdcpYuksaiDID272NP6PHZJEZozC29eMgSkfNY93JVQu3JbnvHJDRLMBqSZI1IYoe/8JIGuvmBWWx1QuvbH4qY5/8Q9fZ2GtVWjIENVb/3jbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HKQxYKG0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tfl+Bj1B; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HKQxYKG0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tfl+Bj1B"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8A305138277E;
	Fri, 28 Feb 2025 01:16:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 28 Feb 2025 01:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740723385; x=1740809785; bh=a92trB59Hz
	e2wSNNpJAs/EwvEDG2nZSyEbMFMjQ1+VU=; b=HKQxYKG0UBQcyG2nyPCiAAQlZn
	nz2C/GCmNtemvxtBSNwnvTHSJJjgot5QYs8dkkOELrLDAYVkZgnlnIelxOO5kLFy
	YH19Z9waUT2P06CH2bH3VZtqm/GvL7hV48wCc9+35buq3/SKyo4IvRQK4zJm0cxr
	kKkCVrr/GrBRuP4ZA9hV5awtVxOu0PG+Etj7PhiPbQE9i98+/1V5/PNFSSOeheYx
	889ZQsS0XLczdr8SjgsHaukxJQyeO06Y+N3q2DC3Kip3maGVNbhT5zUVjrbwsLWN
	XTgghzYGtqa8X2OYuz+ywqhExM/KHUluDQ7WgZqPpl9U7No75jEbWmIJLeXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740723385; x=1740809785; bh=a92trB59Hze2wSNNpJAs/EwvEDG2nZSyEbM
	FMjQ1+VU=; b=Tfl+Bj1BdU25zuRkVAMoX6GpdmURjF1ly6/k/03ZA6C/ApVuQo7
	UmsaSX7fmdz5Fowzh0rUzuI/l2GAvegq7atBU3HmWB3iNBJZDyMPkWTO+HLA+/+r
	KU1c1PMAbyq1zgRiNGXTEKDBqH6xGB/HbaEf9nihDYr5ztd+a+MKp4ihJmFkJ6Xi
	gzQH3Rbmsnwn6KbI8h+HaM/D81Txvr1f8AvY+bwHMmgDDaXxKX4ZGGn02VxuugmU
	JeFy/5zJtv53mR1BxnEeB9cK+nQO5k0NCuiWACoJQMiPEmRrJGyP0Ehc/LeTs7Pm
	QwKSOBHfrY7hHIVEnF2YBVFk4qViogujyDA==
X-ME-Sender: <xms:uVTBZxnBWtG-OJpxA0C2ibd5_lgZY3xIK6SbILiVM9GWEfJJyDZ5dw>
    <xme:uVTBZ83JIqYDZ4PAkZcuecTUKMqKFpbFzZBZ7-0plJfIKkuPZIXjOGL7PE8PsXk9E
    WNYr9YEGTwB9eLU6g>
X-ME-Received: <xmr:uVTBZ3pyesRJT7nq-9mR44q5Jgl_qJBY9lX-xq-lKqKIzeNVGcfyyoabwIsm0OoHA7p9jroWW7lQrL8M4R4fsYKSXszO0T-EjPMIEVLxtwNygb88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrghrthhitgdrshhivhgrrhgrrghmsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:uVTBZxnGV0T2DyZCkL-iOsyJwvGNsIsd8iiD1yJUJQzt0yUoCzZSHw>
    <xmx:uVTBZ_2SqX5P7Tq_P8d3qgj9XGPG0zICw1t5EiZ_a_gX5N2YGVzs8w>
    <xmx:uVTBZwuAZbAANRgqWK_glNnhh3c81sHxUj5O06o51YVTlt_OhSAMhw>
    <xmx:uVTBZzX4AlNguMMiiG35dYwGFKuFsos6EGdASCoKGRbaxw28B5puGQ>
    <xmx:uVTBZ0lhtrfxTg7o2y9xQPX5nhLDOZtUsfkMuCRgT-RJc9vulrAbeTDg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 01:16:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eccd06a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 06:16:21 +0000 (UTC)
Date: Fri, 28 Feb 2025 07:16:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jialuo She <shejialuo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git in GSoC 2025
Message-ID: <Z8FUsPOcg9ht65Bp@pks.im>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C29409D-691B-471F-B08C-83E14D35EE13@gmail.com>

On Fri, Feb 28, 2025 at 08:33:38AM +0530, Kaartic Sivaraam wrote:
> Hi Christian, Patrick, Ghanshyam, Karthik, Jialuo and all,
> 
> 
> On 19 January 2025 3:43:29 pm IST, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> >Hello everyone,
> >
> >It is that time of year. GSoC Org Applications for 2025 are open now[1].
> >They are due before Tuesday, February 11 at 1800 UTC. It's good to see that few contributors have already started working on microprojects this year :-)
> >
> 
> I'm glad to announce that we've successfully been selected as a
> mentoring organization for GSoC this year[1]!

Yay!

> Christian, Patrick and Karthik,
> 
> As you're already members of the organization kindly log in to the
> GSoC portal to read and accept this year's Program Rules and Org
> Member agreement. Let me know once that's done. I could then add you
> to this year's program.

Thanks, I've accepted the docs.

Patrick
