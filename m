Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0500C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C417E611CC
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 19:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhJETn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhJETn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 15:43:57 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AB1C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 12:42:06 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id a3so767283oid.6
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=LNQjisVtIowjl9Tc5Bs246H+AOxvq4upj+kSQ2RuQkI=;
        b=Vr59O/+vt6B1G9MTHhvuwNa5ICURJu822cgOheIJKo50qbsVanJQxuVFA1yqf8uWjO
         JPzALcb27ZnedM7KbiCaOJpXUUmZKRXT7ald+MBu1ugZBLuMa42/AD3QCzXSfwz/jCuq
         DI2SFDKV4DYzSsQM8XpsRg3xGFiHFVR8/yZX4bunyFymexLaIuIFkMi5aceIQPsyd8Ks
         HKhz3fWulj0oeXu+eygCDOPlqQu8qcs8CFxVRm9oqBCae0YKLJCe247oqpUBaoIH6zNE
         FesMHJc3hwnfct1V4kws/bEGMGaCu4kLOHQjpkTYdZ4aCkxNzs5g9pUOYbz4WJmPHCWh
         ZcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=LNQjisVtIowjl9Tc5Bs246H+AOxvq4upj+kSQ2RuQkI=;
        b=xQOdhLN5rQRt8myozrikyWXcrbR62ha9orkxUgPdvmU2KxDcsPNk4rN2hD/v/vD7VI
         BHM1iBIcVuTC0NWvq8DQX/EpbgkL9ovgf3l1IGdPhUOR0LP3xc4v6EJhqTjvx9n75wuV
         KyRnqZ/vxg4otV+lW1FSuVoNePJKr3myXvXs1Yu/J71DF4L0yHGAEj2XbwnPtoEOUjrj
         oCQmg2TA7eT9+RenPkE2lb5gwh9BwgaGMOddQTytXjF5w2vNnSPp6ay+WC+RfedT3nan
         E+ANrbnCGJhZpAY72zi85njkha2MbkQkFxo2Dl10DavhptlAeVC0wfzTesPJ8k9a7Aik
         F70g==
X-Gm-Message-State: AOAM5302q+RpT1WNkhne4lNF8Yc4bTovSznGXd6oK8Y/jBVt9Js04bN+
        9nk1CJUVmwVAWe1fHT/aS4gZ0fE2lN5Ltg==
X-Google-Smtp-Source: ABdhPJwe4N1LS9NcTScBhjcDjiQba6E7gl+kwgNkrMaIkYy2XA+1wxriCOjPS2hso1kCW3CQIdX38w==
X-Received: by 2002:aca:af0c:: with SMTP id y12mr3972459oie.88.1633462923844;
        Tue, 05 Oct 2021 12:42:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5589:eba2:f5ec:ffb9? ([2600:1700:e72:80a0:5589:eba2:f5ec:ffb9])
        by smtp.gmail.com with ESMTPSA id l25sm3444828oic.54.2021.10.05.12.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 12:42:03 -0700 (PDT)
Message-ID: <9e4411aa-e757-0653-0c2a-24894b13158f@gmail.com>
Date:   Tue, 5 Oct 2021 15:42:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Merge ORT performance in the wild
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all, especially Elijah.

We finally shipped Git 2.33.0 (with VFS for Git) to the Windows OS
engineers, and the microsoft/git fork enables the ORT merge strategy
by default in this version.

I know that we are queued to include the ORT merge strategy as on
by default in Git 2.34.0, and to further support that change (and
thank Elijah for working hard on the feature), I wanted to share
some early data on our users interacting with it.

We have about 250 users who have upgraded, relative to ~2,300 users
who were active on the previous version. However, we saw sufficiently
high use of 'git cherry-pick' and 'git merge' in these early users to
share these results for how they are experiencing the new world:

| Builtin     | Percentile | Recursive | ORT   |
|-------------|------------|-----------|-------|
| cherry-pick | 50         |  18.4s    | 14.1s |
| cherry-pick | 80         |  34.9s    | 15.4s |
| cherry-pick | 95         | 117.9s    | 17.7s |
| merge       | 50         |   7.7s    |  1.2s |
| merge       | 80         |  17.9s    | 12.7s |
| merge       | 95         |  58.9s    | 22.3s |

This matches the results from a synthetic performance test I ran
in our monorepos: ORT is always faster, but its outlier performance
is far faster than the outlier performance of the 'recursive'
strategy.

Thanks!
-Stolee
