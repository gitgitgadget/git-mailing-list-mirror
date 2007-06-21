From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: use "blame -w -C -C" for "where did it come from, originally?"
Date: Thu, 21 Jun 2007 01:01:17 -0400
Message-ID: <20070621050117.GF8477@spearce.org>
References: <200706162226.l5GMQBss004492@mi0.bluebottle.com> <7vk5tx5333.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 07:01:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1EnN-0003x3-1J
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 07:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXFUFBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 01:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbXFUFBX
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 01:01:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37527 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbXFUFBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 01:01:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1EnJ-0002Do-8z; Thu, 21 Jun 2007 01:01:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A911420FBAE; Thu, 21 Jun 2007 01:01:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vk5tx5333.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50594>

Junio C Hamano <gitster@pobox.com> wrote:
> The blame window shows "who wrote the piece originally" and "who
> moved it there" in two columns.  In order to identify the former
> more correctly, it helps to use the new -w option.
...
> diff --git a/lib/blame.tcl b/lib/blame.tcl
> index 139171d..a412a8c 100644
> --- a/lib/blame.tcl
> +++ b/lib/blame.tcl
> @@ -672,7 +672,7 @@ method _read_blame {fd cur_w cur_d cur_s} {
>  		close $fd
>  		if {$cur_w eq $w_asim} {
>  			_exec_blame $this $w_amov @amov_data \
> -				[list -M -C -C] \
> +				[list -w -C -C] \
>  				{ original location}
>  		} else {
>  			set current_fd {}
> 

I've wanted to do this since you introduced `git blame -w`.  But I
can't use it, because I cannot trust that -w is there.  For example
it is not in maint, but the new blame viewer from git-gui is.

Apply my --list-features patch to core Git and I'll activate -w in
git-gui when --list-features claims the 'blame-ignore-whitespace'
feature is available.

;-)

-- 
Shawn.
