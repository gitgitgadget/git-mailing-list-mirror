Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E04A1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfAVXSW (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:18:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53185 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfAVXSW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:18:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so251775wml.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QheQtYBgpyM71XCLEJ/8Vzp/tgxaMrYywqlgXm02mQM=;
        b=kuDfVh3w7CuaFrmbMABA7BdzXc9Uh2Oq1DXeJ9T4sUDCSV5p0dhrJCYdS+lLw2GN/U
         9OX2Gi6PrSFNIHdRgk1n+wl8YF4xCG1KibJffLUlFUI6Mi+p49GKfwP5JjZXb+Cr7ZrM
         JMzf8Nto5qEB3BAg5HG5EVhP0HRVzzka+3iLapw/CzkvxSEuubQKFy6Wi+wq/4ovOLbb
         An6H9xY8cQ9qEjP0SMec2iY9C4QpiBXTfz9RSzqzxl558iULfGuc667EVm5OnqpJNUhv
         eW2qdPzQaSFIIxYNmXrdFVCqyaiZmdIX93A1EFTNMoPyZZpheNwy5NyDrJfwvU4a7MqE
         uLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QheQtYBgpyM71XCLEJ/8Vzp/tgxaMrYywqlgXm02mQM=;
        b=Kzt/G0VPfDDTsSt8QWBWVWx5qWLkxSpY5lcOOjcbWDAc4fxrorAhURIMOTonFTdf8d
         n71lm5axwVCdJT0DGMdOgptPTWlK1qpPau6FvfDhB8EHPp1LkSI+/rrTI36wuMqITvv7
         L7bD+chTEDyfWmLwQK0s2Gn1AZwKxd9qlDCk3dOrkaXnhuXRCHLVqpFkEQA00kPWiCOw
         nVV095zEFH+QOne01iB7Whs0KjyE1RlaTa+QW3x5EbmUQuhezpUj7U/nHsF+nIzkSq0i
         e8DmjJ36x2YE+Vzc7T4+cR3uI4Q20mzePIxrOkhZCYzvJPbStX6CM9FKttZaUtnxZy5p
         6lIw==
X-Gm-Message-State: AJcUukdcms67D1KtyDjrHpqbp9tTolufjrhOJIRxLKirKgY8l+iNVBeH
        UaV6MmT+2eIbbaJdNOJi4Tc=
X-Google-Smtp-Source: ALg8bN532G2252H5knSLUdqM4zA2iMOK36vc4vAmyBOx64I+APaLquInUNSFRcTvUA3tSiqDbylqNw==
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr408228wmd.66.1548199100103;
        Tue, 22 Jan 2019 15:18:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w12sm85391004wrr.23.2019.01.22.15.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:18:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] diff.c: simplify diff_opt_break_rewrites()
References: <20190122002635.9411-1-pclouds@gmail.com>
        <20190122002635.9411-4-pclouds@gmail.com>
        <xmqqtvi0e7sv.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 22 Jan 2019 15:18:18 -0800
In-Reply-To: <xmqqtvi0e7sv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 22 Jan 2019 12:50:08 -0800")
Message-ID: <xmqqpnsocmdh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It would make it even easier to follow if you did
>
> 	if (*arg == '/') {
> 		opt2 = ...;
> 		arg++;
> 	} else {

Oops, this should read "else if (!*arg) {", of course, to match the
original.  Sorry for the noise.

> 		opt2 = 0;
> 	}

And then we'd want a blank line here to make it clear that the
previous if/else cascade has finished, and the error checking we see
next is not part of it.

> 	if (*arg)
> 		return error(...);
>
> It makes it clear that opt2==0 means <n> form and not <n>/<m> form,
> by having an explicit assignment while we parse what *arg points at,
> without the initialization to 0 in the variable definition.

