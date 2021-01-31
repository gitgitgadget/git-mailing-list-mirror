Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A841FC433DB
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6330464E29
	for <git@archiver.kernel.org>; Sun, 31 Jan 2021 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhAaUO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhAaUMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 15:12:16 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE019C06174A
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:11:35 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 63so14289378oty.0
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 12:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ftXsyzNOmn0TcoOp9aI23+K1IWYBV+NsV1koIhMf3fY=;
        b=FVFe8X+u4lAKCMEhSRN87XmcfCeO+hy5XNxOhNlQOtgb8DsMfVlUbTHya/MrMmvkMl
         1x6NQVld4cW+kGs6KWMp0YLrCigm+yIeTYwcTWtBUv+/aFgPa98pZuqiC8nuh5wF11BD
         WarX91NhEPQGkPtrKkOnotVUErt4S+t3pRmUHbA0afNorXJUXXvhBRNvICXCbnAVDUPh
         0bn/UARcDwnHz4UkmPJ+hIE8FihiIc14/tql6d0kUCB1Qxz2aeL6KMU8gS5kpPK3/9/s
         V8OYooNgmc6AdIReO9TbGCxALwMKn3CNS9RazS8IAfWnyjMiXKOjzNd7ooLr4zMOQDHC
         LvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ftXsyzNOmn0TcoOp9aI23+K1IWYBV+NsV1koIhMf3fY=;
        b=YC3FBcCaTLf1B4CTHNNlvAHD6+4lJd9eh6jfLd0D+fENx2Ai/hYYwyp4FZ0xPtk/U4
         F2KZDJdK0XmfXyna5EsxW8ST/W5Ms3GeOBlQMdAtrAGEZ3CTuZXs0G9kGfZepvTr+EB/
         eP0vpCDwrUO61yx6MIz2cxyya/xw9IuRO8cl3aMws7RLJ2K1As8gmpcBSBxYWxoN8a42
         6IaSu9/NFEJV+uDs2bdgZX4mFuON6qCsmwh3OaRwHnBNMccAMldOLk6XcEquD6ws34JG
         QJ1y8HQNgCNc0Pqb9sQTLiyjZVfKnUBsSRynm9I6AOlbD91wlAbnpdZm7ikGjt+EtFfA
         uxww==
X-Gm-Message-State: AOAM531wZmmiNXncIX9n+SH1LzRpnlRici+v1lj+JhcJXTT147NEph/Q
        EN/XPr5JBV40+pP5KTykjFWgSD25xKWuiA==
X-Google-Smtp-Source: ABdhPJwkihf2a/n8wHEf8QvvwbUzH2BQIl+6VXsTtDX3A6uMwU3z2UJmD25VctaEeXHRjee+BbNeNQ==
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr9679223oto.23.1612123894700;
        Sun, 31 Jan 2021 12:11:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:383e:f17:3be5:db8d? ([2600:1700:e72:80a0:383e:f17:3be5:db8d])
        by smtp.gmail.com with UTF8SMTPSA id e20sm3542924otr.14.2021.01.31.12.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 12:11:34 -0800 (PST)
Message-ID: <66be51fb-f40c-5712-8e48-346ca53bd9e8@gmail.com>
Date:   Sun, 31 Jan 2021 15:11:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqsg6infev.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/30/2021 7:00 PM, Junio C Hamano wrote:
> * ds/merge-base-independent (2021-01-28) 3 commits
>  - commit-reach: use heuristic in remove_redundant()
>  - commit-reach: move compare_commits_by_gen
>  - commit-reach: use one walk in remove_redundant()
>  (this branch uses ak/corrected-commit-date; is tangled with ds/chunked-file-api.)
> 
>  The code to implement "git merge-base --independent" was poorly
>  done and was kept from the very beginning of the feature.
> 
>  Will merge to 'next'.

Please hold off until I can push a new version. There were
some meaningful updates to the new algorithm, but also there
is value in the old algorithm when the commit-graph does not
exist (and the heuristic doesn't answer quickly). I'll comment
more in that thread.

Thanks,
-Stolee

