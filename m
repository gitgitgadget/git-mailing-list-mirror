From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 08:03:44 +0400
Message-ID: <20080628040344.GK5737@dpotapov.dyndns.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <alpine.DEB.1.00.0806271408290.9925@racer> <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com> <20080628021444.GI5737@dpotapov.dyndns.org> <9af502e50806271957o2df9e0abt9dadcb0514dd4173@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 06:04:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCRgG-00054y-SX
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 06:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYF1EDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 00:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbYF1EDv
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 00:03:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:39937 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbYF1EDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 00:03:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so378954fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 21:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kb1VUrHnISHf3G2uGxAmaEXQ/1BGZytsywLpDk8GBys=;
        b=wT4qFJh4dA5xSBiI6CqcYRtetsxZ+3LBLzSZhYJucH3GLM5uveCS+Umpxzke6DjAl0
         BkcZD/utgveAAoHhzlONLqsIGBDMEMZ1ydk/0TjaCcw5eQLVV3QCSxHWT4ydo2Q7/bw1
         Ton2JrY4U3/tC/E4DI/XUdcQf0k+zOdsd2vgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TUCyA0B0K1Zd7E/ZfA/CqrXj+skkbefH4df/oPdNPjGmT6EK0FSzNQZOJz1azC87nY
         XHDMeKPwvjNtvCKRBFPbfmtFTPDSqioWQkJ3pebXHiJgUvvaqmgd/yDIyrFsdoYameHZ
         Mj6SGTydfk6r4Nz2y0rn6tSYS+vJr80usn+gY=
Received: by 10.86.26.1 with SMTP id 1mr2939980fgz.49.1214625828547;
        Fri, 27 Jun 2008 21:03:48 -0700 (PDT)
Received: from localhost ( [85.140.169.188])
        by mx.google.com with ESMTPS id e11sm4004235fga.4.2008.06.27.21.03.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 21:03:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <9af502e50806271957o2df9e0abt9dadcb0514dd4173@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86698>

On Fri, Jun 27, 2008 at 07:57:02PM -0700, Robert Anderson wrote:
> On Fri, Jun 27, 2008 at 7:14 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> > On Fri, Jun 27, 2008 at 10:14:05AM -0700, Robert Anderson wrote:
> >>
> >> It is too subtle.  That the index state - which becomes the next
> >> committed state - is not available for building or testing before
> >> committing is a deep flaw.
> >
> > And why is that? It is like saying that any editor that does not allow
> > you to compile the file without saving it first has a deep flaw.
> 
> I don't believe it is like that.  It would be like that if you
> intended for your on-tree disk to have a policy to always compile (for
> example).  That is not a common use-case.

Do you think commit only tested changes is a common policy among
Git users? I seriously doubt that. And as I said before, git commit
is probably closer to saving a file than to what cvs commit does.


> > You can commit any changes
> > and amend them any time later before you publish your changes.
> 
> This is enforcing a two-step process where there only need be one the
> vast majority of the time, to require that commit and publish be
> separate operations.

I don't see it is a problem. In fact, it saves time for me, because
I can work while tests are running, and considering the whole cycle
with different configurations may take 3 hours, I really want to do
something useful while it is running... Besides, I really believe
in review, so it cannot be one-step process anyway...

> 
> > Those who care about quality should have a review process, and the
> > review process works best when all changes are slit in a small logical
> > steps. How do you propose to that without committing changes first?
> 
> I don't understand the question. 

If you use CVS like workflow, you may have the policy of no commit
until your patches are reviewed. In case of Git, you do commit but
only push to fast-forward only branch after receiving okay (or the
maintainer pull your changes to it). With Git, commit is more like
saving file, except that you save not a single file but the whole
changeset with the commit message and relevant information.

> > You can verify it, but you do that _after_ you committed changes but
> > before you publish them.
> 
> Again, this is requiring two steps when it is otherwise not required,
> creating an inefficient workflow that is error prone.

I don't see why you think that is inefficient or error prone.

> 
> > BTW, policy may include that it should be
> > compiled and tested on a few platforms, so you cannot do that in
> > your working directory anyway.
> 
> Huh?  I have done that every day for 15+ years.

You have your working directory let's say on Linux, and you have to
test your changes on Windows. So what do you do? With Git, it is
simple as you commit your changes and then run testing automatically
on different platforms and they use exactly what you put into the
repo. So if everything is okay, you can publish.

> 
> > I think the source of your confusion is that you consider git commit
> > as cvs commit
> 
> No.  I have experience with a wide array of source control systems.
> CVS fits my mental model the least well.  git is pretty close, but it
> is not there yet.  The current partial commit facility is the biggest
> misfire, in my view.

Do you have your personal experience of using it, or it is just some
abstract considerations? Certainly, any feature may be misused but, in
general, it is handy and I have not had any problem with it. And, yes,
if I split a very complex patch then I will use stash to facilitate
me with this work, but it is rare.

> I like that git's philosophy does not include a draconian policy of
> not changing history.  That's fine, it's practical, and it's useful,
> to cover common scenarios in which you'd like to quickly recover from
> a mistake.  However, I am afraid that these facilities have been
> abused and turned into something that they are not well-suited for,
> i.e., the use of lines of development as both keepers of history and
> of scratch spaces where you scribble around with temporary things, all
> the while git having no clue which is intended.

I don't see why git should know it. The policy depends on workflow
and is usually enforced by hooks. I don't see why Git should care
about it deeply. It is like a word processor can be used for writing
a draft of a document or the final version for publication. Sure,
you can mark something as work-in-progress (use tags or comments),
but it is not something about Git should care deeply inside.

Dmitry
