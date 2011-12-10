From: Adam Spiers <git@adamspiers.org>
Subject: Re: git-work, git-base: an example of how to use it.
Date: Sat, 10 Dec 2011 15:54:48 +0000
Message-ID: <CAOkDyE8BZgVw7TYydz7+WnJ_7EjPeEcVUzjFV+NGRuDn2+cg6g@mail.gmail.com>
References: <BANLkTim07-a5VwSAt7_vLMzOES_JZad9DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 16:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZPGK-0004fQ-5e
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 16:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab1LJPyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 10:54:52 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48743 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1LJPyv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 10:54:51 -0500
Received: by wgbdr13 with SMTP id dr13so7852563wgb.1
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 07:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=aZpw1nbTFPrBCV+c0qDYjMyJVmxXf9cvf4UtQUSNo2Y=;
        b=R02QGXQYYN+rNFYH13wAVDE15gKJohdDb2encwzA84HYdPNAEgbx7NkuaO665gF3kb
         jKx53N2i68D25dCXbslw7TQCjgkMsf+SdihzIqjdYS0zDN05cImWS2yXFDfsgymEQ/X+
         uRZbZfz5cmxJf8s3LOrUcgi0ge609QDPDgYB4=
Received: by 10.180.75.204 with SMTP id e12mr14873054wiw.61.1323532489001;
 Sat, 10 Dec 2011 07:54:49 -0800 (PST)
Received: by 10.216.243.199 with HTTP; Sat, 10 Dec 2011 07:54:48 -0800 (PST)
In-Reply-To: <BANLkTim07-a5VwSAt7_vLMzOES_JZad9DA@mail.gmail.com>
X-Google-Sender-Auth: 6NBOa9WzhWRO7gDDO3Tq74bNolw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186785>

Hi Jon,

I've only just discovered git-work, and it looks extremely
interesting.  From what I can tell so far, it is exactly what I was
looking for and could have recently saved me considerable pain!
Here's some initial feedback.

On Mon, Apr 25, 2011 at 11:43 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> I haven't had much feedback about git-work, to this point. Peter
> Baumann mentioned it was a little hard to grok.

I suspect that there is a strong correlation between these two points.
I also found it hard to grok, although I think this could be easily
fixed with a few tweaks to your existing docs.  Hopefully this would
result in more feedback.

First some comments about Documentation/git-work.txt:

The existing DESCRIPTION really isn't a description, but merely a
legend for the COMMANDS section, which is where it really should
belong IMHO.  Also, the first sentence refers to the "base" of
{branch} without explaining what that means.  This is currently the
first full sentence a potential user is likely to read about git-work,
but for me at least, unfortunately it triggered a "huh?" reaction
which sapped my will to continue reading.  Subsequently I discovered
that git-base.txt gives a definition of the "base" of a working
branch, but it's such a key ingredient in understanding the whole
workflow that it needs to be covered in the primary document, not in
the manual page for the git-base helper command which, if I understand
correctly, is rarely meant to be invoked directly by the user anyway.
Furthermore, the "base" is defined in terms of the user's "current
work", but that is not clearly defined.

In contrast, the contents of the DISCUSSION section are very helpful;
my initial reaction was "yes! this is exactly what I need!"  So I
think *this* should be the DESCRIPTION section, so that it's the first
thing a potential user encounters, other than the SYNOPSIS section
which by necessity of convention has to be at the top.  BTW, there's
an "integraton" typo which needs to be fixed.

The EXAMPLES section which immediately follows the DISCUSSION is just
sequence of one-liners and it's not clear how they are related to each
other (if at all), and why/when you would want to use each one.

It would be better if the EXAMPLES section showed a use case "story"
which starts with examples of simple usage and then builds up to more
sophisticated workflows.  You seem to have already started to address
this with your README.md example, but the first step in that is a 'git
add' without even explaining which branch you are on at the time, what
commits are already on that branch, or how it relates to other
branches.  So currently (for my small brain, at least) there is too
much of a "WTF" factor for it to be useful at first sight.

Perhaps part of the confusion arises from a clash between your concept
of a private working branch which is regularly rebased by 'git work',
and many people's concept of master, which is often a public branch
which as such is expected to be safe to regularly merge from.  Maybe
you could avoid this by recommending that a user adopting a workflow
based on 'git work' should use it to control an obviously private
branch, e.g. one named 'private' / 'working' / 'unstable' rather than
'master'.

In another email to this list (Subject: [PATCH 00/23] RFC: Introducing
git-test, git-atomic, git-base and git-work) you give some more
workflow examples, which are useful and could be incorporated into a
use case story.

A well-constructed story would answer questions implicitly raised
within the (current) DISCUSSION section, such as:

  - How are dependencies tracked?

  - Can you have chains of dependencies?  If so, what does the
    dependency graph look like?  Can a branch have multiple (direct)
    dependencies?

  - In what order are dependencies included in the base of the working
    branch?

By the way, one of the EXAMPLES one-liners is described as "start
gitk, showing only the current work", but looks like it might be a
typo; shouldn't it read:

    $ gitk $(git work)

?

Another suggestion to encourage people to try your work out: provide a
quick "how to try this out" guide, preferably one which doesn't
involve building the whole of git.

Finally, please wrap all lines in git-work.txt etc. to less than 80
columns to conform to existing style.  Currently these files are
unreadable in certain contexts, e.g.

  https://github.com/jonseymour/git/blob/master/Documentation/git-work.txt

due to the unreadably long lines.

I hope that's useful feedback.  I will continue experimenting with it ...

Adam
