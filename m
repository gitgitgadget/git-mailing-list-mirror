From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: "git merge" merges too much!
Date: Wed, 2 Dec 2009 03:22:01 +0300
Message-ID: <20091202002201.GG11235@dpotapov.dyndns.org>
References: <m1NEaLp-000kn1C@most.weird.com> <20091129051427.GA6104@coredump.intra.peff.net> <m1NFAji-000kn2C@most.weird.com> <20091130192212.GA23181@dpotapov.dyndns.org> <m1NFXpl-000knKC@most.weird.com> <20091201205057.GD11235@dpotapov.dyndns.org> <m1NFak0-000kn2C@most.weird.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: The Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 01:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFczM-0006Kp-8t
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 01:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZLBAWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 19:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbZLBAWT
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 19:22:19 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64957 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbZLBAWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 19:22:18 -0500
Received: by bwz27 with SMTP id 27so3984388bwz.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 16:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OEkhotfdXa2kb2scDgMZouArMd4ZRumo7aS5SFYbueI=;
        b=IkVwmQyexZP12kTi4MM3k4YEMvQUHr817CyaLlsENniI8rQXLfIq0uqeovwnTv3gha
         /2HN6JcxI3W0G7SFrrFeek6epKpVfJPFtxjRro9pLas2Owar/y8NFAdYXqhYty05Gn+L
         4NRO1Ayz/Jkf+0NMBgDiVHErWZdTXNuVLe1XE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oky6s1gCAKz7xG+3B4Omdy3QaCIQacxpamAeDwrYdF5+b3uBogFnnAcoSKyw3itZ4y
         jQOPRFMPvzAMazirfca3OLKAZvinRvAUyBm3dJgExdS/8E+YLqmjOPRq/buhzot/+A7T
         3be/aOQY9Ow1LJgAkvOFvaRtlvW9yJOd0mfOU=
Received: by 10.204.32.209 with SMTP id e17mr229399bkd.84.1259713343135;
        Tue, 01 Dec 2009 16:22:23 -0800 (PST)
Received: from localhost ([91.78.50.138])
        by mx.google.com with ESMTPS id 15sm180509bwz.8.2009.12.01.16.22.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 16:22:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m1NFak0-000kn2C@most.weird.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134271>

On Tue, Dec 01, 2009 at 04:58:34PM -0500, Greg A. Woods wrote:
> At Tue, 1 Dec 2009 23:50:57 +0300, Dmitry Potapov <dpotapov@gmail.com> wrote:
> Subject: Re: "git merge" merges too much!
> > 
> > > > 
> > > > $ git branch new-foo foo
> > > > 
> > > > $ git rebase --onto newbase oldbase new-foo
> > > 
> > > Hmmm.... I'll have to think about that.  It makes some sense, but I
> > > don't intuitively read the command-line parameters well enough to
> > > predict the outcome in all of the scenarios I'm interested in.
> > > 
> > > what is "oldbase" there?  I'm guessing it means "base of foo" (and for
> > > the moment, "new-foo" too)?
> > 
> > You have:
> > 
> >  o---o---o---o---o  newbase
> >        \
> >         o---o---o---o---o  oldbase
> >                          \
> >                           o---o---o  foo
> 
> Yes, sort of -- in the ideal situation, but not in my particular example
> where "oldbase" is just a tag, not a real branch.

It does not matter whether it is tag or branch or just SHA-1. You can
use any two reference as newbase and oldbase. They specify two points
in DAG. The only thing that has to be a branch in my example is new-foo.

> 
> So yes, "oldbase" is in fact "base of foo".  Trickier still is when the
> "oldbase" branch has one or more commits newer then "base of foo".  Does
> Git not have a symbolic name for the true base of a branch?  I.e. is
> there not some form of symbolic name for "N" in the following?
> 
>    o---o---o---o---o---o---o---o  master
>             \
>              o---o---N---o---o  release-1
>                       \
>                        o---o---o  local-release-1

You can always find SHA-1 for N using the following command:

  git merge-base release-1 local-release-1

but you do not have to do that to rebase your changes. You just can run:

   # create a copy of local-release-1, so it will not disappear
   git branch copy-release-1 local-release-1

   # rebase the branch to master
   git rebase --onto master release-1 copy-release-1


Dmitry
