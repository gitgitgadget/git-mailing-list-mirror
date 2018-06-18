Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D55051F403
	for <e@80x24.org>; Mon, 18 Jun 2018 17:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeFRRFn (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 13:05:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46115 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752835AbeFRRFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 13:05:42 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so17590821wrp.13
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XRELk0ztO8L3Br05aeGxsD7aTenUpdKKDKmfU1jqtB8=;
        b=Tb6xzqUKn7VSRBwVX1WKfcuCYsqGugP9uNjTGO2POCYF2Uyg5ylIx9zGLeDkbk3bHn
         fVHFgJQ1LCtUBQDMXEFI+PvutTTCxz6SgMovVX/iqjGOiZcEjtp0zsLDr+L7PKf2m2oG
         6ydjlQlOGq8jQxPv4mO0VVPX59X6h3ITlnP3ngebqGF8o5VDeU/OL4mXtcJtvoskeWUz
         i3u3JO3LuVe4dMzTpgdeAbuBfoqxX22m6cu2LF8fvRbf4JATaFeUAM+6TZrh5qjTB89o
         SP+2YjUvevDnNGA73gBkMZcaWRh6sedmdcBOyy/Ydsa/f6rMvSjEzrZNCcpl+vVFi/N2
         yJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XRELk0ztO8L3Br05aeGxsD7aTenUpdKKDKmfU1jqtB8=;
        b=g9LeWq/0zf6H54U2sYks7OgKYavA7p8Z4kXJoElicSX6Z2/GaV0Ju4aQk88oOxtMVI
         kk8ldWx5hO+LThUhhg9llO2aIF+9frqAG5cift98O4oQErT8NhPG9gw71Z6rlrkA8tu5
         Y3FhuU882ejtxL8Lmj+Mr44aiVq5dfLYiIVFtcHvmeIEO5alrsrGeCpuQzL/Th2ykyjh
         BOdg+IADQoMTpgORhIFjwUnK+B2KKJf/sUwR5JmwL45mOBAZ1pIVZdjLVDpTv8MWAzEF
         oYygKAsPK1hJ4uw3VJPVqnShV+59qUs7vYBfpbUgWTG9GfigII2C1RGcbDFC1BZqgzsl
         dFeA==
X-Gm-Message-State: APt69E14+GZK0VROHVx3r7dwfjXZSOv3qeuoo9TBR/Oki9IIbmxk5XSC
        sfndCMdJ7PSN2QCXO9w9vmk=
X-Google-Smtp-Source: ADUXVKJ+PIJCSPosYxYjyulIAgOero6GnjpZY8LZ1YwCXA0gs5dCNweIHIGZA5qj/ZR+PCVkdQFe4w==
X-Received: by 2002:adf:ac69:: with SMTP id v96-v6mr10756646wrc.5.1529341541050;
        Mon, 18 Jun 2018 10:05:41 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.gmail.com with ESMTPSA id e2-v6sm18651596wro.97.2018.06.18.10.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 10:05:40 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/3] sequencer: add a new function to silence a
 command, except if it fails.
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180618131844.13408-2-alban.gruin@gmail.com>
 <CAP8UFD1PirEpeVwR=Zr4NAccrt_zGxjZkbDrjXNbQRp49zcjtg@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <17075b2c-93d5-1956-01e5-8e2998327101@gmail.com>
Date:   Mon, 18 Jun 2018 19:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1PirEpeVwR=Zr4NAccrt_zGxjZkbDrjXNbQRp49zcjtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Le 18/06/2018 à 18:26, Christian Couder a écrit :
> Hi Alban,
> 
> On Mon, Jun 18, 2018 at 3:18 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>> This adds a new function, run_command_silent_if_successful(),
> 
> He re the function is called run_command_silent_if_successful()...
> 
>> to
>> redirect the stdout and stderr of a command to a strbuf, and then to run
>> that command. This strbuf is printed only if the command fails. It is
>> functionnaly similar to output() from git-rebase.sh.
>>
>> run_git_commit() is then refactored to use of
>> run_command_silent_if_successful().
> 
> ...here also...
> 
> [...]
> 
>> +static int run_command_silent_on_success(struct child_process *cmd)
> 
> ...but here it is called run_command_silent_on_success().
> 
> Thanks,
> Christian.
> 

Oops, my bad.  I will fix this in a reroll.

Cheers,
Alban

