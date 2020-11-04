Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5454FC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9B422243
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8yygRVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgKDNdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgKDNdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:33:54 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7294BC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 05:33:54 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id z6so19261292qkz.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 05:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AWX+W/FlXSQIxVwtrFi7YYp77+XbdJxnZ7rh4N0hHaY=;
        b=d8yygRVai3sW80uamB4T8ka0/u4P8CqXT9eZ7g5zYGDeRYKmL7RlW5vq555SHGgieY
         kan5pNG4Zd4pa6/4JHqTmmAyuWyeSKcn9JzwTsM7/O6soXmRqVfaN3BHKD824Nqloem1
         rkCQaNqTKKf5YXUnzWMnEknR3e1Ejk+V2PHiGRJlxgVPopVgsO9aECTnE9XA/n4w26VK
         5EcXMMjWxrZv9/yyHAE9SSZMl38PlnUobZAzA6L8CwkelAAVdIbrkLj2WEVpyFttUUDe
         ZY2LjPcQrkWtZjuZvX5p2JD5TqW3OTZd6my7Ww9m8EZGM3zcdcHzgGuvcl9oXXZKnb/u
         aXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AWX+W/FlXSQIxVwtrFi7YYp77+XbdJxnZ7rh4N0hHaY=;
        b=CPbYlyFcTydvh2W+gxgouWljxTbseWEpCdOw4J/CzXH86w9wBEchoxcvC8UlUP/Nt+
         APTBaVQvQZkOtOSBS2FdDXUft6CT4GKuo+Qr9jK0Y5AMDS8trkh3sOtOjRIgORoy02z/
         3rkLnb5eZHUzLOQ4O+GwTYKECoJHtNd6aiXUlP3nsXczIhLWa3xSArBEcQ6qeaJuLdxk
         HK5eoR3+mw24C0vwFs9j5457gc38ZvE4DMqpYJKhJ+M1adYfxFGcaAVLVpSEyfy/r1Rv
         2ksG2EgNJEn3rHD50S/cB4N3h5cOsoKL1EB2I0Zb7/0Ixb3RJfYh6eGPG7G6Tc7C0bo0
         ou3A==
X-Gm-Message-State: AOAM530HOhV2eOAFSz/jaqWKNfbe/+7NfWYcCh8VdGSJ3L+LSFiv4E4k
        pw80Xh33OElgqX70akf+m0BtAigULkObqA==
X-Google-Smtp-Source: ABdhPJw8ecAzOVnBjMFhhnZI2uObf8GSyEZKQax89JwGQ6N86N9kQaqu4JXj9biEZlS9sD0tNXHsxQ==
X-Received: by 2002:ae9:e902:: with SMTP id x2mr25011548qkf.106.1604496833627;
        Wed, 04 Nov 2020 05:33:53 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id r18sm71786qtp.89.2020.11.04.05.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 05:33:52 -0800 (PST)
Subject: Re: [PATCH 2/3] maintenance: use launchctl on macOS
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <832fdf16872cbfee4a5e15b559b2b40dabd545f4.1604412197.git.gitgitgadget@gmail.com>
 <CAPig+cR1zSqY_y02JBdtjh_+9Pp2dOtGrHHmf-ah5sU6Lhzp6Q@mail.gmail.com>
 <e493b759-4565-e7d2-4a19-dee23c651119@gmail.com>
 <CAPig+cSbNGdRA11cMCugJH1HtY65smfuE9ThARX0EvuQZnA5rA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42151abf-6a1a-d56b-48b8-cf122103fbc5@gmail.com>
Date:   Wed, 4 Nov 2020 08:33:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSbNGdRA11cMCugJH1HtY65smfuE9ThARX0EvuQZnA5rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 5:27 PM, Eric Sunshine wrote:
> On Tue, Nov 3, 2020 at 4:22 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 11/3/2020 1:45 PM, Eric Sunshine wrote:
>>> It's not clear whether or not this is saying that git-maintenance will
>>> dynamically adapt to work with modern and older 'launchctl'. A glance
>>> at the actual code reveals that it knows only about modern
>>> 'bootstrap'. Perhaps this could be a bit clearer by saying that it
>>> only supports modern versions, and that support for older versions can
>>> be added later if needed. (For those of us who are stuck with 10-20
>>> year old hardware and OS versions, 2015 isn't that long ago.)
>>
>> Yes, this is a strange place to be. How far do we go back to support
>> as many users as possible? How many users will be simultaneously
>> stuck on an old version of macOS _and_ interested in updating to this
>> latest version of Git? Is that worth the extra functionality to detect
>> the the OS version and change commands?
> 
> I don't think this patch series needs to answer these questions
> provided that it doesn't close the door to someone adding
> older-version support down the road. My review comment was more about
> the commit message being clearer about the choice -- supporting only
> recent 'launchctl' -- being made by this series. (And perhaps the
> documentation could mention that it requires a reasonably modern
> 'launchctl'.)

Thanks. I'll be sure to make the commit message more clear.
 
>> This makes me realize that I should update the documentation to give
>> pointers for how to view the schedules for each platform:
>>
>> - Windows: Open "Task Scheduler"
>> - macOS: 'launchctl list | grep org.git-scm.git'
>> - Others: 'crontab -l'
> 
> Good idea.
> 
> I haven't looked at the documentation, but if it doesn't already, I
> wonder if it should give examples of how to set these up by hand or
> how to customize the ones created by git-maintenance itself. I was
> also wondering if git-maintenance could have a mode in which it
> generates the template file(s) for you but doesn't actually
> activate/install it, instead providing instructions for
> activation/installation. That way, people could modify the scheduling
> file before actually activating it. However, this may all be outside
> the scope of the patch series, and could be done later if desired.

Outside of the technical details, the biggest questions I've
tried to handle with the background maintenance feature has
been to balance customization with ease-of-use. My philosophy
is that users fall into a few expertise buckets, and have
different expectations:

* Beginners will never know about background maintenance and
  so will never run "git maintenance start" or set the config
  values.

* Intermediate users might discover "git maintenance start"
  and will appreciate that they don't need to learn cron to
  set up a good default schedule.

* Advanced users will read the documentation and use Git
  config settings to customize their maintenance tasks and
  schedule.

* Expert users might decide the task schedule available by
  "git maintenance start" is too restrictive, so they create
  their own background schedule with custom tasks. They might
  not even run the maintenance builtin and opt instead for
  'git gc' or 'git repack' directly!

My main target has been these "intermediate" users who might
run the command and forget about it. However, I've also tried
to keep the advanced users in mind with the advanced config
options available.

Your comment about documentation demonstrates a way to serve
the advanced and expert users by providing a clear framework
for discovering what Git is doing under the hood and how to
modify or adapt that to their needs. It is also important to
demonstrate how to set up schedules in a similar way without
having them be overwritten by a later "git maintenance start"
command.

I will give this a shot in v2. Thanks.

-Stolee
