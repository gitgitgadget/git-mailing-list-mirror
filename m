Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20150263
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790012; cv=none; b=cQL0tAFWuayKiTtWoQY+gml09RH66Hy1pw3bNNlhnlpcaRv9lB2Rjg03lsXJ7UjmFTup9WGZye6HKFSDmNvk4GECVNeCQYvZBGUA59OWdUeX7WwAallK66AwfGj1sqeYyj7/3bPPk3suZwYShR1uReO/K6oosKoqNLSWxGXR1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790012; c=relaxed/simple;
	bh=jRYYdQGY/5K2JUw0oZA+o81VLfist4+XePn7XNr3KQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv06ehohp7eZA9rmoXmAOuob/9GtruTzzJD/Qt/KL3BXkVbnI6b1GgzU0lU4StFCvZeEPgIg4Mrz5sLoXbKd5N6Kgl0Xe68vCGQtV7nxW6yerPHwGmQqXkd6eJxp4C7Di2CmZ5iwlVr1o9Qj6tvBYnuwRJ4bbKFBcQ+WgFQp2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1it4Xfp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1it4Xfp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DDBC2BBFC;
	Fri,  7 Jun 2024 19:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717790012;
	bh=jRYYdQGY/5K2JUw0oZA+o81VLfist4+XePn7XNr3KQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1it4Xfp0H1yUPkZpJvSfkXTwiIK93l/voAeULTEqMPXF2al/BlOMvuGWzR3hmY+aU
	 mbCbRENgQqsI9XTclRz+87D8NM/JEKT9UTd905QwKPLqYy3XVYf5uY/8+4WmO/OE1j
	 qfbpaDZz3iSlVXSxjzRdkv4OK1MSj3B3ZGzjeats=
Date: Fri, 7 Jun 2024 15:53:31 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Eric Wong <e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: RFC: indicating diff strategy in format-patch message headers
Message-ID: <20240607-ultra-unicorn-of-democracy-d25a69@lemur>
References: <20240605-hilarious-dramatic-mushroom-7fd941@lemur>
 <xmqq5xuns10v.fsf@gitster.g>
 <20240605-zippy-wildcat-of-recreation-8c644e@lemur>
 <20240605222658.M32384@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240605222658.M32384@dcvr>

On Wed, Jun 05, 2024 at 10:26:58PM GMT, Eric Wong wrote:
> > That would be redundant with the message-id. Unfortunately, this doesn't solve
> > the problem of how to reliably map a commit to the patch from which it
> > originated, other than using the Message-ID: or Link: trailers.
> 
> dfpre:, dfblob:, dfpost: search queries on lore seem to work...

I've thought about that, but this is also not very reliable, at least not when
patch series are applied as fast-forwards, not merges. Unfortunately, some
projects enforce a flat history (glibc, gcc), with merges being specifically
not allowed -- which means dfblob matching is not going to match a lot of
commits.

> On my lore + gko mirror, the #related search off a commit mostly
> works for a single extindex, but mapping hundreds of forks to
> hundreds of inboxes with a presentable UI for w3m||lynx users is
> a different matter I haven't been able to solve:
> 
> https://yhbt.net/lore/pub/scm/git/git.git/6549c41e/s/#related
> 
> > I'm not sure if there's a reliable way to solve this.
> 
> I started working on a scoring mechanism a while back but got
> distracted with personal matters.  UI is hard, and dealing with
> my gko mirror has been a source of pain due to various
> memory+performance problems.

I can totally relate to the pain of memory+performance problems. :) Especially
when a ton of "AI" bots decide to aggressively crawl your sites. :/

-K
