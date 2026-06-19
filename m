Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489583932E6
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875234; cv=none; b=Yf9gJxQFoMD5LqhKJP9vOrFDh9KXz7LkgS94/Cbo6vP5YI4n9rL07jdioNdaaN37hpqgHeTuz3/W3/0z0Ub0awZnsl5DIVfjP1Hn21s7iZqlJpnQpm/BHOHy2+mNf4ZbjVkwzKK4/nicRFdP9w/N4yKcyYFQZAwgVlqY9z9OkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875234; c=relaxed/simple;
	bh=o3RVCS8H3P4cr60734Owv0iLxZeAxoh6RBgfP7i6f/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8MAefQyl7mbzwF+gK+WH4XWWC+EqkdAhG6h7vBqi6rY+xneT50oJtXk+owj/ArE79qTV6yt3goGmO9bAkmvGJyKHAQO3VN73uOCfjwoe1vCbO6jp7pQMjVS5/hBQpo+YCp5jOahCVlIUYUFT0ldf6ekZm5DzDnQusMyezOc+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=JbKHAtPT; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="JbKHAtPT"
Date: Fri, 19 Jun 2026 21:20:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781875230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRoF6nI3veYLtp689aysRnMH0BNUk0j84VdyFB2aWZU=;
	b=JbKHAtPT6QY4SnW7/KK/T7GKfPkDgXdMAJTwf0ardroi/hsbcgdQdwv6SUiqFK7fjg0bD8
	g/EdwRdOA69PEyyM0GdInNJDkTr1S9yeEP6itAIZTP8gNvgcWjEuGG2wsAc/x61q6rTTU1
	BRQ8dg8aXtU2iZwV5kGh6bzqsEpIurJSMypg/Vc60hJWUJXAs03Nl/CZvcDoJPg7xdnW/t
	VrgHHVkRkkhh4n8qI+JBhtlmghbHsq+Ws6obCH2nODKN7YWS2cxqTcE3YvKr9+hes8POX4
	IEP+OMrFU71yARLgqD9wGWT7tE4oLlIY9qvar7M27MMq2Jh52wUHv2qJEh00fQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 2/2] doc: advise batching patch rerolls
Message-ID: <ajVCD51lLvHreyJB@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
 <cover.1781714757.git.wy@wyuan.org>
 <496a08c74ddd9368587d032da7117520af1478ae.1781714757.git.wy@wyuan.org>
 <xmqq4ij1vywy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqq4ij1vywy.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

Sorry for the late reply. I spent some time looking back through the
discussions on earlier patch series, to check my patch itself, of course
because I'm apparently a newcomer here.

On Wed, Jun 17, 2026 at 10:50:53AM -0700, Junio C Hamano wrote:
> > If the comments require substantial rework, sending a new version
> > +sooner may save reviewers from spending time on a version you already know will
> > +change significantly.
> 
> I am not sure about this one.  Even though the intention to avoid
> wasting reviewers' time spent on reading through the previous
> version that will be invalidated is a good one, by definition, a
> substantial rework will naturally take time, and it is better not to
> rush and send an updated version with substantial changes that you
> yourself haven't had a chance to thoroughly review yet.
> 
> In such a case, it would be a better idea to respond to the review
> that made you realize a substantial rewrite is needed with a simple
> "I'll make a substantial rework based on this comment, which would
> invalidate this and that part of the current patch series, so please
> do not waste reviewer cycles on these parts until I send an updated
> series out" message.

I think the approach you recommended is obviously more reasonable.

It would be better to give everyone a heads-up "I am working on a
new version."

I will improve this part accordingly.

> > If the topic is close to being accepted and the remaining
> > +comments are small, a quicker new version may also be fine.
> 
> I am not sure if this needs to be codified.
> 
> I often see (e.g., in patches from Patrick) that an iteration is
> marked clearly as final candidate that the author is not aware of
> any outstanding issues.  This encourages reviewers to ask "what
> about this one raised there?"  to remind what is missed, or chime in
> with "yup, this looks good" to show support.  Such a note is highly
> recommended, but I do not see a need to say "the (supposedly) final
> one is specifically allowed to be sent without waiting" even then.

Actually I thought Patrick would say something here ;-) so I waited a
few more days to see whether anyone else had any suggestions.

But here I think Patrick's original intention is: If your series is
*close* to be accepted, (while I'm not sure what the precise definition
of this "close to be accepted", does it means: commented by Junio with
"Looks good", or reviewed by the community/core contributors with "Makes
sense"?) and this time there happens to be a small issue, you can
re-roll quickly to make your series more "sturdy" to wait for
maintainer's final examination and further merges.

So, I think the situation you are describing here is that this version
of the patch has already been declared by the *author* to be the final
version. (i.e. waiting for Junio to do the last exam)

Therefore, I do not think the two situations conflict with each other,
or are directly related. One concerns a patch that is already close to
receiving the maintainer's final verdict, where a minor issue is
discovered and the author quickly rerolls it. The other concerns an
author who, without realizing that some issues remain unresolved, rushes
to send what they believe to be the final version and then waits for the
maintainer to review it.

For the latter case, I think it would be better to add a sentence along
the lines of: "Before sending a new version/the final version, check
once more whether there are any unresolved issues," if the existing
documentation does not already make this clear.

That said, I am not familiar with how patch discussions have played out
in the past, so please directly point out any mistakes in my
understanding. I have to admit that, by this point in writing the
message, I have become a little tangled up in my own reasoning.

Thanks!
