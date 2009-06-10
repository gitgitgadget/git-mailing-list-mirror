From: Sam Vilain <sam@vilain.net>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 14:52:00 +1200
Message-ID: <4A2F1FD0.8060303@vilain.net>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>	<alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>	<4A2F0B8A.9010203@vilain.net> <7vws7khlvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 04:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEDvS-0001Vk-UG
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 04:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbZFJCwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 22:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbZFJCwT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 22:52:19 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50406 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbZFJCwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 22:52:19 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5B23121C331; Wed, 10 Jun 2009 14:52:05 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 5416C21C325;
	Wed, 10 Jun 2009 14:52:00 +1200 (NZST)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <7vws7khlvj.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121244>

Junio C Hamano wrote:
>> I think as long as there is a deprecation cycle, and that users can
>> select the old behaviour (either via an alias or a config option), then
>> we shouldn't upset many long-time users of revert. Do you agree?
>>     
>
> I actually don't.
>
> I do not think introducing "git revert-file" (or "git revert -- path") is
> a problem at all.  But "git revert $commit" has been and is an integral
> part of the established git workflow, and I do not see a point in changing
> it to mean something else, with any deprecation period.
>   

Ok. Off-hand I can't remember why we excluded "git revert -- path" as
workable. Whatever that reason was led to the group of core developers
coming up with these "clearly" "_inferior_" names.

That could solve the problem, switching behaviour on the type of
argument passed rather than including it in the command name. I think
that was my preferred option at the time, too. Perhaps some other
attendees can recall more clearly...

> Some changes in "eg" may port well as a new command to git-core, and some
> change (like this "revert" thing that has different semantics and breaks
> established workflow) will never be in git-core.  People may think that it
> would not cause many problems if we picked only the non-conflicting bits,
> but I actually have some reservations about that.
>
> It will bloat the total number of subcommands you can give git, with the
> end result being
>
>  (1) old timers won't use "revert-commit" and "revert-file" at all but use
>      "revert" and "checkout -- path"; while
>
>  (2) new people will behave the other way; and
>
>  (3) the documentation will list all of commands from these two disjoint
>     sets under "git".
>
> When a "eg" minded person teaches git, the students may have to be told to
> ignore "revert" and "checkout -- path", because there are other ways to do
> the same thing in the lingo they are being taught, which is a subset of
> git commands.  The manual pages will be littered with descriptions like
> "this command, when used this way, is synonymous to using that other
> command with this option", leaving the reader wondering why there are so
> many ways to do the same thing.
>   

Yes, I agree that if the old behaviour is not being deprecated it
probably shouldn't be replicated as well.

In fact that may have been the argument for excluding 'git revert
filename' - because you can already do that with 'git checkout HEAD --
filename'; but perhaps in this case it is acceptable, because the
'checkout' command can also check out from other revisions, but revert
can't.

Sam.
