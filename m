Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E5DC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 03:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06E064E90
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 03:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhBYDRc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 22:17:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63967 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbhBYDRa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 22:17:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AD10AAD20;
        Wed, 24 Feb 2021 22:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9kyzNvTUnm/g
        FdaQ8v386ng0sFo=; b=ohJXrEpFDusWFykYF7pG3wj18BhioqAWAV0PgAAM0Zks
        7vhI/1tZHl5GQ3ktb7g/DPpisjV5lfE2MmaLT/hJmuIVXg8K7/QAwDwdqEUjiLwL
        43+aTQcFFcvA8V/7pmmUCwnOqPxN3bRmqqyPg+5sDrdPYoK3JAVo1DwsjkWz9Yc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=erTx7g
        6Zh2gamjAC9mfG79Xz9xYmE3HwZNOa3J3YAfHq+g3ghASBdg9JgMkMJ34i5tqGDO
        MozFpUojfPrYT88TDFeE3+fhs7Y+4rN2OTK9dEtAiMIpQSIPtNyw2FBpXhLB3ISv
        U+ZeVsF0Mf9kXBPCJY3K2PvPRadwyoOSo/hSU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11543AAD1F;
        Wed, 24 Feb 2021 22:16:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 897C3AAD1E;
        Wed, 24 Feb 2021 22:16:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/2] remote: add camel-cased *.tagOpt key, like clone
References: <20210225012117.17331-1-avarab@gmail.com>
Date:   Wed, 24 Feb 2021 19:16:45 -0800
In-Reply-To: <20210225012117.17331-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 25 Feb 2021 02:21:16 +0100")
Message-ID: <xmqqwnuwx2ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E47547BA-7717-11EB-B058-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> It's easy enough to add a test for this, so let's do that. We can't
> use "git config -l" there, because it'll normalize the keys to their
> lower-cased form.

I wondered if we want "git config -l --preserve-case" or something
like that, but an extra grep for "tagOpt" would be sufficient in a
simple test like these that are unlikely to have unrelated tagOpt
defined in the file.  More importantly, I am starting to doubt if
this should even be tested.

If there were existing "section.varname" variable definition and we
ask

	git_config_set("section.varName", "newvalue");

we may end up with "[section] varname =3D newvalue", and that is
perfectly OK, I would think, because the first and the last
component of the configuration variable names are defined to be case
insensitive, and here may be "[Section] varname =3D oldvalue" in the
configuration file before we try to set it, and the implementation
is free to replace "oldvalue" with "newvalue", instead of first
removing "[Section] varname =3D oldvalue" and then adding a new
"[section] varName =3D newvalue" (after all, there may be variables
other than "varname" in the section, and the existing "[Section]"
header may need to be kept for the remaining variables while we futz
with the varname or varName).

Which means that while we do want to spell the names in our source
code correctly (i.e. "tagOpt", not "tagopt") when we tell which
variable we want to get modified to the git_config_set() function,
we should not care how exactly git_config_set() chooses to spell the
variable in the resulting configuration file, no?

So, ...

> diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
> index 6a6af7449ca..3126cfd7e9d 100755
> --- a/t/t5612-clone-refspec.sh
> +++ b/t/t5612-clone-refspec.sh
> @@ -97,6 +97,7 @@ test_expect_success 'by default no tags will be kept =
updated' '
>  test_expect_success 'clone with --no-tags' '
>  	(
>  		cd dir_all_no_tags &&
> +		grep tagOpt .git/config &&
>  		git fetch &&
>  		git for-each-ref refs/tags >../actual

...as long as "git config remote.origin.tagopt" yields what we
expect, we should be OK, I would think.  Insisting that the variable
name is kept by git_config_set() API may be expecting too much.

>  	) &&
