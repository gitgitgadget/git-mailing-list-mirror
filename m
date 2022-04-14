Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE0C433FE
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 17:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbiDNREW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbiDNREN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 13:04:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4AAB7C6D
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 09:41:39 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b6-20020a62a106000000b0050564d6fd75so3380932pff.22
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AecAA5wNMrsPxCLDRuG4hBx6M6AjU41Q2xZCvxK8sn4=;
        b=sBwwYMASXWTHZCKaYn1EKp36G7UU+Qvhry6oJi8iIHbkjAW2gxj78Ox54GQXtKAXxz
         PHrMAXoUsP8AZka3YEGWYqrPAeGMI7pum7pLXVY0gnXLCubXNgnzK0LFI7FysUpN6q/i
         fYjYcog5C91OPjl6HMvZ7hmyDA4ptE9/jx8BQAKpK9ulOTsz6nXykzOrXCF9oPhN8ob/
         KpiXS96odzGINLtI6p6uVyx2lAWqT7ceWj7qzKE8CkpsDsT7SmtG/DQyInW9JIFoZwar
         Ybe1Wx2yNYZsncGhRE338jd2IwhfTAJMRzO5w4CpheJkcTBC+wXo4cN6hqctAkC5nSPu
         UFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AecAA5wNMrsPxCLDRuG4hBx6M6AjU41Q2xZCvxK8sn4=;
        b=2Khu+b4QuFdH6O/HktjF32paFVazJp7k8I9hQl1ptzUHrc8c/WcPiuA4mDLxoVTOzF
         khTGpNDJ+SSWDqAV3QwQp3RH3pLpqT8kYIdHRy/e9Qwas+dtKYRH/5m/D60sPNTpF7p+
         Lyq6h6lCg76BnO5TBr9FrsiiN514BEkkUbUBtJTwKjNq9KPJiluerRvdq/3BGuEFaqHA
         yfX9JqDGYMrjtROuk2BYen+cosDqvfDVCD2vYNK6wGTisL3xwJ9b8wqClpjaWgl3fRaL
         pVA0m3jgmflHkC/CoRJU+YXNYIZ/3ywZPW/Qj7Ekt2vLUh0RA36bCXF0YCJ5drPGbzzI
         JCOg==
X-Gm-Message-State: AOAM530pq1AglCqLaxltkQ4208xEtcdzkpuw6QrmeUnwvDvkWqmdiWU2
        wPS/S6ZsmlElMQMCzDcHuDh8htDE/eOOKQ==
X-Google-Smtp-Source: ABdhPJwZJB4LH4yiPQffPReXiRoOUb6KG4M5ymGHWB8G0IT80tylGOG6A+Wp5C/yg1x2Kl2fApCQWUDEdiGhrQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:4c4e:0:b0:39d:21c4:2381 with SMTP id
 l14-20020a654c4e000000b0039d21c42381mr2994206pgr.566.1649954498592; Thu, 14
 Apr 2022 09:41:38 -0700 (PDT)
Date:   Thu, 14 Apr 2022 09:41:36 -0700
In-Reply-To: <xmqqwnfs4kud.fsf@gitster.g>
Message-Id: <kl6lh76v8vnj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lv8vc90ts.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqwnfs4kud.fsf@gitster.g>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com, Taylor Blau <me@ttaylorr.com>,
        martinvonz@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> Martin observed that, viability aside, there's another approach that I
>> haven't discussed:
>>
>>   == 5 Disable bare repo discovery
>>
>>   We could introduce a config value that disables bare repo discovery
>>   altogether. This would only disable _discovery_; a user can still use
>>   the bare repo by specifying the gitdir (e.g. via `--git-dir=.` or
>>   GIT_DIR).
>
> Does it or does it not count as "allowing discovery to do its job"
> if you go to the directory, knowing that the directory is a bare
> one, and expect Git to work in it?
>
> I am guessing that your definition of "discovery" is not even
> consider if the current directory is a repository and always force
> the user to tell us with --git-dir or GIT_DIR.

Yes, I mean that even the current directory will be ignored when
discovery is disabled.

>                                                I am not sure that
> is realistically feasible (I am thinking of cases like "git fetch"
> going to the remote repository on the local disk that is bare to run
> "git upload-pack"), but if the fallout is not too bad, it may be a
> good heuristics.

Good detail - I hadn't considered the impact on our own child processes.
I suspect this might be a huge undertaking. Unless there is significant
interest in this option, I probably won't pursue it further.
