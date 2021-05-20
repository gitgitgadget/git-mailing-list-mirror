Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B22BC433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A434606A5
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhETSwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhETSwA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 14:52:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFDCC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:50:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c12so1447148pfl.3
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=piPai9KSTOvQiEXYUJmd6tG4mjv51Xg3kewhMEbolFY=;
        b=bV+jAO+WUP6/j5jO265xAM6GpXK6rTpablA4L95+Fsrs+8I8EX7YSIpcwSv/zXIpQP
         hpyyscp5rEOo1i29zGmGQS29DuOnR+OcmMfSCpX1RoTCd9ME4yKCJ8p0in2RAf/hhXdB
         YkpHJYA0UeF2G6aendtZjmXOw1//6GjN/wMdnnUoNDAOt2gSpVj0MeR0D+2Nyysr2hCT
         VIZNnF4R6R9Z0mkKjdOCYPJACpXoreBBg+lL6zA2GyoT3UrrCrRlk46AbRK4F5rlubhj
         s4DrvFXIYh459doD06q/dTdUQ4CkJkarspvWl0lhHzIQWnk0azSNqRDbqjSFHgREBH9Q
         RJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=piPai9KSTOvQiEXYUJmd6tG4mjv51Xg3kewhMEbolFY=;
        b=j0JP+7KaSz42G4Aql1q39nsxzzTgJzci76HBgbRxS7m7rTEg5Ttaqham8F8/JwMKEZ
         PvWhxe8cRoC8OiuY98+/wmca/RMfyDYewv1TzUCynYHQZy16vQ6DYJ6kW/PI9sWx3Yn7
         x1iVe6LvPi89yQzZpjY1mNgPaikeQKknUfhsHAXzalG8YqXzbmMp/vT/3KXd9wMEvaeg
         3Mh5xqt3YSYvaaIA8xjyEt2UmB3l7KICkNJScMkDCSK1b1pNU3cBmPua9IqQuO7RarGd
         19NDQlhvw05QXWKN0Zsp3ow0EX2lLx7E8yliPDf6k5eJFEwg1JHqwPtwillgmOgw+byJ
         PRzA==
X-Gm-Message-State: AOAM533Upo5Yptl/Nhv/rVS7xyg6ry6k1KsvhgLl7o1WqIthUd8jw3sU
        Ngused8bGZqAIaHMnNWBvvc=
X-Google-Smtp-Source: ABdhPJzF6vrVlku4hx1JqSNBk7xfIeQYiahkpBvzYqCMsQ4pPqrKN6GDKTN+tAXd98sSieZzL45d4g==
X-Received: by 2002:a63:514f:: with SMTP id r15mr5876892pgl.374.1621536636653;
        Thu, 20 May 2021 11:50:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ec75:d356:9cf2:6ea1])
        by smtp.gmail.com with ESMTPSA id l9sm2608881pja.20.2021.05.20.11.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:50:36 -0700 (PDT)
Date:   Thu, 20 May 2021 11:50:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] diff-merges: let -m imply -p
Message-ID: <YKaverOKIAJpJl3s@google.com>
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210510153451.15090-1-sorganov@gmail.com>
 <20210510153451.15090-7-sorganov@gmail.com>
 <YKWHo9gZNp+i3fH9@google.com>
 <xmqqmtsqwb9g.fsf@gitster.g>
 <87v97dfsyg.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v97dfsyg.fsf@osv.gnss.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> This is about "log" from the "rev-list" family, not "diff" to
>> compare two endpoints, so "git diff" won't be affected, and "git
>> diff-tree" is not affected, either.
>
> You are right. I've added a test for "git diff-tree -m", and the changes
> don't break it.

Good.

> Can easily re-roll if you think the test worth it.

I care more about the commit message than the test --- i.e. mentioning
that this doesn't affect commands like

	git rev-list HEAD~5..HEAD | git diff-tree --stdin -m

Thanks,
Jonathan
