From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 1/2] submodule: fix confusing variable name
Date: Mon, 19 Aug 2013 23:09:37 +0200
Message-ID: <52128991.8080603@web.de>
References: <1376760343-741047-1-git-send-email-sandals@crustytoothpaste.net> <1376760343-741047-2-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Aug 19 23:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBWi5-0005tf-3I
	for gcvg-git-2@plane.gmane.org; Mon, 19 Aug 2013 23:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab3HSVJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Aug 2013 17:09:41 -0400
Received: from mout.web.de ([212.227.17.12]:63143 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082Ab3HSVJk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Aug 2013 17:09:40 -0400
Received: from [192.168.178.41] ([91.3.132.244]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MfqC4-1VPur84Bwy-00N7J1 for <git@vger.kernel.org>;
 Mon, 19 Aug 2013 23:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1376760343-741047-2-git-send-email-sandals@crustytoothpaste.net>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:dDPo3Qt8yQmldGHQkFX8pRkq82MzU+ZpI5IXLSDTWyqwnDDh9KU
 i137SVvl6plZPlPjQWp/wIZmVe/I9syEZd+f9Pnu3MsD7DiNHNZ8mRtoBzco9EhChDqyUhL
 UhYHDlG5ovUT2cajExRPov4RkDzuQlz02EXb0gVPqugM4HExuo8ZA6zwlqvz7igY9KSNHDN
 G15SzB9B+xFzGqSQpA/Mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232567>

Am 17.08.2013 19:25, schrieb brian m. carlson:
> cmd_summary reads the output of git diff, but reads in the submodule path into a
> variable called name.  Since this variable does not contain the name of the
> submodule, but the path, rename it to be clearer what data it actually holds.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Thanks, this one is looking good to me.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>

> ---
>  git-submodule.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 2979197..38520db 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -1032,13 +1032,13 @@ cmd_summary() {
>  	# Get modified modules cared by user
>  	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
>  		sane_egrep '^:([0-7]* )?160000' |
> -		while read mod_src mod_dst sha1_src sha1_dst status name
> +		while read mod_src mod_dst sha1_src sha1_dst status sm_path
>  		do
>  			# Always show modules deleted or type-changed (blob<->module)
> -			test $status = D -o $status = T && echo "$name" && continue
> +			test $status = D -o $status = T && echo "$sm_path" && continue
>  			# Also show added or modified modules which are checked out
> -			GIT_DIR="$name/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
> -			echo "$name"
> +			GIT_DIR="$sm_path/.git" git-rev-parse --git-dir >/dev/null 2>&1 &&
> +			echo "$sm_path"
>  		done
>  	)
>  
> 
