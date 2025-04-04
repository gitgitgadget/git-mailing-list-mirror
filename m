Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAC1A23B5
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757798; cv=none; b=sCcjkW3xsmyDw4Hp3pQIW4DcOO4QdPfy3cCK0uw2F/B56h7Z2y1MI+Hdh6uWW1Pi015jAoHZegjQ7Xk+K80VqYI9a1aCWb8ALPE0PHjx1JUnL/EmVVYylyNRRhqPx9UPn74qZ45KkNGuwGuFORsytMPPzYknMdtJ9LjS+m8X3sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757798; c=relaxed/simple;
	bh=9U+mRuZgLWTcL5SjtZMVclJCPkWhgShnhYo3tOGUL/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUzvmvgZ+LqWQpcfRI4pt5qif2m7BeejFZOjEIDv+xl+S/seVRjIPCpILGHkLB3MaVSq2NjbcM/C2kQiqszS9O3jQDa3tgF7d8IBQ/TmekItC1BmC6+SN1XBYdGB6trXmByPVy+x3BIm9HXUZoAxtwDRz4L4xKTivGE7HTUbEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j3we/d7U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbtvRUnU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j3we/d7U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbtvRUnU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 99D6C114011B;
	Fri,  4 Apr 2025 05:09:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 04 Apr 2025 05:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743757794; x=1743844194; bh=x08LdIhv4B
	vz+MX1POn/ynCEW6bS1JKXYKSWBS5G7cY=; b=j3we/d7UmAEoEY6M2/EbbCmsGr
	dmMyMT93gebqgt25GcEOcp8VDsUSGaWytFjGPSuxYwcIb9U02w0z8j5u0VClByA6
	NGnoAw8ZnF1upJFIsQGvn7GMsne8mzuupio+7TDoN4i4RPF758M5LU6SEpaufbOV
	v+bmZHKZ5gKxzqzYZUL+UQKcmEvSqe0fnuXhf1DBlOh3amWGkWgMOWnQ5/qt2/FA
	Z8niRspwP2Paf+bg1m3ZJciiya/+NC6DLg9rQl9ynVQdQu+gBb3iHcfWi0NimioG
	Xfx63z1GF5yBKjBcnS+ICl8SlBJZNWj6+kvpwA3zGA+9cPlUcQrBBUUk/Z1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743757794; x=1743844194; bh=x08LdIhv4Bvz+MX1POn/ynCEW6bS1JKXYKS
	WBS5G7cY=; b=UbtvRUnUu9Gtkc+9nf6lUTtCbJh5EUa9EkhJzkQX7hFjutErqyl
	CbY1RlqzNN+nM2P5ZIeiiLsFZ6jGzIzhMXKxS9U7z0SBnMpDJoH+pg5iLQOldJdB
	YenUbFNVIUNlBcRusY1tzxu6mHamIMQpseX4UHu3ZlnpCOIx1B/d4af6Zni+krIv
	9Z8d/GgWPk/l7Jq+g2TaiP4pVBDIWW/OMQjrPZe/zXWofPgySO9xnL0FA4m0ZQcr
	hJm5ZhYRG2z9eOA6JOUNuBz7wfiA9EXj4n380tsicns7joZXlZLkInxIJ/ZdAuMo
	uvo2qMoazXQzLlBIVitZH5jqt3XLvdI9IMg==
X-ME-Sender: <xms:4qHvZ987xJ9GE-UzkjsMTxPz9hXG-9Vnzlwv3pjlLuqwyI7e5Vxv-w>
    <xme:4qHvZxv04S9jqTL-Cyhrfp1C1b6oPKKUI5-nrUKDpvPkJKagQBSX2LikUyG62wnCN
    g6Z8tiSNwGenyy_MA>
X-ME-Received: <xmr:4qHvZ7CJyc6gYw-7g73_sLHIlbd8273YxuD9Aaz-8NiVxELeEPvfCKyvs6KJpcBqzlLhXS9BGhD5oFBnCWzPET8bQujqAYyeVlwziVe7qBiTGeM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledutdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4qHvZxcsp_BQmpdoOYfcQ2ropw9ZE-ebYilWYrIr7x8RgvQZUiZ-xQ>
    <xmx:4qHvZyM0QnwQpx35p-A6psMgLnIO9zFvwDv31eCpOFfcK_KBKzeTvw>
    <xmx:4qHvZzlBMk7jMx4-j8ybmmr0svDH2HfpCQagBVxAKjeqQW4Q-lAHpw>
    <xmx:4qHvZ8uMKHP1uYpXGElWWemkWidiQLbh-RpuhY9d53Mduge2FPXcJg>
    <xmx:4qHvZx2zL--RR0xxSgVMpTmwX7f_bGfQPO-jHecJzxaYBexUnmay2cwc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Apr 2025 05:09:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 668017c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Apr 2025 09:09:51 +0000 (UTC)
Date: Fri, 4 Apr 2025 11:09:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, shyamthakkar001@gmail.com
Subject: Re: [GSoC] Project Proposal: Machine-Readable Repository Information
 Query Tool
Message-ID: <Z--h3rhY5XAERVHm@pks.im>
References: <7EB151DA-0BDB-4D54-BBB8-CEE69F51F13A@gmail.com>
 <Z-5famP3CgaSfDc2@pks.im>
 <BC393559-6A33-447D-9AE8-BB2D9D0BC0D6@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BC393559-6A33-447D-9AE8-BB2D9D0BC0D6@gmail.com>

On Thu, Apr 03, 2025 at 03:02:51PM -0300, Lucas Seiki Oshiro wrote:
> > This kind of information is exposed via git-rev-parse(1) already, see
> > the section "Options for Files".
> 
> Thanks for your clarification! But still, I was discussing with people
> here at my university who deals directly with research on FLOSS
> repositories, is it worth to find other uses cases for this new command?

It doesn't hurt to think about additional usecases, sure. But one of the
things that I want to caution against is that we now create the next
"grab bag" of unrelated features under a common name. After all, we are
trying to fix exactly this state in git-rev-parse(1). So the intent of
the command should be clearly defined to avoid this.

Patrick
