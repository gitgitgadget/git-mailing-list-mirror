From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 08:01:14 -0700
Message-ID: <86zm33291h.fsf@blue.stonehenge.com>
References: <18031.64456.948230.375333@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyULV-0006NM-32
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757667AbXFMPBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756619AbXFMPBP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:01:15 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:29936 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbXFMPBP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:01:15 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id B4B721DEAE8; Wed, 13 Jun 2007 08:01:14 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.7.2; tzolkin = 1 Ik; haab = 10 Zotz
In-Reply-To: <18031.64456.948230.375333@lisa.zopyra.com> (Bill Lear's message of "Wed, 13 Jun 2007 09:14:32 -0500")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50070>

>>>>> "Bill" == Bill Lear <rael@zopyra.com> writes:

Bill> We have some CVS users who complain that they cannot do a pull
Bill> into a dirty working tree, as they could under CVS.  Here is
Bill> their scenario: they make a few changes to their code and want
Bill> to test it out; someone else pushes changes to the central repo
Bill> that they then want to add to their working tree to test also;
Bill> they then want to pull in these changes and test everything, as
Bill> if they had done 'mv stuff stuff-; git pull; mv stuff- stuff'.

Bill> They would like an option (perhaps a config option) to do a "dirty
Bill> pull".

Maybe this will do it, presuming they haven't published any of their local
work, and they're on a topic branch "topic"

git-tag WIP # mark HEAD so we can come back
git-commit -a -m WIP # commit current work so we can replay it
git-fetch origin # grabs the upstream
git-rebase origin # rebase current work-in-progress onto new upstream
# might need to resolve and commit conflicts repeatedly
git-reset --soft WIP # next commit will be on top of commit prior to rebase
git-reset # mark all files as uncommitted as yet
git-tag -d WIP # no more need for this tag

This effectively puts the upstream changes "under" (or "prior to") the current
topic branch.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
