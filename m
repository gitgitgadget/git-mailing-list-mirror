From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] contrib/difftool: add support for Kompare
Date: Fri, 30 Jan 2009 22:37:15 -0800
Message-ID: <20090131063714.GA29621@gmail.com>
References: <200901310019.30117.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 31 07:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT9cD-0006b0-B8
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 07:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbZAaGgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 01:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZAaGgm
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 01:36:42 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:6070 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZAaGgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 01:36:41 -0500
Received: by rv-out-0506.google.com with SMTP id k40so774731rvb.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 22:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=M3PeZRizGq2HTkZsEx1VjKub+1+oIcGMjOjcd8YZHWM=;
        b=j22mWsMeDII0NGZOn30fWL7dcQ1rTqsTXFriK4CnuUqHLveswzB0m2ZniY3FgYrH2/
         fcUNEX7Xi5RjAxGxYGWrNkJZlbDfg6DnaV09aK20uB3DsaJMtiBcPKKYinvrb4R8lXBs
         foafpczebwmQRg8fEW8rokWV5vJvi1i5Kb1Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wvsW5Y4992id+haoYl7gaOQyjXJOId5yoUdghT6sIZSatKhiJJSwlt5N5oZk57jKfV
         9xJNgJLZCPqzNSXnWSKffVm63LIrlCUADvsjMqU0G+G32iuHJAjaHCM6wiSSTBQSNc4J
         Z+Bp2zJKcStciDYFoDq3AZUda29iL7Gg9lwno=
Received: by 10.141.88.3 with SMTP id q3mr335779rvl.68.1233383799940;
        Fri, 30 Jan 2009 22:36:39 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id b39sm1888144rvf.0.2009.01.30.22.36.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 22:36:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200901310019.30117.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107904>

On  0, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>  contrib/difftool/git-difftool-helper |   16 ++++++++++------
>  contrib/difftool/git-difftool.txt    |    3 ++-
>  2 files changed, 12 insertions(+), 7 deletions(-)


Good stuff =)
Should we patch mergetool with the same change?
Kompare's pretty popular in KDE land.


BTW git.git's next branch has:

commit fb700cb0679e22900f0d1435641e6cf7c652968b
Author: Johannes Gilger <heipei@hackvalue.de>
Date:   Sat Jan 24 00:12:45 2009 +0100

    mergetool: Don't repeat merge tool candidates
    
    git mergetool listed some candidates for mergetools twice, depending on
    the environment.
    
    This slightly changes the behavior when both KDE_FULL_SESSION and
    GNOME_DESKTOP_SESSION_ID are set at the same time; in such a case
    meld is used in favor of kdiff3 (the old code favored kdiff3 in such a
    case), but it should not matter in practice.
    
    Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>


difftool probably needs a similar patch.
I'll see if I can get to that this weekend if no one beats
me to it.


> 
> diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
> index 0c48506..10632a3 100755
> --- a/contrib/difftool/git-difftool-helper
> +++ b/contrib/difftool/git-difftool-helper
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # git-difftool-helper is a GIT_EXTERNAL_DIFF-compatible diff tool launcher.
> -# It supports kdiff3, tkdiff, xxdiff, meld, opendiff, emerge, ecmerge,
> -# vimdiff, gvimdiff, and custom user-configurable tools.
> +# It supports kdiff3, kompare, tkdiff, xxdiff, meld, opendiff,
> +# emerge, ecmerge, vimdiff, gvimdiff, and custom user-configurable tools.
>  # This script is typically launched by using the 'git difftool'
>  # convenience command.
>  #
> @@ -73,6 +73,10 @@ launch_merge_tool () {
>  			> /dev/null 2>&1
>  		;;
>  
> +	kompare)
> +		"$merge_tool_path" "$LOCAL" "$REMOTE"
> +		;;
> +
>  	tkdiff)
>  		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
>  		;;
> @@ -134,7 +138,7 @@ valid_custom_tool() {
>  # Built-in merge tools are always valid.
>  valid_tool() {
>  	case "$1" in
> -	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
> +	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge)
>  		;; # happy
>  	*)
>  		if ! valid_custom_tool "$1"
> @@ -180,14 +184,14 @@ if test -z "$merge_tool"; then
>  
>  	# We have a $DISPLAY so try some common UNIX merge tools
>  	if test -n "$DISPLAY"; then
> -		merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
> +		merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff"
>  		# If gnome then prefer meld
>  		if test -n "$GNOME_DESKTOP_SESSION_ID"; then
>  			merge_tool_candidates="meld $merge_tool_candidates"
>  		fi
> -		# If KDE then prefer kdiff3
> +		# If KDE then prefer kdiff3 or kompare
>  		if test "$KDE_FULL_SESSION" = "true"; then
> -			merge_tool_candidates="kdiff3 $merge_tool_candidates"
> +			merge_tool_candidates="kdiff3 kompare $merge_tool_candidates"
>  		fi
>  	fi
>  
> diff --git a/contrib/difftool/git-difftool.txt b/contrib/difftool/git-difftool.txt
> index ca3dbd2..6e2610c 100644
> --- a/contrib/difftool/git-difftool.txt
> +++ b/contrib/difftool/git-difftool.txt
> @@ -28,7 +28,8 @@ OPTIONS
>  --tool=<tool>::
>  	Use the merge resolution program specified by <tool>.
>  	Valid merge tools are:
> -	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, and opendiff
> +	kdiff3, kompare, tkdiff, meld, xxdiff, emerge,
> +	vimdiff, gvimdiff, ecmerge, and opendiff
>  +
>  If a merge resolution program is not specified, 'git-difftool'
>  will use the configuration variable `merge.tool`.  If the
> -- 
> 1.6.1.2.256.g62566b
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

	David
