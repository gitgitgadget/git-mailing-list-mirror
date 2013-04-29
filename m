From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] test output: respect $TEST_OUTPUT_DIRECTORY
Date: Mon, 29 Apr 2013 20:00:27 +0200
Message-ID: <87fvy9dxok.fsf@hexa.v.cablecom.net>
References: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
	<7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
	<47c9ba4200a22e865040208628357d9bc4bcf3f4.1367002553.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWsNf-0002uq-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454Ab3D2SAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:00:50 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:17616 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758183Ab3D2SAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:00:30 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 29 Apr
 2013 20:00:27 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 29 Apr
 2013 20:00:27 +0200
In-Reply-To: <47c9ba4200a22e865040208628357d9bc4bcf3f4.1367002553.git.john@keeping.me.uk>
	(John Keeping's message of "Fri, 26 Apr 2013 19:55:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222830>

John Keeping <john@keeping.me.uk> writes:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ca6bdef..70ad085 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -54,8 +54,8 @@ done,*)
>  	# do not redirect again
>  	;;
>  *' --tee '*|*' --va'*)
> -	mkdir -p test-results
> -	BASE=test-results/$(basename "$0" .sh)
> +	mkdir -p "$(TEST_OUTPUT_DIRECTORY)/test-results"
> +	BASE="$(TEST_OUTPUT_DIRECTORY)/test-results/$(basename "$0" .sh)"
>  	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
>  	 echo $? > $BASE.exit) | tee $BASE.out
>  	test "$(cat $BASE.exit)" = 0

Hmm, I initially was too lazy to review this change, and now it's biting
me.  The above is Makefile-quoted, which to the shell reads like a
command substitution.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
