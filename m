From: Alexander Strasser <eclipse7@gmx.net>
Subject: Re: [PATCH 7/6?] t4012: use 'printf' instead of 'dd' to generate a
 binary file
Date: Fri, 13 Jul 2012 00:25:40 +0200
Message-ID: <20120712222540.GA2782@akuma>
References: <20120711221140.GA21303@akuma>
 <4FFE7913.3090500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 13 00:25:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpRpa-0004HR-SI
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 00:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161578Ab2GLWZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 18:25:49 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:43461 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752323Ab2GLWZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 18:25:48 -0400
Received: (qmail invoked by alias); 12 Jul 2012 22:25:45 -0000
Received: from p5DC37306.dip.t-dialin.net (EHLO gmx.net) [93.195.115.6]
  by mail.gmx.net (mp041) with SMTP; 13 Jul 2012 00:25:45 +0200
X-Authenticated: #8251126
X-Provags-ID: V01U2FsdGVkX18/9FkvnA4/vP9pKgy/XIg0blyafH1lzJiUBisl9j
	BJ/cEwzelYeAKP
Received: by gmx.net (sSMTP sendmail emulation); Fri, 13 Jul 2012 00:25:40 +0200
Content-Disposition: inline
In-Reply-To: <4FFE7913.3090500@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201387>

Hi, 

Johannes Sixt wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> For some reason, 'echo X | dd bs=1k seek=1' creates a file with 2050 bytes
> on Windows instead of the expected 1026 bytes, so that a test fails. Since
> the actual contents of the file are irrelevant as long as there is at
> least one zero byte so that the diff machinery recognizes it as binary,
> use printf to generate it.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  While the focus is on t4012, maybe you can add this patch to the series.

  Your patch looks good to me and works here. If I hear no
objections I will include it as number 7 when resending this
series.

  Alexander

>  t/t4012-diff-binary.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
> index 6cebb39..8c018ab 100755
> --- a/t/t4012-diff-binary.sh
> +++ b/t/t4012-diff-binary.sh
> @@ -125,7 +125,7 @@ cat >expect <<EOF
>  EOF
>  
>  test_expect_success 'diff --stat with binary files and big change count' '
> -	echo X | dd of=binfile bs=1k seek=1 &&
> +	printf "\01\00%1024d" 1 >binfile &&
>  	git add binfile &&
>  	i=0 &&
>  	while test $i -lt 10000; do
> -- 
> 1.7.11.1.1304.g11834c6
