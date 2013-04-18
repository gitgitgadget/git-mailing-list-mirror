From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 11:16:33 -0700
Message-ID: <7v61zj66wu.fsf@alter.siamese.dyndns.org>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
	<87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
	<7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
	<87wqs1xi9h.fsf@hexa.v.cablecom.net>
	<7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
	<7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
	<20130417201056.GA2914@sigill.intra.peff.net>
	<7va9owd3d1.fsf@alter.siamese.dyndns.org>
	<20130418172714.GA24690@sigill.intra.peff.net>
	<7vd2tr6833.fsf@alter.siamese.dyndns.org>
	<20130418180017.GA5714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 20:16:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UStNy-0003Gb-NE
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 20:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156Ab3DRSQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 14:16:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330Ab3DRSQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 14:16:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A555217575;
	Thu, 18 Apr 2013 18:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O3vKH/vjztbQdVCkVojbXGQw/VI=; b=e5b68d
	pXtlk9WigzFFmQ+fIE7wcfNJuyZ6nldXGJ8y/l9SOhZfe7E53yNNZeRzJFMvfWXV
	eQ5AuaSeXIf/Q3T0DWq6faU9YpzWIauK8HTFBkmUwps6CDX+QiDKRbjNELj0jPlk
	FDGB3lC/YoNBCQfQZtanyWmsXlBc9a+l39RiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qTxeNOgAkHeBGJtsFISoC2BdsCEX98vs
	fIMFHf3zkpI6IOj6cm6uBfGcvQksx2Zh1mLG/aruPInbqNFIpg++uhhPaClSADQm
	U97XCSIUFS19YZOHjsrx8gohF8ANjHd2s7wFoiEIXOckMMcFH5P3y+UwoaQrb1Ks
	4V3FGqRZDpE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CDB917574;
	Thu, 18 Apr 2013 18:16:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 004DE17572;
	Thu, 18 Apr 2013 18:16:34 +0000 (UTC)
In-Reply-To: <20130418180017.GA5714@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 18 Apr 2013 14:00:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A83A70C-A854-11E2-90A0-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221680>

Jeff King <peff@peff.net> writes:

> could work for both cases. Something like "not considering" (or another
> synonym for "considering") might be even more accurate. It is not just
> that we did not stage it; it is what we did not even consider it an item
> for staging under the current rules.

Yes, "not considering" is much more sensible, while side-stepping
the dryrun issue.  Or

       warning("ignoring removal of '%s'")

> Note that the "not staging" warnings may potentially be interspersed
> with the normal dry-run output. I think that's OK.

As long as the top-text makes it clear what "not considering" (or
"ignoring") in the following text means, I think it is fine.

But I think we are doing users a disservice by listing tons of
paths.  Where the difference of versions matters _most_ is when the
user has tons of removed paths in the working tree.  Either with one
warning per path, or a block of collected paths at the end, we are
scrolling the more important part of the message up.

That was why I originally showed one path as an example and stopped
there.  Perhaps it is a better solution to keep that behaviour and
rephrase the message to say that we ignored removal of paths like
this one '%s' you lost from the working tree but it will change in
Git 2.0 and you will better learn to use the --no-all option now.

The inter-topic conflicts between stages of three "add in Git 2.0"
topics is getting cumbersome even with the help from rerere, so I'd
like to merge their preparatory steps as I have them now to 'next'
and merge them down to 'master' first, and start applying tweaks
from there, or something.
