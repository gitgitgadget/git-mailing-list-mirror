From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Gitweb: Avoid warnings when a repo does not have a valid
 HEAD
Date: Wed, 14 Dec 2011 02:53:37 -0600
Message-ID: <20111214085337.GA19424@elie.hsd1.il.comcast.net>
References: <1323815706-10560-1-git-send-email-jratt0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 09:53:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rakb0-0007Ca-VR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 09:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943Ab1LNIxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 03:53:47 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40594 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab1LNIxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 03:53:46 -0500
Received: by qadc12 with SMTP id c12so3914052qad.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 00:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/vwDB96wCAexa6144/k1lnN+TGiO1Zrno5NvF7uh1Ro=;
        b=Pv2R/Mgh6MR3Z8C9dU8ZmwJkefgISYrdlDH4+6wfEONLq36L+PAAE05EvTFCsGXB8o
         YgdUseeQ2hHzpkY8P9S1grCChob0s29FAA+mkJfxA0/agQa+rwO2Jj2nzoN4Ad0STV1a
         dL6yo2buy85pfjB/7TnmCDR2pXeNZbREMWXG8=
Received: by 10.224.195.10 with SMTP id ea10mr7969965qab.16.1323852825691;
        Wed, 14 Dec 2011 00:53:45 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dj9sm4318165qab.18.2011.12.14.00.53.44
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 00:53:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323815706-10560-1-git-send-email-jratt0@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187103>

(just cc-ing Jakub)
Joe Ratterman wrote:

> It is possible that the HEAD reference does not point to an existing
> branch.  When viewing such a repository in gitweb, a message like this
> one was sent to the error log:
>
>   gitweb.cgi: Use of uninitialized value in string eq at /usr/src/git/gitweb/gitweb.cgi line 5115.
>
> Signed-off-by: Joe Ratterman <jratt0@gmail.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..5af06d6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5440,7 +5440,7 @@ sub git_heads_body {
>  	for (my $i = $from; $i <= $to; $i++) {
>  		my $entry = $headlist->[$i];
>  		my %ref = %$entry;
> -		my $curr = $ref{'id'} eq $head;
> +		my $curr = $head ? ($ref{'id'} eq $head) : 0;
>  		if ($alternate) {
>  			print "<tr class=\"dark\">\n";
>  		} else {
> -- 
> 1.7.7.1
> 
> 
