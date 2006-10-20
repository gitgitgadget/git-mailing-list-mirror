From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 12:19:48 +0200
Message-ID: <200610201219.48921.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE> <a7e835d40610200126y5edc2ad0v8ca0a95655b2e029@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>,
	"Aaron Bentley" <aaron.bentley@utoronto.ca>,
	"Linus Torvalds" <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 12:19:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GarTk-0004Gc-5I
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 12:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWJTKTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 06:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWJTKTt
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 06:19:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:34460 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751483AbWJTKTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 06:19:48 -0400
Received: by ug-out-1314.google.com with SMTP id o38so707695ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 03:19:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ldgcnTScZiylpS7RR5EX9T6j1dXcaNZnXB9EBsypUTBSPj0JRhdWnUsEulTxmUz3lTsrHDw4XLVGj77ItQIVKkiAGvQ1JAMp0qyy69G/MtixRkuRI5oD0diWU/oDqkpz2YQwHVbWlfUYTebQ8f3sWCsukZr/maegDUr6gL4WB2U=
Received: by 10.66.224.19 with SMTP id w19mr1606800ugg;
        Fri, 20 Oct 2006 03:19:47 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 53sm1144555ugn.2006.10.20.03.19.46;
        Fri, 20 Oct 2006 03:19:46 -0700 (PDT)
To: "James Henstridge" <james@jamesh.id.au>
User-Agent: KMail/1.9.3
In-Reply-To: <a7e835d40610200126y5edc2ad0v8ca0a95655b2e029@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29438>

James Henstridge wrote:
> On 17/10/06, Sean <seanlkml@sympatico.ca> wrote:
> > > - - you can use a checkout to maintain a local mirror of a read-only
> > >   branch (I do this with http://bazaar-vcs.com/bzr/bzr.dev).
> >
> > I'm not sure what you mean here.  A bzr checkout doesn't have any history
> > does it?  So it's not a mirror of a branch, but just a checkout of the
> > branch head?
> 
> There are two forms of checkout: a normal checkout which contains the
> complete history of the branch, and a lightweight checkout, which just
> has a pointer back to the original location of the history.
> 
> In both cases, a "bzr commit" invocation will commit changes to the
> remote location.  In general, you only want to use a lightweight
> checkout when there is a fast reliably connection to the branch (e.g.
> if it is on the local file system, or local network).

So the "lightweight checkout" is equivalent of "lazy clone" we have
much discussed on git mailing list about (without any resulting code,
unfortunately). The point of problem was how to do this fast, without
need for fast reliable connection to the repository it was cloned from.
For example if to leave fetched objects in some kind of cache, or even
in "lightweight checkout"/"lazy clone" repository database.

If repository we do "lightweight checkout"/"lazy clone" from is on
local file system (perhaps network file system), then we can use
alternates mechanism (git clone -l -s). That's why "lazy clone" was
sometimes named "remote alternates".
 
> Aaron would be talking about a normal (heavyweight) checkout here.
> With a heavyweight checkout, you can do pretty much anything without
> access to the branch.  In contrast, almost all operations on a
> lightweight checkout need access to the branch.

We have terminology conflict here. Bazaar-NG "pull" and "merge" vs.
GIT "fetch", "pull" and "merge"; Bazaar-NG "checkout" vs. GIT "clone"
and "checkout".

In GIT "clone" is what is used to copy whole repository, "checkout"
is what is used to extract given/current branch to [given] working area.
-- 
Jakub Narebski
Poland
