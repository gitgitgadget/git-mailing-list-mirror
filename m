From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Fri, 12 Apr 2013 15:14:46 -0700
Message-ID: <7v4nfbcs6h.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org>
 <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?Q?Ngu?= =?utf-8?Q?y=E1=BB=85n?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 13 00:15:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQmFH-0005RN-7p
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 00:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab3DLWOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 18:14:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875Ab3DLWOt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 18:14:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90EC716360;
	Fri, 12 Apr 2013 22:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IoXMEIy4GKqyzalbg2K/L/Pt9yc=; b=DWjWvuI5Ze5aDC22bxWr
	xydN6CCd0e+iAJahOvIYEUt4d4dXnD3J/sO0ZZcuMaMP4pEXkQ3klAkYw38xAfuZ
	BeA71SfYXwEU/B9gfdiQ02nkgmzs7KxBXZhTm0WpYFF4K5fXIjpNix9jpWP8jDxn
	F/6hD5l5WW+dc+9xtD0BZEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Myk7o9tJBoTSsu/9vqEjH9pGbWOXcWxjrZQmOIhPxlzYxD
	7eDXqJOvPwLzrv6qbEQEUWh7tz3uKXqXwKwSMWj8Nd+Hd/glVHYOlm+aKp/WxsOp
	fZpUIqKYtqBE6oYXqEvSUnaz7YAZbSYy+nZ60nTWrlH388anCJZTwRtX8IjS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 883051635F;
	Fri, 12 Apr 2013 22:14:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 091F91635D; Fri, 12 Apr
 2013 22:14:47 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6359C6FE-A3BE-11E2-9E1E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221031>

Jeff King <peff@peff.net> writes:

> Which is still kind of weird, because why should the branch you are on
> affect the default push location? But that is how default "matching" has
> always behaved, and we would remain consistent with that.

I agree that what makes us behave "kind of weird" is that the
current branch is used to look up branch.$name.{remote,pushremote}
when pushing. I do not think "matching" [*1*] has anything to do
with it.

The per-branch configuration, branch.$name.{remote,pushremote}, says
"this branch interacts with a remote that is different from what I
normally interact with".

It is excusable for branch.$name.remote to take the current branch
into account, when it is used to govern the fetch-integrate side
(i.e.  not used as a fall-back for branch.$name.pushremote).  In
order to affect that configured local branch, e.g. "git pull" to
merge other's work, you need to have that named branch checked out
in your working tree.  Triggering the effect of the configuration
based on which branch is checked out makes more sense because of
that reason when you are fetching.

It does not make much sense to use the current branch as the key to
look it up when you are pushing things out. If anything, what is
being pushed out should be what determines where it goes.

But that is a realization that comes after you think the issue long
and hard enough. To a casual end user, I think it is an equally or
even more natural expectation a "git push" would pick the destination
based on what branch you are currently on, as that is what happens
when he runs the command without any argument.


[Footnote]

*1* The "matching" semantics is to support the workflow for people
who batch things up. You perfect _all_ your branches that matter to
the public, and push all of them in one go. If you do not finish a
work on one branch and push out when other branches are not yet
ready, you do not want your push to be limited to the current
branch. And you do not have to "configure" what branches should be
visible to the public. Instead, you have _your_ remote remember it
for you: what are already there are the ones that are updated.

The "current", "upstream", etc. are to support folks who want to
push work done on a single branch out as soon as it is done, even
though the other branches are in no shape to be pushed out.
