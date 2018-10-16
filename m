Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA871F453
	for <e@80x24.org>; Tue, 16 Oct 2018 03:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbeJPL3q (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 07:29:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34219 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeJPL3q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 07:29:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so24329203wmf.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 20:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0cYup1oVbfUFRrCEu1ZhPFdBCf3+pl7ZhG7bmKQiBjg=;
        b=JT75diDCSB5d2cAhZQcwmGbOUkulzHA5Q/zrCZaZuf3u+RsVn5RE8aYrDQXqYrO5Ng
         IJnz5b4NZ4jDn0VFPbtDNJfctKoLQcLcCw1hNWzWiJWb0B5ZKNaVni7QEEMGXf2Us0CQ
         uxw7Qn5x8+HpTFltV+N1d8CW6rcGTz3Ew6pGpo1wzX3IJ7SO55YaqaQmkj/zGG1E/V1e
         k5v3qMaHEEvah0tpmepYW/AE1cv6lt18uEqErp41dd4S00FXfLR11zobWfardwSJ8Qte
         3znWIbHmik6/y6lo29rY0OwaVFJsxNwavkhCb5FeULh3leTT/Mkiy3VGayCR03TBnHu1
         lU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0cYup1oVbfUFRrCEu1ZhPFdBCf3+pl7ZhG7bmKQiBjg=;
        b=MRraP5dNdHTvSIapnTtPfbvDtCjRpjtWoRYsGwByQfHlm09thFrE9gm6WfVwJ/72CO
         onvJ+DJVEL2EFLl9S06/UGQFhDGSP001+r/wYQl/snn15ZY39KoDqdzYPw2kNr38POHX
         CLmNqLI9WNJmsEJ9dxSpRFnRTtDOadZsEShH6WJeLSUaL792LC+uS59gHNpV8d5ZrmnV
         KDPgw0lmujicmgID4KLYFWlCiJzkgp30qLJ3Fc5JPs++jS4Zta3VI9lhKVCmXosQ0KcB
         wSZ6DGSipGwAT2izY0A7Z3sYTSiTlMZT39pIrO0Rfmf5cFIbR5RMnAc2sqDjZ3RlrBQm
         EASg==
X-Gm-Message-State: ABuFfojnh0Fw8NbmvM1NGEZkWWsgX0fBQQmzQDRxbaDmKPenNtQSE3N8
        A/tuLS6lIr+Z2AQHaD6FW/U=
X-Google-Smtp-Source: ACcGV60RS3jdA2dqh33PvA0Fwy5fiUEvBnbvRLUeyHeEQex6CcedTKCwCluPZCVo8xIFsDclWl2HTw==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr14452397wmf.114.1539661288459;
        Mon, 15 Oct 2018 20:41:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i7-v6sm15396266wmd.41.2018.10.15.20.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 20:41:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v10 00/21] Convert "git stash" to C builtin
References: <https://public-inbox.org/git/cover.1537913094.git.ungureanupaulsebastian@gmail.com/>
        <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
        <20181015221040.GD4883@hank.intra.tgummerer.com>
Date:   Tue, 16 Oct 2018 12:41:25 +0900
In-Reply-To: <20181015221040.GD4883@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Mon, 15 Oct 2018 23:10:40 +0100")
Message-ID: <xmqqin2236e2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 10/15, Paul-Sebastian Ungureanu wrote:
>> Hello,
>> 
>> This is a new iteration of `git stash`, based on the last review.
>> This iteration fixes some code styling issues, bring some changes
>> to `do_push_stash()` and `do_create_stash()` to be closer to API by
>> following Thomas Gummerer's review of last iteration [1]. Also, there
>> were some missing messages [2], which are now included.
>
> Thanks for your work!  I had two more comments (on the patches
> inline).  Once those are addressed, I'd be happy for this to be merged
> to 'next'.

Thank you for your tireless reviews.  They were quite helpful and
reasonable.
