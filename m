Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6990D1FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 11:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdFJLM3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 07:12:29 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34118 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751999AbdFJLM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 07:12:28 -0400
Received: by mail-pg0-f47.google.com with SMTP id v18so33321995pgb.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eYQrMEAKcMVaU+xgbaF9WaeEFzrvaW1Ln2qqG928SBs=;
        b=ANr6WzzQcr61qjtWucWGx+YFP1/iqdI6xqZ9o7BBHNYx/lKrwllO7gDdYdWFn2A80P
         xlsKwZy/z25z0ckczBsPnKfeD3mt7z0ZzZvy7OJt2oFRmcJNOACg9aD4OvsE08Q1JlO2
         K5lEioK/tSfQoz03kOU1EU1ZkhGtsiSPi+OC+xKxjT+1rjaz0B9tpwXkGrPRvScoMHfj
         jpwrSJy3CKPpLp4yTe7c/h8klosQoB1/fVMBqGVVOyuRtuEq1IH1sUCNzogXA41QGP/7
         naksTsLW1S+jls6JOr16bNplDvWBsI2RxxOTY+f11bAj6fNRxcp+zZktJFgRrp+3Ws2G
         hrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eYQrMEAKcMVaU+xgbaF9WaeEFzrvaW1Ln2qqG928SBs=;
        b=iA/R4FuPbzkruQYTy3pClYB28OJ4PRw3tKRv52kUldujSe8MusdoA1GGTs3WXAj3R5
         mTkOB3jhvDCC7TnucgphMlC4kfaUuHdqwMXcrmfmgJujmYnTUsneCFmpQLoJ12dSXs3b
         D+JgsDfI+sZVK6V56dnSAAHQU7z3qhg5drDbf9W2+uHXagIvXnxlNd05BL3cC3h8eGlT
         VffcqThXnLnm+1OSu9BMRNBY9tKXdDOK8ZuOqYfwLV2N8wcEsRNwxnXMMC/1Y751E3yy
         HmG324wtEFvpnh+0h/fXoIKfenlZLS+CPvXIlUieDXOjKW84eraUNts8etnQkRJ0QViD
         Xa9g==
X-Gm-Message-State: AODbwcDXmmnlIOnc6uQm6uGa8STJSb+DKjqzNp6TkTThCK6Y6zeFHQAa
        ImqrKi905GcyFw==
X-Received: by 10.84.129.67 with SMTP id 61mr37275169plb.229.1497093147413;
        Sat, 10 Jun 2017 04:12:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id v186sm6431561pgd.9.2017.06.10.04.12.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 04:12:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive clone
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
        <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
        <20170606181024.GA189073@google.com>
        <20170606183914.6iowfhimo5yrvmtf@sigill.intra.peff.net>
        <20170609231935.ysolxkiuhhpa3xrd@sigill.intra.peff.net>
        <xmqqbmpw4mpo.fsf@gitster.mtv.corp.google.com>
        <20170610071342.gdmpgjqlho2xfvdt@sigill.intra.peff.net>
Date:   Sat, 10 Jun 2017 20:12:25 +0900
In-Reply-To: <20170610071342.gdmpgjqlho2xfvdt@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Jun 2017 03:13:43 -0400")
Message-ID: <xmqqr2ys14h2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Certainly I think it _could_ be a valid state. But traditionally it
> caused "clone --recursive" to barf. And from what Stefan and Brandon
> have said, we are moving in the opposite direction entirely, with
> .gitmodules becoming the source of truth.
> 
> I could see arguments for going in either direction (gitlinks versus
> .gitmodules as source of truth for submodules). But it bothers me that
> it's so easy to create a state that will behave in a confusing manner.
> ...
> Allowing both is not in itself wrong.  But because we provide no
> guidance for the expert route, it's easy to shoot yourself in the foot
> and not even realize it. Which is why I suggested a warning and not
> forbidding the operation. Or better still, an advise() block that tells
> you how to recover (probably "git submodule add", though it might need
> to learn to handle already-present gitlinks). And which can be disabled
> if you really are an expert user.

Yeah, the current situation is bad in that having both .gitmodules
file and gitlinks in a tree allows for redundant pieces of
information to go out of sync and result in contradiction.  A gitlink
without an entry in the .gitmodules file is an obvious example.  An
entry in .gitmodules file whose path does not have a gitlink in the
tree would also be a broken case.  

While "git submodule" was the only/primary interface to the
submodule, it was rather easy to explain that ".gitmodules need to
be consistent with the index and the tree iff you do 'git submodule'
thing" (implying "if you only use gitlinks to bind two or more
projects locally without sharing with others, you do not need 'git
submodule' and you do not need .gitmodules"), but with the recent
push to add "--recurse-submodules" to everything, the extent of what
was historically "iff you do 'git submodule' thing" is getting
larger and it becomes more and more important to keep .gitmodules
consistent with gitlinks in the tree that house it.

I find it a bit sad, but I do not think of a better way X-<.


