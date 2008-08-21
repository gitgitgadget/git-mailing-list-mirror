From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problem with git-svn
Date: Wed, 20 Aug 2008 23:34:48 -0700
Message-ID: <20080821063448.GA2392@untitled>
References: <5979e28c0808190641l343ed48fi75c55f9f0cdb1bcf@mail.gmail.com> <20080820080528.GA16665@untitled> <5979e28c0808201045i2c525d7dx7fc8d70a67e9c9ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boaz Stuller <boazstuller@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 08:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW3m3-0001QO-Bc
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 08:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbYHUGev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 02:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754573AbYHUGev
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 02:34:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:44492 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753896AbYHUGeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 02:34:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id BC3E12DC01B;
	Wed, 20 Aug 2008 23:34:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5979e28c0808201045i2c525d7dx7fc8d70a67e9c9ef@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93115>

Boaz Stuller <boazstuller@gmail.com> wrote:
> On Wed, Aug 20, 2008 at 4:11 AM, Eric Wong <normalperson@yhbt.net> wrote:
> > Boaz Stuller <boazstuller@gmail.com> wrote:
> >> I'm having a problem with git-svn.  I was connecting to a remote svn
> >> repository via the svn+ssh:// protocol using an embedded username in
> >> the url, i.e svn+ssh://boazstuller@svn.example.com/some/complicated/path.
> >>  When I upgraded to 1.6.0, 'git svn dcommit' stopped working and
> >> instead kept asking me for a password.   I tracked the problem down to
> >> the following commit:
> >>
> >> commit ba24e7457aa1f958370bbb67dfb97e3ec806fd4a
> >> Author: Eric Wong <normalperson@yhbt.net>
> >> Date:   Thu Aug 7 02:06:16 2008 -0700
> >>     git-svn: add ability to specify --commit-url for dcommit
> >>
> >> I don't know perl, but the problem seems to be where around line 446,
> >> '$gs->full_url' gets changed to  '$url'.  Apparently, $gs->full_url
> >> contained the embedded username but $url has it stripped out, i.e
> >> svn+ssh://svn.example.com/some/complicated/path , so ssh can't tell
> >> what username I'm trying to log in as.
> >
> > Hi Boaz, thanks for tracking this down.  The following patch should
> > fix your issue (and another potential one I noticed).
> >
> > I've lightly tested it and it appears to work for me.
> 
> I only tested with a couple commits too, but your patch works
> perfectly for me.

Junio: please apply my patch to maint, thank you.

-- 
Eric Wong
