Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12971207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbdEBEUx (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:20:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36783 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdEBEUw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:20:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id v14so30373011pfd.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0TGXQY5I/ntJZCQ4GqUKkv+grnHj0DsM22E6vm7eMuo=;
        b=Hra6++XzUZqthe7seKYvo03rLmMMGX6SohaY27pfVGqFVxlPw/wPc8PAgZPPdj2dJh
         Q/ndAdX23zm3MJXv5P/+cb095JbFZLxGYnNPRh7xpoqRdDDQvTnRsGjKAEnRMv93UNar
         h4xKyRJ6jZ46Qd+efCEKmYAGLKdwbn72VoypmpIJwkpKNbiLmJFHoOQqFE3bmGJAO3iN
         e0hD0r/IPRwC4Q9GkTxnFsWyIafV/tM3RD9z4MpwIwcH+QNsyxtcZ9ix5Q9KWAw4IaHN
         Ch6EiUYOY1chz7laznkyBs/rrZdyFdX08TfKCX0/HWIxNxbguvN1R2ciL6LTgGmtYdAF
         eyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0TGXQY5I/ntJZCQ4GqUKkv+grnHj0DsM22E6vm7eMuo=;
        b=JxgTrvXzurU3Cl5FMm6JnYqp9sTj4kWHUPr7Ic3sv5xvZKM3llET9yWTux9Gvt8HGG
         tx2Gtw7PGoXaHFzNWhI7pNZ9MQuETiBRjtlnaJilgodYWehhdfXBlkp2+rDlVMmJFkNk
         /gG6LPIluWB7nKdwTUlSurNwVOhZqoFQ1WF7Hph1CMe+c84BA5ZNzIF0nADY761S7iQK
         KpkFIdDVr2UQQftLHW91pZuoPh2bz71VhwrVlWQYUbaKhVFNElf31F1A29RijwtQ560t
         pw3PJ9CWD9GRM+WgD601S4NToyjRPNIyebVam5svjB754cBw3GIhT5KP60vQWZ2CM1Ct
         J9nw==
X-Gm-Message-State: AN3rC/7P5EwJx2YYi/r4D6U4idUNypfFiXyDTy7Ib00S0tqlQ/0SPVGD
        bz+FCG0AfzALLg==
X-Received: by 10.99.60.21 with SMTP id j21mr15847635pga.99.1493698851596;
        Mon, 01 May 2017 21:20:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id l7sm33080142pgn.10.2017.05.01.21.20.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 21:20:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira \(theiostream\)" <bnmvco@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC] [GSoC] Port git-add--interactive.perl:status_cmd to C
References: <CAEA2_RLvjRDytE03hfe84TTqvCQm324BXV=GvTU3UVqNWJUXiQ@mail.gmail.com>
        <xmqqo9vcf68f.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 01 May 2017 21:20:50 -0700
In-Reply-To: <xmqqo9vcf68f.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 01 May 2017 17:32:48 -0700")
Message-ID: <xmqqvapjdh3x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Daniel Ferreira (theiostream)" <bnmvco@gmail.com> writes:
>
>> Reproducing either of these comparisons "natively" would simply
>> require running run_diff_index() or run_diff_files() with
>> DIFF_FORMAT_NUMSTAT and tweaking diff_flush() to format appropriately
>> for the "interactive--add case".
>
> A more usual way to drive the diff machinery and react to its
> findings is to use DIFF_FORMAT_CALLBACK interface, and walk the
> collected diff_queue to work on the paths discovered.  The way
> wt-status.c builds "Changes to be committed" list out of the
> "diff-index --cached" it internally runs and "Changes not staged for
> commit" out of the "diff-files" it internally runs would be a good
> example to study.

Ahh, you'd also want to show the numstat equivalent and eventually
you'd need to spool the actual textual diff in-core, so that you can
present hunks to the user and have them accepted/rejected
interactively. CALLBACK interface is not a good match for that task.

Of course, using a temporary file to buffer output from diff would
be an obvious and simple workaround (and this is not a performance
critical part of the system---we are talking about end user choosing
hunks interactively after all).  A cleaner may be to spawn diff-index
and diff-files and read from them via pipe into core.

