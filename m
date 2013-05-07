From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Make "$remote/$branch" work with unconventional refspecs
Date: Mon, 06 May 2013 19:11:56 -0700
Message-ID: <7vip2vo7wz.fsf@alter.siamese.dyndns.org>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
	<7vr4hmuk20.fsf@alter.siamese.dyndns.org>
	<CALKQrgdp9DVDBLNwCAmQHbEfZDvhdsmSW3sh1BRo1XEnyqPPaA@mail.gmail.com>
	<7v8v3tuu6i.fsf@alter.siamese.dyndns.org>
	<CALKQrgf6NcT2tEGMTczxR2WspOi4NjrN_kxmKN-QyE2Py3iSaQ@mail.gmail.com>
	<7vhaigrqay.fsf@alter.siamese.dyndns.org>
	<CALKQrgeegzzJ-2QNvdmeeugS0Aw7jrE4SM8S7zk+qPdfgRCMyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 07 04:12:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXNu-0008So-Kp
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757764Ab3EGCMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:12:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757356Ab3EGCL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:11:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54100135BC;
	Tue,  7 May 2013 02:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UrXYRJCO6WAFtbY0yphnjkFHr5I=; b=Z7+eB8
	ZsUOkDJ4FlisyyYTBuhYoCIT2DgnJ6sBwxg2kyKjnywz/JlkGM6EiIIVgar0RWY1
	Mx761AbhBxmLBUVGvKDWitfFrDTGee5hbEVyImTliI85JXDg19QZhV9acX9KsHO+
	chK+0dCfOp3wy3kRETKCSsW26EEi03aJV2yoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r60fpa07iRh3/nMH4JYMIouAnwCq61b8
	FzODyNZeoQO6fCCzkaQsSDxi/tNq0JGE021Iwa346VGB0bVpRw+LY7ec+jv7bHM7
	fsxX935T4+ex4jEO2qxb2+BNs55xdJmsJ7ulhJRR2XYnxqxr3JRbu1QpXeqqInbh
	GIQTsWFAkZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 457FA135BA;
	Tue,  7 May 2013 02:11:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8980A135B7;
	Tue,  7 May 2013 02:11:58 +0000 (UTC)
In-Reply-To: <CALKQrgeegzzJ-2QNvdmeeugS0Aw7jrE4SM8S7zk+qPdfgRCMyg@mail.gmail.com>
	(Johan Herland's message of "Tue, 7 May 2013 01:42:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F518B70-B6BB-11E2-92FD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223523>

Johan Herland <johan@herland.net> writes:

> Ok, so whereas I consider the refspec to be "king", and that the expansion
> from convenient shorthands to full remote-tracking refnames should be
> derived from the chosen refspec, you would (if I understand you correctly)
> rather have a constant (i.e. independent of remotes and refspecs) set of
> rules for expanding shorthands to full refnames, and if the user chooses
> refspecs that don't mesh well with those rules, then that is the user's
> problem, and not Git's.

You need to dig your rhetoric from the other end of the tunnel.  I
would consider the local namespace for the refs to be the "king",
and we would design how they are resolved to be useful for user's
local usage pattern.  How the remote refs are copied by fetch
following refspecs is one of the many components (e.g. the dwimming
machinery "checkout foo" uses to guess that the user may want to
fork from and integrate later with one of the refs under refs/remotes
is one of them and it is not "fetch") to complement the refname
resolution rule to support the local usage of refs.

> In light of this, I'm interested in your thoughts about the following
> related problem that I've just started looking at:
>
> git branch -r shows the remote-tracking branches in this repo. Currently,
> .... Should we add a heuristic for detecting when
> to use refs/remotes/* vs. refs/remotes/*/heads/* as a filter?

Didn't I already said that I do not think repurposing refs/remotes/
for these "unified" copies is the best approach?

A change that I think is a good thing to add on top of your [45]/7
refactoring is to allow the user to add custom expansion/contraction
rules.  Then the user can group refs regardless of "remotes" and
give meaningful shortening.

As I said in a very early review, viewing "fetch refspec" to be
"king" and refspecs are the only way the user may want to group
things locally is myopic.  The every-day usage of the local names
ought to be the king, and everything else should serve to make it
easier to use.
