Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F701FAA
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471661; cv=none; b=o84y8ZnSjXhrlMqcaUQ6iH1LUewMlzzaeBT3XqHBCEhPHmgPXVQIjV2th5aTtrJjPKTm95PvVMh55PNZSzXDgUCAHUsFrnFOfTR5qhZokoDLUQHKUfnLGvuWetMmMDVxOMd7HP4eGCnIGO22h2sk2LqtERJtjCzjHPTLdWQzOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471661; c=relaxed/simple;
	bh=24CSjIzYD+0pBKhI81x3mNC+XB8q0KRytb/0/QaKRjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTxVvWqrB5H57oM5JqSdwyQnXLHmA9+pZUgrG5+A4Eor9siUbgHyQ1N24wGP2Xz0vILBOsmW1fCquDZ4+ieM+GXeWxN+EeEf6imNrCyB82+Fii+TGX8bs9Rf6yIPKH1IOOz4nI/BKu8yGT63lv75VM11b0PRnLAuB20Fzg+vQM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oVKGEUqu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=stbHqldq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oVKGEUqu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="stbHqldq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 67DD71380105;
	Mon, 16 Sep 2024 03:27:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 16 Sep 2024 03:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726471659; x=1726558059; bh=h5p3bUJkO0
	ttP4dnfmHKRJs8SFiDUMSfR+HENK700QE=; b=oVKGEUqu9l0q4InzxNYYUi4MdP
	hvgXquD+A9+Ou4GRUbrAmFr0N2pLnI8OsTbWg08RkiWT7Wvb++jHfGSEfOPMNhtG
	N9SV0AFsv0aJNrlgR9aZQx3bwtz3qQv0XwaLwroKZ9/+PPhTzUTrf8Zjln6C8Vf6
	0b/KUovJ/OwSbq3lwspdspB7rnCbLXuCJPxTGrMDBinLbVAVVeUnzs2jvONxYWzL
	q4pqU2/wIOmRS5Z+IRQBNiZKbYOd+U1iga0xirGzrMLYC2PHjU11RTee9G2QIWxv
	pCgNDljp6wNYnOLW5XVORkku8N0dImZPDwva5N9W+uX3z5wskRUKehYWu9tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726471659; x=1726558059; bh=h5p3bUJkO0ttP4dnfmHKRJs8SFiD
	UMSfR+HENK700QE=; b=stbHqldqe1U7IQ9dC5vI88biXNVoDqEcrW9TqT6suJ5+
	MiUNR90HMnajKvCyfMYr4UoTBDBqMvfxT8vVGJPp0Wwf4J7EfJjR6jePeR02CXJO
	Ne77PmA7z0mLbwz64+AZBxsfzRv8r2DV+gJRTR/3ixw9nqMP1Xl2Cn3IlZK+G8LZ
	88KZ6pV2K8PB6T5f2a/V36vwd7oGfJcPrQ7HdHyfXG8FsS4VgM1b010rtEongW5A
	gJwoMjsFmcuIySjENTKD+WbCbAgL8ByCvL9JdAdW/+1kTQ22kavYnB6x+yV6LjQQ
	QN5I39rnss0kPblI6D0t+3Cy7mlkzIFO1rxLZ/rA6Q==
X-ME-Sender: <xms:693nZr7x5V9tuUKCkiVGxu8sYIlli0-U-1A-AWeEEvZqiX6KLgC5Xg>
    <xme:693nZg6-NlOit34VFysv4o00qpxn2bdvb7WZnmZJ9y63TN5QCJ2Ir_b8kNzpUhuTl
    _YQx-uy2Izyz1Q8cA>
X-ME-Received: <xmr:693nZifYV-1udFTxQReZKHpKBGm-7m2JLC_tWXv_XA0_pWbjpaCPY_PIwzmfHLRlK9N7BAb9tooVGG5suD9w-u9Lpz7gb0NSWiIiZ-hTZjgVZEYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:693nZsJ-cVU3qVTgeYewl5w7GOzZa9cTj1oc7aWB-pyq9wa4XxMOmA>
    <xmx:693nZvIIUaxKgIndu7rWCbN5U4cbT6_ACt3yQKvoVW7SCZwDKxyaAQ>
    <xmx:693nZlzXiMiyjVpKMXSXUmTCa5H7EFhwUVj4MY6F_Sehb8O3ZCXCrw>
    <xmx:693nZrLrLRc2eQou7Z9FmppdSX_ZfSXZapDVpTNwQu7ke2f6lhtnAw>
    <xmx:693nZmWCxeBP_8L3-tkTU7cGRd4ZnVD_yeTcp3Dr7xhv0T3zzShQyXby>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 03:27:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27b13872 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 07:27:20 +0000 (UTC)
Date: Mon, 16 Sep 2024 09:27:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t9001: use a more distinct fake BugID
Message-ID: <Zufd4BmUu_fRBBrd@pks.im>
References: <20240915113115.GA2019070@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915113115.GA2019070@coredump.intra.peff.net>

On Sun, Sep 15, 2024 at 07:31:15AM -0400, Jeff King wrote:
> In the test "cc list is sanitized", we feed a commit with a variety of
> trailers to send-email, and then check its output to see how it handled
> them. For most of them, we are grepping for a specific mention of the
> header, but there's a "BugID" header which we expect to be ignored. We
> confirm this by grepping for "12345", the fake BugID, and making sure it
> is not present.
> 
> But we can be fooled by false positives! I just tracked down a flaky
> test failure here that was caused by matching this unrelated line in the
> output:
> 
>   <20240914090449.612345-1-author@example.com>
> 
> which will change from run to run based on the time, pid, etc.
> 
> Ideally we'd tighten the regex to make this more specifically, but since
> the point is that it _shouldn't_ be mentioned, it's hard to say what the
> right match would be (e.g., would there be a leading space?).
> 
> Instead, let's just choose a match that is much less likely to appear.
> The actual content of the header isn't important, since it's supposed to
> be ignored.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I guess this is fairly unlikely, as re-running the test with --stress
> didn't reproduce after a few hundred attempts. Back of the envelope, I
> guess any 5-digit sequence has a 1-in-10^5 chance of matching our
> target. There are 2 in chances in a 6-digit pid. Some in the date, but
> as there's no December 34th or hour 34, you're limited to a few specific
> times like 01:23:45 (or at 11am), 12:34:5x, or perhaps 23:45 on the 1st,
> 11th, or 21st of the month.
> 
> So I think I just got really unlucky, but after spending several minutes
> debugging, I wouldn't want to wish it on anybody else. ;)

Heh, unlucky indeed. In any case, the change makes sense to me, thanks!

Patrick
