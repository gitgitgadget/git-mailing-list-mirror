Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CEDDA9
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 02:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947928; cv=none; b=iRD5cHLjtW/xKnckP1HkYznwpnjLKg9hIeTycy2ZlAZN66P8zkkrYQURqFV9z1SBxmsTdCx1sowxCwEJ3txQdQidprJGdBSZfrhioI6CLGWHtUVLqR/vaSuONU4irZpdBeoeJSlem/v3PPyGtSEIUV/fhdH5OdQqR38df2gGbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947928; c=relaxed/simple;
	bh=N7eIFgLd1leyt4o6HE42NffRioUW5qLH16pk7P8f0J8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X07Bq01ee6GII/+iUnYGHm46pJq7QWA3GnxrzgWSkvXzppe8kSeaFgsG258fXUpz1KjlEhnHoxI0QrU2By/Q+w8jdIbSc4yjRCNCwtGY8D+XyRTzCdibVvFUeb2Wakwq9AMXRYugTsZYqr2rJcS3LSVFhtocEFqOwjwAcmn2Gmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cvRJ3xHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UescLKH9; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cvRJ3xHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UescLKH9"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E795A11400FE;
	Wed,  6 Nov 2024 21:52:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 06 Nov 2024 21:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730947924; x=1731034324; bh=66ks4LKIH+
	h1DKu6ZkkjXFWPED2inFRGQM4sbJMeL9U=; b=cvRJ3xHUklaK5JIcKjSbu3fnh7
	aeZG7vLsDB035/PWLLEGLxS5mzN+ndIBwxh+SKfeoKHqI17mpQJklXXZdruvcKGe
	KJ2NRvU/UpiBZNymANV1F/pbJvq/BYFYA8MuDkr8e7K0UPBj4W2DxdZrcA1cqP0D
	Mz5D3PWQAMiSh8GbTtsXiUEAKv8glmhxv3P4usc7F+XwSxtDoMNYI6+95+agQq5S
	nDjpsn4YG4fCYSxDO4BWoVbmBbFej4rtORAYtK/Q1rv421wclPyMVZHFGIWGzOZT
	bl9jlZTuksdpJkU/ll4Nu81meiaotfeF0GEBDIo9h4LupN3gOSj3KfhQ1/Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730947924; x=1731034324; bh=66ks4LKIH+h1DKu6ZkkjXFWPED2inFRGQM4
	sbJMeL9U=; b=UescLKH9NafE6XEa1jmCYkJTtbotMVe4lMuvBj58ecapBHQaHi8
	J/AFlXXlHLqgy5syKoBVx8XFvR6IucnpWhyVj8uNdQ8d4Ctvklf4Y6TbTL5R50UP
	bZVYga7YG971Na3Vxo6OYMXJ4jcR5ku6PMSYX4ivF6fpfoyJYEZ1hhh0yrLJH5m1
	Bco5QnCGD61QVzj6kYsXdHAxt03Lr3YK5/7o9HgtqA93ENJtcYEXMTP+L21ym6Ve
	kOSLsV1szjhaZw0F6CkHIOXF1zTeNstOZFwk5mtUeIqIKcKDDzagqkD2eUwpTwVE
	jwQ2WB6dxx48t5Txm5rH1jvFtoWZfiYiplg==
X-ME-Sender: <xms:VCssZ9TOODruoSiAozNMZHHTuxfw56dtqHPfSsg3TocYn1ZWZhDYww>
    <xme:VCssZ2ykaJ-2aDibX92kumtW7CRxYF6helRszEb8dm28nw3HTle0md6DlKX9piWeL
    Cyrs32Qtc-qHSR-1w>
X-ME-Received: <xmr:VCssZy1iNxYtXFG-fA-mIHNVicTNvivSqcGoBC4LVFRwBwNDiW6SEMR-ZcEVPDhQE4qNV-Pdgs5prGov2TRFSvlJ4fpWuGR7hxix>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepfhhivhgvvdefuddttdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VCssZ1CnKAR_ARK4rkXT3ls7Z_VDMQkj7qjs9MEdEt16Liussr76ew>
    <xmx:VCssZ2jhpCWbAFxK5Ntucuec9bJ9qX7O70JQRVtyviktp0fDBNZXFw>
    <xmx:VCssZ5oFfqYRczcF9W_XobKWLmwAhpCZYvySUhQNODEU4dw5r7OrIw>
    <xmx:VCssZxhQRkWqRPrPj2kBL1GzD6v4HVA-pWCyk0C0M189-J9DGSmkpg>
    <xmx:VCssZ4Z30OYz67gHfCrdaY2JZULdejrffEfuU5WxojTQhg3B92qnEeqZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 21:52:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kousik Sanagavarapu <five231003@gmail.com>,  git@vger.kernel.org,
  Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
In-Reply-To: <20241106185102.GA880133@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Nov 2024 13:51:02 -0500")
References: <20241105190235.13502-1-five231003@gmail.com>
	<xmqqikt1qhwt.fsf@gitster.g>
	<20241106022552.GA816908@coredump.intra.peff.net>
	<xmqq8qtxqcye.fsf@gitster.g>
	<20241106185102.GA880133@coredump.intra.peff.net>
Date: Thu, 07 Nov 2024 11:52:03 +0900
Message-ID: <xmqqo72rvjqk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> who is doing:
>
>   %(if:equals=%%foo)
>
> to match the literal "%%foo" will be broken if we change that. They are
> not doing anything wrong; that is the only way to make it work now.

Ah, you're absolutely right.  Unescaping would start breaking them.

> I wouldn't go so far as to call the current behavior a bug. It's
> just...not very flexible. I also think it is unlikely that anybody would
> care in practice (though I find matching refs with ")" in them already a
> bit far-fetched).

100% agreed.  For that matter, I find "if:equals=%%foo" equally
implausible.

> If we wanted to be extra careful, we could introduce a variant of
> "equals" that indicates that it will be expanded before comparison.  Or
> even an extra tag, like:
>
>   %(if:expand:equals=%%foo)

Surely, but if nobody screams, I am tempted to suggest fixing the
equals/notequals---we do not have to be bug-to-bug compatible with a
buggy old implementation. After all, we do expand the string being
inspected that appears between %(if) and %(then).  I do not think of
a good excuse for us to limit the string that it gets compared with
to literals.

The implementation may be a bit involved, but shouldn't be too bad.

When .str is an empty string in if_atom_handler(), we can follow
what the current code does.  If .str is not empty, allocate a new
stack element in order to parse the .str to its end by pointing
.at_end of the new stack element to a new handler (call it
if_cond_handler()), and pass the if_then_else structure it allocated
as .at_end_data to it.

And in the if_cond_handler(), grab the cur->output and overwrite the
.str member with it (while being careful to avoid leaks).  At the
end of the if_cond_handler(), pass control to if_then_else_handler()
by arranging the if_then_else_handler is called, imitating the way
how if_atom_handler() passes control to if_then_else_handler() in
the current code.

Then things like

  %(if:equals=%(upstream:lstrip=3))%(refname:short)%(then)...

would work as expected ;-)
