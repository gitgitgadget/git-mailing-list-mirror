Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EDA01F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 23:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfAOXOB (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 18:14:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbfAOXOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 18:14:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so4937487wrr.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 15:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a7OHkPhqLIWtxTINGMTAOfQUknr6N7ZDpR8CUeEG5Ik=;
        b=Q1gF9HUF2RwXhLtsJQL4vuXkmydp33WziXvk+hXyxdDGuqh2BIsOmUHSVa9iq0FZKA
         xYYzM1tI+naHnqP9a7fOum7kQxeoyvcZZarN+f9m322WrK87L21HTVHbihN3P49QEnGj
         DyXiD7zeNoJxZLjBHa4QkrELjtXLOgdHKb7dkbQridYvf4yhPCvp2u1vFJGcY1yMfpou
         obfpwGuRP8tF2UkBlovA31791D6mWbw04TCJ0NNfpy5NO1HzV3dYBhWYMDH27QfSxh2Y
         Hik8X7ORbgVM5+YsstFPpQ1RL33ZAixxesiwYwCfE9KPuVkRSwRf01jyEh1NtCBKeJMR
         LUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a7OHkPhqLIWtxTINGMTAOfQUknr6N7ZDpR8CUeEG5Ik=;
        b=UdVb9/dGYFUL0cNxLiTyfmoqM9SIw5iF8Cc67PPtrZu9cUZ1uYEGt7uX2ZL7L1hM4M
         PROghwf5S/bN1+RwXp5eD+QCQUD9HssVyKjDaPzdaLawVp+UG3ZQii+tc4E0cAkyihf5
         cc5HTQRMGos5ANyHvafpEZzfQH8fjYe0KhldUBhYGX3DlPB9BerF3muG/mKs2uI/kBfT
         6bmcQZ3s0hDQuGCFglC4FNVsEYSfb2uiapTwCpDVNnBDDqd/s2gvtS388ejJyDWaNulX
         63fxRamP+OIJ87E64JyCQL4B79GKWfHxVmbH2i+GFVdRTSgRh79vDy+xtgnEfUo/vSe7
         XY2w==
X-Gm-Message-State: AJcUukdiMJzz/qKhlbQjf2Yqb0UBuYaNYaZWhxf9MYOmDQCDLqK65HGN
        OLY1l9fCRJdHhdtm6BhWTFeNM3+Q
X-Google-Smtp-Source: ALg8bN7EiE/vEhgFEXFUSCqfJr6W6kqgsW2VoTO2zB/vOkrZBCkJ37XAOYQCtR5gwj/vKK7QHEpDTA==
X-Received: by 2002:adf:afdc:: with SMTP id y28mr4828429wrd.275.1547594038562;
        Tue, 15 Jan 2019 15:13:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o15sm63099848wrp.12.2019.01.15.15.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 15:13:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Sideband the whole fetch v2 response
References: <xmqqva2ppn17.fsf@gitster-ct.c.googlers.com>
        <20190115230239.57954-1-jonathantanmy@google.com>
Date:   Tue, 15 Jan 2019 15:13:57 -0800
In-Reply-To: <20190115230239.57954-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 15 Jan 2019 15:02:39 -0800")
Message-ID: <xmqqr2ddpl8q.fsf@gitster-ct.c.googlers.com>
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
>> >> Jonathan Tan <jonathantanmy@google.com> writes:
>> >> 
>> >> > Like v1, this is on origin/ms/packet-err-check.
>> >> 
>> >> By the way, when merged to 'pu' as one of the earlier topic, t5409
>> >> starts to fail under --stress.
>> >> 
>> >> 	$ git checkout 'origin/pu^{/^Merge branch .jt/fetch-v2-sideband}'
>> >> 	$ make
>> >> 	$ cd t && sh ./t5409-col*.sh --stress
>> >> 
>> >> This is not new to this round; v1 exhibited the same symptom.
>> >> 
>> >> Thanks.
>> >
>> > Thanks for checking. I don't think this branch is the cause of this
>> > issue, though. I ran the same stress test on both:
>> >
>> >  - f3035d003e ("Merge branch 'sg/stress-test' into jch", 2019-01-14) and
>> >  - the result of merging sg/stress-test into master,
>> >
>> > and the test fails with the same result.
>> 
>> Interesting.  That is not what I am seeing (as I manually bisected
>> the first-parent chain between f3035d003e and the tip of pu).
>
> Ah...yes, you're right. I forgot to build before running the tests. I'll
> take a look.

Thanks.
