From: "Philip Oakley" <philipoakley@iee.org>
Subject: Fw: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 5 Feb 2012 15:10:38 -0000
Organization: OPDS
Message-ID: <1A0FD0F1D0AF429D941C20774162118F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=response
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 16:10:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru3jk-00054H-0e
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 16:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828Ab2BEPKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 10:10:35 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:56151 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754182Ab2BEPKf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 10:10:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgEFAJ+bLk9Z8r9j/2dsb2JhbABBilykVIEGgW0FAQEECQEBDiAeAQEmBgEBCAIBAxEEAQEKOQEECBIGBw0CDhMIAQEBAgMBCIdjAwaWQoYzkGyIFYNPASkMAQEJBBQLDwoBgm+BIggBBAQpgktjBI1JkmmHUQ
X-IronPort-AV: E=Sophos;i="4.73,364,1325462400"; 
   d="scan'208";a="369082169"
Received: from host-89-242-191-99.as13285.net (HELO PhilipOakley) ([89.242.191.99])
  by out1.ip05ir2.opaltelecom.net with SMTP; 05 Feb 2012 15:10:32 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189943>

Oops, forget 'reply all' to the list.
Philip

----- Original Message ----- 
From: "Philip Oakley" <philipoakley@iee.org>
To: "Jakub Narebski" <jnareb@gmail.com>
Sent: Sunday, February 05, 2012 2:31 PM
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published 
history


> From: "Jakub Narebski" <jnareb@gmail.com>
> Sent: Saturday, February 04, 2012 7:45 PM
>> Git includes protection against rewriting published history on the
>> receive side with fast-forward check by default (which can be
>> overridden) and various receive.deny* configuration variables,
>> including receive.denyNonFastForwards.
>>
>> Nevertheless git users requested (among others in Git User's Survey)
>> more help on creation side, namely preventing rewriting parts of
>> history which was already made public (or at least warning that one is
>> about to rewrite published history).  The "warn before/when rewriting
>> published history" answer in "17. Which of the following features would
>> you like to see implemented in git?" multiple-choice question in latest
>> Git User's Survey 2011[1] got 24% (1525) responses.
>>
>> [1]: https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL
>>
>> So people would like for git to warn them about rewriting history before
>> they attempt a push and it turns out to not fast-forward.
>>
>
> Another area that is implicitly related is that of (lack of) publication 
> of sub-module updates. A mechanisms that, in the super project, knows the 
> status of the (local) submodules, such as where they would be sourced 
> from, i.e. what was last pushed & where, could help in such instances.
>
>>
>> What prompted this email is the fact that Mercurial includes support for
>> tracking which revisions (changesets) are safe to modify in its 2.1
>> latest version:
>>
>>  http://lwn.net/Articles/478795/
>>  http://mercurial.selenic.com/wiki/WhatsNew
>>
>> It does that by tracking so called "phase" of a changeset (revision).
>>
>>  http://mercurial.selenic.com/wiki/Phases
>>  http://mercurial.selenic.com/wiki/PhasesDevel
>>
>>  http://www.logilab.org/blogentry/88203
>>  http://www.logilab.org/blogentry/88219
>>  http://www.logilab.org/blogentry/88259
>>
>>
>> While we don't have to play catch-up with Mercurial features, I think
>> something similar to what Mercurial has to warn about rewriting
>> published history (amend, rebase, perhaps even filter-branch) would
>> be nice to have.  Perhaps even follow UI used by Mercurial, and/or
>> translating its implementation into git terms.
>>
>> In Mercurial 2.1 there are three available phases: 'public' for
>> published commits, 'draft' for local un-published commits and
>> 'secret' for local un-published commits which are not meant to
>> be published.
>>
>> The phase of a changeset is always equal to or higher than the phase
>> of it's descendants, according to the following order:
>>
>>      public < draft < secret
>>
>> Commits start life as 'draft', and move to 'public' on push.
>
> Recording where they wer pushed to would be useful for synchronising 
> sub-modules and their super projects. That is, giving remote users a clue 
> as to where they might find mising sub-modules.
>
>>
>> Mercurial documentation talks about phase of a commit, which might
>> be a good UI, ut also about commits in 'public' phase being "immutable".
>> As commits in Git are immutable, and rewriting history is in fact
>> re-doing commits, this description should probably be changed.
>>
>> While default "push matching" behavior makes it possible to have
>> "secret" commits, being able to explicitly mark commits as not for
>> publishing might be a good idea also for Git.
>>
>
> Being able to mark temporary, out of sequence or other hacks as Secret 
> could be useful, as would recording where Public commits had been sent.
>
>>
>> What do you think about this?
>> -- 
>> Jakub Narebski
>> Poland
>> --
>
> Philip Oakley
> 
