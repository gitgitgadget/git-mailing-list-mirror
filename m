From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Sat, 24 Nov 2007 21:08:46 +0700
Message-ID: <fcaeb9bf0711240608w2e5e0812me0e56c1f1a2f8c85@mail.gmail.com>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
	 <fcaeb9bf0711230431x1b0432f6uc9472b2f67514463@mail.gmail.com>
	 <Pine.LNX.4.64.0711231428350.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 24 15:09:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivvgy-0004eB-PK
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 15:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbXKXOIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 09:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbXKXOIt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 09:08:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:8485 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbXKXOIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 09:08:48 -0500
Received: by nf-out-0910.google.com with SMTP id g13so122780nfb
        for <git@vger.kernel.org>; Sat, 24 Nov 2007 06:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fn3HBCEQ8EMPtx+WM4TQQjXLUb3/qqs2Qb2NjHaMGAk=;
        b=Adh0+6HG/Fwb7J756Q+URnmua1Mlcy7BTBcwpGcNku6xlJYEqVUFP/atOk5W6R3ZC9X0YhZip4nNbsxTe1L9sqShrbw/PR/5jt181gTjF1ziLGRqUw9jCaUgVetBAQedc2pAhu/Xjtb7YwEB/L1V9oNCyfsTiSf4zvbqSAD5yLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jQXQcpwajOkd6wtY+0Cb0ZbKGIsGqVeobrfvtLen563o7dv1PcSGLi1laGtrl8DDkAmEqNtVfZgfX3Yt+LFozKO4AicRmI4k8MmxY8y+75XEah//dJBhzqMMRXDnAOCvbuzfRxOO7DNKn9x8TrJBccUPlEgl078P/0Qy5s4p8k4=
Received: by 10.86.77.5 with SMTP id z5mr542316fga.1195913326456;
        Sat, 24 Nov 2007 06:08:46 -0800 (PST)
Received: by 10.86.68.16 with HTTP; Sat, 24 Nov 2007 06:08:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711231428350.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65951>

On Nov 23, 2007 9:31 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 23 Nov 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On Nov 21, 2007 10:40 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > [WIP: this does not handle tags yet, and it lacks a test script
> > >  as well as documentation.]
> > >
> > > This program dumps (parts of) a git repository in the format that
> > > fast-import understands.
> > >
> > > For clarity's sake, it does not use the 'inline' method of specifying
> > > blobs in the commits, but builds the blobs before building the commits.B
> > >
> > > ---
> > >         I am way too tired now to continue, but maybe someone else wants
> > >         to pick up the ball.
> >
> > Well, I would better be back on setup_git_directory() than picking up
> > the ball.
>
> Concur.
>
> > I have a suggestion though. git-fast-export and git-fast-import should
> > support bundle.
>
> I think this is not what fast-export and fast-import are about.  They use
> an easy to generate, and easy to edit, format.
>
> Bundles are optimised transport mechanisms for sneaker net.  They are not
> to be meant to be easy to edit, but as small as possible.
>
> > Bundle is very handy for transferring a bunch of commits, but it does
> > not (cannot?) hold tags and branches.
>
> But they can!  Nothing prevents you from calling
>
>         git bundle create a1.bundle refs/tags/v1.0.0 refs/heads/next
>
> (At least this is the idea, haven't tested yet).

It can store commits and heavy tags, but it won't restore tags to
refs/tags or advance branches.

-- 
Duy
