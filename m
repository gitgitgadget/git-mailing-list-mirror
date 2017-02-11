Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 119191FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 23:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbdBKXkX (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 18:40:23 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34054 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdBKXkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 18:40:23 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so5987034pgv.1
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 15:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J4V9cxCyQxdtppHyCWqAKNLRxN/XymqsusiLDSPy5Jg=;
        b=T43Kl7VW1vvm+R9aSlVMZddSPAtIVO0qFH+TtQo0LFLmBdS9JOmTmdcnJ9S8UyT+//
         KgYe5YNwb/C/GVLo0XvBaDPzWP/E9fZONeYA6wSRbRg3Trqai9tE6aJTgjFj152JVFHy
         vbAiLPDyPvB4E89pO+LD33bqzTsdVpDGS5l0MQOL12vwv+s7qLOVjTrDf/WEklIX/qKK
         YC1oXKRenvogaDUgdCC7fZ/TFfo6jeH3GdFuXqqfVi2QrFrxOOzu0sBgRo+XnBOTrOlh
         qv5vIL6coT/w0W7Zhsd9/RRstzQ6j9E3gY5lsdJElEoSh02NDd66ZASg6sysSwF02FrP
         1q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J4V9cxCyQxdtppHyCWqAKNLRxN/XymqsusiLDSPy5Jg=;
        b=a6+oANj8scOniwDKwZ5ReMv9kqDrUVgxWmLcpm4Z/yUCDrBZMNznHgBKqi25HuIvUw
         AuUWxz45cwapSB6nYYuPIsAWoV+JCeFwY0gAXLPi3CCl+XM71n1qdlwyqf/FhMDaN4/x
         JBBnVUKeO3VpEQIFERDNMOqj+T0LxUamgbQ9psGyqI85VzrPUygYWqps7EaFnZhZebsp
         kFRUWZRktjBLE6nE0ELXzqC8WOP9yP+XxlrVSr3RYT0klUSLVdJOZWXUUpe5wYb8iHt6
         DAx1zbubz2fkeNvK7i4+ixcPhy0syXAAUHJrYbOSwh+FktROaqtx8g8uwVyY/nYGQDxk
         4w9Q==
X-Gm-Message-State: AMke39lrvBkyagdQgsthjtDuSy+V8Wp/fjn0Vmx9LfMUCLQubYVbGQq63wV8LHgKOmaLrA==
X-Received: by 10.99.158.68 with SMTP id r4mr18746706pgo.153.1486856422487;
        Sat, 11 Feb 2017 15:40:22 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d4bf:82d:ab5d:5a31])
        by smtp.gmail.com with ESMTPSA id p26sm12835400pgn.39.2017.02.11.15.40.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 11 Feb 2017 15:40:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/2 v3] revision.c: args starting with "-" might be a revision
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
        <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
        <20170211075254.GA16053@ubuntu-512mb-blr1-01.localdomain>
        <xmqqefz4h1vq.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 11 Feb 2017 15:40:19 -0800
In-Reply-To: <xmqqefz4h1vq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 11 Feb 2017 13:08:09 -0800")
Message-ID: <xmqqa89sguu4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Such a change to handle_revision_opt() unfortunately affects other
> callers of the function, so it may not be worth it, and I think
> "decrement and then increment, because this codepath wants to check
> to see something that may ordinarily be clasified as an unknown
> option if it is a rev" is an ugly workaround, just like your left--
> was.  But I think the resulting code flow is much closer to the
> above ideal.

Having re-analysed the codepath like so, I realize that the new
variable I introduced was misnamed.  Its purpose is to let the
"if arg begins with dash, do this" block communicate that what the
later part of the code is told to inspect in "arg" may be an option
that we do not recognise.  So I shouldn't have called it maybe_rev;
the message from the former to the latter is "this may be an unknown
option" and I should have called it "maybe_unknown_opt".

