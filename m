From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] archive.c: format_subst - fixed bogus argument to memchr
Date: Wed, 23 Apr 2008 17:54:37 +0200
Message-ID: <480F5BBD.8090101@lsrfire.ath.cx>
References: <87od81peog.fsf@sneeze.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ariel Badichi <abadichi@bezeqint.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 17:55:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JohJr-000550-Nh
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 17:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbYDWPyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 11:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755519AbYDWPyp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 11:54:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:35122 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755419AbYDWPyo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 11:54:44 -0400
Received: from [10.0.1.200] (p57B7DBF0.dip.t-dialin.net [87.183.219.240])
	by india601.server4you.de (Postfix) with ESMTPSA id C84802F804E;
	Wed, 23 Apr 2008 17:54:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <87od81peog.fsf@sneeze.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80225>

Ariel Badichi schrieb:
> Also removed a superfluous test.
> 
> Signed-off-by: Ariel Badichi <abadichi@bezeqint.net>
> ---
>  archive.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/archive.c b/archive.c
> index fb159fe..7a32c19 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -16,9 +16,9 @@ static void format_subst(const struct commit *commit,
>  		const char *b, *c;
>  
>  		b = memmem(src, len, "$Format:", 8);
> -		if (!b || src + len < b + 9)
> +		if (!b)
>  			break;

OK.

> -		c = memchr(b + 8, '$', len - 8);
> +		c = memchr(b + 8, '$', (src + len) - b - 8);
>  		if (!c)
>  			break;

Ouch.  Perhaps rearranging it to "len - (b - src) - 8" would make it a
little easier to read?  Anyway, thanks and:

Acked-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
