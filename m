From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Sat, 05 Dec 2009 06:27:08 +0900
Message-ID: <20091205062708.6117@nanako3.lavabit.com>
References: <cover.1259934977.git.mhagger@alum.mit.edu> <4B192701.4000308@drmicha.warpmail.net> <vpqfx7qocwl.fsf@bauges.imag.fr> <7vws12r5v2.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 04 22:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGfgm-0007rX-Em
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 22:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300AbZLDV1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 16:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757298AbZLDV1c
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 16:27:32 -0500
Received: from karen.lavabit.com ([72.249.41.33]:53116 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757276AbZLDV1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 16:27:32 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id BB83811B8BB;
	Fri,  4 Dec 2009 15:27:38 -0600 (CST)
Received: from 9898.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id OQWD8QV3H772; Fri, 04 Dec 2009 15:27:38 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=En+RbOiS2nFlOp28R4hdJFt86w2xnaBWjB4z9P0OVFNXWDUVG0ahlhFCzil9CV2zyjetU9v2aonK7GZfLosC6YInLEFoBX6A8QgGoOxjvWCLbnVNozhSinsQj9f+giFKXTDhOT+5vMj8Ds6zfND8ZFJ8V8CALMZ2h/7QItJNQvQ=;
  h=From:To:Cc:Subject:X-Draft-From:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
X-Draft-From: ("nnml:git-mail" 72381)
In-Reply-To: <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134578>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>

> Hi,
>
> On Fri, 4 Dec 2009, Junio C Hamano wrote:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> 
>> > Michael J Gruber <git@drmicha.warpmail.net> writes:
>> >
>> >>> If the idea of a "fix" command is acceptable, then I would like to
>> >>> implement a further convenience: if a group of commits to be folded
>> >>> together includes *only* "fix" commits, then the first log message
>> >>> should be used without even opening an editor.  But I would like to
>> >>> get a reaction to the "fix" command in general before doing so.
>> >>
>> >> I'd say that would make a useful command ("fix") even more useful, being
>> >> just the right counterpart to "reword" for trivial commit message fixes.
>> >
>> > +1 for fix, and +1 for the "don't even launch the editor" too.
>> 
>> I like it, too.  Also I vaguely recall that there was a series that died
>> that would have allowed you to give hints to help this behaviour at the
>> time you make "fix-up" commits; we may want to resurrect it on top of this
>> feature.
>
> I'll just repeat this exactly one more time: it is not always possible to 
> know whether you make a fix-up commit, and it is not always possible to be 
> sure that you want to amend the next time you do a rebase.
>
> So: Commit time is definitely a bad time to decide on the action in some 
> future rebase event.

I think Junio is referring to this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/127923/focus=121874

The old patch added a convention to mark a fix-up commit 
with a special string "!fixup" and refer to which commit 
in the series it is fixing.  It added --autosquash option
to rebase--interactive that tells it to move such a commit 
to an appropriate place in the series and change its 'pick' 
to 'squash'. I think with Michael's patches, it can change 
'pick' to 'fix' instead.

I too think Michael's "fix" is a good feature, and in the 
workflow by Shawn, he knows he is fixing up an earlier 
commit, and he knows he doesn't want to add anything to 
the message by the fix-up commit when he makes that commit 
(how else would he have messages like "a", "s", or "foo").

I don't think your objection should block *others* (like
Shawn and Junio) who can decide when they make commits 
from using the feature from my old patch to make it even 
easier to clean up their topics. If *you* can't decide if 
you want to amend or not when you make a fix-up commit, you 
can leave your fix-up commits unmarked, run interactive 
rebase without the --autosquash option, and use Michael's 
'fix' manually. People who can sometimes but not always 
decide when they make commits can do the same when they 
can't.

Isn't it what Junio suggested by his "on top of this feature", 
and wouldn't that make everybody happy?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
