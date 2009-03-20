From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
	shortcut to the tracked branch
Date: Thu, 19 Mar 2009 17:44:50 -0700
Message-ID: <20090320004450.GY23521@spearce.org>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:46:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSsP-0003BU-97
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbZCTAow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZCTAow
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:44:52 -0400
Received: from george.spearce.org ([209.20.77.23]:36767 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbZCTAow (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:44:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7132D38221; Fri, 20 Mar 2009 00:44:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090320004029.GX23521@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113878>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 20 Mar 2009, Johannes Schindelin wrote:
> > 
> > > Just try this:
> > > 
> > > 	$ git checkout -b %helloworld
> > 
> > It gets worse.  Much worse.
> > 
> > Try this (triggered by a comment by Ilari on IRC):
> > 
> > 	$ git checkout -b '@{1}'
> > 
> > That _works_! WTH?
> 
> '@' is not reserved.  Neither is '{' or '}'.  Neither is
> the combination.

In hindsight, I wish we had reserved all of the "fun" characters
like !@#$%^&*():;~'"\ and prevented them from ever appearing in a
ref name.

Instead only what check_ref_format() in refs.c ll.694 tells is
is reserved:

 671 /*
 672  * Make sure "ref" is something reasonable to have under ".git/refs/";
 673  * We do not like it if:
 674  *
 675  * - any path component of it begins with ".", or
 676  * - it has double dots "..", or
 677  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
 678  * - it ends with a "/".
 679  */

Heh.  At least : and SP are reserved.

Use BEL for your %helloworld hack.  It'll be fun to type.  :-)

-- 
Shawn.
