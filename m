From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 2/4] t4011: illustrate "diff-index -p" on stat-dirty paths
Date: Thu, 01 Mar 2012 11:05:49 +0100
Message-ID: <4F4F49FD.3090504@in.waw.pl>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com> <1330568057-27304-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:06:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S32tq-0001eW-I5
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 11:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758423Ab2CAKF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 05:05:59 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55356 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030285Ab2CAKF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 05:05:58 -0500
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S32tY-0001Tm-Ge; Thu, 01 Mar 2012 11:05:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <1330568057-27304-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191912>

On 03/01/2012 03:14 AM, Junio C Hamano wrote:
> -test_expect_success SYMLINKS 'diff unchanged symlink'  '
> +test_expect_success SYMLINKS 'diff unchanged symlink and file'  '
>   	tree=$(git write-tree)&&
> -	git update-index frotz&&
> +	git update-index frotz nitfol&&
>   	test -z "$(git diff-index --name-only $tree)"
>   '
Hi,
why modify and extend an existing test instead of adding a new separate 
one? I think the test-suite should be getting more unittest-y, ie. 
checking minimal aspects of functionality, not less.

Zbyszek

> -test_expect_success SYMLINKS 'diff removed symlink' '
> +test_expect_success SYMLINKS 'diff removed symlink and file' '
>   	cat>expected<<-\EOF&&
>   	diff --git a/frotz b/frotz
>   	deleted file mode 120000
> @@ -44,22 +52,39 @@ test_expect_success SYMLINKS 'diff removed symlink' '
>   	@@ -1 +0,0 @@
>   	-xyzzy
>   	\ No newline at end of file
> +	diff --git a/nitfol b/nitfol
> +	deleted file mode 100644
> +	index 7c465af..0000000
> +	--- a/nitfol
> +	+++ /dev/null
> +	@@ -1 +0,0 @@
> +	-xyzzy
>   	EOF
>   	mv frotz frotz2&&
> +	mv nitfol nitfol2&&
>   	git diff-index -M -p $tree>current&&
>   	compare_diff_patch expected current
>   '
