From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] t/t5505-remote: remove dependency on $origin_url
Date: Fri, 21 Jun 2013 15:10:39 -0700
Message-ID: <7v61x7ktcw.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 00:10:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq9Xa-0007F8-T6
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 00:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423590Ab3FUWKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 18:10:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38040 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423527Ab3FUWKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 18:10:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10D952A68B;
	Fri, 21 Jun 2013 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJzq1njkc2vl94S8evCmHz3q0ew=; b=xrtBMN
	ag63xGbZK5SyNDB0Mxe/HxQtkW06leNtiQeKJgJZ7qQlsdw6NZhpenvK3JQIoB/0
	d/ynxCSAoVcBVISxnNLFP+IS1IIPuECZkxZpM4Abz1qlIQhM8zMI1RLKdhMwYvIT
	xSe3MW8JjljP+94U4nwazDnzFoRR+NaujMCdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BlCHP+H9EkQNFK0sNRE777HKCIajam7i
	oJ56tBUH+KzVIaRvJYcQ//uKuNmXa5c5vjQ8dL36+BPgi77xXnJAVs5Zn53P6Lrp
	D9HSbywEKY2JaKGGUgxCfdP+Ty61dpDn1bNAZ+RP1EU5CaCLxVxKjvhk+7wSdPfM
	LMZhRKs5NiE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03DA52A68A;
	Fri, 21 Jun 2013 22:10:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61AA72A689;
	Fri, 21 Jun 2013 22:10:41 +0000 (UTC)
In-Reply-To: <1371813160-4200-5-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 21 Jun 2013 16:42:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 694241F8-DABF-11E2-8B82-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228662>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> In the tests "migrate a remote from named file in
> $GIT_DIR/{remotes,branches}", we are only checking that a configuration
> is migrated successfully; it has no correspondence with whether or not
> those values do something sensible with other git
> operations (fetch/push).  Therefore, there is no need to determine
> $origin_url: just substitute it with the constant value "quux".

Is there a reason why "quux" is better than another randomly chosen
string "$(pwd)/one"?



>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t5505-remote.sh | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index dcb6c2f..fd0a81e 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -669,21 +669,20 @@ test_expect_success 'rename a remote with name prefix of other remote' '
>  '
>  
>  cat > remotes_origin << EOF
> -URL: $(pwd)/one
> +URL: quux
>  Push: refs/heads/master:refs/heads/upstream
>  Pull: refs/heads/master:refs/heads/origin
>  EOF
>  
>  test_expect_success 'migrate a remote from named file in $GIT_DIR/remotes' '
>  	git clone one five &&
> -	origin_url=$(pwd)/one &&
>  	(cd five &&
>  	 git remote remove origin &&
>  	 mkdir -p .git/remotes &&
>  	 cat ../remotes_origin > .git/remotes/origin &&
>  	 git remote rename origin origin &&
>  	 test_path_is_missing .git/remotes/origin &&
> -	 test "$(git config remote.origin.url)" = "$origin_url" &&
> +	 test "$(git config remote.origin.url)" = "quux" &&
>  	 test "$(git config remote.origin.push)" = "refs/heads/master:refs/heads/upstream" &&
>  	 test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin")
>  '
> @@ -694,10 +693,10 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
>  	(
>  		cd six &&
>  		git remote rm origin &&
> -		echo "$origin_url" > .git/branches/origin &&
> +		echo quux > .git/branches/origin &&
>  		git remote rename origin origin &&
>  		test_path_is_missing .git/branches/origin &&
> -		test "$(git config remote.origin.url)" = "$origin_url" &&
> +		test "$(git config remote.origin.url)" = "quux" &&
>  		test "$(git config remote.origin.fetch)" = "refs/heads/master:refs/heads/origin" &&
>  		test "$(git config remote.origin.push)" = "HEAD:refs/heads/master"
>  	)
