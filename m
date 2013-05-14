From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 14:59:09 -0700
Message-ID: <7vzjvxfck2.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:59:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNFd-0001lU-U5
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286Ab3ENV7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:59:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758059Ab3ENV7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:59:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19FB61F768;
	Tue, 14 May 2013 21:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=1WmSE33qBOmwoxdT20pMKGXFA10=; b=E32HSWaUJ8PxPHS3zYBX
	J58zEUBBLQSVmFF4E6nSwE3+m+KUxO1T5QtaGYthrQ4Lg9oLBuL6iJoekWo2eUQV
	5LR1FPgE5K9YFLffbx1R8ey7DgLxB/xGhsrd8lHq1J2//Q+o6I2sh+60ZrJ2wH+E
	NKwt04VDGuZFDwXR2+I1oLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bzms9NXjy2osQmGW4q1o423P8+p+xI4WeW8WUaegTH44a1
	dYoX1MEleaxeUVPD2PHiMf3JzK0onwsecfme8VeiEHFl+iIp/sdttOBh9eikeGtz
	hnaCyQYv4zeScv6wOajTbDkJfFYvEtmPA0EPC1TNpByJpKPxLJ1WMwQLGF9m0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114F21F767;
	Tue, 14 May 2013 21:59:12 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7097B1F765;
	Tue, 14 May 2013 21:59:11 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8253F5D4-BCE1-11E2-A2B1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224353>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Without this fix, the user would never ever see new bookmarks, only the ones
> that (s)he initially cloned.

Now, think again and realize how long it took you (the original
author) to discover issues and come up with these fixes and
explanation since the series was merged before -rc0.

Are we giving the users enough time to discover and complain issues
that these 10 patches may introduce before the final release?  "You
can see these patches are so trivially correct" is not a valid
argument. The original patches would also have been looked correct
when they were sent to the list. Things take time and actual use by
the users to mature.

Having said that, the impression I am getting is that whatever we
pushed out in 1.8.2 and 1.8.3-rc0 was far from ready for real use,
and with your explanations (by the way, I found that many of them
deserve to be in the log message), the end result of applying these
patches, up to 8/10, will still not be as it is very likely that you
and users will discover issues at a similar rate, but at least it
will be much closer to be ready than they currently are.

In other words, it still seems to be in "something is better than
nothing, newer is better than older" stage before stabilization.

And that is to be expected for a contrib/ material; nothing for us
to be ashamed of.  So I changed my mind.  As long as it is clearly
marked as "still experimental, possibly with rough edges", I think
it is better to ship 1.8.3 with these 8 patches than without.

I am unhappy with 3/10, though.  It is spreading existing mistake by
adding another configuration variable with dash in its name, which
goes against the recommended practice, and making it more cumbersome
to eventually fix them, because we would need to break end user's
configuration.

Things like 1/10 and 2/10 that can be characterized as:

> This is a trivial cleanup, cannot cause regressions.

may probably be a good clean-up to build the next development cycle
on top, but are not at all urgent for it to deserve to be included
in the upcoming release.  But it seems that 3-8 textually depend on
at least 2, so I'll queue the first eight for 1.8.3 and exclude the
rest for now.  If these are identical to the early part of the
47-patch series (I didn't check; they are for the next cycle), it
would make the next cycle shorter by 8 patches.
