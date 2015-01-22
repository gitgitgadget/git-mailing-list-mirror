From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v4 32/33] Improved doc and tests for guilt header.
Date: Thu, 22 Jan 2015 08:56:02 -0500
Message-ID: <20150122135602.GA101460@meili.jeffnet.31bits.net>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
 <1400450409-30998-33-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 15:01:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEIKV-0005uH-4i
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 15:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbbAVOBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 09:01:47 -0500
Received: from josefsipek.net ([71.174.113.7]:1540 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704AbbAVOBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 09:01:46 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2015 09:01:46 EST
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 739485567A;
	Thu, 22 Jan 2015 08:56:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1400450409-30998-33-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262833>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


On Mon, May 19, 2014 at 12:00:08AM +0200, Per Cederqvist wrote:
> ---
>  Documentation/guilt-header.txt | 5 ++++-
>  regression/t-028.out           | 9 +++++++++
>  regression/t-028.sh            | 3 +++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/guilt-header.txt b/Documentation/guilt-header.txt
> index 870bfaf..71b2e66 100644
> --- a/Documentation/guilt-header.txt
> +++ b/Documentation/guilt-header.txt
> @@ -18,7 +18,10 @@ Prints either the topmost patch's header or the header of a specified patch.
>  -E::
>  	Open the raw patch in an editor, instead of printing it.
>  <patchname>::
> -	Name of the patch.
> +	Name of the patch. If a patch with exactly this name exists,
> +	use it. Otherwise, treat the name as a regexp; if the regexp
> +	matches a single patch, use it. Otherwise, list all matching
> +	patch names to stderr and fail.
>  
>  Author
>  ------
> diff --git a/regression/t-028.out b/regression/t-028.out
> index ea72a3a..39ac900 100644
> --- a/regression/t-028.out
> +++ b/regression/t-028.out
> @@ -56,3 +56,12 @@ Patch non-existant is not in the series
>    remove
>    mode
>    patch-with-some-desc
> +% guilt header de
> +de does not uniquely identify a patch. Did you mean any of these?
> +  mode
> +  patch-with-some-desc
> +% guilt header des
> +blah blah blah
> +
> +Signed-off-by: Commiter Name <commiter@email>
> +
> diff --git a/regression/t-028.sh b/regression/t-028.sh
> index 2ce0378..cd3088c 100755
> --- a/regression/t-028.sh
> +++ b/regression/t-028.sh
> @@ -35,4 +35,7 @@ shouldfail guilt header non-existant
>  # patch name is a regexp that just happens to match an existing patch.
>  shouldfail guilt header '.*'
>  
> +shouldfail guilt header de
> +cmd guilt header des
> +
>  # FIXME: how do we check that -e works?
> -- 
> 1.8.3.1
> 

-- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman
