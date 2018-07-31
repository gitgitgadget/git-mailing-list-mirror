Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA31F1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 16:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbeGaRpU (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:45:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34314 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaRpU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:45:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so11460508wme.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4yuAauWI89UcGnUiaBM6/S6DqAqGEarWfIiTDairPBk=;
        b=mHdqnBAN3Rr/jxpzvXyiwL5vmDPOwccp2LQqp4YYLyoilhO+EmSHfEpYFGqrDS2Hvq
         GmrL6kTwJR4il7S4x0MIosCdUyq8GTHTCWX2MbL2n7UMle4y+5+aV81XVGMfSm2vFe4c
         IBvAqVBMJQFd9FjvLdWWnITT76HCUFtxTus9BNEm2mWJYiWrDjjtu6VM+h7k+e6VN/U2
         E1h3BoH2gnyVZFSp4XPlozD70aeaBFCn0//y7b6MyK3bSnLB0fKC2kMu/ScuHstsia7z
         M5pY9AQ8Pklyz02uPWRM7kgvSUbAauIfgLwxxm998xl0XjMNsjVYAEV2W4XOld8eIlm2
         tWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4yuAauWI89UcGnUiaBM6/S6DqAqGEarWfIiTDairPBk=;
        b=PA694j50qdwiCRVrgZgh12JDEUiQtxGb0ADi9GVcrJWFfdUlDGDeQ/xRFaR/XK9VMf
         jmGfjhNOeJTncaPS9m8zj0xeyio4LaN3B0Q+/G6eQOMIg1bnoBKnIvMvbYjk7ZqFbZpj
         cWITqGGeeGaqbOrg/yMZljIUVCqaLymZc0bEBGhWVWgbHs99rsyOzwaZ1ddMk8zEGcEE
         pocxhKRBI8pNCZvWUDHBVS4BjDBTXN8xVPizyjMBrUgreJYF/smEFsb5ggowq5No7frM
         kz3s7l6TeQPVZIehC0a8vsBcxOS0WpYImeX9Ff+FZ/6Oh99pcQgenpnM4Bi+JwQ0hogY
         M39A==
X-Gm-Message-State: AOUpUlFbcL36dBmVzsQ4QMRdcHCnUJCmYJzxz36D8GZG9xiTfEiwGayg
        nxWXSUNEIkURO27ubn2sPXA=
X-Google-Smtp-Source: AAOMgpe79bXonhw1JFqokamqpaTYeiLyc2v4bmB6wzgDB7Rj82+runwBUCNhGGnn1iSepVia7N0/Kw==
X-Received: by 2002:a1c:9e4d:: with SMTP id h74-v6mr225581wme.70.1533053058880;
        Tue, 31 Jul 2018 09:04:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n12-v6sm27298360wrm.62.2018.07.31.09.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 09:04:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [GSoC][PATCH v4] fixup! rebase -i: rewrite write_basic_state() in C
References: <20180730182516.32644-1-szeder.dev@gmail.com>
        <20180731121115.12296-1-alban.gruin@gmail.com>
        <xmqqy3drctu4.fsf@gitster-ct.c.googlers.com>
        <ad8fe398-6e7b-b50f-df96-35ac06049020@gmail.com>
Date:   Tue, 31 Jul 2018 09:04:17 -0700
In-Reply-To: <ad8fe398-6e7b-b50f-df96-35ac06049020@gmail.com> (Alban Gruin's
        message of "Tue, 31 Jul 2018 17:59:49 +0200")
Message-ID: <xmqqpnz3cry6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> Hmph, from reading your other message
>> 
>>   https://public-inbox.org/git/dce8c99b-51e9-4ed1-8ae4-28049cb6e7ec@gmail.com/
>> 
>> I got an impression that a rerolled version is coming anyway.  Is
>> this fix so urgent that it needs tobe squashed in in the meantime
>> and cannot wait?
>> 
>
> I wanted to reroll it first, but the only changes would have been this
> fix and Ramsay’s patch.  I was advised to send a fixup! patch instead.
>
> I can send a reroll if you want, but it won’t have any more changes.

Then please do send an updated one with v$n incremented.

As the number of his or her own topics each contributor needs to
keep track of by definition is the number of all topics I need to
take care of, I do not want to have to keep track of things myself
more than necessary, which would result in missed fixups and delayed
updates.


