From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] Extend sample pre-commit hook to check for non ascii filenames
Date: Fri, 15 May 2009 16:57:45 +0200
Message-ID: <200905151657.47225.jnareb@gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 15 16:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4yrP-0003Vn-3u
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 16:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795AbZEOO5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761781AbZEOO5w
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 10:57:52 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:43075 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880AbZEOO5v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 10:57:51 -0400
Received: by ewy24 with SMTP id 24so2515527ewy.37
        for <git@vger.kernel.org>; Fri, 15 May 2009 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1CaGJ4UwOy4yWU7KzpF0374GAk1ZK9ZPAU6IgV04Hrg=;
        b=JN/GeiaqB58bNEXGJNT1zcKt9sEPHafNMZhLW/ZWx3AnRof4/FwsXcSBSoIRjJtFsS
         YBo+a74mUnPq1TPM9lkiMDmixCPjlVEacd9rdEHo7+rRA43JHpbe8+EUsz9Ayvt5bORv
         2/M8uDgLrqs5T1PzfqhREYE6J7QDI86PVcMk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=GuyZCTEqs1UyEVD/ypmBZisuNSiiMq1whX0cX9QJYRtsWx88FN/SJag2mKpsCbwVWm
         A4/N8W+OldkVZMwZmLZqADNkSlNMv1UISYwdhSFdOr4mQO2N7FTzJdAAQ2rmHnN5hPgc
         YMjZNENLXAtSBKKBxVt384J8Fc4cyINyrbmOw=
Received: by 10.216.0.84 with SMTP id 62mr1199618wea.185.1242399470210;
        Fri, 15 May 2009 07:57:50 -0700 (PDT)
Received: from ?192.168.1.13? (abwb23.neoplus.adsl.tpnet.pl [83.8.225.23])
        by mx.google.com with ESMTPS id t12sm2789613gvd.18.2009.05.15.07.57.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 07:57:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090514175850.GA26267@macbook.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119258>

<Insert standard Dscho disclaimer here...> ;-)

In short: good idea, don't be discouraged by criticism...

On Thu, 14 May 2009, Heiko Voigt wrote:

> At the moment non-ascii encodings of filenames are not portably converted
> between different filesystems by git. This will most likely change in the
> future but to allow repositories to be portable among different file/operating
> systems this check is enabled by default.

By the way, you might consider choosing shorter line length for commits,
something around 70-76 characters per line; otherwise it is harder to
reply to without linewrapping. 80 characters that you used is, IMHO,
absolute maximum, and it is good that you kept to it.

> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---

> +# If you want to allow non-ascii filenames set this variable to true.
> +allownonascii=$(git config hooks.allownonascii)
> +
> +function is_ascii () {
> +    test -z "$(cat | sed -e "s/[\ -~]*//g")"
> +    return $?
> +}

>From CodingGuidelines for shell scripts:
 - We do not write the noiseword "function" in front of shell
   functions.

(in short: do not use bash-specific features... unless, of course,
you are modifying bash-completion script).

Second, it would be nice to have comment about how to use this
function (as it does not check file given by its argument, but
rather its standard input). And perhaps also a comment that it
works because ASCII printable characters begin with ' ' space
(does it have to be escaped?) and end with '~' tilde[2].

Third, isn't it useless use of 'cat'[3]? And wouldn't it be better
to use 'tr' to either delete printable characters and check for
anything left (as you do; BTW. wouldn't "return test ..." be simpler?),
or use 'tr' to count non portable characters?

[1] http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html
[2] http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters
[3] http://partmaps.org/era/unix/award.html#cat

> +
> +if [ "$allownonascii" != "true" ]
> +then
> +	# until git can handle non-ascii filenames gracefully
> +	# prevent them to be added into the repository
> +	if ! git diff --cached --name-only --diff-filter=A -z \
> +			| tr "\0" "\n" | is_ascii; then
> +		echo "Non-ascii filenames are not allowed !"
> +		echo "Please rename the file ..."
> +		exit 1
> +	fi
> +fi
> +
>  if git-rev-parse --verify HEAD 2>/dev/null
>  then
>  	against=HEAD
> -- 
> 1.6.3
> 
> 
> 
> 

-- 
Jakub Narebski
Poland
