From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 11:51:22 +0100
Message-ID: <cda58cb80601190251v5251c8bdh@mail.gmail.com>
References: <cda58cb80601170928r252a6e34y@mail.gmail.com>
	 <cda58cb80601170932o6f955469y@mail.gmail.com>
	 <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 11:51:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzXO2-0000lT-2X
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 11:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbWASKvX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 05:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161302AbWASKvX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 05:51:23 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:25126 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161243AbWASKvX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 05:51:23 -0500
Received: by zproxy.gmail.com with SMTP id 14so171843nzn
        for <git@vger.kernel.org>; Thu, 19 Jan 2006 02:51:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S+EHSPPPdeg0JgMAqd3KdyR0PcvLhA6A+O7Q8jN+vej/Jyq+Tc+B3Nu5YrOYf/7RrWdqfQtFU/+M/tS1ojlt6FudDOAf1v/IQaBoXh+ylAjarnTtbNROOCTDJ/L9gRlKkd+GC0njib4WJQ4yj98gGvyAmkr8qw22owThTtdcboY=
Received: by 10.36.31.8 with SMTP id e8mr390985nze;
        Thu, 19 Jan 2006 02:51:22 -0800 (PST)
Received: by 10.36.47.7 with HTTP; Thu, 19 Jan 2006 02:51:22 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14897>

Thanks Junio for answering

2006/1/19, Junio C Hamano <junkio@cox.net>:
> Franck <vagabon.xyz@gmail.com> writes:
>
> > I'm wondering why the "grafts" files is not involved during
> > push/pull/clone operations ?
>
> Commit ancestry grafting is a local repository issue and even if
> you manage to lie to your local git that 300,000th commit is the
> epoch, the commit object you send out to the downloader would
> record its true parent (or parents, if it is a merge), so the
> downloader would want to go further back.  And no, rewriting
> that commit and feeding a parentless commit to the downloader is
> not an option, because such a commit object would have different
> object name and unpack-objects would be unhappy.
>
> If you choose not to have full history in your public repository
> for whatever reason (ISP server diskquota comes to mind)

well, dealing with a repo that has more than 300,000 objects becomes a
burden. A lots of git commands are slow, and cloning it take a while !

> that is
> OK, but be honest about it to your downloaders.  Tell them that
> you do not have the full history, and they first need to clone
> from some other repository you started your development upon, in
> order to use what you added upon.  "This repository does not
> have all the history -- please first clone from XX repository
> (you need at least xxx commit), and then do another 'git pull'
> from here", or something like that.
>

I don't try to hide or lie to my downloaders. I just want them to
avoid to deal with totaly pointless history. My work have been started
recently and is based on current XX repository. IMHO storing, dealing
with objects which are more than 10 years old is useless.

I don't see why it is so bad to create a "grafted" repository ? I want
it to be small but still want to merge by using git-resolve with XX
repository.

>
> >                $ git-merge-base master origin
> >                # nothing
>
> Maybe you did not use grafts properly to cauterize?

Well in my graft file I did:

                    $ cat > .git/info/grafts
                    <shaid> <shaid>

                    $

By reading "Documentation/repository-layout.txt", I thought it would
have been the right thing to do. If I did the same like you did ie:

                    $ cat > .git/info/grafts
                    <shaid>

                    $

It works.

Thanks
--
               Franck
