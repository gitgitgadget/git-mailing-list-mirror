From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [RFC/PATCH] git-merge: implement --ff-only-merge option.
Date: Wed, 08 Oct 2014 14:02:41 +0400
Message-ID: <87mw96g9q6.fsf@osv.gnss.ru>
References: <1412699710-3480-1-git-send-email-sorganov@gmail.com>
	<xmqqzjd7enet.fsf@gitster.dls.corp.google.com>
	<87fvezsk5k.fsf@osv.gnss.ru>
	<xmqqegujeibx.fsf@gitster.dls.corp.google.com>
	<87a957obm6.fsf@osv.gnss.ru>
	<xmqqwq8bd0hw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 12:02:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbo53-0005bW-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 12:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbaJHKCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 06:02:45 -0400
Received: from mail.javad.com ([54.86.164.124]:52869 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbaJHKCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 06:02:44 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id BD58361865;
	Wed,  8 Oct 2014 10:02:42 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1Xbo4v-00065H-2u; Wed, 08 Oct 2014 14:02:41 +0400
In-Reply-To: <xmqqwq8bd0hw.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 07 Oct 2014 14:38:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> Because rebasing immediately before is considered a bad manner,
>>> i.e. encouraging a wrong workflow?
>>
>> Why? What is wrong about it?
>
> Searching the kernel archive for messages that talks about "rebase"
> and "pull-request" from Linus would tell us why it is frowned upon
> in a prominent early adopter project of Git.

I don't argue it's wrong for work-flows used for Linux kernel.

Even in general, once pull-request is issued, it's bad idea to rebase
your work, as you've already published your history.

I don't see how it is relevant to my proposal though. It was bad idea in
general to rewrite published history before this patch, it still is with
this patch, and the patch itself doesn't encourage anybody to rebase
published history as it is about true merge, not about rebase.

> You destroy what you have been testing and replace it with an untested
> one. If you merge, and if the result of the merge is broken, at least
> you would have something that used to work at its second parent (i.e.
> the tip of your topic).

This seems to apply to rebasing in general. I have nothing against
work-flows that don't routinely use rebasing, but there are other
work-flows around as well. 

In my workflows, I do test the result of rebase, and I'd simply revert
the rebase if the result appears to be broken. When the result is OK, I
do the final merge. If it is perfectly trivial merge, it needs no
testing at all as it doesn't change content. It's this latter condition
that my suggested new option for "git merge" tries to ensure.

Hopefully we are not going into arguing whose work flow is better.

>> Please also notice that I don't try to impose this on anybody who does
>> consider it wrong workflow.
>
> I know ;-).  I didn't say anything about "imposing", did I?
>
> Having an option to make it easy to do something undesirable gives
> people an excuse to say "See Git has this option to let me do that
> easily, it is an officially sanctioned and encouraged workflow".

Whatever you can do "easily" with my patch, you can do "easily" with
--no-ff right now, except that with my option instead of --no-ff, you
won't get non-trivial merges you didn't intend.

So I rather see the message of my proposal as: provided you rebase your
(topic) branches anyway, you can use this feature to keep essential
information in the history and avoid complications of non-trivial
merges.

-- 
Sergey.
