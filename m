Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21162C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 21:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCIVvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCIVvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 16:51:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D2F2F99
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 13:51:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p20so3470054plw.13
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678398678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTLcPu066h53Tzu8geb9rArOZ5jAGqq1tlDlhQTNhEQ=;
        b=e7I9FUqLK/kNr0jWVR+bHbL2Y/81a0DZbz9e3cpWYkN+kJgnzuAPkX7ccaLFjO3dEO
         vKJfJgzTPyaA9cYSg8vUhcgfCXLYgWdNcQSYWUKD18Y2ucWnBF018tCBng5W/gApD5vv
         KsTHFP5XH+/MxN4JhtzFj34D5cR050mMaVynCIT5S56Sv+Xx4WRwxAYP5xQObyXZMon/
         jUwZsBJ3R5ktSWfLaY52d7IshLC2KFPCUgMwmaI4yqq/Js2oeIDyQQ+W/asojMd3ZTeL
         f73/c49OAwKcBOm809XvyI7dzXC+HJyJGnRX24E1Y4awkYDEPgvdZ2r7OcHxFZwz/lOM
         TeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678398678;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JTLcPu066h53Tzu8geb9rArOZ5jAGqq1tlDlhQTNhEQ=;
        b=hgwmvUURZM+A08y8XypkxJBRbDBDtzorX/5uzuvm4REAjo0PVlh4337euD9ReJvfKO
         uxlm1+ODiIelGh1nlMuXeZlRuLHwOKB0GKT1D+JbCUNysIOh9/y92/M3stLmRH55SP4Q
         iW/eETF5N3sh5tC0XedKnkcBvKw7MaOewM0OrsxQN9TgnMF8YsCdYE6ujn1P/9g1J7fK
         6V+687S8d0uu+BhDbUcQP0ol84BfczIVl7GtqpZFEWmmXSyNifwwzXs+Gd4caVIBZSy/
         zDNXdZVc6eHr9f1tcM0rFiquG3CxJcZinJpDutQrZM40knRP7l910l+Xas2mPhYFMjc6
         oR6g==
X-Gm-Message-State: AO0yUKXptI2dzSM03fRPuCePqd9/Lk8MW/qSxdGWDTPTsTlcnr378Q0k
        Trkp0/14ckzkUgIi8UapwF0=
X-Google-Smtp-Source: AK7set9wEBKWPShOc3thvCqo1ium4NjqiVBGwvMHhTDANeBpRm8IyiQa/JnFdeMTThHIdcGDfb5rcQ==
X-Received: by 2002:a17:902:ce92:b0:19c:f8c5:d504 with SMTP id f18-20020a170902ce9200b0019cf8c5d504mr3886659plg.59.1678398677830;
        Thu, 09 Mar 2023 13:51:17 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kp13-20020a170903280d00b0019c919bccf8sm119999plb.86.2023.03.09.13.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:51:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/8] ahead-behind: new builtin for counting multiple
 commit ranges
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
        <xmqqedq1ag8d.fsf@gitster.g> <ZAaHB7XTz8HX75LD@nand.local>
        <ZAmk9V54c/jIbJ65@coredump.intra.peff.net>
Date:   Thu, 09 Mar 2023 13:51:17 -0800
In-Reply-To: <ZAmk9V54c/jIbJ65@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Mar 2023 04:20:53 -0500")
Message-ID: <xmqqv8j98uga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Yeah. You could imagine that `rev-list --count` might do something
>> fancy like coalescing
>> 
>>     git rev-list --count B...C1 B...C2 B...C3
>> 
>> into a single walk. But I am not sure that just because `rev-list
>> --count` provides similar functionality that we should fold in the
>> proposed `ahead-behind` interface into that flag.
>
> It does coalesce all of that into a single walk. The problem is somewhat
> the opposite: it only has a notion of two "sides" for a symmetric
> traversal: left and right. But in your example there are many sides, and
> we have to remember which is which.

Yeah, this reminds me of what I had to do in "show-branch", where
each tip gets assigned a bit in the object->flags (which means it
can only traverse from a very small limited number of tips, like 30
or so), which I once planned to extend to arbitrary number of tips
by storing these bits in commit slab, but it never materialized.

> So I don't think it would be impossible to make this a mode of rev-list.
> And that mode might even provide flexibility for other similar
> operations, like a mass "git rev-list --cherry-mark"[1]. But it is a
> pretty big departure from the current rev-list traversal (to my mind,
> especially the "keep walking past UNINTERESTING part). I don't mind it
> as its own command.

I agree this is not a good fit for the mental model of rev-list or
the revision.c::get_revision() traversal.

Thanks.
