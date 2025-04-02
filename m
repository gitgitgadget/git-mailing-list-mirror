Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D22AF14
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 19:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623117; cv=none; b=YkkMx7WXJrzPGqGml+wjEWclzxz9XNW+PM0MqYQKgABIQPvvG2617gtq1VWfH4twz/bqExF9z0+wmm35rQ4DTDf0fmL5TfMBsDrYLMhYpB96zk7jZp21l8Eir/ywsWBz3E2WFQxdjMLk6CaPItao/uCKT6Awd/KPWWIjFKEDalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623117; c=relaxed/simple;
	bh=NFXGxTehyzpyt88wFDQX+lFgOEAjnUwd0AlMG1tnuI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGxJpzkjBJ6I8KITi4xk1+7/FY56zgrHcGfUEXhUB/KDqNY6MVvHfrhsy704e46YZF7GH0SeamoiDdd+QW8qe94eicpViZvukwrxrhBpx4qbVcDUt2PqA0oQDC9G3HXsFEWabTvi5l287u9MW60Wu4tWdQ+SS+tij7HyRQHZNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LuExzhlS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LuExzhlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F46C4CEDD;
	Wed,  2 Apr 2025 19:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743623117;
	bh=NFXGxTehyzpyt88wFDQX+lFgOEAjnUwd0AlMG1tnuI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuExzhlSiM1u+YMTNSQc1LsPjQ87BvMvWQbt20padMwLJ5cs31vHdSrAFOS1Fz4DP
	 T8AWC1+qGIDihslNk+L2o4nZFIAyDNCJOuJkxsgmJl+SPuU2REym7Zpess6i7imHyE
	 QMZy0zJ2ULa+rKqnS/DiGMqAo3uQ20U+MFGLRKYc=
Date: Wed, 2 Apr 2025 15:45:15 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, remo@buenzli.dev, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
Message-ID: <20250402-adventurous-mustard-raccoon-ed93e3@meerkat>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>

On Wed, Apr 02, 2025 at 11:48:01AM -0700, Martin von Zweigbergk wrote:
> Hi,
> 
> The Gerrit, GitButler, and Jujutsu projects all have a concept of
> a "change id", and it behaves in a similar way between the three
> tools. The change id is conceptually associated with a commit.
> It follows a commit as its rewritten (e.g. by amending and
> rebasing). The three projects currently store and format the
> change id differently. We would like to unify that so we can
> interoperate better. We hope the Git project is also interested
> in preserving and using this header.

Notably, b4 also uses change-id, but as a series identifier, not as a commit
identifier. It is not intended to ever make its way into git commits and is
always passed in the patch footer.

The format is an arbitrary unique string. :)

-K
