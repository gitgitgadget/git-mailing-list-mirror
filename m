Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB8052F9B
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123104; cv=none; b=a0n59EPDdjwNcSL8/PmjQfO7Ge27pd/+i/p3tttElOZRxpSV2twdu3w+fPXTnOQZiOV5hCLl9PcmlfZ8PL6UxVn9mvu7hzTsX9qNb9YfsP0BP9uG7LFy+i2zVMpwPirVR06nbEvXfvFI1YdwQvad+hD0dTcpY51x8trI+vTmLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123104; c=relaxed/simple;
	bh=/YqyhEYLyeVwXef73cn9q00/UVvqpPN2xvwJAMPIUyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BfVmpQkE3WFA1Gg8ma+NDwp8K3JFDb3ySMh49+hFCSfWu7DjDSRZVd4pfL6ICiUbK5nmx1/DfZ4kewZlubNHVyOiogzIZhLR/cOdJRf7G2XPHTJxpfLZq5tYgMEnoLNJfhjWlkoNHmuFZtunXl7YQi0mmvX6o0fg5Ri1dU+h1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vXzL+Xht; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vXzL+Xht"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F1DCB19365;
	Fri, 22 Mar 2024 11:58:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/YqyhEYLyeVwXef73cn9q00/UVvqpPN2xvwJAM
	PIUyM=; b=vXzL+XhtyntHpOW+Diul8Lb50LxxwK7YSII0drbcVnL7YxQLdompET
	WBO2716z9OzxWwpNYZgmYSNBPbamoak2anNMfTg0lHM1YTq+OHHs7B0SvBMFPnQa
	0XNpKOGyKD3QPizkZS2WUJB1UssAH7aaD8wJkkEJ2nBPOiqeVILf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E84DC19364;
	Fri, 22 Mar 2024 11:58:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7813119363;
	Fri, 22 Mar 2024 11:58:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,  Matthew Rollings <admin@stealthcopter.com>,
  Stelian Pop <stelian@popies.net>,  git@vger.kernel.org
Subject: Re: [PATCH] contrib: drop hg-to-git script
In-Reply-To: <01de5e16-a4ee-47df-03e6-67f5f0d601a7@gmx.de> (Johannes
	Schindelin's message of "Fri, 22 Mar 2024 08:31:28 +0100 (CET)")
References: <20240320094824.GA2445978@coredump.intra.peff.net>
	<01de5e16-a4ee-47df-03e6-67f5f0d601a7@gmx.de>
Date: Fri, 22 Mar 2024 08:58:16 -0700
Message-ID: <xmqqjzlu2r8n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 000A897E-E865-11EE-A5E9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> While I have no objection to dropping this script, I am reluctant to drop
> it without leaving anything helpful in place. I am thinking about
> something like a `README.md` that would contain helpful information for
> any interested reader.

Years ago, I lost the illusion that our tree is the place for all
users who want to improve their Git experience to come and they try
to find related software in our contrib/ section.

Those with specific needs (e.g., "A project uses Mercuial; I want
its history in Git because I am used to it more") will never come to
our contrib/ as their first place to look, but they may still find
us in https://letmegooglethat.com/?q=mercurial+to+git if we left an
otherwise empty directory there.

Those with curiosity without specific needs (e.g., "what kind of
interesting enhancements around Git are there") are unlikely to come
to our contrib/ section either, as it offers too small a collection,
but more importantly, a directory with README and nothing else is
one more place they have to look at for no interesting information.
If we want to be really helpful to these folks, we need a curated
collection that is properly maintained.

While some directories under contrib/ may have been well maintained,
I do not think we have been good stewards for most directories in
there that do not have upstream author's involvement in maintaining
them.  If 6 months down the road a better alternative for cinnabar
or remote-hg appears, I doubt anybody will update such a README file
to add mention of it.  Even if it did, I highly doubt anybody will
come to our contrib/ area to find out about it---they will find out
about it elsewhere.

I am aware that we have precedence.  contrib/hooks/multimail and
contrib/emacs are two examples that lost almost everything but still
have tombstone README.  But these README are not kept up to date to
help their intended audiences.  The only people it _might_ help to
have such tombstone README are those who say "Oh, I thought we had
Hg to git in contrib/---what happened to it?" and they are better
served by "git log contrib/" that will find the commit that explains
why we decided to drop it back when we did.

>> The hg-to-git script is full of command injection vulnerabilities
>> against malicious branch and tag names. It's also old and largely
>> unmaintained; the last commit was over 4 years ago, and the last code
>> change before that was from 2013. Users are better off with a modern
>> remote-helper tool like cinnabar or remote-hg.

The approach will not give them any false expectation that the
"modern tool" are updated in the historical record to tell them
about better alternative that appeared after hg-to-git was removed,
unlike tombstone README that we _could_ be maintaining but without
any intention to do so.

So, I dunno.  I very much appreciate your desire to be helpful to
the users, but in this case the effort is misguided and not being
helping the users very much.  

If we were a major part of the sources for Git related information
and there were little external information, READMEs that are
somewhat stale were much much better than no READMEs at all.  But
such days are over a decade ago and having README that we plan to
let go stale has dubious value, I would have to say.
