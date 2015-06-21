From: Christoph Hellwig <hch@infradead.org>
Subject: Re: broken repo after power cut
Date: Sun, 21 Jun 2015 06:59:03 -0700
Message-ID: <20150621135903.GA18719@infradead.org>
References: <5585C1B6.50407@nod.at>
 <330ab8f498e1b435d5b210384200b649@www.dscho.org>
 <5586B71D.2070407@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, David Gstir <david@sigma-star.at>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Sun Jun 21 15:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6fmE-0002Ba-EL
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 15:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbbFUN7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 09:59:10 -0400
Received: from bombadil.infradead.org ([198.137.202.9]:34812 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbbFUN7I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 09:59:08 -0400
Received: from hch by bombadil.infradead.org with local (Exim 4.80.1 #2 (Red Hat Linux))
	id 1Z6fm3-0007I1-Pt; Sun, 21 Jun 2015 13:59:03 +0000
Content-Disposition: inline
In-Reply-To: <5586B71D.2070407@nod.at>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272264>

On Sun, Jun 21, 2015 at 03:07:41PM +0200, Richard Weinberger wrote:
> >> To me it seems like git was creating a new object and got interrupted
> >> before fsync/fdatasync'ing it.
> >> As the object was referenced before syncing the data to disk the repo broke.

Git doesn't fsync by default, and because of that I've seen similar
data losses on ext4/xfs/btrfs.

You can set the core.fsyncobjectfiles to mitigate it, but even with
that I've seen corrupted index files.

Note that I've been mostly on old git versions from various distros,
so in case this was fixed recently I'll take everything I said back.
