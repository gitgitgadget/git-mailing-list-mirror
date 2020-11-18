Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D55C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 21:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56519246B8
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 21:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GanyT3/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgKRVQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRVQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 16:16:58 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77DCC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 13:16:57 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id u23so1812894qvf.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 13:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kez0lM9wPAlzUX23qiXJVBixe7g+9qsjG0Ejv7MEKRs=;
        b=GanyT3/buLEsSo0hKQdEQoc0HaMWmnW3Wpe9vO6uFhYl4YXQRR4QU4D5cxiOdihBHp
         EbEgVP44X4r3tzoxaVEmPviHstdlIEUMjGVXmIDvIzo+74P5Bi8HPuj0HulECnQhJH3B
         C4JbHo3zckzJYh/KdQ4gjPF536cJBT8tdB6btvXv7AFRH+euLnA0uDXqt2d7VHaZ7n6U
         RSnIKbyoSM5ibnOAXWgYzphtK2RYGrTwsUWKNkf6FVONoy2Z7QFYrFa/G2CGYYcJyUGL
         L7j4px8h74BcZbF0+21gVH0eLbgltnQMwnWZtV+LUilwWgfBWFG6DhjgaS3D1ZJx7qCe
         IjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kez0lM9wPAlzUX23qiXJVBixe7g+9qsjG0Ejv7MEKRs=;
        b=s0XZzWtLdnnyPV/6TClQXk8o3IqQHHlhYwEQoF/u2rEbT4y2vPUxPdRayTAdgboWLH
         aGhiu3lAwKTwWMpRY7LQgXyTvy7r3JGVLSFAFxBQJZ+6iG1JHwuRPu3BKHPfTyqv1ZX5
         X2h5EbL1EE7KuyJWiuBHnT4sDVYIDQvwHYIj1J/nxPlSDGkBrU03yl4Sylhl0K8UPhHQ
         68FyHzZTwsTifYZWtZgjYrzumxz+rrbWOI2UfM7IA1Nr1OUTeuDa3+UiH1vhcsFJFRgY
         wwXr9enVELGQIxuplv+aI6yTzzwlbwl9hYXjSQCGdK9ybUMhEQ+glOxpyv+RwY15QVwO
         Pa3w==
X-Gm-Message-State: AOAM533U785b2JJa+tcRrXiYo1O4rvYGrWNIjMTRpLb1jNt+Sitf7Swt
        ryGq3XSY+UKwUmbExUif90wTdQvBM4AGDw==
X-Google-Smtp-Source: ABdhPJxsWQNgqzUNDbFKIwXHwt3I1mLgDTkMI3Qui95FiaYM+RX1ZlqRdmSM5mkkkJycKxC/DGiIlw==
X-Received: by 2002:a0c:fb06:: with SMTP id c6mr7030755qvp.10.1605734216907;
        Wed, 18 Nov 2020 13:16:56 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:805f:b8ae:cbb3:6b01? ([2600:1700:e72:80a0:805f:b8ae:cbb3:6b01])
        by smtp.gmail.com with UTF8SMTPSA id s27sm17384159qkj.33.2020.11.18.13.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:16:56 -0800 (PST)
Subject: Re: [PATCH v4 4/4] maintenance: use Windows scheduled tasks
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <pull.776.v4.git.1605647598.gitgitgadget@gmail.com>
 <b8d86fb9832b59884d3d38791de252dcb71e3629.1605647598.git.gitgitgadget@gmail.com>
 <CAPig+cRFQfg-NLx5dO+BjQpYduhOYs-_+ZRd=DhO8ebWjGB0iA@mail.gmail.com>
 <e8922076-1ed4-b540-f1c9-9b4a8fa7a085@gmail.com>
 <CAPig+cQt+RFpikr-8cXfLtsXapS4tK4gufKZa-U1yN-ynJbiow@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4ab08301-274a-cd38-ab19-5bad55ec4df8@gmail.com>
Date:   Wed, 18 Nov 2020 16:16:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQt+RFpikr-8cXfLtsXapS4tK4gufKZa-U1yN-ynJbiow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18/2020 3:54 PM, Eric Sunshine wrote:
> On Wed, Nov 18, 2020 at 1:30 PM Derrick Stolee <stolee@gmail.com> wrote:
>> On 11/18/2020 2:15 AM, Eric Sunshine wrote:
>>> On Tue, Nov 17, 2020 at 4:13 PM Derrick Stolee via GitGitGadget
>>> <gitgitgadget@gmail.com> wrote:
>>>> +       xmlpath =  xstrfmt("%s/schedule-%s.xml",
>>>> +                          the_repository->objects->odb->path,
>>>> +                          frequency);
>>>
>>> I missed this in the earlier rounds since I wasn't paying close enough
>>> attention, but placing this XML file within the object database
>>> directory (.git/objects/) feels rather odd, even if it is just a
>>> temporary file. Using the .git/ directory itself might be better,
>>> perhaps like this:
>>
>> It does look odd, and in this case we could use the .git directory
>> instead. I specifically use the objects directory for the maintenance
>> lock in 'git maintenance run' to allow maintenance to run when
>> GIT_OBJECT_DIRECTORY points to an alternate, allowing us to maintain
>> object databases that don't have a full .git directory around them.
> 
> I guess I'm confused. Won't a Git "common" directory exist even for
> such a case when GIT_OBJECT_DIRECTORY is pointing elsewhere, whether
> the "common" directory is .git/ or a bare repository, or whatnot?

The reason to use the object dir for the 'git maintenance run' lock
is to avoid multiple enlistments pointing at a common alternate from
running concurrent maintenance on the same object directory.

That doesn't really apply to the temp files in this patch.

> Anyhow, this brings us back to my original suggestion of creating
> these temporary files in a genuine temporary directory (/tmp or
> $TMPDIR or $TEMP) instead of arbitrarily choosing a path within the
> repository itself. An important reason for using a genuine temporary
> directory for these temporary XML files is that it makes it less
> confusing for those who come along later and try to understand this
> code; they won't have to puzzle out why it is using a repository
> location for a file which is clearly temporary.
> 
> To make this really simple, you could use one of the
> x?mks_tempfile_t*() functions from tempfile.h which will automatically
> place the file in $TMPDIR, thus relieving this code from having to
> make the choice. Doing so would simplify this code even further since
> you would replace create_tempfile() with x?mks_tempfile_t*(), and
> wouldn't have to maintain (or free) `xmlpath` manually.
> 
> As for the test script, the `print-args` is already picking up the
> pathname of the temporary file specified by the /xml option, so it
> should be possible to make the rest of the test work with the
> generated temporary filename.
 
I'll adopt your recommendations here. Thanks.
-Stolee
