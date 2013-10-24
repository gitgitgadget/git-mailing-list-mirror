From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/15] fetch --prune: prune only based on explicit refspecs
Date: Thu, 24 Oct 2013 14:11:41 -0700
Message-ID: <xmqqiowmml0y.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-12-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSC8-0005TR-K7
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722Ab3JXVLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:11:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab3JXVLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:11:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A9D24D9D6;
	Thu, 24 Oct 2013 21:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4kBx3S2LaMOzMJrZ6GMWjkyoHMc=; b=ito73l
	sUqXrWJGA5fWL1hTw9AlyV+puTF7Eq0jg9ard9s/I0TsRkqciXnliwDUs0WCyPlf
	E9F7jekirRlZMO39tyMmsOvV6l+SEjrVkibXSF2coLC4dzVzryqMuLAjQ6ckQAmk
	BfZfyu5oqsHczSzZpEAhi690SxhOMBPwr0taQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dn2of4qvP1CdkomKdhtxCSEQNmpQlFIg
	VKe9LYMib3WtKNDC17SCIIOGiP8BP/islI5Y2gYBC2GENiReCzbLIOJGm9an7nse
	g78yACoL1uYcC9UiDGc4C3EZ3odjyjvz+fSyYCs2RGFgYuFr/Y51h/I2xSY/z89z
	aIl9H6369Sk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C37F4D9D3;
	Thu, 24 Oct 2013 21:11:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32AD14D9CE;
	Thu, 24 Oct 2013 21:11:43 +0000 (UTC)
In-Reply-To: <1382543448-2586-12-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E342B6B6-3CF0-11E3-8539-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236623>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ...
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Everything in the proposed log message made sense to me.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d4d93c9..83c1700 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2086,7 +2086,7 @@ remote.<name>.vcs::
>  remote.<name>.prune::
>  	When set to true, fetching from this remote by default will also
>  	remove any remote-tracking branches which no longer exist on the
> -	remote (as if the `--prune` option was give on the command line).
> +	remote (as if the `--prune` option was given on the command line).

Shouldn't we stop saying "branches" here?

> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 0e6d2ac..5d12219 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -41,8 +41,14 @@ ifndef::git-pull[]
>  
>  -p::
>  --prune::
> -	After fetching, remove any remote-tracking branches which
> -	no longer exist	on the remote.
> +	After fetching, remove any remote-tracking branches that

Likewise.  This is a lot more important than the one in
remote.<name>.prune documentation, as the next sentence "Tags are
not subject to ..." implies that they fall into the same category as
what gets pruned here, i.e. "remote-tracking branches" in the above
sentence, but nobody calls refs/tags/v1.0.0 a "remote-tracking
branch" even if it came from your 'origin'.

> +	no longer exist	on the remote.  Tags are not subject to
> +	pruning in the usual case that they are fetched because of the
> +	--tags option or remote.<name>.tagopt.  

We should mention the most usual case tags are fetched, before
mentioning the case the unusual option "--tags" was used from the
command line or .tagopt configuration was used.  Namely, when the
tags are automatically followed.

> +     However, if tags are
> +	fetched due to an explicit refspec (either on the command line
> +	or in the remote configuration, for example if the remote was
> +	cloned with the --mirror option), then they are also subject
> +	to pruning.

Very good.

> @@ -63,7 +69,10 @@ ifndef::git-pull[]
>  --tags::
>  	This is a short-hand requesting that all tags be fetched from
>  	the remote in addition to whatever else is being fetched.  It
> -	is similar to using the refspec `refs/tags/*:refs/tags/*`.
> +	is similar to using the refspec `refs/tags/*:refs/tags/*`,
> +	except that it doesn't subject tags to pruning, regardless of
> +	a --prune option or the configuration settings of fetch.prune
> +	or remote.<name>.prune.

Using --tags is not similar to using refs/tags/*:refs/tags/* after
the previous patch already; "git fetch origin --tags" and "git fetch
origin refs/tags/*:refs/tags/*" are vastly different and that was
the whole point of the previous step.  And that "calling something
not so similar similar" needs to be fixed further here to clarify
that they are not similar in yet another way.

We should just lose "It is similar to using" from 10/15 and start
over, perhaps?  Add the first paragraph of the below in 10/15 and
add the rest in 11/15, or something.

	--tags::
		Request that all tags be fetched from the remote
		under the same name (i.e. `refs/tags/X` is created in
		our repository by copying their `refs/tags/X`), in
		addition to whatever is fetched by the same `git
		fetch` command without this option on the command
		line.
	+
        When `refs/tags/*` hierarchy from the remote is copied only
        because this option was given, they are not subject to be
	pruned when `--prune` option (or configuration variables
	like `fetch.prune` or `remote.<name>.prune`) is in effect.

That would make it clear that they are subject to pruning when --mirror
or an explicit refspec refs/tags/*:refs/tags/* is given, as tags are
not fetched "only because of --tags" in such cases.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7edb1ea..47b63a7 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -829,38 +829,17 @@ static int do_fetch(struct transport *transport,
>  		goto cleanup;
>  	}
>  	if (prune) {
> -		struct refspec *prune_refspecs;
> -		int prune_refspec_count;
> -
> +		/*
> +		 * We only prune based on refspecs specified
> +		 * explicitly (via command line or configuration); we
> +		 * don't care whether --tags was specified.
> +		 */
>  		if (ref_count) {
> -			prune_refspecs = refs;
> -			prune_refspec_count = ref_count;
> -		} else {
> -			prune_refspecs = transport->remote->fetch;
> -			prune_refspec_count = transport->remote->fetch_refspec_nr;
> -		}
> -
> -		if (tags == TAGS_SET) {
> -			/*
> -			 * --tags was specified.  Pretend that the user also
> -			 * gave us the canonical tags refspec
> -			 */
> -			const char *tags_str = "refs/tags/*:refs/tags/*";
> -			struct refspec *tags_refspec, *refspec;
> -
> -			/* Copy the refspec and add the tags to it */
> -			refspec = xcalloc(prune_refspec_count + 1, sizeof(*refspec));
> -			tags_refspec = parse_fetch_refspec(1, &tags_str);
> -			memcpy(refspec, prune_refspecs, prune_refspec_count * sizeof(*refspec));
> -			memcpy(&refspec[prune_refspec_count], tags_refspec, sizeof(*refspec));
> -
> -			prune_refs(refspec, prune_refspec_count + 1, ref_map);
> -
> -			/* The rest of the strings belong to fetch_one */
> -			free_refspec(1, tags_refspec);
> -			free(refspec);
> +			prune_refs(refs, ref_count, ref_map);
>  		} else {
> -			prune_refs(prune_refspecs, prune_refspec_count, ref_map);
> +			prune_refs(transport->remote->fetch,
> +				   transport->remote->fetch_refspec_nr,
> +				   ref_map);
>  		}
>  	}

Nice.
