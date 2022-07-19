Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB9C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiGSQ0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiGSQ0o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 12:26:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3447C564EA
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 09:26:43 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C93BC196C16;
        Tue, 19 Jul 2022 12:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Q8Ho3BB4pTmObELz3tcMA9sR3zQWa/auvnpyz
        rp+Ho=; b=xowMHMvlbFwEMtK+Ejufz0xrEYp0MGopEW2MsT/jaSBXIZnYH0HBu9
        CWZrxZdoKylT75WRS1Mtj6L6HGoWvhbkNPeNXAjJzuol0/mEINoIlXqg7YyahhS6
        PdKtKnaSeEP8KmT6WHQqMYNUZAcSKqVUa9GPSaGaGwNHBAIzMNhug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C24B1196C14;
        Tue, 19 Jul 2022 12:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 573AE196C0C;
        Tue, 19 Jul 2022 12:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Celeste Liu <coelacanthus@outlook.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Raman Gupta <rocketraman@gmail.com>
Subject: Re: [PATCH v2] contrib/rerere-train: avoid useless gpg sign in
 training
References: <PH7PR14MB5594BE1B100435DCD28C1E45CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
Date:   Tue, 19 Jul 2022 09:26:38 -0700
In-Reply-To: <PH7PR14MB5594BE1B100435DCD28C1E45CE8F9@PH7PR14MB5594.namprd14.prod.outlook.com>
        (Celeste Liu's message of "Tue, 19 Jul 2022 21:03:58 +0800")
Message-ID: <xmqqzgh5ax1d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91068752-077F-11ED-875D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Celeste Liu <coelacanthus@outlook.com> writes:

> The rerere-train script now signs all temporary commits,
> which is unnecessary and useless.

Not for me ;-)  There must be something else that is forcing it to
behave that way.

> This commit turns off gpg signing.


>
> Signed-off-by: Celeste Liu <coelacanthus@outlook.com>
> ---
>
> v2: add problem detail in commit message.
>
>  contrib/rerere-train.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/rerere-train.sh b/contrib/rerere-train.sh
> index 26b724c8c6..bd01e430ef 100755
> --- a/contrib/rerere-train.sh
> +++ b/contrib/rerere-train.sh
> @@ -75,7 +75,7 @@ do
>  		continue
>  	fi
>  	git checkout -q "$parent1^0"
> -	if git merge $other_parents >/dev/null 2>&1
> +	if git merge --no-gpg-sign $other_parents >/dev/null 2>&1
>  	then
>  		# Cleanly merges
>  		continue
