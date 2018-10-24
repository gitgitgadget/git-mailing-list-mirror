Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EE21F453
	for <e@80x24.org>; Wed, 24 Oct 2018 05:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbeJXNio (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 09:38:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45098 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXNio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 09:38:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so234320wrw.12
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 22:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DXNJvTA+Ni6UBTHzJYd+vjLbqLyxykzipPFM1IKqeYs=;
        b=rUog98E4swyqCoSTO/mzLi4+bGsW6QBwmOxuPMqJ3SShU8eWivrI3EUd7FKjFe3Jf9
         idHMoADDrvxkz53AHxRMbHNf7wjIf+4bd9FxvoafPtCDXscN3xzQLs9W8nCWrQeLYfPz
         JNlsMhu5XnMDYpaR8apIGCLZy3LaBbG6UJt87UzhMwrKUqplxUX1/nBNjNNLioWQgOx+
         MhU6z57GsgWXhbVu5OHXA6k8J8XlC9zCg3NP/xEpVyc4CyIrXM/P9Xyfx2o2ZNmUctWV
         nK1IK+F/wvGWPWbAqQJ3wSSZERJwAVdrL6+NjHs/zStKqNInb0iMnPzMJGRxX0tFRHwP
         0euA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DXNJvTA+Ni6UBTHzJYd+vjLbqLyxykzipPFM1IKqeYs=;
        b=j6D1xLdNNqmQ0pukLDGsXndGITWsV4bBRToGPeb0JB2J19d9g9Ob+WlDV9TK66pXN+
         jQ6ImR4KJEm4oGoT/ycAPMlzrglhMa9Q7kuGxQ9Tw5WyqVuuua4v12Og0GtjkH5RPo4j
         qEFaRnuWufq1qeYa2tp7bOc/hOI6KZh2pDfGl4PEa66MdUrJrDdH+gbg3belha5K50E8
         mAROmOkzMtOenOH+P3ahT/G66QcR7DKbXbkN4wllOUF/iEUwelolTohzCQetEwpYf2I0
         Nd3Qj73cxGSuYKM7SfQ9Yer94JX2glnMtqfFUtz5AB2Y7ZxbgBSGFDJ0ytWJ2528wtsM
         t+rA==
X-Gm-Message-State: AGRZ1gKILNeqpGG9z4GNRpgPlmOyXGP5zgvaROUTBg5hJOR+Vc0gH1ao
        OKIaeI6Qz/59zuKhs9DhyKY=
X-Google-Smtp-Source: AJdET5fzLDQ+wt82XQeg8oMWisvjP3r1vqGF2En9mBvWDbkaUCtm6WKXMzXubr/OW4LksjdcuNZc5w==
X-Received: by 2002:adf:8521:: with SMTP id 30-v6mr1050162wrh.284.1540357933408;
        Tue, 23 Oct 2018 22:12:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y64-v6sm3931485wmg.28.2018.10.23.22.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 22:12:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
        <87in29dj55.fsf@evledraar.gmail.com>
        <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
        <20181023140710.GA7073@ldmartin-desk.jf.intel.com>
        <xmqqh8hcqeho.fsf@gitster-ct.c.googlers.com>
        <20181024024309.GA22379@ldmartin-desk.jf.intel.com>
Date:   Wed, 24 Oct 2018 14:12:11 +0900
In-Reply-To: <20181024024309.GA22379@ldmartin-desk.jf.intel.com> (Lucas De
        Marchi's message of "Tue, 23 Oct 2018 19:43:09 -0700")
Message-ID: <xmqqtvlcnd1w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lucas De Marchi <lucas.demarchi@intel.com> writes:

> Your reply arrived just a little after I sent the v2, so I thought it
> was just the race and you would end up seeing the unread email in the
> same thread. Sorry for not including the msg id:
> 20181011081750.24240-1-lucas.demarchi@intel.com

OK, then I am not surprised that I do not recall seeing such an old
message ;-)  Let me take a look.

Thanks.
