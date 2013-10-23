From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/15] ref_remove_duplicates(): improve documentation comment
Date: Wed, 23 Oct 2013 11:47:29 -0700
Message-ID: <xmqqsivrq0xq.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-9-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 23 20:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ3Sy-0008Nz-UG
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 20:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab3JWSrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 14:47:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163Ab3JWSrc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 14:47:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 157224D06B;
	Wed, 23 Oct 2013 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LCq27y/y3hy7HNcu9nWOmfMDFlI=; b=YZFTc1
	tmq/DjhLyaDeGdOxZA79aovHg0Prikglw337XZEwj5gc6iGV2RcS6Clna2zZU6mL
	sJIYlJ/syfnWvZ6bjKS/a5Ew2vo2j5Vf8HTsurF+jkccEgSu2cczNN1voKunBS4Y
	NxfK/6bGigkd8t/jLLQU2qH2Yq+S7J+NxiNhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Us2I3TqrcRbDKXJ8D6ykqCYR9ht8fAm1
	7dV4CX3W4ZYijmwN8GsQvgYR6GW1YqKWbZcbm3AZJg04R/NhIqkADoWUIcYOdO7q
	UvVT+QRjiGVt1XJLZh225qTgW5IVqPFqQiiKm9v5bhfIkB7BQNRbvfCs3R+23aAT
	edHJRzCgcEk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03F7F4D06A;
	Wed, 23 Oct 2013 18:47:32 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FFA74D066;
	Wed, 23 Oct 2013 18:47:31 +0000 (UTC)
In-Reply-To: <1382543448-2586-9-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Wed, 23 Oct 2013 17:50:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 92ACBC34-3C13-11E3-8D3C-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236547>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Up to this point the patches all look very sensible (modulo minor
nits I sent separately).  Will come back to the rest of the topics
later.

Thanks.

> ---
>  remote.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/remote.h b/remote.h
> index 131130a..40293c0 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -149,7 +149,14 @@ int resolve_remote_symref(struct ref *ref, struct ref *list);
>  int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
>  
>  /*
> - * Removes and frees any duplicate refs in the map.
> + * Remove and free all but the first of any entries in the input list
> + * that map the same remote reference to the same local reference.  If
> + * there are two entries that map different remote references to the
> + * same local reference, die.
> + *
> + * Note that the first entry is never removed; therefore, the pointer
> + * passed in as argument still points to the head of the list after
> + * the function returns.
>   */
>  void ref_remove_duplicates(struct ref *ref_map);
