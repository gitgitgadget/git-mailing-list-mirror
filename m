Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78633FB067
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167995; cv=none; b=D79ygaY0hq7/Cnqa8l1xgGUPjaNX05DdBKaAdYrRRR9RugVnZArBm9tgyaiPb7U23kKtYhkTta9L+HO8CsmvlCodY7oWzq4VsTcwFWhDJCh4ylIaAMJI17QSF0InWI1jzNhNF2fVvPw3wQPuxU8x9gt5WRyczeI1k/oVOmW31ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167995; c=relaxed/simple;
	bh=L0EfeTvqSB5B8zWD0/A0HLcGcO16dkHKyIq1ry9SQXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=phOdVHGe98yS8dn0EeqoElDpmurqeZ4HxrJ8IHkWbdRBJKw7Vx9gsMDpDDhmGR9+aooN4L+60m8n5ibGefIR+XTWabbtWbgfKU2z3EMx3S+F3uIIbJEGDWpMecRdR9rKmh1aMMk2aTqMJCeUxKPvxr4LINEUAFVXMJ+Cl4ZB05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NEgRTSpW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jn8JZ1W9; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NEgRTSpW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jn8JZ1W9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C48BCEC01A9;
	Mon, 27 Jul 2026 11:59:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 11:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785167991; x=1785254391; bh=gf5++nsuzm
	rJDhKn5fsd418oToCDgdPogCFE5LDF1pM=; b=NEgRTSpWxu6JROIsQ7IGNODh6N
	sq95DmdL+7yilc8Arats6TFvefRkD6ZZau/LW5hWD4KS67SVXivqpAYJSS09lS0c
	RbFvECpiT3AJ9sFmntfj+NG9YSKVei8TU5GUjbMi3pXz5Asm/h/fbBPRzk2r//5H
	hU50CS1I+0cLuIQo6VD0Er6tLCn98BfMYn2RnqsQIbBrFPGRG154JOUqoO+/T0fP
	xNGvvUgK3NQQzIe209f0uX5zExmmztHnvh9Vv41MuBIXjqk5Wzt2OllcXLgAIjph
	glCcj0yFhraOAW1mCg68b+65+Xnddcoe2Bwe5NDsbsgqNSY0PDzBcgrevAkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785167991; x=1785254391; bh=gf5++nsuzmrJDhKn5fsd418oToCDgdPogCF
	E5LDF1pM=; b=jn8JZ1W9SjyRNcn4ISoKYwj0yr10ITM7Mk52C9A4J+Zg0azBoj6
	EnOD9/US7MXRv7899GQVXa0BGE3I8FpRJJi/87qrftZxhZeYpvrYs5vAi39Ka64B
	8mnEfD0wr/PWnga+TcweLaBY4Tq0o4Cn3nKdVm8SfmG5tPPcM1Zt2cEP+53Z7AJG
	WWiNtuCT30GfbzLtEJEoM9OQkChEOp89Bf+ASsDTbHpJ5pTh3fw1CpPg4bGZNi0J
	dSRQDD9971svAASQjupYnDJ7NE6Gafyd8ttPXu3l/61Z4DHucWRtJE02d+pedDaH
	NCAuZxbbohdN9cuNMLrm4tH3y0cA6nNay/A==
X-ME-Sender: <xms:d4BnatbaulKVAT-aR_AD9z1hTmwjQPW4NrtoeB2qo_uvkoCjmZWE2w>
    <xme:d4BnaoGy5GJgyjyG-M8RYZAOaOww8wzN41xwnSAP2ZBPcuvryOQocKN7vLF2S7JMx
    eMjobCLswLKSpdI43a3qyIWkRnBfp7IRz17q-b2U__XFi0kRd4dLg>
X-ME-Received: <xmr:d4BnapxBb0mlAmXtJs0z1lU9POjuKFGGh_2tAzAjzNUKHXUeSxgoQh1Mo-5zPWah3Or3muD2MIRaEhMiNFjaU7-uU6PJE-VEtQ>
X-ME-Proxy-Cause: dmFkZTGLkIywjg4MxvKeKIQW2ejWEl1NOeMVq65a3ArKHPcFcb8wCuy7He8KVldrQKmETP
    cSXHP7UzfMk6lbl8xO77bCfnwqf5XTSp52qZ0hXKX0UKxLcdo8tkx8SCW3Hl1chb2x+ZqY
    b34mJkz5msRCHOl4dvNPiip+46VY2LnyKBPdmx0YrMMZnhgfdI3de4A+J2RpEzQSELuibh
    VuxbyGvMFtl+yhSdeq84QfnJNfzwjMSJhHC4flsypqZQ5NNuxYNaWB3ObSIQpG8wXZcsc6
    Hitiaf6X7uwC44GkVUBcTCRgJsD30tZ0/gn7I/iuE4gWvi2yFf3yDufOhqdCbX8dTOdpRh
    zAAP5EpMGYoR4WuY/GvGSXE/kWjt/06UgkbXtM1E2DSdKpLVUTUmPoCEYWlmPuOca/UOdW
    J8Q/Ao6eYQyJw6VCC8Fhr7JXpqgc+tY87CCg4HRbOv0oLjYeyZDqbGWOTnFqlF5agczmgQ
    yISe2oxoWJ6K2oaCt1+tQbjtpYGt7GrKJYdBv6571BeLvejfJqxlQq/cuagJgPsNjpWCCh
    JnEjA3QNLuWU0l8tShNRKSZ0N48yG63FYL4xrDEfySoz0Y+qBre/cyRj15THC9b0FWcWZ5
    d57ssrkbP8LX17pLatyIb9rSl2bSrZ/Z6Mu7m/2SwJz8lh4HXUwfzL7yigWQ
X-ME-Proxy: <xmx:d4BnaimHDuE4_KJHvYTwkbYuLhqu63LNolfC1ncfsuKOt8llYJhH5w>
    <xmx:d4Bnaqkx4G6hqJL0qbgGZJepd_Ike084yydNU1FLRHWRU1AohRXk7Q>
    <xmx:d4BnaswZD4cCivYVUd0fyWYF3KhYQdI9ON1cFJedwknFi8KlJD1VHg>
    <xmx:d4Bnanq6s9AWYGjsHtD9v6a1U4eRheF8ycCqgkG8r95xIvAnkbYq7w>
    <xmx:d4Bnao2dkoEJfGI2_nTNt8Z2W0WmJHT46wHKG5R47JacsYhmW7E7_j16>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 11:59:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Bryan B. Lima" <bblima@usp.br>, Patrick Steinhardt <ps@pks.im>
Cc:   git@vger.kernel.org,
  gustavoscorrea@usp.br,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] submodule absorbgitdirs tests: use test_* helper functions
In-Reply-To: <akTKHfKPsP3-Rn31@pks.im> (Patrick Steinhardt's message of "Wed,
	1 Jul 2026 10:04:45 +0200")
References: <20260630020220.1559190-1-bblima@usp.br>
	<xmqqmrwbsybn.fsf@gitster.g> <akTKHfKPsP3-Rn31@pks.im>
Date: Mon, 27 Jul 2026 08:59:49 -0700
Message-ID: <xmqqik60o22y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 30, 2026 at 11:00:28AM -0700, Junio C Hamano wrote:
>> "Bryan B. Lima" <bblima@usp.br> writes:
>> 
>> > Use modern helper functions from test-lib-functions.sh to provide nice error messages.
>> >
>> > Signed-off-by: Bryan B. Lima <bblima@usp.br>
>> > Co-authored-by: Gustavo S. Correa <gustavoscorrea@usp.br>
>> > Signed-off-by: Gustavo S. Correa <gustavoscorrea@usp.br>
>> > ---
>> >  t/t7412-submodule-absorbgitdirs.sh | 22 +++++++++++-----------
>> >  1 file changed, 11 insertions(+), 11 deletions(-)
>> 
>> Welcome to the Git development community.
>
> Welcome indeed!
>
>> It is rare, but it happens from time to time, that we see a patch by
>> somebody we haven't seen on this list, and the patch looks perfect.
>> Very delighted.
>
> Sorry to spoil it: the order of SOBs is incorrect. The patch is authored
> by Bryan, so that signoff needs to come last.
>
> The patch itself looks good though, thanks!


This discussion thread has been hanging for a while after we saw
this message.  To help a new participant, here are a few tips.

 * These discussions can be seen on mail archives.  On the primary
   archive, the message I am responding to appears here:

   https://lore.kernel.org/git/akTKHfKPsP3-Rn31@pks.im/

   For any discussion you are interested in, replace the URL path
   with the Message-Id of the message that is part of the
   discussion.  For example, after sending a patch, you use the
   message ID of the patch message you sent out and by visiting the
   page there, you see everything people said on your patch.

   https://lore.kernel.org/git/20260630020220.1559190-1-bblima@usp.br/

   Scroll down to see the "Thread overview".

 * When you receive a review response to help you polish your patch
   submission, you are expected to respond to it.  If the reviewer
   suggested an improvement, either you respond explaining why your
   original is better without the change suggested, or you respond
   thanking the reviewer for the suggestion and promise to submit an
   updated version that incorporates the suggested improvements, and
   then take your time to improve the patch and send a "reroll".
   For this patch, it would be numbered "v2".

   As we can see, neither option has occurred, and this discussion
   thread is keeping everybody waiting.

Thanks.
