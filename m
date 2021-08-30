Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BA7C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B8460F5E
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbhH3UEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhH3UED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:04:03 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C09C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:03:09 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m4so27893541ljq.8
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E4n2eopjeScUTDwpGS09f3YHy8S6NtojvqK0Xw0UiFE=;
        b=ny9ncbYF6AwBqPjR6b7O8cZoidFPo+7LiHKjqcQ9jvlvlEqzFYi5MUgiBFB2w7bY3Z
         tEmlbHeycGVtb+AX0DFeDQTfQevmmCqyUL6cLNr1Yn8rmD6A1HRIB8ftORjWOAl0yOhu
         u0Xjb3vuBlLu4M4k0C6CPT04Lp/4Y2HS2L4KTLsY8D6fCNe4/9hKKtqPg9wJTBF3sWQh
         ecno3NmodZJY4SO6mucXjuGEJ7Eu5ZcbgfdNYR1RdaxtbuxkuCBqnugH0TqumB9yEfRl
         z3O7INdt+Bfya6qSLJRFouDhXkBZJ9RRGLE59mx3aNJzX3Tv0FnyTYEQl4intq+UIVaD
         fhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=E4n2eopjeScUTDwpGS09f3YHy8S6NtojvqK0Xw0UiFE=;
        b=p9uV959KX/Sn4hC92HMN05EEvXJWr5GGnMAHtygae8Od4RSC2w8//Vrld5x93qBkhM
         dIP4BkbrkBZomidyPy7Alo4Fy4OrM7gyJk0pklC/L0rdDPfPm8Goh31QQ1clgNXmizus
         1WSUMpMdVNTuHP7ZnR0bAo/UUkSZT/ml0JFOBcCS/r6aRa4ynJsrAMJnGIVRsgQeQvgz
         hNhcQnuqjwewn3/8ZmRrK+cJq0QFGWhDGBRapyWUmcGfAJyYtiHpWZTAv77xgZsjLGIZ
         BqVlaPR4td58AtDNG/zhvvs/lTIY0oDf5F09iwwW8u9FZ8Ue67gkcqewcdygpag08nbU
         S+6Q==
X-Gm-Message-State: AOAM532pb8XdhlUOmghaZk9rkUiA9AWZXjizMPpRTMGPLeJFs3hUFnni
        qTb23sqaGatyseMeixO8MOcuHHioltc=
X-Google-Smtp-Source: ABdhPJyXsoYoGLsEzmavCQywRji3GjRLIdUAie073AyvkcGlDjxFhI+S2K3tou/je6VnC72c0FxyPw==
X-Received: by 2002:a2e:b44f:: with SMTP id o15mr22266126ljm.430.1630353787696;
        Mon, 30 Aug 2021 13:03:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m16sm1487095lfh.243.2021.08.30.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:03:07 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <xmqqsfyq501v.fsf@gitster.g> <xmqq7dg24xff.fsf@gitster.g>
Date:   Mon, 30 Aug 2021 23:03:06 +0300
In-Reply-To: <xmqq7dg24xff.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        30 Aug 2021 11:09:08 -0700")
Message-ID: <87lf4izon9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
>>> to diff-index, 2021-05-21) git diff-index no longer accepts --cc. This
>>> breaks gitk: it invokes
>>>
>>>    git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD
>>>
>>> to show the staged changes (when the line "Local changes checked in to
>>> index but not committed" is selected).
>>>
>>> The man page of git diff-index does not mention --cc as an option. I
>>> haven't fully grokked the meaning of --cc, so I cannot tell whether this
>>> absence has any significance (is deliberate or an omission).
>>>
>>> Is gitk wrong to add --cc unconditionally? Should it do so only when
>>> there are conflicts? Or not at all?
>>
>> I think --cc is designed to naturally fall back to -p when there is
>> only one parent.  Use of both -p and --cc has also long been an
>> acceptable combination, and even if we say the later --cc overrides
>> -p, there is no reason not to show single parent patch here with
>> --cc.
>
> Another tangent.
>
> I think the use of --cc with diff-index can make sense in another
> way.
>
>     $ echo "# both" >>COPYING
>     $ git add COPYING
>     $ echo "# work" >>COPYING
>
> Now we have one extra line at the end in both the index and the
> working tree file, with yet another at the end of the latter.
>
>     $ git diff-index --cc HEAD
>
> is a way to show combined diff to go to the working tree version
> starting from HEAD and starting from the index (I needed to use an
> old version because the 'maint' and upwards are broken as reported).
>
>     $ rungit v1.5.3 diff-index --cc HEAD
>     diff --cc COPYING
>     index 8b9c100,536e555..0000000
>     --- a/COPYING
>     +++ b/COPYING
>     @@@ -358,4 -358,3 +358,5 @@@ proprietary programs.  If your program 
>       consider it more useful to permit linking proprietary applications with the
>       library.  If this is what you want to do, use the GNU Lesser General
>       Public License instead of this License.
>      +# both
>     ++# work
>
> Now the way "gitk" used is with "--cached", so there is no multi-way
> comparisons to be combined, and it is natural to fall back to "-p",
> so it is a different issue, but since we invented "--cc" to
> originally emulate, and to later improve, the output from gitk,
> I am reasonably sure that its use of "--cc" should be supported.

If the patch breaks essential (even if undocumented and untested)
behavior, as Jeff pointed, it should obviously be fixed. I'll look at it
more closely to suggest a fix.

Thanks,
-- Sergey Organov
