Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0343C47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C4A613D7
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 10:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCKua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 06:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCKu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 06:50:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BBC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 03:48:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o2-20020a05600c4fc2b029019a0a8f959dso3427542wmq.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=upyiABi3b0UJIymqO1qa0jyDVFJTvUyYb1IdWP+VL7o=;
        b=UV6ay3E2OFSEzmr7Y8flKJCkjeOxmYgJ1QOo8LjfeaRCp76Px4qxmoSOQV3nlactn4
         fDO+95hTeNfpkzVXJXfx7NPTvPPiB9RKXDA3QJTEIXsBEM/VOvNHQlacP3yC+uuGskzM
         Eh8f4kLZ8JysqWaywCY7BzpqBLzmFv/240PMR9LNz/F2JLuWc9Mhmq60RXvkIibu4Jdk
         aLa9OTWk2ukHzyhkHBN8JaVP5TgiQeBH1GaYTtUHXRs6a4ZYq2gZ08ptGu34IK354dWz
         X/gKthhjJCnfo7sYqvG3fL6eOjRjAGOeFz3wRTcMI9/a9cvwwdIEBnq/Ulki6NHG2t+a
         qNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=upyiABi3b0UJIymqO1qa0jyDVFJTvUyYb1IdWP+VL7o=;
        b=Ri9yoMj94PjDQh0s24EkCSB6SIUIXisD+3qZBOewWtDl2nTA3JemY0DaDp6PFlbCrP
         Px7r7OcgCLnppyzxrD7x8JgxDLp+E56KWdH0fyG1LfXMPSba0LBIoCgw7T4tHzML/Ah4
         rTwExtIahW4pMgPb3P1w1I3kkWUM8CiyfWNkpuknnfgsgg2iCGomzaz7NjD877M2LKOV
         UfpPEYpn/lCPj+SJZvgSGNHwW2XBTzOKwkP6IbTVNpJD1k+ndgW5oVIh4vNmgVlpgnwD
         OkXwNzgFG9T6AxOeOnddr7p0vAR8jxZkk97b264D3edn4bfJdW7MuQv5i3Rim7csr0/D
         k8Gw==
X-Gm-Message-State: AOAM532cDBtDvdoHHmiSbqSe63oeCIMGcrIasPzQ8wKwjRS10PtG49iA
        z8g6cHoRbnec5/I4/gRQnS2JDerGpgx0nkI1
X-Google-Smtp-Source: ABdhPJyh7Ws5JGA5qOE0x9hbPSZBLPQg8ix9wnnzWhgF2q0/25FWSArWHFbBWMpnaZMEm1mloeTwzQ==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr9710360wmk.118.1622717323911;
        Thu, 03 Jun 2021 03:48:43 -0700 (PDT)
Received: from ?IPv6:2a02:587:4411:d162:1434:d44f:5b63:4717? ([2a02:587:4411:d162:1434:d44f:5b63:4717])
        by smtp.gmail.com with ESMTPSA id q11sm2443014wmq.1.2021.06.03.03.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 03:48:43 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_Request_feature=3a_=e2=80=93no-submodule?=
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
 <YLfqiLbpPXWXHlBi@nand.local> <xmqq8s3r7oma.fsf@gitster.g>
 <YLg/dLqYFEqHZJUn@nand.local>
From:   Ilias Apostolou <ilias.apostolou.zero@gmail.com>
Message-ID: <9cc98ca3-bdc5-61bf-450a-99bb47673d6c@gmail.com>
Date:   Thu, 3 Jun 2021 13:48:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLg/dLqYFEqHZJUn@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reason we need to list all of the true files (except submodules) is 
for code refactoring using the sed unility, for example:

git ls-files | grep -Ev '(png$|ico$)' | xargs sed -i 's/\r\n/\n/'

All of the other alternatives we could think of are very ugly.

On 3/6/2021 5:33 π.μ., Taylor Blau wrote:
> On Thu, Jun 03, 2021 at 09:55:57AM +0900, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>>> In all honesty, though this seems like a niche request for ls-files to
>>> fulfill, ls-files already has quite the collection of options, so I
>>> wouldn't be sad to see it learn how to do this, too.
>> I would be somewhat sad for two reasons.

In my opinion, this should be a feature for "ls-files" only, since it 
would be nice to have a clean stream of true files.

Thank you for your replies,
Ilias

