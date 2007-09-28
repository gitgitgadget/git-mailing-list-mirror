From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] quiltimport: Skip non-existent patches
Date: Fri, 28 Sep 2007 16:06:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0709281606430.11943@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0709271154440.10467@pademelon.sonytel.be>
 <1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-401454985-1190988415=:11943"
Cc: git@vger.kernel.org
To: Dan Nicholson <dbn.lists@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 16:07:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbGUj-000585-U8
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 16:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbXI1OG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 10:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXI1OG5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 10:06:57 -0400
Received: from vervifontaine.sonytel.be ([80.88.33.193]:42561 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751071AbXI1OG5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 10:06:57 -0400
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 68E8D58ABD;
	Fri, 28 Sep 2007 16:06:55 +0200 (MEST)
In-Reply-To: <1190925059-5233-1-git-send-email-dbn.lists@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59394>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-401454985-1190988415=:11943
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 27 Sep 2007, Dan Nicholson wrote:
> When quiltimport encounters a non-existent patch in the series file,
> just skip to the next patch. This matches the behavior of quilt.
> 
> Signed-off-by: Dan Nicholson <dbn.lists@gmail.com>

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

> ---
>  git-quiltimport.sh |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index 74a54d5..880c81d 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -71,6 +71,10 @@ commit=$(git rev-parse HEAD)
>  
>  mkdir $tmp_dir || exit 2
>  for patch_name in $(grep -v '^#' < "$QUILT_PATCHES/series" ); do
> +	if ! [ -f "$QUILT_PATCHES/$patch_name" ] ; then
> +		echo "$patch_name doesn't exist. Skipping."
> +		continue
> +	fi
>  	echo $patch_name
>  	git mailinfo "$tmp_msg" "$tmp_patch" \
>  		<"$QUILT_PATCHES/$patch_name" >"$tmp_info" || exit 3
> -- 
> 1.5.3.2

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-401454985-1190988415=:11943--
