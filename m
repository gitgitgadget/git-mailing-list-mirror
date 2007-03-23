From: Elias Pipping <pipping@macports.org>
Subject: [SOLVED] Testsuite fails (t4118) with sed != gnu sed (was: [PATCH] t4118: be nice to non-GNU sed)
Date: Fri, 23 Mar 2007 01:42:06 +0100
Message-ID: <AC2E511A-04FB-4F18-93E3-8D81C6E379FF@macports.org>
References: <Pine.LNX.4.63.0703230117200.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 02:04:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUYCG-0003SA-59
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 02:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934261AbXCWBD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 21:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934260AbXCWBD4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 21:03:56 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:56539 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934261AbXCWBDz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 21:03:55 -0400
X-Greylist: delayed 1305 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Mar 2007 21:03:55 EDT
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.66)
          with esmtp
          (envelope-from <pipping@macports.org>)
          id <1HUXr7-0003PG-JF>; Fri, 23 Mar 2007 01:42:09 +0100
Received: from p54bfcace.dip.t-dialin.net ([84.191.202.206] helo=[192.168.1.33])
          by inpost2.zedat.fu-berlin.de (Exim 4.66)
          with esmtpsa
          (envelope-from <pipping@macports.org>)
          id <1HUXr7-00028b-C0>; Fri, 23 Mar 2007 01:42:09 +0100
X-Mailer: Apple Mail (2.752.2)
X-Originating-IP: 84.191.202.206
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42893>

Hi,

I'm on a mac, hence /usr/bin/sed is not gnu sed, which makes t4118 fail.

This patch by Johannes Schindelin (Johannes.Schindelin@gmx.de) solves  
the issue for me, though.


Regards,

Elias Pipping


Begin forwarded message:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date: March 23, 2007 1:17:35 AM GMT+01:00
> To: pipping@macports.org
> Subject: [PATCH] t4118: be nice to non-GNU sed
>
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> ---
>
>  t/t4118-apply-empty-context.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/t/t4118-apply-empty-context.sh b/t/t4118-apply-empty- 
> context.sh
> index 690a182..27cc6f2 100755
> --- a/t/t4118-apply-empty-context.sh
> +++ b/t/t4118-apply-empty-context.sh
> @@ -23,7 +23,8 @@ test_expect_success setup '
>  	cat file2 >file2.orig
>  	git add file1 file2 &&
>  	sed -e "/^B/d" <file1.orig >file1 &&
> -	sed -e "/^B/d" <file2.orig >file2 &&
> +	sed -e "/^[BQ]/d" <file2.orig >file2 &&
> +	echo Q | tr -d "\\012" >>file2 &&
>  	cat file1 >file1.mods &&
>  	cat file2 >file2.mods &&
>  	git diff |
