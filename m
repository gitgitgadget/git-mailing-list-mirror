From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 01/12] gitweb: introduce remote_heads feature
Date: Sun, 26 Sep 2010 19:24:05 +0200
Message-ID: <201009261924.06237.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 19:24:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozuxi-0005oB-MY
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 19:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab0IZRYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 13:24:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33765 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab0IZRYR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 13:24:17 -0400
Received: by bwz11 with SMTP id 11so2861668bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 10:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Bfhfw5V1EWKHx5STCNJNkrG+yOCxGXDGh1MEeGWnMIQ=;
        b=ZnVtywO4g0JrrHGFjxkiGGrP0fg/iEbezUn3s02BLC5OOpd9QrTt/9skzmhzuk/06n
         uqEd8V9x3CH6ZlhZK/PYBagGMM8aR3Ibfp+cC1fCkC1dfx4CZbW/LQZGwLddEieqsYCP
         ZVTTNiJACGMR8iXNQienv9fIADn1C4wjNQO+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=x7GgG+LqGfz+lcyHO9j4CgkNMEyaWJvoYGqkJPtDOI2RUrzoXndNe/PYrNvSLrRpeJ
         9zZM+sfBQo8x/8UM4sDmHOBHVfeFdKiVX6rTg9O8TyrHegKXzIaiAQsOmqwMH6Wo8nej
         Yqpegq3MYf237Hn2JOGeE6zN9E71jneT0rzfA=
Received: by 10.204.115.2 with SMTP id g2mr4521952bkq.19.1285521855819;
        Sun, 26 Sep 2010 10:24:15 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id 24sm3560740bkr.7.2010.09.26.10.24.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 10:24:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157240>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> With this feature enabled, remotes are retrieved (and displayed)
> when getting (and displaying) the heads list. Typical usage would be for
> local repository browsing, e.g. by using git-instaweb (or even a more
> permanent gitweb setup), to check the repository status and the relation
> between tracking branches and the originating remotes.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Nice and straighforward.  For what it is worth:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |   18 ++++++++++++++++--
>  1 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a85e2f6..f09fcee 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -486,6 +486,18 @@ our %feature = (
>  		'sub' => sub { feature_bool('highlight', @_) },
>  		'override' => 0,
>  		'default' => [0]},
> +
> +	# Make gitweb show remotes too in the heads list

Very minor nitpick: it should probably be (but I am not a native
English speaker, so I migh be mistaken)

  +	# Make gitweb show also remotes in the heads list

> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'remote_heads'}{'default'} = [1];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'remote_heads'}{'override'} = 1;
> +	# and in project config gitweb.remote_heads = 0|1;
> +	'remote_heads' => {
> +		'sub' => sub { feature_bool('remote_heads', @_) },
> +		'override' => 0,
> +		'default' => [0]},
[...]

-- 
Jakub Narebski
Poland
