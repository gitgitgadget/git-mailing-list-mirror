Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4A8720179
	for <e@80x24.org>; Fri, 17 Jun 2016 17:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbcFQRKL (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:10:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753487AbcFQRKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 13:10:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53C8024ADC;
	Fri, 17 Jun 2016 13:10:08 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wQwy0VOG+AvRr+Ly1VbjO/8nglU=; b=T8tjnp
	JT7WhCQhNzKoSrwUx8myJbC63dvbmDyJgOa8zdiYcWqRdUmap+VksEUwSn1dDYZs
	D5kG7FFcjT1+rEF8eiyLsK2CC800CuUbQ5n3iByGvTaFKUBAtgnhyUA9oHcKosiq
	6iy+jn7XYhzQc2S1qgi9stZjRhjgZNN+9iFT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pNrah+NRtX+mlCS0Km5if26vWMgR3iaG
	z0c9Wg6B6WsQTLTK5Weu+veQLvAuN95HuBbx6FPPmzB3AEpYl5R5RvzN0xD5o96U
	1O7wjPSXOkFyVZuFGUGaouEFmLElQknOX2R7rQfKF670wRmw1s2rAb/OzCpp8W84
	FH57dldwCjU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B1B524ADB;
	Fri, 17 Jun 2016 13:10:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C891824AD6;
	Fri, 17 Jun 2016 13:10:07 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ed Maste <emaste@freebsd.org>
Cc:	git@vger.kernel.org, mackyle@gmail.com
Subject: Re: [PATCH] rebase: update comment about FreeBSD /bin/sh
References: <1466177609-33185-1-git-send-email-emaste@freebsd.org>
Date:	Fri, 17 Jun 2016 10:10:05 -0700
In-Reply-To: <1466177609-33185-1-git-send-email-emaste@freebsd.org> (Ed
	Maste's message of "Fri, 17 Jun 2016 11:33:29 -0400")
Message-ID: <xmqqoa6z213m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57801C00-34AE-11E6-AE36-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ed Maste <emaste@freebsd.org> writes:

> Commit 9f50d32 introduced a fix for FreeBSD /bin/sh misbehaviour
> when dot-sourcing a file containing "return" statements outside of
> any function, from a function in another shell script. That issue
> affects FreeBSD 9.x, and is not present in the /bin/sh in FreeBSD
> 10.3 and later. Update the comment to clarify this.
>
> The example from 9f50d32's commit message produces the expected output
> on FreeBSD 10.3 and -CURRENT (the upcoming 11.0):
>
> % sh script1.sh
> only this line should show
> %
>
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> ---
>  git-rebase--am.sh          | 4 ++--
>  git-rebase--interactive.sh | 4 ++--
>  git-rebase--merge.sh       | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Nice.

It's only two years since 9f50d32b (rebase: avoid non-function use
of "return" on FreeBSD, 2014-04-11) so we still need the warning,
but eventually 9.x will die out and we can stop worrying about this
one.

Thanks, will queue.

> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 9ae898b..3752393 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -9,8 +9,8 @@
>  # below were not inside any function, and expected to return
>  # to the function that dot-sourced us.
>  #
> -# However, FreeBSD /bin/sh misbehaves on such a construct and
> -# continues to run the statements that follow such a "return".
> +# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
> +# construct and continue to run the statements that follow such a "return".
>  # As a work-around, we introduce an extra layer of a function
>  # here, and immediately call it after defining it.
>  git_rebase__am () {
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 6e96abc..05f22e4 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1038,8 +1038,8 @@ check_todo_list () {
>  # below were not inside any function, and expected to return
>  # to the function that dot-sourced us.
>  #
> -# However, FreeBSD /bin/sh misbehaves on such a construct and
> -# continues to run the statements that follow such a "return".
> +# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
> +# construct and continue to run the statements that follow such a "return".
>  # As a work-around, we introduce an extra layer of a function
>  # here, and immediately call it after defining it.
>  git_rebase__interactive () {
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index 8d43db9..06a4723 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -107,8 +107,8 @@ finish_rb_merge () {
>  # below were not inside any function, and expected to return
>  # to the function that dot-sourced us.
>  #
> -# However, FreeBSD /bin/sh misbehaves on such a construct and
> -# continues to run the statements that follow such a "return".
> +# However, older (9.x) versions of FreeBSD /bin/sh misbehave on such a
> +# construct and continue to run the statements that follow such a "return".
>  # As a work-around, we introduce an extra layer of a function
>  # here, and immediately call it after defining it.
>  git_rebase__merge () {
