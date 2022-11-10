Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F189CC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiKJRsu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiKJRsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 12:48:42 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705CA31EF3
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:48:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id q93-20020a17090a1b6600b0021311ab9082so1444038pjq.7
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HvX97zTUdfZW8UNXZJUFCsKpGDM6YDD+R+1KIZIqjE=;
        b=YYl+/+mSyGjTgEJ6q4YSuyQKYCuck2lAGo4wxaLUggzf16kOlraSL/7CpBJBK+1mlP
         f9GvXZL44vNKRT79433ZWq0P+Nk7wp1pgi4Nuz3OPdOyX4TkvGlPbQmvclN1oSUPU00P
         h+sde/7XdjAsJXlmQ6UfCiYmHsaleL6sD9nU/d+WU68b7iic/UllNA9fJRY0wgwbDiJW
         MBNG12TiSfcabpOJTK00aDShHYfOxNjXmI2iUH93YfGneZPFxKMlqYf7GsAOXfAWXeqe
         Eu/ky21ZD38yFBAN+tmp48BbBehS96SQeGhHQMmjdeCZJMwFok5iOB4Bdhe+duEb+dSM
         FdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HvX97zTUdfZW8UNXZJUFCsKpGDM6YDD+R+1KIZIqjE=;
        b=yR9DosSioji0AHYIhfXUA8c4r8yXgIvaQttMgmpFj7QE46cpY7KGuaPfKSiIVdYQBB
         v7/pJ2HYV0Hs/W/pZ5uE+gPnY4FRnQ8SeAPEM85DWJpXDjPjKXDNZ8RUl4mk2pOvZ548
         edGNvRoLkJKMh09Jz8Kl9/KBkh5wcqoji9jDHyteP4ejYaLU7nzWGK6/zuqLwaX7is3O
         VvEsibt+bK9DgMkIrNq5H7wjsZKFk6bijiIUXqUga+Wp1hwRo/e5wL11aHUlKoCnmukm
         FZgD9o4PlfB4tvNXTgdv3DdvsP22MTivaeWsxomF/MmMj8Eu2sGVgA3L7x/zNsSyEf/c
         EBpg==
X-Gm-Message-State: ACrzQf0coAhaStQ3gIcvMbbvMiV+J3R4iwBDLMSfHhuQWnCNd8TVFALp
        iqML7k3bu5E+/GF6COFJZZOxx5SlakKAeA==
X-Google-Smtp-Source: AMsMyM67MNk9iSdTHBaEUYcZFrEV7wE0eFL2irETOd9i7FX2PFg4YWgSdf965mp6oNWtCC63ZuKxJ4L6HLjBcg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ecc2:b0:187:85a:2889 with SMTP id
 a2-20020a170902ecc200b00187085a2889mr65480510plh.65.1668102520344; Thu, 10
 Nov 2022 09:48:40 -0800 (PST)
Date:   Thu, 10 Nov 2022 09:48:38 -0800
In-Reply-To: <Y2xnUyEoCFmbPtUI@nand.local>
Mime-Version: 1.0
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com> <Y2xnUyEoCFmbPtUI@nand.local>
Message-ID: <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>>      * How could we set up end-to-end tests to ensure that we're testing
>>        this against affected versions of curl? To avoid regressions, I'd
>>        also prefer to test against future versions of curl too.
>
> Does that necessarily matter? We want to make sure that we don't see
> sensitive headers from the h2h3 module with any version of cURL, no?

It would help, but it might not be worth setting up infrastructure for
just this use case alone. Given the various platforms running tests
against the Git codebase, we probably get close to a representative
sample of the population with enough time.

I think it would be more important to have tests against HTTP/2.0. If we
did, we probably would have already caught this, e.g.
t/t5551-http-fetch-smart.sh:'GIT_TRACE_CURL redacts auth details' and
friends.

>> +		if (!redact_sensitive_header(&inner)) {
>> +			strbuf_setlen(header, strlen("h2h3 ["));
>> +			strbuf_addbuf(header, &inner);
>
> This leaks inner.buf, no?

Ah, you're right. Thanks.

