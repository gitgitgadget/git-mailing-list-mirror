Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27174C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 20:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjAMURy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjAMURv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 15:17:51 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A15E094
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:17:49 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s3so14476216pfd.12
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i3t37IK+sA57LiOLFTbhdfZd16AJM9nTXxSYnnE7CpY=;
        b=EMD81Sa4qEx1zmdOQt8gZrJDTP79h/Qx+4Ec9fNygvvPtYILSrthcew33S1lrlB6Xh
         QYFPJeeq02PVUjUtU/xcsWI/3ZJ0cdlP28nuciHZEl4bw1iJU30hCH0J/DCBJBRHn1AH
         obCrokBbpMvlSLR9sVxUfpJLkg+TozbOR0IEhTOKffYcwyKnzYF2KUMT0x9Su9q4pmZv
         OJGfkrCsn2SJ4findF5ATMVDRMHHCzvJHy0qMZqmFMnA3xd9OzunGWDG1HeReiB22Gqm
         rLkCBvPL//8MkZi2koHoDL6Hh3cl6MvjXCdqAdxkjmYRTKRhp8hAwRdw38C5cAHkFIno
         /9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3t37IK+sA57LiOLFTbhdfZd16AJM9nTXxSYnnE7CpY=;
        b=UrImdJZ7Ojn+oAWI9HudRPyJFSN2aNWdLSHt39GENFFRDWTfcCOP8l8uVo11eyIGZp
         jqDuDkbse6H1VaZFWTYuIITeELv7GSvl+GvHsp/3PcgK+HgxkWBjBKwX39k/yY/2A9Ij
         aZfriCfJUGLT4uD152hY2vWSWp2jkVmmsCSc75tkqvLkeSf6Sa7tyhwgAn7yYv74ypOw
         pGK4MjrP/Yta2fG4ZeUJlcHbQNegoPYY2bLEZQwZ4d0HyNRaHX5MtFQJggpWU9NFnTBs
         L0vp1rbIyp33a+osryRfTIh0dGSW0oiVxywSVquZVlbl12A8Pz3ZylSo075i2hkQimLj
         pF1w==
X-Gm-Message-State: AFqh2ko3ElIlt00wJqRxq9OnRsP4eOwCfCbFi4zgTpY+1Gckj+wIhFCl
        gg8irBXo5wyARPOyqfdcFFs=
X-Google-Smtp-Source: AMrXdXtMQIy3sqNJh7gOzSUlreYjan6BJd8d2Tis2GQRuDcFMaaIaI4Esq7fsz/VEqfTViXJi1qmgA==
X-Received: by 2002:a62:1c90:0:b0:58b:a309:b7c7 with SMTP id c138-20020a621c90000000b0058ba309b7c7mr7843108pfc.16.1673641068393;
        Fri, 13 Jan 2023 12:17:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c132-20020a621c8a000000b00589a7824703sm9022675pfc.194.2023.01.13.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:17:48 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] env-helper: move this built-in to to "test-tool
 env-helper"
References: <Y71qiCs+oAS2OegH@coredump.intra.peff.net>
        <patch-1.1-e662c570f1d-20230112T155226Z-avarab@gmail.com>
        <Y8A3yGeJl0TCDNqe@coredump.intra.peff.net>
Date:   Fri, 13 Jan 2023 12:17:47 -0800
Message-ID: <xmqqpmbi195g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I am totally fine with this direction. My reservations were:
>
>   1. It was work somebody had to do. But now you've done it.
>
>   2. It's _possible_ that some script somewhere is depending on it. But
>      I think the "--" in the name plus the lack of documentation means
>      that it's unlikely, and that we're morally absolved if somebody's
>      script does break.

That's how we burned some folks who depend on submodule--helper,
isn't it? ;-)

> The patch itself looks obviously correct to me.

>> -	test_must_fail git env--helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&
>> +	test_must_fail test-tool env-helper --type=bool --default=false --exit-code MISSING >actual.out 2>actual.err &&
>
> Long lines like these made me wonder if it should simply be "test-tool
> env", which is shorter. We do not need "helper" to avoid polluting the
> main git-command namespace, and everything in test-tool is a helper
> anyway. But it probably doesn't matter much either way. It's not like
> that line wasn't already overly long. :)

I agree that the "-helper" looks a bit irritating, not because the
line is long, but because test-tool is by definition about helpers
used in tests, so the suffix is redundant.

Let's have a small update before queuing it.

> If we do take this, then my t/interop patch can be dropped, though we
> might want to salvage the error message bit:

Yup, that does make sense.  Will queue what is below the scissors
line.

Thanks, both.

>
> -- >8 --
> Subject: [PATCH] t/interop: report which vanilla git command failed
>
> The interop test library sets up wrappers "git.a" and "git.b" to
> represent the two versions to be tested. It also wraps vanilla "git" to
> report an error, with the goal of catching tests which accidentally fail
> to use one of the version-specific wrappers (which could invalidate the
> tests in a very subtle way).
>
> But when it catches an invocation of vanilla git, it doesn't give any
> details, which makes it very hard to debug exactly which invocation is
> responsible (especially if it's buried in a function invocation, etc).
> Let's report the arguments passed to git, which helps narrow it down.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/interop/interop-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/interop/interop-lib.sh b/t/interop/interop-lib.sh
> index 3e0a2911d4..62f4481b6e 100644
> --- a/t/interop/interop-lib.sh
> +++ b/t/interop/interop-lib.sh
> @@ -68,7 +68,7 @@ generate_wrappers () {
>  	wrap_git .bin/git.a "$DIR_A" &&
>  	wrap_git .bin/git.b "$DIR_B" &&
>  	write_script .bin/git <<-\EOF &&
> -	echo >&2 fatal: test tried to run generic git
> +	echo >&2 fatal: test tried to run generic git: $*
>  	exit 1
>  	EOF
>  	PATH=$(pwd)/.bin:$PATH
