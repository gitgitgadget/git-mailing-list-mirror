From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Fri, 12 Sep 2014 12:00:03 -0700
Message-ID: <xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
	<xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
	<20140912004717.GY18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 21:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSW4x-0001fK-7B
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbaILTAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 15:00:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65428 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbaILTAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:00:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F10E835DFF;
	Fri, 12 Sep 2014 15:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6v+EelYlgINHwgXup3oEc4QTYTs=; b=pWs01w
	3sPuQXLFwpnYyn5MIoUYC23H9OUmgXXvN2Cwc5Ayr4zofM4wh344d/zQF8MiE6Vs
	vA6hnTjJSf6blk2zGCb8U7WSFACAbJJb/98gidHELHGvxQjRM1q1+Ng794EEfxdz
	8X1LPkhku//jJ0czEoDMXHUjczKoHFL/IN1F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VZ/MLHU+gVdeq5IomGESq/NYEaPS0QIl
	t8cJhIICTpqEa8FJumTEnkx7jBM6ADyAkVim/xC5dLtu765m3gt4OfelsEr++UJ0
	O9ZkKJNqZDUVGOK2Dn/I24Qdw3xieJ7XzyCrv+hflB0J0rvpo6SgDvbDf3UluJ5h
	YCDqGdVtcrY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63E7035DFE;
	Fri, 12 Sep 2014 15:00:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 046A635DEF;
	Fri, 12 Sep 2014 15:00:06 -0400 (EDT)
In-Reply-To: <20140912004717.GY18279@google.com> (Jonathan Nieder's message of
	"Thu, 11 Sep 2014 17:47:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0328BB3A-3AAF-11E4-8260-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256940>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> These patches are also available from the git repository at
>>>
>>>   git://repo.or.cz/git/jrn.git tags/rs/ref-transaction
>>
>> The tag fetched and built as-is seems to break 5514 among other
>> things ("git remote rm" segfaults).
>
> Yeah, I noticed that right after sending the series out. :/
>
> The patch below fixes it[1].

Is this meant to replace anything, or is it "Oops, the previous ones
are broken, and this is to patch it up on top"?

> -- >8 --
> From: Ronnie Sahlberg <sahlberg@google.com>
> Date: Thu, 11 Sep 2014 08:42:57 -0700
> Subject: remote rm/prune: print a message when writing packed-refs fails
>
> Until v2.1.0-rc0~22^2~11 (refs.c: add an err argument to
> repack_without_refs, 2014-06-20), repack_without_refs forgot to
> provide an error message when commit_packed_refs fails.  Even today,
> it only provides a message for callers that pass a non-NULL err
> parameter.  Internal callers in refs.c pass non-NULL err but
> "git remote" does not.
>
> That means that "git remote rm" and "git remote prune" can fail
> without printing a message about why.  Fix them by passing in a
> non-NULL err parameter and printing the returned message.
>
> This is the last caller to a ref handling function passing err ==
> NULL.  A later patch can drop support for err == NULL, avoiding such
> problems in the future.
>
> Change-Id: Ifb8a726ef03d0aa282a25a102313064d2e8ec283
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> [1] https://code-review.googlesource.com/1110
>     https://code-review.googlesource.com/1060
>
>  builtin/remote.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 6eaeee7..ef1ffc3 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -750,13 +750,16 @@ static int mv(int argc, const char **argv)
>  
>  static int remove_branches(struct string_list *branches)
>  {
> +	struct strbuf err = STRBUF_INIT;
>  	const char **branch_names;
>  	int i, result = 0;
>  
>  	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
>  	for (i = 0; i < branches->nr; i++)
>  		branch_names[i] = branches->items[i].string;
> -	result |= repack_without_refs(branch_names, branches->nr, NULL);
> +	if (repack_without_refs(branch_names, branches->nr, &err))
> +		result |= error("%s", err.buf);
> +	strbuf_release(&err);
>  	free(branch_names);
>  
>  	for (i = 0; i < branches->nr; i++) {
> @@ -1333,9 +1336,13 @@ static int prune_remote(const char *remote, int dry_run)
>  		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
>  		for (i = 0; i < states.stale.nr; i++)
>  			delete_refs[i] = states.stale.items[i].util;
> -		if (!dry_run)
> -			result |= repack_without_refs(delete_refs,
> -						      states.stale.nr, NULL);
> +		if (!dry_run) {
> +			struct strbuf err = STRBUF_INIT;
> +			if (repack_without_refs(delete_refs, states.stale.nr,
> +						&err))
> +				result |= error("%s", err.buf);
> +			strbuf_release(&err);
> +		}
>  		free(delete_refs);
>  	}
