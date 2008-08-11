From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Two-step tag fetching
Date: Sun, 10 Aug 2008 19:43:41 -0700
Message-ID: <20080811024341.GA27195@spearce.org>
References: <alpine.LNX.1.10.0808101115290.1727@fbirervta.pbzchgretzou.qr> <alpine.LNX.1.10.0808101124370.1727@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 04:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSNS8-0006oG-5F
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 04:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYHKCnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 22:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbYHKCnm
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 22:43:42 -0400
Received: from george.spearce.org ([209.20.77.23]:32945 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbYHKCnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 22:43:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C407338375; Mon, 11 Aug 2008 02:43:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0808101124370.1727@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91910>

Jan Engelhardt <jengelh@medozas.de> wrote:
> On Sunday 2008-08-10 11:19, Jan Engelhardt wrote:
> >
> >I have a somewhat older development tree at git://dev.medozas.de/linux 
> >(about 2.6.26-rc6), and without any tags. Now, adding in Linus's 
> >repository makes it gather all the new stuff, and all the missing tags:
> >[...]
> >What interests me here is why there are two "From" lines.
...
> And my suspicion is that v2.6.19.1--v2.6.19.6 have been repacked into 
> packed-refs, and v2.6.19.7 has been added later and is a loose tag (as 
> is the master branch). So the packed-refs (with less recent history) are 
> fetched later, which conflicts with the output from Linus's repo where I 
> get the (possibly packed) tags first, in chronological order.

Sort of, but not really.

The remote server running git:// must not be new enough to support
the include-tag extension.  So fetching tags which the client
does not have the objects for, and which the client isn't 100%
sure it will need to fetch have to be done during the second pass,
which is when the second From line is displayed.

These tags caught during the second pass are tags pointing at much
older commits; commits which no active branch is currently pointing
at directly, but which are reachable indirectly.  That is why you
are seeing this second pass pick up the "older" tags.

-- 
Shawn.
