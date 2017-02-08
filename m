Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD9D1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751691AbdBHSse (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 13:48:34 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33646 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdBHSru (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 13:47:50 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so12191629pfg.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 10:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tS8vxiJzVdJoyYGnk4gsUA4GWPq+oM1VZ9g3+nfbpxI=;
        b=CwrAcPbAVvAm08SOM67VtpcCse62Haz4AGofRbBPXySJaDOu2I7/3DA5U1wl+Gv3oh
         hFRrekSSlGNLHms/v/OcACxGhUz2DFH+tae6ITkHzryUfWD+cBGXYkt5735hsglh6Wtj
         5k0Ik7+Op+zkVhnudKE7DAYXKxZhSudPWGTm/05Vm04LkXthH7Obgmk3IsrKm6lEjg2O
         N2/gybRA6ADjCi6CLpjc1R7VYYxaYpMa+pNYkd71W4aM2FmHs/B03S7ZV/Kzkz1wkOP9
         kdPgf8PJpX4mjbOW3Hp7umM2ZWfNGhGSGjSD8WMv4+2e2fRs4nYZ1XHUYJBcxmy+O5dF
         /jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tS8vxiJzVdJoyYGnk4gsUA4GWPq+oM1VZ9g3+nfbpxI=;
        b=EvZARi2LOH4lJGdH5rIZggaAIDTbzCi2LN4CKKJiSmD0CJOLFZstxnAcJjXrEGBG6L
         v/ZETbo87zqnQPekVUzJxeNxGtOojdfOF5sBGQLMYd0U1SoRXCaqhhsZ9WyCIJ4MKsIq
         y1Hu1LyH6eEG74FUlQxupeQO5sLpGn1BLv6P1ujQQlJ7c8ugoboYnhQE+2xAEOrkNa53
         zhJCVWWD5VnKbYLZyhvj+J7B5jnYSJCCENUZhiSQSXYAjCBmQsCIRJMtVG1BrBhXTThN
         PUq8icsUAVuJq1mvhhPwmolCbPI0HEbquBaKAeIYzjo/ziMT1EYvNknaF9JXHaoIiKL1
         dhQw==
X-Gm-Message-State: AIkVDXIBGKOdOR38K0D/MOhEpKECV01Sud4rYToS6Po8KmS2KiVuhRP0+mtv615bD+1tfg==
X-Received: by 10.99.111.138 with SMTP id k132mr28980117pgc.138.1486579669707;
        Wed, 08 Feb 2017 10:47:49 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id e13sm22236625pgf.48.2017.02.08.10.47.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 10:47:48 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
Date:   Wed, 08 Feb 2017 10:47:47 -0800
In-Reply-To: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 8 Feb 2017 13:17:02 +0100
        (CET)")
Message-ID: <xmqqh944wmcs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The problem lies deeper, much deeper...
> ... but it bought us many, many problems.

I think you are making a mountain out of molehill here.  
This looks like as an opposite problem of a bug that forgets to
prepend the prefix to relative pathnames given by the end user.

I do agree that some calling scripts may find it more convenient if
the output were relative to their current directory, and in that
sense, this is worth addressing.

However.

How long has "rev-parse --git-path" been around?  Had scripts in the
wild chance to learn to live with the "output is relative to the top
of the working tree" reality?  I think the answers are "since 2.5" and
"yes".

I do not think we can make this unconditionally without breaking
users.  We instead need something like a new "--git-path-relative"
option, similar in the spirit that output from "git diff" can be
made relative to the current directory with the "--relative" option.

Assuming that we are discussing the new behaviour that is
conditionally triggered, let's see the implementation.

> -			puts(git_path("%s", argv[i + 1]));
> +			path = git_path("%s", argv[i + 1]);
> +			if (prefix && !is_absolute_path(path))
> +				path = real_path(path);
> +			puts(path);

Duy, want to help me out here?  I am wondering if using a logic
similar to what is used by "cd t && git grep -e foo :/" to emit
paths as "../Documentation/CodingGuidelines" as relative to the
current working directory is more appropriate than forcing the
absolute path output here (and if so, it may be preferrable to use
the relative_path() helper to do so), or the paths to files in
$GIT_DIR are conceptually different enough from paths to files in
the working tree and it will be more robust to have the output as an
absolute path.

I am leaning toward the latter (i.e. the above use of real_path() is
simple and good), but I haven't thought things through and since we
have an area expert here in the thread...
