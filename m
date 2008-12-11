From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/5] Add copy(InputStream) to TemporaryBuffer
Date: Thu, 11 Dec 2008 07:52:18 -0800
Message-ID: <20081211155218.GF32487@spearce.org>
References: <1228971522-28764-1-git-send-email-spearce@spearce.org> <1228971522-28764-2-git-send-email-spearce@spearce.org> <1228971522-28764-3-git-send-email-spearce@spearce.org> <200812111640.34435.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 16:54:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAnr7-0003W8-0K
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 16:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbYLKPwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 10:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbYLKPwT
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 10:52:19 -0500
Received: from george.spearce.org ([209.20.77.23]:33232 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756104AbYLKPwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 10:52:19 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6B92238200; Thu, 11 Dec 2008 15:52:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200812111640.34435.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102802>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> torsdag 11 december 2008 05:58:39 skrev Shawn O. Pearce:
> > In some places we may find it ourselves with an InputStream we
> > need to copy into a TemporaryBuffer, so we can flatten out the
> > entire stream to a single byte[].  Putting the copy loop here
> > is more useful then duplicating it in application level code.
> > +	public void copy(final InputStream in) throws IOException {
> > +		final byte[] b = new byte[2048];
>
> Why not 8192 here too?

Blargh, you're right.  Actually what I should do is look to see
if blocks != null, in which case I should alloc a block and read
directly into it.  That would avoid one copy of the data.

-- 
Shawn.
