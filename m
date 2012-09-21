From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Quickly searching for a note
Date: Fri, 21 Sep 2012 12:29:50 -0600
Message-ID: <505CB21E.4040607@workspacewhiz.com>
References: <505C7C80.3000700@workspacewhiz.com> <7vy5k370n7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 20:30:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF7zT-0000ie-C4
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 20:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493Ab2IUSaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 14:30:00 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:56321 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160Ab2IUSaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 14:30:00 -0400
Received: (qmail 4163 invoked by uid 399); 21 Sep 2012 12:29:24 -0600
Received: from unknown (HELO SlamDunk) (jjensen@workspacewhiz.com@204.238.46.101)
  by hsmail.qwknetllc.com with ESMTPAM; 21 Sep 2012 12:29:24 -0600
X-Originating-IP: 204.238.46.101
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vy5k370n7.fsf@alter.siamese.dyndns.org>
X-Antivirus: avast! (VPS 120921-0, 09/21/2012), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206146>

----- Original Message -----
From: Junio C Hamano
Date: 9/21/2012 11:21 AM
> Joshua Jensen <jjensen@workspacewhiz.com> writes:
>
>> Background: To tie Perforce changelists to Git commits, I add a note
>> to a commit with the form "P4@123456".  Later, I use the note to sync
>> down the closest Perforce changelist matching the Git commit.
>>
>> I search for these notes by getting a list of revisions:
>>
>>          git rev-list --max-count=1000
>>
>> I iterate those revisions and run git show and grep on each:
>>
>>          git show -s --format=%N%n%s --show-notes=p4notes COMMIT
>>
>> For short runs, this isn't so bad.  For longer runs of commits (I just
>> walked through approximately 100), it takes a long time. Running 'git
>> show' is costing me about 7/10 of second, presumably because I am on
>> Windows.
> Is there any particular reason you do that as two separate steps?
> It would feel more natural, at least to me, to do something along
> the lines of
>
> 	git log --show-notes=p4notes -1000
>
>
Thanks for the reply.

I did not make clear above that I want to stop looking when I find the 
first commit that has the note.

In the case of 'git log --show-notes=p4notes -1000', Git will process 
and hand me the log output for 1,000 commits.  It is rare I need to walk 
that deep.  We saw 300 commits deep once on a long-lived branch that 
hadn't been merged in yet, but I'd be surprised to see 1,000.

Still, it shows an arbitrary choice.  Really, I want to say to Git: Walk 
up the history as far as you need to go from HEAD and return to me the 
first commit containing the text "P4@".

Any other thoughts?

-Josh
