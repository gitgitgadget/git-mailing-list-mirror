Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CD12C190
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724391379; cv=none; b=X3CVNs9aI42CLr96utUqlxVTkjX5WyU7t16TVdQai1yU32NHOENJ9jGb2dSzCKSF3yZQbfvnOG0wLmecnkdLjjQlZ+gh/GNTZOPBaJTp5nwxWfrYBQ9dqYF3z7x0emC1NzC252MHZEfIPKhLp4iBsJl1pyxwJ1TzL3y/AFAbFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724391379; c=relaxed/simple;
	bh=9K60Ol/8RIIDqSSX/8NDASSg/XAd9qArPxxToBN82Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flu2VTc2VzWEXS1MiFoS3Jt+kSFj5mHUfiiivhp1xN63HeZ+yFkgdX9GhzelD4k2M9mp1KeOprvx36DQXLnRLwzo2riNWjwOR2vNnpKXciBz/4QIkv6ou04UlMRcpcwGyn4NhGUGp2odmDg6FbkmmAyk7TEfj8Q4hO40i0Z5geU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HilHJHfQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CsmPvwFJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HilHJHfQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CsmPvwFJ"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A1A7E1151BD5;
	Fri, 23 Aug 2024 01:36:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Aug 2024 01:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724391376; x=1724477776; bh=hd+07jzOWD
	jsUac5ck5LIV8+5EWXSdEWCAQw+stPqyY=; b=HilHJHfQWONUm2oVL7IdZpCiYa
	9S5NHsCI+uSYMQJGBewziW0dBwyWmoS6znfbcrGdackEktxRrulO5OkmKQY8bYnf
	qFfuWFut89q8msts37q+T4MjjtpbE1VaEKWJFCvVOMMlC4VNFTO+5bVY2A/XhPKs
	VhwziQcxKZbn9LPOsEhdFXKwZV/zOH001gurHx87FI0asPy/GICjxHGYTfObp5bP
	WifAU832Yn/zJgHvG4K9xUKSuIrmBoTXMgiAHqYQRR0cHd+3yWSMdWt/QsEakScR
	3x+d/JHXElk86Di5o6gBCn2iQBPBuATX+y1D5RBjgMdvKM0SdwEETyO6c3tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724391376; x=1724477776; bh=hd+07jzOWDjsUac5ck5LIV8+5EWX
	SdEWCAQw+stPqyY=; b=CsmPvwFJjKWwm0iwR5njcS0RipR0e2loMjwQsWigyt4S
	w528By9etNpWGuoYKNRRCXW1vPnz2M7R++rm/1IYb0bgtelAJDc8BIBEmRs6TpI6
	cMEcnVDC0RLOPfWFg50olGfDhlHcleIoOMacFU/O/yDx5OVEegSmwHx6p2N4l9pd
	dJrL7iuJoxe0EG1zl+OI/jjr126OUD6LDI86jzo4v/JquxO8LPQ9mGisZbIqwjkW
	wtH36iSqsEvhP9Ao1FFxpBKcXztvsXW+ii1KLldAk9P14pCj4Y4wlwLjSY/Fe6cP
	etMZyjWOCUkNOvXO7Z4UNxblzjs/WLiS3t1m2+B2aA==
X-ME-Sender: <xms:0B_IZuwh7G9Qhw4ftbaQOJtkwYBoi3p6Eufj_tp9LQMMf7ySXP9LVg>
    <xme:0B_IZqSVigOnxv9TaHds7tnUvs2pY2i0SlDVcYyly7msr51nZ9AqyoYIA3yllkKMl
    L5qHBNBPct8g1oRAg>
X-ME-Received: <xmr:0B_IZgVnAyfJMpF8qn4cwVv0g_IKmsCcNT6-DOl1hOIdUItFQSy8jVYgpestFpQITvWcTLIvgY61-KnTBa1rQklQiEu0h_0Apj6ZGe16bn3-kOx9cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0B_IZkjHgD5JRed86TAlQJDvmTL2p1ZSYuJIwb67Fxy6MZp1FyNzJA>
    <xmx:0B_IZgBOg7I4lEaCS8wBavw7O2G3yU0kvPgLZ-z2DqC4LNWTiqLanw>
    <xmx:0B_IZlLS4mIK7KjEZai-Z_Z_E9uURQhzcYX8meFn5st5tpTDMwQV1g>
    <xmx:0B_IZnDKvlVZ3dBEUzJxyJtsj7-rtmeLMZ0AFfD65zGzNewJAjc6dg>
    <xmx:0B_IZj83dbTC2XhXZea-8B_UpOSZfu9JRRAI5HKGMNL7pfDL4fE2JWKI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 01:36:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d6aab320 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 05:35:37 +0000 (UTC)
Date: Fri, 23 Aug 2024 07:36:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <ZsgfyogIFC1ECN32@tanuki>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM4OZWfylcP5Ix@ArchLinux>
 <Zsb8oDA-vyLxNY0U@tanuki>
 <ZscyGg8M8TbJVKNS@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZscyGg8M8TbJVKNS@ArchLinux>

On Thu, Aug 22, 2024 at 08:42:02PM +0800, shejialuo wrote:
> On Thu, Aug 22, 2024 at 10:53:57AM +0200, Patrick Steinhardt wrote:
> 
> 
> > > +		if ((space_num || newline_num) && !isspace(*p)) {
> > > +			ret = fsck_report_ref(o, report,
> > > +					      FSCK_MSG_BAD_REF_CONTENT,
> > > +					      "contains non-null garbage");
> > > +			goto out;
> > > +		}
> > > +
> > > +		if (*p == '\n') {
> > > +			newline_num++;
> > > +		} else if (*p == ' ') {
> > > +			space_num++;
> > > +		}
> > > +		p++;
> > > +	}
> > 
> > Can't we replace this with a single `strchr('\n')` call to check for the
> > newline and then verify that the next character is a `\0`? The check for
> > spaces would then be handled by `check_refname_format()`.
> > 
> 
> We cannot. Think about this situation.
> 
>   "ref: refs/heads/master  \n   "
> 
> We find that the next character of '\n' is not '\0'. Then we leave it to
> "check_refname_format". But "check_refname_format" will report an error
> here, but this is an allowed symref.

Wouldn't it be correct to warn about this? To me the above very much
looks like garbage after the refname, same like we'd also warn about
such garbage for direct refs.

Patrick
