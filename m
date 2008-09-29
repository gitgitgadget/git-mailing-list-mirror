From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/6] gitweb: use_pathinfo filenames start with /
Date: Mon, 29 Sep 2008 03:08:08 +0200
Message-ID: <200809290308.09312.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com> <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 29 03:09:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk7GS-00085J-8q
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 03:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYI2BIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 21:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYI2BIR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 21:08:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:51401 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYI2BIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 21:08:16 -0400
Received: by nf-out-0910.google.com with SMTP id d3so582765nfc.21
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uKrDlt31JNx3cKrYMXmiw966hB16Hq6OoaNSoyfnCXo=;
        b=VnKzaoxgI8ORCfIgsiPZQzyMh9CuiPy43ftOwZalnuOybmFSDRkQcj5p1PmVwrnhM7
         UAgLUI2XT8vSofKoBHXVZ5L5yjvj4QZ0/tU2CZAWBIP1f/PhV5aDJttEv8OuqGA4/8Rv
         3ZVjEgNsOwNHq7M0bOG3JijXgEjADPI8jsHRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LNmHotZLN0w7+HizR3ekPHjVSb/tAmHCvGzNVUprfBnbRYsx/MmkiLbhg2AMpuuiFy
         gpe7CgrIQFhOawn0shZ5KJtfkPFNbuCxcANqCSZNDgo3wlXEn+v9p6/HE5snmR7jM2wi
         w4HDHX1YhqUirPBVUIoAbgKugsf/J0RcBViHQ=
Received: by 10.210.123.2 with SMTP id v2mr5451502ebc.21.1222650494830;
        Sun, 28 Sep 2008 18:08:14 -0700 (PDT)
Received: from ?192.168.1.11? (abvx193.neoplus.adsl.tpnet.pl [83.8.221.193])
        by mx.google.com with ESMTPS id y34sm2277172iky.2.2008.09.28.18.08.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Sep 2008 18:08:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96992>

On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:

> When using path info, make filenames start with a / (right after the :
> that separates them from the hash base). This minimal change allows
> relative navigation to work properly when viewing HTML files.

Good idea. Nitpick: instead of "using path info", perhaps "generating
path info URL"; this change is about gitweb link generation...

Did you check if gitweb strips leading '/' from filename?

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e783d12..18da484 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -664,7 +664,7 @@ sub href (%) {
>  		if (defined $params{'hash_base'}) {
>  			$href .= "/".esc_url($params{'hash_base'});
>  			if (defined $params{'file_name'}) {
> -				$href .= ":".esc_url($params{'file_name'});
> +				$href .= ":/".esc_url($params{'file_name'});
>  				delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
>  				delete $params{'file_name'};
>  			} else {
> -- 
> 1.5.6.5

Is there reason why this change is separate (not squashed) from
previous commit?

-- 
Jakub Narebski
Poland
