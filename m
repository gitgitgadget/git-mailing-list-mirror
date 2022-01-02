Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ABFC433FE
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 09:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiABJAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 04:00:37 -0500
Received: from mout.web.de ([212.227.15.14]:51599 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbiABJAg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 04:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641114034;
        bh=5LWfu64FYrphR9JOm1mu6Ial7aBl6Eq6TSnSoqNRGp8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QF96nsxsDqgE0VniZw8G8AnAl1tShHhti1nWqg+cz4oHX874YoFhKbyfarFoXSfl8
         oGmqe+80NB9jYRgIneHn0zi9YsUCALmsz8dNAFRLnM8Rihp+4xG/7TPhGMP2sMHHzw
         NxySG+XGLjsfj7UV3CXybVO6bW36SNGE4FlvxbPQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mxpmc-1mCgPs2uT8-00zKrq; Sun, 02
 Jan 2022 10:00:34 +0100
Message-ID: <602b2039-8d74-8063-9757-e67ba5db1141@web.de>
Date:   Sun, 2 Jan 2022 10:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] builtin/reflog.c: use parse-options for expire
 subcommand
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
 <9bd3c6672c4232e0a5c0905b834146ca02af8a4b.1640932151.git.gitgitgadget@gmail.com>
 <6C9B7D67-D21C-44EA-B3FB-9605968AD0FF@gmail.com>
 <a3db4c74-1c60-5ef5-4865-e0fa9639bc5b@web.de>
 <9D4E4253-6EBE-4AA7-86A5-413A732C6E38@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <9D4E4253-6EBE-4AA7-86A5-413A732C6E38@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vWw4INrbKTRNsO/C8SCUExLswUNYvlED1XAnOPv2xlOkXiayeGl
 LKbaesWYb8RDFji7L/sU3Qz36NSeihL6rYgHlQX1IeWDoD+PoexO+XVKLWCFVkpXs5S8Ikw
 KTJEoGjw5c+3Nd2HJLNjDhNIMcSYr4hQAudN+tJeag9CzPFSRLwfJBW1/PJeFZrnm/iQLMh
 HAUTwgPPhPyXPL9gploNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TTEZqdnMaHY=:8y+0fCLwBo4eSWKUzinrHj
 no26z38tau+MipA8UZZZCXQV4HTPlGDNAlAUjsIRlBV76Ri4dEcLkDd35Hg0WWWvOaB/ZKP42
 Jl9XtMHSsxyMiLAY0xWSEY8s+9ym4eFV00D8gPDKaWHRvFONJTnmAhXljqK1M8vw44g9wc56r
 vH/4TX0scQZjNhCjrBOJMpZxP4s3NpSZHD0gBAiNmuO68j2yza/4suqaE1HhROluu0O/cR4vs
 az7voORq5trmA9sPKJBn+5gt828CE0EZJq+STfUg5J+sqUqYSVDT3zYG7E0fLCFH1dZzl1Tiq
 3dhJpBvt60TorIITEgaZs8t1IMCtAd3jLDmQ66T6MFnmZZKkq2co1wfbLE0UUc3d2UKrbRVZb
 833J9lUD713Bq8xuwKvxiGAhjvy9GDbhNiR7O9Yn5JGSsLM8F4k+Bb2PhYBeYc/GYy7KVPAK5
 oi1FumJmefTLx5thrEarMsthJEqHp/P7Lhf7EcmG+WL7r3h9zW83J3Jt66UEK9LCkIYvGEtmk
 4gxoqk9AHZUvVLQ/BqRlPCfLFAq8vdAxatL7XlVbxva7/eHO2uzR8D9YLYdzPtoRsXrasqAQt
 pbgb7Mv1qC5RIzUomSjhDmhgKU/a0KuVsRZRcUJ5K5jYRukvUPxyoJKCMVqvtUoeTwCSsH2m8
 EjJWcW/drqmvZ3XO/Ee1rEi1lZljaMy7zek9+M8izzMHfQCKQ3K9xz+5wcY0HAQ9dBBGl8x1C
 xc5N58bzd/wDRgP96+yss/4x700v1tJKv/Qu9hcyUiBBJMH6Di2lt6hEc8JX0VK01N4cNxQRU
 qVGraKwn7hSHYjNnDbBJNH0va/J/MQCT6NA55YcKoOxK72kSJjv0XgAVrSAZ2FVR0CsLbmUkC
 yU52MPHEVvtHKmfqxQEuKXGLpUZrh7K22J/gOBiqtCyFx7hp7cenVEj1x0m1u4oJCNr6SX/dd
 hV53AmCfxc3LjARWp0M0bscwPuRtyc+AXGO50vqqAzaJsxj7iTZz+YqmlUZyJmONbkD5hcwEe
 2izzHfuloU+caaDwwQoEPHibB0T3naASsjmVh6h+uXe0T/qP8P0Yfq8ArzGEpc4kDTFTFINcu
 bhbHxRMGfx0GZA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.01.22 um 20:09 schrieb John Cai:
>
>
>> On Jan 1, 2022, at 3:16 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>
>> The problem is that the default value can vary between reflogs and we
>> only know which ones are to be expired after option parsing, right?
>
> That=E2=80=99s a good point. Does it matter that the default value varie=
s between reflogs?
>
> Would something like this suffice?
>
> -       for (i =3D 1; i < argc; i++) {
> -               const char *arg =3D argv[i];
> -               if (starts_with(arg, "--expire=3D")) {
> -                       explicit_expiry |=3D EXPIRE_TOTAL;
> -               } else if (starts_with(arg, "--expire-unreachable=3D")) =
{
> -                       explicit_expiry |=3D EXPIRE_UNREACH;
> -               }
> -       }
> -
>         argc =3D parse_options(argc, argv, prefix, options, reflog_expir=
e_usage, 0);
>
> +       if (cb.cmd.expire_total !=3D default_reflog_expire)
> +               explicit_expiry |=3D EXPIRE_TOTAL;
> +       if (cb.cmd.expire_unreachable !=3D default_reflog_expire_unreach=
able)
> +               explicit_expiry |=3D EXPIRE_UNREACH;

This would ignore --expire and -expire-unreachable options with the
value of default_reflog_expire and default_reflog_expire_unreachable,
respectively.  E.g. "git reflog expire --expire=3D90.days.ago refs/stash"
would not expire anything.

Ren=C3=A9
