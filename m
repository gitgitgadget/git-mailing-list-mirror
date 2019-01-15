Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409661F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 22:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391033AbfAOWfU (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:35:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40140 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbfAOWfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:35:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so58515wmf.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K7edWKmzE8tpllDwIMWEuyeR6k9mDMODQQLFDOaEwEE=;
        b=k4kNzeE5gFk9bDaFjjpLEpm9PnH0T86HrbqNxSiEVD1UtuBBMcuIkx5cZcHloQgCH5
         xyfEPg6ImoKkB1V4h+RbfWVHPc/wIvGcGEzNQA1Pzc3Nuy4BSPQTbKLvMBgsEVQ9rdVK
         EgQB6fjVsMtNbn6+9LDl7B2iEhZEw9aZYX35G1r7bHBijk1t7Yagy3n7oHAuAjlBXksx
         toTfY55rw94OSUHYrRGuXvi9gDpiHqh+Wj/Cx5fEqUtAIqK9mFCnJivg6qIPKrN0Rmsq
         Fccd5yxtJ+byyK8tNsZXrIZ9smz5cooEKD9JIaAsJreb/ERssLl49kKeY3cqJWEA+usN
         Stjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K7edWKmzE8tpllDwIMWEuyeR6k9mDMODQQLFDOaEwEE=;
        b=XOFIXtWYHnqFH2fC7pOv2OHMT77ESPUSsE1onPkeoHivjq+xRYlKGzO+Ba6z94XGHC
         fgw2cHssghyj2PNqMRnPcw6+knGOMdBp5rKfWrSHrtnP/nFBv8wjSfjUjgdCc0CCoqdo
         ZVymqy+8iSuPmAukf3Ptsw9FF99+hCZ85/OVyEaBj8cPnSxwb3Eg9pZyQYqdwJyrT67M
         FEG6xK4j/BYqbmgW/wuAvh6NbFDwyITqM0WGiCcaGb54KXfUsVPRrXHHTpT23tDNR35x
         gnVnUC5p2BqtnV4X2RbwmQWycU9xkvtQFaMWH2zVNvUTU1rH8ZGVx32aj/J9szKBq9s1
         vy/w==
X-Gm-Message-State: AJcUukdPER43MBOC7cJsTS/b28BZdJeXjn6MEV3+tElzMs/09OhTP6Qf
        z2VGpVWUWVxZ5ERg0/8W40A=
X-Google-Smtp-Source: ALg8bN65nQBXLz0cXGrcnHhuE6TjX5KXfTd92UOT7cIucY66P2Vx9AKGf5PFSiZR/XlJOGV13uST6Q==
X-Received: by 2002:a1c:16c5:: with SMTP id 188mr5146982wmw.69.1547591717832;
        Tue, 15 Jan 2019 14:35:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n82sm33643511wma.42.2019.01.15.14.35.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 14:35:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
References: <xmqqa7k1r5h9.fsf@gitster-ct.c.googlers.com>
        <20190115220835.61384-1-jonathantanmy@google.com>
Date:   Tue, 15 Jan 2019 14:35:16 -0800
In-Reply-To: <20190115220835.61384-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 15 Jan 2019 14:08:35 -0800")
Message-ID: <xmqqva2ppn17.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Jonathan Tan <jonathantanmy@google.com> writes:
>> 
>> > Like v1, this is on origin/ms/packet-err-check.
>> 
>> By the way, when merged to 'pu' as one of the earlier topic, t5409
>> starts to fail under --stress.
>> 
>> 	$ git checkout 'origin/pu^{/^Merge branch .jt/fetch-v2-sideband}'
>> 	$ make
>> 	$ cd t && sh ./t5409-col*.sh --stress
>> 
>> This is not new to this round; v1 exhibited the same symptom.
>> 
>> Thanks.
>
> Thanks for checking. I don't think this branch is the cause of this
> issue, though. I ran the same stress test on both:
>
>  - f3035d003e ("Merge branch 'sg/stress-test' into jch", 2019-01-14) and
>  - the result of merging sg/stress-test into master,
>
> and the test fails with the same result.

Interesting.  That is not what I am seeing (as I manually bisected
the first-parent chain between f3035d003e and the tip of pu).
