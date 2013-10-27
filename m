From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Sun, 27 Oct 2013 20:10:36 +0100
Message-ID: <CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu>
	<20131027071407.GA11683@leaf>
	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>
	<20131027092019.GB13149@leaf>
	<CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	ksummit-2013-discuss@lists.linuxfoundation.org,
	ksummit-attendees@lists.linuxfoundation.org,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: linux-kernel-owner@vger.kernel.org Sun Oct 27 20:11:05 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VaVjs-00087T-Ki
	for glk-linux-kernel-3@plane.gmane.org; Sun, 27 Oct 2013 20:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab3J0TKi (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 27 Oct 2013 15:10:38 -0400
Received: from mail-vb0-f43.google.com ([209.85.212.43]:47471 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab3J0TKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Oct 2013 15:10:37 -0400
Received: by mail-vb0-f43.google.com with SMTP id g10so4099391vbg.30
        for <multiple recipients>; Sun, 27 Oct 2013 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j3D3s/hGdXmwtmpHCP4dslk5gKQDmldICwgPMpWYnoU=;
        b=tsW8G49YddCwKNJdOt4BMmwwrU6MBmG/TsGqmAqFqeIkFsCf1l5qPfRy4pekcwaft5
         zLxJo7WVt9Mam0t5mZ5e34Bdr4mNf/gXRxAYDW+nQ5HiX9sMVuE2kWgBNrQp9TI/OzMB
         kSY+2GnGRKQuUUvvnn/ksdQLRQZwZsCC0Z32j0FLuLilZZf5TbEE1k3I9v4sPNafcY5S
         FYSuiy5KjtDtYZaE88Wx3HdpjQDDTrgsKsWI78TZd3N2I66cGGnpFA7jnEhKEus4CqS1
         l2y4wtmYptj8dWtJEMD4bJOAiFptRByEvdgDAreal5X4fsp2GSrDkFQjFg5F9ddZsmH2
         WhHw==
X-Received: by 10.220.145.75 with SMTP id c11mr93532vcv.30.1382901036320; Sun,
 27 Oct 2013 12:10:36 -0700 (PDT)
Received: by 10.58.253.136 with HTTP; Sun, 27 Oct 2013 12:10:36 -0700 (PDT)
In-Reply-To: <CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236808>

[Sorry I already sent the reply below to Johan only instead of everyone.]

Hi Johan,

On Sun, Oct 27, 2013 at 11:59 AM, Johan Herland <johan@herland.net> wrote:
> On Sun, Oct 27, 2013 at 10:20 AM, Josh Triplett <josh@joshtriplett.org> wrote:
>>
>> ...good suggestion:
>>
>> ~/src/linux$ git log --grep='stable@' --oneline --since='1 year ago' | wc -l
>> 2769
>> ~/src/linux$ git log --grep='stable@' --oneline --since='1 year ago' --pretty=format:%an | sort -u | wc -l
>> 839
>>
>> Several thousand commits per year by hundreds of unique people seems
>> like enough to justify a short option.
>
> I think this can be solved just as well (if not better) using a
> combination of a commit message template (or a prepare-commit-msg
> hook) and a commit-msg hook.

Your suggestion is very good, and it is not incompatible with command
line options.
So both could be implemented and even work together.

For example if "-f ack:Peff" was passed to the command line, "git commit" could
lookup in the commit message template and see if there is one
RFC822-style header
that starts with or contains "ack" (discarding case) and it could look
in some previous commits if
there is an author whose name contains "Peff" (discarding case) and if
it is the case
it could append the following to the bottom of the commit message:

Fixes:
Reported-by:
Suggested-by:
Improved-by:
Acked-by: Jeff King <peff@peff.net>
Reviewed-by:
Tested-by:
Signed-off-by: Myself <myself@example.com>

(I suppose that the sob is automatically added.)

It would work also with "-f fix:security-bug" and would put something
like what you suggested:

Fixes: 1234beef56 (Commit message summmary)

> Then, the commit-msg hook can clean up and transform this into the
> final commit message:
>
>   My commit subject
>
>   This is the commit message body.
>
>   Fixes: 1234beef56 (Commit message summmary)
>   Reported-by: Joe User <j.user@example.com>
>   Improved-by: Joe Hacker <j.hacker@example.com>
>   Tested-by: Joe Tester <j.tester@example.com>
>   Signed-off-by: Myself <myself@example.com>
>
> Here, the commit-msg hook removes the fields that were not filled in,
> and performs additional filtering on the "Fixes" line (Adding commit
> message summary). The filtering could also resolve ref names, so that
> if you had refs/tags/security-bug pointing at the buggy commit, then:
>
>   Fixes: security-bug
>
> would be expanded/DWIMed into:
>
>   Fixes: 1234beef56 (Commit message summmary)
>
> Obviously, any other fancy processing you want to do into in the
> commit-msg hook can be done as well, adding footnotes, checking that
> commits are present in the ancestry, etc, etc.

Yeah, the commit message hook could do some more processing if the
user adds or changes stuff.

> Three good reasons to go this way:
>
>  1. If the user forgets to supply command-line options like -s,
> --fixes, etc, there is a nice reminder in the supplied form.

Great!

>  2. No need to add any command-line options to Git.

This is not a good reason. If many users prefer a command line option,
why not let them use that?

>  3. The whole mechanism is controlled by the project. The kernel folks
> can do whatever they want in their templates/hooks without needing
> changes to the Git project.

The Git project already manages sob lines. It would be a good thing if
it could manage
more of this stuff to help users in a generic way while taking care of
user preferences.

Best regards,
Christian.
