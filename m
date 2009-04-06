From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Submodules can't work recursively because Git implements
	policy?
Date: Mon, 6 Apr 2009 07:51:40 -0700
Message-ID: <20090406145140.GG23604@spearce.org>
References: <33f4f4d70904060642m25b2cff8nafed433eeabfb6c4@mail.gmail.com> <20090406135618.GA17793@pvv.org> <33f4f4d70904060747h72019846gca18255bd71adc22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:53:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqqCI-0003s0-7e
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbZDFOvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZDFOvn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:51:43 -0400
Received: from george.spearce.org ([209.20.77.23]:53808 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbZDFOvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:51:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 90ECF38211; Mon,  6 Apr 2009 14:51:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <33f4f4d70904060747h72019846gca18255bd71adc22@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115842>

Klas Lindberg <klas.lindberg@gmail.com> wrote:
> On Mon, Apr 6, 2009 at 3:56 PM, Finn Arne Gangstad <finnag@pvv.org> wrote:
> > Maybe the security concerns could be handled by adding some
> > functionality to (quickly) get rid of unwanted commits?
> 
> Why not simply allow users with write permissions to "pop" revisions
> from the top of the history DAG in a way that actually really deletes
> the them? Or at least moves those commits to a separate, locked down
> DAG that cannot be read by people without write permissions?

What, like a secret shadow repository that you move the objects into?

That could be very expensive in terms of disk IO if those objects
are in large packs.  You'd need to break the pack apart into the
"ok" and "sekret" parts.  Ick.
 
> But anyway: If I implement support for fetching SHA keys and full
> recursive behaviour in the presence of submodules; would my patches
> automatically be rejected because of the rationale for the current
> behaviour?

See my recent email (like ~10-15 minutes ago).  It will be rejected
due to the issue that unreachable objects are subjected to GC and
you'd easily see your repository delete that data on the next "git
gc" invocation.  Automatic data destruction is not something that
users come to git for.

-- 
Shawn.
