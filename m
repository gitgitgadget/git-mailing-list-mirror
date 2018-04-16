Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F961F404
	for <e@80x24.org>; Mon, 16 Apr 2018 01:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeDPBAZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 21:00:25 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46455 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDPBAY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 21:00:24 -0400
Received: by mail-wr0-f178.google.com with SMTP id d1so21332565wrj.13
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 18:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1FlgSpC5IONSTkCvUZxq4EhTkmscjKqz1BAWGcVl7Ds=;
        b=iwphMp4oEAhItiIxlLIupJ33C/RLwI8d5GPCrLVwjPbA9UeqqopsVYI5mXW9znShNO
         oYOKCCEiHdyQQNtxbw0M2WWCyjmIS624F35FTzrwxqVfgBp33hYdNnZ8ZGDvhaX3IAV9
         cqI/WvQCXCSgX5mPVk+ORv7PysBChVykI++iW2rfkL82vfozt+6tS3eFXnhG+bE+Shd2
         Ls8DVJIUyAZBxFzZVMxfW0R7FbTr2bWsqrNCx0QalL1Ofmqt9yibB18XSFJApYgxgoP7
         OcL/48ZA9EtEc/lP4NGzgKEylX+l7ujECGRFw0PgtEm0ukqiLHoiHSDiVaO/kAXMUwtc
         ebmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1FlgSpC5IONSTkCvUZxq4EhTkmscjKqz1BAWGcVl7Ds=;
        b=fStomckE4ahJMYPH+E+Kf1ee8ZXK75N+rN5II7EexBzduW2hVMtPIyLTqGGyKXdv+m
         usXTuOd2pEkpc8KNgLJDJkQiBoXX1ddfbs4xFhfjms9p/WpHDhSq/VL083dpAyL0QIEH
         ZEHXwporAS4XFKodL7BedeN2QSJVnb2sXTcYMwv2C+FAm4bHjJEUmB9Db2QVrzEp/miq
         WCm0KFRrcnXplqgr+x4UwK3b7ipRtF5yLqqCYQHs6BHXQbp90quZmlT+hJhZHlrqeDKd
         Bauj8O8RSz1UJ39xP5PZqppFvw9WJpEH4vfQAcBq6LGWAKLZcYatF3C7WYdRI49AHKxz
         kDaA==
X-Gm-Message-State: ALQs6tANbtUw9mf0sUtqfAge/qyC1jebJxIgNWm8Jnyi2YVXv4FIlelt
        3dYDJYun2uFE4u+OVINn48U=
X-Google-Smtp-Source: AIpwx4+7J7dMe70Yri2oHT8mwqD6d8dynOzq/rVinXod4Zlg186LJut8vYJ0BMts5b05mV9ik+sXnw==
X-Received: by 10.28.116.26 with SMTP id p26mr5203527wmc.102.1523840422637;
        Sun, 15 Apr 2018 18:00:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e64sm8456918wmg.22.2018.04.15.18.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 18:00:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "alexmv\@dropbox.com" <alexmv@dropbox.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v1] fsmonitor: fix incorrect buffer size when printing version number
References: <20180410184327.13896-1-benpeart@microsoft.com>
        <CAPig+cRvujJ2RmH62qnjS8asRn0wc+f-O+KA01NfFXuJDk3fog@mail.gmail.com>
        <2b6b2a54-8349-ea28-f752-4d752c798d5a@gmail.com>
Date:   Mon, 16 Apr 2018 10:00:21 +0900
In-Reply-To: <2b6b2a54-8349-ea28-f752-4d752c798d5a@gmail.com> (Ben Peart's
        message of "Fri, 13 Apr 2018 08:18:08 -0400")
Message-ID: <xmqqk1t8ynh6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> On 4/10/2018 4:17 PM, Eric Sunshine wrote:
>> On Tue, Apr 10, 2018 at 2:43 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>>> This is a trivial bug fix for passing the incorrect size to snprintf() when
>>> outputing the version.  It should be passing the size of the destination buffer
>>
>> s/outputing/outputting/
>>
>>> rather than the size of the value being printed.
>>>
>>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>
> Junio, do you want a re-roll of this simple fix or can you fix the
> spelling of the commit message?

I think I already have that typofix in what is queued.

If there is anything more, I'd prefer to replace with a reroll ;-)

Thanks.
