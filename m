Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFF302048
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637203; cv=none; b=W4+jo0hpJI5VCDQJ40ObrUPSY0RlVxuhqWVWMVuq7Qwxo1v3gijnn2V0aYuNAxw3gpyl2zny5iCt2lCSgZzMpCOrCF55od4nYa2e2Q6Pw5LsUL+3yPaWvylVxgudpKtYePSa48qEt35hiJC1Fl6q6CL/kmBGHu+nXHl5efcp/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637203; c=relaxed/simple;
	bh=jqmxEQLCWp9Cs9p62n7cqLt/wQg4Rmb8SSi+i7ZmqO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjM7q2LZITonxNX6Rff15vK1SuLzV9geZWScVZqlEmJNciMBmWHOmZDx78rMhTUk4H7M6WRLkrkuTp5BohZqtEXYzmZ1p41y/tQJJOHSSDcwlhT/PqNSJDTQ7TK+lQo1XjzZHYpOzUvsdncb+zVvnABZQqXQlnIEajxLO0fycOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iGvzz4HI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXFc2B7t; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iGvzz4HI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXFc2B7t"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A206EC01CC;
	Fri,  4 Jul 2025 09:53:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 04 Jul 2025 09:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751637196; x=1751723596; bh=3yd9eL6ssT
	TCG0/eQzPakrqHAPDMAdzaNvvbhWIJseU=; b=iGvzz4HICtRkFHeFbaiPnmJvyf
	nx4zw+PwJCugRQ/vfCXfM00cRlL+RYGWFd52x3a3/wObf/NlET00qQpveXBEdtwR
	btPIKrgWAbH+6KOy8s3DRxDuLfZCgfb7PAAC0W/GpAcNXTz+9MbGyZICJqjAPK5g
	SBO/ydmoGcm7cbJakYblFAZXXl6F6Hw9+cHSnoJ/W18HBITVHW/w//MiyOhO3kY3
	LK2b2iMVAF2gPgb3Lj3hl18qtHdCm/up8JS51yITbjVqNK6UBytfBw7S3QF2ibGT
	0aS8gLiiABoGjfAC+ws8UDCNivl4TLtTv7D0EZFG5N59GE+FuZPqC6M0SjDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751637196; x=1751723596; bh=3yd9eL6ssTTCG0/eQzPakrqHAPDMAdzaNvv
	bhWIJseU=; b=YXFc2B7t1yHSWywnb1fHXvf0NmU6GZ4BSyYm4jLffLO89JSHYWt
	eXgCe+C8dF6c3/9nFP27U6bCZvIBFXSFRklxpfOFMKAAyl/wVNFISXYTy27hapRN
	Dwf5luE6nERZVxHkob02RThYhFONywJNqNUK4O0nIva7H5cy681PeKnzENLgZ8HF
	Zypgp9A9bQpKs96aqz1fG1DtWxZd2qStXiX80GBdTiCe5pQVYsZRLwb4TQbnBVeR
	/uKft7USqx/FqYvrqXkmd4VyK+bT0yCTN7Tx9GYf5M13lsZYy8+mNU739VfZt3+b
	1sH3uPtVhSuMpU2lrGZYiz8vYVqku7fXqfQ==
X-ME-Sender: <xms:y9xnaPJDGJieBsqWwUEEvBv4xNJFNv_X7zxf67cJpRNiovhVHrWAtQ>
    <xme:y9xnaDJ2blapXIu_6g67Bqbanc8PioA6WGAMBvW3Z1dKelH9QonCf8tT4ypIF1t0a
    mkSzxdn7ZHxbpiPnQ>
X-ME-Received: <xmr:y9xnaHuXsVRKxYZa8Tlj6VJ7XlGbx4aFH_EB642ggK170IG5kWD4K_OHP3W7eG76np6s2CWDAHZiqqQKMEz-NcbiHwZqqq9OCDStegUqJnLalbSR-78->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghu
    lhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    fgveefveeihfehhefhgeethfdvffehfeehueelheeiffeuvddvuefhveffiefgueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegsohhrihhssegtohguvghshihnthhhvghsihhsrdgtohhmpdhrtghpthhtoh
    ephhgrnhihrghnghdrthhonhihsegshihtvggurghntggvrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrvghnsegtoh
    guvghshihnthhhvghsihhsrdgtohhm
X-ME-Proxy: <xmx:y9xnaIZt_TFxxd7LKora4i2SGw07D_tNwZGveNQCOx5zRI4Y-2Uqbw>
    <xmx:y9xnaGbKGWHBEC3bDWAqZDlFVw5R2WpdXTmDaXdG0d7yb2aHALFmeg>
    <xmx:y9xnaMBtwQ7n2GO-A7321my4AeWfCVhKfUp20CPbdBxnvvkAkJyXEg>
    <xmx:y9xnaEbMkzDruhhc393Zi_qUvrl3aDOfsPgu7-C5UYjQrWo126UAeA>
    <xmx:zNxnaK60oPQH3CU3YscV4gNsgAEpkd-zeDIyjD1kfNIuZ25rXekjdiBO>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 09:53:15 -0400 (EDT)
Date: Fri, 4 Jul 2025 09:53:13 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Boris Kolpackov <boris@codesynthesis.com>
Cc: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org,
	karen@codesynthesis.com
Subject: Re: Document ability to disable template directory in git-init
Message-ID: <aGfcyfJ0hkZ7kF7_@teonanacatl.net>
References: <boris.20250703161436@codesynthesis.com>
 <CAG1j3zEiD341X-_ZdR2puaEmZZ0ZBWSmyboyyGZaDXcDTcmAeA@mail.gmail.com>
 <boris.20250704123013@codesynthesis.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <boris.20250704123013@codesynthesis.com>

Boris Kolpackov wrote:
> Han Young <hanyang.tony@bytedance.com> writes:
> 
>> Digging through the changelog, I think the feature is added in v1.5.6.4:
>> 
>>  "git init --template=" with blank "template" parameter linked files
>>  under root directories to .git, which was a total nonsense.  Instead, it
>>  means "I do not want to use anything from the template directory".
> 
> Thanks for digging this up. So in a sense this is an obscurely-
> documented behavior that people could reasonably choose to rely
> upon. I think only more reason to document this more prominently.

The commit which added it, d65d2b2fb4 (init: handle empty
"template" parameter, 2008-07-28), notes the behavior:

    init: handle empty "template" parameter
    
    If a user passes "--template=", then our template parameter
    is blank. Unfortunately, copy_templates() assumes it has at
    least one character, and does all sorts of bad things like
    reading from template[-1] and then proceeding to link all of
    '/' into the .git directory.
    
    This patch just checks for that condition in copy_templates
    and aborts. As a side effect, this means that --template=
    now has the meaning "don't copy any templates."

It was released in 1.5.6.5, just in case anyone is looking
at the release notes for 1.5.6.4 and wondering why this
isn't mentioned. :)

It came up in <20080722200911.GA3097@sigill.intra.peff.net>
on the list.

It's been this way for 17 years and seems unlikely to
change.  Documenting it ought to be a good thing.

I think that may fit best in the TEMPLATE DIRECTORY section
of Documentation/git-init.adoc, if anyone here is interested
in taking a stab at a patch.

You'd probably want to confirm how git init behaves when
`init.templatedir` and `GIT_TEMPLATE_DIR` are set to empty
values as well, to document the effects fully and save a
future user wondering why the docs mention --template= and
not init.templatedir or GIT_TEMPLATE_DIR.

If they all behave the same (which I believe they do), the
docs could just say an empty value causes no templates to be
copied, without listing each of the methods by which it
might be set.

-- 
Todd
