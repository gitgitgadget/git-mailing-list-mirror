Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF5C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbiEIRFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiEIRFn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:05:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606A017B84F
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:01:49 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id o11so11636628qtp.13
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H+Rpej5SyhkOonXIgHaKPQIAcI/s5UVUHx2yDttNyUA=;
        b=k8nSuh02849Qad3aT2faEB6iIL53lD9GxNTxzZpo/excD3uXQ3zP398xlGDjZcTL4y
         tfid3bZhoNaWMh6sY2iziqKGWYaLD77o88c4gXRhqcXLD+vdtTf1GVHUKFQbKcSod7cE
         CYi5JdXUacb2l8IE1xLgk1pembnRtiPLcTBLXBbjiktk1okM5Is0isZlz2B4NxtMActm
         Wix17NneY9QCzOCps/IxqEk9p8Zgm8rn07OPh/Mccxj8RMhL3nJzHLSX1+I3rTiCCqIK
         urrOjwzVsYAMlQYbZ2ntofcGUjxAA8yOY454Tk5VS3iWJvW8nIVAcFVfcc3Yv8jCLIh2
         vxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+Rpej5SyhkOonXIgHaKPQIAcI/s5UVUHx2yDttNyUA=;
        b=1YmWFaqyOF+umzYrkgbaH4fmbYKA0flElWvyM7gKbRxlFnHjiixOLs0/R6ItFNmKQl
         QmwQoa400gP3qIM05vAD6RZlg7hRoS0AGn0qmlpDRqdheTJbf3X9tRyRANkfIMEzpK5N
         Ln2y2B8AxyUyztOLJCty0OLLcHAahRiZfDdqF7nihco80znTAHOW7J6DwmCuWzCfkSVo
         G3yv+YqmQTWompHE9Az+IKOGJgInDGTHg1U8+QqWqnmkC01/QYthvZUeUI3t1ouJ2pi5
         j3NHGzupbTGQ5aw6AfWqCFFtN0WUw0ZTPKnC6D9ZQyISsva4QlI4oxU2NdhPGHPVZUOc
         LmnQ==
X-Gm-Message-State: AOAM533pQM0z6mPNrOO54ThjrnFVgwb2Xhazz6iBnQhxdbrv3GiAOBd9
        QuzI37XguYhWTzyIlrq2A5Y=
X-Google-Smtp-Source: ABdhPJxik5oUmhZyS0cnFu8vjpJIMtnXd5KULX/+2Su1KGO4o9Z26QWuok0zD93YHKknk9YEB5EBgw==
X-Received: by 2002:a05:622a:58d:b0:2f3:cceb:d9ab with SMTP id c13-20020a05622a058d00b002f3ccebd9abmr12633366qtb.36.1652115708316;
        Mon, 09 May 2022 10:01:48 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id g15-20020ac87d0f000000b002f3e127be41sm733771qtb.20.2022.05.09.10.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 10:01:47 -0700 (PDT)
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
To:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
 <pull.1227.v4.git.1652095969026.gitgitgadget@gmail.com>
 <Ynk0mADTSJU/xVUd@nand.local>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <54aee42d-fe78-eef1-a371-7ca310a9319f@gmail.com>
Date:   Mon, 9 May 2022 13:01:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ynk0mADTSJU/xVUd@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Le 2022-05-09 à 11:34, Taylor Blau a écrit :
> On Mon, May 09, 2022 at 11:32:48AM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
>> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>>
>> `git remote -v` (`--verbose`) lists down the names of remotes along with
>> their URLs. It would be beneficial for users to also specify the filter
>> types for promisor remotes. Something like this -
> 
> This version looks like it has addressed many (all?) of the comments
> previously discussed during review. On a quick scan, the code and tests
> look good to my eyes, too.
> 
> But there was a good question raised by Phillip in
> 
>     https://lore.kernel.org/git/ab047b4b-6037-af78-1af6-ad35ac6d7c90@iee.email/
> 
> that I didn't see addressed in your response, which was "why not put
> this behind a new `--show-partial-filter` option"?

I originally opened the issue on GGG that this series adresses.
My justification, and asnwer to that question, is simple:
'git remote -v', for me, is a way to ask Git to give me all the information it 
knows about my configured remotes. That's why I thought that it would 
be really nice if partial clones filters would be shown. 

After all, 'git remote' is listed in the 'porcelain' section of the 
Git commands [1], and isn't the goal of declaring commands "porcelain"
that we can make their output more useful to the users without worrying as
much about backwards compatibility than with plumbing commands?

> I share (what I think is) Junio's feeling that having information that
> is readily available from e.g., running "git config --get
> remote.<name>.partialObjectFilter" seems redundant. I could understand
> forcing a user to know the config key's name feels like a hurdle. But
> cluttering the output of `git remote -v` seems like the wrong solution
> to that hurdle.

As I said above, I have 'git rem' (my alias for 'git remote -v') in my muscle
memory and use it when I want to have an outline of my configured remotes.
I think it would be really easier to add the filters info to the existing output.
It's really faster to type than using 'git config', and you do not have to remember
which remote name to query. I think "clutter" is a little strong word here :)

> But I can see where it _would_ be useful. So it would be nice to be able
> to turn the extra output on in those cases, but _only_ those cases, and
> a flag would be a nice way to go about doing that.

If really this topic is blocked by "we do not want to change the default output
of 'git remote -v'", then I agree it would be nice to be able to set 
'remote.showFilters' (or similar) to get such output, I agree.

Or, making 'git remote' act like 'git branch' and accept a second '-v', i.e.
'git remote -vv' would list filters (then I would just adjust my alias :P). 
Then we can outright declare "the output of 'git remote -vv' is subject to 
future changes to show more useful information", or similar, so we do not
have to do the same dance the next time we want to add some other info.

The downside of hiding such new features behing config values or additional flags
is that it really, really limits their discoverability. This is something that I 
often think about and think we should really do better in Git, in general. 
For example, features like 'remote.pushDefault' or the 'diff=*' attribute
for language-aware hunk headers (and funcname-limited log/blame etc) are immensely 
useful, but often even experienced and long-time Git users do not even know they exist, 
because they are not covered in "regular" Git tutorials...

Cheers,

Philippe.

[1] https://git-scm.com/docs/git#Documentation/git.txt-ahrefdocsgit-remotegit-remote1a
