From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [puzzled and solved] "shortlog" not quite understanding all "log" options
Date: Fri, 30 May 2014 14:37:02 -0700
Message-ID: <xmqqwqd36j9d.fsf@gitster.dls.corp.google.com>
References: <xmqqzjhz83rk.fsf@gitster.dls.corp.google.com>
	<20140530201652.GC5513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 23:37:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqUUT-0008M6-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 23:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933232AbaE3VhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 17:37:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55358 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932289AbaE3VhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 17:37:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99E911B1A8;
	Fri, 30 May 2014 17:37:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/1VERQNJrRGeMycjIJiOMlakeLA=; b=x8iIrv
	gBJWYowCGl70RhJzLwedTgyXZtcLYZDO+eNCHsY8nv4gJlzjlaOh+8ko3J4KWgIy
	p3sLIqNAq+hq443Sg1Yh5k01dQWUyAKZY16etCdE0A5T9rGQKt+ECaCMRChZ9HKm
	9nOWtWdK9RVVF+vV6jhnIWnQw3RTB62f9V/og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vrXSUTjlyHW4ex9GrtRli9FOsAoX+rwx
	XS6gotb49H671WW8a2OMU3fLLRw1o6pdtG4vXkTM+1jE4A3NJlltmQ7JM9jFDgOI
	z3CU6+B+BZrdGiT1Ejwunec4sK9ie7vy31f2GAXvqqtrg+HdhLb8dKLoRGMPJSgj
	X/rl0b9bfO8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 783221B1A4;
	Fri, 30 May 2014 17:37:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E7081B1A1;
	Fri, 30 May 2014 17:37:04 -0400 (EDT)
In-Reply-To: <20140530201652.GC5513@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 30 May 2014 16:16:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8AA38DB6-E842-11E3-BD10-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250488>

Jeff King <peff@peff.net> writes:

> On Fri, May 30, 2014 at 12:28:47PM -0700, Junio C Hamano wrote:
>
>> .... Aaaand, it turns out that the answer is in the big comment at
>> the beginning of handle_revision_pseudo_opt().
>> 
>> -- >8 --
>> Subject: shortlog: allow --exclude=<glob> to be passed
>> 
>> e7b432c5 (revision: introduce --exclude=<glob> to tame wildcards,
>> 2013-08-30) taught a new option to the command-line parser of "log"
>> and friends, but did not wire it fully so that it can also be used
>> by "shortlog".
>
> FWIW, I think the discussion above the scissors adds a lot to the
> context. It might be nice to add it to the commit message.

OK.  Try to remember when I reroll it.

> I am slightly puzzled why parse_revision_opt does not just call
> handle_revision_pseudo_opt. According to f6aca0dc4, it is because
> pseudo-options need to be acted on in-order, as they affect things like
> subsequent "--not" options, etc. But if we are using parse_options_step,
> shouldn't we be handling the options in order?
>
> I am sure I am just missing something obvious, so do not trouble
> yourself if you do not know the answer offhand.

Sorry, I don't know ;-)
