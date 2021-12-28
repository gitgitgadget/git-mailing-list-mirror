Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C48C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 16:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbhL1QFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:05:35 -0500
Received: from mout.web.de ([212.227.17.12]:36771 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235538AbhL1QFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 11:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640707522;
        bh=fude5wyJy88bzVKDwA3UERoKabhCIo1ORBw8C0KnP9A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=amXrhUCXL+buzrX2kDgu416ze2JqYb0uAwZiNMKjofA6WWy04LW9JqLBKLWwlg3P/
         P7uplE7LbifUp4F9G5LLcbN+9r/s7iw7i+u7bQUGE42LPT3zHYk7w25CWYLOu3jm+S
         BurXSWHdUkuOrU4ww4pSI+XPfBjJ64ChzP7xvbjc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MSIEs-1mrHg21OP2-00Sxau; Tue, 28
 Dec 2021 17:05:22 +0100
Message-ID: <862118f6-e5dd-8e0a-139f-37b5a1682797@web.de>
Date:   Tue, 28 Dec 2021 17:05:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v8 5/7] progress.c: add temporary variable from progress
 struct
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v8-0.7-00000000000-20211228T150728Z-avarab@gmail.com>
 <patch-v8-5.7-72a31bd7191-20211228T150728Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v8-5.7-72a31bd7191-20211228T150728Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lP6CXRdPPhAqACj/Ij9R48wWk6EyUb5JPPOME46rxNxawGk2fQf
 oN9GiD//+r6n0LFVYEG8VDFXf/6qk49d9fkS4Ik7H1ayEDuYP1FofTY4he24WK7VzT2eFEs
 XL8e6vQWPndv5vn3Jb18c6KEbP/Jc1Pri39xew5LXuAX1mzpFFVMZ2R6UUJiIJwues0wtls
 +IgRmhnI+pWWmToQiokJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eUbYyLcYnaI=:kWQ66b8v3nVZfnC7+4y4md
 qs3fUoF7hSUkmRD0yg2tDu6w8wzvcxegS0xuy1Z4qPwTI8/2I9R1oZeXimoqUSRBOl3qHdeoU
 BWi34f3nWir91wUc65kT0yYXHdwqVD86tZBmAOKvhToYXEaHR0CrEi6lEvuM5duxzUeFpx9fZ
 gOWLJk4EiO9S0Wp27mnRtqUi/RKV4IiOUUv2jzMVPmC/wfBTD6PdA8my4foWkmPdiNYUhdUQg
 j23RiFPS+80+aQN2XYqM3Xb7lHgfzqOBsFls5KcDaPiPghGKdygkfwkv8z6OX5QWgNzG1Qh5q
 0CnhnZhh03Idte70K+qC67YHcTgGBqDYCMGfecWJmzej9GnuHcfMmfXgGf1ojLAj476f6Euol
 OVjWwEpv/IAq/+Bfjv7BGPNUZC7tVtP8Gx11BOUGt2McoyjIgR4OmtSOCZw98hHJHgPjInx2k
 0UqbTVmP+FjS8/M8MUQaWztE32y3OoMJJUdKb91jQyxc7BqB01l/ZoKXni3bBeRtE+lTUUNta
 HZbtLHqX9yDMmH7tQxjhlU4x4BRAsaL7b3So3wORh1twa6ok3KLccCX+t9gleNZ+1XqzKz6vK
 Y4FSd8WbcbtxSMTUvw9HRjgOn2Unc4hEkB7nW/qjpCsiD1FcJ/m8RivZ9schR6SNuot2f9YR/
 qgK1BVm9sU5InIpfUsnJPI5tOFR/I9kNs7i7SlLKQGvnAn9srq0iWZmt+WFbTGqnwmSYAHGGz
 5DNGa5jtX6f8xg0caO07JKpoz+60BjuyclAYhQ/KK9CpZfU4uMzDYh0/2sN6VdvbcaoKDcnJo
 wDpYFLNrIQ4Sqks3f0PnnT/SgO56MQKTVKpQhuiZuXZXkFGq5VWYcq+86GIOnIAnn0qqZOmyO
 9EowXkAbPPdvzf3l5mTHlDv2ecYpnYu7l0ef7LMEl37E2tQkgNHHDze7SHHaYX8yWAv58bNvY
 1y3AWk1i7o6/0PQr8udP14SBixDT1kSAZ1DTXUKPqM/BzOY/AKVpjt5Ia42uc5DZjPGlfocKV
 7CJye0Vv5JvBPTKBAatEIO1rw9uxLZaw5Ful/h6Eodm82Twl6arls6emr9BjiKV4Lw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.21 um 16:19 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> Since 98a13647408 (trace2: log progress time and throughput,
> 2020-05-12) stop_progress() dereferences a "struct progress **"
> parameter in several places. Extract a dereferenced variable (like in
> stop_progress_msg()) to reduce clutter and make it clearer who needs
> to write to this parameter.
>
> Now instead of using "*p_progress" several times in stop_progress() we
> check it once for NULL and then use a dereferenced "progress" variable
> thereafter. This continues the same pattern used in the above
> stop_progress() function, see ac900fddb7f (progress: don't dereference
> before checking for NULL, 2020-08-10).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  progress.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/progress.c b/progress.c
> index 680c6a8bf93..688749648be 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -319,21 +319,23 @@ static void finish_if_sparse(struct progress *prog=
ress)
>
>  void stop_progress(struct progress **p_progress)
>  {
> +	struct progress *progress;
>  	if (!p_progress)
>  		BUG("don't provide NULL to stop_progress");
> +	progress =3D *p_progress;
>
> -	finish_if_sparse(*p_progress);
> +	finish_if_sparse(progress);
>
> -	if (*p_progress) {
> +	if (progress) {
>  		trace2_data_intmax("progress", the_repository, "total_objects",
> -				   (*p_progress)->total);
> +				   progress->total);
>
> -		if ((*p_progress)->throughput)
> +		if (progress->throughput)
>  			trace2_data_intmax("progress", the_repository,
>  					   "total_bytes",
> -					   (*p_progress)->throughput->curr_total);
> +					   progress->throughput->curr_total);
>
> -		trace2_region_leave("progress", (*p_progress)->title, the_repository)=
;
> +		trace2_region_leave("progress", progress->title, the_repository);
>  	}
>
>  	stop_progress_msg(p_progress, _("done"));

This patch is trivially correct, but I wonder why all that code is here
instead of in stop_progress_msg().  I would expect stop_progress() to be
a thin wrapper that just provides a default message, but actually it
handles sparse progress and tracing.  Isn't both necessary even with a
custom message?

In any case, moving the code there becomes easier after this patch.

Ren=C3=A9
