From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] bisect: remove unnecessary redirection
Date: Sat, 30 Aug 2014 22:57:05 +0200
Message-ID: <54023AA1.40709@kdbg.org>
References: <1409427029-65886-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:57:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNpi0-0000lK-Da
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 22:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbaH3U5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 16:57:12 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:22228 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752039AbaH3U5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 16:57:11 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B445910012;
	Sat, 30 Aug 2014 22:57:06 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8682319F497;
	Sat, 30 Aug 2014 22:57:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <1409427029-65886-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256265>

Am 30.08.2014 21:30, schrieb David Aguilar:
> `git rev-parse` is being called with --quiet so there's no need to
> redirect to /dev/null.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  git-bisect.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 1e0d602..c1c2321 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -365,7 +365,7 @@ bisect_reset() {
>  	}
>  	case "$#" in
>  	0) branch=$(cat "$GIT_DIR/BISECT_START") ;;
> -	1) git rev-parse --quiet --verify "$1^{commit}" >/dev/null || {
> +	1) git rev-parse --quiet --verify "$1^{commit}" || {

This is wrong. The redirection quells stdout, but --quiet is about stderr.

>  			invalid="$1"
>  			die "$(eval_gettext "'\$invalid' is not a valid commit")"
>  		}
> 

-- Hannes
