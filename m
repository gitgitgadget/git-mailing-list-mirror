From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] prepare_packed_git(): sort packs by age and localness.
Date: Sat, 10 Mar 2007 21:34:22 -0500
Message-ID: <20070311023422.GE10343@spearce.org>
References: <7vtzwsy0lb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 03:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQDtG-00057p-83
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 03:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbXCKCe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 21:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbXCKCe1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 21:34:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57707 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932705AbXCKCe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 21:34:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQDsz-0000mV-PA; Sat, 10 Mar 2007 21:34:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F1BEF20FBAE; Sat, 10 Mar 2007 21:34:22 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vtzwsy0lb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41898>

Junio C Hamano <junkio@cox.net> wrote:
> When accessing objects, we first look for them in packs that
> are linked together in the reverse order of discovery.
> 
> Since younger packs tend to contain more recent objects, which
> are more likely to be accessed often, and local packs tend to
> contain objects more relevant to our specific projects, sort the
> list of packs before starting to access them.  In addition,
> favoring local packs over the ones borrowed from alternates can
> be a win when alternates are mounted on network file systems.

ACK.  But...
 
> diff --git a/cache.h b/cache.h
> @@ -431,6 +432,7 @@ extern off_t find_pack_entry_one(const unsigned char *, struct packed_git *);
> +void rearrange_packed_git(void);

Is that really necessary to make public?

-- 
Shawn.
