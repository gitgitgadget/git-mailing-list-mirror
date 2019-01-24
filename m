Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A261F453
	for <e@80x24.org>; Thu, 24 Jan 2019 23:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfAXXCh (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 18:02:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45981 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAXXCh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 18:02:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so8268297wrr.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=md8CT0rmiOGQfdERcDQXJnDZ5MtiPTFG9jkVWYx22ew=;
        b=maI7PnY4eC25FYhesqghXYnbh6SZ8XxPhh9I7dQp4W9z9ouzEXWiJ9X1Z0IStU1Osf
         /xFPBT71NgvU6KOWPuAGgivYwQSJStT7Lfjm/7xiQCzafC6fyrRddxaE29xdUqCKTQSt
         yOCIXzpumRUXE/ZWXHDIqnLoh4ReOfn8kIPGdE+L7m0XGfH69obCXBAIlPzblEeupox8
         N1S1FrQDWwr3SkC3NPuFvqimYl5QwsSeMXWdGmKuOsL0uaeNDwtgo5DCcpwPd4eoaF4u
         OwpQKGVZLxFydR0we/8Ajjgn5xtqAwM06cn0aYrNVj2FpzNfUoY7+npFt6CfaNXxDpar
         4ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=md8CT0rmiOGQfdERcDQXJnDZ5MtiPTFG9jkVWYx22ew=;
        b=n16O44oTqvjLPyhJpyIv75T9XOkcPqoMLVHp2KANtAY3QqH1u3OBWlAvygQSjTiOn7
         rvDOJBmPlao8oI9p55o1aLnHtXsw2bOsrTkYkrV5B7sNEocTGhSRS14OwMP9Qu1D9UPm
         x0JpMYUJMHDkpccb2RecDaPo02eM+NGORRhuqSVOXdlV/CjowSa4En8t9hwakEb9JFzy
         4F0rIJPPJF6+9xhY/nV2z+m9NOKsOKO+0KMpppelPbcs2yKvWLRIb/2tuxJpIBFWy+jn
         swwjGAh6HcJ3qbRGPfNw81gpge7AhZ0MCLCUm25+bvosRpBb08PabGNzAAC/HJhDX/To
         8nVA==
X-Gm-Message-State: AJcUukecfDR+QKz9dZMxhv6TSR2uE4d5XIvJGmqiPMaL9+r5qxUdlH8S
        37vRD8Z/2UoaQjwi/lITBco=
X-Google-Smtp-Source: ALg8bN7l2MC/Wps4KB6QpuKabzFHlqSaXFXvOTcQ4hE1YviG8u2rtk515nLNocuMw/L6ZKItofTt8Q==
X-Received: by 2002:adf:b649:: with SMTP id i9mr9188852wre.70.1548370955157;
        Thu, 24 Jan 2019 15:02:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o9sm38144093wmh.3.2019.01.24.15.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 15:02:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
References: <20181220134820.21810-1-t.gummerer@gmail.com>
        <20190108215225.3077-1-t.gummerer@gmail.com>
        <20190108215225.3077-8-t.gummerer@gmail.com>
        <20190122235313.GA199923@google.com>
        <20190123202156.GA11293@hank.intra.tgummerer.com>
        <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
        <20190124011244.GE34357@google.com>
Date:   Thu, 24 Jan 2019 15:02:33 -0800
In-Reply-To: <20190124011244.GE34357@google.com> (Jonathan Nieder's message of
        "Wed, 23 Jan 2019 17:12:44 -0800")
Message-ID: <xmqq8sz9hd6e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I find --ignore-removal fairly easy to understand, and I had no idea
> what --overlay would mean.
>
> I realize this is just one user's experience.

Exactly.  My impression was the exact opposite from yours.

The phrase "removal" in the context of checkout does not click for
me at all, and neither it does in the context of add, especially
given that Git tracks states (i.e. snapshots), not changes.


