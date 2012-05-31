From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] Test environment of git-remote-mw
Date: Thu, 31 May 2012 09:17:37 +0200
Message-ID: <vpqzk8oq0oe.fsf@bauges.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
	<1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
	<1338397492-13360-2-git-send-email-simon.cathebras@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, charles.roussel@ensimag.imag.fr,
	Guillaume.Sasdy@ensimag.imag.fr, Julien.Khayat@ensimag.imag.fr,
	Simon.Perrat@ensimag.imag.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 31 09:17:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZzdr-0005mg-Ko
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 09:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab2EaHRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 03:17:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60058 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab2EaHRl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 03:17:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4V79IuV027987
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 31 May 2012 09:09:18 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SZzda-0003Do-CO; Thu, 31 May 2012 09:17:38 +0200
In-Reply-To: <1338397492-13360-2-git-send-email-simon.cathebras@ensimag.imag.fr>
	(Simon Cathebras's message of "Wed, 30 May 2012 19:04:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 31 May 2012 09:09:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4V79IuV027987
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339052959.34336@w3acc5e2qLQeftE7W+Y3HQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198868>

Simon Cathebras <simon.cathebras@ensimag.imag.fr> writes:

> index 2deead7..8698625 100755
> --- a/t/test-gitmw-lib.sh
> +++ b/t/test-gitmw-lib.sh
> @@ -1,27 +1,136 @@
> +# Copyright (C) 2012
> +#     Charles Roussel <charles.roussel@ensimag.imag.fr>
> +#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
> +#     Julien Khayat <julien.khayat@ensimag.imag.fr>
> +#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
> +#     Simon Perrat <simon.perrat@ensimag.imag.fr>
> +#     Matthieu Moy <matthieu.moy@imag.fr>
> +# License: GPL v2 or later
> +

Why is this added by [PATCH 2/3]?

> -# You might want to change those ones ...
> +# You might want to change these ones
>  #
>  WIKI_DIR_NAME="wiki"            # Name of the wiki's directory
>  WIKI_DIR_INST="/var/www"        # Directory of the web server
>  TMP="/tmp"                      # Temporary directory for downloads
> -                                # Absolute address needed!
> +                                # Absolute path required!
>  SERVER_ADDR="localhost"         # Web server's address
>  
> -#
>  # CONFIGURATION
> -# You should not change those ones unless you know what you to
> +# You should not change these ones unless you know what you do

These fixups should have been squashed into the previous one. Bad use of
"git rebase -i"?

> +	../test-gitmw.pl "get_page" -p "$1" "$2"

Useless quotes around "get_page".

(but useful ones around $1 and $2 ;-))

> +	result=$(diff -r -B -w --exclude=".git" "$1" "$2")

Doesn't seem to be in POSIX:

http://pubs.opengroup.org/onlinepubs/009695399/utilities/diff.html

Will this run on all platforms?

> +# wiki_page_content <file_name> <page_name> 
> +#
> +# Compares the contents of the file <file_name> and the wiki page
> +# <page_name> and exits with error 1 if they do not match.

If it does a comparison, why isn't it named "check_content", or
"diff_content"?

> +# Usage:
> +#       ./test-gitmw.pl <function> [argument]*

I'd say s/function/command/

> +my $wiki_url="http://localhost/wiki/api.php";
> +my $wiki_admin='WikiAdmin';
> +my $wiki_admin_pass='AdminPass';

It would be nice to allow overriding these from the command-line. But as
you are now writting tests, you may as well apply the YAGNI
principle ;-).

> +        # Replace spaces by underscore in the page name

Indent with space.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
