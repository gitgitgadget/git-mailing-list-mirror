Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F50C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 02:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhLJC3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 21:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhLJC3p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 21:29:45 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E6C061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 18:26:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x10so8230475edd.5
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Bcw/AFWh03miGrmuxH4HH1Ni1Yo+JnYuGL5Wj2AAYyM=;
        b=auhYF62tceM8t6NRnuVF3t2mBIV9kpxRyK/UEVEnP3YuWWDBtowjvHI4K2W8N2vXXn
         AVZjgrhbFAFw9jTUYEFCsbbzgNtFRuEPw9x3oV3z6+g0bbOzhhy/seHYyQt+fjDxoea2
         AMdJ+xmpVgDrxJ9md3f0c13/8YookpGwA9mW8ct7LCyyxUkC3DDe93cDNcgLEwcRoGET
         OnGoCNEQ8Lx7vRKv5MzSpqyaEtC17ZsbxghvaBISpcYJer0Uz5BBb3Fdzboi3u36mtlo
         HOx2ZPsy6zloIkuiVa+HAOlTvV4ykWsLLQ1kLX/57tcb2TEwtES7TBLp2hVz7bNDwYXB
         wWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Bcw/AFWh03miGrmuxH4HH1Ni1Yo+JnYuGL5Wj2AAYyM=;
        b=njqBqTg4v3gUmOZv9kf5eyHhdKFdUG2q3t0n+4bbSZ5BG0T5YFTXBgRuNei5brOcJm
         Up508vZrjpXBj0pXJDWsY5xnKWg7ZNSWnjRUXf2vaRg4oUFtTY1tSa2g4853Kyebbtd9
         Iemdty1ci2lAuzooWDvK03Wn9PbYWlOoZJ2pHXTbbXwIaB+LBPV4zq2Y8d33ng1Prfoe
         IQPHy7uOqF3ql1BYYyMN1Gqfpc8rQyw2oZwU00SYKhP7UZkGeYF9gaDP6DygUrkFopgV
         8Qej3tCqBzQFbG2/FM6YgCZPpbdDyjcmTGRKUbk2okG2+VGpycC6M4hNq1wOB/OKrQ7G
         dk+A==
X-Gm-Message-State: AOAM530SurzejwCabE1+EbtglvjTAXhQOp2UoyEDb15Gz8K23und/f+1
        XhPSv8UcCYuyiPa/NtcPcRlu9AaebqzPPg==
X-Google-Smtp-Source: ABdhPJz0HTFokaroKMM5LJCDT9uo1GSFXIuG3byXZhlZFnCq1kPjlHeptCWAHiQck6tmO9/UpDFSiw==
X-Received: by 2002:a50:fb09:: with SMTP id d9mr33231136edq.283.1639103169429;
        Thu, 09 Dec 2021 18:26:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sb19sm707881ejc.120.2021.12.09.18.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:26:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvVbs-0009WB-1Q;
        Fri, 10 Dec 2021 03:26:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] branch.c: replace questionable exit() codes
Date:   Fri, 10 Dec 2021 03:21:58 +0100
References: <20211206215528.97050-1-chooglen@google.com>
 <20211209184928.71413-1-chooglen@google.com>
 <20211209184928.71413-6-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211209184928.71413-6-chooglen@google.com>
Message-ID: <211210.86ee6ldwlc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 09 2021, Glen Choo wrote:

> Replace exit() calls in branch.c that have questionable exit codes:
>
> * in setup_tracking(), exit(-1) was introduced in 27852b2c53 (branch:
>   report errors in tracking branch setup, 2016-02-22). This may have
>   been a mechanical typo because the same commit changes the return type
>   of setup_tracking() from int to void.
>
> * in validate_branch_start(), the exit code changes depending on whether
>   or not advice is enabled. This behavior was not discussed
>   upstream (see caa2036b3b (branch: give advice when tracking
>   start-point is missing, 2013-04-02)).
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> I don't know what the 'correct' exit codes should be, only that Junio
> makes a good case that the existing exit codes are wrong. My best,
> non-prescriptive, choice is 128, to be consistent with the surrounding
> code and Documentation/technical/api-error-handling.txt.
>
>  branch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 305154de0b..ad70ddd120 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -324,7 +324,7 @@ static void validate_branch_start(struct repository *r, const char *start_name,
>  			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
>  				error(_(upstream_missing), start_name);
>  				advise(_(upstream_advice));
> -				exit(1);
> +				exit(128);
>  			}
>  			die(_(upstream_missing), start_name);
>  		}
> @@ -398,7 +398,7 @@ void setup_tracking(const char *new_ref, const char *orig_ref,
>  		string_list_append(tracking.srcs, full_orig_ref);
>  	if (install_branch_config_multiple_remotes(config_flags, new_ref, tracking.remote,
>  			      tracking.srcs) < 0)
> -		exit(-1);
> +		exit(128);
>  
>  cleanup:
>  	string_list_clear(tracking.srcs, 0);

Junio noted in <xmqqbl1tcptq.fsf@gitster.g>:
    
    This is not a problem with this patch, and it should not be fixed as
    part of this series, but since I noticed it, I'll mention it as a
    leftover low-hanging fruit to be fixed after the dust settles.  The
    exit(1) looks wrong.  We should exit with 128 just like die() does.
    Issuing of an advice message should not affect the exit code.

I think it's good to fix these inconsistencies, but also that we
shouldn't be doing it as part of this series, or does it conflict in
some way that's hard to untangle?

FWIW the former hunk is a perfect candidate for the new die_message()
function[1]. I.e. we should be doing:

    int code = die_message(_(upsream_missing), start_name);
    if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
        advise(_(upstream_advice));
    exit(code);

That we print an "error" when giving the advice but "fatal" when not is
really UX wart, and also that the exit code differs.

The latter should really be "exit(1)", not 128. We should reserve that
for die(). FWIW I had some local hacks to detect all these cases of exit
-1 via the test suite, they're almost all cases where we want to exit
with 1, but just conflated an error() return value with a return from
main() (or exit).

1. https://lore.kernel.org/git/cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com/#t
