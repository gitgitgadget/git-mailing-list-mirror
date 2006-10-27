X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Creating new repos
Date: Fri, 27 Oct 2006 14:08:55 -0300
Message-ID: <200610271708.k9RH8thM022812@laptop13.inf.utfsm.cl>
References: <pasky@suse.cz>
NNTP-Posting-Date: Fri, 27 Oct 2006 17:30:45 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Petr Baudis <pasky@suse.cz> 
   of "Fri, 27 Oct 2006 14:39:18 +0200." <20061027123918.GB20017@pasky.or.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Fri, 27 Oct 2006 14:08:55 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30336>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdVCo-0000n3-N5 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 19:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751121AbWJ0RJE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 13:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWJ0RJE
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 13:09:04 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23443 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1751121AbWJ0RJD (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 13:09:03 -0400
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k9RH8tuV022502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Fri, 27
 Oct 2006 14:08:55 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id k9RH8thM022812; Fri, 27
 Oct 2006 14:08:55 -0300
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Fri, Oct 27, 2006 at 02:29:10PM CEST, I got a letter
> where "Horst H. von Brand" <vonbrand@inf.utfsm.cl> said that...
> > I'm trying to set up git repos for remote access here. I set up git-daemon
> > and got it working (some older repositories do work fine), but now:
> > 
> >   $ mkdir /var/scm/user/SomeRepo.git
> >   $ cd /var/scm/user/SomeRepo.git
> >   $ git --bare init-db
> >   $ touch git-daemon-export-ok
> > 
> > All OK, but then, from a remote machine:
> > 
> >   $ git clone git://git-server/user/SomeRepo.git
> >   fatal: no matching remote head
> >   fetch-pack from 'git://git-server/user/Test.git' failed.

> > The empty repo created by init-db should be cloneable, so as to get the
> > ball rolling easily.

> Well there's really nothing to clone, so it's tough. :-) What would such
> a clone be supposed to do? It has no branches to record as belonging to
> origin, and note that Git's git-clone is long-term broken in the sense
> that it won't pick new branches as they appear in the remote
> repository. So a clone of an empty repository would be useless anyway.

As useless as the empty set? ;-)

> > You can't push into such an empty repository either.
> 
> This is supposed to work. What error do you get?

Pilot error. Sorry for the noise.

> > Any suggestion of how to set up a server into which users can create their
> > own repos /without/ giving out full shell accounts?
> 
> Sure:
> 
> 	http://repo.or.cz/w/repo.git

Cloning... 
"error: Can't lock ref" (?)

OK, got it; the repo is at git://repo.or.cz/repo.git. Better not calling it
*.git

> But it may be quite an overkill for you. ;-)

Will see.

> If you want them to be able to do it over ssh, you would need to provide
> a trusted tool which would manage the repository setup, that means not
> only doing init-db, but also managing the export-ok files, description
> file, you'd likely want to enable the post-update hook (but probably not
> any other hook or let the user edit it since at that point you've given
> him full shell access), etc. And the tool would have to be carefully
> reviewed since it's security-critical.

I was fearing something along these lines...

> > Also, the behaviour of git-daemon is different when using git or ssh+git,
> > you need to give the full path for the later but not the former (given
> > --base-path=/var/scm):
> > 
> >   git://git-server/user/Test.git
> >   ssh+git://git-server/var/scm/user/Test.git
> > 
> > Is this intentional?
> 
> git+ssh has nothing to do with git-daemon, it's executing other git
> commands remotely.

OK. But from an UI POW it is confusing.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
