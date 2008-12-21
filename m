From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Have manpage reference new documentation on reverting
 merges.
Date: Sun, 21 Dec 2008 00:00:55 -0800
Message-ID: <7vzliqrm88.fsf@gitster.siamese.dyndns.org>
References: <200812201832.48992.bss@iguanasuicide.net>
 <7vtz8ytft0.fsf@gitster.siamese.dyndns.org>
 <200812202335.19006.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nanako Shiraishi <nanako3@lavabit.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 09:02:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEJGg-0004B8-Hn
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 09:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbYLUIBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 03:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbYLUIBF
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 03:01:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbYLUIBE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 03:01:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BB0C891AD;
	Sun, 21 Dec 2008 03:01:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5BF97891AB; Sun,
 21 Dec 2008 03:00:57 -0500 (EST)
In-Reply-To: <200812202335.19006.bss@iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Sat, 20 Dec 2008 23:35:14 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 821E9856-CF35-11DD-80C9-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103691>

"Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

> But that is not the whole effect of the merge.  The effect of the merge is 
> both the modifications it makes to the tree and the modifications it makes to 
> the history.
>
> Going from the dictionary meaning for "revert", one might expect the those 
> effects to go away as well.  I think a warning that the revert subcommand 
> does not fully revert the merge is appropriate.

You may be technically correct, but think about the intended audience of
the warning.

People who know there are the "tree" aspect and the "history" aspect in
the merge and the revert operation will not get confused by the issue we
describe in the new HOW-TO, and they will understand the ramifications
without the help from the warning in your new paragraph.  The new warning
is trying to help people who do not understand these two aspects..

I have a strong suspicion that the "tree" aspect is much easier to grasp
by new people, while the understanding of the "history" aspect comes much
later when one becomes more proficient in using git.  Also, the immediate
interest of people who are reading "git revert" manual page is to revert
the effect of the merge in the "tree" aspect (iow, "I want to get the damn
thing work again"); that is where the focus of their attention is when
they read this manual page.

Your "not completely" does not tell them that the incompleteness you talk
about is "tree aspect only, not history aspect".  That is what I meant by
"... may get a wrong impression".  Their attention is about the "tree"
aspect, and your "not completely" will be easily misinterpreted as "the
tree effect of the merge won't get reverted completely", which is not what
you want to say.  And that is why I think you are much better off not
saying "not completely" if you do not explain what you mean by it.

As I showed you how in the previous message, an alternative is to say (the
equivalent of) "not completely", but explain what incompleteness you mean.

>> Linus's "does not completely undo" only refers to the history part of the
>> merge, and that only affects future re-merges from the same branch, which
>> the reader who is interested in doing a revert of a merge right now (that
>> is why s/he is reading this paragraph) may not yet care about.
>
> They may not care about it now, but it doesn't make much sense to warn about 
> it during the later merge (plus it might be computationally expensive to 
> detect).

Who's talking about giving a warning by computation?  Please stay on the
discussion of your documentation patch.

>> An alternative is to give a complete but brief explanation.  Perhaps like
>> this:
>>
>>     By reverting a merge, you are declaring that you will never want the
>>     changes that were brought in by that merge you are reverting in your
>>     tree.  If you do merge from the same branch again in the future after
>>     it is updated, git remembers your declaration, and only the changes on
>>     the branch that were made after the reverted merge will be brought in.
>>     This may or may not be what you want.  See 'revert-a-faulty-merge'
>>     HOWTO for more details.
>
> I think the wording might need to be changed a little bit, but I do like the 
> longer, more complete and clear explanation and I'll work on a patch that has 
> one.
