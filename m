From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 00:19:20 +0200
Message-ID: <20071007221920.GF2765@steel.home>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:19:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeeTQ-0003mH-DO
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 00:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbXJGWTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 18:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756098AbXJGWTX
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 18:19:23 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:53346 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952AbXJGWTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 18:19:23 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo11) (RZmta 13.4)
	with ESMTP id 002d48j97HVAEJ ; Mon, 8 Oct 2007 00:19:21 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D989B277AE;
	Mon,  8 Oct 2007 00:19:20 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B2AFEC502; Mon,  8 Oct 2007 00:19:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60231>

Elijah Newren, Mon, Oct 08, 2007 00:00:51 +0200:
> On 10/7/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > On Sun, Oct 07, 2007 at 03:23:59PM -0600, Elijah Newren wrote:
> > > The following set of instructions will duplicate my problem with a
> > > smaller repo; why is the local git repository bigger after running
> > > git-filter-branch rather than smaller as I'd expect?  I'm probably
> > > missing something obvious, but I have no idea what it is.
> >
> > The usual suspect would be the reflog.
> 
> The git-filter-branch documentation mentions creating refs/original
> under .git.  Unfortunately, it doesn't contain any links or
> documentation on how I'd clean those out and I haven't been able to
> figure it out.  I asked on #git how to clean these out and got some
> answers that didn't work (git branch -d and something else I don't
> remember).

rm -rf .git/refs/original/refs/heads/<the branch where HEAD pointed to>
(assuming you haven't repacked yet)

or just edit .git/packed-refs and remove everything "refs/original"
which fits the criteria

> So...how do I fix the reflog, and then repack to have a
> pack under 11MB in size?

git reflog expire --all (it is a bit to much. You can just edit
.git/logs/* in any text editor)
