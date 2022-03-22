Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C3C433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiCVSld (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiCVSlc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:41:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C17E089
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:40:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bi12so38218711ejb.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=seM1BTIL/QxR5rviyUBDjhayvo1WcZ5u0RE5A1R00Rc=;
        b=HgW19hzuewhyPSA9kOW2gXmU8xYLAAjfwTqaJYKRYWxFYtv8+LkJ0te27bxD2hz92z
         slgTgs6twCFB/CjOxOpouGwciHNMXN5t31A/rtkgr/8fLO8Yqf+PJUE108iFVVnQGmBW
         YzRIPIVp66iAmImeTt1bYqXGQzYS8niGa1UYx53XERUATzUFgjBrjW3EMBNQgtu33+NJ
         ojQWjr1KhOXK+ZSA+/KHAHyo0ds+YctkZy5JU57A0Ea0Nfk1Plnwpjg6NJxAEqkqNQiW
         64XuVY4fQkaPdrONh/Ob3wTY21atl8x6RgxXcRIRsxlIzX5QF+rGgNNQjYZz/wxBX7yX
         UFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=seM1BTIL/QxR5rviyUBDjhayvo1WcZ5u0RE5A1R00Rc=;
        b=KBIagXWTba9COxXB4in6gtpaj278m0+zgyBPO0sd0umhNJWThUjww1agcsHkmFwoUw
         NyhiyFgHriZDP1jULIn0cSL60ABTz1qW4WYf+dqdAA0+0sFEn6cBOgtiVoASWkNDOC5R
         P5oqoye7J2fEc1HAWJ5ikO5e3MpRXDW6HdR3CTpPamwL12XjQ9SA2Cy5RW+KC0sBwhck
         lfKTXEcOU4XaiCjFxgd0KLhwT27I3eY2I9ITVQkrjnuMvXAC3Y8036b9kEzuqehY9TCI
         Gt3XEpu1qVcSFmn9xkkh23ZBaaNMNTvuTpzP6eonJ61ryLISZeY54vjGtqJbGYeTVrtO
         iaig==
X-Gm-Message-State: AOAM530UbX3oogywaRZ265piSCOO1KYmLBLtVyZ0jnDjuFV6QxPMrAe7
        X783H5LxNvH/QLaPIIkfGmS/TVElX85osQ==
X-Google-Smtp-Source: ABdhPJwPWvMUVvk7buQmRU0ukkK7reoyr02LT2eh9baluDJmESZlJ3FvIfGqgr49EZMprV4teMrXJg==
X-Received: by 2002:a17:907:a421:b0:6da:b635:fbed with SMTP id sg33-20020a170907a42100b006dab635fbedmr28266665ejc.91.1647974402319;
        Tue, 22 Mar 2022 11:40:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906728800b006e0351df2dcsm1680280ejl.70.2022.03.22.11.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:40:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWjQH-000CLO-3a;
        Tue, 22 Mar 2022 19:40:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 21/29] t7527: create test for fsmonitor--daemon
Date:   Tue, 22 Mar 2022 19:35:27 +0100
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <4a920d0b54a25a442bf52efc171139c698d59dc7.1647972010.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <4a920d0b54a25a442bf52efc171139c698d59dc7.1647972010.git.gitgitgadget@gmail.com>
Message-ID: <220322.86a6dhq1a6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t7527-builtin-fsmonitor.sh | 501 +++++++++++++++++++++++++++++++++++
>  1 file changed, 501 insertions(+)
>  create mode 100755 t/t7527-builtin-fsmonitor.sh
>
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> new file mode 100755
> index 00000000000..d79635e7596
> --- /dev/null
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -0,0 +1,501 @@
> +#!/bin/sh
> +
> +test_description='built-in file system watcher'
> +
> +. ./test-lib.sh
> +
> +if ! test_have_prereq FSMONITOR_DAEMON
> +then
> +	skip_all="fsmonitor--daemon is not supported on this platform"
> +	test_done
> +fi
> +
> +stop_daemon_delete_repo () {
> +	r=$1 &&
> +	test_might_fail git -C $r fsmonitor--daemon stop &&
> +	rm -rf $1
> +}
> +
> +start_daemon () {
> +	r= &&
> +	tf= &&
> +	t2= &&
> +	tk= &&

I think these all have &&-chains added since previous versions, good...

> +	while test "$#" -ne 0
> +	do
> +		case "$1" in
> +		-C)
> +			shift;
> +			test "$#" -ne 0 || BUG "error: -C requires arg"
> +			r="-C $1"
> +			shift
> +			;;
> +		-tf)
> +			shift;
> +			test "$#" -ne 0 || BUG "error: -tf requires arg"
> +			tf="$1"
> +			shift
> +			;;
> +		-t2)
> +			shift;
> +			test "$#" -ne 0 || BUG "error: -t2 requires arg"
> +			t2="$1"
> +			shift
> +			;;
> +		-tk)
> +			shift;
> +			test "$#" -ne 0 || BUG "error: -tk requires arg"
> +			tk="$1"
> +			shift
> +			;;

But (and IIRC I noted this in a previous iteration) if you &&-chain the
"shift" here you can lose the more verbose BUG

> +	start_daemon -tf "$PWD/.git/trace" &&

FWIW having an option parser take -tf to mean --tf is quite unlike our
common conventions, usually it means both -t and -f.

In this case every single caller added here does provide -tf
argument. Perhaps better as as unconditional $1 then?


