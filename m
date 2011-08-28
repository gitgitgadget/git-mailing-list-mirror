From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: git project patch workflow
Date: Sun, 28 Aug 2011 17:50:26 +0200
Message-ID: <4E5A63C2.5010207@alum.mit.edu>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu> <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu> <4E58710B.60507@alum.mit.edu> <7vty92adv0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cmn@elego.de,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 17:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxhiI-0001tJ-IV
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 17:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab1H1Puz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 11:50:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41838 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab1H1Pux (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 11:50:53 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEA689.dip.t-dialin.net [84.190.166.137])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p7SFoQhV001927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Aug 2011 17:50:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.20) Gecko/20110805 Lightning/1.0b2 Thunderbird/3.1.12
In-Reply-To: <7vty92adv0.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180278>

On 08/27/2011 08:30 PM, Junio C Hamano wrote:
> It sometimes gets frustrating to see a re-rolled submission that ignores
> the fix-ups to messages and patches I make locally before queued to 'pu'.
> 
> It is easy for me to say that they should fetch 'pu' to see what is queued
> before resubmitting [...]

I usually try to do this, but it is awkward (or maybe I am doing it
wrong).  If I run git fetch and notice that one of the upstream branches
was updated, then I still have to do a semi-manual step to see whether
any of the new commits are from a patch series that I submitted,
possibly which version of the patch series they are from, and whether
the patch or commit message was edited by you.  Sometimes it is not even
clear which branch you will choose to apply a patch series to (maint vs
master).  Contrast that, for example, with the ease of determining in
github whether a patch series has made it upstream.

In this particular case your email mentioned your code improvement, and
I obviously checked that your change made sense and squashed it onto my
own patch.  But your email didn't mention your changes to the commit
message, so I did not think to look for any.  Given that we, the
unwashed masses, have to transact all of our git patches through the
mailing list, I naively assumed that you would also mention your changes
on the mailing list.

I am amazed at the volume, quality, promptness, and patience of your
feedback (thanks!) and we should all bend over backwards to make your
life easier even at the expense of some extra work for ourselves.  Junio
doesn't scale :-)  So my suggestions below should only be considered if
they do not increase your bureaucratic work at the expense of your
technical work.

> [...] but I've been wondering if there is a better way to
> communicate back such differences, so that submitters can easily sanity
> check to see if my fix-ups are sensible, and to ensure that the re-rolled
> patches do not discard them by mistake before submitting.
> 
> I could post what are queued in new topics back to the list as part of
> ack, but that would make the list too noisy to read.

I personally would find it helpful if you would mention any changes that
you made in an acknowledgment email.  Ideally, the email would also
mention the branch name that you have chosen for the feature branch, to
make it easier to grep for the commit in your repo where it was merged
into pu and in your "What's cooking" messages.  In your case it would be
enough to *mention* that you made a change because we can see the change
itself in your repo.  I wouldn't worry too much about mailing list
traffic, because the acknowledgement would presumably be in the same
thread as the original patch series and thus easily ignorable by people
who are not interested in the subject.


Taking a step back, the real irony is that the git project hardly use
the distributed features of git *for the development of git itself*.  I
was flabbergasted when I first realized that fact.  Why is that?  It
seems that the kind of fork/pull request/merge workflow that github
makes so easy would be more convenient (and if not, the dogfooding would
force us to *make* it more convenient).  I personally found it vastly
easier to contribute my first patch to a github-based project than to git.

What would it take to make a git-centered workflow meet all of the
requirements that are satisfied by the mailing-list centered workflow
that is used currently?

ISTM that if there were a pull request procedure that automatically sent
PATCH emails to the mailing list for review (including the
non-log-message comments), then we would already be 95% of the way
there.  The goal would be to make git the definitive store of
information, and the patch emails a side-product.  That's the real
reason I started the thread "'git format-patch' should get more
information out of git": if all necessary information were in git then
there would be no need for all changes to be serialized through the
mailing list.

1. Author creates v1 of patch series
2. Author pushes changes to any publicly-visible git repo, including
non-log-message comments as notes
3. Author creates v1 tag and submits pull request, which results in
emails being sent to the mailing list as now (but with links to the git
repo and tag containing the patches)
4. Reviewers submit feedback via the mailing list.  They can either work
directly with the patch emails or can fetch the patches directly from
the author.  The feedback is handled informally as now, but might
include links to changed versions in their own public repo).
5. Author responds to feedback via the mailing list as now.  Goto 1 if
needed, creating tags for v2, v3 etc. of the patch series.
6. When satisfied, maintainer pulls branch to shared repo.  *The
author's commits retain their SHA1s.*

Pie in the sky?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
