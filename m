Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC11E3DE5
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740858070; cv=none; b=X1EoNiivVCAo878lMD330oyVR2sTksUUWAR32c3gZUngPdD0y7WmjYPOc4Mzo2G2Hqj0IBTMQFycitr/J/6+wSo53U49Y/6+sxTdlcGyykP+nmbCdXkHD/Mq4VaUXwTn/5al88qwNWG9onWeT0M4xFLX717fwf6rR8LjlzDxv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740858070; c=relaxed/simple;
	bh=G/S+XQR2aBetOf2xJTf5V08oD7gwJAzix64UnnEltmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibTke4hfyiGzCDPYhmZqL8DWXSkvG7RKZ6kF7PQIHoYqxBpP7ACWscqbd7IztIJQX01OsMp1ncolSKzbWNgmcE0RY1wi1bow7IVJrkc5vPagblFCAt13Z68RNyDJnAuXS6qq8vTjMOieF7qDmReuKlurZULjq1+hfxyZr5TswPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oeoqwiS7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j+FJoiWi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oeoqwiS7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j+FJoiWi"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5345D1140081;
	Sat,  1 Mar 2025 14:41:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 01 Mar 2025 14:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740858066; x=1740944466; bh=RD1Ginc6n2
	/5Z7i4f8DpzGSDWfldk5XnFWklQn2Nu6s=; b=oeoqwiS7PUT6NeX+HPjsB4MfdO
	KOLEYh8xVfe6vU5sOjnhjYZy+XLiXDZ08ikop5LDcRU9AClwvt8Gc6b50wFL650W
	gZ9aHdPZOJEjKMvW7VPS8s2d1iJ7dWKgevQxjdZUpK5vCU8n27r50rtmei4IrXEe
	EtSzs3ZOH0C+YFsxVTYOkBJu9d8UNSLfJSBIS5ATRUCwg4M3u13m/hfkCOnLNK9e
	PG3qR/ukeU3ZwDUUWIIcnn1BrlaNXoCLMxy2FRcd3cKAN3k+0fEouiUzxMo/RpZ7
	KRIaTluOsaP1aVpMTF6edbAf68p32YV1seZwN2pteX9A12eiN0VINI6fAXOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740858066; x=1740944466; bh=RD1Ginc6n2/5Z7i4f8DpzGSDWfldk5XnFWk
	lQn2Nu6s=; b=j+FJoiWi+UejV0Gw3tfLQgcpmR3hdfOmL9U9aB79KYrpQr+WCgO
	B5udmrmreilpaaTgGQx+TaFf2xBxetN0cMIzDDYzMK5lmDVRHObrU3A9DlFuLDan
	/i5IlfojtZRI+4Yag70UaaeM0kkOlOCXMbWIUctpgVI1bHTpkIx9MHM47w0NaK91
	uoE79ZyQg/30Eahe8HM+hBGHqDyKyhUZiqV4uKexFhV/w01KxOybq/JQiOmgrsgh
	gQHspmbfG92/50o773QlNMg5DfGeXlmW1ImiZUeD2mPfkDTXlenP5GKsGYajz+O8
	HW6+nF9I/W9FC3GAAX5GpBUGw2yT3XQ/lJw==
X-ME-Sender: <xms:0mLDZ2KExZb4Spfo7qV13Bckw1oVZ80-2UhBJJdgD5UeF8qSe-GtIg>
    <xme:0mLDZ-KFV_VEWGTjqgc8GOxvijaIzMmQ1P-v_N3A-029f3tiddlQuRiEsH5qotg6m
    J91Pj32A-a3wBWlbg>
X-ME-Received: <xmr:0mLDZ2tlRXit5NV-whf9ZJ6yyHoOEMeZps9nCb8JQVQ_p2V3GGsjcpQQJDjQGgAisGOYCFdLS4WPxfj0BwnZoyXgi8feMN7dlkua-2Ibt6yFPFydORda>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgveefveeihfehhefhgeethfdvffehfeehueelheei
    ffeuvddvuefhveffiefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhooh
    hthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:0mLDZ7a8MRy_dmn5SerQ0hj18hnsBkN2fMapJdgpxRXY9iYE1aTPYg>
    <xmx:0mLDZ9ahxLiJ95CsqCGxz-2T86KuJTcpyu0GSn2XHsLZUwKBs7Wt1Q>
    <xmx:0mLDZ3DITZtl075r-ZG6zkBTw4PSr-aBY3Tkq_QwbeCujVvNTQMz_Q>
    <xmx:0mLDZzaJEFyTxc1XoFE_qN__HeZq74L3YWlSDOGpUAtT1TsYZ6Ws4w>
    <xmx:0mLDZ8XIGdeQNMgNNpfJKDu98B1Mpl4NR0cGUiJjlr3L41gSFl1Hu9JC>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 14:41:05 -0500 (EST)
Date: Sat, 1 Mar 2025 14:41:04 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 4/3] doc: fix build-docdep.perl
Message-ID: <Z8Ni0EyQYgD8uWJ0@teonanacatl.net>
References: <20250301153607.95746-1-tmz@pobox.com>
 <xmqqh64czk7o.fsf@gitster.g>
 <xmqqcyf0zjzt.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyf0zjzt.fsf_-_@gitster.g>

Junio C Hamano wrote:
> We renamed from .txt to .adoc all the asciidoc source files and
> necessary includes.  We also need to adjust the build-docdep tool to
> work on files whose suffix is .adoc when computing the documentation
> dependencies.

Good catch.  This change looks obviously correct.  Testing
shows that it generates the same content as in 2.48.1, apart
from 2 small changes due to adding config/trailers.adoc in
the 2.49.0 cycle.

I took a look though the output of `git grep -F .txt` to see
what other low-hanging and/or important fruit there was.
It's a decent list, though I don't know that most of it is
crucial (any more or less than imperfect documentation ever
is).

Here's a "quick" list of what I noted while perusing that.
I may try to fix up some of these, but I doubt I'll get to
the majority of them anytime soon.  Even if I or someone
else did, it may not be worth the review time during the RC
cycle to try?

There references to .txt in various .gitattributes files.  I
suspect that Documentation/.gitattributes could just be
removed.  It contains only `*.txt whitespace`.  [It was last
changed when it was added in 14f9e128d3 (Define the project
whitespace policy, 2008-02-10). :)]

Other references to .txt files appear in the top-level
.gitattributes which should likely be updated:

    /Documentation/git-merge.txt conflict-marker-size=32
    /Documentation/gitk.txt conflict-marker-size=32
    /Documentation/user-manual.txt conflict-marker-size=32

These were added in b9b07efdb2 (.gitattributes: add
conflict-marker-size for relevant files, 2018-08-28).

The README.md, Documentation/CodingGuidelines, and
Documnetation/MyFirstContribution.adoc files all reference
various Documentation/*.txt paths.  It's probably a little
cruel to make first time contributors who are diligent
enough to read the docs then stumble over outdated
information. :)

Documentation/howto/new-command.adoc references
api-builtin.txt, but that was removed long before the adoc
renaming, in ec14d4ecb5 (builtin.h: take over documentation
from api-builtin.txt, 2017-08-02).

Documentation/technical/partial-clone.adoc references
Documentation/rev-list-options.txt..

Makefile references Documentation/technical/racy-git.txt.

And there are a smattering of code comments which direct
folks to various Documentation/*.txt files.  Those are worth
fixing, but likely anyone deep in the weeks of fsck.h will
be able to find their way from Documentation/fsck-msgids.txt
to Documentation/fsck-msgids.adoc. ;)

Cheers,

-- 
Todd
