Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9A11F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBLRSM (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:18:12 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39287 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbfBLRSL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:18:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so3566462wra.6
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qxxK9vGDeN5cA8ME4/AMLdlTGcwQAQe6rpRTDD7xMZs=;
        b=bE1hT5yO0aorxfvI1ijpB1vAMhehkSyGdIY4D0Dn9xdyYs8nPf6tzTB0IfaVB0NmWn
         NHuzxJF40pohKJAcks77BGXA/5jRV9dLX9GfL9Ji7k78LtG9XTNP7Y/DUI759KYWvZPc
         rIB+J4yMAe1NQpSeT/S76bWfUjm/qUqMtGW8386myGIQQFymEkMSq6Mp/U1hBsh2kBXI
         f3QcV0zw7gxyZcN0xIaYVockU2F3pYNek22In84be6oDOI1Ou9+mNGVMGY+UUNX//uaz
         n0LzvvDtnpffIiysCjLrDFOXox5+slaHw1HpeUkHaRV1XyFb8s97gfuJfhsy9ytiSWBa
         AlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qxxK9vGDeN5cA8ME4/AMLdlTGcwQAQe6rpRTDD7xMZs=;
        b=Q/wy2VA7Fb6YREy/6qORT8iVjkrS6N0D1qqzsMFZVaoHkpy8sL9QdvtdArUqlF9hWP
         7a9jS0NH91qsLLBoVxEx6f4aiKuVZuLPzeD7W/4pQd4SdWZd/N4XrVd0vl8WEjND2eE8
         MvW7DkRgneC+/UL043QYQJFs3lLqJ+teNopYTSSoEHULx+z9sYkCuI6KgvMy8+KUpLMv
         YgzAqzeW4eL5gRM5udmjpqdvVGeKRsCqTV1mBA2M0I2dl3FBI864ODpOExZpLFhADqoL
         6Rh0ySI9kiFw1PLYCsyTzLkH/e1Rg0VFkK5ok5xYgCq7POIeYwI4nOzHT5/QOl9tUyWB
         sSyw==
X-Gm-Message-State: AHQUAuYpzHj0pImmEYPq/Wh9zl2LmlQ2PBXITEILtFvtmQpm8EkMa0YF
        k8XZ/wxNYAgkLkhwZZ7Gz2uGUdSs
X-Google-Smtp-Source: AHgI3IZ+U4KJDP9xKzTd9gP60LPalAoABEHtUwkXMcFX2v4SFxcICinGqNv/yuPUi7w+kkxWIi7e3w==
X-Received: by 2002:a05:6000:1142:: with SMTP id d2mr388516wrx.43.1549991888629;
        Tue, 12 Feb 2019 09:18:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q24sm3082434wmq.16.2019.02.12.09.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:18:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     randall.s.becker@rogers.com, Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 2/3] t5318: replace use of /dev/zero with generate_zero_bytes
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
        <20190209185930.5256-3-randall.s.becker@rogers.com>
        <CAPig+cTMoYMmnHVuay_4RGr_FN-HWC1tN4TPDsNM4vKCH3GzXw@mail.gmail.com>
Date:   Tue, 12 Feb 2019 09:18:07 -0800
In-Reply-To: <CAPig+cTMoYMmnHVuay_4RGr_FN-HWC1tN4TPDsNM4vKCH3GzXw@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 9 Feb 2019 21:07:47 -0500")
Message-ID: <xmqqh8d9diy8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sat, Feb 9, 2019 at 2:00 PM <randall.s.becker@rogers.com> wrote:
>> This change removes the dependency on /dev/zero with generate_zero_bytes
>> appending NUL values to blocks generating wrong signatures for test cases.
>
> This commit message says what the patch does but not _why_. At
> minimum, it should explain that /dev/zero is not available on all
> platforms, therefore, not portable, and (perhaps) cite NonStop as an
> example.

Does sombody want to do the honors?  [PATCH 1/3] would become wasted
effort until that happens.  On the other hand, if this is not urgent
(it is only urgent for those without /dev/zero, and to others it may
be distraction/disruption this close to the final release to add
increased risk of fat finger mistakes), obviously I can wait.

>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
>> @@ -383,7 +383,7 @@ corrupt_graph_and_verify() {
>> -       dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
>> +       generate_zero_bytes $(($orig_size - $zero_pos)) >> "$objdir/info/commit-graph" &&

The original says "skip to the $zero_pos location in an existing
info/commit-graph file, and overwrite its existing contents up to
the $orig_size location with NULs".

If I recall the implementation of generate_zero_bytes in [PATCH 1/3]
correctly, it just generated stream of NULs of given number of bytes.

The only reason why this rewrite is not wrong is because the
previous line (omitted in your quote) truncates the file to
$zero_pos.  That is a bit tricky ;-).
