From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Abort mergetool on read error from stdinput
Date: Fri, 3 Dec 2010 03:14:09 -0600
Message-ID: <20101203091409.GG18202@burratino>
References: <1291271301-12511-1-git-send-email-robin.rosenberg@dewire.com>
 <20101202063851.GA1407@burratino>
 <70B726FD-EC6A-47B2-9AB1-1CDA3B19358A@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 10:14:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORin-0000DJ-Tj
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 10:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0LCJOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 04:14:24 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51646 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab0LCJOX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 04:14:23 -0500
Received: by ywl5 with SMTP id 5so4647280ywl.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 01:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bPr5ivKgELyBTDrbQ5KinK/7FTRVStYMdXyg5wbM96A=;
        b=Bd1jVpfmyC+0IruGW+HywCpXDlhTrWQo3rB0EaMTIUhO+5YsWzwZf3xpr/GHCzMtBw
         HBplCQTxGYYtc22wEZdCgNBMX5acZ8G3OSi4o7sKDW8RRHlVvkteYmwFz5kf2rVd2CYM
         tx9ZGDu/EBBhTMpjItPwBO19Xkbx3ocajntC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vPSdNLAOpN0X1ZUld9faNVb5zqWmNtyfcw7I55ZtBT9LihWhgTArBk6PG+d+fUSxZQ
         Y73trI2YslL7qrakxqQ7KC64viPZLRWKY8z78mXmP9OiK3zxwSe6AyJxwWBDHo5Agx5R
         rHkDGnkwhFbjWdoHLTiSenuaCd5V3I5vdNnRo=
Received: by 10.100.42.1 with SMTP id p1mr1289024anp.79.1291367662292;
        Fri, 03 Dec 2010 01:14:22 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id c7sm1587972ana.17.2010.12.03.01.14.20
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 01:14:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <70B726FD-EC6A-47B2-9AB1-1CDA3B19358A@dewire.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162780>

Robin Rosenberg wrote:

> Subject: [PATCH] Abort mergetool on read error from stdinput
> 
> If the mergetool has not quit (by mistake like pressing
> Command-W instead of Command-Q) and the user pressed Ctrl-C
> in the shell that runs mergetool, bash goes into an infinite
> look, at least on Mac OS X. Ctrl-C kills the diff program
> but not the mergetool script.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  git-mergetool--lib.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> index 77d4aee..1d1413d 100644
> --- a/git-mergetool--lib.sh
> +++ b/git-mergetool--lib.sh
> @@ -35,7 +35,7 @@ check_unchanged () {
>  		while true; do
>  			echo "$MERGED seems unchanged."
>  			printf "Was the merge successful? [y/n] "
> -			read answer
> +			read answer || exit 1
>  			case "$answer" in
>  			y*|Y*) status=0; break ;;
>  			n*|N*) status=1; break ;;

> Here is a better version and motivation.

Thanks.  For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
