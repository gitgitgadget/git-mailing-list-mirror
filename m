From: Junio C Hamano <gitster@pobox.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Wed, 25 Jun 2008 15:13:15 -0700
Message-ID: <7viqvxxix0.fsf@gitster.siamese.dyndns.org>
References: <willow-jeske-01l6XqjOFEDjC=91jv>
 <willow-jeske-01l6@3PlFEDjCVAh-01l6XqjPFEDjCY6P>
 <1784.50359167091$1214430241@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Tso" <tytso@mit.edu>, git@vger.kernel.org
To: "David Jeske" <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 00:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBdFz-00038T-9T
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 00:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYFYWNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYFYWNa
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 18:13:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59853 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbYFYWN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 18:13:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 47F1E962D;
	Wed, 25 Jun 2008 18:13:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 892C0962C; Wed, 25 Jun 2008 18:13:22 -0400 (EDT)
In-Reply-To: <1784.50359167091$1214430241@news.gmane.org> (David Jeske's
 message of "Wed, 25 Jun 2008 21:34:16 -0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF7BD71A-4303-11DD-98EE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86358>

"David Jeske" <jeske@willowmail.com> writes:

>> : "ncvs up" ->
>> :
>> : git stash; git pull; git apply;

First of all, if you are in CVS mindset, you may not want to necessarily
do "git pull", but "git fetch" followed by "git rebase".

I suspect the last one in the above sequence of yours is "git stash pop".
Definitely not "git apply" without any argument which is a no-op.

>> : git diff --stat <baseof:current branch> - un-pushed filenames

"git diff [--options] origin..." (three-dots) is often used.  This is a
shorthand for:

	git diff [--options] $(git merge-base origin HEAD) HEAD

that is, "show me what I did since I forked from origin".

>> : git-show-branch <current branch> - un-pushed comments

This would be useful if you are using "fetch + rebase", but in any case

	git log --graph --pretty=oneline origin..

may be prettier these days.  --graph is a recent invention that appeared
first in 1.5.6.

> Question: How do I create a branch on a remote repo when I'm on
> my local machine, without sshing to it?

I hope that the question is not "How do I do anything on a remote without
having any network connection to it" as its answer cannot be anything but
"telepathy".
