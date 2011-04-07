From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: blobs (once more)
Date: Thu, 7 Apr 2011 08:45:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1104070836590.2040@bonsai2>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com> <buo4o6abpsg.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 08:46:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7iyq-0000Hl-VJ
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 08:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160Ab1DGGqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 02:46:05 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:48591 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752019Ab1DGGqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 02:46:05 -0400
Received: (qmail invoked by alias); 07 Apr 2011 06:46:02 -0000
Received: from pD9EB2ACB.dip0.t-ipconnect.de (EHLO noname) [217.235.42.203]
  by mail.gmx.net (mp058) with SMTP; 07 Apr 2011 08:46:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18STGUgETkS1IZoQkjTPI4mkc97sUddtlbwj8eweu
	mo1k9xJ9iR2y34
X-X-Sender: gene099@bonsai2
In-Reply-To: <buo4o6abpsg.fsf@dhlpc061.dev.necel.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171045>

Hi,

On Thu, 7 Apr 2011, Miles Bader wrote:

> Pau Garcia i Quiles <pgquiles@elpauer.org> writes:
> > The usual answer to the "I need to put binaries in the repository" 
> > question has been "no, you do not". Well, we do. We are in heavy 
> > development now, therefore today's version may depend on a certain 
> > version of a third-party shared library (DLL) which we only can get in 
> > binary form, and tomorrow's version may depend on the next version of 
> > that library, and you cannot mix today's source with yesterday's 
> > third-party DLL. I. e. to be able to use the code from 7 days ago at 
> > 11.07 AM you need "git checkout" to "return" our source AND the 
> > binaries we were using back then. This is something ClearCase manages 
> > satisfactorily.
> 
> If it were me, I'd just store the huge binaries in some sort of separate 
> remote filesystem, and then store the remote-file-system _paths_ to them 
> in git (in a simple text file).

That fails for a number of reasons:

- it does not pass the 30,000-feet-high test

- integrity is not guaranteed (anybody can edit the files on the remote 
  file system, and nobody would realize that a "git checkout HEAD~2000" 
  ends up being something different from before)

- you would have to reinvent an efficient transfer (e.g. taking into 
  account all the data we have already)

- storage is no longer efficient, especially if you have multiple versions 
  of the same file.

- it is no longer decentralized anymore. Just think about yourself sitting 
  in the middle of antarctica, desperately needing to match a penguin 
  against a database of known penguins. You definitely want to have the 
  database local instead of leeching it down the non-existing wire all the 
  time. Likewise, if you and your group sit, say, on Viti Levu, and 
  develop software with people from New York, Texas, you definitely want
  a repository-in-the-middle, making it one person's duty to synchronize, 
  say, once per day.

I am sure you can think of more reasons.

Ciao,
Johannes
