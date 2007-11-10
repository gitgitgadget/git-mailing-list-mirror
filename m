From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v3] user-manual: add advanced topic "bisecting merges"
Date: Sat, 10 Nov 2007 12:16:14 +0100
Message-ID: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de>
References: <217E7104-312D-4D0C-BC66-C4829779C216@zib.de> <119468808499-git-send-email-prohaska@zib.de> <7vsl3emlpc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 12:15:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqoJD-000708-0A
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 12:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbXKJLPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 06:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXKJLPK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 06:15:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:48015 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbXKJLPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 06:15:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAABEw1Z004889;
	Sat, 10 Nov 2007 12:14:58 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83e97.pool.einsundeins.de [77.184.62.151])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAABEurU000275
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 10 Nov 2007 12:14:58 +0100 (MET)
In-Reply-To: <7vsl3emlpc.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64330>


On Nov 10, 2007, at 11:36 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> ...
>> +A solution is to linearize the history by rebasing the lower
>> +branch on top of the upper, instead of merging. There were no
>
> Hmm.  When I wrote it, I did not mean this as a "solution", but
> as an illustration of how a merge heavy history and a linear
> history have impact on bisectability.

I agree. This is what I understood. But later Johannes brought up
the idea of naming it a "solution"; and some others liked this.

We should probably move the discussion to Chapter 5 "Rewriting
history and maintaining patch series". Discussing pros and cons
of merge versus rebase makes more sense there.  The discussion
would go right after "Problems with rewriting history". So,
users should be warned not to rebase without thinking about
the consequences. Another advantage is that users should
have learnt more about git when they reach Chapter 5. Hence,
it should be easier to follow the discussion.


>   So it is more like...
>
>     On the other hand, if you did not merge at C but rebased the
>     history between Z to B on top of A, you would have get this
>     linear history [illustration here].  Bisecting between Z and
>     D* would hit a single culprit commit Y* instead.  This tends
>     to be easier to understand why it is broken.

I'll take this...


> For this reason, many experienced git users, even when they are
> working on an otherwise merge-heavy project, keep the histories
> linear by rebasing their work on top of public upstreams before
> publishing (when able).  An extreme example: merges from a few
> top-level lieutenants to Linus in the kernel, e.g. David Miller,
> are known to _almost always_ fast-forward for Linus.
>
> IOW, the description is to mildly encourage private rebasing to
> keep the job of later bisecting (for potentially others) easier.
> I realize I originally wrote as if C (merge) was made by the
> same person as the person who ends up bisecting, but that is
> not necessarily the case.  Keeping the history without needless
> merges tend to make _other_ people's lives simpler.
>
> And after encouraging the private rebasing, I would continue
> like...
>
>     But if you already made a merge C instead of rebasing, all
>     is not lost.  In the illustrated case, you can easily rebase
>     one parent branch on top of the other after the fact, just
>     to understand the history and to make the history more
>     easily bisectable.

s/more easily bisectable/easier to bisect/ ?


>     Even though the published history should
>     not be rewound without consent with others in the project,
>     nobody gets hurt if you rebased to create alternate history
>     privately.  After understanding the breakage and coming up
>     with a fix on top of D*, you can discard that rebased
>     history, and apply the same fix on top of D, as D* and D
>     should have the identical trees.

... and will prepare PATCH v4.

	Steffen
