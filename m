From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: "git merge" merges too much!
Date: Tue, 1 Dec 2009 23:50:57 +0300
Message-ID: <20091201205057.GD11235@dpotapov.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com> <20091129051427.GA6104@coredump.intra.peff.net> <m1NFAji-000kn2C@most.weird.com> <20091130192212.GA23181@dpotapov.dyndns.org> <m1NFXpl-000knKC@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 21:51:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFZh8-00044t-CB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 21:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbZLAUvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 15:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753824AbZLAUvP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 15:51:15 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61146 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbZLAUvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 15:51:14 -0500
Received: by bwz27 with SMTP id 27so3859233bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 12:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oJdTfS/lZL/u04SApMJpb+qNxkp+HoLeFJPR0ghJSEU=;
        b=X/Oassne7Gs9/u5t1jIkqd7O1SjnKsmnIlmUB8U8ck2t8Y153GgcCByfC0QC6NycUl
         +DcMJMghhwBJJeuOdo9fD2hGD9lypSczbPrTjuDgrHleZdytJCNVG1i5dpYERAq4jY0Z
         O7dD+yZlcNO8FTU9bn2gBV7Yl/bY5lxUi69Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=u04zoA3wXToqZNsi7gih2gn2X41N6sMG8oYFqsW86yIzngQWPCHf0cu6vEnKGlUVET
         btoqJXMQ9YOlQq4TBZpBEOoXRUxifRLv1sAj1N/EMVYB0lVO5uxpsE6nvLGVaq6pKf1L
         IUXMQFZjuE9aF1lvtC37UW/cfnUFiFezA/Qvs=
Received: by 10.204.154.213 with SMTP id p21mr28137bkw.163.1259700679462;
        Tue, 01 Dec 2009 12:51:19 -0800 (PST)
Received: from localhost ([91.78.50.138])
        by mx.google.com with ESMTPS id 14sm148916bwz.1.2009.12.01.12.51.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 12:51:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFXpl-000knKC@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134256>

On Tue, Dec 01, 2009 at 01:52:18PM -0500, Greg A. Woods wrote:
> At Mon, 30 Nov 2009 22:22:12 +0300, Dmitry Potapov <dpotapov@gmail.co=
m> wrote:
> Subject: Re: "git merge" merges too much!
> >=20
> > The key difference comparing to what you may got used is that branc=
hes
> > are normally based on the oldest branch in what this feature may be
> > included. Thus normally changes are not backported to old branches,
> > because you can merge them directly.
>=20
> Hmmm... the idea of creating topic branches based on the oldest branc=
h
> where the feature might be used is indeed neither intuitive, nor is i=
t
> mentioned anywhere I've so far read about using topic branches in Git=
=2E

Most things that we consider "intuitive" are those that we got used to.
Git is different in many aspect than other VCSes (such as CVS/SVN), and
the workflow that good for those VCSes may not be optimal for Git. Ther=
e
is a good description that provide basic knowledge how to use Git:

man gitworkflows

or online:

http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html

If you do not base your changes on the oldest branch then you will not
be able to merge changes, which implies you will have to cherry-pick
manually without ability automatic to track what changes were merged
and what were not, this is a recipe for a disaster...


> At the moment I'm leaning towards a process where the configuration
> branch is re-created for every build -- i.e. the merges are redone fr=
om
> every topic branch to a freshly configured branch forked from the
> locally supported release branch, hopefully making use of git-rerere =
to
> solve most conflicts in as automated a fashion as is possible.

I am not quite sure that I fully understood your idea of configuration
branches, but I want to warn you about one serious limitations of
git-rerere -- it stores conflict resolution per-file basis. This means
that if resolution of some conflict implies some change to another file
then git-rerere will not help you here. So, it handles maybe 80-90%
cases, but not all of them.

>=20
> Perhaps Stacked-Git really is the best answer.  I will have to
> investigate more.

There is also TopGit. I have never used any of them, but if you are
interested in patch management system, you probably should look at both
of them. StGit is modelled after quilt, while TopGit is aimed to be
better integrated with Git and better fit to work in distributed
environment. But as I said, I do not have any first hand experience
with any of them. (Personally, I would look at TopGit first, but maybe
I am biased here).

> >=20
> > $ git branch new-foo foo
> >=20
> > $ git rebase --onto newbase oldbase new-foo
>=20
> Hmmm.... I'll have to think about that.  It makes some sense, but I
> don't intuitively read the command-line parameters well enough to
> predict the outcome in all of the scenarios I'm interested in.
>=20
> what is "oldbase" there?  I'm guessing it means "base of foo" (and fo=
r
> the moment, "new-foo" too)?

You have:

 o---o---o---o---o  newbase
       \
        o---o---o---o---o  oldbase
                         \
                          o---o---o  foo


and you want this:

 o---o---o---o---o  newbase
     |            \
     |             o=B4--o=B4--o=B4  new-foo
      \
       o---o---o---o---o  oldbase
                         \
                          o---o---o  foo


Dmitry
