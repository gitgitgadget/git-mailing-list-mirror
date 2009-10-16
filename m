From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git describe without refs distinguishes dirty
 working  tree
Date: Fri, 16 Oct 2009 16:02:59 -0700
Message-ID: <7vvdifq6vw.fsf@alter.siamese.dyndns.org>
References: <dffdbd190910160812h6d6a876el8261a622b5439b30@mail.gmail.com>
 <20091016173902.GT10505@spearce.org>
 <7veip3t6rm.fsf@alter.siamese.dyndns.org>
 <dffdbd190910161452o4ac0b426i7c48649eafa0d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jean Privat <jean@pryen.org>
X-From: git-owner@vger.kernel.org Sat Oct 17 01:03:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyvpR-0007vM-Tx
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 01:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbZJPXDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 19:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbZJPXDG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 19:03:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZJPXDE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 19:03:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68E1F5B32B;
	Fri, 16 Oct 2009 19:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WQNTdGJXa5DN4W7QmvLp0daI/4o=; b=UjdLfu
	FEVvIlmDEDMR9d0L9DfRoIgqWODmlzbmmcHkIgyHNhrcPbQYrgiyt6cUCpr6GBSp
	8bGcFtWTS6m7xxTw/rhRQ/bC7yLqwyuwMDWzL4nd2McENqKALYIvhJhUKHrm7OdZ
	zFCSXaxr4XaAUMlHh2SSlONogUTo/tlxea7vg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kAblml9eXA2r/WDg428kNDgcOk3/YGEx
	D8dKxEolJQPgl+AsaajN/4a0KOLzd4RHM25rsafZuFI71mgGtLfaKGWnKSRSI4QA
	eie3q96B8HqDqTatnBeLZECpqluLuofCaPoAer5P5PczS2AzcaYmpUe4w7ap0VNz
	in7/UnqQjOU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C0645B32A;
	Fri, 16 Oct 2009 19:03:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A51E5B329; Fri, 16 Oct
 2009 19:03:00 -0400 (EDT)
In-Reply-To: <dffdbd190910161452o4ac0b426i7c48649eafa0d53@mail.gmail.com>
 (Jean Privat's message of "Fri\, 16 Oct 2009 17\:52\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0FEDA0C4-BAA8-11DE-A571-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130533>

Jean Privat <jean@pryen.org> writes:

>> I still haven't heard anything that helps me to decide which way the
>> default should be.  The only concrete thing I have heard against the
>> change of the default is that it will break existing setup, but I haven't
>> heard anything concrete for the change yet.
>
> As a said in the comment part of the initial message, I initially
> planed to add a --worktree option that means "I want you to describe
> my working tree". Knowing that from my naive point of view, the
> description of the working tree is what build script wanted :
> description of HEAD (on which is based the working tree) + saying that
> if the working tree is dirty or not (done manually by scripts).
> Moreover, in my naive view with the "--worktree" option, no refs where
> allowed (i.e. describe the working tree xor describe some commit
> references).

I do not think it is naive at all.  "git describe --worktree HEAD^" won't
make any sense in that world view; by definition the work tree is not
derived from anything but HEAD.

> Then, I realized that for some other git commands that can work both
> on the working tree and on an arbitrary commit reference, the default
> was to work on the working tree and require an explicit HEAD to work
> on the HEAD commit.

But the thing is, "git describe" without arguments already works on HEAD
and describes it, and people depend on the behaviour.

I originally thought this _might_ break and hoped it won't be a big issue,
but now I've seen that even the kernel would break (it runs the command
without saying "HEAD"), I do not want to risk breaking other projects I
may not even heard of.  Some people might have copied our GIT-VERSION-GEN
(that says "HEAD"), but I would not bet against that many many more people
would have copied the use of "git describe" from the kernel build tree
than from us.  After all, they are more famous and established than we
are.  [*1*]

One line of argument that I would have found reasonable to defend the
change of the default is that "The --worktree (or --dirty) option is
cumbersome to type.  And in _this_ workflow (that I haven't imagined, but
still would be *very* valid and useful one---so anybody who argues along
this line needs to fill in the blank here), it is the best solution to ask
the "git describe" command about the state of the work tree from the
command line very often, and here is why (here is another blank to fill
in), because there is no other way to get at the information, and/or the
info given by other existing commands are suboptimal for these reasons
(here is another blank to fill in)."

Then we would need to weigh benefits (for the interactive use of a very
useful and often used form of the command) against downsides (for people
having to update their existing scripts).

For use by scripts, the argument against having to give an extra option to
get the new behaviour becomes much weaker than for interactive use, even
if the new behaviour may be more common.  The point of scripting is that
you can write it once and forget about it; if it requires "--worktree" in
order to omit an extra "diff --index HEAD", it is not such a big deal.

And it is important to realize that "can write it once and forget about
it" cuts both ways.  It should apply not only to the people who write
their scripts after this patch of yours is applied to git, but should
equally apply to the people who wrote their scripts long time ago,
expecting that they can safely forget about them once they wrote them,
relying on the existing behaviour of the command.  Changing the defaults
for them means we lied to them and they have to update their scripts.  In
other words, they cannot script and forget about it anymore.

An attitude to change the default lightly like that, be it in 1.7.0 or
not, will then later come back and haunt your scripts you write while
assuming that the behaviour your patch will bring in will stay forever.
Allowing such a casual attitude will lead to other people changing the
default equally casually in the future.

It is my job to say no, even when I 100% agree that the new behaviour
would have been the default one if we were inventing "git describe" from
scratch and there were no existing users [*2*].  We do not live in an
ideal world, and 1.7.0 is not a blank check to change everything in sight.

>> How about "describe --dirty" and "describe --dirty=-mod" (the latter
>> creates v1.6.5-15-gc274db7-mod")
>
> May be better than "--wortree" (especially because of the value part),
> but what happen with
>  $ git describe --dirty v1.2.1
> should it show an error, output "v1.2.1" anyway, or output
> "v1.2.1-dirty" if the working tree is different from v1.2.1 ?

I am actually fine with your --worktree option, especially after seeing
your much more clear (i.e. "the state of my work tree") explanation in the
beginning of your response.

But I think "git describe" working in this "describe the version in the
work tree in the point in history" mode should reject any explicit
revision argument; by definition the work tree is not derived from
anything but HEAD.


[Footnote]

*1* In addition to the "it would break the kernel" issue, there are some
projects that expect users to tweak files they ship before building
(e.g. makefiles and config.h and the like).  For these people, any and all
builds would be -dirty.  I expect these projects, when migrating to git,
would either update their build procedures (moving config.h to
config.h-sample or something), but another solution for them would be to
use "git describe" without the -dirty bits.  So they are another class of
people who may not want -dirty by default.

*2* It personally hurts in a case like this, but that is what maintainers
have to do.  The maintainer's job is not to be loved, but is largely to
protect existing users from the second system syndrome.
