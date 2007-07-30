From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 1/4] get_series: Remove comments from end of series lines
Date: Sun, 29 Jul 2007 23:54:22 -0400
Message-ID: <20070730035422.GB22017@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <11856954183111-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:54:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMLG-0007er-Hj
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933593AbXG3Dyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933509AbXG3Dyj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:54:39 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45517 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbXG3Dyj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 23:54:39 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6U3sMfh026016;
	Sun, 29 Jul 2007 23:54:23 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6U3sMrR026014;
	Sun, 29 Jul 2007 23:54:22 -0400
Content-Disposition: inline
In-Reply-To: <11856954183111-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54177>

On Sun, Jul 29, 2007 at 12:50:15AM -0700, Eric Lesh wrote:
... 
> diff --git a/guilt b/guilt
> index f67bfb5..774909e 100755
> --- a/guilt
> +++ b/guilt
> @@ -178,7 +178,8 @@ get_series()
>  	#	- whitespace only
>  	#	- optional whitespace followed by '#' followed by more
>  	#	  optional whitespace
> -	grep -ve '^[[:space:]]*\(#.*\)*$' "$series"
> +	# also remove comments from end of lines
> +	grep -ve '^[[:space:]]*\(#.*\)*$' < "$series" | sed -e 's/[[:space:]]*#.*$//'

I'd be tempted to replace the whole thing with one sed script...something
like (not tested):

"
/^[[:space:]]*#/ ! {
	s/[[:space:]]*#.*$//

	p
}
"

Regardless of the other 3 patches, this one makes sense to include.

Josef 'Jeff' Sipek.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
