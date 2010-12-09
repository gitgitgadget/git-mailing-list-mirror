From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 08/18] gitweb: Change is_cacheable() to return true always
Date: Thu, 09 Dec 2010 15:46:06 -0800 (PST)
Message-ID: <m3tyim1pey.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
	<1291931844-28454-9-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 00:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQqBk-0001IL-Ky
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 00:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398Ab0LIXqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 18:46:09 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:52919 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab0LIXqI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 18:46:08 -0500
Received: by fxm18 with SMTP id 18so3103651fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 15:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=DEjIMzyMOISSyIYFHVioKedhXPcUzZvgPwg/QjxIDy0=;
        b=Nr0h5p3RgezLJRyxQuuR4dBRvlXjtcKM672Dziq8YGhl3Jua/qqLcFf8TUgkyo24Lp
         pHolImvidMIOzFH5Md6+8bYblTWULW64BURgr+DjWBTLYceXA/U5uAChth6HqQX90FLv
         lNVW6NQYtCwcJ4lqHG/zyNNKduGJJXV6M/MwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=EtP5Idm/8X+EOdJUxV3z6cyD315qGjGeOdTAD3teEMidMy5eoEdQQiP7wlsMCQxhFp
         RC7BpBF8au1WhpywXveBjdsUa+/XLtjABEcfvo5Mv9vsad4KbMG48G5p0kKln0ODg4Ln
         dYX6lGs2sFjKVzyztEWoNCsnGeBsqApuGxmRk=
Received: by 10.223.101.203 with SMTP id d11mr63632fao.91.1291938366756;
        Thu, 09 Dec 2010 15:46:06 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id n1sm734528fam.16.2010.12.09.15.46.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 15:46:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB9NjfPq019918;
	Fri, 10 Dec 2010 00:45:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB9NjP28019910;
	Fri, 10 Dec 2010 00:45:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-9-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163360>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> is_cacheable() was set to return false for blame or blame_incremental
> which both use unique urls so there's no reason this shouldn't pass
> through the caching engine.

I have disabled caching 'blame_incremental' (and its workhorse
'blame_data'), in slightly different way (by disabling these views
rather than making them un-cacheable), because last time when I was
chaing this it simply didn't work with caching.  Did you check that it
works?

Besides with caching (without "tee"-ing captre) 'blame_incremental'
view doesn't offer any advantage over 'blame' view, so it should be
IMHO disabled.
 
> Leaving the function in place for now should something actually arrise
> that we can't use caching for (think ajaxy kinda things likely).

Sidenote: I use it for 'cache' and for 'cache_clear' action in

  "[RFC PATCHv6 24/24] gitweb: Add beginnings of cache administration page (proof of concept)"
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163051
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/aa9fd77ff206eae8838fdde626d2afea563f9f75

> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> ---
>  gitweb/gitweb.perl |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 5eb0309..1d8bc74 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -798,7 +798,8 @@ our %actions = (
>  );
>  sub is_cacheable {
>  	my $action = shift;
> -	return !($action eq 'blame_data' || $action eq 'blame_incremental');
> +	# There are no known actions that do no involve a unique URL that shouldn't be cached.
> +	return 1;
>  }
>  
>  # finally, we have the hash of allowed extra_options for the commands that
> -- 
> 1.7.2.3
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
