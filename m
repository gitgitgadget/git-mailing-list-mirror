From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 10:51:12 -0700
Message-ID: <7vd2tr6833.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
	<7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
	<87wqs1xi9h.fsf@hexa.v.cablecom.net>
	<7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
	<7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
	<20130417201056.GA2914@sigill.intra.peff.net>
	<7va9owd3d1.fsf@alter.siamese.dyndns.org>
	<20130418172714.GA24690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:51:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USszQ-0000Mo-7V
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941Ab3DRRvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:51:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab3DRRvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:51:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22BAF173EF;
	Thu, 18 Apr 2013 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xh5rTFomZdTFI2q15B9QhPkoYtA=; b=eoGa7O
	t620QyA72gjs9pXFyPmCnnXWYxB31C/kzBYZLTBJBFpi/CU6WQ534qLR+3bGx3hW
	3BYLFGHn71l9d/nYSODUOV6t+T4U+0G7PCVIaRqVKbuSsVgITylxOOOlTHvNPBNh
	mbEPiRzppCckdvio8ohTVvzm0pmgo2ahRac5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IRB4D0mM5JCp/JEdiDKYfUdlmzZyo1jD
	l0brr7HuS2lioZt3W0l56owAbgOw0xWL6CNB8b2jqteoydmNEP0SASjJpz7AFtWH
	aYpy6eOL0irNuOMkp+YWrPa+UjazTBzwh+cRMCJCae8RnK03Dv070ssmRSlq0vYH
	RLv/S7vEaJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4C8173EE;
	Thu, 18 Apr 2013 17:51:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74CB8173EB;
	Thu, 18 Apr 2013 17:51:13 +0000 (UTC)
In-Reply-To: <20130418172714.GA24690@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 18 Apr 2013 13:27:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8F9E081A-A850-11E2-AE99-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221678>

Jeff King <peff@peff.net> writes:

> +static const char *add_would_remove_warning = N_(
> +/* indent for "warning: " */
> +         "In Git 2.0, 'git add <pathspec>...' will also update the\n"
> +"index for paths removed from the working tree that match the given\n"
> +"pathspec. If you want to 'add' only changed or newly created paths,\n"
> +"say 'git add --no-all <pathspec>...' instead.\n");
> +
>  static void warn_add_would_remove(const char *path)
>  {
> -	warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
> -		  "index for paths removed from the working tree that match\n"
> -		  "the given pathspec. If you want to 'add' only changed\n"
> -		  "or newly created paths, say 'git add --no-all <pathspec>...'"
> -		  " instead.\n\n"
> -		  "'%s' would be removed from the index without --no-all."),
> -		path);
> +	static int warned_once;
> +	if (!warned_once++)
> +		warning(_(add_would_remove_warning));
> +	warning("did not stage removal of '%s'", path);
>  }

Would "add --dry-run" say this, too?

>  static void update_callback(struct diff_queue_struct *q,
> @@ -84,10 +88,8 @@ static void update_callback(struct diff_queue_struct *q,
>  			}
>  			break;
>  		case DIFF_STATUS_DELETED:
> -			if (data->warn_add_would_remove) {
> +			if (data->warn_add_would_remove)
>  				warn_add_would_remove(path);
> -				data->warn_add_would_remove = 0;
> -			}
>  			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
>  				break;
>  			if (!(data->flags & ADD_CACHE_PRETEND))
