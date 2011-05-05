From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1507: change quoting in test_did_you_mean to a more
 general one
Date: Thu, 05 May 2011 13:02:16 -0700
Message-ID: <7vsjss6hmf.fsf@alter.siamese.dyndns.org>
References: <20110505191027.GA3242@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Thu May 05 22:02:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI4kn-0005Xn-Iu
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab1EEUCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 16:02:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1EEUCY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:02:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B3624B87;
	Thu,  5 May 2011 16:04:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jyV5j7JgRUXD0/eOCf94NRzAbr0=; b=kZcqA7
	ZfcvQzUMjOe0IihAZ0O+v/PqbLUOq2D9RG0D+NgagD9VEU9KnYgtYiol/hLflWNO
	jkXmv4B2wClJJPGqIlPqdTtEwhbxNZzK/yNRQLDsi0ow8ZJ/TPChm+j9KvcwYftx
	6DhKj43adsmX2GeeyVmEVB+SFzWnd3SZdx1Qw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=atBC01f6W7HjGp7E+rILWcuW1CC7OPeQ
	r/s3w3kGnhYwz7NhNRZMuW9pjbCw8RhVZrbUniqvQfgZrPmrA2lI+xgj5HCSR51U
	W0CUzFXJIGgT26PBRS9RMYe/87Jsj9nUFOb/M9PoINgdO+wnQEAUWRKVxmf1EtsR
	oH4mgmekD/U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DC8364B7B;
	Thu,  5 May 2011 16:04:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DDFAE4B7A; Thu,  5 May 2011
 16:04:21 -0400 (EDT)
In-Reply-To: <20110505191027.GA3242@camk.edu.pl> (Kacper Kornet's message of
 "Thu, 5 May 2011 21:10:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DFE04EE0-7752-11E0-A066-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172899>

Kacper Kornet <draenog@pld-linux.org> writes:

> In bash and some other shells the script:
>
>   x=2; unset a; echo "${a:-'$x'}"
>
> prints '2'. However ksh shell prints $x. The quoting is added to
> reproduce bash behaviour.

What I happen to have in /usr/bin/ksh

    $ /usr/bin/ksh --version
      version         sh (AT&T Research) 93t+ 2009-05-01

does not seem to have this issue.

Whose ksh is this?  It is broken.

POSIX "2.6.2 Parameter Expansion" [*1*] says in ${parameter<op>word},
"word shall be subjected to tilde expansion, parameter expansion, command
substitution, and arithmetic expansion", when "a value of word is needed"
based on the state of parameter.

I am not opposed to the change, but because it is not "change to more
general one" but "work around a bug in <this implementation of ksh>", and
I would like to know what to fill in the blank when I rewrite the proposed
commit log message.

> Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> ---
>  t/t1506-rev-parse-diagnosis.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> index 4a6396f..bad09f9 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -8,8 +8,8 @@ exec </dev/null
>  
>  test_did_you_mean ()
>  {
> -	printf "fatal: Path '$2$3' $4, but not ${5:-'$3'}.\n" >expected &&
> -	printf "Did you mean '$1:$2$3'${2:+ aka '$1:./$3'}?\n" >>expected &&
> +	printf "fatal: Path '$2$3' $4, but not ${5:-\'$3\'}.\n" >expected &&
> +	printf "Did you mean '$1:$2$3'${2:+ aka \'$1:./$3\'}?\n" >>expected &&
>  	test_cmp expected error
>  }
>  
> -- 
> 1.7.5

[Reference]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02
