Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39BD202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdKTWcf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:32:35 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41909 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdKTWce (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:32:34 -0500
Received: by mail-pg0-f67.google.com with SMTP id p9so8524251pgc.8
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+gDsdTMYS2ASVdqjGyVjX5YpHrcL1qH1Nino+axxFRU=;
        b=TTRsE9yGXitaJjPLqYDxyG4bB96fCBDq7b+m4UeKRmpGYIYT4XoXeEIo7EVcvE7vu/
         ltSiR16+/K6xAKRxCLuQXQmG6eP/ZuvWOltr01QyOMC65auqOczHl4dFpheWPxG/D6Me
         JmTeHuSJFHrxu/jgscXrdAzTll9AVcUpYAjhq7ujWM+nPh249LOGDkGKXDnsXLX9nnlG
         1G8NHqyNES74r3t2bwUltWPJYoMyGRuIIvO/+9Y9ug3dfRYl0E9unnZv5FdGyYn4cBDh
         bj02Olu4aCLk2HEQZH78ryWcgelzlp1+kBEFe5sGhGcNIzt87kXIH/av0OlnfvLoqntC
         uk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gDsdTMYS2ASVdqjGyVjX5YpHrcL1qH1Nino+axxFRU=;
        b=puTfhHR11Be4/AFrjbQcwIgnFFugSzbQl99R/21SOoQXzXwoaOjHeCuQg8w5JTE9R7
         d7SYOrJRDRTk8nkPEhoSm95LhA2YMTCqp9XcCzfA61syPsAcbaL7bdUxjv1NhWz5F7vf
         q+NlqUGNNPgdX1jb9DXDHIfoeTVTzLzTwEvIVwH5nqmCRu0hKibIgozvVKSrrSnzz/zx
         jdUeTfwZEJv9nyVx6QQivqAzrVqOm52PcwDHC2URMt2qd3hJUdRPbeKwtkjbYr0xwxQ/
         HWTx1+tSjLPKRkt2uh/h9YHUdUrQbPB94kqrTOzoBoUOP1O4vtmTSD1wh7yjgXO/vIhs
         V9JQ==
X-Gm-Message-State: AJaThX7GiJJVCoon29VUV5KxyxMPFZjqNdB8/qW2GjUyWS8D7VKI3dGX
        U3/XXPlp93cm1jwiaLdFn2D+8w==
X-Google-Smtp-Source: AGs4zMahYNonJ6VGrzVoLA/PyorlIVJQdhk3HIlCmWC07we+AmF6zLZZ761f3G/HVnQcZ8qjApPXZw==
X-Received: by 10.99.97.76 with SMTP id v73mr14469940pgb.378.1511217154233;
        Mon, 20 Nov 2017 14:32:34 -0800 (PST)
Received: from google.com ([2620:0:100e:422:255c:f926:518d:9e83])
        by smtp.gmail.com with ESMTPSA id v15sm20079279pfa.50.2017.11.20.14.32.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 14:32:33 -0800 (PST)
Date:   Mon, 20 Nov 2017 14:32:32 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH v3 0/8] Coping with unrecognized ssh wrapper scripts in
 GIT_SSH
Message-ID: <20171120223232.GG92506@google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Jonathan Nieder wrote:
> Previously: [1].
> 
> This version should be essentially identical to v2.  Changes:
> - patch 1 is new and should fix the test failure on Windows
> - patch 2 is new, discussed at [2]
> - patch 5 split off from patch 6 as suggested at [3]
> - patch 6 commit message got two new notes to address the worries
>   from [3]
> 
> Thanks for the helpful reviews, and sorry to take so long to get this
> out.  Thoughts of all kinds welcome, as always.

Just finished looking through the series.  Looks good overall!

Thanks again for getting this out!

> 
> Sincerely,
> Jonathan Nieder (8):
>   ssh test: make copy_ssh_wrapper_as clean up after itself
>   connect: move no_fork fallback to git_tcp_connect
>   connect: split git:// setup into a separate function
>   connect: split ssh command line options into separate function
>   connect: split ssh option computation to its own function
>   ssh: 'auto' variant to select between 'ssh' and 'simple'
>   ssh: 'simple' variant does not support -4/-6
>   ssh: 'simple' variant does not support --port
> 
>  Documentation/config.txt |  24 ++--
>  connect.c                | 322 +++++++++++++++++++++++++++++------------------
>  t/t5601-clone.sh         |  69 ++++++----
>  t/t5603-clone-dirname.sh |   2 +
>  4 files changed, 265 insertions(+), 152 deletions(-)
> 
> [1] https://public-inbox.org/git/20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com/
> [2] https://public-inbox.org/git/20171115202516.hduhzsgeoff5a22b@aiede.mtv.corp.google.com/
> [3] https://public-inbox.org/git/xmqq60b59toe.fsf@gitster.mtv.corp.google.com/

-- 
Brandon Williams
