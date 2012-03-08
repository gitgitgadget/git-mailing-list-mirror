From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH] gitk: use symbolic font names "sans" and "monospace"
 when available
Date: Thu, 8 Mar 2012 21:19:30 +0000 (GMT)
Message-ID: <alpine.LNX.2.01.1203082118260.1467@stax.localdomain>
References: <20120308123011.GA4355@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Josh Triplett <josh@joshtriplett.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 22:38:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5l2h-0001JR-0J
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412Ab2CHVia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 16:38:30 -0500
Received: from mx.ij.cx ([212.13.201.15]:50278 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755551Ab2CHVi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 16:38:29 -0500
X-Greylist: delayed 1136 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2012 16:38:29 EST
Received: from cpc2-acto2-0-0-cust942.4-2.cable.virginmedia.com ([82.28.203.175] helo=stax.localdomain)
	by wes.ijneb.com with esmtpa (Exim 4.77)
	(envelope-from <mark@pogo.org.uk>)
	id 1S5kkF-0006Jd-Mg; Thu, 08 Mar 2012 21:19:31 +0000
Received: from mark (helo=localhost)
	by stax.localdomain with local-esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1S5kkE-0000SW-U8; Thu, 08 Mar 2012 21:19:30 +0000
In-Reply-To: <20120308123011.GA4355@burratino>
X-SA-Exim-Connect-IP: 82.28.203.175
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192655>

On Thu, 8 Mar 2012, Jonathan Nieder wrote:

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

Sounds reasonable to me.

Acked-by: Mark Hills <mark@pogo.org.uk>

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
> 

-- 
Mark
