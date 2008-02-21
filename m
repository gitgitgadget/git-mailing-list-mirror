From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 21 Feb 2008 08:47:30 -0800
Message-ID: <7vejb6uuhp.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
 <7vodavd9qw.fsf@gitster.siamese.dyndns.org>
 <7vbq6tset4.fsf@gitster.siamese.dyndns.org>
 <7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
 <7vk5la4oxq.fsf@gitster.siamese.dyndns.org>
 <7vejbc44hu.fsf@gitster.siamese.dyndns.org>
 <7v8x1fymei.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802211024200.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSEb9-0004Jk-H9
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934059AbYBUQr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759949AbYBUQr6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:47:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61232 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934015AbYBUQrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:47:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 40EBA351C;
	Thu, 21 Feb 2008 11:47:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 7E775351B; Thu, 21 Feb 2008 11:47:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74633>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> * js/merge (Sun Feb 17 19:07:40 2008 +0000) 2 commits
>>  + xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
>>  + xdl_merge(): make XDL_MERGE_ZEALOUS output simpler
>> 
>> This makes conflicting merges that have hunks separated by only
>> a few common lines much easier to read.
>
> The question is: what to do about ALNUM.  Use it in merge-recursive?  Make 
> it a config variable?

I'd say we'll leave it as is for now and use it everywhere later
after making sure things work out Ok.

>> * db/push-single-with-HEAD (Wed Feb 20 12:54:05 2008 -0500) 1 commit
>>  + Resolve value supplied for no-colon push refspecs
>> 
>> Kills two birds with a commit by (1) fixing "git push $there +HEAD"
>> to force the single push, and (2) allowing you to set
>> "remote.$there.push = HEAD" so that "git push $there" will push
>> only the current branch.
>
> The question is now: should we initialise remote.origin.push to HEAD like 
> you said?  And if so, shouldn't we have git-remote's "add" do the same?

Perhaps we do not do anything further for now, other than
telling shared repository people to put it in their config and
see how well the behaviour matches their expectation.  Protocol
extensions to let clone notice what the other end is can come
later (and we would need to do that anyway to set up HEAD symref
as well).  The same mechanism would be used in "git remote add",
and at that point clone could be implemented as "init/remote
add/fetch/checkout".

>> * js/reflog-delete (Fri Jan 4 19:11:37 2008 -0600) 2 commits
>>  + builtin-reflog.c: fix typo that accesses an unset variable
>>  + Teach "git reflog" a subcommand to delete single entries
>> 
>> There was a patch that uses this to implement "git-stash drop",
>> which I didn't queue, as the command name and the UI was
>> undecided yet.  Dscho was in favor of "pop" without "drop".
>
> Maybe it is time to "drop" this topic?

I've been waiting for somebody to come up with a clean "pop", as
it probably is easy enough and would be an itch people other
than you and me can scratch.
