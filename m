From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/4] Change history page table to SWT.VIRTUAL.
Date: Mon, 31 Mar 2008 01:34:30 -0400
Message-ID: <20080331053430.GJ10274@spearce.org>
References: <1206890314-3712-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Mon Mar 31 07:35:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgCg6-0005QS-Ev
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 07:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYCaFeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 01:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYCaFeg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 01:34:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56600 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbYCaFeg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 01:34:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JgCf9-00059L-Uq; Mon, 31 Mar 2008 01:34:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 644C620FBAE; Mon, 31 Mar 2008 01:34:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1206890314-3712-1-git-send-email-rogersoares@intelinet.com.br>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78557>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> It makes the history page show about the same speed as gitk on my
> eclipse.
> 
> From the eclipse API:
> 
> "Style VIRTUAL is used to create a Table whose TableItems are to be
> populated by the client on an on-demand basis instead of up-front.
> This can provide significant performance improvements for tables
> that are very large or for which TableItem population is expensive
> (for example, retrieving values from an external source)."

Yea, I originally wrote my series around the VIRTUAL flag but on
Win32 it caused ArrayIndexOutOfBoundsExceptions to be thrown from
deep down within the Win32 implementation of the SWT Table widget.

Appears to be something of a known bug, based on the Eclipse issue
tracker, but not much work happening to fix it.

I'll retest this tomorrow on Win32, but I'm pretty certain its
a bad idea on that platform.  What are you running on, Linux?
Maybe we can set this flag everywhere except on Win32.
 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
> index fffe7e0..6559d64 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitGraphTable.java
> @@ -88,7 +88,7 @@ class CommitGraphTable {
>  		hFont = highlightFont();
>  
>  		final Table rawTable = new Table(parent, SWT.MULTI | SWT.H_SCROLL
> -				| SWT.V_SCROLL | SWT.BORDER | SWT.FULL_SELECTION);
> +				| SWT.V_SCROLL | SWT.BORDER | SWT.FULL_SELECTION | SWT.VIRTUAL);
>  		rawTable.setHeaderVisible(true);
>  		rawTable.setLinesVisible(false);
>  		rawTable.setFont(nFont);

-- 
Shawn.
