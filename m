From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] Improvements to git-archive tests and
 add_submodule_odb()
Date: Tue, 3 Dec 2013 19:18:07 +0100
Message-ID: <20131203181807.GA4629@sandbox-ub>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
 <6D370472-81BB-4249-9ADA-1C906C26D88F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Nick Townsend <nick.townsend@mac.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnuY6-00043A-IS
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab3LCSSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 13:18:15 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:47233 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab3LCSSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:18:14 -0500
Received: from [77.20.33.19] (helo=sandbox-ub)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VnuXz-0000h5-LY; Tue, 03 Dec 2013 19:18:11 +0100
Content-Disposition: inline
In-Reply-To: <6D370472-81BB-4249-9ADA-1C906C26D88F@mac.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238706>

On Mon, Dec 02, 2013 at 04:14:37PM -0800, Nick Townsend wrote:
> diff --git a/submodule.c b/submodule.c
> index 1905d75..1ea46be 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -143,7 +143,7 @@ void stage_updated_gitmodules(void)
>  		die(_("staging updated .gitmodules failed"));
>  }
>  
> -static int add_submodule_odb(const char *path)
> +int add_submodule_odb(const char *path)

I am not against making add_submodule_odb() usable from outside
submodule.c but I would prefer if this change goes along with some code
actually using it. The reason being that when refactoring or extending
you immediately know that a function is file local only with the static
keyword. Without anyone using this function from outside submodule.c
this fact is still true and so the code should say, IMO.

Its not a big deal to postpone removing this keyword in a later commit
so I would like to drop this change from the patch. The documentation
fix is fine with me.

Cheers Heiko
