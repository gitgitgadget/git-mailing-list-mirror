From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/14] clear_ref_list(): rename from free_ref_list()
Date: Thu, 13 Oct 2011 11:43:22 -0700
Message-ID: <7vipns4trp.fsf@alter.siamese.dyndns.org>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
 <1318492715-5931-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 20:43:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQFf-0001nq-Jw
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab1JMSnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:43:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab1JMSnY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:43:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1372C346E;
	Thu, 13 Oct 2011 14:43:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BMB42u0l7bZMExB9jmddgJGiuTU=; b=w+wOJh
	vD6mphef2kuTp17mHPr+s1RWT8hbXC2vlGfLl3/CmD/7Bnjb9pCy5D7FcYa4jCcV
	uSDKh8OaQ/or0rn1j3RKxu7T64FBnHfPH6kGohVN7+R3ddFYxhNvpijdffWktTSH
	+m/7RktRDGaL1Zz5jALyzUxM4tAk56eZ8d3Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xhDZMGkynya0vZRvr3g8Vwlk1Ag7JviM
	5iE4OeWYtHhTDy7LseCZkzaUxoyIO0i+Ut1WT3t9EAeK7hseOGlvZdbszEHy4BvZ
	44H6KzUcofUwnjvwhkOArDytJeJkv1o0YWVZmQrRQbe6YOMKbK2/cVwQgAkMHMY2
	2LMyvdk6tKQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06984346D;
	Thu, 13 Oct 2011 14:43:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78B41346C; Thu, 13 Oct 2011
 14:43:23 -0400 (EDT)
In-Reply-To: <1318492715-5931-6-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Thu, 13 Oct 2011 09:58:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3AD78894-F5CB-11E0-BE41-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183511>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> Rename the function since it doesn't actually free the array object
> that is passed to it.

The commit log message correctly refers to the "array-ness" of the object
being cleared. Needs retitling the patch to match.

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index c466fcd..a2e48e4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -149,7 +149,7 @@ static struct ref_entry *current_ref;
>  
>  static struct ref_array extra_refs;
>  
> -static void free_ref_array(struct ref_array *array)
> +static void clear_ref_array(struct ref_array *array)
>  {
>  	int i;
>  	for (i = 0; i < array->nr; i++)
> @@ -162,14 +162,14 @@ static void free_ref_array(struct ref_array *array)
>  static void clear_cached_packed_refs(struct cached_refs *refs)
>  {
>  	if (refs->did_packed)
> -		free_ref_array(&refs->packed);
> +		clear_ref_array(&refs->packed);
>  	refs->did_packed = 0;
>  }
>  
>  static void clear_cached_loose_refs(struct cached_refs *refs)
>  {
>  	if (refs->did_loose)
> -		free_ref_array(&refs->loose);
> +		clear_ref_array(&refs->loose);
>  	refs->did_loose = 0;
>  }
>  
> @@ -256,7 +256,7 @@ void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
>  
>  void clear_extra_refs(void)
>  {
> -	free_ref_array(&extra_refs);
> +	clear_ref_array(&extra_refs);
>  }
>  
>  static struct ref_array *get_packed_refs(const char *submodule)
