From: "Wu, Bryan" <bryan.wu@analog.com>
Subject: Re: [PATCH] git-quiltimport /bin/sh-ism fix
Date: Fri, 30 Mar 2007 10:05:04 +0800
Organization: Analog Devices, Inc.
Message-ID: <1175220304.15391.46.camel@roc-desktop>
References: <20070329213820.GY24561@craic.sysops.org>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Daly <francis@daoine.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 04:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX6TW-0001io-F3
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 04:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbXC3CET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 22:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbXC3CET
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 22:04:19 -0400
Received: from nwd2mail11.analog.com ([137.71.25.57]:33425 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbXC3CES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 22:04:18 -0400
Received: from nwd2mhb1.analog.com ([137.71.5.12])
  by nwd2mail11.analog.com with ESMTP; 29 Mar 2007 22:04:17 -0400
X-IronPort-AV: i="4.14,350,1170651600"; 
   d="scan'208"; a="25874714:sNHT22955947"
Received: from nwd2exm4.ad.analog.com (nwd2exm4.ad.analog.com [10.64.53.123])
	by nwd2mhb1.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id WAA08128;
	Thu, 29 Mar 2007 22:04:13 -0400 (EDT)
Received: from 10.99.22.84 ([10.99.22.84]) by nwd2exm4.ad.analog.com ([10.64.53.123]) via Exchange Front-End Server owa.analog.com ([10.64.25.43]) with Microsoft Exchange Server HTTP-DAV ;
 Fri, 30 Mar 2007 02:04:13 +0000
Received: from roc-desktop by owa.analog.com; 30 Mar 2007 10:05:13 +0800
In-Reply-To: <20070329213820.GY24561@craic.sysops.org>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43491>

On Thu, 2007-03-29 at 22:38 +0100, Francis Daly wrote:
> Bryan Wu reported
> /usr/local/bin/git-quiltimport: 114: Syntax error: Missing '))'
> 
> Most bourne-ish shells I have here accept
>  x=$((echo x)|cat)
> but all bourne-ish shells I have here accept
>  x=$( (echo x)|cat)
> because $(( might mean arithmetic expansion.
> 
> Signed-off-by: Francis Daly <francis@daoine.org>
> ---
>  git-quiltimport.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index 08ac9bb..edccd82 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -115,7 +115,7 @@ for patch_name in $(cat "$QUILT_PATCHES/series" | grep -v '^#'); do
>  	if [ -z "$dry_run" ] ; then
>  		git-apply --index -C1 "$tmp_patch" &&
>  		tree=$(git-write-tree) &&
> -		commit=$((echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
> +		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git-commit-tree $tree -p $commit) &&
>  		git-update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
>  	fi
>  done

Cool. Thanks a lot.
-Bryan
