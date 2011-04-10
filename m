From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] supply '-n' to gzip to produce identical tarballs
Date: Sun, 10 Apr 2011 00:38:32 -0700 (PDT)
Message-ID: <m362qm4kvu.fsf@localhost.localdomain>
References: <1302415936-7362-1-git-send-email-frase@frase.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fraser Tweedale <frase@frase.id.au>
X-From: git-owner@vger.kernel.org Sun Apr 10 09:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8pEP-0005Qz-VD
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 09:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab1DJHif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 03:38:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64113 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab1DJHie (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 03:38:34 -0400
Received: by fxm17 with SMTP id 17so3026906fxm.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 00:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=iyUjBowGewJDwkHTeK0Qd2Tnc++5j1Ss7KNCVVSkESc=;
        b=dE1kO3CvQnRZM0HaiX4txATq3Wqli7q4dnWtt/KElw6aPY9Fte5HRQVS5+v6NCqkJL
         xRvtZg+3+sM4NWqmBqS9r9C3R65Tv5J71GW/d9I3FeOcNQWF+H9be8RPBskOj1OxJHub
         JZTPdEnlNbRhP1evncbUqoaQglVkZkNm05AEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=W/UfvzIwpfOQWOD/zE1lCOOOs0mdfmPnGeAeKBjmaerlPFXX3FzESmINysptFIfboU
         0J3VYeLAHUlQzKLkEOx8vVJZBUj67Oylq0s07gmWQ692+m2U0JNXUExE3U+cEakMYLa8
         G6nBF19XLKmDZufndNkT3ZicM0ELKSY3G2LPc=
Received: by 10.223.7.73 with SMTP id c9mr2921733fac.117.1302421113765;
        Sun, 10 Apr 2011 00:38:33 -0700 (PDT)
Received: from localhost.localdomain (abwa66.neoplus.adsl.tpnet.pl [83.8.224.66])
        by mx.google.com with ESMTPS id k5sm1274869faa.39.2011.04.10.00.38.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 00:38:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3A7bw9C023662;
	Sun, 10 Apr 2011 09:38:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3A7bgeC023655;
	Sun, 10 Apr 2011 09:37:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1302415936-7362-1-git-send-email-frase@frase.id.au>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171241>

Fraser Tweedale <frase@frase.id.au> writes:

> Subject: [PATCH] supply '-n' to gzip to produce identical tarballs
>
> Without the '-n' ('--no-name') argument, gzip includes timestamp in
> output which results in different files.  Important systems like FreeBSD
> ports and perhaps many others hash/checksum downloaded files to ensure
> integrity.  For projects that do not release official archives, gitweb's
> snapshot feature would be an excellent stand-in but for the fact that the
> files it produces are not identical.
> 
> Supply '-n' to gzip to exclude timestamp from output and produce idential
> output every time.
> 
> Signed-off-by: Fraser Tweedale <frase@frase.id.au>

Very good description, except subject line should denote which
subsystem this commit affects, i.e.:

  gitweb: supply '-n' to gzip to produce identical tarballs

Hmmm... gzip in gitweb's 'snapshot' action gets data compressed from
standard input, not from filesystem.  Isn't -n / --no-name no-op then?
Just asking...

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 46186ab..2ab08da 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -186,7 +186,7 @@ our %known_snapshot_formats = (
>  		'type' => 'application/x-gzip',
>  		'suffix' => '.tar.gz',
>  		'format' => 'tar',
> -		'compressor' => ['gzip']},
> +		'compressor' => ['gzip', '-n']},

Perhaps it would be more clear to use

  +		'compressor' => ['gzip', '--no-name']},

>  
>  	'tbz2' => {
>  		'display' => 'tar.bz2',
> -- 
> 1.7.4.3
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
