From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/15] get_ref_map(): rename local variables
Date: Wed, 23 Oct 2013 11:45:05 -0700
Message-ID: <xmqqwql3q11q.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-6-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 23 20:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ3Qj-0006qJ-Le
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 20:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab3JWSpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 14:45:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45072 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab3JWSpK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 14:45:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA2394DE07;
	Wed, 23 Oct 2013 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XwWJShhB7hu23yImRfSVGcMs5UQ=; b=GyzDRT
	xWwsKqIAp00lQXGK02JNhbfqVeEYAL+deoskpIW96pXwrV2+yS2zdrKWjBMn2qSN
	Zqk3QO2hIJEwc/1ug04kQBPjfwDbc/pHl4o92FulXbSpBcwK/9t74BRsHaxv4XNI
	hPplOWlxuQhrpbGfbOZQL6YzdInMjGtGjPvno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V428x7ce7xLgBnmTOmGqmqJBkicGdG5m
	eAFyzjgJB/ziTNph3auHx7jfRxLgD+sdAUXkCz0STvyNJOyVGlHj4Ns4XlYBcX19
	0CCb0UpAM6TrNwAcjDotneWOTfk8w70Ycl05fOHntYfeNYhYUcmIydR21jRg7PYB
	fsX3LWD2KEU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A42C4DE01;
	Wed, 23 Oct 2013 18:45:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D90044DDFA;
	Wed, 23 Oct 2013 18:45:07 +0000 (UTC)
In-Reply-To: <1382543448-2586-6-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3D3C6B82-3C13-11E3-B2FB-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236546>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Rename "refs" -> "refspecs" and "ref_count" -> "refspec_count" to
> reduce confusion, because they describe an array of "struct refspec",
> as opposed to the "struct ref" objects that are also used in this
> function.

Good.  In general, we'd prefer to name an array of things that are
primarily walked in the index order "thing[]", so that "thing number
3" can be spelled thing[3] (not things[3]) in the code, though.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/fetch.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index bd7a101..2248abf 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -165,8 +165,8 @@ static void find_non_local_tags(struct transport *transport,
>  			struct ref ***tail);
>  
>  static struct ref *get_ref_map(struct transport *transport,
> -			       struct refspec *refs, int ref_count, int tags,
> -			       int *autotags)
> +			       struct refspec *refspecs, int refspec_count,
> +			       int tags, int *autotags)
>  {
>  	int i;
>  	struct ref *rm;
> @@ -175,12 +175,12 @@ static struct ref *get_ref_map(struct transport *transport,
>  
>  	const struct ref *remote_refs = transport_get_remote_refs(transport);
>  
> -	if (ref_count || tags == TAGS_SET) {
> +	if (refspec_count || tags == TAGS_SET) {
>  		struct ref **old_tail;
>  
> -		for (i = 0; i < ref_count; i++) {
> -			get_fetch_map(remote_refs, &refs[i], &tail, 0);
> -			if (refs[i].dst && refs[i].dst[0])
> +		for (i = 0; i < refspec_count; i++) {
> +			get_fetch_map(remote_refs, &refspecs[i], &tail, 0);
> +			if (refspecs[i].dst && refspecs[i].dst[0])
>  				*autotags = 1;
>  		}
>  		/* Merge everything on the command line, but not --tags */
