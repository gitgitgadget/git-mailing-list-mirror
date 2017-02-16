Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2039F1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 22:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933520AbdBPWAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 17:00:20 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34557 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPWAT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 17:00:19 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so3006300pgv.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aD/+gvkKSxqjIYeosGL0C19xjZTevTf8H5tsL7YC1Aw=;
        b=hXsURClmBdayTFGukce2NGPHTPglPUQ4nJZ2sP6K8Bd5vPO+xf3+vGNPkmSqLO8OTi
         bs8cJ09DA5GYwMUY9vmXa23nPAPSd8V0Hn8Qh4w0TO5YQj3XM5CnNt69cBi/NCJwqfMJ
         C29P0ZkcHYlrPDFCsk44b7nX2Fse5RfMhA0Ob6RXgQJsOTaPrS3gJDbSZy1BE8ZU392v
         w03eGDbXPbNDMhmU+IpaWj0MOiVrK0cFxe+X5sX7Pd6FKN0SYLBNZbsBn6fIDDlPnbd3
         KilzY7C6Rtvn7yjBzW9w8IEJJT/vil+TCe22Jizw3VPjDXhObyEHpL9jd8U0CPVTD5kB
         H/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aD/+gvkKSxqjIYeosGL0C19xjZTevTf8H5tsL7YC1Aw=;
        b=EjIBGiNZ8SRuVvIO1HtjwrS0BZDvHiNmrN4rYda6k4KfHgCC//mvsYefeBKKst15d0
         I5bPbiJJzNqmMoxEcQ1ReKqe6Gg635Hk4MebRxzG4RlL50FEssSZdGaR9+qqF09owYLd
         ZR1e5vwaC5uk+XqMhoO69oD0XRF70YHYvFz74cZaKa9AtL29m/c4Gjznxv/ouJf+88ef
         JUH4bsXecH8EDCA8PTYgiDJs6B1kBGNo0t75BAEZVSlkjuGBEYSVUVqvQySvTeOrlucB
         jDjvGg+xaRzBXXLfewSfW4EQekHmdtNstXkxk8JxDjzFbODwJJhlznnn65d2ce+ATptQ
         W0Xw==
X-Gm-Message-State: AMke39n0JguX4mIkLN8W4iqO69W/mzHtUQU3abBwKRQAduT51zVkep9D6f4dWXt0qCiFlA==
X-Received: by 10.99.238.5 with SMTP id e5mr5627589pgi.49.1487282418584;
        Thu, 16 Feb 2017 14:00:18 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id x2sm15355641pfa.71.2017.02.16.14.00.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 14:00:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com
Subject: Re: [RFCv4 PATCH 00/14] Checkout aware of Submodules!
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
Date:   Thu, 16 Feb 2017 14:00:17 -0800
In-Reply-To: <20170216003811.18273-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 15 Feb 2017 16:37:56 -0800")
Message-ID: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Integrate updating the submodules into git checkout,...

It was more or less a pleasant read, once I decided to pretend that
I were a machine who uses identifiers only to identify locations in
the program ;-) IOW, for human consumption, the new names introduced
were sometimes quite confusing and went against helping understanding.

I saw a few places where logic looked somewhat iffy, which I sent
separate comments on; I may spot more if the code used more
understandable names and calling conventions, but that is OK.  It is
an expected part of an iterative process.  

I can feel that this topic is getting closer to where we eventually
want to go.

Thanks.
