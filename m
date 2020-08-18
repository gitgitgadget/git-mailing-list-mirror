Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF61C433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54BFC20786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rk9TGuu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgHRWwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:52:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57635 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgHRWwN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 18:52:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80A2E68501;
        Tue, 18 Aug 2020 18:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zZ2hlATHwzNw
        c9sd9cTRwGJRubw=; b=Rk9TGuu1KmYmksjojL/rwp22R85/AC3X2459xYpYAT2o
        SLSRocHYQsU2wQr6UDazVy8h79oKNLAyAblyGaScIRglNEfyqyFc8JvgkB8yisSd
        9A6xuL5RYWq5LuT8GjrGMOx01in+NjctKZ4+r1v2Vym5X/JaajCHqygGVAGC9AY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ILkS6T
        PAO9pFaBNHZ/YG666l3iVfs5nTjjn5mnICmftSTt/E7izPS0Ae2abpydr+dTFdmV
        vBTo22NNC3dAEyXCenRTKHOLeQQBjU+NETDVSZvuVRa+zWtxlU9/wdEvtHp8CbJc
        8WY/JjRbvufW98epPNlK0h1PPrJcnUE1TA3Xc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 798DC68500;
        Tue, 18 Aug 2020 18:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0425F684FF;
        Tue, 18 Aug 2020 18:52:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Tilman Vogel <tilman.vogel@web.de>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] patch-id: ignore newline at end of file in diff_flush_patch_id()
References: <2639321.dTF8K4C05n@alien.lan>
        <b67eb51d-75e8-62c5-d1c4-fc3015e13fc6@web.de>
Date:   Tue, 18 Aug 2020 15:52:08 -0700
In-Reply-To: <b67eb51d-75e8-62c5-d1c4-fc3015e13fc6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 19 Aug 2020 00:08:54 +0200")
Message-ID: <xmqqblj7worr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7237C02C-E1A5-11EA-B99D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Whitespace is ignored when calculating patch IDs.  This is done by
> removing all whitespace from diff lines before hashing them, including
> a newline at the end of a file.  If that newline is missing, however,
> diff reports that fact in a separate line containing "\ No newline at
> end of file\n", and this marker is hashed like a context line.

Ah, ouch.

> This goes against our goal of making patch IDs independent of
> whitespace.  Use the same heuristic that 2485eab55cc (git-patch-id: do
> not trip over "no newline" markers, 2011-02-17) added to git patch-id
> instead and skip diff lines that start with a backslash and a space
> and are longer than twelve characters.

Good find of previous example.  Excellent.

> Reported-by: Tilman Vogel <tilman.vogel@web.de>
> Initial-test-by: Tilman Vogel <tilman.vogel@web.de>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  diff.c            |  2 ++
>  t/t3500-cherry.sh | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Thanks.

> diff --git a/diff.c b/diff.c
> index f9709de7b45..f175019eb7a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6044,6 +6044,8 @@ static void patch_id_consume(void *priv, char *li=
ne, unsigned long len)
>  	struct patch_id_t *data =3D priv;
>  	int new_len;
>
> +	if (len > 12 && starts_with(line, "\\ "))
> +		return;
>  	new_len =3D remove_space(line, len);
>
>  	the_hash_algo->update_fn(data->ctx, line, new_len);
> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
> index f038f34b7c0..2b8d9cb38ed 100755
> --- a/t/t3500-cherry.sh
> +++ b/t/t3500-cherry.sh
> @@ -55,4 +55,27 @@ test_expect_success \
>       expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* -=
 .*"
>  '
>
> +test_expect_success 'cherry ignores whitespace' '
> +	git switch --orphan=3Dupstream-with-space &&
> +	test_commit initial file &&
> +	>expect &&
> +	git switch --create=3Dfeature-without-space &&
> +
> +	# A spaceless file on the feature branch.  Expect a match upstream.
> +	printf space >file &&
> +	git add file &&
> +	git commit -m"file without space" &&
> +	git log --format=3D"- %H" -1 >>expect &&
> +
> +	# A further change.  Should not match upstream.
> +	test_commit change file &&
> +	git log --format=3D"+ %H" -1 >>expect &&
> +
> +	git switch upstream-with-space &&
> +	# Same as the spaceless file, just with spaces and on upstream.
> +	test_commit "file with space" file "s p a c e" file-with-space &&
> +	git cherry upstream-with-space feature-without-space >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.28.0
