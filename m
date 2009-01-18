From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
 submodules
Date: Sun, 18 Jan 2009 22:02:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901182201140.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>  <1232275999-14852-2-git-send-email-hjemli@gmail.com>  <1232275999-14852-3-git-send-email-hjemli@gmail.com>  <alpine.DEB.1.00.0901181635290.3586@pacific.mpi-cbg.de> 
 <8c5c35580901180945u17a69140vff2736765ee6073@mail.gmail.com>  <alpine.DEB.1.00.0901181929220.3586@pacific.mpi-cbg.de> <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOeoA-0008LL-S4
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:03:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbZARVC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbZARVC1
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:02:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:47556 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752929AbZARVC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:02:26 -0500
Received: (qmail invoked by alias); 18 Jan 2009 21:02:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 18 Jan 2009 22:02:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19j889AP75jH46jCbuehFoSD13NL7aUHwnJEoc+YC
	Uehxx/nZDy7/4H
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <8c5c35580901181145x2e14fe0fq4ab0e94c13bad38a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106280>

Hi,

On Sun, 18 Jan 2009, Lars Hjemli wrote:

> On Sun, Jan 18, 2009 at 19:33, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 18 Jan 2009, Lars Hjemli wrote:
> >> Actually, I want this to work for bare repositories by specifying the
> >> submodule odbs in the alternates file. So if the current submodule odb
> >> wasn't found my plan was to check if the commit object was accessible
> >> anyways but don't die() if it wasn't.
> >
> > Please make that an explicit option (cannot think of a good name, though),
> > otherwise I will not be able to use your feature.  Making it the default
> > would be inconsistent with the rest of our submodules framework.
> 
> Would a test on is_bare_repository() suffice for your use-case?

No.  Inconsistent is inconsistent.

> If this isn't good enough, how do you propose it be solved?

As I said, with an extra option that you _have_ to pass when you want 
that behavior.

> >> >> +     commit = lookup_commit(sha1);
> >> >> +     if (!commit)
> >> >> +             die("traverse_gitlink(): internal error");
> >> >
> >> > s/internal error/could not access commit '%s' of submodule '%s'",
> >> >                        sha1_to_hex(sha1), path);/
> >>
> >> Ok (I belive this codepath is virtually impossible to hit, hence the
> >> "internal error", but I could of course be mistaken).
> >
> > You make it a function that is exported to other parts of Git in cache.h.
> > So you might just as well expect it to be used by other parts at some
> > stage.
> 
> This function is local to tree.c, but your point is still valid.

My point is still valid because I never talked about the static function, 
but the non-static one which calls the static one.

Ciao,
Dscho
