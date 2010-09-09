From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Coping with the pull-before-you-push model
Date: Thu, 9 Sep 2010 13:06:38 +0000
Message-ID: <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
References: <4C8866F9.1040705@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 15:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otgq1-00017x-As
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 15:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab0IINGl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 09:06:41 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54024 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab0IINGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 09:06:39 -0400
Received: by gxk23 with SMTP id 23so582844gxk.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8X1csClZWQQdROy0c7UkPB2qo+OxEdvgiyTLM2uwI/I=;
        b=aChxh7yRy/wqY8b0OI1u1sy3g+68vx6HPu6zQO+2Ic4udG7EGvLlkyu55e9MQ7EbEn
         Lya4MEnNwHFWrBO9uUH1RGT3KT/Dj3iUD3AEXMhp/BAEovv9nBZIDV6aC7Om90hxNrY/
         EQaD2zGiBbZMfYz+WqTZYUq18QWZaDLhVoCkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VstAFIIT5Zhu5mp/aFh4n745piu6UMKJDVYep8EAyklF8qUo1exBjAR7r2iyv8lvHO
         vkiSmiAkxytZZZsCz367VMDWgb9RrmUwJDFqscu6EPigtNazEZ6D1zAfVz4Z1L6vDREI
         Dy833Y6XdGqcCw8G9VLME/u4JgOuUEgBkqCZM=
Received: by 10.100.127.5 with SMTP id z5mr254750anc.47.1284037598961; Thu, 09
 Sep 2010 06:06:38 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 9 Sep 2010 06:06:38 -0700 (PDT)
In-Reply-To: <4C8866F9.1040705@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155856>

On Thu, Sep 9, 2010 at 04:47, Joshua Jensen <jjensen@workspacewhiz.com>=
 wrote:
> =C2=A0After a deployment of Git on a centralized server at my place o=
f business,
> the largest amount of grumbling has been with the pull-before-you-pus=
h
> model. =C2=A0Coming from the file-centric Perforce where you need onl=
y have
> latest of just the files you are submitting, the pull-before-you-push=
 model
> has really been a pain in the neck for a large team.
>
> Even with topic branches being used, merges to master occur frequentl=
y. =C2=A0It
> can really be a frustrating battle to get your merged branch pushed t=
o the
> central master branch. =C2=A0In the time it took you to pull, test, a=
nd push,
> someone has probably already pushed before you. =C2=A0To cope with th=
is, people
> will pull, not bother testing, and immediately push their changes. =C2=
=A0Yes,
> this could result in build instability, but it is considered better t=
han
> never being able to make your change live.
>
> (Let's ignore what we should or shouldn't be doing as far as 'develop=
ment
> practices'. =C2=A0:) =C2=A0We're solving the problems one step at a t=
ime...)

Let's not ignore that.

Presumably you had exactly the same problem in perforce, i.e. because
you only had have the files you were changing checked out in Perforce
in the time between `hack && pull && test && push` someone else might
have already pushed. Thus what you just submitted wasn't guaranteed to
pass tests.

So is the flow in Git where you don't run the tests again, rebase and
push and hope for the best any different?

> Gerrit provides a compelling model where branches are pushed to the c=
ode
> review server in the form refs/for/master, and the given push will al=
ways
> succeed. =C2=A0Code reviews are performed, someone sets the verified =
bit, and the
> change is submitted and merged to master by Gerrit itself in a queued
> fashion. =C2=A0Unfortunately, its general "requirement" to squash you=
r branch
> down to a single commit is, possibly, a showstopper. =C2=A0If it trea=
ted a branch
> merge as a group of commits that MUST stay together, that would be pe=
rfect.

This sounds like something that's configurable in Gerrit, or should
be.

> [..]
>
> Is there another workflow that is successful for your large(-ish) ent=
erprise
> team?

Linux manages to deal with a huge number of commits, but does so by
having subsystems.

Maybe that's something you can use in your codebase?
