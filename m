Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2634155A4D
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547391; cv=none; b=o6CyKNWLJJW6UKA9WCl8XnZZDwDCkzFz83G2Jtdm1tVOkCP9gH2Wi0B+a6zROUMs1TsXuFCBT11aVCpr+Saol2DcbL2SMIsuHOCLppH/u7rBHkWWRkDAASgP3/95740q1axri7xrdMO0pBSXJ2qrn2fshXjzKMXtMCQBK7Wh3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547391; c=relaxed/simple;
	bh=7Vmf+jRVXIkqkIyX8FknO1kbV4EGpBJrPF8r6LzVuy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r6jCo5YGdz3A/LUt4GAmExz8z9T68eE3WeUZSgI0+CqWzEIzUdkyfxOH0syg+7A5jqUN1Tjxjwz68Bj1UMOtfRZ1VmS+40ZJ1EbqElUsKoyX96RcqxAAwdaYZFGEySCXfZE1lOfKQm523QEUP8Ev1OShZC43XRrrVvHnP1Sr8jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U9dL2MK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VeQIa34e; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U9dL2MK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VeQIa34e"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A09E2EC0178;
	Thu,  7 Aug 2025 02:16:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 02:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754547388; x=1754633788; bh=QELinpVxVW
	YGNUaJGSwtF6Gq64WnhgKuAOXZPAW4kWE=; b=U9dL2MK37YzyHH6w3hJCU9S/7W
	B1nJdMZEqI9l7lB8cXQZ5IGJllous9+r6rBwHxpF/FSqOo0dlJkNRpZxEV1G0pMq
	FrsWBJPXWxp9VhVeWlkQTKuaA+AnDMmiWlfSnxU3DiWkXeoVXiQC26AEbHjcMCm0
	9r+IXdcIGHxJhBa4Q+9IrENun0lS/EBnlB/tB55Y4vQ16kbm4p9SRAlDWbw6k/wy
	r05nuAt+yBxWJA6kFRsQiRiZC+Z+A8Vf26CmkRESjaBCQ6DFNIOHAxNr+Wp7fFlC
	cHwpgc9AmX7RKTMidMof6o716qxnbtqZGZ08PGbORWsXUuksBkOIU4Ult3Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754547388; x=1754633788; bh=QELinpVxVWYGNUaJGSwtF6Gq64WnhgKuAOX
	ZPAW4kWE=; b=VeQIa34eT5+cSmVsErizzjSFkwJ0ixbetfJaD8cvPaEe0At0b14
	q3YfVcs5OsDZq5kb2i+1Yt7oN4kWUS4qqptDgvRkE0SOyKxcnkYaQwMhuVyBGgaj
	f+et4q4JC9+lTCPdVGxvxDXyQ/6luaG5tirXtkAgPYtXrLYD5vWAUCvGtbzz4YnW
	aMUm34gVOnof/inSaNY5cIST2M6AUYSLX9zq5rCCC26JT6YWk57GJ6S+aERnoVBR
	t1yk2R548Dsq2xB4/ZY2es5t6u5to9gpPiMWrovaxr4dael4XnUMNChsjj9oDzew
	h+48QT0fXzjISFQA+JGhHyCU3pPGI6XW/pQ==
X-ME-Sender: <xms:vESUaBTO9LKOoSX2yBd0QcCiD3SF5ugajYzIcbndp9lj0ljUbZNDuQ>
    <xme:vESUaOC-T6o-2hkJG7mSLf7ojMgKuvBHKwtQdz3xVaEr6B4XZUIlkueRnlHO3Wp6y
    xPbYP-3OrYARCXegg>
X-ME-Received: <xmr:vESUaAQJvEhv_e1jeUjnZbg6xO4qgmwNTjUQ9wdq7dDsitYoQtfLB7axkqnu_nGqWlByutTJUpTy-e0dNnJAvKntLqRqajA5zIf160npWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vESUaErqOhqO7vaGpti31m_QoU79AXiKVjjo5PK0u3piv5KW2pbm8Q>
    <xmx:vESUaKy-XUy0ka2IUd5O9eNv6PxM9XcryBVNTvPEF9NHut5Q4kAhPg>
    <xmx:vESUaBLBmxnRGiaV5ziT-EhzuKfVnj8FSkFaf3363PIocUXquWztFA>
    <xmx:vESUaEIhjtKtqrQwmgCRe1YiQe10yeJRuvVzYqe11g6tUYlCCJqXOA>
    <xmx:vESUaC2QBjJxhAcmklTQz8HVHRfAAXPzyQdQo9tENYGFsJ-Yqq6cycW_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:16:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b19f940c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 06:16:26 +0000 (UTC)
Date: Thu, 7 Aug 2025 08:16:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/8] odb: return newly created in-memory sources
Message-ID: <aJREtxNAJ9tK30GT@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-3-748db2eda3b5@pks.im>
 <87ectotnd4.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ectotnd4.fsf@iotcl.com>

On Wed, Aug 06, 2025 at 06:40:23PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.c b/odb.c
> > index 61104b7cb8..7793816f81 100644
> > --- a/odb.c
> > +++ b/odb.c
> > @@ -316,17 +315,23 @@ void odb_add_to_alternates_file(struct object_database *odb,
> >  	free(alts);
> >  }
> >  
> > -void odb_add_to_alternates_memory(struct object_database *odb,
> > -				  const char *reference)
> > +struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
> > +						const char *reference)
> >  {
> > +	struct odb_source *alternate;
> > +	char *objdir;
> > +
> >  	/*
> >  	 * Make sure alternates are initialized, or else our entry may be
> >  	 * overwritten when they are.
> >  	 */
> >  	odb_prepare_alternates(odb);
> >  
> > -	link_alt_odb_entries(odb, reference,
> > -			     '\n', NULL, 0);
> > +	objdir = real_pathdup(odb->sources->path, 1);
> > +	alternate = link_alt_odb_entry(odb, reference, NULL, 0, objdir);
> 
> If I understand correctly, instead of using real_pathdup() we could
> instead call:
> 
>     alternate = link_alt_odb_entry(odb, reference, "/", 0, odb->sources->path);
> 
> I did not test this, but it would avoid duplicating the path here. I'm
> not sure though whether it's easier to read.

We can't quite, as the call to `alt_odb_usable()` needs the normalized
object directory path so that it can figure out whether its local object
directory is the same as the proposed new object directory.

But what I noticed is that we're passing in redundant information: the
path is already stored in `struct object_database`, and all callers of
`link_alt_odb_entry()` pass both that ODB and its path. So we can drop
the parameter and make it an internal implementation detail.

Patrick
