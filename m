Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D53A1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfFTOC3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 10:02:29 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35000 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTOC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 10:02:29 -0400
Received: by mail-qk1-f196.google.com with SMTP id l128so1975704qke.2
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UCgR+XE/850W0w6INdm4wv/yI93vykv1S/kvAsXM8UI=;
        b=LLA3YNnxGblDk2kMyVUha0CTBK48zD3Rhye/Rk4F30g+0Lxs+VTbpfyOkcfVosrwPF
         7LacVv7RDkyvOoCzUb8BlAp6GBAFO2BJez1mnLPQBCGWcZ5lg+k01VJxlSnzCiXuJV76
         3/Ek8iGBZbx9rH6JBVZ7hxZ4uMSpaCBhWNroh5/ao+P5NphN+9yGEuU5XR0RHg1ctAvp
         5vAbFbuRamdNzuIAbdzla9JF0kQOrgeezKrmKdsiHYQ8SmXpOFsyLHDM99j5Y7PzBG/s
         nNm5NrA7IpUg69vAyJqp+VJS2LdXlUn6Pbxz+hc4+AiU0VUlW2YrBzspPANU/nWMVDpo
         Sb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UCgR+XE/850W0w6INdm4wv/yI93vykv1S/kvAsXM8UI=;
        b=m9cBfPuumIlqvVTYUITWR54RwoWo54clCBej8yxa1qvwjRCzqbnnLUMYAzznAjvtJx
         jls2Lub/LPE6ZtpYVJL53scLMAhi4upKZWMMhFCz0vo3hB0WyOtcJOQYXjT3lj2+EMpD
         aR6idPwRY+lYdV9cPB6+PwSL+Yrnd0RORcRTFp2KkRgys56BiFCX0+x1yxQYZPkQcQ5e
         ZWL2F7/PTJl7b90QEXlFpsn/1smLrqjV12f/hITAYygLVMyPXAtRkTtPFlNtKVnsUy29
         YYhX4OrP1XgT9Vlr6QjMldO2C/LUmeho0pt2Gb40auAXkSPVkkpSb+YnjgONGsS2TevZ
         uaDQ==
X-Gm-Message-State: APjAAAWDlIczO+yVczoYngjih4Zx/+/jTJo6skvf9Z4hpd3ZAftTH8Ah
        eMgqG55YMJI8bgdIw2eHjCUUV4fi
X-Google-Smtp-Source: APXvYqxraCzaHkM/Oi4V8jQktzdgkOO2a3zAT4I9Vhjuad0UgSoY3Wpg7ExvV0+r35UyLXDQafefcg==
X-Received: by 2002:a37:e506:: with SMTP id e6mr37709832qkg.229.1561039348080;
        Thu, 20 Jun 2019 07:02:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a934:2ce3:312e:b671? ([2001:4898:a800:1010:5a6a:2ce3:312e:b671])
        by smtp.gmail.com with ESMTPSA id s8sm643820qkg.64.2019.06.20.07.02.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 07:02:26 -0700 (PDT)
Subject: Re: [PATCH 2/4] switch: allow to switch in the middle of bisect
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190620095523.10003-1-pclouds@gmail.com>
 <20190620095523.10003-3-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <446ace86-714f-9109-99d8-95554ceaf26b@gmail.com>
Date:   Thu, 20 Jun 2019 10:02:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190620095523.10003-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/20/2019 5:55 AM, Nguyễn Thái Ngọc Duy wrote:
> In c45f0f525d (switch: reject if some operation is in progress,
> 2019-03-29), a check is added to prevent switching when some operation
> is in progress. The reason is it's often not safe to do so.
> 
> This is true for merge, am, rebase, cherry-pick and revert, but not so
> much for bisect because bisecting is basically jumping/switching between
> a bunch of commits to pin point the first bad one. git-bisect suggests
> the next commit to test, but it's not wrong for the user to test a
> different commit because git-bisect cannot have the knowledge to know
> better.

When a user switches commits during a bisect, it can just create new
known-good or known-bad commits, right? It won't mess up the next
selection of a test commit? I'm imagining someone jumping to a commit
between two known-bad commits or something, when it is more likely that
they are jumping to a parallel history.

> For this reason, allow to switch when bisecting (*). I considered if we
> should still prevent switching by default and allow it with
> --ignore-in-progress. But I don't think the prevention really adds
> anything much.
>
> If the user switches away by mistake, since we print the previous HEAD
> value, even if they don't know about the "-" shortcut, switching back is
> still possible.

I tell everyone I know about the "-" shortcut, and I'm always surprised
they didn't already know about "cd -".

> The warning will be printed on every switch while bisect is still
> ongoing, not the first time you switch away from bisect's suggested
> commit, so it could become a bit annoying.

I think a one-line warning is fine, as a power user doing this a lot
will develop blinders that ignore the message as they switch during
a bisect.

-Stolee
