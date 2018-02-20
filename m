Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748D31F404
	for <e@80x24.org>; Tue, 20 Feb 2018 23:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeBTX3r (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 18:29:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37087 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751860AbeBTX3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 18:29:46 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so12933762wrg.4
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 15:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1aGTrABI5Ij8XI+VtrD4AGu3QB0PIpk3hlPaLcFw7ak=;
        b=Pw//z1gpqjzifYNGRlyuc1JfKWDCMvgV+nnak/ZdMcMTtgLewlVvhJTYA1NtZ9wlyb
         Rt+xQUwLySfEon7WdlvcvgvqKCBwalWIG0NDsnbKMHtMlaNxOQGQ8XFTLv66jngl2Dbo
         S54giUyb2qKvBIryo5kgHBVP+U4EYz5exAPpra1ZBVJ5N9rG5flXcsXpWS4RV7cZQPuo
         Et7sW40TffJ9dDGsERovA6eeH5Fuq3IEmSrHRUz91mGULZ0INHirz7JvhgnylcypEQNQ
         rVmozijwPnQDiSdqtxJ/BD8LyLMAhlZwsFgdtPYtZZ5xZnWhh23fRennfMVR9ZuosA45
         QO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1aGTrABI5Ij8XI+VtrD4AGu3QB0PIpk3hlPaLcFw7ak=;
        b=BXaPHgjMJ2u+kWlx9XDFde6RTxP0NbcVf0Kyl/9c/P0uPWGlHihjWq1PGiFLUJt82D
         VfRqNYon87XbjCERDMsTtqfSDdWwbAP/xoqLq6K5TmnCNS1rDfKBXwMCSh1S2GrhQjge
         QljjYF2wkUHctdoZefg4OGqODJZ9M+sk2JXI4pVaw08LeRGv2P96pz4qeX4L73ID/mfd
         sfUpmek/cfoV50T4UW4ZQHDncVpn3v+hmXnGLYBRMFTVkp08RcsayFs1z//M4bqn9ckG
         WmXtMvm1VwRYBWtYjc2GWhKodMoEFEkC8orKwzVA46r6Fydhp5mI/RYEvG6qUHNkCzJe
         2yNw==
X-Gm-Message-State: APf1xPCr8Zf1SyCueHjPLR/Yx25MKJjYJFgFN1fNnpHkbf2FlLksNeUd
        V0+qBtK3IqzqbC+WBK4ra6oxpR0k
X-Google-Smtp-Source: AH8x224YZDW6GSQcsGlOlcCaa9k71RK2vB/Qc1dpHrLRa9qFqYJsjV0/Tb3nakJbEr6YSgEZ5X88Ug==
X-Received: by 10.28.41.3 with SMTP id p3mr489467wmp.140.1519169384625;
        Tue, 20 Feb 2018 15:29:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u20sm4339797wru.94.2018.02.20.15.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 15:29:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH] tag: Make "git tag --contains <id>" less chatty if <id> is invalid
References: <20180219212130.4217-1-ungureanupaulsebastian@gmail.com>
        <CAGZ79kbXXN_nxFZUorsbFHcg4-8H7ZnAOnaViUrnP4r4u6ThhQ@mail.gmail.com>
Date:   Tue, 20 Feb 2018 15:29:41 -0800
In-Reply-To: <CAGZ79kbXXN_nxFZUorsbFHcg4-8H7ZnAOnaViUrnP4r4u6ThhQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 20 Feb 2018 14:35:49 -0800")
Message-ID: <xmqqinar1bq2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> diff --git a/t/t7013-tag-contains.sh b/t/t7013-tag-contains.sh
>> new file mode 100755
>> index 000000000..65119dada
>> --- /dev/null
>> +++ b/t/t7013-tag-contains.sh
>
> Thanks for adding the tests into a new file instead of putting it somewhere
> where it is already convenient. (We have too many of those "just add it there
> as it is easiest to fit in")

Careful, as that cuts both ways.  We want to strongly encourage
people to see if there is already a place that is a good enough fit
for new tests before adding small test scripts randomly to consume
the test serial numbers and test process start-up cost.  Only when
there is nowhere appropriate, we do want to add.  And if this covers
both tag and branch, then a new script may be appropriate but it
shouldn't limit its future enhancement (to test 'git branch') by
having 'tag' to pretend that this file must be limited to 'git tag'.

> So I'd expect the return code to be 0 (if we don't care) or 1
> (if we do care), in the case of 1, we shall write:
>
>   test_must_fail git tag --contains ... &&
>   grep ....
>
> (A long way of hinting at the test_must_fail test function,
> that lives in t/test-lib-functions.sh)

If you are looking at error stream, it is very likely that you would
want to study test_i18ngrep and use it, as errors are fair game for
i18n (and possibly coloring, which is a near-by topic).
