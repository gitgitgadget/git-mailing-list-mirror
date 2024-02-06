Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68D4745C3
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190383; cv=none; b=ovXtFDQBlI6AGSasbuhq+PziEOfcVk9KBHyZAm2xliKU/Gm6p8BcA1EO50+WxddP0RE7okn922WvEYwEvabynyvt0QmYJvvSEz3ZFHpBZqQd4FlbnuFSAEt8YbI9W7J/yoEWFNUjlRB3ZdHXW6OVisDrwhqQAthxPlpR5chM5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190383; c=relaxed/simple;
	bh=5w9YSljjE04ysouRI/TQAu5tcvN+csWMf+iySYP3BZ4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=dLUwIx4JW5Xjvf0jCFiUY1n3VqpkhlZpXxa2deSuupKBo+fKttFDqoNG+vq5TUxxH9duwrotCq03DteKAgur3z57HlfDw9wSdZpkc5TwTalpi2koF0Yk32rUyG/msJr72tSG/Tzj/ZqIEEBjd986T2Yseo1j13PvKIXLDN8iuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=w+6UB5qd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="w+6UB5qd"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707190378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kF8tqYLU+Djb4atfqvVXxD0le2qCCukoSa5N+S2vqv4=;
	b=w+6UB5qdlQtNwC+SraRxcX3zJrxVxNVW30oNMToygb0K1qxfC2POY+0I1CcKoRUXfLQzZt
	qv0wxoKKeTusnLcN7CYlvKbgboGWISh1ob8BPoFQXxLqCIFz8TaMBZC8Sq4BTT0/rHcQUy
	iH3NXEuPl/BNucejmmFOShd4PV9r/UwBhPdC4eJ4nZmK+UaFrWFkBljvViN+YiMeYaYFnX
	aAnUaR1HLyf9oGd4fkQXLnprsTBkc52Tfbuoe0jjRpQm7dkt6FLs2XcQIZn0jlUZd/5tYf
	J+5i/U8Z2UjtZImO9GhEsEMjxpBfz1IxR3pKgAhaU3ccmcb+Ifte4qei4NcmDg==
Date: Tue, 06 Feb 2024 04:32:57 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: clarify <oldbranch> and <newbranch> terms further
In-Reply-To: <xmqqttmmlahf.fsf@gitster.g>
References: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
 <CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
 <xmqqttmmlahf.fsf@gitster.g>
Message-ID: <8f588db87929b063462dbf4ff134adc7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-02-06 01:09, Junio C Hamano wrote:
> Kyle Lippincott <spectral@google.com> writes:
> 
>> I'm not super pleased with that second sentence, and maybe we
>> shouldn't include it here. Maybe it belongs on the documentation for
>> --move and --copy instead? It's sort of mentioned in the text at the
>> top describing the -m/-M and -c/-C options, though it's not clear from
>> that text what actually happens to the existing copy of <newbranch> if
>> one uses --force. If we could include a better description of what
>> happens to the existing branch when one uses --force, that'd be nice.
> 
> My preference is to limit the "OPTIONS" section to dashed options.
> If "--move" takes one or two arguments, update its description to
> talk about how these one or two arguments are used, perhaps like
> 
> 	-m [<oldbranch>] <newbranch>::
> 	--move [<oldbranch>] <newbranch>::
> 
> 		Rename an existing branch <oldbranch>, which
>                 defaults to the current branch, to <newbranch>.  The
>                 configuration variables about and the reflog of
>                 <oldbranch> are also renamed appropriately to be
>                 used with <newbranch>. It is an error if <newbranch>
>                 exists (you can use `--force` to clobber an existing
>                 <newbranch>).
> 
> or something like that.

Thank you for your detailed feedback!

I like it and I fully agree that describing the operation arguments
fits and flows much better in the descriptions of their respective
operations.  Describing the outcome of forced operations is also
needed for completeness, and for safety.

I'll prepare and send a v2 that takes that approach.

> Listing non-options in the list may have been a misguided attempt to
> "save" description on arguments that are common to multiple options,
> but it is not working.  We can see the bad effect of that approach
> only by looking at the current description of the above option,
> which reads:
> 
> 	-m::
> 	--move::
> 		Move/rename a branch, together with its config and reflog.
> 
> It does not mentioning what arguments "--move" takes, and does not
> even refer the readers to the entries for <newbranch> and
> <oldbranch>, so the only plausible way the users can learn what they
> want about this single option is by reading the page from top to
> bottom.

... or the users can perhaps learn by simply experimenting a bit
and observing what happens, after getting a bit disappointed by the
current descriptions of the operations and resorting to the rather
usual "tl;dr" approach.

Avoiding such "tl;dr" scenarios is the way to move forward with the
improvements to the git man pages, if you agree.

> And trim the DESCRIPTION part. A lot. Because things are explained
> redundantly between there and the OPTIONS part, and their details
> are waiting to drift apart unless we are careful.
> 
> I think I laid all this out and more in a separate message.
> 
> https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/

I agree about this as well, but that will perhaps be handled in some
separate patch for the git-branch(1) man page.
