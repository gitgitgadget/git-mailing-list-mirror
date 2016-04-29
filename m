From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/15] submodule deinit: loose requirement for giving '.'
Date: Fri, 29 Apr 2016 11:27:42 -0700
Message-ID: <xmqqtwikxobl.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:27:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awD8o-0002s9-M8
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 20:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbcD2S1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 14:27:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbcD2S1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 14:27:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0B7717FBE;
	Fri, 29 Apr 2016 14:27:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W7LjzFG1YIRnGIIux429377Yqw0=; b=qIFnSh
	4ZkUHXUhPDjgob0brYTyuW0cwcMtioEPGmkDree6IQYZxTU3HWdfB5HHConDiiaa
	uppr4MQquRPKMHvxgTt0T3KeWhlVYDJu4ScubtlEqYmH6e650bKJiFuXgt7LFU7J
	tE8D3fRbtYEMN6ux3Mr5XjP+6w6vwskurIiys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=noEiu/mlwgpQeGptQ5zeoe0dw3pn/RFP
	HEMkyNoj+I/IwxyiKr0eYv7fQONQHgzYLVKhE3xScJfNi3cVFW4H0dZbhe+OPDKM
	I0r4CRGwffsrvnw8IIhFhc5B6athbxG2zRdUFxxgP6og4XJ9Y0/Tzb6Esh4ISZN+
	v/PofkHLj+g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B6C5A17FBD;
	Fri, 29 Apr 2016 14:27:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1786817FBB;
	Fri, 29 Apr 2016 14:27:44 -0400 (EDT)
In-Reply-To: <1461703833-10350-8-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 109D919C-0E38-11E6-9A70-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293041>

Stefan Beller <sbeller@google.com> writes:

> This is needed later to make a distinction between 'all specified'
> and the default group of submodules.

s/loose/lose/;

Again, this can be separated as an independent preliminary clean-up.


>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  git-submodule.sh           | 5 -----
>  t/t7400-submodule-basic.sh | 1 -
>  2 files changed, 6 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index d7a5e1a..253ad07 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -440,11 +440,6 @@ cmd_deinit()
>  		shift
>  	done
>  
> -	if test $# = 0
> -	then
> -		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
> -	fi
> -
>  	git submodule--helper list --prefix "$wt_prefix" "$@" |
>  	while read mode sha1 stage sm_path
>  	do
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index e9d1d58..ac477b2 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -932,7 +932,6 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
>  	git submodule update --init &&
>  	git config submodule.example.foo bar &&
>  	git config submodule.example2.frotz nitfol &&
> -	test_must_fail git submodule deinit &&
>  	git submodule deinit . >actual &&
>  	test -z "$(git config --get-regexp "submodule\.example\.")" &&
>  	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
