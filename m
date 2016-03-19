From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 1/2] gitk: Add a 'rename' option to the branch context
 menu
Date: Sat, 19 Mar 2016 14:45:55 +1100
Message-ID: <20160319034555.GB27126@fergus.ozlabs.ibm.com>
References: <51900395.pKIx87RN0F@wiske>
 <1859807.50qitjY8Ul@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rogier Goossens <goossens.rogier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:00:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahAsb-00048z-Bz
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 08:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbcCSHAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 03:00:51 -0400
Received: from ozlabs.org ([103.22.144.67]:53829 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbcCSHAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 03:00:39 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3qRtK13mYKz9s9Z; Sat, 19 Mar 2016 18:00:37 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1859807.50qitjY8Ul@wiske>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289293>

On Fri, Jan 15, 2016 at 10:38:49PM +0100, Rogier Goossens wrote:
> 
> Signed-off-by: Rogier Goossens <goossens.rogier@gmail.com>

This is a nice idea; I just have some comments about the Tcl here:

> @@ -9756,15 +9831,19 @@ proc headmenu {x y id head} {
>      stopfinding
>      set headmenuid $id
>      set headmenuhead $head
> -    set state normal
> +    array set state {0 normal 1 normal 2 normal 3 normal}
>      if {[string match "remotes/*" $head]} {
> -	set state disabled
> +	set state(0) disabled
> +	set state(1) disabled
> +	set state(2) disabled

Why not "array set state {0 disabled 1 disabled 2 disabled}" instead?

>      }
>      if {$head eq $mainhead} {
> -	set state disabled
> +	set state(0) disabled
> +	set state(1) disabled

Similarly, "array set state {0 disabled 1 disabled}".

> +    }
> +    foreach i {0 1 2 3} {

Why do you go up to 3 when we never disable the 3rd entry?

Paul.
