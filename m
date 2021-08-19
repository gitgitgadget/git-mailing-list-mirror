Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36F1C4338F
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 07:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C5160560
	for <git@archiver.kernel.org>; Thu, 19 Aug 2021 07:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbhHSHqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 03:46:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:44685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhHSHqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 03:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629359160;
        bh=kH9tkjt0QOcTmsyBiQlt1ogY/33j3t6Rb5RgSZqpI/I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GDjGjSEIkcsKBykE8tvXeTNiorDspuSGudzW+TCRrQALxvhWZUdhV6RJK2T4fSN5i
         NgpgdpgHkf07B4cJSSMIPXOzbtpmr4qC5/2Xb6unXZCIdsgBkTsn228B61pkVmjxBi
         lzH8dNf4NF7xGW9lEaURz5zavRKnpNifSrWdPSYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.229]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1mhOxa3fFp-00Qo9d; Thu, 19
 Aug 2021 09:45:59 +0200
Date:   Thu, 19 Aug 2021 09:45:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/8] t7519: rewrite sparse index test
In-Reply-To: <e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108190933210.55@tvgsbejvaqbjf.bet>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com> <e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dE3nxCTxMJI/fafK3aU6GM/KeFYu0UIn2tKObw0KZLp6CLRMZoO
 spR5HJg0+/8Cl5jniiX55yDojEgcWqmb2qeW2EE+SclZMLyWDJ6IsziXd/hOxkOhm4e/B5g
 oei6SzyZhvF9EkVKc1bxsQ5YNhbsXGNPU5LEd5y/RswWwH3m4YKKAkXNIn7rzVBOiXBinQs
 ZfYhXejCru/oZQPTZ87aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/QE06rCaHPY=:2bwJHDRn8XCYwX/8w6orVS
 M8f72C8juHO4ZyhAX+SuMguQB8sSkSfrV41HPwOGPgPy416RGUN2bwj/iulD/AlPepCA2nVcL
 CcSEeDHnbc07I7bpARazzb7INJxsQ49SmdaLDfBOt6zutlyK/zuC2q8KjlKl9KFYi26QX2WPm
 AvaiUS9V2vTlvYO1CMFg34fYLJLliUs0e2WaO8DALNTPaYOtInXEIURekOYQkySEf7KPKfX9A
 wPhH0vmfY+xZV/53a1PgEJgETmtFIvW3fXzTTM7KRp6a6P3rSnz/f1QXx4niO+1APw98xWp13
 ueYZjbtZEX8C5xPbfAoIRmpn6w1Rd67Z8ZuIQ0CqDQ+2LaELkMbM+l9WdiG+0HghzXHkNwQTg
 PqYiLPVHhVchHe2NZra7QzrgXqHa12HTXbVfBMeQW36EjA/siEA6bvWKAOEctot240nqYfjqg
 W6ZHTk70GBvaMC3nmieh5Fn1dxgJU42b9DSND1T0eCYjZopdWRTQVbC0eFgP7SMsBzHaP708e
 egeMnEkJRlPKe5db70SrWyJydLTTlsfCw/XGiiw4oBjHOmUjC0W5broXtduxnaepBQqsum9kN
 JAlIpBgRZ6ke1xD+brZelPHA9EXVC44JEGfMrvs1gCBxHemHp/jZ8jhWbbCIf+vUTcI0igeie
 M1BTApHUN0s+CeTq1Ha93FxzmlHWf71OZafugtXRCIV+yToOQvv0B1qH1NUHrnFysyUKPsaqT
 TYadQ2BPgOpMPaUBbJTDtR4V6NkaDKzs4tDeIMjRMhQNCVT1017Asm3EGUPPZMBSWAYq+fxZK
 IsxvThO28uiE+Gaqf44WegNVj7kIFrHyqEMhiQbUKR93679wUnmaAOPS6eobjez1lTI1hOQ74
 iCQL/XeAMWf4CrY9AEGf+K3DvLcFjZ9TY+TlfjE2MqSaFW/HYFeaGaw/i+aa7qBzYEc8m8/yy
 RYzJZuYCm8MB0qd9i8jvvRxKdYSbRRfu1eF3Rxrf781OZH2c7BnceA/BdslXUFWsBeO3X30cD
 nuI7vIL4igc7Yh7z9m1YIOzriixwOJBXxH9IEraj783NNXEQnXlnfDtqymbZlpMj0J7LSTfyA
 EpVDHGyqrgBBGh8YclVjyQoJa/fAt6RG1BGIZNMCVAeZ9XOHzTkDdMaOQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The sparse index is tested with the FS Monitor hook and extension since
> f8fe49e (fsmonitor: integrate with sparse index, 2021-07-14). This test
> was very fragile because it shared an index across sparse and non-sparse
> behavior. Since that expansion and contraction could cause the index to
> lose its FS Monitor bitmap and token, behavior is fragile to changes in
> 'git sparse-checkout set'.
>
> Rewrite the test to use two clones of the original repo: full and
> sparse. This allows us to also keep the test files (actual, expect,
> trace2.txt) out of the repos we are testing with 'git status'.

Makes sense.

It also should accelerate the test, as it does not have to convert between
sparse and full index all the time.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t7519-status-fsmonitor.sh | 38 ++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index deea88d4431..6f2cf306f66 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -389,43 +389,47 @@ test_expect_success 'status succeeds after staging=
/unstaging' '
>  # If "!" is supplied, then we verify that we do not call ensure_full_in=
dex
>  # during a call to 'git status'. Otherwise, we verify that we _do_ call=
 it.
>  check_sparse_index_behavior () {
> -	git status --porcelain=3Dv2 >expect &&
> -	git sparse-checkout init --cone --sparse-index &&
> -	git sparse-checkout set dir1 dir2 &&
> +	git -C full status --porcelain=3Dv2 >expect &&
>  	GIT_TRACE2_EVENT=3D"$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=3D10 \
> -		git status --porcelain=3Dv2 >actual &&
> +		git -C sparse status --porcelain=3Dv2 >actual &&
>  	test_region $1 index ensure_full_index trace2.txt &&
>  	test_region fsm_hook query trace2.txt &&
>  	test_cmp expect actual &&
> -	rm trace2.txt &&
> -	git sparse-checkout disable
> +	rm trace2.txt
>  }
>
>  test_expect_success 'status succeeds with sparse index' '
> -	git reset --hard &&
> +	git clone . full &&
> +	git clone . sparse &&
> +	git -C sparse sparse-checkout init --cone --sparse-index &&

Would it make sense to call `git clone --sparse . sparse`? I see that
there is no support for `--sparse=3Dcone`, which makes me wonder whether w=
e
want that at some stage. In any case, cloning with `--sparse` and then
setting up the cone mode should result in a little less work, right?

> +	git -C sparse sparse-checkout set dir1 dir2 &&
>
> -	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
> -	check_sparse_index_behavior ! &&
> -
> -	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +	write_script .git/hooks/fsmonitor-test <<-\EOF &&
>  		printf "last_update_token\0"

Technically, the backslash needs to be escaped because it is within double
quotes and we do not want the shell to interpolate the `\0`, but `printf`.
Practically, all the shells I tried handle this as expected.

Also, I have a slight preference for:

		printf "%s\\0" last_update_token

and later

		printf "%s\\0" last_update_token dir1/modified

What do your taste buds say about this?

These are only minor nits, of course. I do like the overall patch and
would be fine with it as-is.

Ciao,
Dscho

>  	EOF
> -	git config core.fsmonitor .git/hooks/fsmonitor-test &&
> +	git -C full config core.fsmonitor ../.git/hooks/fsmonitor-test &&
> +	git -C sparse config core.fsmonitor ../.git/hooks/fsmonitor-test &&
>  	check_sparse_index_behavior ! &&
>
> -	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +	write_script .git/hooks/fsmonitor-test <<-\EOF &&
>  		printf "last_update_token\0"
>  		printf "dir1/modified\0"
>  	EOF
>  	check_sparse_index_behavior ! &&
>
> -	cp -r dir1 dir1a &&
> -	git add dir1a &&
> -	git commit -m "add dir1a" &&
> +	git -C sparse sparse-checkout add dir1a &&
> +
> +	for repo in full sparse
> +	do
> +		cp -r $repo/dir1 $repo/dir1a &&
> +		git -C $repo add dir1a &&
> +		git -C $repo commit -m "add dir1a" || return 1
> +	done &&
> +	git -C sparse sparse-checkout set dir1 dir2 &&
>
>  	# This one modifies outside the sparse-checkout definition
>  	# and hence we expect to expand the sparse-index.
> -	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +	write_script .git/hooks/fsmonitor-test <<-\EOF &&
>  		printf "last_update_token\0"
>  		printf "dir1a/modified\0"
>  	EOF
> --
> gitgitgadget
>
>
