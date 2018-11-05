Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85F61F453
	for <e@80x24.org>; Mon,  5 Nov 2018 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbeKFHWe (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 02:22:34 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:39028 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFHWd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 02:22:33 -0500
Received: by mail-pl1-f181.google.com with SMTP id b5-v6so5110849pla.6
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 14:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdtXNIuTcksGmIjlj8cz1tnB+jGzdP6bCza43SNFyc4=;
        b=RQwJr/MeQZyPYb3mitbeXJ6W4KZ0xVFOgX60pWs+iBDLO2Ttl08J97LI/bUARUwApJ
         Zs1PH7CUBqB488NWQPfKBdiR3Ja4phdqBZdG21CE4inaBbLWhCAr1rTGNQqDW9COMO1v
         3V2rtNHsoW3JfT2f4XizcePs/kophwuc0B+qrUKE2OuKhfqzyuXZ+5OYw7kRnmWUXlZY
         9cTydBRYl5yr8Edo2K3VyGs3+Lkq64Hg37YgFq624uwSgmbwwowB/TfYHLcctGyboQ2o
         oZOACQRd4Zai6L7coj1a+YXFjWgx7PsFGM+oaQrVLTEwlifbv+5TDLPqhrfFzRZ6Ct73
         nbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdtXNIuTcksGmIjlj8cz1tnB+jGzdP6bCza43SNFyc4=;
        b=Bwycp1pwo/T2cpogi5zITbj5xFHSq1DooEaeNq0IlxCdWmHQ4H6ha48922H4lkfJqk
         hbL89EYyM0TAbe6KfIyi1tu/hjgVioeaadm++kKrr1JATmH4KquKTnQsNKJCF7LyUPlL
         3b/EMk4fmsl9PQEdba/FE+TXIRVHoidyZ/8946w3ohGx6l5F4XcToyEreiwm2yjX5fDc
         nna1t33CkVSdJGhVh38s4xtuOwNz/+HUPxbsXG1ywn9TiWXwCMvcXSNsvplIs5vMfxaz
         nBrR6QDrA3L7s5J6XfgnlQv1L104pNbZ+RnOccpBxgfFrWRElW0UZEOFzjLLK8GNyDzk
         Jn/Q==
X-Gm-Message-State: AGRZ1gI289G79aKpOYKt0yEDZLQd6dDayned6kI6uxvvua6hHKQ3gdM2
        WDiRSsrvKc4AfUuGmYy9sHA=
X-Google-Smtp-Source: AJdET5cgyi4t6i5YVQ5cZGNKNSz61dxq8o5voOch1/Lh5NV9WT2ZF7AD0RRQhV/3vUb56s98INzPLw==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14-v6mr7720684plo.133.1541455245294;
        Mon, 05 Nov 2018 14:00:45 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id p6-v6sm7909314pfg.30.2018.11.05.14.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:00:44 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:00:42 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Design of multiple hash support
Message-ID: <20181105220042.GA162375@google.com>
References: <20181105010032.GN731755@genre.crustytoothpaste.net>
 <CACsJy8B+WAyjrthKs9nr=kLpx7f8k_Dug4rRdYDoBR+mmLHCuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8B+WAyjrthKs9nr=kLpx7f8k_Dug4rRdYDoBR+mmLHCuQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:
> On Mon, Nov 5, 2018 at 2:02 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:

>> There are basically two approaches I can take.  The first is to provide
>> each command that needs to learn about this with its own --hash
>> argument.  So we'd have:
>>
>>   git init --hash=sha256
>>   git show-index --hash=sha256 <some-file
>>
>> The other alternative is that we provide a global option to git, which
>> is parsed by all programs, like so:
>>
>>   git --hash=sha256 init
>>   git --hash=sha256 show-index <some-file
[...]
> I'm leaning towards "git foo --hash=".

Can you say a little more about the semantics of the option?  For
commands like "git init", I tend to agree with Duy here, since it
allows each command's manual to describe what the option means in the
context of that command.

For "git show-index", ideally Git should use the object format named
in the idx file.

>> There's also the question of what we want to call the option.  The
>> obvious name is --hash, which is intuitive and straightforward.
>> However, the transition plan names the config option
>> extensions.objectFormat,
[...]
> --object-format is less vague than --hash. The downside is it's longer
> (more to type) but I'm counting on git-completion.bash and the guess
> that people rarely need to use this option.

Agreed.  --object-format makes more sense to me than --hash, since
it's more precise about what the option affects.

Thanks for looking into this.

Sincerely,
Jonathan
