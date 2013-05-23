From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 09:01:15 -0700
Message-ID: <7vd2shheic.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 23 18:01:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfXxE-00084Y-1M
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 18:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759240Ab3EWQBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 12:01:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758360Ab3EWQBT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 12:01:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5279D2191D;
	Thu, 23 May 2013 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0cKVFbvzumcOWw1uwEuNRsgQRU0=; b=o8YJuM
	/ZZ8eR+E+9S8FPZH+ffb+YYgvLrAPR7pplYI+ZLD7DeSXbTFbVSARW38ea04AG0V
	mee6Sgk4sczVC+qq/zqmh459tsG9PIbcDVvKQpHwKzqOhnCCfaMS8wwpEKJpc26z
	4pCrVVdtpvuc18uFCwjg9cpC5cWF3/+x3YdTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nPh93XWMxJ3CbU6VifklliDQvFRd18pj
	3UrY0kH4xBbXrmy0sWTaWrlADFKPpngn80FojiajRAjEtrzhIoo3ARzzQeI85ALo
	49VNhiRGO+1YtSsc8gGv09FEeVQc5usgUf9uRo9mcS9BzmnLNPJNJXZPU4lzPNOc
	EaI/B2PG+xY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DFE2191C;
	Thu, 23 May 2013 16:01:18 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 813342191A;
	Thu, 23 May 2013 16:01:17 +0000 (UTC)
In-Reply-To: <20130523110839.GT27005@serenity.lan> (John Keeping's message of
	"Thu, 23 May 2013 12:08:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0094FFCE-C3C2-11E2-9AE7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225264>

John Keeping <john@keeping.me.uk> writes:

> I've been annoyed by this at $DAYJOB recently.  A lot of people seem to
> blindly "git pull" without much thought about how the history is ending
> up and what they actually want to do.

I think these two are essentially the same thing, and having an
option to flip the heads of a merge only solves a half of the
problem.

A merge that shows everybody else's work merged into your history
means you are the integrator, the keeper of the main history.  And
the first-parent view of the history is useful only when the keeper
of the main history takes good care of the main history.

When you are using a "central shared repository" workflow, if you
had and used an option to flip the heads of a merge to record what
you have done so far as a side branch of what everybody else did to
do the merge, or if you rebased your work on top of what everybody
else did, the first-parent view would make a bit more sense than
what you currently get.  At least, everybody else's work will not
appear as a side branch that does 47 unrelated things, and your work
will appear as a side branch.  That is a big plus.

But the other half of the problem still remains, i.e. "what they
actually want to do".  People tend to do too many "pull" when their
work is not ready, only to "catch up", and that is the real problem.

Instead of having a nice "these six commits marked as 'x' were done
on a branch forked some time ago, to address only this one issue and
to address it fully" history that explains how these commits were
related and these commits are the full solution to a single issue:

      x---x---x---x---x---x
     /                     \
 ---o---o---o---o---o---o---M---o---o---...

they end up with something like this, even with the "flip the heads
of a merge" option, by pulling too often:

      x---x   x---x---x   x
     /     \ /         \ / \
 ---o---o---M---o---o---M---M---o---o---...

The result fragments otherwise a logical and clean "single strand of
pearls to fully address the issue, consisting of 6 commits", into
separate and seemingly unrelated pieces.

Imagine that other people are working the same way, and the commits
marked with 'o' are merges of side branches they add their half-way
work to the main history similar to what happened in the second
illustration above.  You would get this history:

      x---x   x---x---x   x
     /     \ /         \ / \
 ---o---o---M---o---M---M---M---o---o---...
             \     /
              y---y 

Nothing, other than the labels I used in the picture, ties these
'x's together while differentiating them from 'y's, so you lost an
important information.  Unless people stop doing that too many
"pull"s that are used only to "catch up", even with the "flip the
heads of a merge" option, you will not get a history that yields a
good first-parent view.

That gets back to what I said in the second paragraph of this
message.  When you "pull" from the central shared repository, with
the "flip the heads of a merge" option, you are acting as the keeper
of the main history at that point, and you are responsible for
taking good care of it.  If you make a 2+3+1=6 mess as depicted in
the last illustration above, you are failing to do so.

One obvious way to solve it is to use a topic branch workflow (the
first picture above; 'x's are built not on local 'master'), and you
do a "git pull" from the shared repository while you are on your
'master', which is free of your 'x's until that 6-commit series is
complete and ready.  Then you locally merge that topic branch and
push it back for everybody to see, which will give you the first
picture in this message.  Incidentally, this does not need the "flip
the heads" option.

Solving half a problem is better than solving no problem, and
especially because not all changes need to be multi-commit series
but can be done directly, perfectly and fully on the local 'master'
(i.e. 2+3+1=6 split would not happen for such changes).  For these
reasons, I personally am not strongly opposed to a "flip the heads"
option, if implemented cleanly.

But people need to realize that it is not solving the other half, a
more fundamental problem some people have in their workflow.
