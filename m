From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-instaweb: Don't assume Apache executable is
 named apache2
Date: Wed, 30 Jun 2010 09:03:17 -0700
Message-ID: <7v39w48q4a.fsf@alter.siamese.dyndns.org>
References: <1277865900-25044-1-git-send-email-dpmcgee@gmail.com>
 <1277865900-25044-3-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 18:03:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzlF-0000Cr-Ga
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 18:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab0F3QDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 12:03:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159Ab0F3QDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 12:03:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86D80C0F2F;
	Wed, 30 Jun 2010 12:03:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pOY25dKp1PKyZrbLWBVezd2WZK0=; b=H4rwwo
	ONkr3cEeDyV/jmEv1zYnbE5QcoFZ7DhvdRbh2fVVOVm6lar4qCv/DEPMjOH2TYJw
	6N8BtvXLnVj6yF9F/nA8AjjK6hL4EaZiNBc7roXxQl6T93VdgXYBzw93yJpJPXLq
	IVXCGTEfvSKe09GLyir72v1mOBKnH4p7CSOhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OOBs+1JsWvowOtAf3ZaW76acXvypIb8i
	sMbsHmKEYqfd+XoUE5GjpUG39T1AiGFc8xGO+1/VBTWG1N2i7uApgm3gtVtadGve
	Pi+ZQGIQZvtVcPFfmPo+pCSh9zR/pID5CIkYYZQd+KXTmVASswwt/2WmNnC5ybQ+
	NQujton1EjE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F4D2C0F27;
	Wed, 30 Jun 2010 12:03:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 204D5C0F20; Wed, 30 Jun
 2010 12:03:18 -0400 (EDT)
In-Reply-To: <1277865900-25044-3-git-send-email-dpmcgee@gmail.com> (Dan
 McGee's message of "Tue\, 29 Jun 2010 21\:45\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02F8E21A-8461-11DF-9018-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149978>

Dan McGee <dpmcgee@gmail.com> writes:

> On Arch Linux, we keep the original 'httpd' name for the exectuable and
> don't rename it or the path to the modules.

Sorry, but I cannot parse the last 6 words here.

> Remove some of these assumptions
> and add the httpd name in where it may be required.
> ...
>  resolve_full_httpd () {
>  	case "$httpd" in
> -	*apache2*|*lighttpd*)
> +	*apache2*|*lighttpd*|*httpd*)
> +		# yes, *httpd* covers *lighttpd* above, but it is there for clarity

That may make things work better on Arch but I wonder if there are
platforms that allow users to point at their favorite, non-Apache, http
server with a canonical name "httpd" that gets broken by this change.  Am
I being too paranoid?

Other two patches looked very sane.  Thanks.
