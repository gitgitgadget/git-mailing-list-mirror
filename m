From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Sun, 06 Jan 2008 02:51:24 -0800
Message-ID: <7vejcv5is3.fsf@gitster.siamese.dyndns.org>
References: <7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
	<20080106042409.GA4843@coredump.intra.peff.net>
	<20080106042935.GB4843@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 06 11:52:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBT6x-0004bq-Ev
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 11:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbYAFKvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 05:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYAFKvg
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 05:51:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbYAFKvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 05:51:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 719A9778D;
	Sun,  6 Jan 2008 05:51:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D54778B;
	Sun,  6 Jan 2008 05:51:30 -0500 (EST)
In-Reply-To: <20080106042935.GB4843@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 5 Jan 2008 23:29:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69724>

Jeff King <peff@peff.net> writes:

> This is a little uglier than it could be because the "colored" function
> does two things: correctly colorize a string, and check the global
> $use_color.

That fallout is a logical consequence of the semantics change of
color.interactive, which used to color the whole user experience
but now only covers about menus and stuff.  $use_color is still
tied to the former semantics.

It may make more sense to:

 * unset $prompt_color and friends when color.interactive says
   "not to color the menus";

 * unset $fraginfo_color and diff related ones when color.diff
   says "diff is monochrome";

upfront, and then change "sub colored" to just check if $color
is unset, instead of checking $use_color.
