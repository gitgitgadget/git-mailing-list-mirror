Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DF3C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 03:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676AE64ECF
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 03:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhBYDSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:18:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55793 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBYDSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 22:18:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A558511ABBF;
        Wed, 24 Feb 2021 22:17:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZEL7VgFLayw9
        6ydWwqlT57Q5mIs=; b=gIOWwIhi8KCLFTqfAXOPCQXn7duHTi5komnZq+RCxZCl
        2G/R0uWaWkShNaCETw3WVNtgLtJSQ2ip8EemSKVHfebSYj4ypAfJrTHjroAF3zYm
        1YAw66AURpaxPmHlqh06jSVK4H1PEw6TsjLSByemeiM1YHvu2fkUr8HvqzuXz6Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kEX0+X
        D0lEPJm895t968UPzoyo8J5jgQlKQIBGZvAIh0cBsQgLpqPPywCMfUA3bqL1mwO1
        qGxffjINeXz7kBGJ9qmhWDBjxKyH/ZEFFliGDHkvw0Q0ndvIXTAi8wOcQ6bptnk7
        jf8v+PLcA/tYabrM9LxHpJ2yNNf7DTJCMEXJE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E42611ABBE;
        Wed, 24 Feb 2021 22:17:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA42511ABBD;
        Wed, 24 Feb 2021 22:17:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] remote: write camel-cased *.pushRemote on rename
References: <20210225012117.17331-1-avarab@gmail.com>
        <20210225012117.17331-2-avarab@gmail.com>
Date:   Wed, 24 Feb 2021 19:17:49 -0800
In-Reply-To: <20210225012117.17331-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 25 Feb 2021 02:21:17 +0100")
Message-ID: <xmqqsg5kx2ci.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0AD70B1E-7718-11EB-BB47-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When a remote is renamed don't change the canonical "*.pushRemote"
> form to "*.pushremote". Fixes and tests for a minor bug in
> 923d4a5ca4f (remote rename/remove: handle branch.<name>.pushRemote
> config values, 2020-01-27). See the preceding commit for why this does
> & doesn't matter.
>
> While we're at it let's also test that we handle the "*.pushDefault"
> key correctly. The code to handle that was added in
> b3fd6cbf294 (remote rename/remove: gently handle remote.pushDefault
> config, 2020-02-01) and does the right thing, but nothing tested that
> we wrote out the canonical camel-cased form.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/remote.c  | 2 +-
>  t/t5505-remote.sh | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index f286ae97538..717b662d455 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -746,7 +746,7 @@ static int mv(int argc, const char **argv)
>  		}
>  		if (info->push_remote_name && !strcmp(info->push_remote_name, rename=
.old_name)) {
>  			strbuf_reset(&buf);
> -			strbuf_addf(&buf, "branch.%s.pushremote", item->string);
> +			strbuf_addf(&buf, "branch.%s.pushRemote", item->string);
>  			git_config_set(buf.buf, rename.new_name);
>  		}
>  	}
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 2a7b5cd00a0..34fc3fa421f 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -757,6 +757,7 @@ test_expect_success 'rename a remote' '
>  		cd four &&
>  		git config branch.main.pushRemote origin &&
>  		git remote rename origin upstream &&
> +		grep "pushRemote" .git/config &&
>  		test -z "$(git for-each-ref refs/remotes/origin)" &&
>  		test "$(git symbolic-ref refs/remotes/upstream/HEAD)" =3D "refs/remo=
tes/upstream/main" &&
>  		test "$(git rev-parse upstream/main)" =3D "$(git rev-parse main)" &&
> @@ -773,6 +774,7 @@ test_expect_success 'rename a remote renames repo r=
emote.pushDefault' '
>  		cd four.1 &&
>  		git config remote.pushDefault origin &&
>  		git remote rename origin upstream &&
> +		grep pushDefault .git/config &&
>  		test "$(git config --local remote.pushDefault)" =3D "upstream"
>  	)
>  '

Again, good find, but I am not sure if we want the test to be so
strict.  Besides, quoting one and not quoting the other in the same
patch looks the test is also being inconsistent ;-).

Thanks.
