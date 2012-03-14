From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 16:23:33 +0300
Message-ID: <CAHkcotgMgqr29WEQfiH+89JVbTAAQyLwscXRtTyrf3JRxEuVbA@mail.gmail.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com>
	<4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com>
	<vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
	<vpqhaxrzh2a.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 14 14:23:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7oB3-0001mv-AL
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 14:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030816Ab2CNNXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 09:23:36 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42904 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761067Ab2CNNXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 09:23:35 -0400
Received: by eekc41 with SMTP id c41so838894eek.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 06:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bMpPV7ddUWqhMA/Wg6HiXbMkRuJ4oyyiKWThKP+7Ci0=;
        b=1AwuEMQKUJPxh5marKGem6liPxsoaa8Q1p8yjiPFVj4oZ0jDz7iQydZ0jswZq3hGmo
         X/zaXFr2FUcNsnuOl+0GuDhjH2AaNDrJ4Wk0HENJzFmrQNZ/Ch/2WGS6woZexZDfApby
         SfsqGSk4Rz8U/2X30uz39ZLYQvA8dvkNog4l5wwKwKcyj19ihnRkM0NJ/zjqiPLqanCZ
         KUb+NcOmRqu0F/Rz2oZatLbNWCVDBlbVRWK00eySRD6cqjW5v2TLp15gORvnBVkTNEGU
         i6GmJ+GCBSGEBhE8+N4qjh6hzVsqDSGdlu+UA3tGi8GKTqvXmru2FS+ZrExgAJ46VrIa
         bM5g==
Received: by 10.224.174.76 with SMTP id s12mr3065619qaz.11.1331731413690; Wed,
 14 Mar 2012 06:23:33 -0700 (PDT)
Received: by 10.229.135.130 with HTTP; Wed, 14 Mar 2012 06:23:33 -0700 (PDT)
In-Reply-To: <vpqhaxrzh2a.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193104>

On Wed, Mar 14, 2012 at 1:07 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Dmitry Potapov <dpotapov@gmail.com> writes:
>
>> If there is a centralized workflow with only one branch then
>> everything is simple, but it is not so with other workflows.
>
> I don't get this. With either 'current' or 'upstream', both pull and
> push deal with one local and one remote branch. The only asymetry is the
> case of non-fast forward (push fails, pull merges). But it's all about
> transmitting changes from a branch to another, in one or another
> direction.

If a user has 'master' after cloning and then create another branch
with different names, are you sure that the user expects that this
second branch to be pushed to a remote 'master'? And then what about
his stale local 'master'?

Those who understand the concept tracking may be happy with 'upstream'
but when it comes to the least surprise principle for beginner , I
believe 'current' is better. Maybe it would be even better if it did
not create a new remote branch without asking first:

Staying on foo-branch, you do:
 $ git push
Warning: foo-branch does not exist on the remote, if you want to
create it, type: "git push foo-branch"

In this way, it will be safer.

>
>> Moreover, doing 'git pull' too often (unless it is 'git pull --rebase)
>> pollutes history with useless merges, making more difficult to review
>> changes, or doing git-bisect.
>
> What's your point here? How does it invalidate the rule of thumb above?

The point is that you still need to understand what you are doing. It
is not 'pull' magically resolve the problem. On the other hand, if you
really want a workflow similar to CVS then you need "git pull --rebase"
(you can configure 'pull' to do rebase by default, but beginners do not
know about it).

BTW, whether you do merge or rebase, you still need to test the result
before pushing. Even if there was no conflicts, it may not work anymore.
And while you are merging and testing everything, somebody else could
push his changes. So, a centralized workflow may appear simple, but it
does not scale well, and often leads to many untested and hastily merged
commits.

>> I agree that the current diagnostic is not suitable for beginners.
>> Not-fast-forward push is something that beginners should never use,
>> but from this message is not clear what is the alternative to forcing
>> non-fast-forward push.
>
> Again, what would you suggest? Teach --force to beginners?

Not of course. I said above non-fast forward push should not be used by
beginners. However, if you have branches and merge them (using 'pull' or
'merge'), it is silly pretend that they do not exist. If you happy with
CVS-like behavior then just do "pull --rebase".

>
>>> One can easily get in this situation even in a kernel-style workflow:
>>> work from your desktop, push, work from your laptop, try to push and it
>>> fails.
>>
>> IMHO, when you often switch between your desktop and laptop, 'matching'
>> makes much more sense.
>
> Then, if you worked on branch 'foo' from your desktop, and 'bar' on your
> laptop, you'll get errors about non-fast forward push from both machines.

Right... and then I look at the cause, and usually I have made some
minor fixes to some series of patches. So when I make my mind, I do
non-fast forward push, but I do not think it is how beginners should
start to use 'git'.

>
>> If 'push' fails then usually I want to force non- fast-forward push,
>> because the new series contain reworked patches that already were on
>> the other computer.
>
> ... but if they were not, you've just silently errased your previous
> work. I have no problem with you working like this, but please don't
> teach that to beginners.

Basically, it is same as doing 'git reset --hard somewhere'. I use it
sometimes, but I have never suggested that for beginners...


Dmitry
