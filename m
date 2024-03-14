Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C50579EE
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 05:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710392803; cv=none; b=Pj1/Ln4F3Rzjn35oCmpCc9wBZO5FmlGAiZliMIPH4nV7tCjW3ssGfvzELxqR6NVgfw3gdLEEvEr8CYUkwZ4/5HnPrxgh1FZXb8CF9thAXarLqFcAz/or4juqgeBYgR7NYGeluv24wbdqW45+1ZFIt5itGvCk//VO8kf85Cy7Nw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710392803; c=relaxed/simple;
	bh=V41PNZRImUGAl+/r+ykAmyamRC9Y/LdSKwR+68iTwBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=strkVASw4n1utSjj44qwG3ZWrlJrad56tWjfB99dkjtsLGQyDwUrXFLRi+Dhp6doOWXE4YJXTTv7NwRJIGPENEDmBiJ/SqZsK3Iv9k561HfmKNvlKdlvQwEqUW8lFsv33TD2EOmA9qLWLqC8X7CwRJPryxy2DcBO7wpFJvijLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net; spf=pass smtp.mailfrom=who-t.net; dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b=DNSMWGKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z4WW4Efa; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=who-t.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=who-t.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="DNSMWGKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z4WW4Efa"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id E07DE1800075;
	Thu, 14 Mar 2024 01:06:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 14 Mar 2024 01:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1710392799; x=1710479199; bh=HlxRACooT6
	rbtMqDNW+xdXVze9f+PgUpwW5Wmv/Og1w=; b=DNSMWGKT0dwfEf7r3b01Zb9p1T
	mKmDxOYONYisBH05zyvQa9mfy/8LjMrLg8Nc6hUvsUAQ7D08F0Wxiu5yN2wsXrVM
	F2wnil+dpVU8l92I9TUZQu2oXbTrKVQDli6+6TOqT/TbX273+JEYaoRnU3MVF1ka
	IJoXXUzhkqA1FHHm2YYo7DP1d1qOAX9PNRHgZzpE4KOtgzVKRPRKvxvqSo9MT+2t
	S9SDoeodcxcrQuUrEcLURv7q46W119uAKVy5ch4bGt/qtERszogqK2M87hWXLkqy
	NvZ6FGPoB8KoswBfRXOZPYYVHLO1qhF5iTFDb3ASPBZLhLJZDEzTPx5kej0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710392799; x=1710479199; bh=HlxRACooT6rbtMqDNW+xdXVze9f+
	PgUpwW5Wmv/Og1w=; b=Z4WW4EfazP5Vntu31lfoqEnNrJ3sHxwjvEybDxwTcRll
	SnvGlRvEhD+sGTpzlGu6SjdX6nD5XEG5hXfViWx25PmTKdBmrASjU4UGZxSKVxG5
	rxaXp5nqyfy50qs1qiCHGFMz/LWwAxKNsz1JfI9CybM60oIZVflN+cJkKFjgrGNz
	ke55kJ5mkm6iH2jOWTmOh92rZsJCKE17N1gvH66tUOKL3Fgf/bkpJOL8pW/zKFMR
	1zIlf2UTwwDwRXTofFDnOWqF4a3HzRaVKeKWg1u7fv2FqtD+ViSeFO2MK+oIavbb
	JMQkdDYDITenLEirrRxFZ5fUfPVADhJC8a13B85XpA==
X-ME-Sender: <xms:3oXyZazrSh9hvLk-kbBvBK2DiGkMVgAs4bIlapjsoM2nb19TUBs7Lg>
    <xme:3oXyZWT8KFVkcMazCSKXFzMhKjHBRZAqfHjSaqKHKFrVLYmIXRsuzJ0TyU4EWFzzj
    RhabdVKekCSC_DBiMg>
X-ME-Received: <xmr:3oXyZcWmxXAFWsrFWv_adAJmDPETt8sqvukGS8BSpMYdM7dKZCcfwQthvpVXW25ngIPjXig350wX-lgGao7zIgdT8RrwfNWaSbYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrvghtvghr
    ucfjuhhtthgvrhgvrhcuoehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
    eqnecuggftrfgrthhtvghrnhepkedvkeegheefjefgvddufffhveehjeffvefgiefgkefh
    udeifedugfetudfgtefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvght
X-ME-Proxy: <xmx:3oXyZQhsfHDq6XcupqnfTaCZjMs_QKUFjVFn1UXRD4M188_uFrLcSw>
    <xmx:3oXyZcDzrHHLsyng7x5NxtlJ0M8WsBgYhf7pza6hjaZr8QEz5epXQg>
    <xmx:3oXyZRLliH9MMt4kkM1hRPv2_K1KpbxlHOtMdRNwtJ6jUUoumQY-kw>
    <xmx:3oXyZTBGTYYxpeYe0FBx1rKXrPczTtzwL88ZCB81PdSrVMgk2Pc0tw>
    <xmx:34XyZe2TOn0hHukcwfxRFQSMIGWyeY4L37dbQysPX0E78iKlXgEo-TQvfV0>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 01:06:36 -0400 (EDT)
Date: Thu, 14 Mar 2024 15:06:30 +1000
From: Peter Hutterer <peter.hutterer@who-t.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	David Heidelberg <david@ixit.cz>, Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] diff: add diff.srcPrefix and diff.dstPrefix
 configuration variables
Message-ID: <20240314050630.GA995444@quokka>
References: <20240312231559.GA116605@quokka>
 <f8565251-2af1-470b-9b2d-798e3504b0d1@gmail.com>
 <xmqqbk7if8vj.fsf@gitster.g>
 <9449a421-c6ea-427c-a600-73c6f99ccf0d@gmail.com>
 <xmqqcyryc8yh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcyryc8yh.fsf@gitster.g>

On Wed, Mar 13, 2024 at 10:55:50AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > mention that one as well or just say something like "This is designed
> > to be used to override the configuration variables `diff.*Prefix`.".
> 
> Excellent.
> 
> Thanks.  Peter, do you want to wrap things up with an updated patch
> (no rush and no obligation to do so---we just want to know if it
> will happen, in which case we will just wait, and otherwise somebody
> else will do that)?

Happy to send out another patch (tomorrow, assuming the discussion has
settled fully).

Cheers,
  Peter
