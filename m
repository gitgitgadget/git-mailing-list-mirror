Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B68C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A72B22C7E
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 07:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgLUHhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 02:37:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:60976 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgLUHhT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 02:37:19 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1krFkD-007NrP-71; Mon, 21 Dec 2020 00:36:37 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1krFkC-00Ek9H-2f; Mon, 21 Dec 2020 00:36:36 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id CD71D500651;
        Mon, 21 Dec 2020 00:36:35 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vIqBb8OvTSPV; Mon, 21 Dec 2020 00:36:35 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id 73979500522;
        Mon, 21 Dec 2020 00:36:35 -0700 (MST)
Date:   Mon, 21 Dec 2020 00:36:33 -0700
From:   Seth House <seth@eseth.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <20201221073633.GA157132@ellen>
References: <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5fe033e0ec278_96932089d@natae.notmuch>
X-XM-SPF: eid=1krFkC-00Ek9H-2f;;;mid=<20201221073633.GA157132@ellen>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 20, 2020 at 11:34:24PM -0600, Felipe Contreras wrote:
> I disagree. It's fine if you don't want to participate, but the fact
> remains that the position that some tools would want to turn this off
> hasn't been properly defended.

If you are _genuinely_ interested in the answer to this question, please
read the section in my post titled "Conflict Resolution" followed by the
sub-section "Custom Merge Algorithm", and finally "Merge algorithms" [1]
on Wikipedia. Then pretend you want to write your own conflict
resolution algorithm for a new mergetool you've been dreaming up and ask
yourself what versions of the conflicted file your tool will need.

[1] https://en.wikipedia.org/wiki/Merge_(version_control)#Merge_algorithms

Right now the algorithm Git uses is pretty best-in-class so it might
seem unlikely that someone would want to write one of those. However
a whopping *seven* of the tools surveyed do just that. Some of them even
do a pretty good job (I've tried to point those out in the reviews).
You're preoccupied with identifying a specific "adverse effect" but this
debate isn't about that -- it's about giving individual tools the option
to choose how they are used. If people out there want to try and write
a better algorithm than Git, I want to see them try.

That's the point I've been trying to drive home and that's the point
that David also made in his last reply to you.

On that note: you replied to David and said:

> [Y]ou spend your time implementing this on top of my patch. That way
> it's clear who made the mistake.

I plan to start work on exactly that tomorrow. You made the initial
patch so if you'd prefer to take it over the finish line yourself I'll
defer. But if you're not interested then I would be happy to credit you
and finish it.

> Thanks for doing this, but unfortunately one of the most popular isn't
> listed there: vimdiff2.

It's under the Vim section. Use the page search in your browser for
"vimdiff2".

> That's what I expected.

That's what we all expected. The purpose of this follow-up survey was to
validate that expectation.

