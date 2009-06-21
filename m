From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Sun, 21 Jun 2009 02:22:22 -0700
Message-ID: <7v3a9uszzl.fsf@alter.siamese.dyndns.org>
References: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
	<slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 11:22:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJFw-00015l-Sl
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbZFUJWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 05:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZFUJWW
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:22:22 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55096 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbZFUJWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:22:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621092224.QNZV20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jun 2009 05:22:24 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6ZNN1c0034aMwMQ03ZNNYT; Sun, 21 Jun 2009 05:22:24 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=abpcs_R5fxsA:10 a=pGLkceISAAAA:8
 a=lssDqVK3QJZrHppHoSkA:9 a=a6xoL4iir8HYmV8xeK_vtGwHZn4A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net> (Sitaram Chamarty's message of "Sun\, 21 Jun 2009 09\:11\:28 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121975>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> At the command line, this gives you a detailed warning message, but the
> GUI currently allows it without any fuss.
>
> Since the GUI is often used by people much less familiar with git, it
> seems reasonable to make the GUI more restrictive than the command line,
> not less.
> ...
> This patch helps me a lot.

The patch seems to disable checkout unconditionally, but it at least needs
an "expert mode" switch to bypass the patch's logic, or (better yet) a
"training wheel" switch for you to set in repositories of the people you
manage.

> diff --git a/gitk-git/gitk b/gitk-git/gitk
> old mode 100644
> new mode 100755
> index 8c66d17..411bc52
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk

The above should ideally read:

> diff --git a/gitk b/gitk
> index 8c66d17..411bc52
> --- a/gitk
> +++ b/gitk

if the patch goes to Paulus.

> @@ -8770,6 +8770,9 @@ proc headmenu {x y id head} {
>      set headmenuid $id
>      set headmenuhead $head
>      set state normal
> +    if {[string match "remotes/*" $head]} {
> +	set state disabled
> +    }
>      if {$head eq $mainhead} {
>  	set state disabled
>      }
> -- 
> 1.6.3.2
