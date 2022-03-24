Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003AC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 15:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351265AbiCXP3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 11:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244954AbiCXP3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 11:29:13 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA03ABF41
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:27:38 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so5257903fac.7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R4/7nMAzJF0jgLvIsnq0f2UDpOcQhHDSDVdRCORq+cY=;
        b=CCX//UvWn5yU7Q5cQBp8n2+dnsDXk2RaPTsvTEutmZisMPhEehJ0+SDWB/eGfLeyeJ
         UsPFwrZQWKgwAxd1R0mpxQi4KPB7onYgg5uP+fqx1LY1h5VVFh/jaXxKkEgQeIQdHvct
         fuBWFVl42uosG3bbORr1hTJ4rcMivNLE3m5S7traZjKP0HBtF7Cbr2JQYUTuTamZJhjF
         EH0wVxCbuvnzufYBsC5fA83BeI/dpTTeMuodXS9ey68UZj2BqsRlAv7btPGSsTb2ClBd
         r0TgCSo/B8M9X2Wuf5BRHRmJmVXSJ1jw8Q4ww/WcrKG2bCa2VtbZUQ+N2m8yzNX1H7RI
         1nJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R4/7nMAzJF0jgLvIsnq0f2UDpOcQhHDSDVdRCORq+cY=;
        b=dtq/CJ3YdraUiaCJa1Wut56mKX7IvEDn+VzWcRJ2lnk7nURZw77OYuALP4YMgFsPD8
         qhTt674obzJHyBK1LieKgpkVmKLuHTGKr3dix3tOxUFqrbpd00gAn5AkrMd/U1BHQKHk
         k2mFcO/hG7E6DOf040GTzwN3YX6cItX3fL4rMbAQ9YS2eTzEzGpOr+FHPWmR3LHvcrXx
         PiWrLOEQmqM2XFuIWjQIWWkZ+NdoZiMMsDXUwFv66JpdLhCJ5RrHRKNa9PhRx6cxuZ7A
         UmdmEFLdzhR9TBWakyrvRsoUDRrM3f74AlcEhTjO+5qKzpBjaIFCfIeRu21yAsEjTduk
         0QsQ==
X-Gm-Message-State: AOAM532Ss7+Uekyakh+IeTtN5UopHDDwFxSMSXEazMQrvidF6SEMTau+
        UXsRtMuC+limaKj2BGdifZzF
X-Google-Smtp-Source: ABdhPJwtxIVs6umWn3slDTLGiucSNxgSnklkKaoGa1RB1K6V/4PrC4s+OPyLIk049YpaDIGorgZKaA==
X-Received: by 2002:a05:6870:f10d:b0:dd:de2d:1a47 with SMTP id k13-20020a056870f10d00b000ddde2d1a47mr2771338oac.67.1648135656860;
        Thu, 24 Mar 2022 08:27:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e8-20020a9d63c8000000b005b235a56831sm1453457otl.49.2022.03.24.08.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 08:27:36 -0700 (PDT)
Message-ID: <34da1688-7d94-d54c-6b3a-3106d0f15380@github.com>
Date:   Thu, 24 Mar 2022 11:27:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] commit-reach: do not parse and iterate minima
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
References: <20220323210803.1130790-1-jonathantanmy@google.com>
 <xmqqbkxwp7qp.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqbkxwp7qp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2022 7:30 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> When a commit is parsed, it pretends to have a different (possibly
>> empty) list of parents if there is graft information for that commit.
>> But there is a bug that could occur when a commit is parsed, the graft
>> information is updated (for example, when a shallow file is rewritten),
>> and the same commit is subsequently used: the parents of the commit do
>> not conform to the updated graft information, but the information at the
>> time of parsing.
>>
>> This is usually not an issue, as a commit is usually introduced into the
>> repository at the same time as its graft information. That means that
>> when we try to parse that commit, we already have its graft information.
>>
>> However, this is not the case when fetching with --update-shallow. In
>> post_assign_shallow() in shallow.c, a revision walk is done that also
>> parses commits at the shallow boundary before updating the shallow
>> information (and hence, the graft information). (This revision walk
>> needs to be done before the update because the nature of the update
>> depends on the outcome of the revision walk.) If we were to
>> revision-walk such a commit (at the shallow boundary), we would end up
>> trying and failing to parse its parents because its list of parents is
>> not empty (since it was parsed before there was any graft information
>> telling us to conceal its parents). This revision walk will happen if
>> the client has submodules, as it will revision-walk the fetched commits
>> to check for new submodules, triggering this bug.
>>
>> This revision walk in post_assign_shallow() actually does not need to go
>> beyond the shallow boundaries, so the solution is twofold: (1) do not
>> iterate beyond such commits, and (2) in doing so, we no longer need to
>> parse them, so do not parse them.
> 
> This sounds quite tricky.  In this case we may know which commit we
> need to avoid (re)parsing to avoid the bug, but would it always be
> the case?  It feels almost like we want to unparse the commit
> objects when we clear the grafts information in the previous patch,
> doesn't it?
 
I agree that the adjustment to paint_down_to_common() is a bit too
coupled to this scenario, when we should just trust our commits to
be valid if they have been parsed. We should always be able to
parse our parents.

Finding this bug is interesting, but I agree with Junio that a
better fix would be to "unparse" a commit when modifying its graft
in any way. That will universally fix it for any potential future
commit walks that might be hit due to future code changes.

Thanks,
-Stolee
