Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2884FC6
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813405; cv=none; b=ZQrCTlkYY9ThHYq9MPR8U48s67w+kAxkOAMbdQVSy5sdvQJt9YbO5bZXJQCu2pjHSe0SAiscSGJXVo1J9xfdOWjHqLEYq1lvMjXKqHcIZSo4gnuakZ5XoTIDob9X+xZ5SfKpn5vSrTGXeFQAGdakiigT7l/FtK01PYLwOaSG5sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813405; c=relaxed/simple;
	bh=urU/2KIuq/Tal71zUG3c+Mh+AOE4g72uMfQbe7QegrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTsJAKnJ25mJVGsrXrmM0VroPipMTkq+y+bLAXotigumDYohjYyvuklMl/wNXPV5oFZPomPETOltynRL6j0KLdITs59iQrBCd2uWAMGlF5YHRjTjXDfHMpW+9cGenwFIZyP0f+sdZNGblw1jIgTh5+2yDIbv32/hg3INFyhkLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iyrXaHpa; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iyrXaHpa"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 71BB63BE1E;
	Thu,  1 Feb 2024 13:50:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=urU/2KIuq/Tal71zUG3c+Mh+AOE4g72uMfQbe7
	QegrU=; b=iyrXaHpa583+3jlxtIIS7M54x1TGPNvdS9zYxjI277asCsn5vLUzQ4
	L8XM8erZd0xkrADJXxc7M91RWVX1uMnyhhqn/JSPwExla+mV1h4u/MxzTnzxNqBl
	JMQJiRwOkWu8WaB/zlkFx1n1uhuX+bMOmG6Z3OwMJOfqh85h5uCqg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6ADCB3BE1D;
	Thu,  1 Feb 2024 13:50:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 88E8B3BE19;
	Thu,  1 Feb 2024 13:49:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>,  Emily
 Shaffer <nasamuffin@google.com>,  Josh Steadmon <steadmon@google.com>,
  "Randall S. Becker" <rsbecker@nexbridge.com>,  Linus Arver
 <linusa@google.com>
Subject: Re: [PATCH v3 05/10] trailer: make trailer_info struct private
In-Reply-To: <c19c1dcc592186d8da2857692f4ebbfe35adfac0.1706664145.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 31 Jan 2024 01:22:19
	+0000")
References: <pull.1632.v2.git.1706308737.gitgitgadget@gmail.com>
	<pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<c19c1dcc592186d8da2857692f4ebbfe35adfac0.1706664145.git.gitgitgadget@gmail.com>
Date: Thu, 01 Feb 2024 10:49:56 -0800
Message-ID: <xmqqplxgyq7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2B4B694-C132-11EE-A969-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Make this struct private by putting its definition inside trailer.c.
> This has two benefits:
>
>   (1) it makes the surface area of the public facing
>       interface (trailer.h) smaller, and
>
>   (2) external API users are unable to peer inside this struct (because
>       it is only ever exposed as an opaque pointer).

At the cost of an extra pointer dereference every time the member of
the struct is accessed, plus the cost of allocation/deallocation.

Which may not be a huge deal, but I wonder if the approach to name
the member of the outer struct with "private" that seems to be used
in other parts of the code (e.g. the .private_size member in the
hashmap structure, the .refs_private member in the repository
structure) or even a documented convention (e.g. raw_object_store),
might be more appropriate here.  If Coccinelle works well (which we
may be having some trouble with --- cf. <xmqq1q9ybsnl.fsf@gitster.g>),
we should be able to catch external accesses without having to hide
the implementation details via an extra pointer dereference.

> @@ -176,11 +176,12 @@ static void interpret_trailers(const struct process_trailer_options *opts,
>  	strbuf_release(&trailer_block);
>  
>  	free_trailers(&head);
> -	trailer_info_release(&info);
>  
>  	/* Print the lines after the trailers as is */
>  	if (!opts->only_trailers)
> -		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
> +		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
> +
> +	trailer_info_release(info);

Interesting.  Is this an indenendent bugfix even if we decided not
to take this patch?  No, I have not fully decided to be negative on
the move this entire patch makes (even though I am leaning towards
saying so).  Just hypothetically, even if we wanted to keep "info"
here as a structure and not a pointer to an opaque structure,
doesn't this hunk fix a real bug?

Well, technically, not quite, because the members referenced in that
if (.only_trailers) block are still live in the info struct.  But it
still smells wrong to access info.* after calling _release() on it,
and this fix should come before "info" is turned from an instance to
a pointer, I would say.

> diff --git a/trailer.h b/trailer.h
> index a7599067acc..e19ddf84e64 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -4,6 +4,8 @@
>  #include "list.h"
>  #include "strbuf.h"
>  
> +struct trailer_info;
> +
>  enum trailer_where {
>  	WHERE_DEFAULT,
>  	WHERE_END,
> @@ -29,27 +31,6 @@ int trailer_set_where(enum trailer_where *item, const char *value);
>  int trailer_set_if_exists(enum trailer_if_exists *item, const char *value);
>  int trailer_set_if_missing(enum trailer_if_missing *item, const char *value);
>  
> +size_t trailer_block_start(struct trailer_info *info);
> +size_t trailer_block_end(struct trailer_info *info);
> +int blank_line_before_trailer_block(struct trailer_info *info);

And we need new accessors, which is a good change regardless of the
answer to the "do we really want an extra pointer dereference?
Shouldn't the existing 'private' and 'internal' label we see below
sufficient?" question.

> @@ -142,7 +123,7 @@ struct trailer_iterator {
>  
>  	/* private */
>  	struct {
> -		struct trailer_info info;
> +		struct trailer_info *info;
>  		size_t cur;
>  	} internal;
>  };
