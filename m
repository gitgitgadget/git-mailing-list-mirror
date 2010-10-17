From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t0003: properly quote $HOME
Date: Sun, 17 Oct 2010 23:03:58 +0200
Message-ID: <201010172303.58780.j6t@kdbg.org>
References: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 17 23:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7aOq-0001SU-Q8
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 23:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938Ab0JQVED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 17:04:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:62977 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932862Ab0JQVEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 17:04:02 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AF70D2C4003;
	Sun, 17 Oct 2010 23:03:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 06F1E19F823;
	Sun, 17 Oct 2010 23:03:59 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <decc39532e1706c50964bad14c51d0bcd9ab09a6.1287342744.git.trast@student.ethz.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159219>

On Sonntag, 17. Oktober 2010, Thomas Rast wrote:
> 6df42ab (Add global and system-wide gitattributes, 2010-09-01) forgot
> to quote one instance of $HOME in the tests.  This broke the test for
> me with the shell complaining about an ambiguous redirect (but only
> when run with --root for some reason).
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>  t/t0003-attributes.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index 25205ac..e75153b 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -38,7 +38,7 @@ test_expect_success 'setup' '
>  	) >a/b/.gitattributes
>  	(
>  		echo "global test=global"
> -	) >$HOME/global-gitattributes
> +	) >"$HOME"/global-gitattributes
>
>  '

FWIW, the failure is due to bash trying to be helpful. Variable expansions 
after redirections are not word-split, but bash incorrectly detects 
an "ambiguous redirect" if the expanded text contains IFS characters. Your 
fix is of course the right way to work it around. But you might update the 
commit message.

-- Hannes
