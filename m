Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA1CC4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 01:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiLBBao (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 20:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLBBam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 20:30:42 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BBBD15A7
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 17:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669944635; bh=OZQmchSHJ5Mq6xq3gBWdm7gmGMyli5S+0PAT62OxTRg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=d/7y1SXX7CaHTOZPcwQcH1dytSN5EMpXTV1eNFH6RQEfuusL7YnOmDIRtFwIqngDN
         gwnAiKZhUfEzTx62ul3aLsL05I3qF9B+Wh6owTVVGJAbbzTh/k++Kht76Y/m3wt+W5
         LRVTdkCCJlbBK6IvkHm+oF4z/3OWOYh62IsDgVHG5zj37jIiI/yBcs6D/7gyTplhS/
         EoQMRMwrDY0ZIqHT5az82hbQPeOvuwh/15/GT4Dg7xiKz2Jaz0puuVH9tTnizNxhpQ
         Q8Ja2DnFhdQhWVMqXtd64fLYmd5I3BV1VmAkv2xsGMQIgOUVgfioyCABHoKooAzGsq
         qGAyMfqVZNAXQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3uS-1oUbGT08xm-00gMEA; Fri, 02
 Dec 2022 02:30:35 +0100
Message-ID: <6f6350b7-a479-c05d-6100-cb2aad72a658@web.de>
Date:   Fri, 2 Dec 2022 02:30:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/8] test-lib-functions: add and use test_cmp_cmd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v2-4.8-c36060934a6-20221202T000227Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:atgiMjyewHJoNiOuo21PYPouKT5Ab7BtKvEQCYzgnWJKWRuWs4a
 rkbmQWCxliMz5252rYF5K4wmBFU4rjy8Hg3S/X8uAD1vOIC5VLjL3QJ1RhGh6J0eCO/mKDf
 DKpaYgDVV2jZ2d6qrkQVOWfX39IzwMTmytgMpM2brpISAgq6nzeommjZUCgfZI/ztHlKq2u
 86446j0aVh/snvKZCmUhg==
UI-OutboundReport: notjunk:1;M01:P0:oRVrmM0cLAE=;pJnANN9tmIaHJR8jhP2rR26vE3V
 O+qLKvuyKK3bpXW4Fm7JliX0PRDI+qcYx3hIZNGgoIUJvnOwfCzFYZb+77a7XS12yAbJEfwBx
 WhVQIHtR/olBt134xrMHGg4v9bSywcf66wpArOohWC77Q0Tjt9BrRtEfqQ8D9YurLCR6gnlFU
 QY5Ste+0x6tsgWHLk/y8udWi/aStqk6h/OKuq9fguEiBLRWKs/wgQE4bUXiX1HqDQEWNQPK7H
 KDhLKJq0vpTjVAPAsapqksP+pdy2dx9RrbHrtQtQIOisRBE3xYJ3ggozCNbeBiz91OtqVKCgb
 d61Jf2LTc5/Eyeklkt72KESM2SQpw6mcoWqTCQ1zwyeg+9moMIIe4s2Dty3vQXHpg9Jpg5GEM
 evBOF8b3fDrvX+07Ll37C+1bLowzpIVZ1qV1NP2e/TzExsVDXtnMInWDhO+lYxw2rk7N3EEHg
 RRLsEaCIK5v6yXiVzEOT2OOx1Uv1W20MJaRqH8nnp+5GKbMIOjAy2qHNyvN4ChwCBEmafirgz
 AE1Kxw1SLtxwSO1LYMvfwWbZp64HJyprlguyEHaQ3tDL0TNWtf5Z3s/vSGkiTjOGANEwvz3x8
 FSiBGSNGAiHHKN1jEYaWHkNdQ7lZZe3XfUQHq0FPUmB4o2AteybK8F6XpAoKk1/7+YQo63Mcz
 4OiQyV05jZP7Yod6IDi7DQRLOtkdQ7n1BmvuHTWu8ad3vjv1EakaG8NyvAe9+OQTk/SaWGZq8
 yb2T8q6RxywzImntQlTIiKvneFQDo8GIJBBH6z4WvhmSNB6JholUc0ANAdCYzelvtVhE9BuSu
 FViWJq4/jmFLDtONc1+naMXRzgtjoycB7Gk1ahr9gwveINOacAIm+kM67ge18MLj+U2VtPxCz
 2AjxPpIkRRDW1iywyF6O0Cyw6EbTMps3jXVtjPaCYa0qYpUQQ6YcCTSwQo2axuRUcdb0NQJ4v
 SgxJkgAicQQianwnSaL0kuIAlRk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.12.2022 um 01:06 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Add a "test_cmp_cmd" helper for the common pattern discussed in the
> documentation being added here to "t/test-lib-functions.sh".
>
> This implementation leaves the door open for extending this helper
> past its obvious limitations, such as:
>
> 	test_cmp_cmd "some" "lines" -- <some-cmd>
> 	test_cmp_cmd --stdin <some-cmd> <expect
> 	test_cmp_cmd --ignore-stderr "output" <some-cmd>
>
> By using this in we'll catch cases where "git" or "test-tool"
> errors (such as segfaults or abort()) were previously hidden, and we'd
> either pass the test, or fail in some subsequent assertion.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 796093a7b32..0e8e0f808e3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1274,6 +1274,24 @@ test_cmp_rev () {
>  	fi
>  }
>
> +# test_cmp_cmd is a convenience helper for doing the more verbose:
> +#
> +#	echo something >expect &&
> +#	<some-command-and-args> >actual &&
> +#	test_cmp expect actual
> +#
> +# As:
> +#
> +#	test_cmp_cmd something <some-command-and-args>
> +test_cmp_cmd () {
> +	local expect=3D"$1" &&
> +	shift &&
> +	printf "%s\n" "$expect" >expect &&
> +	"$@" >actual 2>err &&
> +	test_must_be_empty err
> +	test_cmp expect actual

err, expect and actual are common filenames used in tests.
Clobbering them might be surprising.  Perhaps at least add some
prefix (e.g. name them test_cmp_cmd_expect etc.), like other
functions in that script do, to avoid collisions?

> +}
> +
>  # Compare paths respecting core.ignoreCase
>  test_cmp_fspath () {
>  	if test "x$1" =3D "x$2"
