From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Fri, 04 Jan 2008 21:21:10 +0100
Message-ID: <477E9536.6050401@redhat.com>
References: <20080104185926.GA11912@redhat.com> <alpine.LFD.1.00.0801041437190.2649@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 21:21:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAt3A-0005Do-MZ
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 21:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbYADUVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561AbYADUVY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 15:21:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34619 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555AbYADUVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 15:21:23 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m04KLCiK011318;
	Fri, 4 Jan 2008 15:21:12 -0500
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m04KLB0A029021;
	Fri, 4 Jan 2008 15:21:11 -0500
Received: from argon.maulnet (vpn-4-29.str.redhat.com [10.32.4.29])
	by pobox.stuttgart.redhat.com (8.13.1/8.13.1) with ESMTP id m04KLA64027655;
	Fri, 4 Jan 2008 15:21:10 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.1.00.0801041437190.2649@xanadu.home>
X-Enigmail-Version: 0.95.5
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69600>

Nicolas Pitre wrote:
> On Fri, 4 Jan 2008, Michael Stefaniuc wrote:
> 
>> With "too many unreachable loose objects" git gc --auto will always
>> trigger. This clutters the output of git am and thus git rebase.
>>
>> The work flow of the Wine project doesn't include git merge. git rebase
>> is therefor used to track the origin. This will produce soon too many
>> loose objects for git gc --auto's taste. Pruning the repository would
>> "fix" it. But we tell Wine developers new to git to NOT prune as long as
>> they aren't confident enough with git; just as a safety net in case they
>> have thrown away month of work.
> 
> The safety is the reflog.  What it refers to doesn't get pruned.
Then git gc --auto should just prune too and not spam, right?
But the reflog is only there for branches that still exist; the rest is
gone. A git stash clear will also remove the reflog for the stash.

Regardless of the safety of git prune i don't see a reason why git gc
--auto needs to be called for every patch in a git-am run and not once
at the end.

bye
	michael
