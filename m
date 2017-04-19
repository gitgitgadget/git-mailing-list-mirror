Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCD0207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933100AbdDSBiM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:38:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65367 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933042AbdDSBiK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:38:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CDB283054;
        Tue, 18 Apr 2017 21:38:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=elgMLVQb+Hdi
        xBSpNukXriP3+bQ=; b=Zokw89itaSM8bXDAfylxpjMS3wN3s3W/+Ow2/McSv644
        NFTirOWXDpUkvAIJrNySHRx5yBUF3B40tNMnsjvtYVeugDj0oD9Mg11DewXe9Rnh
        3wh9oUwWrInv5XiHRKBeLf3dxT5abO19Isd7FIR4oxb4omLf+dxUm7HWN/e2sQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sTKqN/
        r7msrq3eUjnu0lKk4uCgQJV6YCn7fXJ9zr3KntAZnQCLpyPfrMwqP9YlLzAow+Ye
        qlY/QFIftY3EWNG/on+xa7SGotk2y91YBh2P+X8WZC2J3WtNglz/CPsiJS8djI2e
        7fj13i4ysKxGD9N9cXqSb4NwXGLQuEIGu5bm0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24FB783053;
        Tue, 18 Apr 2017 21:38:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8300383051;
        Tue, 18 Apr 2017 21:38:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] clone: add a --no-tags option to clone without tags
References: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
        <20170418191553.15464-1-avarab@gmail.com>
Date:   Tue, 18 Apr 2017 18:38:07 -0700
In-Reply-To: <20170418191553.15464-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 18 Apr 2017 19:15:53 +0000")
Message-ID: <xmqq60i1dvnk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D769E8BE-24A0-11E7-8629-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a --no-tags option to "git clone" to clone without tags. Currently
> there's no easy way to clone a repository and end up with just a
> "master" branch via --single-branch, or track all branches and no
> tags. Now --no-tags can be added to "git clone" with or without
> --single-branch to clone a repository without tags.

Makes sense.

> +--no-tags::
> +	Don't clone any tags, and set `remote.origin.tagOpt=3D--no-tags`
> +	in the config, ensuring that future `git pull` and `git fetch`
> +	operations won't fetch any tags.

OK.  Not just we ignore tags during the initial cloning, we set
things up so that we do not _follow_ tags in subsequent fetches.

s/won't fetch/won't follow/ is probably needed, as we still allow
users to fetch tags by explicitly naming them on the command line.
The only thing we are doing is to refrain from auto-following.

As an end-user facing help, exact configuration name and value is
much less helpful than telling them the effect of the setting in the
words they understand, i.e. "make later fetches not to follow tags"
or something.  Hardcoded 'origin' in `remote.origin.tagOpt` is not
correct anyway, so I'd suggest redoing this part of the doc.

> @@ -120,6 +121,8 @@ static struct option builtin_clone_options[] =3D {
>  			N_("deepen history of shallow clone, excluding rev")),
>  	OPT_BOOL(0, "single-branch", &option_single_branch,
>  		    N_("clone only one branch, HEAD or --branch")),
> +	OPT_BOOL_NONEG(0, "no-tags", &option_no_tags,
> +		       N_("don't clone any tags, and set remote.<name>.tagOpt=3D--no=
-tags")),

Likewise.  As an end-user facing help, exact configuration name and
value is much less helpful than telling them the effect of the
setting in the words they understand, i.e. "make later fetches not
to follow tags" or something.

> +	if (option_no_tags) {
> +		strbuf_addf(&key, "remote.%s.tagOpt", option_origin);

Good to use option_origin. =20

> +		git_config_set(key.buf, "--no-tags");
> +		strbuf_reset(&key);
> +	}
> +

Thanks.
