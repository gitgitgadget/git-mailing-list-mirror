Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B674E1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeBWXoU (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:44:20 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37494 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbeBWXoT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:44:19 -0500
Received: by mail-wr0-f196.google.com with SMTP id z12so15699784wrg.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fghw32rjK1r6XIa1QdGB4oZ0YGRGGsanTAK6RbERWXI=;
        b=sXoCQP9Xdmgc3VzVD2tPnT+DO/jrn84tIa+P6311t8oug7A8iQgB3JzzEJc/g6GDW3
         /F4Nx/+9pkcsMpOSoLJhoPjOlmS6T4CdfM/b5g5rAk9nsltkf4npp4CsD2z7LzXagLJw
         oXNImc/Y1Jse2EG0ASKNsOhEKTrSdFahvv+tyVqXrmsCoIqGrCu2DuxoRDXBQI+2PfSb
         r1px1JgBERVIaF+LWGdue7DQEjtSHeRPmSpUYKowEU2ZdRRegjRN8EKpfankBZL1wGLY
         OeAkenDtV9RGeujLZ6lGr2lHA7FDPpPbdZ2jfJGhvXiYBC16pmpUWSECG8xoITJNlFzh
         x4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fghw32rjK1r6XIa1QdGB4oZ0YGRGGsanTAK6RbERWXI=;
        b=UGdD7tosdcz+FMBpUoC4l6S5/IDf82+lk8lk33+SBVWwXXspyG1aEgVlekglgFktml
         1pDDT2XQxeNGVA8j32Q1aCv/l+zGQDIgxaNcsO1JYgSxJtkQ7z3//OLrKf5ORJ8uCDXN
         4P8fJZKnfFi+m7NW13+yBz62UztiXLoZDyM/HwdIYNVac/ITFc/4UALTnnH0RHopzOOP
         WlRqgIADlShXSOwRtVNkt6Irq7Ms+gkPo1sOjKLClrEyEWlP3XRtcCA9qq/2nwM1ajW5
         8l6NstJu5shFeRiqdOS5AxRu6IYJJ6/vvDzSdFBPd2y5tHlAr6EKdnohmB0jdVQqnmd+
         uZ3A==
X-Gm-Message-State: APf1xPBdsjJp9m3m87nxSnRRZlKZVxIEG0QneTo4TzGRJVaDP4e2p0uy
        R90+fnrXtftMXD5ej0b3+aQ=
X-Google-Smtp-Source: AH8x227oDGo1O5ApNSDs6+f92BMFaJffyVAMEA48UJW4D/gR/Ygvi7F+O/w5HtjnqHza6OUi+1A7WQ==
X-Received: by 10.223.161.158 with SMTP id u30mr3214950wru.109.1519429457557;
        Fri, 23 Feb 2018 15:44:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n24sm3967985wmi.21.2018.02.23.15.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 15:44:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v2] ref-filter: Make "--contains <id>" less chatty if <id> is invalid
References: <20180223162557.31477-1-ungureanupaulsebastian@gmail.com>
        <xmqqwoz3s9s2.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 23 Feb 2018 15:44:16 -0800
In-Reply-To: <xmqqwoz3s9s2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 23 Feb 2018 12:58:37 -0800")
Message-ID: <xmqq371rs23z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:
>
>> Basically, the option parser only parses strings that represent
>> commits and the ref-filter performs the commit look-up. If an
>> error occurs during the option parsing, then it must be an invalid
>> argument and the user should be informed of usage, but if a error
>> occurs during ref-filtering, then it is a problem with the
>> argument.

After staring the code a bit longer, I started to dislike the
approach taken by this patch quite a lot.  Isn't the problem that we
let parse-options machinery to show the usage help, which is
designed to be shown when the user does not know what options the
command supports, even when we recognised the option perfectly fine?

That is, if we added a mechanism for a callback function given to
OPT_CALLBACK to tell the calling parse-options machinery "I
recognise the option; but the value given to the option is wrong and
that is why I am returning an error", and made the caller in the
parse-options machinery to refrain from showing the usage help,
would it solve the issue with minimum fuss and stop the execution at
the very first error we detect?

Stepping back even further, I wonder if any error detected in a
custom callback handler given to OPT_CALLBACK even wants to show the
usage help.  I offhand do not think of any situation--- the callback
was called only because OPT_CALLBACK item in the options[] list
matched what the user gave us, so at that point we know the user
gave us one of the valid options.  The error message from the
callback may say "Hey I only take commit object name", or it could
(theoretically) even be "Sorry I do not take any values", but in any
case, I do not think there is a reason for a failure detected in the
callback should lead to the usage help.

So perhaps "if we added a machanism...to tell..." part in the
previous paragraph is not even needed, and the only thing we need to
do is to make the caller in parse-options that calls a custom
callback function given to OPT_CALLBACK to stop giving the usage
help.  Wouldn't that automatically fix the "branch --points-at
garbage" issue that is not addressed by this patch, too?
