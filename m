From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Git fetch/pull stopped working
Date: Tue, 8 May 2012 02:10:18 +0200
Message-ID: <20120508001018.GB5067@centaur.lab.cmartin.tk>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
 <7vehqv36aw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Egor Ryabkov <egor.ryabkov@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 08 02:10:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRY0V-0006LR-Hg
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 02:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757841Ab2EHAKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 20:10:17 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:47498 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757743Ab2EHAKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 20:10:16 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9c539.pool.mediaWays.net [77.185.197.57])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5871346057;
	Tue,  8 May 2012 02:10:07 +0200 (CEST)
Received: (nullmailer pid 30690 invoked by uid 1000);
	Tue, 08 May 2012 00:10:18 -0000
Content-Disposition: inline
In-Reply-To: <7vehqv36aw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197330>

On Mon, May 07, 2012 at 04:44:23PM -0700, Junio C Hamano wrote:
> Egor Ryabkov <egor.ryabkov@gmail.com> writes:
> 
> > git fetch and pull stopped working a few days ago on my server with
> > the following message:
> >
> > $ git fetch
> > ERROR: Repository not found.
> > fatal: The remote end hung up unexpectedly
> 
> Are you sure it is an error on the remote side (presumably on GitHub)?
> 
> More interestingly, neither "Repository not found" nor "ERROR:" hits
> anything relevant to "git fetch" codepath.  The closest I can find is in
> http-backend.c that says "Repository not exported", which is on the server
> side, but you were talking about ssh connection, so it probably is not
> what you are seeing.
> 
> Oh, wait.
> 
> > "$ GIT_TRACE=1 git fetch" gives somewhat different output on local PC
> > and server:
> > http://pastecode.com/bd3fc1a79f8e9d1eaf30911d9895938051c472f4
> 
> So you are going over http:// after all.  But it does not look like github
> to me, so you may be comparing apples and oranges, which would not help in
> diagnosing the issue very much.

I can reproduce this issue. It happens somewhere between my phone jack
and rackspace.

I can perform 'git fetch' on other hosts and ssh -T git@github.com
works fine. However, trying to fetch from github gives me an error.

Not only this, but trying to browse to github.com or rubygems.org,
both of which seem to be hosted on the same datacentre gives me
timeouts or takes really long to answer. Routing traffic through my
server in the next country over makes it work, as does fetching from
that host.

The only difference I've been able to find is that the traffic looks
like it goes through different hosts when it goes through the UK on
its way to the US.

> 
> Puzzled...

Yeah... It looks like the Internet is being silly. So much for routing
around damage. What I'm not sure is how this would also affect AWS;
maybe the Irish one?

   cmn
