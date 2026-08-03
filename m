Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D6B411FBB
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770430; cv=none; b=NsxAXJTUmBHUMdlF31Z7j2g8FbMhzWmOhh+ZkJ+E1HPLwxD4jpK3+ShmWC7h1gSiBMb6jAlvYOsdMru6rIH0pXuJVcbN6ax1XTZnOcYL682NipgK7PBfPXgide2zCpdbNhUmcHCZnKJFoJmM6AoNWPFgkF8C9KT7lPvNZJNGp7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770430; c=relaxed/simple;
	bh=nORE2QiRtAXHvd7cKmA7FJjAcEm/5F+4jIT+apcItDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F466zjnYGIPYLch28rAv51893csoRbMTf74N7dww9Lh5VT+RTqgarF6FD8fXVY2Kf8ScX8D/O9YBCzurCuYwevwqZKB8DVJAOnQNf4Ufrcc3wHaamHM21gMy45g0rLBEEQqpvhzVmPZ9oTMvyDhIVtkdkql1fBJdKS5RvoF9r9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QZ69w2hQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QZ69w2hQ"
Received: (qmail 34794 invoked by uid 106); 3 Aug 2026 15:20:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=nORE2QiRtAXHvd7cKmA7FJjAcEm/5F+4jIT+apcItDs=; b=QZ69w2hQASBZ6NFdDjFDL/It8SX+YZ7yWiZdM/oggtkcs3XujzKOnN7v12KD3T06f5cl57/jf6qlcxHLW0NxJn5FMVlkemoZRbSPhSsEJ5b7lKry6XoNtyPNlhIKBzjToo0UO5tuRKMAU0vKRgTE6rpGvzApL+lOSrpR+u+HB5HR97Ayi7JrMdaNPerJJ/ygDvRxDctjDWQHI9BfFK5BkBLhU92bF5ViMRfTBaaWwrp0gCXXe7hRhZ9MIhn/y4z/eXNXPmqkfko3CalH2JZbQIOaUtco4HyWHOqyg3EqwpHsOjExOZQRM8bYcnvtkiw3F0lSlXs3zTSW4mtPqQXJGw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Aug 2026 15:20:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 45466 invoked by uid 111); 3 Aug 2026 15:20:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Aug 2026 11:20:26 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 3 Aug 2026 11:20:25 -0400
From: Jeff King <peff@peff.net>
To: kristofferhaugsbakk@fastmail.com
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
Message-ID: <20260803152025.GA189075@coredump.intra.peff.net>
References: <20260609004340.GF358144@coredump.intra.peff.net>
 <URLs_not_trailers.b13@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <URLs_not_trailers.b13@msgid.xyz>

On Sun, Aug 02, 2026 at 09:57:17PM +0200, kristofferhaugsbakk@fastmail.com wrote:

> There are commits which contain intended non-trailer lines which start
> with URLs. These are comments. Example with just the trailers:[2]
> 
>     Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>     [bhelgaas: squash fixes:
>     https://lore.kernel.org/r/20260108013956.14351-2-bagasdotme@gmail.com
>     https://lore.kernel.org/r/20260108013956.14351-3-bagasdotme@gmail.com]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>     Link: https://patch.msgid.link/20251210132907.58799-4-xueshuai@linux.alibaba.com
> 
> Those `[]` pairs delimit the “squash fixes” comment.

This example makes me wonder if we ought to be smarter about brackets.
I.e., could/should we realize that the opening bracket is a comment and
then ignore everything up to the closing one? That would help this case
and other weird cases like:

  Signed-off-by: whomever
  [peff: there's a really interesting thing going on
  here: the comment is free-form text that happens to
  use a colon in a sentence, but we'll interpret it
  as a trailer with key "here"]
  Signed-off-by: another unlucky soul

That said, I think there are cases without brackets that are also
confusing. Like:

  Let me finish this commit message by telling you all about this
  amazing url:

  https://example.com

So I don't think that is a counter-argument against this URL
false-positive check, but just a possible direction for future
exploration.

> Another example is linewrapping mistakes; a `Link` trailer with a
> URL where the URL ended up on the next line, presumably because the
> user’s editor linewrapped the “too long” line. Example with just the
> trailers:[3]
> 
>     Link: https://patch.msgid.link/20260216-work-xattr-socket-v1-4-c2efa4f74cb7@kernel.org
>     Link:
>     https://lore.kernel.org/3cnmtqmakpbb2uwhenrj7kdqu3uefykiykjllgfbtpkiwhaa4s@sghkevv7jned [1]
>     Acked-by: Darrick J. Wong <djwong@kernel.org>
>     Reviewed-by: Jan Kara <jack@suse.cz>
>     Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Now, this intended trailer is already ruined, but interpreting the URL
> as a standalone trailer only compounds the mistake.

Yeah, this is another interesting example. I agree it is fundamentally
broken, but showing the "https" trailer is just making it worse.

> diff --git a/trailer.c b/trailer.c
> index 6d8ec7fa8d8..971ae459596 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -635,8 +635,13 @@ static ssize_t find_separator(const char *line, const char *separators)
>  	int whitespace_found = 0;
>  	const char *c;
>  	for (c = line; *c; c++) {
> -		if (strchr(separators, *c))
> +		if (strchr(separators, *c)) {
> +			/* avoid accidental URL matches (://) */
> +			if (*c == ':' && c[1] == '/' && c[2] == '/' &&
> +			    !whitespace_found)
> +				return -1;
>  			return c - line;
> +		}

As discussed elsewhere, we are free to match with short-circuiting
because of the NUL termination. But that also means we could write this
as:

  if (starts_with(c, "://") && !whitespace_found)

which is perhaps a little more readable.

-Peff
