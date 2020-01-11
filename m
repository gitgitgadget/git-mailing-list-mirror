Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CF7C33C9E
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 11:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6635620842
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 11:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgAKLAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 06:00:33 -0500
Received: from smtpq2.tb.mail.iss.as9143.net ([212.54.42.165]:41162 "EHLO
        smtpq2.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728881AbgAKLAc (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 11 Jan 2020 06:00:32 -0500
Received: from [212.54.42.116] (helo=lsmtp2.tb.mail.iss.as9143.net)
        by smtpq2.tb.mail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1iqEVK-0002Hg-7d; Sat, 11 Jan 2020 12:00:30 +0100
Received: from 92-109-146-195.cable.dynamic.v4.ziggo.nl ([92.109.146.195] helo=mail9.alinoe.com)
        by lsmtp2.tb.mail.iss.as9143.net with esmtp (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1iqEVK-00023a-3e; Sat, 11 Jan 2020 12:00:30 +0100
Received: from carlo by mail9.alinoe.com with local (Exim 4.90_1)
        (envelope-from <carlo@alinoe.com>)
        id 1iqEVJ-0007Bi-N5; Sat, 11 Jan 2020 12:00:29 +0100
Date:   Sat, 11 Jan 2020 12:00:29 +0100
From:   Carlo Wood <carlo@alinoe.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git submodule update  strange output behavior.
Message-ID: <20200111120029.2baaa090@hikaru>
In-Reply-To: <xmqqblrbm7c9.fsf@gitster-ct.c.googlers.com>
References: <20200109192040.46aaa01e@hikaru>
        <xmqqtv54zcik.fsf@gitster-ct.c.googlers.com>
        <xmqq8smgz9as.fsf@gitster-ct.c.googlers.com>
        <20200110101251.3b9f9332@hikaru>
        <xmqqblrbm7c9.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: carlo@alinoe.com
X-SA-Exim-Scanned: No (on mail9.alinoe.com); SAEximRunCond expanded to false
X-SourceIP: 92.109.146.195
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.3 cv=OIuTIhSB c=1 sm=1 tr=0 a=at3gEZHPcpTZPMkiLtqVSg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=Jdjhy38mL1oA:10 a=ybZZDoGAAAAA:8 a=BjFOTwK7AAAA:8 a=hrmhdJoBOhqMKG-2TzEA:9 a=CjuIK1q_8ugA:10 a=0RhZnL1DYvcuLYC8JZ5M:22 a=N3Up1mgHhB-0MyeZKEz1:22
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Jan 2020 11:36:54 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Carlo Wood <carlo@alinoe.com> writes:
> 
> > It seems to me that the other part of the problem is printing
> > this output for submodules when nothing (needed to be) is fetched.  
> 
> Hmm, I am not sure if that is a reasonable expectation.  Would it be
> possible to tell if there is something that needs to be fetched
> without attempting to contact the other side?

That wasn't even my point though: assume that we can't know, so we
have to attempt a fetch anyway (seems indeed likely), then I'd
expect to see this message for *every* submodule, and not just
for submodules inside other submodule.

There is an asymmetry (in the output of this command) between
submodules in the top level project and submodules inside other
submodules.

This then makes me wonder after all, if the message is suppressed for
top-level submodules then can't it also be suppressed for the others
(those that are currently being printed)?

-- 
Carlo Wood <carlo@alinoe.com>
