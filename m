From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/15] fetch --tags: fetch tags *in addition to* other stuff
Date: Mon, 28 Oct 2013 12:10:04 -0700
Message-ID: <xmqqa9htfbzn.fsf@gitster.dls.corp.google.com>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
	<1382543448-2586-11-git-send-email-mhagger@alum.mit.edu>
	<xmqqob6emlxu.fsf@gitster.dls.corp.google.com>
	<526A896D.7050801@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Mon Oct 28 20:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VasCd-0006AI-2Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756055Ab3J1TKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 15:10:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab3J1TKI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:10:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81CE44EB85;
	Mon, 28 Oct 2013 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=de4396ZGmiTLaXZ02i6U/inANcI=; b=FQZAK36rzy6el6Dh4vid
	pMd4Dy+8LJNq6m3Ssd8vVG42teQdcHXRs+NV106LE4hW7WP1yy7DHZJyLmPpSrTl
	CupykCN8TPa93bkS5MKfytvH6q8e9aIX8aVIKp7IavVKyU0IECsq4qFfKhwPaLiO
	K0Xa+Viyvi7av6//UICoTgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=hQ4x5IrktIU37lP8DcHrj6i0LsHCDWPyskx7MDYYSFLmm0
	ydzuvBNgc2LQEi7p+VEu51ZadNMYIRGNG9R+BunKe1TwNPGdiozmEwrWKoCN0zA2
	Fofk9FQOoM9AJ3BFYR6Nzzypja69AhlOoWUhdO4wRKaEuKTrzdAlC6ltw5d0I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 737E84EB84;
	Mon, 28 Oct 2013 19:10:07 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 449C84EB80;
	Mon, 28 Oct 2013 19:10:06 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8E5C1F4A-4004-11E3-86AA-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236848>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> True but when fetching other references, tags relevant to the
>> history being fetched by default should automatically follow, so the
>> above explains why "fetch --tags" is not a useful thing to do daily.
>
> Maybe not necessary in many scenarios, but is it harmful for the common
> case of cloning from and then periodically fetching from an upstream?

There is no mention of "harmful"; I only said "not useful". And it
comes primarily from knowing why "--tags" was introduced in the
first place; I should have said "less useful than before, ever since
we started to reliably auto-follow".

The only "harmful" part is its interaction with "--prune", which
your series nicely addresses.

> ISTM that the result of the declarative --tags option
>
>     we have all upstream tags
>
> is easier to reason about than the history-dependent tag-following behavior

I'd say "we have all the relevant tags" and "we have all the tags
the other side has" are equally valid things to wish for, depending
who you are and how your project is organized, and one is not
necessarily easy/useful than the other.  In case it was unclear, I
was not seriously advocating to deprecate/remove "--tags".

> Regarding your first point: if it matters which of the duplicates is
> chosen, then it can only matter because they differ in some other way
> than their reference names, for example in their flags.  So a robust way
> of de-duping them (if it is possible) would be to compare the two
> records and decide which one should take precedence based on this other
> information rather than based on which one happened to come earlier in
> the list.  Then the list order would be immaterial and (for example) it
> wouldn't be a problem to reorder the items.

But that changes the behaviour to those who has cared to rely on the
ordering.  With the change to first collect and then sort unstably
before deduping, the series already tells them not to rely on the
order, and two of us tentatively agreed in this discussion that it
is not likely to matter.  If later this agreement turns out to be a
mistake and there are people who *do* rely on the ordering, the only
acceptable fix for them is by making sure we restore the "first one
trumps" semantics, not by defining an alternative, arguably better,
behaviour---that is not a regression fix.

In any case, thanks for working on this topic.
