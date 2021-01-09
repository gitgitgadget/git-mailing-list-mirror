Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87485C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F52F2396F
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 23:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbhAIXTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 18:19:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51027 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbhAIXTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 18:19:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29FED11469F;
        Sat,  9 Jan 2021 18:18:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oO3gTdTF+Bq6ks90lfaS9yKPQQE=; b=eg8TY+
        /QzMkwrL99RECPfGSgSb8wv/+D0bUL3ehi+O4lhaDTRA+n01dPUbhE64HA3BKxOI
        mqeVJPz6KLKn0X72HOealdDLyPay/PWhXzBSVT+iKZnZURsLfGTL48YCypSPY79R
        5ogAVJSBQxdF6O7RIM/eYYRML4uEqv4drjlhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NVWUiBEwBTHyA6NvfFRUeFABvLDEZldq
        vdAZSJLlyppmORVyVAxj1gzn/aNh4Kb2VeB8A4qHUzXYbrfQU7avulhn+cAMg6PX
        ddcTwxmovlhIlsocdogTYCCeFToNQV84p2uXwdtW7z9l/Qr5NJ1t1c9z+3Yip6nf
        TiyEPStGpyU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2261811469E;
        Sat,  9 Jan 2021 18:18:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 81CDF11469A;
        Sat,  9 Jan 2021 18:18:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] fixup! mergetool: add automerge configuration
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net>
        <20210109224236.50363-1-davvid@gmail.com>
Date:   Sat, 09 Jan 2021 15:18:43 -0800
In-Reply-To: <20210109224236.50363-1-davvid@gmail.com> (David Aguilar's
        message of "Sat, 9 Jan 2021 14:42:36 -0800")
Message-ID: <xmqqbldxem24.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 054C7230-52D1-11EB-B329-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> "\r\?" in sed is not portable to macOS and possibly others.
> "\r" is not valid on Linux with POSIXLY_CORRECT.
>
> Replace "\r" with a substituted variable that contains "\r".
> Replace "\?" with "\{0,1\}".
>
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This is based on top of fc/mergetool-automerge and can be squashed in
> (with the addition of my sign-off) if desired.
>
> Changes since last time:
> - printf '\r' instead of printf '\x0d'
> - The commit message now mentions POSIXLY_CORRECT.
>
>  git-mergetool.sh | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index a44afd3822..9029a79431 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -243,9 +243,16 @@ auto_merge () {
>  	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
>  	if test -s "$DIFF3"
>  	then
> -		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
> -		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> -		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
> +		cr=$(printf '\r')
> +		sed -e '/^<<<<<<< /,/^||||||| /d' \
> +			-e "/^=======$cr\{0,1\}$/,/^>>>>>>> /d" \
> +			"$DIFF3" >"$BASE"
> +		sed -e '/^||||||| /,/^>>>>>>> /d' \
> +			-e '/^<<<<<<< /d' \
> +			"$DIFF3" >"$LOCAL"
> +		sed -e "/^<<<<<<< /,/^=======$cr\{0,1\}$/d" \
> +			-e '/^>>>>>>> /d' \
> +			"$DIFF3" >"$REMOTE"
>  	fi
>  	rm -- "$DIFF3"
>  }

I was hoping that we can avoid repetition that can cause bugs with
something like

diff --git i/git-mergetool.sh w/git-mergetool.sh
index a44afd3822..e07dabbf72 100755
--- i/git-mergetool.sh
+++ w/git-mergetool.sh
@@ -243,9 +243,13 @@ auto_merge () {
 	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
 	if test -s "$DIFF3"
 	then
-		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
-		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
-		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
+		C0="^<<<<<<< "
+		C1="^||||||| "
+		C2="^=======$(printf '\015')*\$"
+		C3="^>>>>>>> "
+		sed -e "/$C0/,/$C1/d" -e "/$C2/,/$C3/d" "$DIFF3" >"$BASE"
+		sed -e "/$C1/,/$C3/d" -e "/$C0/d" "$DIFF3" >"$LOCAL"
+		sed -e "/$C0/,/$C2/d" -e "/$C3 /d" "$DIFF3" >"$REMOTE"
 	fi
 	rm -- "$DIFF3"
 }
