From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 3/5] gitweb: use_pathinfo filenames start with /
Date: Sun, 19 Oct 2008 01:26:06 +0200
Message-ID: <200810190126.06697.jnareb@gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com> <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 01:27:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrLD8-0007BN-G5
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 01:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbYJRX0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 19:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbYJRX0a
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 19:26:30 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:6810 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbYJRX02 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 19:26:28 -0400
Received: by ey-out-2122.google.com with SMTP id 6so397901eyi.37
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=u8ES6fKxpEGDJVnKUYRFBIAsv0/mqWD9WHjxhjsYA0g=;
        b=wJZZUDH8UozmMiZgIEnPoDnfxJYDm5Iiza+Al10XtkMcYGDMMySxDVcxAp0XTm2lS+
         lAhg4lRSvHEaGFBCGgYintVfliP1rbqZX0e/A+ICjSadaru5/17+I2MBWWbV5mWPASW7
         T2VYGtriix1C9F+ae60mTTQwXy+RepRYpj2Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=poMOsFcTpO3z3sFI0B0TDOK3udkl9z4xPzr+TG8zj/6QKg+P2YNtTJntFffWVCSHHN
         rvn6rJwltXZcXPDqSs6XOtV8HFucF9wtW2o6S0tms3CaESAINcQ1bW4FRn6YtC0G0lGg
         NfgrxJ0vHMlBbinArQffpkfVubMhWFLY0VqXU=
Received: by 10.210.39.2 with SMTP id m2mr6543682ebm.191.1224372386158;
        Sat, 18 Oct 2008 16:26:26 -0700 (PDT)
Received: from ?192.168.1.11? (abwr242.neoplus.adsl.tpnet.pl [83.8.241.242])
        by mx.google.com with ESMTPS id 7sm7149891eyb.1.2008.10.18.16.26.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 16:26:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98582>

On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:

> When using path info, make filenames start with a / (right after the :
> that separates them from the hash base). This minimal change allows
> relative navigation to work properly when viewing HTML files in raw
> ('blob_plain') mode.

This means generating project/action/hash_base:/filename rather than
earlier project/action/hash_base:filename, isn't it?

For example for http://repo.or.cz/w/git.git/html:/git.html links leads
to correct HTML pages, while for http://repo.or.cz/w/git.git/html:git.html
they lead to empty gitweb page (no errors, so link checker would be
fooled).

> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 5337d40..49730f3 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -727,7 +727,7 @@ sub href (%) {
>  		# try to put as many parameters as possible in PATH_INFO:
>  		#   - project name
>  		#   - action
> -		#   - hash or hash_base:filename
> +		#   - hash or hash_base:/filename
>  
>  		# When the script is the root DirectoryIndex for the domain,
>  		# $href here would be something like http://gitweb.example.com/
> @@ -746,11 +746,11 @@ sub href (%) {
>  			delete $params{'action'};
>  		}
>  
> -		# Finally, we put either hash_base:file_name or hash
> +		# Finally, we put either hash_base:/file_name or hash
>  		if (defined $params{'hash_base'}) {
>  			$href .= "/".esc_url($params{'hash_base'});
>  			if (defined $params{'file_name'}) {
> -				$href .= ":".esc_url($params{'file_name'});
> +				$href .= ":/".esc_url($params{'file_name'});
>  				delete $params{'file_name'};
>  			}
>  			delete $params{'hash'};
> -- 
> 1.5.6.5
> 
> 

-- 
Jakub Narebski
Poland
