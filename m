Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF6F1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbcHISaH (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:30:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932270AbcHISaG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 14:30:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B016934D1B;
	Tue,  9 Aug 2016 14:30:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=i/raWdQhjCeH
	yzm/NO6b3zqpaW4=; b=XGWeml9WQ5DPO90B3jp/LJfF6OI4lVoVkaN0U1liC5HR
	f/bWP99zq1y8AkLmu/BlxnIGVNhfEJ2v9nS0Vj7wLr+Kbbx7RknPF7RWBrnd+wu/
	K4mIMHNdxHsvfFgHrrtZWYvfzbzyd2wuzIiPZcHAVzGKm7npyubr9VxWCpixiyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BjZsxx
	ZgLS3Z5tEYeJFUdn3mTJgwbJR97VQHU/9z0Ut0wiNwy4PuONINhN2X428MT3txV5
	LQPGt3393F+etb9cQUK45ngHHtBQVOywr3/kmSfrAvKnJiYOE9hacNPtxpYQh7F/
	iVQieazFe7Iee0eTZsR3gcCjIRpcIW0kQSsQg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7A7534D1A;
	Tue,  9 Aug 2016 14:30:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1A4434D16;
	Tue,  9 Aug 2016 14:30:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:	git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCH v2] completion: complete --delete, --move, and --remotes for git branch
References: <1120818262.376555.1465290963431.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<1470735284-5686-1-git-send-email-ville.skytta@iki.fi>
Date:	Tue, 09 Aug 2016 11:30:00 -0700
In-Reply-To: <1470735284-5686-1-git-send-email-ville.skytta@iki.fi> ("Ville
	=?utf-8?Q?Skytt=C3=A4=22's?= message of "Tue, 9 Aug 2016 12:34:44 +0300")
Message-ID: <xmqqh9ataj87.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4A929088-5E5F-11E6-AC9F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ville Skyttä <ville.skytta@iki.fi> writes:

> Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 6a187bc..76abbd1 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1008,8 +1008,8 @@ _git_branch ()
>  	while [ $c -lt $cword ]; do
>  		i="${words[c]}"
>  		case "$i" in
> -		-d|-m)	only_local_ref="y" ;;
> -		-r)	has_r="y" ;;
> +		-d|--delete|-m|--move)	only_local_ref="y" ;;
> +		-r|--remotes)		has_r="y" ;;
>  		esac
>  		((c++))
>  	done

Sounds sensible; we already had "-d" but not its fully-spelled
variant, and you are adding it (together with its friends).

Will queue.

> @@ -1023,7 +1023,7 @@ _git_branch ()
>  			--color --no-color --verbose --abbrev= --no-abbrev
>  			--track --no-track --contains --merged --no-merged
>  			--set-upstream-to= --edit-description --list
> -			--unset-upstream
> +			--unset-upstream --delete --move --remotes
>  			"
>  		;;
>  	*)
