Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A231F461
	for <e@80x24.org>; Fri,  6 Sep 2019 17:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfIFRDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 13:03:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55205 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfIFRDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 13:03:10 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65B61329EE;
        Fri,  6 Sep 2019 13:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5f1pAzg8hdxE
        tWdt39+mcKP3/s4=; b=NHBUDP71j9fO67wer3D+T6yX2V6Au7spGQxr15p9JnMH
        bbC/OOKHBLQda/tUvaubIPpkVwCE5wQCpwAGQbJpDRnnS1NwuVf7Uz5IX9PN87Mz
        zLwv80vRGQJFki+IBVNz8ibFen06+Mb3jff2rSINTHskbuT+D0o3iUpidg/HsuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=o8Ee2b
        o/MUPloTtPjQSDhOoEBoE15bHSaiM0U95r9I+cWzDGJghFldMIfzSdTM+WyPA4vZ
        puP88HntQdpaJiLerK8lnMt3ST/uAGZZk4t9W7Fh8VwCOE4h4iP2WgEf6QgbQGq6
        ilgbKfcXUqrvhrT36YhMxOtpJfjON5BfQ+Awc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D604329ED;
        Fri,  6 Sep 2019 13:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B9A0D329EC;
        Fri,  6 Sep 2019 13:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] ci: restore running httpd tests
References: <20190621101812.27300-8-avarab@gmail.com>
        <20190906121326.23056-1-szeder.dev@gmail.com>
        <20190906121326.23056-2-szeder.dev@gmail.com>
Date:   Fri, 06 Sep 2019 10:03:06 -0700
In-Reply-To: <20190906121326.23056-2-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 6 Sep 2019 14:13:26 +0200")
Message-ID: <xmqqd0gdnyr9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32EADAEC-D0C8-11E9-8A35-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> Once upon a time GIT_TEST_HTTPD was a tristate variable and we
> exported 'GIT_TEST_HTTPD=3DYesPlease' in our CI scripts to make sure
> that we run the httpd tests in the Linux Clang and GCC build jobs, or
> error out if they can't be run for any reason [1].

Wow.  I vaguely recall having mumbled about keeping YesPlease as an
extra synomym for 'yes' for safety against misconversions, as its
use in the build/test infrastructure is so ingrained, but at the end
went with the standard set of boolean without doing such extending,
with the hope that soon any misconversion would be found out.

This discovery of a misconversion took 3 months, which may or may
not match the definition of "soon" X-<.

The fix is obviously correct.  Thanks.

> Then 3b072c577b (tests: replace test_tristate with "git env--helper",
> 2019-06-21) came along, turned GIT_TEST_HTTPD into a bool, but forgot
> to update our CI scripts accordingly.  So, since GIT_TEST_HTTPD is set
> explicitly, but its value is not one of the standardized true values,
> our CI jobs have been simply skipping the httpd tests in the last
> couple of weeks.
>
> Set 'GIT_TEST_HTTPD=3Dtrue' to restore running httpd tests in our CI
> jobs.
>
> [1] a1157b76eb (travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh',
>     2017-12-12)
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  ci/lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 44db2d5cbb..29dc740d40 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -160,7 +160,7 @@ linux-clang|linux-gcc)
>  		export CC=3Dgcc-8
>  	fi
> =20
> -	export GIT_TEST_HTTPD=3DYesPlease
> +	export GIT_TEST_HTTPD=3Dtrue
> =20
>  	# The Linux build installs the defined dependency versions below.
>  	# The OS X build installs much more recent versions, whichever
