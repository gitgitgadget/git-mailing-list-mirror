From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Mon, 17 Sep 2012 13:53:54 -0700
Message-ID: <7v7grstlp9.fsf@alter.siamese.dyndns.org>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
 <1347901579-5545-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:54:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDiKa-0004cX-Hp
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab2IQUx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:53:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924Ab2IQUx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:53:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B67AA86FF;
	Mon, 17 Sep 2012 16:53:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a8XkWh9dZt03bnLoZLWZoRkZujw=; b=QtHcmV
	zipxOmrIBsef57BwazHkyiHk2cXbk1jHzhlW31Eo8YokaQ8+IqZvi6dPsBAaTHMc
	1w8K56bW0jdH+nDzx7sOEJpapsmFLeajB1/U2Qu6Bs8BVMzctd5F3EGaUWFAs85O
	alBO41z9lqVjpz5weo3GWqRvS0IUOmu4axEkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rtb+H2WqNnWFP7FISKNLzPpD0Of5SiU7
	kFb9hHxWLHr2O8ClWpcfn19rMgZza+sVZapnDLuJfKrr2mxbSJ4shn0sAGT2B6qP
	MrweqHOPZ9I2kqGq9pwuCkEYYMiyNJUp8/B7sY2OaQHz10WZ8kA9rIsVERyoifvi
	MuCo9vXGkyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4C2D86FE;
	Mon, 17 Sep 2012 16:53:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 087BF86FD; Mon, 17 Sep 2012
 16:53:55 -0400 (EDT)
In-Reply-To: <1347901579-5545-2-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Mon, 17 Sep 2012 22:36:19 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBD22A12-0109-11E2-8B2C-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205746>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> When tests were run without building git, the following error message
> was displayed:
>
>     .: 54: Can't open /path/to/git/source/t/../GIT-BUILD-OPTIONS
>
> Change this to display a more user-friendly error message:
>
>      error: you do not seem to have built git yet.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t0000-basic.sh |   10 ----------
>  t/test-lib.sh    |    6 ++++++
>  2 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index ae6a3f0..08677df 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -18,16 +18,6 @@ swapping compression and hashing order, the person who is making the
>  modification *should* take notice and update the test vectors here.
>  '
>  
> -################################################################
> -# It appears that people try to run tests without building...
> -
> -../git >/dev/null
> -if test $? != 1
> -then
> -	echo >&2 'You do not seem to have built git yet.'
> -	exit 1
> -fi
> -
>  . ./test-lib.sh
>  
>  ################################################################
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f8e3733..c00452a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -51,6 +51,12 @@ then
>  fi
>  GIT_BUILD_DIR="$TEST_DIRECTORY"/..
>  
> +if ! test -r "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> +then
> +	echo 'error: you do not seem to have built git yet.' >&2
> +	exit 1
> +fi
> +

Is this a sufficient replacement for what you removed from 0000?
Can the BUILD-OPTIONS file exist when your build of git failed?

>  . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>  export PERL_PATH SHELL_PATH
