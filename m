From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] Added test from David Glasser.
Date: Thu, 09 Sep 2010 23:33:30 +0200
Message-ID: <vpqk4muvbyt.fsf@bauges.imag.fr>
References: <1284056514-4935-1-git-send-email-davi.reis@gmail.com>
	<1284056514-4935-2-git-send-email-davi.reis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: davi.reis@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 09 23:33:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otokk-0001At-6d
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 23:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0IIVdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 17:33:36 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33049 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756066Ab0IIVdf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 17:33:35 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o89LLBH3031614
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 9 Sep 2010 23:21:11 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OtokN-0000RF-0y; Thu, 09 Sep 2010 23:33:31 +0200
In-Reply-To: <1284056514-4935-2-git-send-email-davi.reis@gmail.com> (davi reis's message of "Thu\,  9 Sep 2010 11\:21\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 09 Sep 2010 23:21:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o89LLBH3031614
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1284672073.6869@3oNC7zwpXnD8HwAl/pLHWg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155905>

davi.reis@gmail.com writes:

> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -52,7 +52,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
>  		speclen = strlen(spec);
>  		if (speclen <= len)
>  			continue;
> -		if (spec[len] != 0 && spec[len] != '/')
> +		if (spec[len] != '/')

This change is not the one advertized for in the title. If you didn't
mean it, then

  git send-email --annotate

can be your friend, it gives you a last opportunity to check your
patch before it is sent.

If you did mean it, then it should be justified in the commit message.

> --- a/t/t3100-ls-tree-restrict.sh
> +++ b/t/t3100-ls-tree-restrict.sh
> @@ -165,4 +165,13 @@ test_expect_success \
>  EOF
>       test_output'
>  
> +test_expect_success \
> +    'ls-tree with one path a prefix of the other' \
> +    'git ls-tree $tree path2/baz path2/bazbo >current &&
> +     make_expected <<\EOF &&
> +040000 tree X  path2/baz
> +120000 blob X  path2/bazbo
> +EOF
> +     test_output'
> +
>  test_done

Adding the test can help people to understand what the first patch is
fixing, hence, I'd suggest either squashing both patches, or putting
the test patch first (with a test_expect_failure), and having the
second turn the test_expect_failure into a test_expect_success (hence,
it's obvious reading the patch that it fixes the test).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
