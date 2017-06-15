Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C55A20401
	for <e@80x24.org>; Thu, 15 Jun 2017 22:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdFOW0s (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 18:26:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35531 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbdFOW0r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 18:26:47 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so2997357pgc.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 15:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V9/wjfDpepp9doXt8YP/J0xCxMpJE7GR5S32h6xPd7A=;
        b=hteWI4Jtb0HIAgqiiTHDcXpBQHoZSwsdu6GVqhnVMJnMQ3NPexU14yBG5jMBGVAzkN
         A4uUnhCoB+xh7+5SwYKrX3eHBIg002O87Dttq+P0SgbltBGGYcijDzENLeAy2vmLHPF3
         aiPN08D9xuEPchcvM9O0X/vbjZvsvwKjgiR0otXqfH+BuCyu54xCW9Ot6WgCze8mbLaU
         Z5NKR7CrnrEokK0U45R0fEq29FY/4bdO/v1/AFNqmxW4pA0QKDOpfAukdARNFUnWPH0F
         UZzOetB1elBC2tYaRa5xEWyKsnRISIvZSCRsiz9cUITkVtCEkvY8JxIwYg17RKsy1ZxC
         0GyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V9/wjfDpepp9doXt8YP/J0xCxMpJE7GR5S32h6xPd7A=;
        b=Z6VajCLp5gq+XK3nq+0wpYxIGXEqz2fxb5ntcfNaXy8es5H73YCC8njj+/d4da/4uG
         oMD6YSsKg7zKnh2FboiqeL7CW6UHLLeqTSt1rnlswlebC4C5iN4Lb61vfCSZCLx4u0Sf
         flnO0R2MXoEnpOAXHT12EaH39vSXTP5xLFjXZtO9xIpGL2ixgEC9z8EA4Phr1f6fMs3A
         aQvMSjr+7tu7NBNY2HKzdp7/xM8DsSgVd7RRlf33IQVO/49rxYuyocFnkotJpjXgTx+e
         lDUiGDPRFyCERDbEF3ZGOxIvOjKOoOYzwa4AJBzFmwr09RWD7OFlnW2toI2JNebL4bfm
         0Iqw==
X-Gm-Message-State: AKS2vOy31Yjlh8RQq+o10ihNXtya5/slzpQhXeHVW5NIkvtFVIf6ZKUf
        QsHCjcdWVqDfpw==
X-Received: by 10.84.218.134 with SMTP id r6mr8766803pli.288.1497565606610;
        Thu, 15 Jun 2017 15:26:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id 15sm488794pfj.59.2017.06.15.15.26.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 15:26:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98yvind?= Holm <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] for_each_bisect_ref(): don't trim refnames
References: <cover.1497430232.git.mhagger@alum.mit.edu>
        <3615deefe90bebe746618b04c055a466a442f85b.1497430232.git.mhagger@alum.mit.edu>
Date:   Thu, 15 Jun 2017 15:26:44 -0700
In-Reply-To: <3615deefe90bebe746618b04c055a466a442f85b.1497430232.git.mhagger@alum.mit.edu>
        (Michael Haggerty's message of "Wed, 14 Jun 2017 11:07:26 +0200")
Message-ID: <xmqqwp8cyjiz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> `for_each_bisect_ref()` is called by `for_each_bad_bisect_ref()` with
> a term "bad". This used to make it call `for_each_ref_in_submodule()`
> with a prefix "refs/bisect/bad". But the latter is the name of the
> reference that is being sought, so the empty string was being passed
> to the callback as the trimmed refname. Moreover, this questionable
> practice was turned into an error by
>
>     b9c8e7f2fb prefix_ref_iterator: don't trim too much, 2017-05-22
>
> It makes more sense (and agrees better with the documentation of
> `--bisect`) for the callers to receive the full reference names. So
>
> * Add a new function, `for_each_fullref_in_submodule()`, to the refs
>   API.
>
> * Change `for_each_bad_bisect_ref()` to call the new function rather
>   than `for_each_ref_in_submodule()`.

This unfortunately makes nd/prune-in-worktree topic rather
obsolete.  Can somebody volunteer to update it to newer codebase
including this fix?

Thanks.
