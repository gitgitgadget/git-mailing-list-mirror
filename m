Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29F091F463
	for <e@80x24.org>; Sat, 14 Sep 2019 13:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389032AbfINN6k (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 09:58:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42267 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbfINN6j (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 09:58:39 -0400
Received: by mail-pl1-f194.google.com with SMTP id e5so3487270pls.9
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 06:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=aHV4YDbBVq+ZTYNOiJhL+ML1acL+SRcueLSm4p0haP8=;
        b=G+uINyCGmZZT0Zt79cRPXUXmXYMVBij909eHunjGpeU6G0byhKjHk3RHDClnO/kEn3
         FUvmfS9E9UaOjLe/lRMluKK19Z7S9RzrSpqBLvisZVvmEOutfZXlFMKKaHdIgP3KXe1N
         WuLyMiMeEwiOExJ1ZLH7zl/gplyA54bYUfYGtq1KwH+6/HDJj91nyFSsbNziEBSyOXkX
         Fr/tAj/HUPQz3bTosorYYnT80Z1jP6A9ztj6UCO22LnTnBCYoOgSmIlvxoMURiFF38AK
         fuJIDEYFpjPP0eikSFRkz9P7Eymb5lJfD++1MlMz3JNg7jb4E0aLDSmQPUtK4unxHUoN
         wD9Q==
X-Gm-Message-State: APjAAAVTP01LIXba9nJ/CQ/FNuejQSelBupaNvxwUGYpAn9QwRufY2J+
        fKbLrfXmCAO9r4ASndKw4SvtzQ==
X-Google-Smtp-Source: APXvYqypJwXPuk+jsN5ceNpm3YAgheUNd0F0btaLzBR+p0h+t/MyiS7OtwEQLXTzskJo8ktjstbR/g==
X-Received: by 2002:a17:902:d888:: with SMTP id b8mr52732095plz.272.1568469517479;
        Sat, 14 Sep 2019 06:58:37 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id u1sm23487977pgi.28.2019.09.14.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 06:58:37 -0700 (PDT)
Date:   Sat, 14 Sep 2019 06:58:37 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 06:35:40 PDT (-0700)
Subject:     Re: pd/fetch-jobs, was Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
In-Reply-To: <xmqq8sqtgzp9.fsf@gitster-ct.c.googlers.com>
CC:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     gitster@pobox.com
Message-ID: <mhng-2c9b8fd0-22e7-4679-9d9b-f8128881fada@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Sep 2019 11:02:42 PDT (-0700), gitster@pobox.com wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> * pd/fetch-jobs (2019-08-13) 5 commits
>>>  . fetch: make --jobs control submodules and remotes
>>>  . fetch: add the --submodule-fetch-jobs option
>>>  . fetch: add the fetch.jobs config key
>>>  . fetch: add the "--fetch-jobs" option
>>>  . fetch: rename max_children to max_children_for_submodules
>>>
>>>  "git fetch --jobs" is getting taught to also run fetch jobs in
>>>  parallel when fetching from multiple remote repositories.
>>>
>>>  Comments?
>>
>> I still stand by my suggestion that it is undesirable (and makes the
>> code much more complicated than necessary) to end up with three options.
>> Having only `--jobs=<n>` would be the ideal solution.
>
> I think exposing "--jobs" as the primary UI element is a good longer
> term goal; the approach taken in the intermediate step would be a
> necessary one for backward compatibility.
>
> I stopped carrying it in 'pu' some weeks ago (I suspect it had some
> interactions with other topics in flight, by causing either test
> failures or textual conflicts).  Perhaps somebody interested enough
> in the topic can resurrect it.

Sorry, I'm somewhat new to the git development process.  I'm happy to re-spin 
the patch set, I'm just not sure what do to here.  It looks like there are some 
test failures when I rebase to the latest master, which I'm happy to fix.  Just 
let me know if I should:

* Send all 5 patches, under the assumption that the last one will not get 
  merged until some time later.
* Send just the first 4 patches, holding onto the last one for later.
* Send just a single patch, which wouldn't add the --fetch-jobs and 
  --submodule-fetch-jobs arguments.
