From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: stash refuses to pop
Date: Wed, 11 Apr 2012 10:21:07 -0400
Message-ID: <4F859353.4070700@ubuntu.com>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org> <4F84827B.80104@ubuntu.com> <4F851D8A.4000501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHyQH-00058a-7h
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 16:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760338Ab2DKOVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 10:21:10 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:6921 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760295Ab2DKOVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 10:21:09 -0400
X-Authority-Analysis: v=2.0 cv=FOSZNpUs c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=vnNYxAp2wzwA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=gIQW62ysuaBU9Oec-P8A:9 a=RAIl4_oo4fszboTSlyoA:7 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:49464] helo=[10.1.1.230])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 1A/B3-21438-353958F4; Wed, 11 Apr 2012 14:21:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F851D8A.4000501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195184>

On 4/11/2012 1:58 AM, Johannes Sixt wrote:
> You are trying to abuse git-stash, but it does not cooperate because it
> was not designed to be abused ;-) git-stash is not intended as a generic
> push-and-pop-my-changes work horse.

In what way is using the documented -p switch abuse?

> The purpose of git-stash is that you can "move away"

Yes, and then move back.  That is why it is broken that you can not 
immediately move back after a stash -p.

> - all of your changes to have a clean worktree or
> - part of your changes to _create a clean worktree from the remaining
> changes_.
>
> That is, before you can think of applying a stash, you are expected to
> have cleaned out your worktree.

It is obvious that is the assumption that stash was originally made 
with, and it might make some sense if it always left the tree in a clean 
state, but it no longer makes sense given -p and how it can leave the 
tree in a not clean state.

This is clearly a case of the initial implementation being a bit lazy. 
pop already performs a type of merge, just on a whole file basis.  In 
other words, the pop leaves you with some files from before the pop, and 
some files that were modified by the pop.  It should do a proper merge 
instead of a lazy whole file merge.
