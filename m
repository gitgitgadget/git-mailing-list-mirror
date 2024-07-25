Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C419AD8B
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927373; cv=none; b=HamnLofUG5sMZ/1OgtWHjSfISpdPlBbXPmtAbI3ysbkuezgByS7zJxQVtmppzjTf82TEfJkRqWTfh5zcHUOxtGxYw5lRisB7HT6lC20g13lhhqZkU8/Op8JZ546+Tc5hcK7sCnOktF9XKPxXc676T2/E59+1qdq3Nl/XagBA16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927373; c=relaxed/simple;
	bh=pVZT42TXZ/a3keDn3MUl4BKQpCuN//8DSR5+DANEGnE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cjR2qDzvB8CFobm/PutkpNBLdJ/clDo1Tt+5oKOihRGVMHbBCS9cCFDvs2icuhFmeW0KQr+jmPhfyWleR2oZ3v/VO1RhzJDiqThT9U2lFlYN4vebhJQEuPstJgrWcwDFPuvqxw62NNHH5erBqt+LeI2Xw1dMq6uOBs8QBPYXu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jrlp87AN; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jrlp87AN"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 36FB21A809;
	Thu, 25 Jul 2024 13:09:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pVZT42TXZ/a3keDn3MUl4BKQpCuN//8DSR5+DA
	NEGnE=; b=jrlp87ANE+5gORk+uwCqJ8cVTDrJrDuSketvgQXt3hQH4wdBA4M+fV
	bL6VQjLc9Hu+rON9OrjSwuz9/3tzNoR75sJubS+SrS2+9QqNib3MUyXBHTXYiPg0
	sbpOTGbKh9CSh2fn2tA6WP8yNsEorfH3hs0gopWLORVm2lS2S+DAc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FEEF1A808;
	Thu, 25 Jul 2024 13:09:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AC66C1A807;
	Thu, 25 Jul 2024 13:09:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: David Disseldorp <ddiss@suse.de>
Cc: git@vger.kernel.org,  Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH 2/2] notes: revert note_data.given behavior with empty
 notes add
In-Reply-To: <20240725144548.3434-3-ddiss@suse.de> (David Disseldorp's message
	of "Thu, 25 Jul 2024 16:41:07 +0200")
References: <20240725144548.3434-1-ddiss@suse.de>
	<20240725144548.3434-3-ddiss@suse.de>
Date: Thu, 25 Jul 2024 10:09:26 -0700
Message-ID: <xmqqzfq5flfd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A65370E8-4AA8-11EF-AD85-92D9AF168FA5-77302942!pb-smtp20.pobox.com

David Disseldorp <ddiss@suse.de> writes:

> Subject: Re: [PATCH 2/2] notes: revert note_data.given behavior with empty notes add

Maybe it is just me, but "revert" has a specific connotation in the
context of the command this project develops, and when your patch is
not doing so, it gets misleading.  If you said you are restoring the
behaviour, that would be more easily understood.

    notes: do not trigger editor when adding an empty note

perhaps?

> Prior to 90bc19b3ae, note_data.given was set alongside an -m, -C or -F

Please make the first mention of a commit using "git show -s --pretty=reference"
format, i.e.

    90bc19b3ae (notes.c: introduce '--separator=<paragraph-break>' option, 2023-05-27)

Using the reference format, besides being consistent, is very much
preferrable to allow us to tell how old the problem goes back
immediately by having the datestamp at the end.

more generally, this proposed log message starts with implementation
details.  When we have a user-visible breakage, please start from
describing that instead.  The usual way to compose a log message of
this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y" or "X
   does Y"), and discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  So something along this line:

	With "git notes add -C $blob", the given blob contents are
	to be made into a note without involving an editor.  But
	when "--allow-empty" is given, the editor is invoked.

	This behaviour started when 90bc19b3 (notes.c: introduce
	'--separator=<paragraph-break>' option, 2023-05-27).  Prior
	to that commit, we used to do this and that ... describe
	implementation details here if you want ...

	Restore the original behaviour of "git note" that takes the
	contents given via the "-m", "-C", "-F" options without
	invoking an editor, by doing ... this and that ... describe
	implementation details here if you want ...

would be more customary.

This is not a fault of this patch, and certainly not a fault of
90bc19b3 (notes.c: introduce '--separator=<paragraph-break>' option,
2023-05-27), but unlike "git commit" and "git tag" that can take
pre-prepared contents from some source and by default use that
intact without involving an editor, "git notes" seems to lack the
ability to countermand this default and spawn an editor (e.g., "git
commit -F myfile -e").  We may want to #leftoverbits fix that.

> Fixes: 90bc19b3ae ("notes.c: introduce '--separator=<paragraph-break>' option")
> Link: https://github.com/ddiss/icyci/issues/12

We generally refrain from using these two trailers.  Please drop them.

Especially "Fixes" claim can later prove incorrect (we thought this
was a good fix when committing, but it later turned out to be a bad
one), and besides you will be referring to the problematic commit in
your proposed log message already anyway.

> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  builtin/notes.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index d9c356e354..3ccb3eb602 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -282,6 +282,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
>  	d->messages[d->msg_nr - 1] = msg;
>  	msg->stripspace = STRIPSPACE;
> +	d->given = 1;
>  	return 0;
>  }
>  
> @@ -302,6 +303,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
>  	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
>  	d->messages[d->msg_nr - 1] = msg;
>  	msg->stripspace = STRIPSPACE;
> +	d->given = 1;
>  	return 0;
>  }
>  
> @@ -335,6 +337,7 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
>  	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
>  	d->messages[d->msg_nr - 1] = msg;
>  	msg->stripspace = NO_STRIPSPACE;
> +	d->given = 1;
>  	return 0;
>  }

All the above places that resurrects setting d.given looks OK, but
it makes me wonder if you need to add them in the first place.

Wouldn't it be sufficient to see if d->msg_nr is non-zero after all
the parsing is done?  If any of the message came from "-c", a
separate flag d->use_editor is set to force you run the editor, and
otherwise you'd not be using the editor, right?

> @@ -515,7 +518,6 @@ static int add(int argc, const char **argv, const char *prefix)
>  
>  	if (d.msg_nr)
>  		concat_messages(&d);
> -	d.given = !!d.buf.len;

Here is what I mean.  If you didn't do any of the "d->given = 1"
above during parsing, and instead say

	if (d.msg_nr)
		concat_messages(&d);
	d.given = d.msg_nr;

shouldn't it be sufficient to convince prepare_note_data() to do the
right thing?

Thanks.
