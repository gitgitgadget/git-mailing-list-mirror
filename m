Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76C39BFEB
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177803; cv=none; b=oLs89fiI6/QkMAuIz1ciiQVuE4Xz4oPlzaoUI8e+nPWZv2NXkgs+ScjxBuyKJwBXDJXv7yxwpcY24XBCXXo8TbdGzLmsLO6MYN1cP2DgoUP78Z1CRgslGMEKiEsbgpdauma5MWW6gw+gQSRhrYHSIpdCG4wEMd116YAXEPvb7mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177803; c=relaxed/simple;
	bh=JPZukpFyTjBYvSeALEdjmf86c6VobuuoSpFHHC84gzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeJ0btJC0bh+UstaW7YEQnF6Wx7W1WcrUr84AM4m0LTDfwVSWp4hd9v2hv1ECvvnWbi/0X34vCjiaaFX/KJwI9ju/jVjL42jAaTdcJR3t0nhLzq8vEZ/bn0SziMLtou83TXGu84YvK9Mc8xhcqDMO3Ul0vsvy0b67Exm/b+xnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=Qd+P2pUg; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="Qd+P2pUg"
Date: Tue, 10 Mar 2026 22:23:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773177794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jkh1CAhPsTRS/mTyxFoYEp98D0ZRcVaUrBVOxIStsvI=;
	b=Qd+P2pUgM5QxtXdU/ovbxTrnTho1ByApcdkWnRBgjsWZB0AzWokLBq0aCnq0IMNrgQ+Gr7
	3fVThTN6oZD5ynOEafqMeR6qTc4ocX+GiqMlwf4lYLv+qifBizDbp1X8jvYdeYeN7L4elB
	jU36SDMbxeTlIWIiuOPz/BbkqpPwV3yJUMiWWH3Vp+tf671CtjW16/QhTt3Awg4ea2B/DY
	O3bNEv2HlosZaj8i9lFPJttLV8fJOHjGgHClF8hyHocc4FBHQeh2+opZfEhNBAjsgsBXEr
	QPz29W3Bth3SrKZzKMlYy81XpLYX897klW0hPzb3Nix+dDEY5ACKdM3wMCUTcQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
Message-ID: <abCLFS3QP7rJHueq@exploit>
References: <cover.1772837832.git.mroik@delayed.space>
 <cover.1772839973.git.mroik@delayed.space>
 <c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
 <6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com>
 <xmqqikb3ws3e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikb3ws3e.fsf@gitster.g>
X-Spamd-Bar: -

On Tue, Mar 10, 2026 at 09:45:57AM -0700, Junio C Hamano wrote:
> That syntax is the same as setting config.key=true; disabling the
> feature triggered by config.key is quite counter-intuitive, isn't
> it?
> 
> We are by default using "shortlog", but use of this configuration
> variable is a sign that the user wants to use a more modern custom
> format that is not the traditional "shortlog".  It would be quite
> natural to invoke the modern default by setting it to "true" (i.e.,
> "I want to enable the new format.commitlistformat feature, but I am
> not saying which format, and the "log:[%(count)/%(total)] %s" format
> is used).
> 
> Perhaps "format.commitlistformat = false" should disable the modern
> format and fall back to "shortlog", setting it to true (including
> the use of "valueless true" syntax) should enable it and use the
> modern default "log:[%c/%t] %s" format, and non-bool text should be
> used as a custom specification ("shortlog", or "log:<format>")?
> 
> I.e.
> 
> 	switch (git_parse_maybe_bool_text(value)) {
>         case 0: /* false */
> 		fmt_cover_letter_commit_list = "shortlog";
> 		break;
> 	case 1: /* true - use the modern default format */
> 		fmt_cover_letter_commit_list = "log:[%c/%t] %s";
> 		break;		
> 	default:
> 		fmt_cover_letter_commit_list = value;
> 		break;
> 	}
> 
> Hmm?

Mmh, what if instead we defined a prefix format just like shortlog?
Maybe call it something like "numbered" or something similar (not too
good with coming up with names).

I dislike the idea of having an option be multiple types. Should bool or
string, not both.
