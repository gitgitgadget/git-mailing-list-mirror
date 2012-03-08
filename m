From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] gitk: use symbolic font names "sans" and "monospace"
 when available
Date: Thu, 8 Mar 2012 04:46:35 -0800
Message-ID: <20120308124635.GA24679@leaf>
References: <20120308123011.GA4355@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Mark Hills <mark@pogo.org.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 13:47:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ckA-0004Lj-13
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 13:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570Ab2CHMqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 07:46:44 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54231 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab2CHMqn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 07:46:43 -0500
X-Originating-IP: 217.70.178.146
Received: from mfilter18-d.gandi.net (mfilter18-d.gandi.net [217.70.178.146])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id E343C17209E;
	Thu,  8 Mar 2012 13:46:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter18-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter18-d.gandi.net (mfilter18-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id aG6ocEoVq2jc; Thu,  8 Mar 2012 13:46:40 +0100 (CET)
X-Originating-IP: 50.43.46.74
Received: from leaf (static-50-43-46-74.bvtn.or.frontiernet.net [50.43.46.74])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id BDBA8172071;
	Thu,  8 Mar 2012 13:46:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120308123011.GA4355@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192586>

On Thu, Mar 08, 2012 at 06:30:11AM -0600, Jonathan Nieder wrote:
> The following only concerns systems using X and the client-side font
> rendering framework from freedesktop.org.  Windows and Mac OS X are
> not affected.
> 
> Starting with version 8.5, Tk uses freetype and fontconfig by default
> to render fonts on platforms that support it.  Gitk currently defaults
> to the font Helvetica for the interface and Courier for diffs, and
> both unfortunately look rather bad on screen in the default
> configuration on many Linux distros with anti-aliasing and poor
> hinting.
> 
> It is better to default to "sans" and "monospace", which are mapped by
> fontconfig to some appropriate font of the sysadmin and user's
> choosing (typically Bitstream Vera Sans and Mono).  The result looks
> more sensible and it makes gitk feel like a well-behaved software
> citizen since its fonts match other native apps.
> 
> This patch does not change the appearance of gitk for users that have
> already run it, since gitk uses the remembered UI and diff font names
> from ~/.gitk
> 
> Requested-by: Michael Biebl <biebl@debian.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> ---
> Hi,
> 
> A variant of this patch that just unconditionally set the fonts has
> been in Debian for more than a year, but just now I finally got around
> to making it conditional.  Tested with tk 8.5 (where fontconfig is
> used) and tk 8.4 (where it isn't) and the autodetection seems to work.
> 
> Sensible?
> 
> Jonathan
> 
>  gitk-git/gitk |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 64ef3c40..6981cb20 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11426,6 +11426,11 @@ if {[tk windowingsystem] eq "aqua"} {
>      set mainfont {{Lucida Grande} 9}
>      set textfont {Monaco 9}
>      set uifont {{Lucida Grande} 9 bold}
> +} elseif {![catch {::tk::pkgconfig get fontsystem} xft] && $xft eq "xft"} {
> +    # fontconfig!
> +    set mainfont {sans 9}
> +    set textfont {monospace 9}
> +    set uifont {sans 9 bold}
>  } else {
>      set mainfont {Helvetica 9}
>      set textfont {Courier 9}
> -- 
> 1.7.9.2
> 
