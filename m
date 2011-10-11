From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/7] invalidate_ref_cache(): rename function from
 invalidate_cached_refs()
Date: Mon, 10 Oct 2011 17:00:38 -0700
Message-ID: <7vfwj0iehl.fsf@alter.siamese.dyndns.org>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPm1-0004xl-9G
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab1JKAAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 20:00:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1JKAAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 20:00:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 555E85603;
	Mon, 10 Oct 2011 20:00:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=O9lpYyJiMjnXRuzBSDitYMIVHdQ=; b=Lg4nfYrTsWps0yTtGcoY
	V+4BBShH4BjC+zDXTxpHidSGVwYK3TJRHcKnidB2DyyNBWCNb2zfgOatLx+WmFO1
	e3u3w9+n3jdw5DbqM9WBhRCWoDleV5xa0FEDOmLVsUY6K8HYln7ghh+TlWT8uhmm
	OPc2G4a0pIthR/ovMPn8foA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hLZsNMOCsiPfYgQiWJpyx+pjwtQsyebmMbsYE2JAb2Rr6w
	iGaFfVh0vl8DLW3jm6KUK2YM+u3l6+YWBGINwqF8mB+a9z3bdYVeymJCerKqBwMo
	EGcAKMnbySfxJRNBw4lNKWte/EuLMwBZTMdGT6ggETwBsB0MiBwlW1cRJPOj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BAB15602;
	Mon, 10 Oct 2011 20:00:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF0BF5601; Mon, 10 Oct 2011
 20:00:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E20D5E8-F39C-11E0-BFC6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183273>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It is the cache that is being invalidated, not the references.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Although I think one can say "ref cache is the container for cached refs"
and invalidating the "ref cache" as the container and invalidating the
"cached refs" as a collection mean essentially the same thing, probably
the new name makes more sense.

>  refs.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 2cb93e2..56e4254 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -223,7 +223,7 @@ static struct cached_refs *get_cached_refs(const char *submodule)
>  	return refs;
>  }
>  
> -static void invalidate_cached_refs(void)
> +static void invalidate_ref_cache(void)
>  {
>  	struct cached_refs *refs = cached_refs;
>  	while (refs) {
> @@ -1212,7 +1212,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  	ret |= repack_without_ref(refname);
>  
>  	unlink_or_warn(git_path("logs/%s", lock->ref_name));
> -	invalidate_cached_refs();
> +	invalidate_ref_cache();
>  	unlock_ref(lock);
>  	return ret;
>  }
> @@ -1511,7 +1511,7 @@ int write_ref_sha1(struct ref_lock *lock,
>  		unlock_ref(lock);
>  		return -1;
>  	}
> -	invalidate_cached_refs();
> +	invalidate_ref_cache();
>  	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
>  	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
>  	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
