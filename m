Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10672082F
	for <e@80x24.org>; Tue, 27 Jun 2017 03:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdF0DA0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 23:00:26 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34751 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdF0DA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 23:00:26 -0400
Received: by mail-pg0-f42.google.com with SMTP id t186so8918259pgb.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 20:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NfPCz7HjkTA2Os7rm/FS0pBPcQvex9npZIdPue7UsMk=;
        b=FT7D7z8xGvhMJg+wgGredOj5ci1JKxVJ0uNBkd2wyAIkk53RN+fbOf6LfU4wBBiT2E
         8Jxnsu2BPyqfGypzfxxYL3oJmd9v/nf3WdH+QyzrcRnUazdwlOP2p48FSzBWhspAKUcT
         qMPbpk/3tNLj3Y3ddToFzqW86W7mvw4DnOxFCWhYX12ep6CCNdvxCPqmwHLCmMMv2nvE
         sRleY7MlsyTVW6r1XrqDBJEyNrc6lavkfYgFGLohw+sFfW3znnmbv5tinA68XCDPdBu/
         p2B5XIDJAzsuz6mvkQD5YVx/JK066FmRbEFeF8EMlikzdS//qaU6pbJmxzdhwbTizJb8
         TXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NfPCz7HjkTA2Os7rm/FS0pBPcQvex9npZIdPue7UsMk=;
        b=MVGmOF1pWJzFHhjCp7f2wiFTN2GDRyjx0nENjRequdVF8ylTCp1QFANXkTm/bccGd6
         DJ3M0dt5xGxDMyfXpkLAzyuYV0UMXfXwxstn7QuPKjN9IPPQJdCNDkh0Z/K7cw9rC40K
         JVIs0tqVdQxcVxVl3dV9q8mMVrmVUUJZBqLoIIMYUazfsgR7EhwhiHeCKTLAwAhKxuzZ
         NI6oayn9EdHP/BgwwNPXwmCkAyXqyrHMf68T/W/iwYd2kUr+0xpRkXpJqNyXLBQikDzW
         R4Du0wQXqNHtWv9Pf+GPc/q5tfNCeFBS9/9HYyEyb8kbrd3EUZc8YX7BU/AcaecdHMQU
         c0jw==
X-Gm-Message-State: AKS2vOz6cz4NwpbKF0beMRa8lu1gBN2QZafhIqs4KlC48NZaoH+cjVxx
        KQyWRCzbiKD1jMLlH3N/3sIwR9WnUM0W
X-Received: by 10.98.19.136 with SMTP id 8mr3077963pft.105.1498532425193; Mon,
 26 Jun 2017 20:00:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 26 Jun 2017 20:00:24 -0700 (PDT)
In-Reply-To: <xmqq1sqab436.fsf@gitster.mtv.corp.google.com>
References: <20170623191302.16053-1-sbeller@google.com> <20170623191302.16053-3-sbeller@google.com>
 <xmqqo9tebaco.fsf@gitster.mtv.corp.google.com> <CAGZ79ka+va5bRNQL3x3fvn+738iAfJXJfD2PKpt2hmGEg09mTQ@mail.gmail.com>
 <xmqq1sqab436.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Jun 2017 20:00:24 -0700
Message-ID: <CAGZ79kZUkQCEEcLUcg8tSr33Wng1Fq4_i4n80+Xr45y0mcvB6A@mail.gmail.com>
Subject: Re: [PATCH 2/3] builtin/fetch: parse recurse-submodules-default at
 default options parsing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 5:51 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>>>       if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
>>>> -             if (recurse_submodules_default) {
>>>> -                     int arg = parse_fetch_recurse_submodules_arg("--recurse-submodules-default", recurse_submodules_default);
>>>> -                     set_config_fetch_recurse_submodules(arg);
>>>> -             }
>>>> +             if (recurse_submodules_default != RECURSE_SUBMODULES_DEFAULT)
>>>> +                     set_config_fetch_recurse_submodules(recurse_submodules_default);
>>>


>
> I am not talking about the outer "if" condition.

I agree with your analysis, my answer was evasive.
I'll dig into the details why we do not set the default by default.
