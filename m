From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] push: make upstream, simple work with pushdefault
Date: Mon, 10 Jun 2013 21:37:01 +0530
Message-ID: <CALkWK0mfWs3LBocvn=QMcX0_ZCROx4Nw=+xjpCbKLQU0JzSdXg@mail.gmail.com>
References: <1370798000-2358-1-git-send-email-artagnon@gmail.com>
 <1370798000-2358-3-git-send-email-artagnon@gmail.com> <7vip1moq3k.fsf@alter.siamese.dyndns.org>
 <CALkWK0mesZay8Cpi6yTvhUG=136=9JLyFUZXm8t_fMOrY0F62Q@mail.gmail.com>
 <7v4nd6l31d.fsf@alter.siamese.dyndns.org> <CALkWK0mY5=H6FoUZCOXTYykEV1f=3wrP21WPXj1v4VBCeOxocg@mail.gmail.com>
 <7vwqq2j7c9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Leandro Lucarella <leandro.lucarella@sociomantic.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 18:07:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um4dP-0004AV-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 18:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab3FJQHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 12:07:43 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:54148 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3FJQHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 12:07:42 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so3113282ied.14
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oV7RoHt290budAv6c7H7II7TA7+7AhQ9G5eehlMR/g8=;
        b=QVMtOZ479EgdolDlj294VJSvLEEdRid+xp7OMCkjOCR/wC+Op26r3mV+CCg4a3sDkx
         nag3LqllG4Gg+e1WjwB4KBtIlY+qm1hLlNISaQNOwM17xHwGOZKn28/yFe/tCX3fCADO
         75Meax24Hqodo6QwBT9AtaCzTsShWvmhlGCo6MspWZvSu0y0PLLiWmnUN0vAKwdV46J8
         NXduWZSSqSE6tjAwOHNnavL11PlACB19aPhvG6cqRnCupYI0V7CChU0CUsb67x+gNkPH
         8idnj84Je3ImmY/cyLQfbo7q5K226C/GrsxWxM45m2I3TsVTotQziKLnnzh7YZIggCu1
         ooeg==
X-Received: by 10.50.3.37 with SMTP id 5mr4309004igz.0.1370880462296; Mon, 10
 Jun 2013 09:07:42 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 10 Jun 2013 09:07:01 -0700 (PDT)
In-Reply-To: <7vwqq2j7c9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227313>

Junio C Hamano wrote:
> Only if I want to publish the result of the work forked from your
> "triangle" as my "triangle", but that is not the case.  A fork to be
> integrated by other is by definition more specialized than the
> original, and I would publish my "pushbranch" subtopic as such, not
> as "triangle".

Okay, so it should _never_ push out as "triangle", because it is an
insane default.

> But that is not what is happening, unless you keep thinking
> "push.default decides the name of the branch regardless of what
> repository it lives in", which is where our difference lies, I
> think.

I assumed that we want all push.default modes to do something
"sensible" in both central and triangular workflows.  push.default
dictating a push destination would break triangular workflows.  It's
very clear to me.

> Imagine the case where I forked two branches from your "triangle"
> topic and pushing them to my repository using the triangular
> workflow.  By your definition, they will both try to push to
> "triangle", which means you, the "triangle" topic maintainer, cannot
> receive two independent pull requests from me.  You can only get a
> single branch that pre-merges both, and if you want to get one but
> not the other, you have to do the untangling of these two topics.

Okay, you've made your point.  Due to namespace conflict, the solution
I proposed is not at all a "sane" default.  It's just confusing and
Bad (TM).

> I am not saying that you have to pick one to use for push.default
> among the remaining ones (i.e. matching, current, what else?).  It
> is very plausible that the triangular workflow wants a different
> logic to pick what branches are to be updated and how.  Perhaps we
> would want something that is capable of mapping your local branch
> name to a branch name suitable in your publishing repository, and I
> am not opposed to have such a mode.

Okay, we'll have to do some sort of split and mark push.default =
upstream/ simple suitable-only-for-centralized-workflows, or something
to that effect (deprecation?) :|

I'll try to think of something.
