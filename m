From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 16:31:06 -0400
Message-ID: <9b3e2dc20806271331l2870ef94o4cd413ee40ab0d39@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 22:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCKc2-0004N8-Dg
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 22:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762658AbYF0UbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762072AbYF0UbI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 16:31:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:9140 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762009AbYF0UbG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 16:31:06 -0400
Received: by rv-out-0506.google.com with SMTP id k40so726267rvb.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WhshP0jN+vr3Lexb+Ut6ghtAdWe4gXYDTGViSF7nxM4=;
        b=e9CQiickqb6vW+2DwQQR0ZgeF6maJJguVtX167KF+nxJBvdJg+MGX9M+lI2u2siagt
         4ktMGs8hxIDZPDejgGuIbhrDhhIsA5SpWpvlY3rzi/p6irMZ3OfzYogTSveqMxPWnN8p
         nnN7Ik29/1h5oioM+8ONzXHupDNocCLJSk5Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Q+ANSvwxRIAdleBAsdfb1nibxr07hTVEfuTT/z1Cpye9YjhCFwNFgz6zSt4G4di1Mn
         Sk2hSJ3dH5pstMJMytFmLGjxYs4BBI0/qQqZ+GNv37bdmc2gYBk11xPIn+kfauV5tN1u
         PWmYkwC8zrni3PjwtdS6+y/a5Mefbqe2nvlXw=
Received: by 10.141.29.21 with SMTP id g21mr1024567rvj.225.1214598666103;
        Fri, 27 Jun 2008 13:31:06 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Fri, 27 Jun 2008 13:31:06 -0700 (PDT)
In-Reply-To: <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86628>

Hello,

On Fri, Jun 27, 2008 at 1:14 PM, Robert Anderson <rwa000@gmail.com> wrote:
> On Fri, Jun 27, 2008 at 6:33 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Now, this is not necessarily what everybody wants, which is why many
>> people are fine with the index.
>
> But it is something they should want, and should have, if they care
> about the quality of their commits.  Especially in the common case of
> a project with development lines which have some sort of policy about
> build/test requirements.  How do you ensure your commits obey that
> policy if you cannot verify it?  That is why the index is not a
> sufficient mechanism for preparing partial commits.  It's fine for
> quick and dirty operation when the factorization of the conflated
> changes is obvious and trivial.  It is not sufficient otherwise.

I just thought I'd throw in my $0.02 here.  There's something
fundamental I think I'm not getting about this argument: it seems to
be based on the premise that partial commits allow untested tree
states to enter the repository.  However, having gotten used to the
git way of things, I personally don't see the problem with allowing
bad commits, as long as they are not pushed to public.

That is, I use the git add -p command all the time when I realize I've
just done two things that should be committed separately.  Then I'll
git commit everything else, and go back and test, like so:

git checkout master
[hack hack..]
git add -p
git commit
git commit -a
[test..]
git checkout master^
[test..]
git checkout master

See? All tested.  If I find a problem during testing, I'll probably
commit it and then rebase master off my new commit, fixing any
conflicts I just introduced.

Frankly I hardly even use the stash; since history can be edited, I
feel like commits are all I need when working with git.  Anything I do
doesn't matter until I push to public anyways.  So it's up to me to
make sure I test everything before pushing, but otherwise I'm very
happy with the ability to commit half-baked ideas and then go back to
make sure they are usable (and tested!) before pushing.  This is what
local branches are for, isn't it?


Steve
