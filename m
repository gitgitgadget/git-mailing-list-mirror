Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C37BC433C1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39B661978
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhCTL3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCTL3c (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 07:29:32 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F89C0613A7
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 03:40:35 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id m132so995601ybf.2
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpsuOXaJglA8jGor/GjfA6UvrDxPfvyGDQVQD0uNSnE=;
        b=P1XPQinwAaAe9j+SiaTyN03c3Mknb2pgtKDE6fRwsnfP+lNwD+1hv1aEtOgEctEQgo
         /GLYgcS+W2D75duesEB0uJ7JjwstxVxpbrz5jB5xn+l2ks2v5DF5b1kawaVHJdkjzw/P
         2kdgFPcvQvMql/xSkgSnLzFkD5DR4PivxzVlUlfLBRTX8Xlt0AI5alt6H/xVK98A6T7/
         kM5zOkdC8ldL1qom/HnVR+tWvUWW5MBSkPT4U4W/LGSNcUiYjBQ+rVanXuvTpv7uNXUf
         YcjtCeag1KOYUtK812eLiNVMJaweOeAmDRq5bJTI5Tc6x54QhDxohRFHCPzesUXaUav2
         Z+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpsuOXaJglA8jGor/GjfA6UvrDxPfvyGDQVQD0uNSnE=;
        b=SJV3BdtG7iG+hwvPg5rGk/e92q9ca/HJ8ZrKpN1MeDY3t7HNQjmSE5o3QUlPU1svAF
         J5mNW/fLB+ZdNRvB8abp78UumdGUsPX5FGOotiB5MBj6b0zKHshauDotvXwrBqKCJnob
         b1yS8U9XQIxCwmxJQGO26b0uCnDQb9ykWxXAa7unFBdqFG+Oth8MeZTmrDEuDiKCybMw
         9KLFIkPFGoZLWcXn/zYjgZQHYdqc31N468NlCcXlgIY5+KMDnKRKIN8PhevwJrTLH0aM
         WQ4mxEQFyCqBA33JVav7rNUTzDdnJ9KSCG1h+R2aubLBt2DGINPpa8TPWvI6rdZKDRbm
         qpFg==
X-Gm-Message-State: AOAM530Pc/6ziFtuT3B4KPFGyMhoq2epUhjbpwDiP3xwrBeZj0MpDZF+
        /zcNxg7MCQxPqcJr/2CxrQTsVoVUobZZQ0cT4SeJsR96EnqlOQ==
X-Google-Smtp-Source: ABdhPJwyj7vWv7S73GQjmbVmk+ijmgcczMosJ7KZpzU9gG86AG3+h1WPteoKQMwTzOB0FA1fM6bgE01uXlcdBuwgGZI=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr3800608otq.160.1616222302485;
 Fri, 19 Mar 2021 23:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
 <xmqq1rcctgj7.fsf@gitster.g> <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
 <xmqq7dm3p344.fsf@gitster.g> <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
 <YFWCvePMGvBY/I9v@coredump.intra.peff.net> <xmqq4kh6l6fd.fsf@gitster.g> <CAOLTT8RE6LOx2AUH8PJMzFdqp4_GJkiY41K0xE1YiSQNixKCRA@mail.gmail.com>
In-Reply-To: <CAOLTT8RE6LOx2AUH8PJMzFdqp4_GJkiY41K0xE1YiSQNixKCRA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 20 Mar 2021 14:38:11 +0800
Message-ID: <CAOLTT8T54RHPm8P=mJ3vOKZPEwpJQgnbeU3VqczWbPSk36wZcA@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In actually ,

@@ -1071,6 +1071,7 @@ static const char *find_author_by_nickname(const
char *name)
                strbuf_release(&buf);
                format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
                clear_mailmap(&mailmap);
+               reset_revision_walk();
                return strbuf_detach(&buf, NULL);
        }

then we can reuse this function.

But I think I can give find_author_by_nickname another arg for choice if we want
 `reset_revision_walk()`.

Thanks, Junio and Jeff.
