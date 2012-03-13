From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Tue, 13 Mar 2012 10:34:00 +0100
Message-ID: <vpqy5r44zg7.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 10:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7O7v-0004Y4-Su
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 10:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760161Ab2CMJei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 05:34:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33797 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759774Ab2CMJeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 05:34:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2D9TdHB011703
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 13 Mar 2012 10:29:39 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7O7F-0003uT-Sr; Tue, 13 Mar 2012 10:34:01 +0100
In-Reply-To: <20120312183725.GA2187@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 12 Mar 2012 14:37:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 13 Mar 2012 10:29:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2D9TdHB011703
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332235781.68939@rMFiiKGU7Jgwk/5DXsMqVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192991>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 12, 2012 at 05:37:32PM +0100, Matthieu Moy wrote:
>
>> * For newbies, the sequence "create an empty repository, clone it,
>>   commit and push" works like a charm with either 'upstream' or
>>   'current'. Today, the first push to an empty repository requires
>>   either saying "git push origin master" or "git push --all", both of
>>   which sound like black magic to the poor user who did not yet learn
>>   what 'origin' is and what a branch is.
>
> Ending that confusion is one of the best reasons to switch the default,
> IMHO, but I don't think it argues for "current" versus "upstream", as
> they both fix it (but Michael's matching-current hybrid would not, so I
> agree it is less appealing).

Exactly. It does not change the 'upstream' vs 'current' debate.

>> * 'upstream' makes it easy to create a local topic branch, and let
>>   'push' send it to the master branch (i.e. have local 'topic-branch'
>>   pull and push to 'origin/master'). In general, 'upstream' allows
>>   workflows where you push to branches with either a different name or
>>   with the same name (by setting the upstream appropriately), but the
>>   opposite is not true.
>
> Actually, this is the thing that scares me the most about "upstream" as
> a default, because in this case, you are implicitly performing the
> equivalent of a fast-forward merge. So that's handy if you are a new
> user who wants to publish your work back to the master branch. But that
> has two problems:
>
>   1. If you are a new user who does like the implicit merge, you may
>      find it convenient not to have to learn about "git checkout; git
>      merge topic ; git push remote master". But it only helps you
>      _sometimes_. If master has had other work built on it, your push
>      will fail, and you will have to do the merge yourself. So it is
>      only helping you by omitting a step some of the time, and you still
>      have to learn why the step is sometimes necessary and sometimes
>      not.

There's a rule of thumb which works very well for beginners: when "git
push" tells you to pull before, then pull before. This rule of thumb
works, but only provided "push" and "pull" are symmetrical.

My experience with teaching Git is that this is the number 1 issue with
beginners (I'm talking about students who didn't learn CVS/SVN before,
so real beginners). They try to push, the push fails, and they come to
me saying "Git is broken, we can't work". That's why I introduced the
advice about non-fast forward, and later added the mention (e.g. 'git
pull') to point users in the right direction when the push fails. It
considerably reduced my workload as teacher ;-).

Now, if pushing sends commits to a branch other than 'upstream', you can
get the following scenario:

$ git push
To bla
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'bla'
To prevent you from losing history, non-fast-forward updates were rejected
Merge the remote changes (e.g. 'git pull') before pushing again.  See the
'Note about fast-forwards' section of 'git push --help' for details.
$ git pull
Already up-to-date.
$ git push
<still denied, wtf>

One can easily get in this situation even in a kernel-style workflow:
work from your desktop, push, work from your laptop, try to push and it
fails.

Back to my students, most of them will never get in this situation
because they won't use branch, so HEAD = master and upstream =
origin/master, but the not-so-newbies may get this once they start
creating branches ifever they have HEAD = topic-branch and upstream =
origin/master for example.

>   2. If you are a new user who _doesn't_ want to do the merge, but
>      instead wants to publish your work-in-progress topic, then the
>      implicit merge-back-to-master behavior is wrong and dangerous.
>      You are publishing work that probably violates the general rules
>      for what goes on master.

To me, this is the real argument in favor of 'current'. I think it is
less important than others, but that's obviously subjective.

In any case, I'm not opposed to 'current', and I think 'current' is a
better default than 'matching', but I'm still not convinced it is better
than 'upstream'.

>      Or perhaps somebody else has built on top of master, and your push
>      fails. If you're an astute reader, you will see that the failing
>      push tried to go to master. But if you're not, you may retry with
>      "-f", which is quite dangerous, as now you are not just
>      accidentally publishing a work-in-progress, but you are
>      overwriting somebody else's work. Obviously this is a problem
>      anytime you use "-f", but the fact that your "foo" branch is going
>      to somewhere besides the remote's "foo" branch makes me think it is
>      much more likely a clueless user will get confused and overwrite
>      something on the more "mainstream" branch.

I don't think 'current' Vs 'upstream' really changes that. You may get a
non-fast forward on your topic branch if you've push to it from another
machine for example.

> So far a lot of the discussion has focused on "what is the most sensible
> default for the most number of people". But I wonder if a better
> question is "what is the default that is the least likely to do
> something dangerous and embarrassing".

I think "what's the most intuitive" is also very important. If we're
talking about real, real newbies, the risk of pushing to the wrong
branch is marginal compared to the risk of giving up and say "Git
doesn't work, I'll send my files by email" (which is real in my
experience :'-( ). But your remark does apply to not-totally newbies
anymore, but not yet Git gurus.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
