Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1CEC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbiD0SKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiD0SKL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:10:11 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97C512AA5
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651082802;
        bh=9lCHn/FxACo4ZJwS9p7evhXn5eiXk6ZxkH5pysvdDkM=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=PFmzxeTLGyQQv/ayCgDFq6NXCX3/tZV0nFZixgsCY0eoYC/LOWB8VKQ6x48CsoFMn
         YG6xlcPdKPF0T1mXLJg3e2Qdz6cRh49rwuirfCNc+WmUVhPWaTkdOmoOfr7UwxM68y
         YoNo6KCUEh1GG6qylJBprpzdMFldZKcw2eQZefGc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melf5-1oJemF05Qb-00aizW; Wed, 27
 Apr 2022 20:06:42 +0200
Message-ID: <a1dcac11-98ac-9fcd-8375-4fd1be9ace78@web.de>
Date:   Wed, 27 Apr 2022 20:06:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Matthias_A=c3=9fhauer?= <mha1993@live.de>
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
 <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
 <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com> <xmqqo80nsw5h.fsf@gitster.g>
 <xmqq7d7bsu2n.fsf@gitster.g> <561a73aa-7e94-5a09-0c9c-08e8b6ce7188@web.de>
In-Reply-To: <561a73aa-7e94-5a09-0c9c-08e8b6ce7188@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D3st5dmxAU1XLg/18RMGI8ELk2HYOp10mJ/emwB1N+LbbdJmEyt
 3ITUVuA5j6U+vlcBR32ZY253biwlCdecrn3/2cqqd/unzvPNObMdDl0o4P6u6GhLmyeYSO8
 9sZVT5TwQBRMNp3nH0WrjGPuamX+lC0BVjyzR/5KoP1aeUjE+GNGlcuHERTKZPludj+VxVc
 /8LcZZPHurENV1DwLw+NA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sT+p/Z0CB3g=:g9E35tFdu6tz43/3LhpdVA
 rpoEMdkQ9jRnTlWeDZK7Cjjim0floMeM1m2os4cx2eLdatyR2h7dnUXg3AkqknB3QF0k6bgAa
 +aim2N4ihEu/QFF+OB6v2wNaWv3BxRovCD8D2sD0ctBWRtYvb5HOOaKKxQ9CJsyIjr+uQWu5u
 acUoojpS5pUl5ld7DWfbki4LU22mQJDCWTO0HG0OXvHXndbokYyLhdLnVpSF8egn5/J08hUyP
 98NdwsFH7s+gC9XPb0AbIrJJiPozXjuWTgZ2GJnESh9tH7mEZ9sVGM19jwUW4VSp5YbWIVrLM
 /suPsdg+NcLowP8I9/iosexHWCtMtlUTYXqEsO1zUPC3VHYSDRBiS+1ZdvBHNkOrEIEcBHmr5
 ABJWkiBsPrP4l3f4B0uV3lmwDtvDvFzcas8WIYz2v85zW0jgDtMkdDnHeQZ63hEM2VcEhya8H
 Fr2Sshn6uIYdooUQpH/s9qjK7/7Y60B7/l252Ph+w/h7IqtMyQeXMXGHsy7b7OHbzd9Ro5Grq
 YzenMXdy/1BTTDMdlHMX8ZvUD/S9gRBBG2XtdCCmzQnc82GqmTJjsgeZy2q990/xjsST3oCL8
 3B8ZxR/AZuNVpNdE6ZGKsxx5O4ZhSBWdQoNBzlTTVDw8hraawPzreChhy2FI1HPT+9Nz5WRbr
 hTGxVxOdtwD/rvmZ82G37FGYGJlyGO6EIR/dQ9f8RnybnVT8Bx4jl0Nwnxo4wOw9XC8VPoW5I
 3I/4LgTtgbmYRc7XsSW9I07zS7z03Qmq3Ex4iBRsOkmn3/vjSVRsK2RV5qZWsmpA3OLUDpuDe
 vs5jnAow6iErNePKM/C3yrbQP4GLYU9j3zQB4IPMKvM1a6+H3y36zCoGO1LxMIIgH+8VyqttE
 t00vCfu8ymAoms8oJLKfmTfb5yCakeg/ADP21XXyS0qtCBibLc1jGM8bTIJ2q9bvQN5K7wRV/
 vqGWMQb6eBK66CxWfXKpEt0I+l0I1ZrQoqtavREy2/+5om/6LmB6bxbiWqvPNXuVJNDXdlRue
 P2WWCRYGbeajP9klnRTe6J9DKFU7wL1Dmr/Q+qMoh59mQXBDYh8JopSFeGRoS9Yvwg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.22 um 18:42 schrieb Ren=C3=A9 Scharfe:
> Am 26.04.22 um 18:11 schrieb Junio C Hamano:
>> This only surfaced as a regression after 2.36 release, but the
>> breakage was already there with us for at least a year.
>>
>> The diff_free() call is to be used after we completely finished with
>> a diffopt structure.  After "git diff A B" finishes producing
>> output, calling it before process exit is fine.  But there are
>> commands that prepares diff_options struct once, compares two sets
>> of paths, releases resources that were used to do the comparison,
>> then reuses the same diff_option struct to go on to compare the next
>> two sets of paths, like "git log -p".
>>
>> After "git log -p" finishes showing a single commit, calling it
>> before it goes on to the next commit is NOT fine.  There is a
>> mechanism, the .no_free member in diff_options struct, to help "git
>> log" to avoid calling diff_free() after showing each commit and
>> instead call it just one.  When the mechanism was introduced in
>> e900d494 (diff: add an API for deferred freeing, 2021-02-11),
>> however, we forgot to do the same to "diff-tree --stdin", which *is*
>> a moral equivalent to "git log".
>>
>> During 2.36 release cycle, we started clearing the pathspec in
>> diff_free(), so programs like gitk that runs
>>
>>     git diff-tree --stdin -- <pathspec>
>>
>> downstream of a pipe, processing one commit after another, started
>> showing irrelevant comparison outside the given <pathspec> from the
>> second commit.  The same commit, by forgetting to teach the .no_free
>> mechanism, broke "diff-tree --stdin -I<regexp>" and nobody noticed
>> it for over a year, presumably because it is so seldom used an
>> option.
>>
>> But <pathspec> is a different story.  The breakage was very
>> prominently visible and was reported immediately after 2.36 was
>> released.
>>
>> Fix this breakage by mimicking how "git log" utilizes the .no_free
>> member so that "diff-tree --stdin" behaves more similarly to "log".
>>
>> Protect the fix with a few new tests.
>
> We could check where reused diffopts caused a pathspec loss at runtime,
> like in the patch below.  Then we "just" need to get the relevant test
> coverage to 100% and we'll find them all.
>
> With your patch on top of main, "make test" passes for me.  With the
> patch below added as well I get failures in three test scripts:
>
> t3427-rebase-subtree.sh                          (Wstat: 256 Tests: 3 Fa=
iled: 2)
>   Failed tests:  2-3
>   Non-zero exit status: 1
> t4014-format-patch.sh                            (Wstat: 256 Tests: 190 =
Failed: 1)
>   Failed test:  73
>   Non-zero exit status: 1
> t9350-fast-export.sh                             (Wstat: 256 Tests: 50 F=
ailed: 3)
>   Failed tests:  30, 32, 43
>   Non-zero exit status: 1
>
> The format-patch is a bit surprising to me because it already sets
> no_free conditionally.  t4014 is successful if no_free is set in all
> cases, so the condition seems to be too narrow -- but I don't understand
> it.  Didn't look at the other cases.
>
> ---
>  diff.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index ef7159968b..b7c837aca8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6455,9 +6455,16 @@ static void diff_free_ignore_regex(struct diff_op=
tions *options)
>
>  void diff_free(struct diff_options *options)
>  {
> +	static struct diff_options *prev_options_with_pathspec;
> +
>  	if (options->no_free)
>  		return;
>
> +	if (prev_options_with_pathspec =3D=3D options && !options->pathspec.nr=
)
> +		BUG("reused struct diff_options, potentially lost pathspec");
> +	if (options->pathspec.nr)
> +		prev_options_with_pathspec =3D options;

This can report a false positive if a diffopt is reused with different
pathspecs, and one of them is empty (match all).  Which could be countered
by using a fresh diffopt every time (e.g. pushing it into a loop).

> +
>  	diff_free_file(options);
>  	diff_free_ignore_regex(options);
>  	clear_pathspec(&options->pathspec);
