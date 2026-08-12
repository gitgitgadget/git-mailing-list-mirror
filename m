Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD98441F349
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573908; cv=none; b=g1M7wySZ5K9jc9a/t5e8tEy62dF1wMPogCXj4NN+HxIMS935d8XPWqmrjHR8qqNW9w3DdZ0suFSm2+cKf1utiMRZLMHv5+1xyiU3mudQwt/PveL9gHyAL2XXmza0HWucQeIDLtrAMs0s2Kqs34/ziTgrxVG9lRJXShYqNYhg69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573908; c=relaxed/simple;
	bh=Zfkwe6O/jxogG7Iwx39ZXrWitYNjHtfUM5L3RBhA5YY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nrGe7YzrMdhxek2V5alG4SPA0BZ+K/V20AWjATKLyFa/pxSaES8jgqUrITtUCuC/YolhnP3Um6AkV2sB3To83TL+CoIu4vnOIQ/ATmTW5/DXw1j8cva7/o6QMmt4i+3ES+rxgHUfstUZ8iPC8SrpLOw639r/+qqVxyOCWQP74so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JtApoLB1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZM8Wo8DK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JtApoLB1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZM8Wo8DK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4639E7A004D;
	Wed, 12 Aug 2026 18:31:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 18:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786573903; x=1786660303; bh=4u52ZSO9sS
	3cSa3z0a8APaYXqFHpZkz+pWhM2RGX69I=; b=JtApoLB1KsOiRSV8DOF7KCjl3N
	DxB1NjjOLAVGyjAMBqDynXxkNarHnp7Sd6Dfxzx2fQMIK3Puq/QYg5JZeT6M2jJI
	7Ykb4r43lVZ/VDZhwY8Y0fOTwcKyoVUUWhP4zHBw/w9ZMQlR4cZwZlPRnGgbSe5L
	xDCQn/aMbahtjbNiWqIIrkChgmacDYmMIaGrAJMoST4ihV63epYo9yIzYl4d/ymg
	RdgW3AhvIVA8QYz2LKfgGqa0DPkITYJWETRO5qgRUESfaJubjLnSUaK9sSNAzH5E
	9pJZaWixtZKZGNVJgfsZvhp3jAbeufCAoj69qOCkHHswTepNagzmBhnr6vsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786573903; x=1786660303; bh=4u52ZSO9sS3cSa3z0a8APaYXqFHpZkz+pWh
	M2RGX69I=; b=ZM8Wo8DKbGTp/5DDh7nhrHw3WEP59sTNs6XhSC+TZOCqft0t8u8
	fHBLrTyqDEb0HZYZ0K+QTfga/vHaZ6ANbdhLKAZuedoH1bUXal/iXjlrY28Bjh+x
	lyEsH5XFs29ZHE/L+TgJnOfArInjmNu9qTiatEkXOb6XxVq7RJbwf+ern9JnIXY6
	LA+I8eWXndKBVokJtsSGtPEo/c4yaCkg7NybjRDMzRZ2h1PdH9gUtq5S0VSLTc8U
	Mq0+yvJIm56u44ImhqCo1ZHF+MWccHoFEM5bZms/+tRoNDCt4jUtC5Snd/mHZfhD
	08K/jKjL/3i6MTg9jFFBEo0LR4tFYGA8P5w==
X-ME-Sender: <xms:TvR8an1nNIOHP3TqiC6zZg8z1S9JZ1QbR96yETNVWdAeE4-PVJSlTQ>
    <xme:TvR8athVWHH3DEXmDnT072JcNni6GxGMLGpXXY4AsCjpUrDPyR4Hxe4tO85dPhxfb
    PggCppew1OZu6S5liz6RgmegbFQa_Cb4Wo1IO8QM64PbFg4p4kI7w>
X-ME-Received: <xmr:TvR8alSlWkd19-rvgA5BHEr857IEa81O4iZnMcYNpkaL98uMbZaHMt91tJYSOePrPAtDapxftZy9iqalj3z0z6pZmqSROzzfNQ>
X-ME-Proxy-Cause: dmFkZTEMWkzJauUFxsWydDoFx0Ogt3JMXeugQens522MAr9fXl8eLU0dU/iTtU4GEaj2D+
    H8SgOrGrmnCbw5RDDKZjiuCEqU//tl1gc+mVqw4x74fiaVObtuO0jOLKk9V/W5wpaw/jhB
    0P2lTvNzYzFzFb1e6yA+PuvUFf4JbuDAa2P+iSXRJMT/dZaHeortYRCYDWEt1SRPxN4DQ4
    49wja9IuX1D4sPzHxL5WMvfmzJAclJP83QxTZK31Z6qUIRugMNPKhD7NCPmuww5+KBojmE
    I1WRgXGNhlKyOZhb652QgITIzUZ7hrWy7kVFTiCrT56V2+4VLFQA+uXxm5CZ0ZlLU8LEYL
    zZCXxT5g2Yctn1/s+T5DbR9OYxR6rDqV7U2DlH28wa18U2s0zDl721fyJXebXHHOXAafaa
    C78mJEv+mHfdOKRydIGEVtS0UGoix0XOWof3MFRxO7wYI0wkSO7JTl/7wDFdlxg+nToBBm
    NtPuA7+Vnv4W8K+V6qQkMKZYEyHCWMfEv64S4VT5G5C3erQSsfiJyWtGXSEfw6fvrxLxkX
    HZjBJitDmp/5V6mBXD97AkCpN+moM0n55KlWGwix3gw0vCh9HH/snT9zw9j5YLDCEP0hMl
    cIDfeFjjVPkK0u7sZXyV91lzV35+KdbTQ1z1J5waj3Xuo2g0uAkASfPOB86g
X-ME-Proxy: <xmx:TvR8amhgXPxYYsA2fmWlrnZlD2NAUj3_RZAD4GQhGcfxnMNSGl7FFw>
    <xmx:TvR8at73M-xug1Q2uHc_l7H1vQ1aJ4ckWhhwP4PkpOPs4Uawp78hwg>
    <xmx:TvR8arB-C1JV5udekHjxMr21ECvX6V_12ZKucMRLRfwmI4uxll_vKQ>
    <xmx:TvR8asYayhqLuEmMe1m3krUGYLaPvmbNiqv0Hco-nNJJAVeDn4jCuw>
    <xmx:T_R8aoFvcYM4gDHIp9tPXyy1SYM1HcYVUrOHCqrYBOyZBWEcqdSOb7AA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 18:31:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: Can we do better than "git checkout/add -p"
In-Reply-To: <21db84ba-3894-23e9-9f17-ceeafb1990c2@gmx.de> (Johannes
	Schindelin's message of "Wed, 12 Aug 2026 10:40:08 +0200 (CEST)")
References: <xmqq8q6ih924.fsf@gitster.g>
	<21db84ba-3894-23e9-9f17-ceeafb1990c2@gmx.de>
Date: Wed, 12 Aug 2026 15:31:41 -0700
Message-ID: <xmqqse4jug1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> My current workaround is not to use "git checkout -p" and instead
>> (e)dit an undesirable hunk into a no-op hunk.  This is serviceable,
>> but with two caveats:
>> 
>>  - The underlying 'apply' machinery does not see a truly no-op,
>>    context-only hunk.  You'd need to pretend removing an existing
>>    line and adding the same line back.
>> 
>>  - (e)dit applies the edited hunk right away without giving the user
>>    a chance to proofread and approve or reedit.
>
> I, too, often find myself in exactly that kind of need. That's why I was
> *so* disappointed when
> https://lore.kernel.org/git/20260325075055.354709-1-luizedc1@gmail.com/
> was shot down unceremoniously. I still think that would be a good
> addition. I even opened https://github.com/gitgitgadget/git/issues/1828
> and sketched
> https://github.com/git/git/compare/master...dscho:git:add-p-stash-mode to
> the same extent.
>
> Maybe it is time to revisit that verdict, and see whether there is really
> no way to accept that clearly needed functionality.

I agree that functionality to cover the "classify three kinds of
changes in the working tree files, update both index and working
tree files" is a good thing to have.

I did not, and still do not, think "git add -p" is a good place to
add a feature to munge working tree files, though.

IOW, what I am lamenting is that we have add/checkout each having
"-p" options, and as separate commands, the user cannot handle three
kinds of changes in the working tree files without switching between
these two commands.

 - changes that we want to add to the index for the next commit
   (you tell [y] to add -p)
 - changes that we want to leave in the working tree files
   (you tell [n] to add -p)
 - changes that we want to get rid of from the working tree files
   (you tell [y] to checkout -p)

The ancient patch deserved to be discarded, simply because "if we
are adding it to 'add -p', what about 'checkout p'?" is a valid
question.

But the need to have a single command that can deal with the three
kinds without exiting does exist.  It might be beneficial to widen
our horizon to also consider if it would help us to include stash
into the mix.  It may give two choices to handle the second class of
changes, making them into four categories, i.e.

 - changes that we want to add to the index for the next commit
 - changes that we want to stash away from the working tree files
 - changes that we want to leave in the working tree files
 - changes that we want to get rid of from the working tree files

