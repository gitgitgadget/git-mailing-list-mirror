From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] t3000 (ls-files -o): modernize style
Date: Sun, 11 Jul 2010 01:33:33 -0700 (PDT)
Message-ID: <m3d3uul8pd.fsf@localhost.localdomain>
References: <20100711042025.GA7424@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 10:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXryt-0006nL-4t
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 10:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683Ab0GKIdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 04:33:42 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64541 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0GKIdl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 04:33:41 -0400
Received: by bwz1 with SMTP id 1so1849268bwz.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=xk+8kbmCoSHBg99klxV0fwpqJiWOistOn0pZIKPlddg=;
        b=bSgTwp01zNXCQxpXA8xZmkC8TPcSiS7NmSoBg+OF24xy5D33orIL0o7bGgJBmdtqEo
         M3EsCeR5FtV90fYDlXf2pu6X0ozLKolnCupDrZA5a4th2qjTPqHIa6FUBWjr1RzNnarD
         6XyQeB7EQOqXcE5GgVrdTlZU0HP8Mr7K8r9II=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fGq/zt1l1y+V74vDnTf9CJIBxZZpRZUTn5vp5qaDvPHszwUy+0FAE/lPZcMmFmzOdd
         pJFLQFNTPwz45ZEkGQzF+NcA+D8QFVhb48oNAr4ynYo78PhT/2GH0BtrOYfJIYozlm7K
         fJr0a8XmQEP0ad/lHunLHB1TjVKybBsX7CAHc=
Received: by 10.204.16.82 with SMTP id n18mr9463398bka.212.1278837214142;
        Sun, 11 Jul 2010 01:33:34 -0700 (PDT)
Received: from localhost.localdomain (abwj181.neoplus.adsl.tpnet.pl [83.8.233.181])
        by mx.google.com with ESMTPS id 24sm12556431bkr.19.2010.07.11.01.33.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 01:33:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6B8X1tK017003;
	Sun, 11 Jul 2010 10:33:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6B8Wkvw016993;
	Sun, 11 Jul 2010 10:32:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100711042025.GA7424@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150768>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This script is part of the second batch of tests, from the same day
> the test infrastructure was added to git.  Update it to use a more
> modern style in the spirit of v1.6.4-rc0~45^2~2 (2009-05-22).
> In particular:
> 
>  - Put setup code inside test assertions, to avoid unexpected
>    breakages and avoid stray output without -v (as t/README
>    recommends); and

O.K., but...
 
> -cat >expected1 <<EOF
> -expected1
> -expected2
> -expected3
> -output
> -path0
> -path1
> -path2-junk
> -path2/file2
> -EOF
> -sed -e 's|path2/file2|path2/|' <expected1 >expected2
> -cat <expected2 >expected3
> -echo path4/ >>expected2
> -
> +test_expect_success 'setup: expected output' '
> +	cat >expected1 <<-\EOF &&
> +	expected1
> +	expected2
> +	expected3
> +	output
> +	path0
> +	path1
> +	path2-junk
> +	path2/file2
> +	EOF
> +
> +	sed -e "s|path2/file2|path2/|" <expected1 >expected2 &&
> +	cp expected2 expected3 &&
> +	echo path4/ >>expected2
> +'

... I don't think it is really needed.  There isn't anything there
that can fail, and there isn't anything there that produces any
output.

BTW. do all sane shells that can be used to run test suite support
'<<-' here-doc redirection operators?  Is it in POSIX?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
