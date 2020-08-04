Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC3C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F3E206DA
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 17:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWiPzdUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgHDRvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDRvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 13:51:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0FC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 10:51:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so28469340qto.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 10:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uzw3qAAAtY/2y3itPtNlzWsszKTN5kkdANQJ68AHQxg=;
        b=aWiPzdUQHAgVkYaQYgqOt8xYvWJCZCextohpzD2gS73a734Rig6SbFkByQvQrElgpq
         6GNd/B3DU0kpiCFDPdKnMxsG/ZSQKCCEF6tLoULNSAQmNF+O+YNSCCoomMEMKbDL/AZj
         Yj+RnHQkHoU2QwswbihbSPLJOfCF72oGiyFBD2vY3RmkyKcL+8eDYDy2v25o9ZsbGfxU
         2tjG4zjjCFQIXzGEgLXZlqvCfIPp+o7VRChs0QG2XyBndLk7O+BcubGBsqJ48OG+HHYa
         6wxg645UFTqu/hd4ykZN11FLI5iJDvK7A189H4Ad2jhqgzgZ9teTdrDGvgWaRZLUp93k
         EPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uzw3qAAAtY/2y3itPtNlzWsszKTN5kkdANQJ68AHQxg=;
        b=ttmRt7Kut4CKxhruncv1bDaFYWewcsywL9qtzDFmNLt4jNmmHvI+JPXO73s4RZdgk+
         ZbdSca1+MdH4SduYsZTrCRVZlr98gWLpLSBZ8W4tclfYntQ4CgKpX/FtN8r6K6Z6kHcd
         VYim9654LacWl1RJxE+N2HvVJR05SZ37Pkb/NQhTq7/KkaWCvuA4dfkctSJzytIxO9jJ
         X/YKWTCQ79zBqPc50WlLbI5AWJBxkz55yRKnWnpjV6nyM1LhtI9SAxixb2QBVd/Vzw3O
         Ipb1wvCF1JQjIWcA3NGyxW/KtUkD6vNADCPrTO93DnJTqg3a8uCkcRrr711jKvdR/zHM
         U3Aw==
X-Gm-Message-State: AOAM5307ZGBFpZli8uJv739Rv/Id5xsbDG7PlTi3Bw/L58LkB8Fllmu2
        O6b+EDp9tmtqM68e9ZfCEnk=
X-Google-Smtp-Source: ABdhPJy6A5amjEkwT8QVy0NZL6WxVrKg0K6G3M8XJLCgEAgAwgOYuw9fx72O+OIh7vfTyhTbbEsfRA==
X-Received: by 2002:ac8:7650:: with SMTP id i16mr22335541qtr.215.1596563503966;
        Tue, 04 Aug 2020 10:51:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:2c68:49ab:a5c1:6501? ([2600:1700:e72:80a0:2c68:49ab:a5c1:6501])
        by smtp.gmail.com with ESMTPSA id b23sm22346896qtp.41.2020.08.04.10.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 10:51:43 -0700 (PDT)
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com> <20200803224631.GA73022@syl.lan>
 <20200803230134.GA58587@google.com> <20200803230814.GA73765@syl.lan>
 <20200803231745.GB58587@google.com>
 <aac90dbd-e885-f366-1056-0824b8b8b8fe@gmail.com>
 <20200804144208.GA227292@google.com>
 <2b6da345-d004-1d83-78cd-3f1ceaf278d9@gmail.com>
 <20200804170220.GB227292@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dd6a6434-d1cb-f933-3a3e-0f8c09a46ffb@gmail.com>
Date:   Tue, 4 Aug 2020 13:51:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200804170220.GB227292@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2020 1:02 PM, Jonathan Nieder wrote:
> Derrick Stolee wrote:
> 
>> Here is my attempt so far:
> [...]
>> 	test_subcommand_called "gc" run-no-auto.txt &&
>> 	test_subcommand_not_called "gc --auto" run-auto.txt &&
>> 	test_subcommand_called "gc --quiet" run-quiet.txt
> 
> I like it.  Some tweaks:
> - can simplify by using 'printf' instead of sed
> - passing the trace in stdin
> - following the convention that helpers like test_i18ngrep use of
>   accepting ! as a parameter to negate the exit code
> 
> That would make (untested)
> 
> # Check that the given command was invoked as part of the
> # trace2-format trace on stdin.
> #
> #	test_subcommand_called [!] <command> <args>... < <trace>
> #
> # For example, to look for an invocation of "git upload-pack
> # /path/to/repo"
> #
> #	GIT_TRACE2_EVENT=event.log git fetch ... &&
> #	test_subcommand_called git upload-pack "$PATH" <event.log
> #
> # If the first parameter passed is !, this instead checks that
> # the given command was not called.
> #
> test_subcommand_called () {
> 	local negate=
> 	if test "$1" = "!"
> 	then
> 		negate=t
> 		shift
> 	fi
> 
> 	local expr=$(printf '"%s",' "$@")
> 	expr="${expr%,}"
> 
> 	if test -n "$negate"
> 	then
> 		! grep "\[$expr\]"
> 	else
> 		grep "\[$expr\]"
> 	fi
> }

This works! Thanks. With the ! usage, I think a rename to
'test_subcommand' makes sense. Further, I was somehow wrong
about not including "git" in the beginning, so here is my
example use of this method;

	test_subcommand git gc <run-no-auto.txt &&
	test_subcommand ! git gc --auto <run-auto.txt &&
	test_subcommand git gc --quiet <run-quiet.txt

Thanks,
-Stolee
