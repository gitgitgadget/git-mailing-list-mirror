From: "David Jeske" <jeske@willowmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 20:45:20 -0000
Message-ID: <28623.5624961138$1214599725@news.gmane.org>
References: <9b3e2dc20806271331l2870ef94o4cd413ee40ab0d39@mail.gmail.com>
	<willow-jeske-01l7H4tHFEDjCgPV-01l7ZhB8FEDjCdJs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 22:48:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCKrj-00020q-TX
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 22:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbYF0UrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 16:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYF0UrX
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 16:47:23 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33085 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751490AbYF0UrW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 16:47:22 -0400
Received: (qmail 28388 invoked by uid 90); 27 Jun 2008 20:47:17 -0000
X-Mailer: Willow v0.02
Received: from 72.14.229.81 at Fri, 27 Jun 2008 20:45:20 -0000
In-Reply-To: <9b3e2dc20806271331l2870ef94o4cd413ee40ab0d39@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86630>

-- Stephen Sinclair wrote:
> However, having gotten used to the git way of things, I
> personally don't see the problem with allowing
> bad commits, as long as they are not pushed to public.
Of course developers need to be able to make bad-commits. If they can't, we
quickly end up back in the "don't checkin" mentality of CVS. I want to be able
to do bad-commits. Further, I recognize that even with the best of intentions
bad-commits will enter the mainline. What I think is missing is a mechanism for
re-summarizing a set of committs that does not rely on the fact that they've
never been published. See my other email on "supercede"..

Consider a big public tree that is using bisect, but discovers that there is a
bad commit in the mainline. I have no idea what you would do with current git
to fix this. However, if I could pick two endpoints and "supercede" them, I
would have a bunch of options:

- I could supercede 2-commits with 1, effectively making the bad-commit
disappear in the linear history. Users who already have the history, however,
would be unaffected, because the start/end endpoints are the same.

- I could supercede 2-commits with two different commits, one that makes the
test pass correctly, and one that trues-it-up with the next patch, that somehow
made all the tests pass correctly again. (possibly by hoisting a diff out of
the 2nd commit that actually fixed the first issue)

While repairing an old test build problem may seem like an infrequent issue,
this mechanism has a much more frequent and more important benefit... which is
that people can share changes and then later rebase them -- and others who have
a copy of that branch will receive automatic merge/rebase support. (assuming
there are not reasons for conflict)
