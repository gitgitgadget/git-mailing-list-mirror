Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8021F9AF
	for <e@80x24.org>; Mon, 30 Jan 2017 21:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754472AbdA3VKb (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:10:31 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36354 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754303AbdA3VKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:10:30 -0500
Received: by mail-yb0-f196.google.com with SMTP id o65so2152274ybo.3
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=GoPgSznzuMFY2DLmxxTAWDYyPgg3VMsIt1LxGkTnV+c=;
        b=TVE4U5yJ3JYptojzNI6APVj4BAmCrdCX8lcI45xwiEbPfhDI311BPi5UhXfues1Vgl
         PQMCh4+luE1zxZKHM59t26ajYUIo1n0QNWXwDuv9qanp5CTyGoz+37oAL3X2/+Pzbz3J
         mcKSKJ85kNSgwF1w7px/EGhyuXOnjPZqkKqgSF3MeDcex3sPmwt4kZXEnvTH0hS/tjg+
         ut1eZoYh30OsyVIfGiJF6p40Ci2id3Xje2TBpGkjI6YJkG6XqCcmZzT+GxHQ9kW0G6Ud
         ybsJ2ZkvYllZbOndkbW9HI21kaPc2otnyxdlKNCymYYKyuyaRM+AVpcIHIEVVAUpuXtP
         U6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=GoPgSznzuMFY2DLmxxTAWDYyPgg3VMsIt1LxGkTnV+c=;
        b=t0KM0zSufxTgcqQdU9DlJsXKGX3aNWWu4yfI83FwEhKxiw5AofPL02sk9DNYrxyJHs
         oZ7kQkG5LX0p0VNBGEqFl+TYuP+xonN7csFliZlHoWAr9JYacG8Jdw6nbvLeYt9tlKzO
         gikznSyAmUCB+LyxqBl1PZP5mzSYXMJC4tzM/Kn79hLd3dRxo+D+IG/MF0R15Rxr9sLh
         AW0G+luBCKB7KwacWLeSf7EZbTrDpgM4pDSBBNwS+x+19Ox8RqouvNFmbw5MP/aDljA/
         4UJFB/N82t9lvLhd2EQ2d+oEldy7l8QNhAIrYo6BOkaBQ+qrGpWQeDr0J2UbkOfUToWp
         oVmQ==
X-Gm-Message-State: AIkVDXJQh53pTvkHFhpqwnI1M9afbLlZgwtbce455QSKfuvBfhyGhBNeukIIOiRyo97d4w==
X-Received: by 10.13.204.23 with SMTP id o23mr15246851ywd.47.1485810621474;
        Mon, 30 Jan 2017 13:10:21 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id h185sm5664905ywe.26.2017.01.30.13.10.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 13:10:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/4] introduce new format for git stash create
In-Reply-To: <20170129201604.30445-4-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 29 Jan 2017 20:16:03 +0000")
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170129201604.30445-1-t.gummerer@gmail.com>
        <20170129201604.30445-4-t.gummerer@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
Date:   Mon, 30 Jan 2017 13:10:19 -0800
Message-ID: <xmqqbmuouudg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>  create_stash () {
> -	stash_msg="$1"
> -	untracked="$2"
> +	stash_msg=
> +	untracked=
> +	new_style=
> ...
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		-m|--message)
> +			shift
> +			stash_msg="$1"

	${1?"-m needs an argument"}

to error check "git stash create -m<Enter>"?

> +	if test -z "$new_style"
> +	then
> +		stash_msg="$*"
> +	fi

This breaks external users who do "git stash create" in the old
fashioned way, I think, but can be easily fixed with something like:

		stash_msg=$1 untracked=$2

If the existing tests did not catch this, I guess there is a
coverage gap we may want to fill.  Perhaps add a new test to 3903
that runs "git stash create message untracked" and makes sure it
still works?
