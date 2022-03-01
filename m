Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D653C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 15:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiCAP07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 10:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiCAP0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 10:26:35 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D8AA9A43
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 07:25:48 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so12463681otl.6
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 07:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XSa4c4q1e0c8TX4HvX5Kp9ZJzxzl8dYsyR55ly0Rxjs=;
        b=aVbWudJyUjGa1mEBsUAdKCHdNdG7uDX7HHiOQCeVkj8pYS2vQeCQPy955aur1L6SaW
         t9I1BsHxyEl1rY5eQOPA5WPOPBIQxSX0jxp3Hj/fsVWEOykGcBcNjF9+X4fgYAW8i9T3
         MipiAbuBx2nnGdcS3LmgGjqNWKEoGBJDS/Pbdp7woDy/u8AgaBxlnxLyqPFXm6xl+Uew
         t6A9K3i6rxVgebMrU78g+N+oJo0FkQ6f3ur+pkQtU6RwZwz/TAvDUfvYmB5gBgeTLnns
         zI53rBW4GFBbMJj9QhpLDqVFaq3O9B44HnCcAGxicqemCTRbhbAQLmuoXdWBrcFZxFWB
         CTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XSa4c4q1e0c8TX4HvX5Kp9ZJzxzl8dYsyR55ly0Rxjs=;
        b=qQHUHZyubnNrV67f6RFVNah+dCXKGvR6h/Xh0zA5i+mwSkxsOFm9AtwsxHknhDLrIN
         B8h40/O2rIUz0BGXGLsrgkQZa1NaVFt2QEoWpl2sQgpctcMepRsfO5860vdQ3K54K0ET
         ta1eCqcFcQedn8YGJXzxOC3R8itIHXxMsLT/Asq8df8UuUR9ipuk5PzwTJSB6vq5tcpJ
         VF68Tw1IUdgyKZ9/9l/Hj5v2EWA97JaAnf9PaQv+jtliCH2qAn01mmwx1Rb8cUkQYqjZ
         EvGXttiO0iVnjLszxHh4E/j3IGsYMNXEnGJ5IqquXDrlV12vNtNEA8smJufLhTKRUcBr
         qkbw==
X-Gm-Message-State: AOAM530rXVl/yIuL4wgX5X23430IjDpzOd90jfwODK9YcfC4uzNxbIz0
        CAAFHBwX19HdLAYK4uQvOBJ1
X-Google-Smtp-Source: ABdhPJzJMjKlmOXXyp26gAFMoAPNRhVzwBw7YeiSANe9p+uwiRatqK8+FYVyb5648Re2Wf/M7QL+qw==
X-Received: by 2002:a05:6830:44e:b0:5af:3b50:8a2a with SMTP id d14-20020a056830044e00b005af3b508a2amr12646722otc.129.1646148348013;
        Tue, 01 Mar 2022 07:25:48 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i3-20020a056820138300b0031c0d227905sm6305149oow.19.2022.03.01.07.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 07:25:47 -0800 (PST)
Message-ID: <1b9912f7-87be-2520-bb53-9e23529ad233@github.com>
Date:   Tue, 1 Mar 2022 10:25:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 3/7] commit-graph: start parsing generation v2 (again)
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        abhishekkumar8222@gmail.com
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
 <a3436b92a32f7f6dd02ad61eb2337a4d088d5e9c.1645735117.git.gitgitgadget@gmail.com>
 <YhzkdMxrIGlNutr6@ncase> <e29ec01f-3039-6992-8ade-800ad32fcf34@github.com>
 <Yhz/hsDDGNVjt64R@xps> <dbb59fe7-4918-50ef-33a6-79eb430445e8@github.com>
 <Yh3rZX6cJpkHmRZc@ncase> <Yh325v3RBDMxjFnD@ncase>
 <f50e74f0-9ffa-f4f2-4663-269801495ed3@github.com> <Yh4zehdSnHLW1HuK@ncase>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yh4zehdSnHLW1HuK@ncase>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 9:53 AM, Patrick Steinhardt wrote:
> On Tue, Mar 01, 2022 at 09:06:44AM -0500, Derrick Stolee wrote:
>> On 3/1/2022 5:35 AM, Patrick Steinhardt wrote:
>>> On Tue, Mar 01, 2022 at 10:46:14AM +0100, Patrick Steinhardt wrote:
>>>> On Mon, Feb 28, 2022 at 01:44:01PM -0500, Derrick Stolee wrote:
>>>>> On 2/28/2022 11:59 AM, Patrick Steinhardt wrote:
>>>>>> On Mon, Feb 28, 2022 at 11:23:38AM -0500, Derrick Stolee wrote:
>>>>>>> On 2/28/2022 10:18 AM, Patrick Steinhardt wrote:
>>>>>>>> [1]: https://gitlab.com/gitlab-com/www-gitlab-com.git
...
>>> So the question is whether this is a change that needs to be rolled out
>>> over multiple releases. First we'd get in the bug fix such that we write
>>> correct commit-graphs, and after this fix has been released we can also
>>> release the fix that starts to actually parse the generation. This
>>> ensures there's a grace period during which we can hopefully correct the
>>> data on-disk such that users are not faced with failures.
>>
>> You are right that we need to be careful here, but I also think that
>> previous versions of Git always wrote the correct data. Here is my
>> thought process:
>>
>> 1. To get this bug, we need to have parsed the corrected commit date
>>    from an existing commit-graph in order to under-count the number
>>    of overflow values.
>>
>> 2. Before this series, Git versions were not parsing the corrected
>>    commit date, so they recompute the corrected commit date every
>>    time the commit-graph is written, getting the proper count of
>>    overflow values.
>>
>> For these reasons, data written by previous versions of Git are
>> correct and can be trusted without a staged release.
>>
>> Does this make sense? Or, do you experience a different result when
>> you build commit-graphs with a released Git version and then when
>> writing on top with all patches applied?
> 
> Just to verify my understanding: you claim that the bug I was hitting
> shouldn't be encountered in the wild when the release , but
> only if one were to write a commit-graph with the intermediate stafe
> until patch 3/4 of your patch series?

That is my claim. And my testing of the repo at [1] has demonstrated
that it works correctly in these cases.
 
> Hum. I have re-verified, and this indeed seems to play out. So I must've
> accidentally ran all my testing with the state generated without the
> final patch which fixes the corruption. I do see lots of the following
> warnings, but overall I can verify and write the commit-graph just fine:
> 
>     commit-graph generation for commit c80a42de8803e2d77818d0c82f88e748d7f9425f is 1623362063 < 1623362139

But I'm not able to generate these warnings from either version. I
tried generating different levels of a split commit-graph, but
could not reproduce it. If you have reproduction steps using current
'master' (or any released Git version) and the four patches here,
then I would love to get a full understanding of your errors.

Thanks,
-Stolee
