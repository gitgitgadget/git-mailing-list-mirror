From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 15/21] git p4 test: disable chmod test for cygwin
Date: Fri, 28 Sep 2012 21:33:36 +0200
Message-ID: <5065FB90.2070602@kdbg.org>
References: <1348833865-6093-1-git-send-email-pw@padd.com> <1348833865-6093-16-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THgJx-0007EC-4b
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031084Ab2I1Tdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:33:44 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:57026 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030602Ab2I1Tdm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:33:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9538A130052;
	Fri, 28 Sep 2012 21:33:38 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B76C519F374;
	Fri, 28 Sep 2012 21:33:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <1348833865-6093-16-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206603>

Am 28.09.2012 14:04, schrieb Pete Wyckoff:
> It does not notice chmod +x or -x; there is nothing
> for this test to do.
> 
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  t/t9815-git-p4-submit-fail.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t9815-git-p4-submit-fail.sh b/t/t9815-git-p4-submit-fail.sh
> index d2b7b3d..2db1bf1 100755
> --- a/t/t9815-git-p4-submit-fail.sh
> +++ b/t/t9815-git-p4-submit-fail.sh
> @@ -400,7 +400,9 @@ test_expect_success 'cleanup rename after submit cancel' '
>  	)
>  '
>  
> -test_expect_success 'cleanup chmod after submit cancel' '
> +# chmods are not recognized in cygwin; git has nothing
> +# to commit
> +test_expect_success NOT_CYGWIN 'cleanup chmod after submit cancel' '
>  	test_when_finished cleanup_git &&
>  	git p4 clone --dest="$git" //depot &&
>  	(
> 

In the git part, you could use test_chmod to change the executable bit.
But if you cannot test it in the p4 part later on, it is probably not
worth it.

-- Hannes
