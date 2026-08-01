Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0FD3B47CB
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785626082; cv=none; b=Eamx0flP62KtlGXXH4O7uD0BpWfuy5Xu9WRULkpqDOOI11rZOl8d//S4yN/CrP8tsOqVltED5ZupIqyYj/sPKPak/wjm9F5I/L9upZ8fLM1pqFevNnUUmvk3ayKt6Jz8AoJmF8fjx5W3BhOm0cluvon2Mf+rqLXw31weRcNfbnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785626082; c=relaxed/simple;
	bh=zVhWSYJJk+pWu+qJwOXF8YHUDMITaPdKWXk4cnJ94ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF+MH6+Cun2TBWaR+G/nWwz0e5u/z5GmFfngb8BV4MYKbqo5M/AEEJwYQkSJehOZRhgetDZCJmhff1+/JPjoXVAo7hZmacKXGwoqJSfuoMlnroed23TyKo/P+lSZbCZ8tgJKeXhDOePTZlPXpbC0XZOPhqtNr6dSOS+peS8aQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ejMp+8xD; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ejMp+8xD"
Received: (qmail 14469 invoked by uid 106); 1 Aug 2026 23:14:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zVhWSYJJk+pWu+qJwOXF8YHUDMITaPdKWXk4cnJ94ec=; b=ejMp+8xDHMsS3PKx3R3evXXvYrmPaP1Pt1bBzKfGbnAQ7Cq2/aJYhrTrEeUWee9JseJSnswdvgDM/PGLqfo4nUhQ0onBK4eVP6GdOIUGjCLNekCvlwLHneUv+xaBXXRXyPmgpfzJqDXsTo9OgY8T8+YkG5ux+ErbulgF2BJWFQS/EgPtym58Ylq/z6+50azpz+tdiZslPYMM1svtmGT5dlHMcjBlKVYmOqh+WRiTM/9seOXQefSOW8Y6oertJrZ4iwT4Leny2Um+Zx9FHoTVN0nqjXFMyQXaq218DbjbVpHXWDKKhzpGtcGvn9qppV9zWLL4r8CMc7VxOqPBKsqeVw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Aug 2026 23:14:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22413 invoked by uid 111); 1 Aug 2026 23:14:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Aug 2026 19:14:38 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 1 Aug 2026 19:14:37 -0400
From: Jeff King <peff@peff.net>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	chandrapratap3519@gmail.com, karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
Message-ID: <20260801231437.GA2097059@coredump.intra.peff.net>
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
 <20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
 <xmqq7bmaa0sw.fsf@gitster.g>
 <xmqqzez67yg1.fsf@gitster.g>
 <DKDYGQRTSF2W.25OU81K306HJN@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DKDYGQRTSF2W.25OU81K306HJN@gmail.com>

On Sun, Aug 02, 2026 at 12:20:28AM +0200, Pablo Sabater wrote:

> > We are probably using this pointer indirection to say "ah, '.typep'
> > is NULL so the caller did not ask for this information and the
> > object layer does not have to provide it", plus "'.typep' is NULL
> > so the engine did not give this information for the object".  But we
> > can do so with two bitfields
> >
> >     unsigned type_asked:1,
> >              type_valid:1;
> >
> > instead of paying ~24 bytes or more of heap allocation overhead.

Yes, this conditional loading is exactly how we use the pointers. I
agree that a bool would be smaller, though I doubt it really matters in
practice. You shouldn't have a large number of object_info structs. You
should have one that you use over and over. And it does not point to a
heap allocation, but usually to a stack variable in the caller.

I don't think you'd need type_valid (at least not as the object_info
code is written now). If you ask for it, then either the query is
satisfied, or we return an error.

I think the pointer system goes all the way back to 9a49059022
(sha1_object_info_extended(): expose a bit more info, 2011-05-12). It is
mostly just mirroring the pointers that would be passed directly to the
function (but marshalling them in a struct so callers don't have to pass
a zillion NULLs). So:

  read_object_info(oid, &size);

became:

  struct object_info query;
  query.sizep = &size;
  read_object_info(oid, &query);

One minor benefit the pointer system gets you is that the compiler can
more easily tell what has been loaded. Imagine that we had a type_asked
bool, but you forgot to set it. Now you look at oi.type, and it's
garbage (or maybe some sentinel value). But the compiler has no clue
without looking at the innards of the read_object_info() function.

Whereas with the pointers, you do this:

  enum object_type type;
  struct object_info oi = OBJECT_INFO_INIT;

  oi.typep = &type; /* what if we forget this? */

  read_object_info(oid, &oi);
  do_something(type);

If you forget the pointer assignment, the compiler will realize that
"type" never got passed to anybody and complain.

I don't know how valuable that is in practice, though.

Anyway, that is the history.

> This is related to what had to be done to fix a bug at "contents"
> commands a few days ago [1].
> 
> In that patch it had to save the previous state of typep and then
> restore it, because other commands like "info" and this series one
> "remote-object-info" use this pointer for the "is this asked?" question.

Yes, though you'd have the same thing with bools. You'd have to save
type_asked, set it, and then restore it.

> If we take a look at expand_atom():
> 
> 	...
> 	} else if (is_atom("objecttype", atom, len)) {
> 		if (data->mark_query) {
> 			data->info.typep = &data->type;
> 		} else {
> 			const char *t = type_name(data->type);
> 			strbuf_addstr(sb, t ? t : "");
> 		}
> 	...
> 
> expand_atom() has two responsibilities, it is called at the start to map
> which atoms are asked (when data->mark_query), and a second to expand
> those atoms.

Yep. But again, you'd have to set the bools somewhere. And it would be
here (in the mark_query half).

> For example, typep being non-NULL does this effect on these commands:
> 
> info: makes a type lookup, and fills type.
> 
> remote-object-info: typep is directly used to know whether a client has
>                     asked for %(objecttype).
> 
> For both commands what we pay is extra work because at the end the data
> shown is the one expanded from the format.

There should be no extra work. We do a single read_object_info() that
grabs all of the data and writes it into expand_data. If we are getting
data from elsewhere (say, a remote server) then we should not be using
object_info at all! The concrete data goes into expand_data, which is a
data structure specific to cat-file expansion.

-Peff
