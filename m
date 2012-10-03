From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 15:35:31 +0200
Message-ID: <CAB9Jk9DmFQcgd2jT4c1eMx91mikchVcKfNVLsmfjxaZL_G3vTQ@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<vpqvcer4xvo.fsf@grenoble-inp.fr>
	<CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
	<CABURp0oHez6j8+FPG8Zm52TGVyC1XwWhE55TBDrXRGFrW6kWww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:36:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJP73-0000hZ-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241Ab2JCNfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 09:35:33 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50196 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab2JCNfc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 09:35:32 -0400
Received: by vcbfo13 with SMTP id fo13so8247260vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=a3kvQWTOdD9CIj5I2znU3gJnMUSkIGHlH9ii+i6STTc=;
        b=CE/ZSWXXdI+lEGB4dXb0vlNer87LTpoSXepNHdP8vATOqciIW9iZUA6EEGxSnMcTLS
         ZwwBCses8ZhCsTt1nzA9c9PFi7mpSjTzjLW/7/y79I1vAtthwKc5Mfxy0KXUCp/WpZGz
         SUJ6OJQMWOnJihDnCJOcn+zel1znGThOa4xq/ocyydWJ4UNV8avKw/xdXznJBu00RvBR
         8mQR9j8RKlH33VsHZ3FA4pCHrwpsFVidQFZIJFJarGBOn5QNbvXppZQo2tf+k9Wdt4C2
         wcoB7BQAxYOxTVw8KPwe3i395f7j20sEUMj8IZ/72HHnFtscVTZ9BsYLoE0a0MR2ouYM
         Uctw==
Received: by 10.52.36.76 with SMTP id o12mr939225vdj.40.1349271331632; Wed, 03
 Oct 2012 06:35:31 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 06:35:31 -0700 (PDT)
In-Reply-To: <CABURp0oHez6j8+FPG8Zm52TGVyC1XwWhE55TBDrXRGFrW6kWww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206891>

Hi Phil

>
> I think what you are missing here is that the script does _not_ have
> to take care for this special case.  The script can do the same thing
> it does for all the other cases and it will work just fine.  This is
> because your goal, as I understand it, is this:
>
> A. Take this branch,
> B. Copy it but remove the binaries,
> C. Push it to the remote (with no binaries)
>
> If the branch has no binaries to begin with, then B is a no-op.  Your
> insistence that the new commits get unique SHA1's is unnecessary and
> is what is causing your trouble.

Suppose the branch has binaries. Then the only way to avoid to push
them is to create an orphan branch (one that has no parents),
otherwise git push will upload also the parent with its binaries.
This is why there is a need to make the script perform different
actions depending on the presence of the binaries. In the attempt to
make the script handle both cases in a simple way I tried to make an
empty commit, and discovered the time-dependent behavior of it.

>
> Consider this analogous operation:
>
> A. Take this file,
> B. Remove every line that does not contain foo,
> C. Cat the result to the console (with only foo lines)
>

This example differs from the commit one in that the user has to cope
with data that s/he can fully control (the contents of files), while
in the other s/he has to cope with the passing of time, which s/he
cannot control. So, taking the files I can predict the result, but
taking the commits, I cannot because I do not know exactly when they
will actually be run. Time is a sort of independent variable that I
know only approximately (or very approximately when the commands are
embedded in scripts).

>
> It seems to those more familiar with git that you are saying that this
> is "the problem", that the operation did not work because the results
> are not unique each time.

Exactly.

>
> But if you ignore the SHA1 of the commits and just rely on the branch
> names, I think you will be happier.  This is because two branches can
> refer to the same SHA1 commit without causing any problem.  You may
> find that sometimes when you push there is no update applied to the
> server.  But this is not a mistake.  It is simply that the server
> already has the same contents as you are pushing, even though your
> local branch name is different than it was before.

Actually I ignore the SHA1 of the commits, and rely on the branch
names I have topic branches and /src/topic branches. Developers push
when they have something new. Of course the scripts must take care of
when they are called and there is nothing to push, but that is not a
big problem.
I eventually found a workaround, which is to change the commit
message, forcing then git commit to create a brand new commit.

> I think when you say "orphan" you mean it has a different SHA1 than
> any other commit.  But this is not what "orphan" means.

No, I mean that it has no parents.

Actually, in the special case in which there are no binaries, I could
create a branch that points to the same commit as the branch that it
is mirroring, and push it. However, this has two disadvantages: 1.
that it will not be an orphan while in the more general case it is,
and 2, that the history of commits will be pushed to the remote
server, while in the general case (with an orphan) it will not. I
preferred to have a unique branch topology so as to make the picture
as simple as possible for the developers.

Note that eventually I solved the problem with a tweak. I still
believe that the git commit command does not behave properly, and that
changing nothing (implementation or documentation) leaves a drifting
mine on which someone (or even myself) will stumble sooner or later. I
am spending time to write all this because I care for git and I would
really see it improving over time removing weak spots, and believe
that you do the same.

-Angelo
>
> Phil
