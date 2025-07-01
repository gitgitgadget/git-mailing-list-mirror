Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AD15E96
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365876; cv=none; b=UavGtZ4ksyqv3kn+uSqaLSka8G8fYwnp0mUaJ0ypoBMp/JdkIjrywNpdlWBZC5T4OKfIyYcwqFJ3EGn2tET9qdk6jfIiSsSodqQxr6OgD0HobsW3H32w9NoixauZyBdkjWP74DKGzZJWPCz+Q9gmMiprISPcGGUWtdIDYyDEG24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365876; c=relaxed/simple;
	bh=Kn3MOtzemtf0mGOcA6J9yQx7pg1YZ9sRlrjPIbF91D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAMUvySHHEVlzOOojGIAS/L21xy+vdCMxfRQA44xAfbxNSIwUjDILj0/gS9rwYpdCtrUTyHGvH2DPbWpH0rwcm2v1OGJHFBYXkSyF/Hmpqs3ue0sWFY7xxKGKcP3ClPkybHA+svL8fbTFC5ujqA2LgUIaXxIaDkACw3VvTwupOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PGSWc8Sy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZU7CyfV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PGSWc8Sy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZU7CyfV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ABA357A00AD;
	Tue,  1 Jul 2025 06:31:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 06:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751365872; x=1751452272; bh=s+lA4lChiA
	GsxQJ23YhGVSn/uOySXWw19dNdzVSLkwo=; b=PGSWc8SyqhFQE9dXpcT8Vg7b/L
	DGz2wSgUmiyN98VtuzQZ6/d8cI3sPYEdOqnQYkeaYIaQQrXNeJ3okk+kNU4FC31A
	Hb9U/xk6XaQ026bU+DBgKezfbdzg+zrIE8+UBA57jPGj7pwIOse989rWjuH0TpTM
	DLWXVhpf6zm0P36j3c4wATOB5OyGs5RgU234FlAAKciF8jpHm7iEMu+qdpHlSau6
	05Ie7dxCszsGF+Gl3vVfFnJWf+3dR6KiNtaCr55TxhGxsFhfu7OHWXRXjranWrSw
	MQjmHBE3rPRm9BI+wxip+Q0FlpyGPBuXwVYm1s814cMGwZjF7IUXZhT13/oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751365872; x=1751452272; bh=s+lA4lChiAGsxQJ23YhGVSn/uOySXWw19dN
	dzVSLkwo=; b=MZU7CyfVQ/7O/7NqG+813HKb5IfrZHKhd4uCpkbwX9yQDBORC8r
	tXloDzVmOobI6vxJCBV5xY2nCy9dHc3dS3naqpFsryduin5vqjAa8NCMkYFNE1FS
	P6KkGdUGRnyI1qXKLYkqzSTnoM1VCivBbb+IjrY8PGhBbgKIw4ycIbOulQslud8y
	+w2pLT0l8/B7qX06ZTGfBFzixWy5EKaAzrGFzU4BpCyqLT0RSddmQln9zxW3B2LJ
	itrhD3Ksh9cCby61YrmjF0aKlD8DxTS1McAU4ZXnKMC8h4UXm5kI96BO6HktFVyF
	sZZYzzNAAT8Mr+5FR63Z3Ocsi4tpqUhBFzQ==
X-ME-Sender: <xms:8LhjaH_uDRw7LtLbe5fcE9BnybV77AgIiOkMLHoPHtll_2jKTp2ZKA>
    <xme:8LhjaDvCPr2IdcT98TuranJWkCNztbGIU2gq6fs9Z2tpAwPdr-qSk0kRr2ZcFa9Nb
    yGQ9F1I8RnswJzf7Q>
X-ME-Received: <xmr:8LhjaFAN_iVKUupAMMmOqbFXdkC-Hy3wv8tUbqJTeFjQIBb_s1a7rNzka29eCAIGjfX8UF3mj0TSjv1qiLrD0uBGOCUAW5J0xhsK-Wmsjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehrhigvnhhushesghhmrghilhdrtghomhdprhgtphhtthhopehjrgihrghthhgvvghrth
    hhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8LhjaDf3xFdJyS6WQ5biOqrRh1al7GkpbPVd9S3L5XW30S17_SPSGg>
    <xmx:8LhjaMNw8CmeWFjr8V6GmmTlH7Z4W38s7G6j9E6_1woZPknQtnO3uw>
    <xmx:8LhjaFnRWW-lWD6r8M5kGXmmTJWyWbxr5d6_KgvnTf9fag8U7oY7ww>
    <xmx:8LhjaGuq_bkmMDOTBpBLSiYETHrPoGUo8yIHmrlOAMTNij7aQONOsQ>
    <xmx:8LhjaFkNl0yIBICNc0b86yFbuFXZ2C70ebMx9jhL5hwybGt9J5YUrLl2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:31:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 419dfba6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 10:31:09 +0000 (UTC)
Date: Tue, 1 Jul 2025 12:31:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com,
	git@vger.kernel.org
Subject: Re: Re [bug] pull --prune could not delete references due to lock
 file already exists error
Message-ID: <aGO46urHzZTZvDve@pks.im>
References: <CAKkAvaw0sZ0sW9o_0NZdnZknS8M34UST3PetaPBQj5wwvJyjBA@mail.gmail.com>
 <20250625141849.78834-1-jayatheerthkulkarni2005@gmail.com>
 <CAOLa=ZSA273KGPnwZ2aRBU_ybcCTYogBHvUwpa+5CfDOc2bEWg@mail.gmail.com>
 <aGKdICvmKlumU0ru@fruit.crustytoothpaste.net>
 <xmqq1pr1lyur.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1pr1lyur.fsf@gitster.g>

On Mon, Jun 30, 2025 at 02:10:36PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > Another option is for users on case-insensitive systems to use reftable,
> > which won't have the same problems as the file-based backend and will
> > preserve case properly.
> 
> The more guinea-pigs^Wadopters we have, the merrier we are ;-).

I'd really like to start thinking about reftables as the default
backend. They fix filesystem-specific issues, compress better, are more
efficient in most (not all) use cases, sometimes significantly so, have
better properties when it comes to repository maintenance. We could for
example make "features.experimental" enable the reftable backend by
default and add a note to the Git 3.0 breaking changes in that spirit.

I'm quite certain that reftables are stable enough to not cause any
problems as used via Git. We have it rolled out to a couple hundred
thousand of repositories on our staging systems at GitLab, and will soon
roll them out to production systems. I myself have been running with
reftables for 1.5 years now and haven't seen a bug after the first
couple months.

But the bigger issue unfortunately is the ecosystem. JGit supports
reftables, but other implementations like libgit2 and Gitoxide don't. I
partially got myself to blame here, because I haven't gotten around to
updating the libgit2 pull request and am lacking the time to finish that
one. So it's probably a non-starter if all tools that use those libraries
cannot access such reftable-enabled Git repositories at all anymore.

I bet there's also tons of scripts out there that just reach into the
filesystem to do stuff, but that's something that we cannot really help
with.

Too bad :/

Patrick
