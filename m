From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] patch-id: document new behaviour
Date: Mon, 31 Mar 2014 12:08:36 -0700
Message-ID: <xmqqmwg65gp7.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
	<1396202583-2572-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhZc-0004vi-Pc
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbaCaTIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:08:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbaCaTIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:08:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C517D77237;
	Mon, 31 Mar 2014 15:08:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rnKCbjW1nOVz9ypGDBvFOVoA3jw=; b=YiLh7t
	C2qWf0a9fvJwF1j/wKF2Wunv+DReiHRwjSSLIhME846rHQDYN8eHfjtnp9ZGnTGG
	CezLaiLDNppo+EO8NiXe9HN6G9AnMuiLkZPI9thqenQY6K6sdKirum1Cmr/eFxGG
	lxkr6RLb6ojsJHESIPFIg4qb8J1bAMTzQW9zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LIz8gRUNSiJKBsOI+GP1MhjRl/SQzgHv
	ayDZNdKc5YOavCzgArxTR6UeDvrq0oRiK4r/9vNU6y/iZ8GzoFCXTy4+puKJINj1
	L6EHA91afm/5NYhfvbKTSfDZIV5sVvbWPkDXjB/hB6x4ot7BoDPsAuDseqKpx0bE
	7FHwdsj5btY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD3CF77236;
	Mon, 31 Mar 2014 15:08:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D17BD77234;
	Mon, 31 Mar 2014 15:08:37 -0400 (EDT)
In-Reply-To: <1396202583-2572-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Sun, 30 Mar 2014 21:09:26 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DD394350-B907-11E3-BDE4-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245512>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Clarify that patch ID is now a sum of hashes, not a hash.
> Document --stable and --unstable flags.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> changes from v2:
> 	explicitly list the kinds of changes against which patch ID is stable
>
>  Documentation/git-patch-id.txt | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
> index 312c3b1..30923e0 100644
> --- a/Documentation/git-patch-id.txt
> +++ b/Documentation/git-patch-id.txt
> @@ -8,14 +8,14 @@ git-patch-id - Compute unique ID for a patch
>  SYNOPSIS
>  --------
>  [verse]
> -'git patch-id' < <patch>
> +'git patch-id' [--stable | --unstable] < <patch>

Thanks.  It seems taht we are fairly inconsistent when writing
alternatives on the SYNOPSIS line.  A small minority seems to spell
the above as "[--stable|--unstable]", which may want to be fixed
(outside the context of this series, of course).

>  
>  DESCRIPTION
>  -----------
> -A "patch ID" is nothing but a SHA-1 of the diff associated with a patch, with
> -whitespace and line numbers ignored.  As such, it's "reasonably stable", but at
> -the same time also reasonably unique, i.e., two patches that have the same "patch
> -ID" are almost guaranteed to be the same thing.
> +A "patch ID" is nothing but a sum of SHA-1 of the diff hunks associated with a
> +patch, with whitespace and line numbers ignored.  As such, it's "reasonably
> +stable", but at the same time also reasonably unique, i.e., two patches that
> +have the same "patch ID" are almost guaranteed to be the same thing.

Perhaps "nothing but" can go by now?

>  
>  IOW, you can use this thing to look for likely duplicate commits.
>  
> @@ -27,6 +27,19 @@ This can be used to make a mapping from patch ID to commit ID.
>  
>  OPTIONS
>  -------
> +
> +--stable::
> +	Use a symmetrical sum of hashes as the patch ID.
> +	With this option, reordering file diffs that make up a patch or
> +	splitting a diff up to multiple diffs that touch the same path
> +	does not affect the ID.
> +	This is the default.
> +
> +--unstable::
> +	Use a non-symmetrical sum of hashes, such that reordering
> +	or splitting the patch does affect the ID.
> +	This was the default value for git 1.9 and older.

I am not sure if swapping the default in this series is a wise
decision.  We typically introduce a new shiny toy to play with in a
release and then later when the shiny toy proves to be useful, start
to think about changing the default, but not before.

>  <patch>::
>  	The diff to create the ID of.
