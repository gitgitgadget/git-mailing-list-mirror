From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 12:51:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606271248270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060626233838.GA3121@steel.home> 
 <Pine.LNX.4.63.0606270936520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0606270158i16ebee20me81ca2b9fa71db5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 12:51:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvBAS-0001qm-Ie
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 12:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbWF0Kvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 06:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933367AbWF0Kvh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 06:51:37 -0400
Received: from mail.gmx.net ([213.165.64.21]:35276 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932677AbWF0Kvg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 06:51:36 -0400
Received: (qmail invoked by alias); 27 Jun 2006 10:51:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 27 Jun 2006 12:51:35 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606270158i16ebee20me81ca2b9fa71db5c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22727>

Hi,

On Tue, 27 Jun 2006, Alex Riesen wrote:

> On 6/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > > I finally got pis^Witched enough by my platform at work and decided
> > > to start the effort of converting Fredriks git-merge-recursive to C.
> > 
> > Darn. I was working on the same thing since a few days.
> 
> I didn't know :)

Vice versa, I guess.

> > - have you considered using run-command() instead of system()?
> 
> No. What run-program?

run-command.c:run_command(). Call it like this:

int return_code = run_command("git-read-tree", sha1_to_hex(sha1), NULL);

> > - in setup_index(), you set GIT_INDEX_FILE, but I do not think that the
> >   rest of git picks up on it. environment.cc:get_index_file() checks if
> >   the variable was set already, but not if it changed.
> 
> Not even sure it's needed. Leftover from conversion

I think it _is_ needed, in order not to mess up the current index. Setting 
the environment variable works for exec()ed processes, but I think we need 
to add a set_index_file(const char *) to environment.c.

> > - I always wondered why merge-recursive did not call merge-base, but did
> >   its own thing. Hmm?
> 
> No idea yet.

Frederik?

Ciao,
Dscho
