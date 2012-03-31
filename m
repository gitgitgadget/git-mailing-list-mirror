From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: push.default: current vs upstream
Date: Sat, 31 Mar 2012 15:49:09 -0700
Message-ID: <CA+7g9JxK5DHj3vbdGgF2dEJxvn=_ZfjAv7Y+AL_P-aO1FVB6-w@mail.gmail.com>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
	<20120329095236.GA11911@sigill.intra.peff.net>
	<7vbonfqezs.fsf@alter.siamese.dyndns.org>
	<20120329221154.GA1413@sigill.intra.peff.net>
	<7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
	<20120330071358.GB30656@sigill.intra.peff.net>
	<7vty15ltuo.fsf@alter.siamese.dyndns.org>
	<20120330210112.GA20734@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 00:49:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE777-0002sC-LN
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 00:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab2CaWtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 18:49:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56143 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab2CaWtL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 18:49:11 -0400
Received: by bkcik5 with SMTP id ik5so1519408bkc.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 15:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=1j3rwp9jSCxRBOIRYnnmCf4CTandYstFWbS2+6Sqcb4=;
        b=owq+/gWTYukUI44mrZDbAkiZ95+yOGrZbyuZW4eomA8BRbfjqiSiYnBLIuxrPyhwBS
         qzcvXlBaYMocC5xJNZ29RCRef8zbG58EXPdiPIYy5xMLw8zSYFdBrRVq96LQvtoE0iRu
         X5+e7L1ovn9IDnisbuMxXDh+SaP40poaefaBslIKej1fk/HLjfuRXY+tIHsSegro+5fJ
         +P4qY+VNOCV381a//2/ozSOSk7ExMInwib5qsYlSS+IH+5YGqN75kmYpU/jebqltE7TI
         4DhqiAwqmlGalnUCGJ4jIoAdovbtLneHJrrhb9ALsdasLJlivfr8I1My3s/IEml+7oYi
         p8xg==
Received: by 10.204.145.81 with SMTP id c17mr1442208bkv.39.1333234149458; Sat,
 31 Mar 2012 15:49:09 -0700 (PDT)
Received: by 10.204.128.200 with HTTP; Sat, 31 Mar 2012 15:49:09 -0700 (PDT)
X-Originating-IP: [66.75.229.176]
In-Reply-To: <20120330210112.GA20734@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQnIHp1IjeqYoGgNxtM/QRkR4F/WeADXVdtoiN/ePSTD9jIAUKvuuJ+Gdm1cLveHo6F+Nh7L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194470>

On Fri, Mar 30, 2012 at 2:01 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 30, 2012 at 01:25:03PM -0700, Junio C Hamano wrote:
>> > my two concerns is that this:
>> >
>> > =A0 $ git clone ...
>> > =A0 $ git checkout -b topic origin/master
>> > =A0 $ hack hack hack
>> > =A0 $ git push
>> >
>> > will try to implicitly fast-forward merge your commits onto master=
=2E
>>
>> And the reason why it is surprising to the beginners is? =A0Because =
"topic"
>> and "master" (of "origin/master") are not the same name?
>
> Sort of. It is more because "upstream" is an overloaded concept. Perh=
aps
> you created the branch from origin/master because you wanted to say
> "this is where my topic is based, and when I 'rebase -i' later, I wan=
t
> it to be considered the baseline". Or perhaps you meant to say "I am
> going to work on origin's master branch, but I would prefer to call i=
t
> 'topic' here".
>
> In the latter case, pushing back to origin/master makes sense. They a=
re
> forks of the same branch to you, and pushing back is how
> you will share your changes to master. But in the former case, you ma=
y
> or may not consider them the same branch, and you may be pushing simp=
ly
> to share your work-in-progress of the topic. Putting that work onto
> "master" would be confusing in that case.
>
> Note that "current" has the same assumption in reverse. If you create=
 a
> local "master" branch (whether or not it is based on a remote
> "origin/master"), you may or may not mean them to be the same branch.
>
> So we have to decide when two things are forks of "the same branch", =
and
> when it is merely "X is based on Y", or "X happens to have the same n=
ame
> as Y". And I think the "name is the same" semantics are way more
> obvious.

I'd like to offer my strong agreement as somebody who has just led his
team through a transition from svn to git.  Branch names are really
important to people.  If they've decided to branch "origin/master" as
something that's not called "master", there's a really good chance
that they mean it to be a new branch.  I think it's also really
important to consider the consequences of getting it wrong under
either scenario.

If a user does some work on his new "features/frobnitz" branch and
does a "git push" only to find that his work has been committed to the
company's master branch he will be confused, frustrated, and publicly
embarrassed.  He then has to apologize and figure out how to revert
the changes.  I really don't see any scenario where that user ends up
saying "oh yeah, I guess git was right and I was wrong."

Compare that outcome to somebody who expects upstream behavior and
gets current.  That person pushes "features/frobnitz" expecting to see
his changes appear on "origin/master", only to find that they didn't.
Instead there's a new branch "origin/features/frobnitz".  Maybe it's
not what he expected but it's easy enough to understand.  He hasn't
inconvenienced anybody else, so there's no need for apology.  He just
takes a look at the docs and figures out how to accomplish what he
intended and deletes the branch he accidentally created.

It's this public vs. private embarrassment factor that motivated me to
recommend "current" as our company policy and most strongly convinces
me that "current" is the right default.

Cheers,
-Nathan

--=20
http://n8gray.org
