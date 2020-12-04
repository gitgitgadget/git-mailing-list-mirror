Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDA9C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B1D22AAB
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 17:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgLDRfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbgLDRfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 12:35:07 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C1C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 09:34:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id q13so8728859lfr.10
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z1jX2sIXpRhWR99ipkjhTtLfvaoKxHQiQGzUVW6WRwY=;
        b=TvOMt80nCkGkISsAWB23/XY+3nUL/tFOxFuz+mei7S8NIoR0wuGyCy0iVDUpBbeenE
         Y9htFX8KJDt7f3wKx6hsCIBpNPD/uOZQJk2o3Q/OzCtf63EwBy0tQmwq7fycWeJrXFzO
         ZZfEQXcxxMdX3yyDlI2eLd+611BLWFuKBhJxZv6wcfTN20E9WjjbC958XOmGAeijVCWW
         1XMgoYEzakFtuVGQ0dXH+gplC+jmJ3P9t/cAfnBzI3cZpRrGDllaIxe7jgBCfEEy7P5E
         BwRK1z+IuX+poIgxYz4pdPbce9cv2zNC04s2Gq2jQTunRc//e74K5mU5vcyNJaz3F/nD
         0wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=z1jX2sIXpRhWR99ipkjhTtLfvaoKxHQiQGzUVW6WRwY=;
        b=Giv517f39ws+RhbL6mRmrB3shB7u4egigzGlprpLLkdQ8nd00QMsmFfae9aNRNPwDk
         xkI6Z8bN3qcXch9r+yaQm0lIsU1WW6T/WAZoSYIEzO17+4aKpce4kZPMujWkEagAzwuH
         NlZzvZcL1Q+zIahqDJyxLV9gNmwSHMEmvTpGu6Q9gobE2Jj4jOGKoWNhNMdGSxn3me+x
         DWD5P+IJzOne9hahr4KB1FMGBHtnuApcAC07/XPvIYj+BALI9WYgqchYcV86mSSvDwJg
         vZ0ff0/0HLzWvhGpf6rRWw2F3vNTCxGQNdU41Q+yUgcDgtUymYI2wkg1azlQ6DM1suel
         RdQA==
X-Gm-Message-State: AOAM530GzuZArU8fejFc2rpseciGH8jmPVyb5RKCJZ6kSNx3peIejGTS
        /NfT1hm+zlNTNbzCDvGtjwvhwiFk4Cw=
X-Google-Smtp-Source: ABdhPJzARYV/g4SuKHen62Ng3hj+1epP/Ljvt2CSFprEEMro3QLn8Zr5HWgSKhtLccOhNaTO4DvjKQ==
X-Received: by 2002:a05:6512:368a:: with SMTP id d10mr3807947lfs.579.1607103259220;
        Fri, 04 Dec 2020 09:34:19 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s22sm1881836lfi.187.2020.12.04.09.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:34:18 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-25-sorganov@gmail.com>
        <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
        <877dpyhefj.fsf@osv.gnss.ru>
        <CABPp-BEyiLDZ5Ums1D5gL679EMmKXpqxWDF_xGT4scXLMkwseg@mail.gmail.com>
Date:   Fri, 04 Dec 2020 20:34:17 +0300
In-Reply-To: <CABPp-BEyiLDZ5Ums1D5gL679EMmKXpqxWDF_xGT4scXLMkwseg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 3 Dec 2020 12:22:08 -0800")
Message-ID: <877dpxpjae.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Dec 3, 2020 at 11:34 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:

[...]

>> >> ++
>> >> +--diff-merges=(off|none):::
>> >> +--no-diff-merges:::
>> >> +       (default) Disable output of diffs for merge commits. Useful to
>> >> +       override implied value.
>> >> ++
>> >> +--diff-merges=first-parent:::
>> >> +       This option makes merge commits show the full diff with
>> >> +       respect to the first parent only, exactly like  regular
>> >> +       commits.
>> >
>> > Not sure that "exactly like regular commits" is helpful here; I'd
>> > personally rather cut those four words out.  I'm worried it'll be
>> > taken not as an implementation explanation, but as a "this treats
>> > merge commits in the natural way that regular commits are" which users
>> > may mistakenly translate to "it shows what changes the user manually
>> > made as part of the commit" which is not at all the correct mapping.
>>
>> Dunno. Don't have strict preference here. Git has no idea how the
>> changes in a commit have been made in the first place. Changes are just
>> changes.
>
> If you don't have a preference, can we drop those four words?  ;-)

Yeah, sure, dropped.

>
>> To my excuse, I took this from git:5fbb4bc191 that has:
>>
>> +Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
>> +will never show a diff, even if a diff format like `--patch` is
>> +selected, nor will they match search options like `-S`. The exception is
>> +when `--first-parent` is in use, in which merges are treated like normal
>> +single-parent commits (this can be overridden by providing a
>> +combined-diff option or with `--no-diff-merges`).
>
> Yeah, I can see where you're coming from, though the context change
> feels like just enough different that the four words you added bother
> me a bit more.  However, this existing wording does bother me now that
> you highlight it.  Even though it's not something introduced by your
> patch, I'd really like to drop "normal" here; I think it is prone to
> cause confusion to users and as far as I can tell provides no useful
> meaning for the sentence.  (There are multiple types of single-parent
> commits?  What is an "unnormal" one?  How do I tell which kind I want?
>  etc...).

I see your point, but I won't change it in these series. I think that
it'd be better if you change this yourself, independently.

Thanks,
-- 
Sergey Organov
