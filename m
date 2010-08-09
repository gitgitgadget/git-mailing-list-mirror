From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Turn unpack_trees_options.msgs into an array + enum
Date: Mon, 09 Aug 2010 12:47:41 -0700
Message-ID: <7vwrrz4lgi.fsf@alter.siamese.dyndns.org>
References: <1281363602-27856-1-git-send-email-Matthieu.Moy@imag.fr>
 <1281363602-27856-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:48:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYKF-0005Sy-LP
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab0HITry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 15:47:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab0HITrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:47:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 43C05CCA95;
	Mon,  9 Aug 2010 15:47:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R5r7R2guOwTo/PBeroJHFA8IzZM=; b=tCCujB
	Rtm9KzVVwZT2W8WPBBpiKdGtDQzb4GTFusOTzNjksySLAfka7ErtYd+WkXyVeOV9
	t7ycv1TPxRMHyNdD0MWlwAwZRr3NSxewjpgt04lClq660s+GQzi1FPLJOYVHGKBq
	c6gv7v5bZa8+WesdG8ZBvJ2zQkxtuRbA4UsIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gzAz7zjS+JssJ+1ZUhav45N097KFyIBq
	wEQR9EVFqs7dX2beLitgRpBjQQSPiQ19gZNslbXPRL4+G7vmeTFfv8aoUeUw1/KW
	9uKAVoZ3wsbVgbP5ledXwhkYIYADJglB3DjMwSpZ1qMew42pTUvoWOMt8odZvUFY
	1B4nueSsJd0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0030DCCA94;
	Mon,  9 Aug 2010 15:47:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40544CCA93; Mon,  9 Aug
 2010 15:47:45 -0400 (EDT)
In-Reply-To: <1281363602-27856-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon\,  9 Aug 2010 16\:19\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FD3007B6-A3EE-11DF-B3CC-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153008>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The list of error messages was introduced as a structure, but an array
> indexed over an enum is more flexible, since it allows one to store a
> type of error message (index in the array) in a variable.

Hmm, the only example of the advantage "enum used as array index" offers
that I can think of off the top of my head is that you can more easily
iterate over it.

> This change needs to rename would_lose_untracked ->
> would_lose_untracked_file to avoid a clash with the function
> would_lose_untracked in merge-recursive.c.

Yes, that shows one upside of "field names in a structure" has over
"enum used as array index".  We get a unique namespace.

If you are to change them to enum, I would actually suggest renaming them
a bit more to make them stand out.  Perhaps spell them all in caps,
perhaps have them share the same short prefix (UTEM_ - unpack trees error
messages), etc.

Having said all that, I am not against the main idea of this patch.
