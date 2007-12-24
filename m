From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Document git rev-list --first-parent
Date: Mon, 24 Dec 2007 12:14:17 +0200
Message-ID: <476F8679.8010706@qumranet.com>
References: <1198484450-16454-1-git-send-email-avi@qumranet.com>	<7v3atstry4.fsf@gitster.siamese.dyndns.org>	<476F6F95.1030506@qumranet.com>	<7vprwwsbey.fsf@gitster.siamese.dyndns.org>	<476F7EA4.1030001@qumranet.com> <7vejdcs9cb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 11:14:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6kKe-0001dv-Dn
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 11:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXLXKOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 05:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXLXKOU
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 05:14:20 -0500
Received: from il.qumranet.com ([82.166.9.18]:59002 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbXLXKOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 05:14:19 -0500
Received: from balrog.qumranet.com (balrog.qumranet.com [10.0.57.202])
	by il.qumranet.com (Postfix) with ESMTP id 1BEC3A0009;
	Mon, 24 Dec 2007 12:14:18 +0200 (IST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vejdcs9cb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69211>

Junio C Hamano wrote:
>> Well, my use case is different.  All of the development merges are
>> fast-forwards (or plain patch applications); the only multiple-parent
>> merges are pulls I do from the main tree in order to advance the
>> baseline,...
>>     
>
> Yeah, that is what I meant as a special case.  If you submit
> patches and rebase the remainder of your changes to the updated
> upstream (as x.org folks seem to do), then the --first-parent
> history will not be your own development but "the global trunk
> history."  If you are the top-level maintainer and your pull
> sometimes ends up as a fast forward and sometimes a real merge,
> you will sometimes get a full history of a topic done by
> somebody else (if that person rebased on top of you) or just a
> summary single merge (otherwise), and the distinction between
> these two cases does not have anything to do with whose commits
> they are (i.e. mine vs others) or the scope of the changes
> (i.e. the trunk history vs side branch development).  It would
> not be as useful as the "looking at the list of one's own
> commits while summarizing out others' developments as merge
> commits" world view the --first-parent would give you in your
> history.
>   

Sorry, I'm confused now.  I'll try to explain more carefully what I'm doing.

I'm a mid-level maintainer for a particular subsystem (kvm).  I merge 
patchsets from others and do my own work, but I am careful to keep 
everything linear (no real merges in the git sense).  Every once in a 
while I merge from upstream or some other tree, but these are never kvm 
developments.  Every merge window I rebase the development branch to 
upstream, removing commits that were later reverted, and merging fixes 
into the patches that introduce them and push the result to Linus.  
Hopefully that's clear as I'm not much of an ascii artist.

So, for me --first-parent means "commits to the development branch of 
kvm", whether by myself or someone else.  It specifically excludes kvm 
commits to mainline, since that would result in a bunch of duplicated 
commits.  But it seems to be quite different from what you're describing.

-- 
error compiling committee.c: too many arguments to function
