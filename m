From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 07 Apr 2013 22:15:01 +0200
Message-ID: <5161D3C5.9060804@web.de>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com> <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com> <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com> <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com> <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com> <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de> <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p9-0000sy-Gg
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933538Ab3DGUPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 16:15:13 -0400
Received: from mout.web.de ([212.227.17.11]:54180 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933407Ab3DGUPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 16:15:12 -0400
Received: from [192.168.178.41] ([79.193.80.33]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MRD4x-1U25OM2EYB-00UGQu; Sun, 07 Apr 2013 22:15:02
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:dU1WHoF0E7riYLfP09kpfLzjNlSK4QoymzYxGvSk/kg
 mMvzWM0SHOkBVmdJTu/mWazV+3xUKuH2GqzaLk5aqw7iyeHbY1
 vmaiYYjBYDCCFtZK2ASToIsLe8dJi78JAhjcIfRWEmoAzEAsXt
 M//7hJM7Peqn9SAghItaMLjo3lC4u1lyhpnXr91TDStrxa3Amv
 K2Uc3fXe356V+w0veYcdw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220371>

Am 07.04.2013 20:44, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> The whole feature list is full of red herrings like this which
>> have nothing to do with the advantages of a new object, but talk
>> about UI issues which are easy to solve in both worlds.
> 
> Really?  git-submodule.sh was written in 2007, and does not have git
> mv or cd-to-toplevel restriction removed to date.  What does that say
> about git-submodule?

That there is still some work to do, which I never denied and am
actively working on (see "git mv" support in pu, which tackles one
of the UI issues you mentioned).

> I specifically said end-user's perspective.  Why exactly would I be
> talking about the advantages of the link object?

Because they are all that matters when it comes to decide if a link
object should be introduced to replace the current model. We should
discuss the differences in the UI that result from introducing such
an object, not the stuff that is still missing from our current
implementation (as that has to be coded either way and can not be
taken in favor of either solution). And we can additionally also
talk about the differences in hacking on git, where I concede that
putting everything into a single object could lead to shorter code
than having to consult a .gitmodules file for that (even though I
believe these arguments are much less important than UI changes).

Just to be sure: I think we agree that both approaches are capable
of allowing all relevant use cases, because they store the same
information?

Disclaimer: I am not opposed to the link object per se, but after
all we are talking about severely changing user visible behavior.
So I want to see striking evidence that we gain something from it,
discussed separately from UI deficiencies of the current code (no
cd-to-toplevel please ;-).

So I started putting together a list of advantages and one of
disadvantages of the new link object compared to the current model.
We can extend and refine that to see what your proposal would mean
for us. After all we are talking about severely changing user
visible behavior, so we need convincing reasons to do that.


Advantages:

* Information is stored in one place, no need to lookup stuff in
  another file/blob.

* Easier coding, as we find all information in a single object.

(I did not forget to add the point that you currently need a
checked out work tree to access the .gitmodules file, as there is
ongoing work to read the configuration directly from the database)

(Another advantage would be that it is easier to merge the link
object, but a - still to be coded - .gitmodules aware merge driver
would work just as well)


Disadvantages:

* Changes in user visible behavior, possible compatibility
  problems when Git versions are mixed.

* Special tools are needed to edit submodule information where
  currently a plain editor is sufficient.

* merge conflicts are harder to resolve and require special git
  commands, solving them in .gitmodules is way more intuitive
  as users are already used to conflict markers.

* A link object has no unstaged counterpart that a file easily
  has. What would that mean for adding a submodule and then
  unstaging it (or how could we add a submodule unstaged, like
  you proposed in another email)?

(I think when we also put the submodule name in the object we
could also retain the ability to repopulated moved submodules
from their old repo, which is found by that name)


I'm not saying that this list is complete, I just wrote down
what came to mind. When we e.g. find workable solutions to the
Disadvantages we can remove them from the list and append them
in parentheses for later reference like I did here. Does that
sound like a plan?
