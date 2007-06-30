From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-clone: fetch possibly detached HEAD over dumb http
Date: Sun, 1 Jul 2007 00:23:36 +0200
Message-ID: <20070630222336.GA2703@steel.home>
References: <20070628105208.GA11105@liacs.nl> <7vsl8bmxv9.fsf@assigned-by-dhcp.pobox.com> <20070629083108.GA14747@liacs.nl> <20070630133310.GB2866@steel.home> <20070630134542.GF7969MdfPADPa@greensroom.kotnet.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Louis-Noel Pouchet <louis-noel.pouchet@inria.fr>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sun Jul 01 00:23:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4lLz-0007iL-9s
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 00:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753043AbXF3WXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 18:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbXF3WXl
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 18:23:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:46221 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbXF3WXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 18:23:40 -0400
Received: from tigra.home (Fa9ee.f.strato-dslnet.de [195.4.169.238])
	by post.webmailer.de (klopstock mo49) (RZmta 7.6)
	with ESMTP id Y01a9bj5UKm8Pu ; Sun, 1 Jul 2007 00:23:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 712FB277BD;
	Sun,  1 Jul 2007 00:23:37 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 09BC3C164; Sun,  1 Jul 2007 00:23:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070630134542.GF7969MdfPADPa@greensroom.kotnet.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNrERwE=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51259>

Sven Verdoolaege, Sat, Jun 30, 2007 15:45:44 +0200:
> On Sat, Jun 30, 2007 at 03:33:10PM +0200, Alex Riesen wrote:
> > Sven Verdoolaege, Fri, Jun 29, 2007 10:31:08 +0200:
> > > +		head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
> > > +		case "$head_sha1" in
> > > +		'ref: refs/'*)
> > > +			;;
> > 
> > And what do you do if the HEAD is a reflink on something not in refs/?
> > Like "ref: tmp"? Yes, it is unlikely, but is not forbidden.
> 
> It may not be forbidden, but I don't think it would
> work with current git-clone either.
> 

Every command which needs a proper .git will not work, so I take this
back completely.

The check for .git validity includes checking if HEAD contains
something sane, and this check is very simple: the HEAD is read
(readlink(2) or plain read(2)) and tested if it contains a
reference starting with "refs/", which maybe inconsistent with
resolve_gitlink_ref, but probably ok.
