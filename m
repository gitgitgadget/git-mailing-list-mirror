From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 05 Mar 2013 11:17:11 -0800
Message-ID: <7v6215u05k.fsf@alter.siamese.dyndns.org>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
 <20130305082204.GB13552@sigill.intra.peff.net>
 <5135DBE5.6080909@alum.mit.edu>
 <20130305182255.GB10928@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 05 20:17:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCxMy-0006P1-DD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 20:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759112Ab3CETRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 14:17:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756925Ab3CETRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 14:17:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 478A4BEA4;
	Tue,  5 Mar 2013 14:17:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bh8ZWqILcwoHIoycCGExmhNVJvY=; b=SP9VXz
	ee3TIIh0H99Irj1qxouZurDugWaRej0yq5ltBhrl3GiRF83yKNLe8FMFDNUrfnoR
	3Smuz2Nz0j0ey+AcF+IdzEyoVKA3xKWOh4aKLwsyKT35Vb1dKwY6eSHVFt65WBg1
	2RmGx/68X/HqpFlV7DGlHCDavXmRLSdMib/KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bDZPsij3eu8/8vXBXR7ht/S/3VL1jJnO
	BxbPCQQw34XWpbiGRcBKF81q90J1735XM5yAUrW+BZt7UqhMFZsiLE5+BV/5ZHsC
	yRsgJkHUqNJE9UFd1mYBqs+aIbqZsmYwfp3cCT1cRSH6qXjaml5fCrmHUkRwvSHb
	Z0K+7xcMTzE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BC30BEA3;
	Tue,  5 Mar 2013 14:17:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 852EFBEA0; Tue,  5 Mar 2013
 14:17:12 -0500 (EST)
In-Reply-To: <20130305182255.GB10928@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Mar 2013 13:22:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 487BE0C8-85C9-11E2-8A1A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217475>

Jeff King <peff@peff.net> writes:

> Yeah, I think that is another sensible variant. It does not really
> "backfill" in the way that Junio's patch does (e.g., if you forgot to
> push out v1.6 to a remote 2 weeks ago and now you are pushing out v1.7,
> Junio's patch will magically fill it in).

I may have tentatively tagged the tip of 'master' as v1.8.2 in my
private repository, started the integration testing, but may not be
confident enough to push out the branch nor the tag yet.  I may have
an experimental topic that I want to share with others before I am
done with the release to unblock them, and the topic may build on
the 'master' I may or may not want to redo before the release.

I can do so with "git push github jc/topic" (no --follow-tags).
After doing such a "you may want to start with this" push, I can
continue working on the release, and the 'master' branch may turn
out to be good to go without redoing.

A later "git push github --follow-tags master" in such a case should
send v1.8.2 out.  It is inexcuable to break it, saying "Oh, I've
seen that commit already---it is part of the previous update to
jc/topic".  That defeats the whole point of --follow-tags.

The other "tags at the tip" is slightly less problematic than
"ignore the commits the receiving end has already seen", but it will
break if I tag the tip of 'maint' as v1.8.1.6, continue working
without being able to push perhaps due to network disruption, and
have already started building towards v1.8.1.7 when the network
comes back.  'maint' may be past v1.8.1.6 and its tip won't be
pointing at that tag, but it still is missing from the public
repository.

While I agree with your goal to make it safer to use "push", both
"ignore commits that the receiving end already saw" and "only look
at the commits at the tip being sent" castrate the option too much
to the point that it is meaningless.  The whole point of asking
explicitly with the "--follow-tags" option to "push" to push out
relevant tags is, eh, to push out relevant tags.  I do not think it
is magical at all.  "backfill" is an integral part of the option.
