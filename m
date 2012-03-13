From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Tue, 13 Mar 2012 21:08:52 +0300
Message-ID: <CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com>
	<4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com>
	<vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 13 19:09:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7W9c-0000y9-Jq
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 19:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758773Ab2CMSIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 14:08:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53407 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758255Ab2CMSIy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 14:08:54 -0400
Received: by yhmm54 with SMTP id m54so836719yhm.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dPVMpDXfJrCbTKCZPKrpo8RttUQIEvSO68WGtZhjPdY=;
        b=HksgPImfTkDWkqthxVZI5K9YtBxhDWmFOcwj1L8QPYHUmlC+JuWquToQ333pChFaRD
         GO0yGclqZCKzGTmHFe+w9LrhTTI5gqPelS76DnZm61sM0ZCwYNdZYu2tBLCyvzvkvBml
         J3Ewk5wpENmKpZH+hJ/vNpK767NaMyL01MZ8qSRlSAFPdrOi7T66GEdEvzopg1oZgMAS
         0y81eu5qpc7TaUamox7METk7cye1lxKCOQlC9q8/oeAd40fONt8ufBHW0ky+evwuPwBq
         pMvLX6gPmUIMytiNLdNGvpuOXHqbRJwKOx/VIhJInLH9ZJZ8fAUw7RJJgZB6uXzVzeQK
         FtQQ==
Received: by 10.224.52.83 with SMTP id h19mr13725800qag.24.1331662132697; Tue,
 13 Mar 2012 11:08:52 -0700 (PDT)
Received: by 10.229.135.130 with HTTP; Tue, 13 Mar 2012 11:08:52 -0700 (PDT)
In-Reply-To: <vpqy5r44zg7.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193049>

On Tue, Mar 13, 2012 at 1:34 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jeff King <peff@peff.net> writes:
>
>> =A0 1. If you are a new user who does like the implicit merge, you m=
ay
>> =A0 =A0 =A0find it convenient not to have to learn about "git checko=
ut; git
>> =A0 =A0 =A0merge topic ; git push remote master". But it only helps =
you
>> =A0 =A0 =A0_sometimes_. If master has had other work built on it, yo=
ur push
>> =A0 =A0 =A0will fail, and you will have to do the merge yourself. So=
 it is
>> =A0 =A0 =A0only helping you by omitting a step some of the time, and=
 you still
>> =A0 =A0 =A0have to learn why the step is sometimes necessary and som=
etimes
>> =A0 =A0 =A0not.
>
> There's a rule of thumb which works very well for beginners: when "gi=
t
> push" tells you to pull before, then pull before. This rule of thumb
> works, but only provided "push" and "pull" are symmetrical.

I am not sure what you mean by symmetrical here, because they are never
truly symmetrical as "pull" does merge and "push" does not. If there is
a centralized workflow with only one branch then everything is simple,
but it is not so with other workflows.

Moreover, doing 'git pull' too often (unless it is 'git pull --rebase)
pollutes history with useless merges, making more difficult to review
changes, or doing git-bisect.

> Now, if pushing sends commits to a branch other than 'upstream', you =
can
> get the following scenario:
>
> $ git push
> To bla
> =A0! [rejected] =A0 =A0 =A0 =A0master -> master (non-fast-forward)
> error: failed to push some refs to 'bla'

I agree that the current diagnostic is not suitable for beginners.
Not-fast-forward push is something that beginners should never use,
but from this message is not clear what is the alternative to forcing
non-fast-forward push.

> One can easily get in this situation even in a kernel-style workflow:
> work from your desktop, push, work from your laptop, try to push and =
it
> fails.

IMHO, when you often switch between your desktop and laptop, 'matching'
makes much more sense. If 'push' fails then usually I want to force non=
-
fast-forward push, because the new series contain reworked patches that
already were on the other computer.

>
> Back to my students, most of them will never get in this situation
> because they won't use branch, so HEAD =3D master and upstream =3D
> origin/master,

So, there is no real difference between 'current' and 'upstream' for
them.

> but the not-so-newbies may get this once they start
> creating branches ifever they have HEAD =3D topic-branch and upstream=
 =3D
> origin/master for example.

The real question is what one expects from 'push' in that situation. It
could be pushing this branch back to the upstream branch or creating a
new feature branch in the upstream.

>
>> So far a lot of the discussion has focused on "what is the most sens=
ible
>> default for the most number of people". But I wonder if a better
>> question is "what is the default that is the least likely to do
>> something dangerous and embarrassing".
>
> I think "what's the most intuitive" is also very important.

But it depends on the workflow that is employed by the project.
Different projects may have different workflows. We can assume that
the person who sets up the repository has good knowledge of Git and
how to use it, but many others who work on the same project may not
know Git well. For them "the most intuitive" means whatever policy
this project has.


Dmitry
