Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD8AC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 14:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBIOoV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 09:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBIOoT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 09:44:19 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7982B36FE7
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 06:44:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d14so1981947wrr.9
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC3oyKQOPaf0CvcFQz3nUDo+v2dvSpQtxty3ASCefmk=;
        b=aVBP72iCtHg0gF9hA4ZsRz7IATQFAOv7e4TRc7MdFhVWt4vwhNL920qGVrJOPHA7cv
         eyPlRK9dgkIdFhHHGTUlZu8Hr+Hk+TR3cN/okfrMXai+3FmQojQfEglLWirSJcdobT7+
         Aai+adOzvb1I5DtsfFbKDzYdDmxf4uBlI6QqgpSN6tDm9C6pXZ6H9myQPcs5XG6Y97IH
         fIX6Tu+y5zJxMS2qfJpQTE91yyY1Yl5bMRtkogAkbK3NmduiFWFzCOwX7isMicO93OWt
         72M4ORj8vvZx4ako5HhCHF1caPff/SES59Vkv2SqLqL4CPN0j3PfkNnr84UMVx2IULbD
         aMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC3oyKQOPaf0CvcFQz3nUDo+v2dvSpQtxty3ASCefmk=;
        b=giKe2Fpvj0KoacmaszPXsNdUnDfJzzQTRQkgCDOyVnNmjt3DBxsGF9RMs4p/FwoFwx
         ysqsxqCA154tC3r4WJx8OK9sDBIoMoBcBJjKo5r5aRW5sn4ObKleqvjNFDcmwyo/LWwm
         CsN8fq+NZUPvl60WoQ0/ucg/6kJBS9h5c4LXv+7RYeSIm2W7e9XLs3Yf3dd5/Z/VfREU
         7O6WLzDTvCJ5bx1z6uj1UmvS30D/j5Hl0F+4IMLhCs+JpxgHuwA6sZpmTHpagrMTQ41/
         6wR1CpS0UfiB6abVkJxatdxj46HUlyxyBLCL7OzVTVdJDcU7OZrkUPBLRdIz5jUqGv+2
         oCJQ==
X-Gm-Message-State: AO0yUKWmwlfQQ5EWK4YTj5SPHN0dobVaux8I62MI12af5NaWgivwXPHw
        /HYdzjWRJqyrlMEh8VzCprcfMoRWXGY=
X-Google-Smtp-Source: AK7set/3mYpOFt9KRVXZpHGpy34PhYPqv9qN1gGHc36fAURG7E071VglPtsiQ/67vzHeTOp/V2ayeA==
X-Received: by 2002:a5d:56c3:0:b0:2bc:846a:8ead with SMTP id m3-20020a5d56c3000000b002bc846a8eadmr10929421wrw.37.1675953856933;
        Thu, 09 Feb 2023 06:44:16 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003dc1d668866sm4995295wmc.10.2023.02.09.06.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 06:44:16 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1ddac91b-7552-3e1e-9888-9e21e808104d@dunelm.org.uk>
Date:   Thu, 9 Feb 2023 14:44:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, John Cai <johncai86@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <230206.865yce7n1w.gmgdl@evledraar.gmail.com>
 <B544D9E8-13C4-4682-9BDA-D6E19B51C91D@gmail.com>
 <d18a5c32-2f15-93ad-ccbf-e8f048edb311@dunelm.org.uk>
 <65129323-326F-4E4A-B6F8-06DC3BBE7B58@gmail.com>
 <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
In-Reply-To: <CABPp-BHhhUhRqn=kKcDiV3EMckBSk2EE8TKZ-PoeqTsKWuvAng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 09/02/2023 09:09, Elijah Newren wrote:
> Hi John and Phillip,
> 
> On Tue, Feb 7, 2023 at 9:05 AM John Cai <johncai86@gmail.com> wrote:
>>
> [...]
>>> Perhaps I'm over simplifying but having read the issue you linked to I couldn't help feeling that the majority of users might be satisfied by just changing gitlab to use the patience algorithm when generating diffs.
>>
>> Right, I recognize this is a judgment call that may be best left up to the list.
>>
>> We don't have a way in GitLab to change the diff algorithm currently. Of course
>> that can be implemented outside of Git,
> 
> Well, the below doesn't allow users to make diffs better for
> *individual* files of interest, but if you agree with me that we
> should just make diffs better for all users automatically, it's a
> two-line change in git.git that I'd love to eventually convince the
> project to take (though obviously doing that would also require some
> documentation changes and some good messaging in release notes and
> whatnot).  I've used it for a good long while, and had a few dozen
> users using this patch too, all without complaint:

I'd support a change to either patience or histogram as the default 
algorithm. My personal preference would be for the patience algorithm as 
I think it generally gives nicer diffs in the cases that the two 
disagree (see below, I've tried changing diff.algorithm to histogram a 
few times and I always end up changing it back to patience pretty 
quickly). However I can see there is an advantage in having "diff" and 
"merge" use the same algorithm as users who diffing either side to the 
merge base will see the same diff that the merge is using. The histogram 
algorithm is known to produce sub-optimal diffs in certain cases[1] but 
I'm not sure how much worse it is in that respect than any of the other 
algorithms.

To see the differences between the output of patience and histogram 
algorithms I diffed the output of "git log -p --no-merges 
--diff-algorithm=patience" and "git log -p --no-merges 
--diff-algorithm=histogram". The first three differences are

- 6c065f72b8 (http: support CURLOPT_PROTOCOLS_STR, 2023-01-16)
   In get_curl_allowed_protocols() the patience algorithm shows the
   change in the return statement more clearly

- 47cfc9bd7d (attr: add flag `--source` to work with tree-ish, 2023-01-14)
    The histogram algorithm shows read_attr_from_index() being moved
    whereas the patience algorithm does not making the diff easier to
    follow.

- b0226007f0 (fsmonitor: eliminate call to deprecated FSEventStream 
function, 2022-12-14)
   In fsm_listen__stop_async() the histogram algorithm shows
   data->shutdown_style = SHUTDOWN_EVENT;
   being moved, which is not as clear as the patience output which
   shows it as a context line.

I think there is a degree of personal preference when it comes to which 
out of patience or histogram is best and the user can easily select 
their preferred algorithm so I'd be happy with either.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/CAGZ79kZYO6hHiAM8Sfp3J=VX11c=0-7YDSx3_EAKt5-uvvt-Ew@mail.gmail.com/

> diff --git a/diff.c b/diff.c
> index 329eebf16a..77a46d5b7d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -55,7 +55,7 @@ static int diff_relative;
>   static int diff_stat_graph_width;
>   static int diff_dirstat_permille_default = 30;
>   static struct diff_options default_diff_options;
> -static long diff_algorithm;
> +static long diff_algorithm = XDF_HISTOGRAM_DIFF;
>   static unsigned ws_error_highlight_default = WSEH_NEW;
> 
>   static char diff_colors[][COLOR_MAXLEN] = {
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index b298f220e0..2f663eab72 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -1549,7 +1549,7 @@ test_expect_success 'short lines of opposite
> sign do not get marked as moved' '
>          this line should be marked as oldMoved newMoved
>          unchanged 4
>          EOF
> -       test_expect_code 1 git diff --no-index --color --color-moved=zebra \
> +       test_expect_code 1 git diff --diff-algorithm=myers --no-index
> --color --color-moved=zebra \
>                  old.txt new.txt >output && cat output &&
>          grep -v index output | test_decode_color >actual &&
>          cat >expect <<-\EOF &&
> 
> 
> I used histogram above rather than patience, since (a) it's what git's
> merge backend uses, (b) it produces roughly similar results to
> patience from a user perspective, (c) past testing has shown it to be
> somewhat faster than patience, and (d) we've potentially got some
> leads in how to speed up our histogram implementation from the README
> over at https://github.com/pascalkuthe/imara-diff.  But, if you really
> wanted to use patience as the default, it'd also be an easy tweak.
> 
> Anyway, just some food for thought.
