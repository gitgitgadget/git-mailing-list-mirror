Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539DC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85435619A6
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 00:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhC3AHR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 20:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhC3AHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 20:07:08 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121AC061762
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:07:08 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k8so1301729pgf.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 17:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IA4JVbH+NgjSoP1VXl6G93zjEh4hxeuCC9bfE+aPDvE=;
        b=nZbmpoVIFMWkh1Lyzo7FA3ankOBcNetJwk8xUEOuTPZOYhmR5CDhYkfz8FmoFeaAPv
         r/cMjIyK6sWaNEms9bJFGfxCLy45iFUA4yWzMQVJvdbB956BQ64RmVPvxXJqPWT8OFQt
         v1BvW1irGIREg0vCx/QrNQOcVrbnLKwkztAsnbet+RBX7fciaJCur0sDOSPg+4cxa9JJ
         XBwLM3lL79RtaaYoPmDpKQFAaUvR8uDzK/46A/XdNGKthNj8PT5FnHkWEXVVZhERMBVT
         UM8No/mazkl9fkrgJkJ5DuipPZAUMS326i07Wu8/Bl5iSxU5HhMamEGPIfkUt4OrU5Q4
         utKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IA4JVbH+NgjSoP1VXl6G93zjEh4hxeuCC9bfE+aPDvE=;
        b=rIg6mktGem9vgCtF3u+DPWONdVcmRpnMHZCURsg5Jp3BiqH+77mcrGmPaTdQrv0AXo
         84wyE24KjxuqKh2w0ZNC/TQvyLyGyXn9uCTTKq+x6LaryyqpaCyeRS/RXuyR1+D7hlQc
         9Ltc315GduQEaPX+PGGsOWyzgZ2lJWXGX4jz87L3B49JEQ6EsKqLdyGa/0c7UIglnAhF
         LW3alfzey60f1sq4ZCEt2gdzZLWL7OAiLwlWV6rkz9g0D7/i65DduzwwaIM7Hz94BenB
         mvDDoQ8c+JGHqvKGufT5DD2HIhuZpTkQnJZ6Qanns9wdwFgAJ+SuYc3uYuIr0pdBSdvn
         cYoQ==
X-Gm-Message-State: AOAM530fE5PW/LVQFQBuOSwDNF7w7P/Cpqf5CungZwhZM8SN3ACTKB9d
        zivilYXP4FYlVkNzQxnfovVm+w==
X-Google-Smtp-Source: ABdhPJwGIBZ8X6RhJ82FIerMuNNvFoV4YSSpX8hg5PnBd5ZUMpGaj8q6aCA4rkPc4k73vWKRvcgHIQ==
X-Received: by 2002:a65:560b:: with SMTP id l11mr25245943pgs.362.1617062827969;
        Mon, 29 Mar 2021 17:07:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:282c:288a:2054:f194])
        by smtp.gmail.com with ESMTPSA id j10sm742444pjs.11.2021.03.29.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 17:07:07 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:07:02 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 36/37] run-command: stop thinking about hooks
Message-ID: <YGJrpnCVMnM1KNjM@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <20210311021037.3001235-37-emilyshaffer@google.com>
 <87v99wg1xw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v99wg1xw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 10:23:55AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > hook.h has replaced all run-command.h hook-related functionality.
> > run-command.h:run_hooks_le/ve and find_hook are no longer used anywhere
> > in the codebase. So, let's delete the dead code - or, in the one case
> > where it's still needed, move it to an internal function in hook.c.
> 
> Similar to other comments about squashing, I think just having this
> happen incrementally as we remove whatever is the last user of the
> function would be better.
> 
> E.g. find_hook() is last used in one commit, run_hook*() in another...

Hm. I could see it, coupled with a blurb like, "Nobody is using this
anymore so delete."

But it feels odd to move the find_hook() impl from here to hook.c
internal in a commit about, say, bugreport.

I'll consider this, thanks. Maybe it fits in one case (like run_hook_*)
better than in another (like find_hook). I'll play with it :)

 - Emily
