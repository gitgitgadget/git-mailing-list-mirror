From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Wed, 25 Jun 2008 11:57:59 +0300
Message-ID: <48620897.5040708@panasas.com>
References: <jeske@willow=01l5V7waFEDjChmh>	<willow-jeske-01l5PFjPFEDjCfzf-01l5V7wbFEDjCX7V>	<willow-jeske-01l5cKsCFEDjC=91MX> <48612ABE.6000104@panasas.com>	<48612CB0.2070303@panasas.com> <m31w2mlki4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Jeske <jeske@google.com>, git@vger.kernel.org,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:00:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBQrG-0007as-RA
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbYFYI7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 04:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbYFYI7N
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 04:59:13 -0400
Received: from gw-colo-pa.panasas.com ([66.238.117.130]:6814 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753947AbYFYI7L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 04:59:11 -0400
Received: from daytona.int.panasas.com (daytona.int.panasas.com [172.17.28.41])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id m5P8wKSI023538;
	Wed, 25 Jun 2008 04:58:21 -0400
Received: from bh-buildlin2.bhalevy.com ([172.17.28.123]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Jun 2008 04:58:05 -0400
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <m31w2mlki4.fsf@localhost.localdomain>
X-OriginalArrivalTime: 25 Jun 2008 08:58:05.0800 (UTC) FILETIME=[9500DE80:01C8D6A1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86256>

Jakub Narebski wrote:
> Boaz Harrosh <bharrosh@panasas.com> writes:
> 
> 
>> Sorry
>> git-reset --clean -f/-n for removing local changes
>> git reset --hard for moving HEAD on a clean tree only
> 
> Wouldn't "git reset <commit-ish>" be enough then?  It modifies where
> current branch points to (as opposed to git-checkout modifying what is
> the current branch), and it modifies index.  What it doesn't modify is
> working directory, but it is clean already.
> 

Does not work. only --hard will do the job. The working directory is not
touched and if you'll do a git-diff you'll see the diff between old-head
to new-head. But what I want is to start-hack or merge on new-head.

> So the solution is: don't use `--hard'.
> 

the closest to git reset --hard that I can think of is:

Lets say I have
$ git-branch -a
* mybranch
remote/master

I can
$ git reset --hard remote/master
Or I can
$ git-checkout -b temp_mybranch remote/master
$ git-branch -M temp_mybranch mybranch

The second will complain if I have local changes.
I have just written 2 scripts. One "git-reset" that
will filter out --hard before calling the original.
Second "git-reset--hard" that will do the above.

Stupid me no more. It will not happen to me again.
Just those poor new users out there, I guess you have to
fall off your bike at least once.

Boaz
