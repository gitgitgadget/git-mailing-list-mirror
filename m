From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 05/21] t6030: generalize test to not rely on current
 implementation
Date: Sun, 10 Apr 2016 15:47:27 +0200
Message-ID: <570A596F.9080200@web.de>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
 <1460294354-7031-6-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 15:47:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apFiW-0002QB-L4
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 15:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbcDJNrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 09:47:51 -0400
Received: from mout.web.de ([212.227.15.14]:61268 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753026AbcDJNru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 09:47:50 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MJTHn-1amlo33Lz9-0033u0; Sun, 10 Apr 2016 15:47:28
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.7.0
In-Reply-To: <1460294354-7031-6-git-send-email-s-beyer@gmx.net>
X-Provags-ID: V03:K0:SE+1rTbaRw56olzfZ8EqCK8v/M+zyYyPSMNa2SZUuqFYXXDOw1M
 XpINJuHRrc6zbKCzP4cTWzP0Yob1BEWDzzCbAKOq34WkzPlEh0UnkAAWt42bvgKzW8W3ygV
 1sTJJLCQU8u9zd3m1c/EylGwx3Rlldq/1u/HSGbqq3E1UH59x+IR+JE48ws6i0K2XKEQIhM
 C3C/a5j4oWLEqoe9NQr+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hyOuAMMKRvw=:8q8P4xclVCoOtcnOrxs9Dd
 o5ngLnYkLONZWYT7ZL3ON7WSqWiP9jeztnATSUgcFCIEbN/0mJ2DGSWqLAXj6Jd9SnRI3U4TC
 ZfUNbKC5VZY64k2oujpb1+3gY8E5PzZc0o8X1WnS4K4nBCH77k12gl+JvRfCWe1XVRdXIqJL2
 kGYGyswtJMh8l41P+ujOShBQOMeMPID5h3EGRfr/MiAkz0pbtbLBxYKDBZEKNj/4ujQGR9TPv
 I34nx1NvsBsS/L+QSdW1prD1WSg6HbbQWWi368+YVOYs7x4SDrCet9kGV0LMaX29dRbNQUF3l
 QfbpPqQyRYc+0P6x6J08EPRb1r+kZFL/7cuClKwzxClfcP6DhwxzXwWc+HJn+NasXh92LWrxs
 K23nVNqzdAoul+oGJtqii34PCaCwnNOOJhcfb0Lxub6XdHKkiiAIyoqQhOSgwAXEQ6PdWTmyY
 8XE889Bkjo4SBzjbLMN30MIls/DmfZIulukOUNGddVlCQf7R0NwclC7/rGHRx5E1JDNMyq+pw
 Kg0suPQbGvD/yj9ayxKTtlC+qCjjK2aIfimMuGxJG0x4qIq9tEmcyqX5NGlthxgVu8sG1GjNB
 uPheupxnCUUBT0ZVZM82Ej7WzR1H98exTLY42xgG66Y99oKmkpEr65nSBRN01nC1QQct1vJo1
 9FBIqWp1bXBLeVgXRG9GERBgAz6QApC/GK1o6VLkErrM9pZAICa3vskEsGrQB1ZKsj3F5mlL7
 nUTQQ79t3P90PCLXmRS1FAk6M4336+IJL7le24pdfrZEqRTe75l3Iy7WUm3G8ViGhVEIeYIk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291169>

On 10.04.16 15:18, Stephan Beyer wrote:
Some nit-comments inline

> ---
>  t/t6030-bisect-porcelain.sh | 167 ++++++++++++++++++++++----------------------
>  1 file changed, 85 insertions(+), 82 deletions(-)
> 
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 05bc639..645ccd9 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -10,36 +10,34 @@ exec </dev/null
> +	if [ -f "$_file" ]; then
I know that the old code did the same, is there a chance
to adopt to the git-style:
	if test -f "$_file" ; then
> +		echo "$_line" >> $_file || return $?

[]
> +test_expect_success '"git bisect run" simple case' '
> +	echo "#"\!"/bin/sh" > test_script.sh &&
> +	echo "grep Another hello > /dev/null" >> test_script.sh &&
> +	echo "test \$? -ne 0" >> test_script.sh &&
> +	chmod +x test_script.sh &&
> +	git bisect start &&
> +	git bisect good $HASH1 &&
> +	git bisect bad $HASH4 &&
> +	git bisect run ./test_script.sh > my_bisect_log.txt &&
> +	grep "$HASH3 is the first bad commit" my_bisect_log.txt &&
> +	git bisect reset
> +'
Portabily:
Since yesterday/yesterweek the usage of hard-coded
#!/bin/sh had shown to be problematic
Junio posted an update like this:
-	printf "#!/bin/sh\n" >diff &&
-	printf "printf \"\$GIT_PREFIX\"" >>diff &&
-	chmod +x diff &&
+	write_script diff <<-\EOF &&
+	printf "%s" "$GIT_PREFIX"
+	EOF

(Same for the scripts below)

>
> +test_expect_success '"git bisect run" with more complex "git bisect start"' '
> +	echo "#"\!"/bin/sh" > test_script.sh &&
> +	echo "grep Ciao hello > /dev/null" >> test_script.sh &&
> +	echo "test \$? -ne 0" >> test_script.sh &&
Style nit, please no ' ' after ">>":
echo "test \$? -ne 0" >>test_script.sh &&

(and more below)
