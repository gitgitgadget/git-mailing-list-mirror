Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1F020248
	for <e@80x24.org>; Fri, 12 Apr 2019 15:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDLPCt (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 11:02:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLPCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 11:02:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so11414876wmk.4
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7kK1rIodHEAEOug8mP8b/kiqTU1U/6b+I7V0HIfWRWs=;
        b=jiqxH6g1CKfsNBAosC8Sl6N4ogchsu3U/G+pxtVtn2bq2Tq/zSnb/66o4eh1PApnSE
         yW1FntQYGXI2PAe/dMMxCVVAH5h2dZfvbqHR5T5SYe7tAP8yt6ESJVPGUrtFSDBM6a09
         NOkWhckSGzEbyc2grHxpBaNg5BEUkFNgGyGf3DNMWjvestTu3RpXioP+tcX/3OtP+JhO
         rrD1Mf8SXLO5HKUiqEuzeNA2ca3rIKGtvl9s7xmnIqwkUjcPBJprBLXQtVM9teWnXhiW
         Bw9E1HrE9BQCqGI9SVgY+V3O5KPMqZpU61XyBGGwIjOQRSkUcV/Ic9r0ige1NBCbuVxF
         hFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7kK1rIodHEAEOug8mP8b/kiqTU1U/6b+I7V0HIfWRWs=;
        b=gBg+aGIT+cEWjkIqSKyiNZy8xoTFnHMzWLDZM+D1CTetDaE73/h0f0S7CwtvTcnlmr
         W5TI2uMTyT/8X7JOZKkic/W79WkcFd13xyyllUWhvsr8CkVT85RxBNRq8cCIJr+u26qA
         iJ5Ii5H1hiTsqLrHOUrk6x1uyQfV+FN0NfMMpgt9JNNBW4EUv40oVnuTOrpL7s7OHgNS
         2LR2VUMWzPK8FsjPc3Z7G0FpbjoZN9T/2UlJ8QfU6tcY3w/uvOeDSgRgqWyDGEdlpqeX
         pJANeTOq4slPJfwPYN08b1SuOJLKtm2lzftGHuMIc/dTuymBfbsRz4J5Zjz6wQCbkcj6
         COhA==
X-Gm-Message-State: APjAAAW4XqFYtNYQF3OuFxAfEkgOYhQkjlP/53NSSDzMkcb3D6iyqHdS
        1RhZOOwzspZ9MOKZp4bUzqI=
X-Google-Smtp-Source: APXvYqyfSaCWF9775ZGh500599aJ2p9zyquJrhggLSoNaD+eMT/3ythfT1Ncn4FvfBHAs9B/xTGg4Q==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr11180530wmc.1.1555081367184;
        Fri, 12 Apr 2019 08:02:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id m6sm52956476wrr.53.2019.04.12.08.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:02:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: incorrect range-diff output?
References: <20190411111729.GB5620@ash>
        <20190411220532.GG32487@hank.intra.tgummerer.com>
Date:   Sat, 13 Apr 2019 00:02:46 +0900
In-Reply-To: <20190411220532.GG32487@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Thu, 11 Apr 2019 23:05:32 +0100")
Message-ID: <xmqqo95bxo4p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I'm not sure what the right solution for this is.  I think one thing
> I'd like range-diff to do is to add the filename, or some context
> (e.g. is this part of the commit message etc.) to the @@ line (not
> sure what that is called?).

Perhaps the inner diff can be done with the usual funcname/xfuncname
logic so that the real function name of the payload is on the @@
lines (they are internally called "hunk header" lines, I think).

And then the outer diff (i.e. the one that compares two inner diff
output) can use a special funcname pattern that says "treat the
lines that begin with '@@ ' as the function name line", instead of
(or in addition to??) the logic that says "lines that begin with
'diff --git' have interesting information" which led to a misleading
piece of information in the range-diff output under discussion,
perhaps?

