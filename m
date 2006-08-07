From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Fixes to packed delta format reading.
Date: Mon, 7 Aug 2006 00:03:42 -0400
Message-ID: <20060807040342.GA20514@spearce.org>
References: <20060806183748.7591.61536.stgit@lathund.dewire.com> <20060806184038.7591.12898.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 06:04:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9wLU-0003t2-5k
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 06:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbWHGEDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 00:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWHGEDw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 00:03:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51653 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751000AbWHGEDv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 00:03:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9wKz-00020I-1u; Mon, 07 Aug 2006 00:03:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8B12A20FB77; Mon,  7 Aug 2006 00:03:43 -0400 (EDT)
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Content-Disposition: inline
In-Reply-To: <20060806184038.7591.12898.stgit@lathund.dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24994>

> ---
> 
>  .../src/org/spearce/jgit/lib/PatchDeltaStream.java |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java
> index 808e854..11a7679 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PatchDeltaStream.java
> @@ -105,7 +105,7 @@ public class PatchDeltaStream extends In
>                              + " load delta base for patching.");
>                      }
>                      shift += n;
> -                    expBaseLen += n;
> +                    expBaseLen -= n;
>                  }
>              }
>              finally
> @@ -269,7 +269,7 @@ public class PatchDeltaStream extends In
>          throws IOException
>      {
>          int r;
> -        while ((r = read(buf, o, len)) > 0)
> +        while ((r = deltaStream.read(buf, o, len)) > 0)
>          {
>              o += r;
>              len -= r;

Thanks.  I actually found these Friday night when I started reviewing
the code to double check its compliance with A Large Angry SCM's
file format documentation.  These were already made locally but I
didn't push them out to my web repository yet.  I'll do that shortly.

-- 
Shawn.
