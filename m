Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7A2C375E
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268566; cv=none; b=jqTgRXCRuSdEE5sH9c5tjZMn7dCh4CsumGRzhkxxAk764O4cP+eZGtUGIwQ5srm0wlXCgHCjAqaZN7xui08zgVLsM65utQw8ezFsUjEtSkU93R+Diyf7F78+g3RImVaXSg+S1CJXBgr+uKmRGTtwg3zB7r1ql3GuMs8X+OLBTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268566; c=relaxed/simple;
	bh=upqCPpw8j4cg2Y+DIQQMjeBn3/7I9/HhXbMXx7xRpQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilUuxe68xDLZSvBrjdXwSL30BJ62GJEPsTh9M9S/s3GKHyXq2wq/MSYVhdkOMEUyOi5Ikao+sfJ/JK01/1WR0phmDLRE4vFkiUFMSl3pE+qmFZekM4nOMHipEeujRzDCvRT5nKJ3KF1yhy1GUiDY60qbFOXcsU5Bp7LTGLJ/qRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Drymivei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYZJS8Gb; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Drymivei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYZJS8Gb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A10D27A0053;
	Mon, 23 Mar 2026 08:22:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Mar 2026 08:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774268564; x=1774354964; bh=3Tr3JsPHxW
	8dlpGKJlTH9tXTUmD6UrI8AVTWuwj/dyE=; b=DrymiveiKWzFbpDc11qdWdGptv
	0mnWBn8tNq62EHRosgRdMBsUiCCJlKFUF+kMSQPvjk6HEVf4wNakkHCv0mpgyC3L
	tYaLyoEEqiV1Q4Jp87qiWBRTRCdhXeGFl7ROhc18GijY2cRqaraUgXhRiA8BMo+2
	4e8qF8JBb7ydwFqz5w1ySmjqty2wkOXCB/Hd06sjlexrWur/tpK0oeY7sdNwfFT/
	j1EtjjHHUG8U/krdeLnB6DYNE1cPb/uQqbeBfDyJMPUuiA3xbS1MG8uoaw9XBbx9
	m9zAD3zUHs7X4czk/VWhC00maMskGyHoqY+DwK+OcDnL01JhlSPs3R7REY/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774268564; x=1774354964; bh=3Tr3JsPHxW8dlpGKJlTH9tXTUmD6UrI8AVT
	Wuwj/dyE=; b=oYZJS8GbBfH39nCrDVdgbIf/nYRVHho0S1J+k16t0iZS6SBMJvL
	rXqPS6XgkGsN2nTusrIOwsqCpntCzuSSG+Z4jbD1ijWpv5wdqFs9/9k8qbXb3/cO
	MRxLLF2jOz4Q8e++EXxBah0yO3hhH/ovTwCjZ6rFETwxFUBnkRqNBSaqICTOpwD3
	UQs/TxmSkPH4t8zxMr+RrDA354EdyNpCINbT2YYNI/k5x2zZDeMjpHzwEuSV2wIi
	+Ln0yHp08NRCs+T8TnYEidJGDd0qefKVoimO/yQrGw9iA2flmHMC5qB3ElbbQsB9
	tXx41t71sd/rsJ0zcgbxidKLWnS9DRo5tjg==
X-ME-Sender: <xms:lDDBaZ1ycgdVVKbnWHLmmwVoFLX6MfB8Cvs2aZKmuWGq-343AYGaig>
    <xme:lDDBaWF6A6Z6V-sKbufX1_-DhyYrBJb_MnJqmd-LAKwiwVZ2zSoUvV5dzIIOKcUFf
    nL0Pom0kgK-OWrEadYRPyTLC3RCWWb4BWsHDQxQcqplTwKHt1yKAg>
X-ME-Received: <xmr:lDDBaXg3I_OkumdG4_VZi7H7DvsOD7esP7g5Pt2d4gZ1JRzzMbFP6iFamsylyrR2UDOq7UKgYtKdjw0liklymxz9_LZQGwKVHu6Rl4tJZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:lDDBaR-3ToRz2d_qkqBlBqFeiJ3sNMZIjr5xQmKbuYYL4FSDO9c71Q>
    <xmx:lDDBaepPZKoL1AGnkA6sWzqcsJUF37VEGyRy6MsuPNjWoBO-CzmdFQ>
    <xmx:lDDBaQ8u0uE62wqu6QVVymNqcylnTVz65DFkeaAF75V91bzS8FPXpw>
    <xmx:lDDBaSXJR090eQKHeYjB2UilXjs7hPPm_hUN_zGJXyANiYLggsA8LQ>
    <xmx:lDDBaVMTTlWJc18pRmd8o455yW89MsUXOfcZdri-PPbq_ER-MkaO2eq6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 08:22:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30dda14e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Mar 2026 12:22:41 +0000 (UTC)
Date: Mon, 23 Mar 2026 13:22:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/14] fsck: drop `the_repository` in `fsck_walk()`
Message-ID: <acEwis6mGCaY4WtR@pks.im>
References: <20260320-b4-pks-fsck-without-the-repository-v1-0-6594f997926b@pks.im>
 <20260320-b4-pks-fsck-without-the-repository-v1-1-6594f997926b@pks.im>
 <xmqq341udrob.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq341udrob.fsf@gitster.g>

On Fri, Mar 20, 2026 at 04:09:24PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The function `fsck_walk()` and its object type specific functions
> > `fsck_walk_tree()` et al implicitly rely on `the_repository`. Remove
> > this dependency by injecting the repository as a parameter instead.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/fsck.c           |  6 +++---
> >  builtin/index-pack.c     |  2 +-
> >  builtin/unpack-objects.c |  2 +-
> >  fsck.c                   | 40 ++++++++++++++++++++++++++--------------
> >  fsck.h                   | 15 ++++++++++++---
> >  5 files changed, 43 insertions(+), 22 deletions(-)
> 
> OK.
> 
> While the conversion is cleanly done, the resulting code makes me
> wonder if fsck_options struct
> 
>         struct fsck_options {
>                 fsck_walk_func walk;
>                 fsck_error error_func;
>                 unsigned strict;
>                 unsigned verbose;
>                 enum fsck_msg_type *msg_type;
>                 struct oidset skip_oids;
>                 struct oidset gitmodules_found;
>                 struct oidset gitmodules_done;
>                 struct oidset gitattributes_found;
>                 struct oidset gitattributes_done;
>                 kh_oid_map_t *object_names;
>         };
> 
> should gain a repository pointer.  After all, these oidset and oidmap
> are about objects in one particular repository.

That's fair, and indeed this was my first attempt at solving the
dependency on `the_repository`. The reason why I discarded that approach
though is the way that we currenlty initialize `struct fsck_options` via
a set of macros. And as we often do this in file-static scope we don't
have a repository available there.

I had a second look at this though and have now introduced a new
function to initialize the options instead. It's a tiny bit ugly, and
ideally we'd just not have the options in global scope in the first
place. But I guess that overall it's okayish.

Will update and send the revised version soonish.

Thanks!

Patrick
