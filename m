Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7330C20401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbdFOTUj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:20:39 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35653 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdFOTUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:20:38 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so2619267pgc.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dZP2tWokTjKQraqThH9+IyhnL0RQQcMJa9o6Gr7LjlE=;
        b=JnIS74A1Z9nZF7o0ZUEqj+m1oW2XoTWATL6Oe3z0VtxTBi/6kTSQjhB2hF4NghuPCR
         lqaJhy2D4VNNBjx+hPSBkTeK6ccmyvMaMrQpZFiyUOyjUcSb+fORseaySmt0ekwOeCwY
         JYSmGfGyt+sWhCYcYUVllI8qLxq9rDo+Ojkcf4de4Sb+xWrTdFWSVsrPR4RmB+MTqLAr
         749zAzl0ISj1VU1djp6KDUQME3Mn6wMbZT/E7WERn1SKunp4dQJG/JlvZL7QVzPPjX0p
         SZ7c802TxFwN7F25EnrCf+Y2cgV7PKSrPddHE9bee1QZobbh3JlLUDrwl3XrYQ9ErXEy
         jjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dZP2tWokTjKQraqThH9+IyhnL0RQQcMJa9o6Gr7LjlE=;
        b=T9FvLVMfK5YL13EGSYmqWc7EgO+EklmK2xUs1iGdEyAT6pNt4f2GIb0dSG4moLeXz/
         WAdh9k7W+ObHwrDwz6bB5efRa4mr5quLPoyo4nckSLVr/ZCKBkm233hESE5vMeEkIUoA
         y1UncHPZ9XuB4aclCWe157AETIikFxtj0MNmHscVvoueVn0raWYzf/EH08fOo3qjnUjL
         FKPJ7EmtNmdaFpoIQSScPsD8cVJo27aZj5WYqH0DKbnBDrKoUYFBXkrj0BAVLM4KMga6
         +1pbNWEqknPFXSPe/YDto5dvkPj+Rmxwtfv0qKcSdRPjQkHqdK1UBUqHgoX3EKwOUt3Y
         JeZw==
X-Gm-Message-State: AKS2vOyyDb39n/azPrwUmMYkTJU6h9q0NVNiMDc5GPfEYn65tAAoZz6r
        wvggM4y1fnLgIg==
X-Received: by 10.99.144.196 with SMTP id a187mr6962526pge.184.1497554437599;
        Thu, 15 Jun 2017 12:20:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id v62sm71938pfb.124.2017.06.15.12.20.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 12:20:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash function transition plan
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
        <20170306182423.GB183239@google.com>
        <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
        <20170615173616.GA176947@google.com>
Date:   Thu, 15 Jun 2017 12:20:35 -0700
In-Reply-To: <20170615173616.GA176947@google.com> (Brandon Williams's message
        of "Thu, 15 Jun 2017 10:36:16 -0700")
Message-ID: <xmqqh8zh12ik.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> It would make a whole of a lot of sense to make that knob not Boolean,
>> but to specify which hash function is in use.
>
> 100% agree on this point.  I believe the current plan is to have the
> hashing function used for a repository be a repository format extension
> which would be a value (most likely a string like 'sha1', 'sha256',
> 'black2', etc) stored in a repository's .git/config.  This way, upon
> startup git will die or ignore a repository which uses a hashing
> function which it does not recognize or does not compiled to handle.
>
> I hope (and expect) that the end produce of this transition is a nice,
> clean hashing API and interface with sufficient abstractions such that
> if I wanted to switch to a different hashing function I would just need
> to implement the interface with the new hashing function and ensure that
> 'verify_repository_format' allows the new function.

Yup.  I thought that part has already been agreed upon, but it is a
good thing that somebody is writing it down (perhaps "again", if not
"for the first time").

Thanks.

