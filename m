From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Fri, 09 Mar 2012 08:22:17 +0100
Message-ID: <4F59AFA9.5030205@viscovery.net>
References: <1331203358-28277-1-git-send-email-domq@google.com> <1331203358-28277-2-git-send-email-domq@google.com> <87399jnyxh.fsf@thomas.inf.ethz.ch> <7vaa3qewqw.fsf@alter.siamese.dyndns.org> <7vipiebv1r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Dominique Quatravaux <domq@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 08:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5u9h-0003OG-QD
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 08:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308Ab2CIHWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 02:22:21 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12908 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752150Ab2CIHWU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 02:22:20 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S5u9Z-0006XR-Ur; Fri, 09 Mar 2012 08:22:18 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A684A1660F;
	Fri,  9 Mar 2012 08:22:17 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vipiebv1r.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192685>

Am 3/8/2012 23:13, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Thomas Rast <trast@inf.ethz.ch> writes:
>>
>>> Dominique Quatravaux <domq@google.com> writes:
>>>
>>>> If set, the second column of the rebase todo contains named revisions (obtained
>>>> with git name-rev) instead of short SHA1s.
>>>
>>> Hum.  I'm not sure yet if I find that very useful, since frequently the
>>> names will just be 'topic', 'topic~1', ...., 'topic~N' if you are
>>> rebasing a topic with N+1 commits not in master.  But you might, so who
>>> am I to judge.
>>
>> I think the only use case where this might be useful is when you
>> have totally undescriptive one-line description to your commits that
>> they alone do not help distinguishing the commits being picked, e.g.
>> ...
> 
> This may need a bit of clarification for readers from the future.
> If you _were_ somehow interactively rebasing changes made on two or
> more branches into a single branch, knowing which branch each commit
> came from may have value, even if your commit titles are descriptive
> enough.
> 
> Today's "git rebase -i" wouldn't do something like that, and we will
> not know how the user would interact with such a yet-to-be-written
> tool, so it is too early to judge if using "topic~1" is the desired
> improvement or not at this point.

Yet-to-be-written? Rebase -i happily linearizes mergy history, so this
does have some merits even today.

I do share your concerns that naming to-be-rebased commits with a relative
specifier such as "topic~1" could be dangerous. However, this is a problem
only when the rebase -i is not completed timely, so that you have
sufficient time to mess with the ref "topic" from a different terminal.
You would have to run "git branch -f", "git fetch", or "git push" (the
latter could even happen from remote) that involve the ref name. Can't we
just declare this as "don't do that then"? (We do say this more often than
not since recently :-)

-- Hannes
