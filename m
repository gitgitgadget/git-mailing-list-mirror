From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 06:14:44 +0400
Message-ID: <20080628021444.GI5737@dpotapov.dyndns.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 04:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCPyq-0005GC-LJ
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 04:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYF1COw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 22:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbYF1COv
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 22:14:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:12043 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbYF1COu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 22:14:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so362258fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 19:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TGAVUhGGaqDgyvJLYYGsaqBndyfdxMnjGTZFsoqstB8=;
        b=ESAoMDP66GUS+HhbhYRuxF2Bb77EpYFnbzsz8UOwncdR7Yyw/tYIrAeYBRxlc85K8l
         qyl1/3C7mCypoaIXjkTzotsEbK8cHZYQ9Sgm1OVcusEETg5bO7pix5roekDj39dS4LKn
         BotG662fwaqkw1rdvlNHI4fmg7yL3/Rm7AKiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mBtEhBrNRJE2d0vxGToz1oAY+qhXrYZ2awc0lh9/6O32JShbzOUo0o7mPKmv+0ZHkD
         eDibikbQOCAmiTUfjxCdhWJVtcjS6N6F59BDIvOdVxW4fWqoCkVqI00Xat6eEO6D3Kkp
         BnVmhfmv+bi+9FGkdGf3W108O5O8pGPROwknQ=
Received: by 10.86.79.19 with SMTP id c19mr1309357fgb.5.1214619288525;
        Fri, 27 Jun 2008 19:14:48 -0700 (PDT)
Received: from localhost ( [85.140.169.188])
        by mx.google.com with ESMTPS id 4sm3829912fge.5.2008.06.27.19.14.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 19:14:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86692>

On Fri, Jun 27, 2008 at 10:14:05AM -0700, Robert Anderson wrote:
> 
> It is too subtle.  That the index state - which becomes the next
> committed state - is not available for building or testing before
> committing is a deep flaw.

And why is that? It is like saying that any editor that does not allow
you to compile the file without saving it first has a deep flaw.

In Git, commits are not the same as in CVS. You can commit any changes
and amend them any time later before you publish your changes. So, what
you normally do is to commit your changes and then run test on them.
The advantage of this approach is that you can continue to your normal
work while test are running, besides the tests are running in clear and
control environment, not in the developer working director where always
there is some garbage.

> > Now, this is not necessarily what everybody wants, which is why many
> > people are fine with the index.
> 
> But it is something they should want, and should have, if they care
> about the quality of their commits.

Those who care about quality should have a review process, and the
review process works best when all changes are slit in a small logical
steps. How do you propose to that without committing changes first?

> Especially in the common case of
> a project with development lines which have some sort of policy about
> build/test requirements.  How do you ensure your commits obey that
> policy if you cannot verify it?

You can verify it, but you do that _after_ you committed changes but
before you publish them. BTW, policy may include that it should be
compiled and tested on a few platforms, so you cannot do that in
your working directory anyway.

I think the source of your confusion is that you consider git commit
as cvs commit, while git commit in some sense may be closer to saving
files, while a better analogue for cvs commit will be git push to a
public repository.

Dmitry
