From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Sat, 15 Mar 2014 09:59:52 +0100
Message-ID: <53241688.2050604@kdbg.org>
References: <20140314235735.GA6959@ibr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Uwe Storbeck <uwe@ibr.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 10:00:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOkS0-0005Qm-WB
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 10:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbaCOJAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 05:00:10 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:42195 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752773AbaCOJAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 05:00:08 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 61DF1CE88C
	for <git@vger.kernel.org>; Sat, 15 Mar 2014 10:00:06 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B15A9A7EB4;
	Sat, 15 Mar 2014 09:59:53 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id F315E19F38C;
	Sat, 15 Mar 2014 09:59:52 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140314235735.GA6959@ibr.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244150>

Am 15.03.2014 00:57, schrieb Uwe Storbeck:
> when variables may contain backslash sequences.
> 
> Backslash sequences are interpreted as control characters
> by the echo command of some shells (e.g. dash).
> 
> Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
> ---
>  t/test-lib.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1531c24..8209204 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -277,7 +277,7 @@ error "Test script did not set test_description."
>  
>  if test "$help" = "t"
>  then
> -	echo "$test_description"
> +	printf '%s\n' "$test_description"
>  	exit 0
>  fi
>  
> @@ -328,7 +328,7 @@ test_failure_ () {
>  	test_failure=$(($test_failure + 1))
>  	say_color error "not ok $test_count - $1"
>  	shift
> -	echo "$@" | sed -e 's/^/#	/'
> +	printf '%s\n' "$@" | sed -e 's/^/#	/'

This should be

	printf '%s\n' "$*" | sed -e 's/^/#	/'

>  	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
>  }
>  
> 
