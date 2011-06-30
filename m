From: Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-next: manual merge of the security-testing tree with the
 tree
Date: Thu, 30 Jun 2011 11:52:17 -0700
Message-ID: <7v4o37qhi6.fsf@alter.siamese.dyndns.org>
References: <20110630142910.2fea4257.sfr@canb.auug.org.au>
 <20110630072559.GA4048@pengutronix.de>
 <20110630193023.6056d48e.sfr@canb.auug.org.au>
 <20110630121710.GJ11559@pengutronix.de>
 <BANLkTi=usrsF60Popfu55v3_dXe7Yo0GrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	James Morris <jmorris@namei.org>, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 30 20:52:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcMLj-0004TY-OV
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 20:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646Ab1F3SwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 14:52:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1F3SwU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 14:52:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 736C16A22;
	Thu, 30 Jun 2011 14:54:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y7rMDB6PfFnyWDyVsZXC17iJ5RM=; b=hc8V7a
	7m8EUWxOeQoDq+529OwDY1jxIzavlIhRG6VJUJVbDysG4CcBD0lhY/hxTF6QMmBA
	blmziqXnj/9IlcQOeXoEOUnVKtpLpKDQTcIlTV/Z+/Y/hwz6srn36RN+2vkonXIC
	/1gBAK8FmFiAR57JOXiLg6wAq9v0DVpsrHLN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HUsH0uKxINv3Ab4pIDwK+f4pEogWF1Dc
	A8a5YmzeOMmG2DiSdYnBjgcsgtmRYwl7chmhk/LYJ9wel0jja77ffVuEAWpqH74u
	+sZiSDHSbJ+wVwbRQKXs920XwXqCuStaREMebNTaXd8zKuWHgJfsieo0ikYu6ic3
	3hLKCqo68A8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B66D6A21;
	Thu, 30 Jun 2011 14:54:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A65BA6A20; Thu, 30 Jun 2011
 14:54:33 -0400 (EDT)
In-Reply-To: <BANLkTi=usrsF60Popfu55v3_dXe7Yo0GrA@mail.gmail.com> (Linus
 Torvalds's message of "Thu, 30 Jun 2011 09:20:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64ED36A2-A34A-11E0-A2E8-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176500>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It would be lovely if "git show" (and log operations) had some option
> to do a "expensive merge check" and did actually figure out the common
> ancestor and at least took that into account.
>
> It would be doable to do it at least better than we do now - the
> common ancestor is not cheap to compute, but it's much cheaper than a
> full merge, and would at least allow us to flag dangerous merges. Of
> course, it gets fun when there are multiple common ancestors and
> renames. It's entirely possible that it's never going to be practical
> to do anything but "re-do the merge and compare result".

I would have to say that it would boil down to "re-do the merge" whichever
way we implement it, and it is not necessarily a bad thing.  

There are ideas to implement a mode of "git merge" that works entirely
in-core without touching the working tree (it may have to write temporary
blobs and possibly trees to the object store, though). It would let sites
like github to let its users accept a trivial pull request that can merge
cleanly on site in the browser without necessarily having to have a local
checkout used for conflict resolution.

If such an "in-core merge" feature is implemented cleanly in a reusable
way, it would be just the matter of comparing the output from it with the
actual committed result.

Of course, if the committed result was deliberately made by "-s ours",
comparison between an auto-merge result and the committed result would
produce a lot of noise, but that is really the point of "expensie merge
check", so the noise in that scenario is a feature, not a bug.
