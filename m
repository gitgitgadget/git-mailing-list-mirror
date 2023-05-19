Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED1EC77B75
	for <git@archiver.kernel.org>; Fri, 19 May 2023 04:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjESEBI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 00:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESEBG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 00:01:06 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E14410DD
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:01:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba8b236e53bso225839276.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684468865; x=1687060865;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=6sQ4hmnJ65ZwxVNuafDHQW0mLD1kUgYxAvj9Hx3fhcc=;
        b=YewjGwCZPxNdXFz6/cVsL04WgUxeX0tK/Mz49OekC14eQCxr2ZyCUybJo01TvUECWz
         B8VVgvm9U7gnpgb74iIv06t+SGE+5468l3IpV7V7f61aEg5rnB5mC6HjXOonZ8j1wh7J
         wrKMMds4vO+oMNEWOzDzCroW7fWuJmijv2fCK0aAsteOa0O+0PWvfYQu/g/2RL/7Livb
         6st4P5gQsAK1HSSAd1cWZlF0r9FkiSLJSPkxp0CKktBcGewcgKZYBGlDA6fsD5dqS+wW
         xsZ18OuZhgylWiPjFuxpFUshJ5SPqfCnqYZX6RbhwU6k0w36kuQL7A1v53LYuamW/Bhj
         a3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684468865; x=1687060865;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sQ4hmnJ65ZwxVNuafDHQW0mLD1kUgYxAvj9Hx3fhcc=;
        b=fR9kCkmmYcZaIe9Y2FkEXj40Wa2QR0+k2JOHfKONr2rudKLRUz2DXFxwKRAHj6Hx7P
         T+W57/HMqtUi8MuqgtZdsZkqHtI7W035XWLjiefxBP5Ygrw1SHE2VyT2dz6JgLHfPNzq
         Ena/0UcxKgcKHdOVyHj6brIrqQQK5SGdt+cfEajjroZUst3hTMqCx8mFaT7A8zafAJs0
         RyVZmAF8UekhUYDhZcfT8UMAhKXoKiMsri+3lHbdoiYHDcF7s/GsTFdcfdvKaC2bfjlL
         NBQo9CNTcg2Phkk5PPZgLF+DllekvpAYUOsT9q5LX/uHi2lfrChCEEU5wr4sgIVI87Df
         nncg==
X-Gm-Message-State: AC+VfDwjcmKUEWl1+uSm4uKmWvJ1XK0Nt+esoduxKAkaToHExxpUz9+n
        B03CgnytG/UUC5BYhpVLp8Q=
X-Google-Smtp-Source: ACHHUZ6IrykOdvdA34izVpEGpJCkO1EHQS0kj7oCdwrt8PF3oZ04F56Z3sUot4c5CgsS479oo+zeiw==
X-Received: by 2002:a81:1d97:0:b0:562:191e:c169 with SMTP id d145-20020a811d97000000b00562191ec169mr853424ywd.2.1684468864617;
        Thu, 18 May 2023 21:01:04 -0700 (PDT)
Received: from epic96565.epic.com ([2620:72:0:6480::10f])
        by smtp.gmail.com with ESMTPSA id u15-20020a05690201cf00b00ba89268d1ddsm780256ybh.5.2023.05.18.21.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 21:01:04 -0700 (PDT)
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
 <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
 <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
 <xmqqttwd8jg5.fsf@gitster.g>
User-agent: mu4e 1.11.1; emacs 29.0.91
From:   Sean Allred <allred.sean@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v3 1/6] show-ref doc: update for internal consistency
Date:   Thu, 18 May 2023 22:55:39 -0500
In-reply-to: <xmqqttwd8jg5.fsf@gitster.g>
Message-ID: <m0353tug01.fsf@epic96565.epic.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:
> Making the last one into the third bullet item, e.g.
>
>     - Use OID instead of SHA-1, as we support different hashing
>       algorithems these days.
>
> would have been even easier to follow, but I'll let it pass.

Easy enough to change for me; this will be addressed in the next
iteration.

> In prose, "object name" would flow better than OID (the original
> would say not just "SHA-1" but use "SHA-1 hash" or somesuch in such
> a context), I would think.  When used as a placeholder, OID would be
> perfectly fine (<oid>, where we used to write <hash> or <sha-1> or
> <SHA-1>).

I've used 'apostrophes' to set off these terms (found as literals in the
documentation that's changed) and explained/expanded 'OID' in the commit
message.

>>  -s::
>>  --hash[=<n>]::
>>
>> -	Only show the SHA-1 hash, not the reference name. When combined with
>> -	--dereference the dereferenced tag will still be shown after the SHA-1.
>> +	Only show the OID, not the reference name. When combined with
>> +	`--dereference`, the dereferenced tag will still be shown after the OID.
>
> Not a problem you created, but I noticed we do not explain what
> "=<n>" up there does.

Given I also don't know what it means, I'll let you spin this off into a
separate bug report however you see fit :-) Just based on the diff
context available above, it's odd to me also that `-s` apparently does
not take an `<n>` -- whatever that may be.

> Everything else looked great in this step.  Thanks for working on this.

Always a pleasure :-) Thanks for the review.

--
Sean Allred
