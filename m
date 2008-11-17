From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git to libgit2 code relicensing
Date: Mon, 17 Nov 2008 07:40:40 -0800
Message-ID: <20081117154040.GO2932@spearce.org>
References: <491DE6CC.6060201@op5.se> <200811151615.42345.chriscool@tuxfamily.org> <49200914.6090506@op5.se> <alpine.DEB.1.00.0811162159280.30769@pacific.mpi-cbg.de> <49211C19.5010409@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 17 16:42:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L26Eh-00045v-T6
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 16:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYKQPkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 10:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbYKQPkn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 10:40:43 -0500
Received: from george.spearce.org ([209.20.77.23]:46163 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbYKQPkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 10:40:41 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E5324381FF; Mon, 17 Nov 2008 15:40:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49211C19.5010409@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101227>

Andreas Ericsson <ae@op5.se> wrote:
>
> "Copy-rewrite", naturally. Being able to lift much of the data-munging code
> is a great benefit. It's basically just the revision traversal (which is
> heavy on state-dependant code) that I haven't quite figured out how to do
> yet, but I believe Shawn's idea of using revision pools is most likely the
> way to go. Each application has to make sure a pool isn't modified by more
> than one thread, but each application can have as many pools as it likes.

I also like Pierre's idea of using annotation data in different
annotation pools, and storing the rewritten parents in such a pool.
Then an application can more easily reuse a revision pool, by just
tossing the rewritten parent pool, or any other annotations it
wants to recompute.

It may still be important to have revision pools and make them
not thread-safe, so we can void fine-grained locking costs in
the library during the tight revision traversal loops.

-- 
Shawn.
