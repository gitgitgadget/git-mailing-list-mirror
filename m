From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 4/4] Add explicit Cygwin check to guard WIN32 header
 inclusion
Date: Mon, 09 Nov 2009 19:26:19 +0000
Message-ID: <4AF86CDB.6030200@ramsay1.demon.co.uk>
References: <4AF5D6F8.40608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:35:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7a1O-0008LR-MN
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 20:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108AbZKITfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 14:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbZKITfB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 14:35:01 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:35040 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112AbZKITfA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 14:35:00 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1N7a13-0006Hc-nA; Mon, 09 Nov 2009 19:35:05 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AF5D6F8.40608@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132511>

Ramsay Jones wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index ef60803..c4b9e5a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -65,10 +65,10 @@
>  #define _NETBSD_SOURCE 1
>  #define _SGI_SOURCE 1
>  
> -#ifdef WIN32 /* Both MinGW and MSVC */
> -#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> -#include <winsock2.h>
> -#include <windows.h>
> +#if defined(_WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
> +# define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
> +# include <winsock2.h>
> +# include <windows.h>

Arrgghhh.

Sorry, Junio, I meant to change this before sending it out. :(

I had intended to remove the added indentation (which I don't even remember
doing!), since it obscures the "real change", which simply consists of the
new expression in the #if preprocessor line.

I'll send a new version of this patch.

ATB,
Ramsay Jones
