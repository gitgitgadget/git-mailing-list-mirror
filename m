Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2067F1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbdL0SHY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:07:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56654 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751781AbdL0SHY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:07:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7C6DBC279;
        Wed, 27 Dec 2017 13:07:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rvzthYWYm+t2
        M/7s24+fRUgHeL4=; b=Xd1ybb67fGFI48gNPOHjE/MGwV3I3+KfnEVrmm8QXf0B
        TIOOf2pvVwfTqb3CDLsBaws4WXs6WS7NmYDg/2a4w9Cay3q0p353DuYVfr1SCGqw
        9jnshvqc6ZFVHYxzoIsTCiZDHcwOCftUO4+qZssWFAUlYWvW+SJomE1QYRq8NEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=L4dYtt
        rQU+3rYn5QDQ37ocXtzUblx7ENcwrYssA8mHoJzqsN0oUsNi9S2Mnk9X7pnMio2Q
        34uFz6ctZ+Ihzps9fnvZBoOetB2O7xpccUinonSrDttIJHQcAcGu6aSJpX4qav3+
        HyHQk8Trzk0V1pbMjBCwjijOO3l9lZhvg4MgQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BDF19BC278;
        Wed, 27 Dec 2017 13:07:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F80DBC277;
        Wed, 27 Dec 2017 13:07:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH 3/1] update-index doc: note a fixed bug in the untracked cache
References: <20171227102551.GA26616@ash>
        <20171227112854.1322-1-avarab@gmail.com>
Date:   Wed, 27 Dec 2017 10:07:21 -0800
In-Reply-To: <20171227112854.1322-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 27 Dec 2017 11:28:54 +0000")
Message-ID: <xmqqpo70nixy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C9AF497E-EB30-11E7-A5CA-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Document the bug tested for in my "status: add a failing test showing
> a core.untrackedCache bug" and fixed in Duy's "dir.c: fix missing dir
> invalidation in untracked code".
>
> Since this is very likely something others will encounter in the
> future on older versions, and it's not obvious how to fix it let's
> document both that it exists, and how to "fix" it with a one-off
> command.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>
>> On Tue, Dec 26, 2017 at 05:47:19PM +0700, Duy Nguyen wrote:
>>> Strangely, root dir is not cached (no valid flag). I don't know why
>>> but that's ok we'll roll with it.
>>
>> I figured this out. Which is good because now I know how/why the bug
>> happens.
>
> Thanks a lot. I think it's probably good to apply something like this
> on top of this now 3-patch series.

Thanks both for working well together.  Now that the problem turns
out not about symbolic links, can we update the test in 1/1 not to
depend on symbolic links?

>
>  Documentation/git-update-index.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
> index bdb0342593..bc6c32002f 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -464,6 +464,17 @@ command reads the index; while when `--[no-|force-=
]untracked-cache`
>  are used, the untracked cache is immediately added to or removed from
>  the index.
> =20
> +Before 2.16, the untracked cache had a bug where replacing a directory
> +with a symlink to another directory could cause it to incorrectly show
> +files tracked by git as untracked. See the "status: add a failing test
> +showing a core.untrackedCache bug" commit to git.git. A workaround for
> +that was (and this might work for other undiscoverd bugs in the
> +future):
> +
> +----------------
> +$ git -c core.untrackedCache=3Dfalse status
> +----------------
> +
>  File System Monitor
>  -------------------
