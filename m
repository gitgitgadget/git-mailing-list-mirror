Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642827CB02
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986760; cv=none; b=slSizxkwJB7yvNSqT26cGfVvJlIY9OlxMUkLORD6ExPR05enuy3NBnaIEB5Y0D6lK92UoXEhkrEC/KAKZWfvH6K83vlrxy9mMf/sfsDGmhC8qe085kLCY+bg5QCD7Yavb4J/Pswha60GTOjuYgmbRSIXRI/TEj2y/VjpXMzk5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986760; c=relaxed/simple;
	bh=D9odIyeYY39MafBZhsDyRMT2BfVh9cSJe7oV6lzfTJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nws4C3K6HUgm5N2+Di5rET6Glwm+AMe7K7f5nZ3W8T5ejc34SK2W+KUyrld119KUFJIxQY2T5n4051er/YFmxp5FkwdlggePS5boBbCGpMDkh5V48N1SAZ1eQppxgeM1Uak9zdeVvISg8R0mBS77f40h8rKaWrp4LpE44g6W/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ty6feN+M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XATt4m4P; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ty6feN+M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XATt4m4P"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 82AEFEC01AD;
	Fri, 20 Mar 2026 02:05:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 02:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773986758; x=1774073158; bh=W7PCk/qkTT
	uQF/eW2TJOlvcU5i+ffyrxUIr50LNreFo=; b=Ty6feN+Me9CrycjHgSnS7G2P5m
	9HaAiPB3MUI5QKmddlCe2gpVetK+4oYo6TRGIZTkrx3AA7+48OBJ87bmjzw6GEeY
	Vx7Ln28jC0BsqZQiO2lrWtcPNuZwpLg1xqIXOZsB2COrDYqmP/0AMnq1gNXLr+BW
	l57yVMYR47oK+jQxIsOImPB23KRsatQNOoPgvQ3ECwx0sEs/cFExs3O3mkAt7iOZ
	b8WkjklXku929cQ6Lm0zGYGCvJkm6iGs1sDhdwhK7sxzEFfI1OQzFxC7d56gN4DU
	ShdLn2sdwbcfN6zL/fYIKzsdOHJtVDOHP02jAuY/aS38RQowC93rdvEXmcUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773986758; x=1774073158; bh=W7PCk/qkTTuQF/eW2TJOlvcU5i+ffyrxUIr
	50LNreFo=; b=XATt4m4P9DZHsZmOX5A9Yxas82qw/hzEo+dk+bS4SU7gK8G7NcT
	JIMVagaSkQYSt8/4J70/IU7hdMdlaOzO9ebSSzt1GSo5Gevt7ruh6oB01ZQkSh8O
	3QxXFQsC71i3I41AeHpZMjqY7x3P6OeY8yBFE9YX9jAnAkqptVWfgx3w46woTTEd
	M5PgmuWeOHXIQfInEoqVz/W50hPEldoGa23YGc82QjLbCdtNWJf8HmYX+XV3WuMb
	xl+/B47JfcGmrEY5P4ZIjZHYKGqbzC6ACuRHcXnOz0D0oUNx3/MEtvq/DSXEfCe4
	VcAzItd5E/SvMJkn1PE1pxBVyORQ6PguweQ==
X-ME-Sender: <xms:xuO8aQwf2qoKB_3JxJZRa18KihW4_tKAfy77GI4K2zkt4Vs3WoRq2g>
    <xme:xuO8aSEO9JYJ9foJQk8XPq0NmA0bTYD-muXOsgkT2n1eLe4piRBmoBbh9qhFoemp0
    77Dw-5oyZrwqeiT-dZZlWVxXBNkHl6DDMy1STkdpRs_0tFLznxCpg>
X-ME-Received: <xmr:xuO8aczfSNwylOpTvMoGucih4s9QN_ap_12mUxBsF3AZ7GhTt0DaMrQiWPb10swhn2P1ZxNQglKIxqcnFmzFiRaVt5mZkjrTDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:xuO8abvfvsocNM-qza-_wxyvaynItOKhAMRtT9AfrXoCieETpSdjKA>
    <xmx:xuO8aR1YlsJTcXMPmdFj7D5cxjEv5Wc4PbumyBv46NZht12rs6Pm7g>
    <xmx:xuO8ae94FmmbSAOLl9bLj7J1vvrG8pPEiPLWav5CytBZUc19RGs8tA>
    <xmx:xuO8aaPKnlDPByLoYR6ExKQdi80c-xStm4NFgxHkDdkH4AlGaDVb2Q>
    <xmx:xuO8aduM7sBoH1Qf0XE50kvd4_Rle0Kci1Pr8iJ6qLDeM-SvAFaXxET4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 02:05:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Subject: [PATCH] object-file: fix sparse 'plain integer as NULL
 pointer' error
In-Reply-To: <b2656d8c-7878-489e-a78b-ecb441570bf6@ramsayjones.plus.com>
	(Ramsay Jones's message of "Fri, 20 Mar 2026 02:04:34 +0000")
References: <97c623fe-4e03-4fbe-a6af-9c01c101bae4@ramsayjones.plus.com>
	<xmqqqzpfgu5s.fsf@gitster.g>
	<b2656d8c-7878-489e-a78b-ecb441570bf6@ramsayjones.plus.com>
Date: Thu, 19 Mar 2026 23:05:56 -0700
Message-ID: <xmqqy0jnf323.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 20/03/2026 1:35 am, Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>> 
>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>> ---
>>>
>>> Hi Patrick,
>>>
>>> When you next re-roll your 'ps/object-counting' branch, could you please squash this
>>> into the patch equivalent to the commit 2b24db1110 ("object-file: generalize counting
>>> objects",2026-03-12) in tonight's 'seen' branch.
>> 
>> The topic being in 'next' since March 17th, that is a bit awkward to
>> arrange.  I can queue the fix on top instead.
>
> Hmm, odd. I didn't do a 'branch --contains', obviously, but this only started tonight
> (and I built git yesterday - master, next and seen), so I just assumed ... ;)
>
> Sorry about that.

FWIW, my local build & test did not catch this until today, only
because the version of sparse I was running was a tad old.  After
updating it today, I started seeing the breakage there.

