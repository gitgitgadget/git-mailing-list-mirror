From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 06:24:44 +0100
Message-ID: <5465921C.7000904@web.de>
References: <1415916087-18953-1-git-send-email-blume.mike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Mike Blume <blume.mike@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 06:25:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp9O8-000254-0a
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 06:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbaKNFZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 00:25:36 -0500
Received: from mout.web.de ([212.227.15.14]:49509 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbaKNFZf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 00:25:35 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LrpKY-1XzZnm2BO2-013cuP; Fri, 14 Nov 2014 06:25:32
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1415916087-18953-1-git-send-email-blume.mike@gmail.com>
X-Provags-ID: V03:K0:Uao+cTtoZjRTKzgtmpKRtaEF8lgvvmu4PZ2I3mokysIql1anNj8
 TI1vs3Yr9l5qrXL8thlHRojZFrzWGNxce0ksiowitWl8ohsSLWVSKH1Sgzfh67XG3MCx7Kx
 8LUbpd0K4jTjp/xn68/DwPmy4YX6oNKaPjOeJUfsiuFDMa6cSapVTvISKTWs2k170hbxMiA
 XqLgFloDCCD0+Cae+aJpg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2014 11:01 PM, Mike Blume wrote:
> listed bug doesn't reproduce on Mac OS Yosemite. For now, just enable
> TTY on Yosemite and higher
>
> Signed-off-by: Mike Blume <blume.mike@gmail.com>
> ---
>   t/lib-terminal.sh | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index 5184549..1311ce0 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -29,7 +29,10 @@ test_lazy_prereq TTY '
>   	# After 2000 iterations or so it hangs.
>   	# https://rt.cpan.org/Ticket/Display.html?id=65692
>   	#
> -	test "$(uname -s)" != Darwin &&
> +	# Under Mac OS X 10.10.1 and Perl 5.18.2, this problem
> +	# appears to be gone.
> +	#
> +	[[ test "$(uname -s)" != Darwin || test "$(uname -r | cut -d. -f1") -ge 14 ]] &&
This seems to be bash syntax (the "[[" can (and should) be easily avoided)

Another question:
Is this related to perl or Mac OS ?
The commit message is indicating that the combination of Mac OS 10.10.1 
and perl 5.18.2
is working, but the code does not reflect this.
Does it make sense to test for the perl version in the code?
Or is it OK to mention

  Under Mac OS X 10.10.1 which ships with Perl 5.18.2, this problem....



>   
>   	perl "$TEST_DIRECTORY"/test-terminal.perl \
>   		sh -c "test -t 1 && test -t 2"
