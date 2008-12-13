From: Josef Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [PATCH] guilt: add option guilt.diffstat
Date: Fri, 12 Dec 2008 23:43:57 -0500
Message-ID: <20081213044357.GD15407@josefsipek.net>
References: <20081213021422.GA28249@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wu Fengguang <fengguang.wu@intel.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 05:54:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBMWc-0000ah-PB
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 05:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYLMEx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 23:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754009AbYLMEx2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 23:53:28 -0500
Received: from josefsipek.net ([141.211.133.196]:41426 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbYLMEx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 23:53:28 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Dec 2008 23:53:28 EST
Received: by josefsipek.net (Postfix, from userid 1000)
	id 956E81C01BA2; Fri, 12 Dec 2008 23:43:57 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20081213021422.GA28249@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102985>

On Sat, Dec 13, 2008 at 10:14:22AM +0800, Wu Fengguang wrote:
> Introduce option guilt.diffstat so that we don't have to type
> "guilt refresh --diffstat" in its full form every time.

Good idea.

> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> ---
>  guilt |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- guilt.orig	2008-12-13 09:53:32.000000000 +0800
> +++ guilt	2008-12-13 10:01:03.000000000 +0800
> @@ -538,7 +538,7 @@ __refresh_patch()
>  
>  		[ ! -z "$4" ] && diffopts="-C -M --find-copies-harder"
>  		
> -		if [ ! -z "$5" ]; then
> +		if [ -n "$5" -o "x$diffstat" = "x1" ]; then

Why the 'x' thing? I've seen it is some scripts before, but I can't think of
a reason to use it if the variable is surrounded in quotation marks.

>  			(
>  				echo "---"
>  				git diff --stat $diffopts "$2"
> @@ -627,6 +627,9 @@ guilt_push_diff_context=1
>  # default autotag value
>  AUTOTAG_DEFAULT=1
>  
> +# default diffstat value
> +DIFFSTAT_DEFAULT=0
> +
>  #
>  # Parse any part of .git/config that belongs to us
>  #
> @@ -635,6 +638,10 @@ AUTOTAG_DEFAULT=1
>  autotag=`git config guilt.autotag`
>  [ -z "$autotag" ] && autotag=$AUTOTAG_DEFAULT
>  
> +# generate diffstat?
> +diffstat=`git config guilt.diffstat`
> +[ -z "$diffstat" ] && diffstat=$DIFFSTAT_DEFAULT
> +
>  #
>  # The following gets run every time this file is source'd
>  #

Could you throw a quick note into the manpages?

Thanks,

Josef 'Jeff' Sipek.

-- 
My public GPG key can be found at
http://www.josefsipek.net/gpg/public-0xC7958FFE.txt
