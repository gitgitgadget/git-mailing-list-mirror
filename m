Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C47E1FAE2
	for <e@80x24.org>; Wed, 28 Feb 2018 00:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeB1AQT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 19:16:19 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34530 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbeB1AQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 19:16:19 -0500
Received: by mail-pf0-f176.google.com with SMTP id j20so285153pfi.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fFDiuCdcdiUJmAbCx7e17ZQjrePQIobGQKLlF93v0IQ=;
        b=lICA+3DnPF8/3/URbrGb+g1XXBOxiwISnANrVZyWNH8obijPlSvKKrn2HN4sVoNWq8
         2a12rjJnoRDB3zgAXTKY9gqUvx1ogEUD61btF6Y827xuPZAXAsDy1ggXjYrC+fecjsmA
         NuFGVtaw16jHPOIrvi2lIqeYDqqOP16etWkU6ofA0ugNMO0J5zKNk5zIxo2R8eRX6V+K
         PInD4n6z3QVabWXiyMQfecjJvoBdYb2FBhY7suUYTHJdUtbC7VfGPDZqINfSHv8/I+VT
         ABSfHzzVJe3aplZ5Mk1Zx87jPV/u1RyvUlelTlqIHT5JkMYPHM6EawVmJGmApqcOycQh
         zFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFDiuCdcdiUJmAbCx7e17ZQjrePQIobGQKLlF93v0IQ=;
        b=R+kMikQh/vfKyEYbSHSK2ljfhQneQiZn329f2IiuIfWSoreVxpmpyww/JyozdVV3XQ
         e0Yvmw3hwEE1GtCmpMdIdq0+8TTpLW1hXqzGwQjINGIee+irgshIHgFHmdBQZxL9MXni
         NbXbHjatK8Eqmrr4aSZcjn9gvWxJDQIys/CftgLIxe6W355d6vGY8LajKXrjQSae74YR
         v1L2cl4DvV+DWdwfnP02ZeKyR++VSlo8UYSLYeyzC5b9b8MnHxEnOqhmaK35YcZx5chh
         pXRmdlUfeGftAMGYa238mz/vB9a86sxsUd2HWgCZjWWcsFUxqcb4NoDSXT/X39TViFnu
         l51Q==
X-Gm-Message-State: APf1xPDI6sAj6MjQ+WY0bCxFcvi/CVjqeJaSGMz5e8737DBqZtJoncs2
        8mn5N97TqxjltFFivx7Bcd4=
X-Google-Smtp-Source: AH8x227cF+KRmNczMf4Wo11Kt/JUIs0M93EFhF7hGRooomPS9qUW3wE3Jn6JmCQfiEDL+ZsWorohiw==
X-Received: by 10.98.242.65 with SMTP id y1mr15445586pfl.232.1519776978456;
        Tue, 27 Feb 2018 16:16:18 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k66sm384023pfb.123.2018.02.27.16.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 16:16:17 -0800 (PST)
Date:   Tue, 27 Feb 2018 16:16:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, 'Joachim Schmitz' <jojo@schmitz-digital.de>,
        Eric Wong <e@80x24.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180228001616.GJ174036@aiede.svl.corp.google.com>
References: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005501d3b025$c0057ce0$401076a0$@nexbridge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Randall S. Becker wrote:

> After months of arguing with some platform developers on this subject, the
> perl spec was held over my head repeatedly about a few lines that are
> causing issues. The basic problem is this line (test-lib-functions.sh, line
> 633, still in ffa952497)
>
>>        elif test $exit_code -gt 129 && test $exit_code -le 192
>>       then
>>               echo >&2 "test_must_fail: died by signal $(($exit_code - 128)):
>
> According to the perl spec http://perldoc.perl.org/functions/die.html, die
> basically takes whatever errno is, mods it with 256 and there you go. EBADF
> is what is used when perl reads from stdin and calls die - that's standard
> perl. In most systems, you end up with something useful, when EBADF is 9.
> But when it is 4009, you get a garbage answer (4009 mod 256 a.k.a. 169).
> However, only 128-165 are technically reserved for signals, rather than all
> the way up to 192, which may be true in some places but not everywhere.
>
> The advice (I'm putting that nicely) I received was to use exit so that the
> result is predictable - unlikely to be useful in the 15K test suites in git.

The fundamental thing is the actual Git commands, not the tests in the
testsuite, no?

In the rest of git, die() makes a command exit with status 128.  The
trouble here is that our code in Perl is assuming the same meaning for
die() but using perl's die builtin instead.  That suggests a few
options:

 a) We could override the meaning of die() in Git.pm.  This feels
    ugly but if it works, it would be a very small patch.

 b) We could forbid use of die() and use some git_die() instead (but
    with a better name) for our own error handling.

 c) We could have a special different exit code convention for
    commands written in Perl.  And then change expectations whenever a
    command is rewritten in C.  As you might expect, I don't like this
    option.

 d) We could wrap each command in an eval {...} block to convert the
    result from die() to exit 128.

Option (b) feels simplest to me.

Thoughts?

Thanks,
Jonathan
