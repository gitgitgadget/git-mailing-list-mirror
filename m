Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C7AC433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 03:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiGODPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 23:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiGODPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 23:15:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F92974792
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:15:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p81so3008431iod.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 20:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wHon6WuKcQmb4Yd30gc7fyXhQ5jvQ22QJq7CwBkVy/o=;
        b=OY3d2dWHXG9SnXPNaLsdDV3CpJI29mguu60LbZGJwFSJSAbZoKibeJeRPosoxNxiXO
         nuiBILHoy74VsLM6d3n3YbYkK1HGg3Ojxdua+buC7+TQiVoWibZ0J4tGtHC6Ec5eytna
         FB3kuW9kiy6B+JplGkEax5M5TqSrZZz36iqDOVj+uq2VFgHs5vXsvqykZiu/z2F2qc4f
         zpiIyzrk7qzYOqiTrsFc/BU1M2yGLHVEV+wUdlMBCDnRM1hHRj4i1k9cvnQF0xIe8TJb
         MNHVuK3WOpN8WMXAY0dg/d3CV4pwzYuUvFlvL3Ay9BMjhpt6nEMct6wKbrmJ7zvPzhlk
         Wyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wHon6WuKcQmb4Yd30gc7fyXhQ5jvQ22QJq7CwBkVy/o=;
        b=TFQpDtC4McR2MPkLEwVhpnHhRl52lasroPubarBPpmXzBzzbbcW4yTqWlzzSF4mvsf
         9ntNJBa53EuQkH5JGQ1WiUgrKhFWZ6pCzzhXy18Gl5mG6ybpEQHoCKrCkHdDbC5iSggQ
         hFz1CL25Cm8rLDY/7u5yaU6g1M0G6xjX5qLWlrdJjiASyvgRKKEgMRq8oFZPkT0OikH/
         RTblolAx90o9DMHO87wOHrto8GBC1R+N3mHUL6uhpaYWCJOltbS9aMy54kPAmcUxwRFh
         TgiQVDwSUIvcyzxD2E6tC7R0fDlJ+dmMVI2hnNviS15mvK52gOzu9eWUKz2ImaAmgyQv
         6+hg==
X-Gm-Message-State: AJIora8AG5qvdaHYvDcXifXjGAj1j/C20IsH6cWdp1NFZ61pKWW2XgHI
        UtHMm9kdQj7wcSgrrxctFa1U
X-Google-Smtp-Source: AGRyM1tTB7OXuNT1VGoY3raGPP28OhlSJyimmQ0TYza+p377UioH8fVaNvo7itogcaqOJwWJX2t1Jg==
X-Received: by 2002:a05:6638:3709:b0:341:471c:4c64 with SMTP id k9-20020a056638370900b00341471c4c64mr1964612jav.226.1657854944436;
        Thu, 14 Jul 2022 20:15:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a446:d79d:69be:6b29? ([2600:1700:e72:80a0:a446:d79d:69be:6b29])
        by smtp.gmail.com with ESMTPSA id x17-20020a056602211100b006694bc50b82sm1551117iox.35.2022.07.14.20.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 20:15:44 -0700 (PDT)
Message-ID: <10d12d6f-6d86-743f-518b-eb45871509a7@github.com>
Date:   Thu, 14 Jul 2022 23:15:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] t5318: demonstrate commit-graph generation v2
 corruption
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, ps@pks.im, wfc@wfchandler.org
References: <cover.1657667404.git.me@ttaylorr.com>
 <0a49c86037bac200bb23e1abf9f67363e99c4b7c.1657667404.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <0a49c86037bac200bb23e1abf9f67363e99c4b7c.1657667404.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/12/2022 7:10 PM, Taylor Blau wrote:
> When upgrading a commit-graph using generation v1 to one using
> generation v2, it is possible to force Git into a corrupt state where it
> (incorrectly) believes that a GDO2 chunk is necessary, *after* deciding
> not to write one.
> 
> This makes subsequent reads using the commit-graph produce the following
> error message:
> 
>     fatal: commit-graph requires overflow generation data but has none
> 
> Demonstrate this bug by increasing our test coverage to include a
> minimal example of upgrading a commit-graph from generation v1 to v2.
> The only notable components of this test are:
> 
>   - The committer date of the commit is chosen carefully so that the
>     offset underflows when computed using a v1 generation number, but
>     would not overflow when using v2 generation numbers.
> 
>   - The upgrade to generation number v2 must read in the v1 generation
>     numbers, which we can do by passing `--changed-paths`, which will
>     force the commit-graph internals to call `fill_commit_graph_info()`.
> 
> A future patch will squash this bug.

Thanks for finding a good test.

> +		# This commit will have a date at two seconds past the Epoch,
> +		# and a (v1) generation number of 1, since it is a root commit.
> +		#
> +		# The offset will then be computed as 2-1, which will underflow

I have verified that your test works, but this explanation is confusing me.
"2 - 1" is 1, which does not underflow. There must be something else going
on.

Looking ahead, you describe the situation correctly in Patch 3 to show that
we take "generation - date", so you really just need s/2-1/1-2/ here.

> +		# to 2^31, which is greater than the v2 offset small limit of
> +		# 2^31-1.
> +		#
> +		# This is sufficient to need a large offset table for the v2
> +		# generation numbers.
> +		test_commit --date "@2 +0000" base &&
> +		git repack -d &&
> +
> +		# Test that upgrading from generation v1 to v2 correctly
> +		# produces the overflow table.
> +		git -c commitGraph.generationVersion=1 commit-graph write &&
> +		git -c commitGraph.generationVersion=2 commit-graph write \
> +			--changed-paths &&

Simple and fast to set up and test. Thanks for using the config explicitly
in both commands so it is robust to possible default changes in the future.

Thanks,
-Stolee
