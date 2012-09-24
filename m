From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: configure submodule.<name>.path on add and
 init
Date: Mon, 24 Sep 2012 21:57:49 +0200
Message-ID: <5060BB3D.9010609@web.de>
References: <1348515040-19986-1-git-send-email-orgads@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 21:58:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGEn9-0004EX-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 21:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099Ab2IXT5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 15:57:52 -0400
Received: from mout.web.de ([212.227.17.12]:49504 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083Ab2IXT5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 15:57:50 -0400
Received: from [192.168.178.41] ([91.3.184.50]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0MaajJ-1T1Am41VFp-00JqXQ; Mon, 24 Sep 2012 21:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <1348515040-19986-1-git-send-email-orgads@gmail.com>
X-Provags-ID: V02:K0:dq/vOUmea+w73LBaaSLvwOoMlfRdJjPa8D8z07NMPCB
 HTKC1pt/+KSZ3OHCx0ZcT1RpoiCYfwVumRWmCCvoAnyEDHydoP
 MdKQGEct3sK8od5Fs5IQ1viSYuMYdCwAwyB8E0XKOOoZr8B30O
 bjHNI99q+gQ+EsSL3NPj44DcfgjZPMgYkhcs+es3mWsrLU1at4
 /ZZapz8hIyk9uivJzlyDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206322>

Am 24.09.2012 21:30, schrieb Orgad Shaneh:
> In order to read diff options for a submodule, its path must be configured
> ---
>  git-submodule.sh |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 3e2045e..f97bb62 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -359,6 +359,7 @@ Use -f if you really want to add it." >&2
>  			esac
>  		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>  	fi
> +	git config submodule."$sm_path".path "$sm_path"
>  	git config submodule."$sm_path".url "$realrepo"
>  
>  	git add $force "$sm_path" ||
> @@ -476,6 +477,7 @@ cmd_init()
>  				url=$(resolve_relative_url "$url") || exit
>  				;;
>  			esac
> +			git config submodule."$name".path "$name" ||
>  			git config submodule."$name".url "$url" ||
>  			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"

Nack. The path must only be configured in .gitmodules or we'll
never be able to rename the submodule directory.
