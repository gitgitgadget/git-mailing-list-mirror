From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Refactor useful notes functions into notes-utils.[ch]
Date: Thu, 13 Jun 2013 13:16:55 -0500
Message-ID: <CAMP44s3atPW-SE1yQzep-F6M13g1fPP_q2RqHKofPL0B8=JfYQ@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<7vzjuv14ir.fsf@alter.siamese.dyndns.org>
	<CAMP44s3jnyds45UGfbig1=evbqP-rztcn7GTZ8puVa2zzA7HGg@mail.gmail.com>
	<7vsj0lvs8f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jrnieder@gmail.com, pclouds@gmail.com, artagnon@gmail.com,
	john@keeping.me.uk, vfr@lyx.org, peff@peff.net,
	torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 20:17:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnC5M-0007ZV-R7
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 20:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758784Ab3FMSQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 14:16:58 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:64986 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab3FMSQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 14:16:57 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so5196860lbd.32
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 11:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=A9ojeUInfR8YzCtoCzySvUnEmpxkGLaKmfSHH8WiVEc=;
        b=HVZh+O8d/Tvdwaqfikf1tqrjiWJmFSsfip+pRh35BvaVFhS8AwUZG5iBalXpGuTvvy
         UPI7ynvWg7gEfTvn4jxE3qGbr7YRbQGowbiBJssSRZ0KoD0pqLPpqj6I3KvxgRO0y67G
         2o62ttkLPFZ/OhisfAnpTOiZNcRWYAf1jvJ0N6tHVBetW25+rsGOpNXbSio46gtUCMGB
         vJ6+1xlbW0Bayf3Mz5H21ZRjJGahz5nDojkhPUZToHF0gzlm4Beoj7CfXajonZcpJJeJ
         LPm8qUOUYGuSecaEV1SrcHH1Np0/I5pUBWqv4SlULGFST3p5/FAFAWYAdnzvkGGj86/H
         fTmw==
X-Received: by 10.112.52.97 with SMTP id s1mr1917521lbo.8.1371147415695; Thu,
 13 Jun 2013 11:16:55 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Thu, 13 Jun 2013 11:16:55 -0700 (PDT)
In-Reply-To: <7vsj0lvs8f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227763>

On Thu, Jun 13, 2013 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Wed, Jun 12, 2013 at 3:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> The proposed patch was rejected on the basis that it was organized
>>> the code in a wrong way.  And your patch shows how it should be
>>> done.
>>
>> In your opinion.
>>
>> The fact that nobody outside of 'git' will ever use
>> init_copy_notes_for_rewrite() still remains. Therefore this
>> "organization" is wrong.
>
> That is a fact?

No, it's not.

> It is your opinion on what might happen in the future.

That's right, an informed opinion.

> And you ignored external projects that may want to link with
> libgit.a,

Like which project?

Moreover:

% find /opt/git -name '*.a'

Returns nothing. The cannot link to libgit.a, and besides, we don't
provide a public API at all.

> and closed the door for future improvements.  Johan's
> implementation has the same effect of allowing sequencer.c to call
> these functions without doing so.

That would be closing the door to ghosts.

Do you want to bet? Five years from now nobody will be using
init_copy_notes_for_rewrite().

You loose, we move it to builtin/lib.a, you win, we don't.

> Anyway, I have a more important thing to say.
>
> You sometimes identify the right problem to tackle, but often the
> discussions on your patches go in a wrong direction that does not
> help solving the original problem at all.

So what? I'm a human, am I not allowed to make mistakes?

You make mistakes too.

> The two examples I can immediately recall offhand are:
>
>  (1) a possible "blame" enhancement, where gitk, that currently runs
>      two passes of it to identify where each line ultimately came
>      from and to identify where each line was moved to the current
>      place, could ask it to learn both with a single run.

Yes, *I ACKNOWLEDGED* the direction was not the right one, and I
didn't have the time nor the patience to go into such a tedious
direction.

>From my recommended guideline:

* Accept comments on your reviews gracefully. If the original patch
submitter doesn't agree with your review, don't take offense. Don't
assume the submitter has to automatically modify the patches according
to your comments, or even necessarily seek a compromise. The submitter
is entitled to his opinion, and so are you. Also, remember that each
person has their own priorities in life, and it might take time before
the submitter has time to implement the changes, if ever. The changes
you request might be beyond the time the submitter is willing to
spend, and it's OK for him to decide to drop the patches as a result.
You can help by picking the patches yourself in those situations.

>  (2) refactoring builtin/notes.c to make it possible for sequencer
>      machinery can also call useful helper functions buried in it.

You are wrong. My patches did solve the original problem, I know
because I was the one that found the original problem.

> The solution to these problems is
> for contributors and reviewers to _collaborate_ to come up with a
> better end result, which is often different from both the original
> patch and the suggestions in the initial review.

Collaboration requires both sides to work on the problem. Not one side
pointing fingers and the other side doing all the work.

> When it is your patch, however, we repeatedly saw that the review
> process got derailed in the middle.

When working collaboratively it's fine to disagree, and it's fine to
have two sides come up with two different patches.

If you disagree with the other side, send a patch that does it properly.

If the other side doesn't do *exactly* what you want, that's not the
review process being derailed.

> If there is no will to collaborate on the contributor's end,
> however, and the primary thing the contributor wants to do is to
> endlessly argue, the efforts by reviewers are all wasted. We do not
> get anywhere.

In order to have and endless argument, *both sides* need to be engaged
in the argument. If you decide that a disagreement has been reached,
the argument ends in a disagreement.

> That is how I perceive what happens to many of your patches.  I am
> sure you will say "that is your opinion", but I do not think I am
> alone.

The opinion of a billion people is still an opinion.

> But the thing is, that majority is what writes the majority of the
> code and does the majority of the reviews, so as maintainer I *do*
> have to give their opinion a lot of weight, not to mention my own
> opinion about how to help keep the community the most productive.

Indeed, but that doesn't make it a fact. It remains an opinion.

> And I have to conclude that the cost of having to deal with you
> outweighs the benefit the project gets out of having you around.
> Therefore I have ask you to leave and not bother us anymore.

We shall see.

[1] http://article.gmane.org/gmane.comp.version-control.git/225325

-- 
Felipe Contreras
