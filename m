Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74769C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 13:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjBDNN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 08:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbjBDNN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 08:13:56 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD0C2A9B0
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 05:13:54 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id o1so2954081ioo.10
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49BXmvV6pgFjtJbG/BEQTTXAokTEAU8cdo9GlWhxGyo=;
        b=QMchzSXhsBRuselK+20AjW9Lwjdwc1b+gCXd++LQu0agUkTEmBKMSEK29nlg03R9GT
         yziIwSgWboRK5asDHbzg/VpG7v4gtvh2nH+U0vXIRyioQzq+FUNHwAv5b5IhQb9xDziz
         SS+gt58xaHimLIUfT4G2LVT7sc0VRG+r+86GJyFF5Zv8NcIwAgv6o5El/QAOQJbV21pw
         y4Evf1hpC2cMgsUdC4BDkxaUfv15YqgQ30ifWgXylBCncAjG/wzgsiFVSjZj5wc9BeX3
         kiFSstFR4ZEn0vfjF7OoXK62YieSEqCAkidNhdMPG2B7xiucJ2roReaan3c5TTGjqW5u
         WA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49BXmvV6pgFjtJbG/BEQTTXAokTEAU8cdo9GlWhxGyo=;
        b=TwAMbuIuTf4RFwMIknjSpp6Asc0DYH3SImhIQ5K8ml+jTxJaJv/9rgT7PeMbQ9/UrB
         FTC9pt7O353hwS18FbMj6EiRBvL7DJo+T+92sfsu1bEn2Y9NIsl9GrLfC9YBQb+d6ajF
         z/iZLIsThsAVhWDco5nQ6CrMbHSNe6S3bxi5z+grFGCJFAqm+kKc1OErAjReUztSfe14
         XKTchDFMEzlqn1hR7UwAN4NIFLA5um8sO1pMBXH85inBQF5FjABvmU3dfAdMIlGCC4iD
         1dNHS+5tedIqKB7OIZl3tzrwoITxqkKDZbrhtB7jMuGDUD1w6/C7m1/5m8GIVZGMKLqs
         2/HQ==
X-Gm-Message-State: AO0yUKWX7nUcCtjZ++RcbChBmIwTmUUS8Fs17ZmBi9Uu8oubiraDHC4V
        Pj28kM1XxaCAkGFjjTakgxq85e49VpiJcU8UGF/D+g==
X-Google-Smtp-Source: AK7set+DreAxQfYEpRZ5MlZA2kE/b8mdQJRLPlCZDsiOuRf2J6WlWRfzsKl1NNpYx2CaO1rNrYVSZg==
X-Received: by 2002:a05:6602:1587:b0:721:90c5:7d0e with SMTP id e7-20020a056602158700b0072190c57d0emr11344005iow.9.1675516433248;
        Sat, 04 Feb 2023 05:13:53 -0800 (PST)
Received: from [10.4.18.48] ([191.101.157.6])
        by smtp.gmail.com with ESMTPSA id e23-20020a6b6917000000b0071e72958095sm1541384ioc.52.2023.02.04.05.13.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 05:13:52 -0800 (PST)
Message-ID: <fa2abffa-1a35-367c-d59b-257c37d18a5f@gmail.com>
Date:   Sat, 4 Feb 2023 14:13:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: The sad state of git.wiki.kernel.org
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
References: <20230203182255.lqla3hsme6riy4w7@meerkat.local>
 <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <Y95BEaOGJy9uBHkG@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02/2023 12:27, Jeff King wrote:
> On Fri, Feb 03, 2023 at 01:22:55PM -0500, Konstantin Ryabitsev wrote:
> 
>> Today, most information found on the wiki is probably outdated and therefore
>> potentially harmful. I would like to solicit ideas what to do with this
>> resource.
> 
> Yeah, my assumption is that it's totally out of date these days. I admit
> that's subjective and maybe there are people maintaining/using it. I
> kind of suspect not, though (and if they don't reply to this thread,
> perhaps we can assume they don't exist, or at least not connected enough
> to the development community to matter).

My knowledge of MediaWiki is not good enough to give a definitive answer,
but it seems that active editing stopped at the end of 2021.

One of most actively edited articles seems to be "GitHosting":

   https://git.wiki.kernel.org/index.php?title=GitHosting&action=history

It seems that it is mostly edited by editors who are promoting Git hosting
they are affiliated with. Article "Interfaces, frontends, and tools" also
got a lot of edits in 2020 and some in 2021:

   https://git.wiki.kernel.org/index.php?title=Interfaces,_frontends,_and_tools&action=history

Diff of the latest edit on the article "Git" is a bit telling:

   https://git.wiki.kernel.org/index.php?title=Git&diff=31274&oldid=8420

Website https://git-scm.com existed in some form since at least 2008,
current website's initial commit dates to 2012-03-06, but the article
"Git" on the wiki didn't have a link to it until 2019.  The article also
hasn't been edited at all between 2010 and 2019.
