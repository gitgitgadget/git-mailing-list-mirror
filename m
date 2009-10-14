From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when 
	appropriate to do so
Date: Wed, 14 Oct 2009 08:49:53 -0400
Message-ID: <76718490910140549l4a6b4f60je64d1b71a1a33d1d@mail.gmail.com>
References: <0016e68fd0123a175304754694b4@google.com>
	 <200910130836.57011.trast@student.ethz.ch>
	 <7vljjf226t.fsf@alter.siamese.dyndns.org>
	 <200910131051.47117.trast@student.ethz.ch>
	 <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0910132302380.4985@pacific.mpi-cbg.de>
	 <20091013220640.GB12603@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0910140117280.4985@pacific.mpi-cbg.de>
	 <76718490910131805o42e8321ama85b90b7e901dc7d@mail.gmail.com>
	 <7vfx9modqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 14:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My3Me-0005Xr-Hy
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 14:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759758AbZJNMub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 08:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759738AbZJNMub
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 08:50:31 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:37323 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755123AbZJNMua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 08:50:30 -0400
Received: by iwn10 with SMTP id 10so3318111iwn.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6s6suffyFpZKVYSLCK0EhlDyngH3e/2J1SW8pRJKfA8=;
        b=ejAZWaP2xDFVrfi9Fal4N/SvYvac1zMsljrhEalxsSgTEavO40lTzSUfV5Jw5F92R/
         OQ1Gu4/EZQkg+8C7gVhneSnnQONN+udM8yWovPZEpiAuvkQ5OJC1ggDKlwt+2s3R4CYC
         PhImViC6AYZetlM/oBHQQksjcdkpO27VPOB78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EVrw5Vf6hzIcmBnKUaP0y9SH/rMP3zx7V2lDGzCFkcuDHRY/Ir4LrRbbfEYm4yicfn
         g9i24Inu9N/CVJwdIynEXMa7zft6SyNG70mGC6TAxk4S/Qrd1rp4mZSz1+2fVtDKmh/8
         lZNkoDh12PE4a+83Bb83SE6x2RF+p09LfuB/g=
Received: by 10.231.117.215 with SMTP id s23mr3886174ibq.41.1255524594061; 
	Wed, 14 Oct 2009 05:49:54 -0700 (PDT)
In-Reply-To: <7vfx9modqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130287>

On Tue, Oct 13, 2009 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> When you do not have local "frotz" branch, and do have cloned/fetched=
 from
> the origin that has "frotz" branch, I am actually Ok with this
>
> =C2=A0 =C2=A0$ git checkout frotz [--]
>
> to do an equivalent of:
>
> =C2=A0 =C2=A0$ git checkout -t -b frotz origin/frotz
>
> I do not have problem with this _particular_ DWIMmery. =C2=A0It will =
not break
> people's expectations, other than "asking to check out non-existing r=
ef
> should fail". =C2=A0That expectation might be logical, but I do not t=
hink it is
> useful.
>
> Another reason I won't have problem with this one is that perhaps aft=
er
> creating a few more commits, the next day when the user does the same
>
> =C2=A0 =C2=A0$ git checkout frotz
>
> what will be shown is the _local_ frotz branch. =C2=A0Nowhere in this=
 sequence
> there is any room to mistake that you somehow checked out a branch ow=
ned
> by somebody else (namely, origin). =C2=A0You started by auto-creating=
 your
> local branch, worked on it, and checked it out again the next day. =C2=
=A0In
> other words, this is really about a shorthand to create a new local b=
ranch
> called "frotz" when the commit that the branch should start from is
> clearly unambiguous.

Okay, this is good, and I can work up a patch if no one beats me to the=
 punch.

> I have trouble with yours, on the other hand, which is to make
>
> =C2=A0 =C2=A0$ git checkout origin/frotz
> =C2=A0 =C2=A0$ git checkout v1.5.5
>
> into
>
> =C2=A0 =C2=A0$ git checkout -b frotz-47 origin/frotz
> =C2=A0 =C2=A0$ git checkout -b v1.5.5-47 v1.5.5

I suggested no such thing, at least, I don't think I did. What I said w=
as:

---snip---
Modify checkout so that the first commit while detached automatically
creates a branch. Perhaps the name is derived from the branch point,
or the user is prompted for a name.
---snip---

So we'd only automatically create a new branch at commit time. But
never mind that, it was just a suggestion and I don't like it.

What if instead we do something like this:

$ git checkout v1.5.5
Note: moving to 'v1.5.5' which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at 1d2375d... GIT 1.5.5
$ [edit foo.c]
$ git add foo.c
$ git commit -m "edited some file"
Cannot commit to v1.5.5. Please use git commit -b <branch> to specify
the name of a new branch to commit to, or use git commit --detach to
force a detached commit.

So we modify git to, by default, no longer allow creating a commit
while detached or on a branch that cannot be committed to.

j.
