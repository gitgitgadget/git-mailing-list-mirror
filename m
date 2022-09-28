Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4295FC54EE9
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 01:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiI1BwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 21:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiI1BwG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 21:52:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1F41EF613
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 18:52:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2334804pjq.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nO6XasrQ1rXmLhAPCzVFkn75bVGfShghT78cLTEvkM8=;
        b=OoT3AR/1XksGFSZNVVdg03ux3XZHwadcohWaamJBdLECuzf7Guwe9pHBfjWBE8MhLh
         zNaE0/WR6FFTmAv3cFosUl3ObMjAnYvJ/9GmbHQsuQeHf39KOz4KbgTPR3aaAvjFI6FL
         e6wVpYryknCrFpEyyxxadWItlid0kc//J7j6iJG9nfaBbx5x4sPw93DI2y22PjSJEPKe
         xCK8xLHfHihURqap+ZnU9TEzhKt4+X35huWhh8aE1TOp0Nzps2+gW8m0QfbuvLVKn4xg
         kay0yHK0gUGD0nK9d1KBV0yvh6EFlHSMhcM1OhT9mxzfW+dGEsoMBf/E67xdytcrg2z8
         oH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nO6XasrQ1rXmLhAPCzVFkn75bVGfShghT78cLTEvkM8=;
        b=mDarXNy1dhBeFGpZ62WnqLIJ/aSSXxLr0AevitqmIXiSPVr373KnmhePV4hqkxqm7l
         x3FHvkveHAXpw4pzBvilroIJBHLxbFSkP2N6DXLJ2MCVVsn5oUQaEY8neFtBwv618tAZ
         rESaLwiNx6uQvgWAE+vNmbAwPQQfp7f0+VQabOixmjQCl1mamxUIG8hgKcxXuWQWxjCo
         JbVh04wb4wVzzeZX53JEwIq2jUl6d6U6lbpYlODQs/xo+plr8ZZ7x1CbuSU9MOoFeq8i
         GoddIJWkD4ddeE/9ZtEPc0w42gjZ4UIPND8fSB/ZvYSq4eaLvfK4jRbQRCZbWPRo0B1L
         Jtow==
X-Gm-Message-State: ACrzQf2ei6WtHJDnP1pRX3zyu8RlRpvXl4IJCsjT0rhI9qMZzw+P3Lte
        1CwEriwsQngt9TIUvdf9bquiJyIJWF38
X-Google-Smtp-Source: AMsMyM7yebQPp77wgKYaEBHGj6Jm7VaOK8RvWhAmvBP1WerXk5Wl6GtVjYwgVuEfuaYbayJwcrHG0Q==
X-Received: by 2002:a17:90a:b00b:b0:203:a6de:5b0f with SMTP id x11-20020a17090ab00b00b00203a6de5b0fmr7559522pjq.134.1664329924606;
        Tue, 27 Sep 2022 18:52:04 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b0017870f471f6sm2238282plg.226.2022.09.27.18.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 18:52:04 -0700 (PDT)
Message-ID: <be8f11f2-c4ad-0542-066b-3bbc99a16dae@github.com>
Date:   Tue, 27 Sep 2022 18:52:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: What's cooking in git.git (Sep 2022, #08; Tue, 27)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <xmqqtu4s1q1m.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqtu4s1q1m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * vd/fix-unaligned-read-index-v4 (2022-09-23) 1 commit
>  - read-cache: avoid misaligned reads in index v4
> 
>  The codepath that reads from the index v4 had unaligned memory
>  accesses, which has been corrected.
> 
>  Expecting a reroll.
>  cf. <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
>  cf. <bb3a2470-7ff5-e4a6-040a-96e0e3833978@gmail.com>
>  source: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
> 

How drastic an update were you expecting for this re-roll? To keep the fix
minimal (that is, focused on 'create_from_disk()'), I was planning to just
add some comments explaining the implementation (in response to [1]). If the
goal is to get this merged quickly, I'd want to avoid a larger refactor
(suggested in [2] & [3]), since doing so would either make the
implementations of "read from disk" ('create_from_disk()') and "write to
disk" ('copy_cache_entry_to_ondisk()') different/difficult to compare, or
would involve a more invasive refactor to update both functions [4].

However, if there's no time pressure (after all, this bug has existed since
the introduction of index v4!), I'm happy to do that refactor. It would
expand the series to 2 or 3 patches, but should address all of the
suggestions made so far and make the code overall a bit clearer.

Let me know what you think!

Thanks,
- Victoria

[1] https://lore.kernel.org/git/bb3a2470-7ff5-e4a6-040a-96e0e3833978@gmail.com/
[2] https://lore.kernel.org/git/Yy4nkEnhuzt2iH+R@coredump.intra.peff.net/
[3] https://lore.kernel.org/git/YzH+IPFBGleIsAUe@coredump.intra.peff.net/
[4] https://lore.kernel.org/git/e5954e90-6b5c-46a6-0842-b3d7d1e06b33@github.com/
