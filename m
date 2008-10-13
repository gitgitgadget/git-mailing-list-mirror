From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Mon, 13 Oct 2008 06:54:47 -0700
Message-ID: <7vwsgcbnx4.fsf@gitster.siamese.dyndns.org>
References: <20081005214114.GA21875@coredump.intra.peff.net>
 <20081005214336.GC21925@coredump.intra.peff.net>
 <48EB7D74.40302@viscovery.net>
 <20081007153543.GA26531@coredump.intra.peff.net>
 <7vabdaidwj.fsf@gitster.siamese.dyndns.org>
 <20081013012311.GE3768@coredump.intra.peff.net>
 <7vk5cddtzh.fsf@gitster.siamese.dyndns.org>
 <20081013041525.GA32629@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 15:56:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpNuM-0002Qs-Ez
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 15:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbYJMNzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 09:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbYJMNzI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 09:55:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbYJMNzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 09:55:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 216CD8928A;
	Mon, 13 Oct 2008 09:55:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CCEE08927D; Mon, 13 Oct 2008 09:54:51 -0400 (EDT)
In-Reply-To: <20081013041525.GA32629@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 13 Oct 2008 00:15:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A724C06-992E-11DD-9906-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98111>

Jeff King <peff@peff.net> writes:

> It's possible that one could, given the binary preimage and the two
> lossy textconv'd versions, produce a custom binary merge that would just
> munge the tags, or just munge the text, or whatever. But that is an
> order of magnitude more work than writing a textconv, which is usually
> as simple as "/path/to/existing/conversion-script".
>
> And the whole point of this exercise was to make it simple to set this
> conversion up.
>
>> I'd say that format-patch should always disable textconv so that we won't
>> have to worry about it for now.
>
> Agreed, if you remove "for now". I had never intended for these to be
> anything but a human-readable display (and while I am generally OK with
> generalizing functionality when we can, I think there is real value in
> the simplicity here).

Ok.  I don't disagree with any of the above.

We however need to make it very clear that reversibility (aka ability to
produce applicable diff) is never the goal of the textconv mechanism (and
suggest your "for applicable and reviewable diff, you produce the standard
binary diff and add the textconv diff as a comment" in the documentation),
as I am quite sure that 6 months down the road somebody who was not
involved in this thread would complain.
