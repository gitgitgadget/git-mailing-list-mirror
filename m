Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4567338593
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255766; cv=none; b=Y2FKY8yDmaBN71AmcWOqM5V51JlpwP+MtK6u0VCqm55MlxiebKxBv1WkAS1HDNHHeyyJRKeG5oDxP7CWgaR+hHZJwnfYANeWuAMAuL+zZ+Tc70D3mNUVtW+ONIC3mP7fInjQ88BNHfgVPhC6x9Dxzds+cu8G5EaOZwPIMkHR/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255766; c=relaxed/simple;
	bh=GxDtKsqQ7lAPVD4nGuVwVp+21mExUfNe4TcivZRXvuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JIQRLzC9bFlclZgaEMdCTmVjinWKbvnjHW9k/bbikA1IyOpR7x4ibYH18tFD0FcXBdk44Z7TY8sgKjzmgkdJngBVio72zQmK3FPUaG0DlYczB8ktTqpkpY16VBMRo3p1e7JMvjNUwBmmUuhBcgoeOxUoM8LtTcmBIONz50vpql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WTSmAbJU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n1DEAPjG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WTSmAbJU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1DEAPjG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C9E8EEC0384;
	Tue, 28 Jul 2026 12:22:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jul 2026 12:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785255763; x=1785342163; bh=OGvQDzSa8M
	bMOAhE3iwYWimYjihYHY/f9E8O2kNY1Zc=; b=WTSmAbJU4UxV9+2KrLSmQxESDU
	uKKThqkfCg8hqP7W0prpHnvOsGmj8an6Rm04n0ZmXbHL7tj1OiokyiVGDCZAN/Ic
	MY1wFWfSArWwn9Kv5QcliwfGw4+eP8gx8A29cwJUuZDeaUctgAcEv2Fn2ZO5MXYB
	39QhZD9pKhVhv2FUSvI8emWmhvmRR6Dpya5RxrNmRB+7N0dPvfMvJbROhR1m/Gy3
	cULFs+rp7SR+X+hEKjHlA6c3rRLtoYlw50Q2NdlwzMmiCsc+vT2pMDWIVCxyXv/P
	AmU4tVRjYJhDd6Spoa/ZTOTp9TmcuUWSDEJAG68qH4bEHascJ3uWW1pqeNjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785255763; x=1785342163; bh=OGvQDzSa8MbMOAhE3iwYWimYjihYHY/f9E8
	O2kNY1Zc=; b=n1DEAPjGPgW0u0lB6VoN3d7J1TiwE9YFDQuf1xXLxUD0imnrFi1
	vn9OitbNRX90pQ1fhWJyJC4moWBladpsmogt2yeHDgeQqPfChlM85rXGmv2691Tk
	dJAi8+pQZozqK7fnFWjvJb9CiR8Wrj+C6PN7H1jN3YFwshXwl4cqhZrzDNTcDLsj
	E2bTwVaj84EJtrJe3rweCd01iCspA/RaYveQcMbMLSCn8hSzrJrkGq3yMFpCRtJX
	rTjoipGLMape9aWEw57CcEUhqCllK44jtBvH1NR1VYbVCv55sZ6A8u2T9fCHZbIs
	aisEPyiFisc/Uc7aqXjwmTSi953px6g3CGA==
X-ME-Sender: <xms:U9doaqrCovp6A26PjwHBzdNT6ff5tLLq3OzuvWtQ7hISBYdteL1GOQ>
    <xme:U9doagGWu4R8mEfFtimUhL5cT1A6D6rRzQ5cvTo0SeHDQEsR_TvTyG2zwqWv1RYJi
    ftca3W_dch_joA_V4szbLwK1qNf-NZwKSWh-gx6dWBuZRqRBryOIg>
X-ME-Received: <xmr:U9doasnMDWg8U7VkEhH3n9xTWI-bTNcx_tOSb_oPPaDUwsQ2AXkKHIxlg1gBNiCmMQVMximK3tO88GtoFIEvQwv76b1lYxC9mw>
X-ME-Proxy-Cause: dmFkZTGRQbVQF1HeCMhiCcwS6PbEIveeBs20FYaps7bYK1cktszEHxL5je1P4kA+crdGJB
    ZQrh6d4aRXWIfnJxAMGoDUwJ0iQJPpbMlefZxBaGDVtdRQ5S0ce+gTQqITfERRawNX5Zh+
    Lueohyg78W8AQ1LrQRuVEljVv2YSy2U/v6E6r5qUNAeI0vKwgl1BcsAo1XzXvdwti0/aNc
    +WoFPo55vH260Rh4BxQHSvbMrAqNyPNGHcqCLIKrULj/ziy+BiHRFOf/WFdzqguxl6LWBF
    mDzzvR39fTvtPRkGK7WMbjCa0wI6hOttDEw5KtYU9qyEhCY/t3FaHCLDYcRdhyt9aJ+8hZ
    KLgGiZOZDsKjm4PTwDjv/kJsPtFbmA6W49i2lfdWeg3RwKpWGGUaTYJ4V44aPW9eOCB0eM
    RvcOKISHPXHJOxRk3kEdBBsQUAosKLOg2ILDeVoRogQxeOnkQo1BgWNPOXIt2AXadBikSZ
    NwHkXnUaCZQs/fIQ/gWX1CkEZYwWU76BnD0gKyBMEQgVfSgDpem5T4BsLv4o3hJt9dHNv/
    roZRNHXAZApVlF99J5JNQJUS55ZSJ+9LzmF8x7ya20bFW3MChOBf/v1l+RLWWhaA5ubq2O
    bJggZ96PcLLJDy+myunFuW6yV+FRjXEnFZZ2OV3ldIZdpRVjHNGN1FwSHZSw
X-ME-Proxy: <xmx:U9doajlL87O0bT6ySU1PbdOvp97f21LH41XfVtvVX9SkWO4kVQfBvA>
    <xmx:U9doatu4GWWmM8NNT2KStH9IJSyVIYAFZbMVYi7f4oaWrrVWD4Tzhg>
    <xmx:U9doamn4fYad_PQHQWG0rdjdil7srEb2YZRcv9lXqwMumMADrabFFQ>
    <xmx:U9doaoskcO0uKT5nv_q1GftxKtllb2WjKhvclTp16Q0DRns3r7c2sQ>
    <xmx:U9doau3ZItvINymASGAtzd3hurw32RNr51u7AgMbkEaeEijDEoj-0SqR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 12:22:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff-lib: add idx/tree sanity check to oneway_diff
In-Reply-To: <20260728151458.GB41931@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jul 2026 11:14:58 -0400")
References: <20260726084550.GC2366012@coredump.intra.peff.net>
	<20260726084705.GB3529698@coredump.intra.peff.net>
	<20260727093912.GA591426@coredump.intra.peff.net>
	<xmqq4ihkgd06.fsf@gitster.g>
	<20260728151458.GB41931@coredump.intra.peff.net>
Date: Tue, 28 Jul 2026 09:22:42 -0700
Message-ID: <xmqqo6frdqy5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> We could help humans that the BUG is not expected to fire and only
>> to help static analysis by a crafted message, perhaps?
>> 
>>    if (!idx && !tree)
>>  	BUG("Hey, Coverity, this does not happen");
>
> If we are helping humans we can probably afford to be a little more
> eloquent. ;)

I do not mind eloquence but does the comment clearly say this is
primarily for unconfusing static analyzers?  My first reaction to
the message was "OK, you explained very well why this condition
would never happen, but then why do you need to check and BUG() on
it???"

But I guess the point is a future modification may invalidate this,
in which case I agree with the comment.  If it is hard for static
analysers to get it right, it probably is equally difficult to grok
for AI agents many people seem to be using to draft their changes
these days ;-).

> +	/*
> +	 * We should only see a NULL idx when the entry was present in the tree
> +	 * but deleted in the idx. In which case it should be impossible
> +	 * that a NULL tree was passed in (there would have been no entry at
> +	 * all) or that we got a df conflict above (you need a directory and a
> +	 * file to get such a conflict, which implies both sides are present).
> +	 */
> +	if (!idx && !tree)
> +		BUG("oneway_diff with neither idx nor tree");
> +
>  	if (revs->diffopt.prefix &&
>  	    strncmp((idx ? idx : tree)->name, revs->diffopt.prefix,
>  		    revs->diffopt.prefix_length))
