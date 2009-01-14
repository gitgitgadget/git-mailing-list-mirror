From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Tue, 13 Jan 2009 18:16:48 -0800
Message-ID: <20090114021648.GV10179@spearce.org>
References: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 03:18:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvKc-0000SX-N9
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZANCQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbZANCQu
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:16:50 -0500
Received: from george.spearce.org ([209.20.77.23]:36020 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbZANCQt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:16:49 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6F70C38210; Wed, 14 Jan 2009 02:16:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105573>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> "S_IFREG | mode" probably is only required for 0644 and 0755.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  fast-import.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index a6bce66..f0e08ac 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1872,12 +1872,13 @@ static void file_change_m(struct branch *b)
>  	if (!p)
>  		die("Corrupt mode: %s", command_buf.buf);
>  	switch (mode) {
> +	case 0644:
> +	case 0755:
> +		mode |= S_IFREG;
>  	case S_IFREG | 0644:
>  	case S_IFREG | 0755:
>  	case S_IFLNK:
>  	case S_IFGITLINK:
> -	case 0644:
> -	case 0755:
>  		/* ok */
>  		break;
>  	default:
> @@ -1944,7 +1945,7 @@ static void file_change_m(struct branch *b)
>  			    typename(type), command_buf.buf);
>  	}
>  
> -	tree_content_set(&b->branch_tree, p, sha1, S_IFREG | mode, NULL);
> +	tree_content_set(&b->branch_tree, p, sha1, mode, NULL);
>  }
>  
>  static void file_change_d(struct branch *b)
> -- 
> 1.6.0.6.5.ga66c
> 

-- 
Shawn.
