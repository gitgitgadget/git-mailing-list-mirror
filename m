From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH, take 1] Linear-time/space rename logic (exact renames only)
Date: Mon, 22 Oct 2007 09:07:50 +0200
Message-ID: <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 09:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjrOR-0008Gv-CE
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 09:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbXJVHHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 03:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbXJVHHx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 03:07:53 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:39414 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbXJVHHw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 03:07:52 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JQA007IWX52PP@psmtp09.wxs.nl> for git@vger.kernel.org; Mon,
 22 Oct 2007 09:07:51 +0200 (MEST)
Received: (qmail 24880 invoked by uid 500); Mon, 22 Oct 2007 07:07:50 +0000
In-reply-to: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61962>

On Sun, Oct 21, 2007 at 04:59:03PM -0700, Linus Torvalds wrote:
> +static int find_same_files(void *ptr)
> +{
> +	struct file_similarity *p = ptr;
> +	struct file_similarity *src = NULL, *dst = NULL;
> +
> +	/* Split the hash list up into sources and destinations */
> +	do {
> +		struct file_similarity *entry = p;
> +		p = p->next;
> +		if (entry->src_dst < 0) {
> +			entry->next = src;
> +			src = entry;
> +		} else {
> +			entry->next = dst;
> +			dst = entry;
> +		}
> +	} while (p);

Aren't you truncating the ptr list after the first entry here?
(While you still need the whole list in free_file_table.)

skimo
