From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] Documentation: finding $(prefix)/etc/gitconfig when
 prefix = /usr
Date: Sun, 7 Jul 2013 23:21:52 +0100
Message-ID: <20130707222152.GV9161@serenity.lan>
References: <1373234402-6856-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 00:22:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxLc-0000uj-7r
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239Ab3GGWWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:22:01 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:33676 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab3GGWWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:22:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id CACE66064F3;
	Sun,  7 Jul 2013 23:22:00 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ByKnkB014M73; Sun,  7 Jul 2013 23:22:00 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 1FE1A6064E7;
	Sun,  7 Jul 2013 23:21:59 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id E4149161E24E;
	Sun,  7 Jul 2013 23:21:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SQWw-KRcmefb; Sun,  7 Jul 2013 23:21:58 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 867EE161E461;
	Sun,  7 Jul 2013 23:21:54 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1373234402-6856-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229809>

On Mon, Jul 08, 2013 at 12:00:02AM +0200, Robin Rosenberg wrote:
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/git-config.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 9ae2508..3198d52 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -107,7 +107,8 @@ See also <<FILES>>.
>  
>  --system::
>  	For writing options: write to system-wide $(prefix)/etc/gitconfig
> -	rather than the repository .git/config.
> +	rather than the repository .git/config. However, $(prefix) is /usr
> +	then /etc/gitconfig is used.

That's a build time condition, not something that's decided at runtime
so I'm not sure that this logic belongs in the user facing
documentation.  The technically correct change would be to use
"$(sysconfdir)/gitconfig" but I think that will just confuse users more.

Since we have a build step for the documentation, I wonder if it's
possible to replace these with the correct directory at build time.

>  +
>  For reading options: read only from system-wide $(prefix)/etc/gitconfig
>  rather than from all available files.
> @@ -214,7 +215,8 @@ $XDG_CONFIG_HOME/git/config::
>  	file was added fairly recently.
>  
>  $(prefix)/etc/gitconfig::
> -	System-wide configuration file.
> +	System-wide configuration file, unless $(prefix) is /usr. In the
> +	latter case /etc/gitconfig is used.
>  
>  If no further options are given, all reading options will read all of these
>  files that are available. If the global or the system-wide configuration
> -- 
> 1.8.3.rc0.19.g7e6a0cc
