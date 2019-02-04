Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 909281F453
	for <e@80x24.org>; Mon,  4 Feb 2019 18:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfBDSrY (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 13:47:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46458 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfBDSrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 13:47:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so932205wrt.13
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 10:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lv/oKoKkPkHHRz026o70hBqK/UNU/8Y17yG7nson22Y=;
        b=hP/98zIxyd0d1z+WZN5K6iPAR1rWmJE38bEH9p+hLSn/H2TrDWININOAca7jMqaCjy
         60LpkGjbw+x3F+SmbOjpSiNESwFZLgNOTR1PH9ydyM6GxZKrsmqsbeMvhpyuBmJYD6uk
         UM8GvS2yMccn2wAYnZVgO+h43s0rXNTDqCRBFRQGdS1C5b0cufbqY1QoBuwaxqznv1fg
         bjnIHz4UeNh1GpkDwmgk3BGGkTevNvgPxrQnpYZjAfsw52G+TTgNNezVyiYCoGq379I5
         kcK9dLmgCfJ4N9KYJvvUr+6LB0ps+qxyUBKvfdeY4oSPXLjbxHPLb6V4+Xtn/QBCTiXg
         H2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lv/oKoKkPkHHRz026o70hBqK/UNU/8Y17yG7nson22Y=;
        b=AZfO63HQxhB18SwYKJzGziTSYum7vJNyBwrEiSTldMM2O56ntVMh/l2yTaYMHRLru3
         jQcTdHPqSslKBDvYFvi7eZu4S7DO+GzBTdxnT54AT8m8/RzC9bzfJCSwxvk31Vlb+ztm
         39+2ntgVGnbrKk9wwZcnKKkaKnVHWCJSY7hH4YQN39lhPeBoJJjPprYU1WRlmYhnRuQV
         eNOYxTCDH+e0iRcCpAY4ZrDQy4RIRB1aPvLQ6H+GFEhoY2jHvMqxKEuJGRAKLuVDD/4U
         mx3rUicaO/T5/NoDGl5bCA6Gc3L3gQ8HHdo/N90F/zRiPh8d5eg8oPcb8/IU8Bq1XMOn
         rHNg==
X-Gm-Message-State: AHQUAua8sof972eoqlRDeqTLBEC8s2cp2UdSMKQz45crTPj9oFAX4xJx
        CPObJj4csbhO3cGT0VGi2xT0KXAO
X-Google-Smtp-Source: AHgI3IadWlLIws2jAb4i79zV9iwYVW30xyCEEJC5+mAsIFhEqw/FNhf9MOLeFYOaAH8rJqkTFw15cA==
X-Received: by 2002:adf:aa44:: with SMTP id q4mr555988wrd.307.1549306041666;
        Mon, 04 Feb 2019 10:47:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c18sm9022857wre.32.2019.02.04.10.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 10:47:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sven van Haastregt <svenvh@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v3] git-submodule.sh: shorten submodule SHA-1s using rev-parse
References: <20190203210027.13272-1-svenvh@gmail.com>
        <CAPig+cQXuzMwZjHa3n+DwRFL3E76U8uAvhiFiC5S=B23f03Vnw@mail.gmail.com>
Date:   Mon, 04 Feb 2019 10:47:18 -0800
In-Reply-To: <CAPig+cQXuzMwZjHa3n+DwRFL3E76U8uAvhiFiC5S=B23f03Vnw@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 3 Feb 2019 16:28:13 -0500")
Message-ID: <xmqqftt3v1ah.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Feb 3, 2019 at 4:01 PM Sven van Haastregt <svenvh@gmail.com> wrote:
>> Until now, `git submodule summary` was always emitting 7-character
>> SHA-1s that have a higher chance of being ambiguous for larger
>> repositories.  Use `git rev-parse --short` instead, which will
>> determine suitable short SHA-1 lengths.
>>
>> We cannot always rely on successfully invoking `git rev-parse` in the
>> submodule directory.  Keep the old method using `cut` as a fallback.
>
> Reviewers and future readers of this patch are left in the dark
> regarding the circumstances in which git-rev-parse may fail in the
> submodule directory. It would be helpful for the commit message to
> explain this potential failure in enough detail for someone working in
> this area in the future to understand any implications of changes to
> this code.

Replace that problematic sentence with something like

	As a submodule may not be initialized with "submodule init"
	or not cloned, `git rev-parse` may not work in it yet; as a
	fallback, use the original method of cutting at 7 hexdigits.

perhaps?


>
>> Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
>> ---
>> Differences since v2: Simplify code as suggested by Eric
>> Sunshine <sunshine@sunshineco.com> and suppress stderr.
>
> This version looks better. Thanks.
