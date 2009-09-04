From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-completion.bash: prevent 'git help' from searching
    for git repository
Date: Fri, 4 Sep 2009 12:32:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041223420.4605@intel-tinevez-2-302>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com> <4AA0E142.4080105@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Gerrit Pape <pape@smarden.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Rogan Dawes <discard@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:32:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjW5l-0005Nx-IK
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933645AbZIDKcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933601AbZIDKcR
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:32:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:44156 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933437AbZIDKcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:32:16 -0400
Received: (qmail invoked by alias); 04 Sep 2009 10:32:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 04 Sep 2009 12:32:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ik/skuTmIKzGqn4OAxT6DVzJtJnsdbRN0xbYPch
	EdDffR9l1RuWTE
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4AA0E142.4080105@dawes.za.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127705>

Hi,

On Fri, 4 Sep 2009, Rogan Dawes wrote:

> Sverre Rabbelier wrote:
> 
> > On Wed, Sep 2, 2009 at 11:58, Gerrit Pape<pape@smarden.org> wrote:
> >> +       for i in $(git --git-dir=/nonexistent help -a|egrep '^ ')
> > 
> > Wouldn't implementing "git --no-git-dir" be more appropriate?
> 
> Or documenting which git commands do/don't require a git dir at all?

This patch is not about documentation, but about preventing the 
auto-completion from trying to discover a Git repository (to prevent 
auto-mounting; although I wonder why you would run Git there if you do not 
want to auto-mount).

> I assume that documenting those that don't would be better than 
> documenting those that do . . .

It's not as easy as that: some commands, such as "ls-remote" do _not_ 
require one, but they take it into account (think "git ls-remote origin").  
Other commands, such as "archive", have modes in which they _need_ a 
repository, and other modes where they do not even look for one.

"git help -a" seems to be similar to the latter modes of "archive".

> And by documenting, I mean in the code, so that the code can DTRT.
> 
> Otherwise, having this switch lets people shoot themselves in the foot, 
> I'd think.

Git offers plenty of opportunity to shoot yourself in the foot (and it 
does not help that we are introducing user-unfriendly constructs like the 
current form of the foreign VCS helpers with more such opportunities, 
either), but for the love of God, I cannot find how "this switch" lets 
people shoot themselves in the foot here.

Ciao,
Dscho
