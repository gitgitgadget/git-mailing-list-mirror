Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCC01F453
	for <e@80x24.org>; Fri, 19 Oct 2018 08:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeJSQkV (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 12:40:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35738 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeJSQkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 12:40:21 -0400
Received: by mail-wm1-f68.google.com with SMTP id o17-v6so2117316wmh.0
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JGSQSslEsVSKj59+7E1QS/qTLFYeWbW5cW4C3/Nw864=;
        b=oRNm9I0c25VkBV4gzzMfLEbFYzxNpkMSOFn7+n5NfDRIy9kUUxEC3WeZ6hhjUSx5wx
         JAILatY3gA/Llh8XQQs3JOfelzaeGhapFyfm6hOmTOQwClyumK6xMLjKruuO/f1V5sYP
         CCInkJZY/iK05KKMV52rrT6rS3FWE0GrDnqEOGYh0OLLJVuGWvmcxN+OCZqMQuOUJdXT
         QOVPA5ftFgoPOZl1/GTrrmjTWnPGiKPLhsSFXTjBxZzgdeD1P1vx3hdi5E56bi8YDnU+
         dVvqrWXctv1JWEOACtJXqpqpL/FFo74wzWpHffW+iyMu6PSugdR/rTRXgntc7OXO0Yoa
         0LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JGSQSslEsVSKj59+7E1QS/qTLFYeWbW5cW4C3/Nw864=;
        b=r22XDstXi1Ciln7QEiJHAXBDkZaPKaIVf8000myOP5EYBFfG66haW12PEMPxI6IYaH
         DxnBq4yeWzJXQV3Mm+jSHELVbuHHSZJLVG/uHZkFOXZKWVYpGYOaIa0HkWhMthqDa/it
         UIQkfpoukppRDSb4wNoD8S1SiRIoOdXveiBn1ODPxlEnvgrlNluMtczKGLI5IzrrAfLl
         UqZjunZyxcyNYb6/MyRmxcvaAKPR6FZa3/XJOCGe1+ngxF0Nf01AZ+4pBqi9Q9L9aAiE
         0WAqFcj1/wumk1TDmbUxweCoTzC7y8P8ie+SNYpIMsCN9ZEld5UWF4IWz9QNFd4JpjDD
         tc3A==
X-Gm-Message-State: ABuFfohqnvdSwzn5cxCO0CptF9alXVpGpVa01kM7mAH3jhaPy+nF0S0X
        1530d/UHQ59tIcQjgT3ut/x3UhbQLC4=
X-Google-Smtp-Source: ACcGV62QJ7Ab1RhxiU/UeOIdpiiiGfvQZoSfn7mlCFlPzggiByz0MIpkoPBpCcVvga4lAUhb2Knqmw==
X-Received: by 2002:a7b:c00a:: with SMTP id c10-v6mr3750165wmb.73.1539938115105;
        Fri, 19 Oct 2018 01:35:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g8-v6sm1671305wmf.45.2018.10.19.01.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 01:35:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/13] ci/lib.sh: encapsulate Travis-specific things
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
        <815152e0f57d545ae2fae7429c16e5be497746be.1539598316.git.gitgitgadget@gmail.com>
        <20181018220106.GU19800@szeder.dev>
        <xmqqy3au3d26.fsf@gitster-ct.c.googlers.com>
        <20181019082552.GV19800@szeder.dev>
Date:   Fri, 19 Oct 2018 17:35:13 +0900
In-Reply-To: <20181019082552.GV19800@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 19 Oct 2018 10:25:52 +0200")
Message-ID: <xmqqva5yz64e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> >> +if test true = "$TRAVIS"
>> >> +then
>> >> +...
>> >> +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>> >> +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
>> >> +fi
>> > ...
>
> $GIT_PROVE_OPTS and $GIT_TEST_OPTS, however, are only used in
> 't/Makefile' but not in the build scripts, thus their values don't
> show up in the build logs.
>
> I run some Travis CI builds with custom $GIT_TEST_OPTS, which, of
> course, conflicted with this patch, and I messed up the conflict
> resolution.  I think I would have noticed sooner what went wrong, if
> the value of $GIT_TEST_OPTS were visible in the build logs.
>
> I've found the output with 'set -x' sufficient so far, and don't think
> that an explicit logging facility is worth it.

That's an interesting perspective.  I would have thoguht that the
values of these two variables we can see above, that are constants
without any substitution or customization, are the least interesting
things to see in the log.


