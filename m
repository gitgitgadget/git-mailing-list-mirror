From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 22:29:51 -0700
Message-ID: <7v8v56rcxc.fsf@alter.siamese.dyndns.org>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com> <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org> <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
 <7vfvzfwn55.fsf@alter.siamese.dyndns.org> <20130328160937.GD16034@leaf>
 <7vr4iztl3z.fsf@alter.siamese.dyndns.org>
 <20130328190344.GA5361@jtriplet-mobl1> <20130328192507.GS28148@google.com>
 <20130328235319.299cb494@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Fri Mar 29 06:30:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULRtP-0006lm-So
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 06:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212Ab3C2F3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 01:29:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab3C2F3y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 01:29:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2C60E845;
	Fri, 29 Mar 2013 05:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VV1q2ru0JB3icMwCILU+OhAjfDg=; b=K1syvK
	YSK5/btXzN6p5jsy+2ZGYVq1fR7IEEWu8MUoONZ9IFVGDRRm6e+4Su5sCptuPKWI
	L3LsOuT1AGcEb+hPpwmivpzkvJW/opgqtfe3/ripNxmVxIVNzIwwEbVpblG7t/Zs
	IKNwAuE0Hgktpc5oPoD04b0T1S1QWinb8a27U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dvh5x4IofevaKRKba8o9nOeAwhqvaZf6
	x+Zt20GfgEj/9MXqziipYXXExaYE6vaaWYs6TdUZOUmlpg5svS84Z6Uf38SzhGz5
	S1s7QpRTr2UKg7ctt0Kz4hxz0IT9+3LEL5KMVLFwgstSjbYLGCbNorXRn7Y7Lj/4
	dpKGKMjyPhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9FA6E843;
	Fri, 29 Mar 2013 05:29:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 055B5E841; Fri, 29 Mar 2013
 05:29:52 +0000 (UTC)
In-Reply-To: <20130328235319.299cb494@hoelz.ro> (Rob Hoelz's message of "Thu,
 28 Mar 2013 23:53:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEF05AF8-9831-11E2-AFF0-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219483>

Rob Hoelz <rob@hoelz.ro> writes:

> Honestly, if my workflow here is stupid and not "Git-like" and someone
> has a better suggestion, I would happy to let my patch go.  Using two
> remotes is an option, but to me, using this triangular setup is just
> easier.

I think you are conflating two unrelated things.

Pulling from one repository to integrate others' work with yours
(either by merging others' work to yours, or rebasing your work on
others'), and pushing the result of your work to another repository
to publish, i.e. triangular workflow, is no less "Git-like" than
pulling from and pushing to the same repository.  Both are valid
workflows, and Git supports them.

What is not correct in your set-up is that a single remote with URL
and pushURL (or rewritten URL derived from them via pushInsteadOf
and insteadOf) that point at two different repositories is *not* the
way to express that triangular configuration.  You name two remotes,
pull from one and push to the other.

If you look at Ram's "triangular workflows" series, cf.

    http://thread.gmane.org/gmane.comp.version-control.git/219387

you can see that a progress is being made to make the "two remotes"
configuration easier to use.

The discussion on the earliest iteration of the patch series, cf.

    http://thread.gmane.org/gmane.comp.version-control.git/215702

shows that even I initially made the same "pointing two different
repositories with URL and pushURL should be sufficient" mistake,
which was corrected by others.  The primary issue is "remote
tracking branches are designed to keep track of the state of the
branches at the named remote"---for this reason alone, you must not
name a logically different repository with URL and pushURL for a
single remote.

So that is one thing.  tl;dr: Triangular workflow is valid.  A
single remote with URL and pushURL to point at the two remote
repositories is not a valid way to express that workflow.

The other thing is if it is worth risking to break the backward
compatibility and hurting existing users in order to remove the
strange "To an explicit pushURL, insteadOf rewriting will not apply"
exception.

The reason I didn't bring up the possible breakage of "documented
behaviour" in the earlier review of this series is exactly because
that special case was unintuitive, so you do not have to argue it is
strange, unintuitive, and would not be a way we would have designed
the system if we knew better. I already agree to that point, and I
think others do, too.  There is a gap between "We would design it
differently if we were building it now with what we know" and "We
should change it and make it ideal" and the gap is called existing
users.

These two are unrelated and independent.

I suspect that Ram's "triangular" series, when it matures, will help
your "pull from there, push to another" workflow in a different way.
You will just define two remotes for these two places, and you may
no longer need "pushInsteadOf is not ignored when you have pushURL"
to solve your immediate issue.

But removing the "pushInsteadOf is ignored when explicit pushURL
exists" may still be a worthwhile thing to do, even if you do not
need it.
