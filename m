Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4B01F453
	for <e@80x24.org>; Thu, 18 Oct 2018 02:01:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJRJ7S (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 05:59:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43073 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeJRJ7S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 05:59:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so31768645wrt.10
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PhQBBU4nj+qMFvNV2GhIVih0V2IID3LhgyylS0lNDiI=;
        b=WZFRKS092ouimlrlgzK3ezvEkcp8+csO3e2yguNYLsSvCkUp1oKbxL9+/gYsIEMeIG
         G9uwHWNoFTcMiu7Gq82ECnQofEYv3GueAEqqbATMA0TN8odsqfiWAPJU0+Fl71H6uBEf
         c9x43+gFX3rkx7niD+aRKCX+BgwXUYliEA/w1WDL6u3d/63fEv3OVBNPc8UMn3+tJ8tG
         4t4GTYxfUiiqH4ztCBnk5jcrr95mJnBLEQ6uSYG9gZWyFr9A7t6x5MCEkoY6gJxlXS+v
         zMNldFnW8fj5c0XOx5ksJsUJliMyfXJQr/BncTIEOlwuZ7crPS015dYkuxXhtzr+FixZ
         04dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PhQBBU4nj+qMFvNV2GhIVih0V2IID3LhgyylS0lNDiI=;
        b=dvyX46yTf/2OkVRTAytyoWcJ7LJ5uKKoV8IxtaQjtXDdjgoXoL5vEjrYPgD0SUSx8z
         +LPZ/HLC9dL/vh4ddxah70K40lVpXFbFPYWRUAZ4NVyoZh9eQGjzeEkNT2TF4AN33W8e
         CXwjj4toCE6chLO9bTjHwPfYiLIoDvKsFfdMGY1dW+biGN5Gq3TdJY/f8uaFpO/8B4IR
         6i9X4artp2J7D7LJfXRWw1ek4HdafSZ80XIrLggbEBemXSO60synVXlAMpu74LJcwmh8
         p4yQfeyaywC94ki0Ytvhpdqx3eaiaNS1S3OkhFlSoNRPGlr9Hnl36EMG1Dsg6K1c7iZ2
         AqCg==
X-Gm-Message-State: ABuFfoi3gJ2ndhAe7EXpBxoxIY3Chi6V9YseTMS3K+JdcOZw/0eYMhGO
        vqYybc7oz5MY4LproJ6bLLU=
X-Google-Smtp-Source: ACcGV62A/yPHyYq9cafOi08Ofv3imR5kSiVAJIq+waZsm5eTuY+CMqS4WQCH7qYClH9PSr6MOQW3Iw==
X-Received: by 2002:a5d:67c8:: with SMTP id n8-v6mr26037395wrw.196.1539828044283;
        Wed, 17 Oct 2018 19:00:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 126-v6sm2227151wme.48.2018.10.17.19.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 19:00:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/4] Bloom filter experiment
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
        <20181009193445.21908-1-szeder.dev@gmail.com>
        <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com>
        <xmqqlg6y1ovh.fsf@gitster-ct.c.googlers.com>
        <8c66cbe3-6830-05cb-f3bb-be2e4902e8f5@gmail.com>
        <87zhvecamd.fsf@evledraar.gmail.com>
Date:   Thu, 18 Oct 2018 11:00:42 +0900
In-Reply-To: <87zhvecamd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 16 Oct 2018 14:57:30 +0200")
Message-ID: <xmqqsh14vws5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> This is all to say: having a maximum size is good. 512 is big enough
>> to cover _most_ commits, but not so big that we may store _really_ big
>> filters.
>
> Makes sense. 512 is good enough to hardcode initially, but I couldn't
> tell from briefly skimming the patches if it was possible to make this
> size dynamic per-repo when the graph/filter is written.
>
> I.e. we might later add some discovery step where we look at N number of
> commits at random, until we're satisfied that we've come up with some
> average/median number of total (recursive) tree entries & how many tend
> to be changed per-commit.
>
> I.e. I can imagine repositories (with some automated changes) where we
> have 10k files and tend to change 1k per commit, or ones with 10k files
> where we tend to change just 1-10 per commit, which would mean a
> larger/smaller filter would be needed / would do.

I was more interested to find out what the advice our docs should
give to the end users to tune the value once such a knob is
invented, and what you gave in the above paragraphs may lead us to a
nice auto-tuning heuristics.

