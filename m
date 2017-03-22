Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B697F20323
	for <e@80x24.org>; Wed, 22 Mar 2017 19:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759843AbdCVTsC (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 15:48:02 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:32942 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759616AbdCVTry (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 15:47:54 -0400
Received: by mail-pg0-f48.google.com with SMTP id w20so9668743pgc.0
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 12:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FeAJpO4YWvpWYSghcZpFmoQyRyHXDJHjcqCuogJUvsM=;
        b=otR5TmADtu4Q/f4MJYWKwUSy4/qJqFlWzkw+DtB1bYeN9DttdHSMUEr41au8k/TVqP
         Xcegu4DmeoO1qtEYB+4A5e7F3asVSqWenvQFK0gBZEp+7eS/VvwmCNxHxsbYNrB81JTC
         WDrWjUB+SihNfq8C0iw+YulTavHJqEI5wF8rFwSa8/h/X29UQFd4QOfuzn18aH1YbNIn
         Ge6Y0pZLcc0CFgsQt8dR8aIhEcksiuoM4DQtjySm5JtnT3R3MchCBn5gC+Y/iffwn8p1
         5rEj0NXKR2D89XcCJV4/xCejHgXX9IJH0Q1Ys3m1ro7Lu/brGJK0aV0ROScU6RUNaRt8
         Xdjg==
X-Gm-Message-State: AFeK/H24e4nUjfBbMDXins1p4tYQRGXBaBwZRkwx5slRR/eCbOqZRzuOmrabpHnxmA8aTQ==
X-Received: by 10.84.199.170 with SMTP id r39mr57096812pld.144.1490212073059;
        Wed, 22 Mar 2017 12:47:53 -0700 (PDT)
Received: from darkstar ([97.107.183.15])
        by smtp.gmail.com with ESMTPSA id a78sm5531122pfc.25.2017.03.22.12.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 12:47:52 -0700 (PDT)
Date:   Wed, 22 Mar 2017 12:47:51 -0700
From:   matthew@giassa.net
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: xdiff and "pretty" (human readable) diff output
Message-ID: <20170322194751.tpzsnnuaxgt7jyvt@darkstar>
References: <20170322192340.elg2gpvcshhk3jq3@darkstar>
 <CAGZ79kZ+BGG6yj_rEvjDNf3gmV5KPgvOvLfH94VdPudzbGCkyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ+BGG6yj_rEvjDNf3gmV5KPgvOvLfH94VdPudzbGCkyA@mail.gmail.com>
User-Agent: NeoMutt/20170206 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Stefan Beller <sbeller@google.com> [2017-03-22 12:43:41 -0700]:

>On Wed, Mar 22, 2017 at 12:23 PM,  <matthew@giassa.net> wrote:
>> Good day,
>>
>> I have a question with respect to how git generates "pretty" (ie: human
>> readable) unified diffs. It's to my understanding that git uses its own
>> (simplified/minimized) fork of libxdiff, simply referred to as "xdiff"
>> [1].
>
>correct.
>
>> Which tool/library is used to take the xdiff output and generate
>> the human-readable equivalent that is rendered to the console?
>
>Git itself. Have a look at diff.c (it's only 5k lines of code ;)
>
>Maybe start with fn_out_consume which is a callback (for xdiff)
>that is responsible for pretty printing the output, i.e. transforming the
>output of xdiff according to Gits configuration.
>
>> I have a
>> program that I'm maintaining that currently tracks changes to a couple
>> of "sandboxed" files, and I wanted to add a simple console UI that
>> periodically shows the changes to the files over time and/or dumps the
>> "pretty diff" to syslog.
>
>> over time
>
>So you could use cron for that?
>
>>  "pretty diff" to syslog.
>
>So you want to modify the "pretty diff"?
>Maybe that can be archived by a custom format
>(see the git *log* man page) and doesn't require hacking.
>
>Thanks,
>Stefan

Thank you Stefan. This provides me with everything I need.

Cheers!

-- 
Matthew Giassa
e: matthew@giassa.net

