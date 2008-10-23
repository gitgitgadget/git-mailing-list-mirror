From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git performance
Date: Thu, 23 Oct 2008 20:04:07 +0700
Message-ID: <fcaeb9bf0810230604u6db6d31cr91153b3cbfa0bbb6@mail.gmail.com>
References: <000801c93483$2fdad340$8f9079c0$@com>
	 <m3d4hsi708.fsf@localhost.localdomain> <49002B27.50201@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Edward Ned Harvey" <git@nedharvey.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 23 15:06:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KszsT-0003TZ-El
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 15:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYJWNEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 09:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbYJWNEM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 09:04:12 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:53996 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYJWNEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 09:04:11 -0400
Received: by gxk9 with SMTP id 9so1273537gxk.13
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=skGrw7fomRLGF04Kg9N1Rd/4Gl87KZtxw982lRvchZo=;
        b=uHZVm38CzuGyAAToSLeGdO0EscxGaqEAvKxUIMnfJ1kDlJtlfxAzlrdu0UpjkeOfxL
         N1QcQbwbzxdUvPpjAkAerBc91tP25/Id46caNjA5GT93KRjKI/Bsu7S8UoBnbpbI4VgY
         Aa6UM+YujlBCz6P4EctFZ8z376Tq/IjRD5noI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=A5pylGf7jnLzNax3EdwRMjj1+KK0dwauWgmJR4y5wu4p5AmgGEwAnlGiOoFAf6VnKn
         hJ53njEUD/IPmDsP/+qruzXT36r/sul/SNQQxq7O7oNyxTKI040YmCLHy1aTNRyGK36N
         B+cIDz/GsIK+SvweHpbMp9Mf8sAvMdzrHv4J8=
Received: by 10.86.95.8 with SMTP id s8mr1143094fgb.33.1224767047338;
        Thu, 23 Oct 2008 06:04:07 -0700 (PDT)
Received: by 10.86.95.9 with HTTP; Thu, 23 Oct 2008 06:04:07 -0700 (PDT)
In-Reply-To: <49002B27.50201@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98961>

On 10/23/08, Andreas Ericsson <ae@op5.se> wrote:
> Jakub Narebski wrote:
>
> > "Edward Ned Harvey" <git@nedharvey.com> writes:
> >
> >
> > > I see things all over the Internet saying git is fast.  I'm
> > > currently struggling with poor svn performance and poor attitude of
> > > svn developers, so I'd like to consider switching to git.  A quick
> > > question first.
> > >
> > > The core of the performance problem I'm facing is the need to "walk
> > > the tree" for many thousand files.  Every time I do "svn update" or
> > > "svn status" the svn client must stat every file to check for local
> > > modifications (a coffee cup or a beer worth of stats).  In essence,
> > > this is unavoidable if there is no mechanism to constantly monitor
> > > filesystem activity during normal operations.  Analogous to
> > > filesystem journaling.
> > >
> > > So - I didn't see anything out there saying "git is fast because it
> > > uses inotify" or anything like that.  Perhaps git would not help me
> > > at all?  Because git still needs to stat all the files in the tree?
> > >
> >
> > http://git.or.cz/gitwiki/GitBenchmarks
> >
> > While it should be possible to use 'assume unchanged' bit together
> > with inotify / icron, it is not something tha is done; IIRC Mercurial
> > had Linux-only InotifyPlugin...
> >
> >
>
>  Well, inotify() is Linux specific, so it'd be quite hard to support on
>  another platform. Emulating it with a billion stat() calls feels rather
>  like a disk (and I/O performance) killer.

There is "filemon" on Windows, which monitors file access. I don't
know how it impacts performance though. A quick search revealed kqueue
for FreeBSD/Mac OSX.
-- 
Duy
