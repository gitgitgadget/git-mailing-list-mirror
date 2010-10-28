From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git rebase --abort of an --onto run does not checkout the originating
 branch
Date: Wed, 27 Oct 2010 21:04:44 -0600
Message-ID: <4CC8E84C.3030709@workspacewhiz.com>
References: <4CC1C34E.8090203@workspacewhiz.com> <7vlj5qkpjc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 05:04:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBInM-0004RT-Pq
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 05:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860Ab0J1DEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 23:04:47 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:54824 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932829Ab0J1DEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 23:04:46 -0400
Received: (qmail 24187 invoked by uid 399); 27 Oct 2010 21:04:40 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Oct 2010 21:04:40 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b3pre Thunderbird/3.1.5
In-Reply-To: <7vlj5qkpjc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160154>

----- Original Message -----
From: Junio C Hamano
Date: 10/22/2010 1:15 PM
> Joshua Jensen<jjensen@workspacewhiz.com>  writes:
>
>> git rebase --onto mybranch START_SHA END_SHA
>>
>> In the middle, I decide to run 'git rebase --abort'.
>>
>> Just as the documentation states, it performs a checkout of END_SHA as
>> the restored branch.  END_SHA has nothing to do with the originating
>> branch, and confusion ensues.
>>
>> Is there a reason why 'git rebase' should not store off the
>> originating branch and use that for an --abort, instead of<branch>
>> which is END_SHA?
> When END_SHA is an actual branch name (which by the way is almost always
> how I use --onto in my attempts to transplant my topics), and when I found
> out that the conflicts I see while rebasing the topic to a different
> starting point (i.e. --onto) is too much to handle for too little gain, I
> would not appreciate if --abort took me to the --onto branch, which is
> totally uninteresting for the purpose of what I was attempting to do,
> namely, to deal with the topic.
>
> If the command took me back to the tip of the topic that I failed to
> rebase, I can continue attempting to whip it in shape using different
> strategies from there (e.g. merging an older part of upstream into the
> topic before merging the topic back to the upstream).
As if turns out, I wasn't expecting --abort to take me to the --onto 
branch but rather, the originating branch.  Let's assume I am working in 
a branch called JBranch.  I run:

         git rebase --onto master START_SHA END_SHA

I decide to abort the rebase.  I expect to be returned to the place I 
started from: JBranch.  After all, I am aborting the rebase.  I don't 
want to proceed.  I decided it was the wrong thing to do, so just put me 
back where I was.

Anyway, that was my thought pattern.  Since that isn't how it works, 
I'll just have to remember where I was when I started the rebase, 
perform the abort, and checkout the originating branch.

Thank you for your time.

Josh
