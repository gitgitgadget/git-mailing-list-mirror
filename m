From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 8 Sep 2013 00:18:05 -0400
Message-ID: <20130908041805.GB14019@sigill.intra.peff.net>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <20130904092527.GB22348@sigill.intra.peff.net>
 <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWS0-0002tu-2t
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab3IHESK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:18:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:42009 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab3IHESJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:18:09 -0400
Received: (qmail 30849 invoked by uid 102); 8 Sep 2013 04:18:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Sep 2013 23:18:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 00:18:05 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234174>

On Sat, Sep 07, 2013 at 09:52:16PM -0500, Felipe Contreras wrote:

> On Wed, Sep 4, 2013 at 4:25 AM, Jeff King <peff@peff.net> wrote:
> 
> > The patch in jc/pull-training-wheel talks about annoying old timers, but
> > I think you may also be annoying clueless new users who simply want an
> > svn-like workflow without thinking too hard about it.
> 
> How? Subversion would complain if you have local changes when you do
> 'svn pull', there's no notion of remotes, branches and merges are
> rare, and forget about rebases.

By "svn-like", I mean the people whose workflow is:

  $ hack hack hack
  $ git commit
  $ git push ;# oops, somebody else pushed in the meantime
  $ git pull
  $ git push

without using branches or worrying about the shape of history. I do not
know what you mean by "svn pull", since that command does not exist
(unless you are talking about svk?). In subversion, that workflow would
be:

  $ hack hack hack
  $ svn commit ;# oops, somebody else committed in the meantime
  $ svn update
  $ svn commit

Those people would now have to learn enough to choose between merge and
rebase when running the "git pull".

It may be OK to say "we do not care about that case, and it is a good
thing that they learn enough to make the choice consciously." But I do
think they exist.

> >> > I do not think we know what we want is to affect "git pull origin".
> >>
> >> I consider "git pull $remote" to be an artifact of the way git-pull is
> >> implemented on top of git-fetch; perhaps I'm missing something but I
> >> can't see a scenario where this is useful.
> >
> > Imagine a workflow where each topic is in its own repository instead of
> > in its own branch inside a repository. Or where each developer has his
> > or her own repository, but everybody just works on the master branch of
> > their repository (or perhaps uses branches, but keeps master as a stable
> > base). Alice is the integration manager; Bob tells her that he has work
> > ready to integrate.  She runs "git pull ~bob/project", which will merge
> > Bob's HEAD.
> 
> These integrators should know what they are doing, so they can do 'git
> pull --merge', or better 'git config pull.mode merge', as Linus
> himself suggested (or something like that).
> 
> The defaults should care most about the clueless users.

In this part of the email you are quoting I was not intending to say
anything about clueless users at all, nor even about what defaults there
are. John indicated that he could not imagine a scenario of "git pull
$remote", so I gave an example.

-Peff
