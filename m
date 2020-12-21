Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1451C433E6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D4B22D5A
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 04:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgLUEZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 23:25:51 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:43550 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLUEZu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 23:25:50 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1krCku-00AYlE-L6; Sun, 20 Dec 2020 21:25:08 -0700
Received: from mta4.zcs.xmission.com ([166.70.13.68])
        by in01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <seth@eseth.com>)
        id 1krCku-0006ra-1v; Sun, 20 Dec 2020 21:25:08 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta4.zcs.xmission.com (Postfix) with ESMTP id 89A3550062D;
        Sun, 20 Dec 2020 21:25:07 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta4.zcs.xmission.com
Received: from mta4.zcs.xmission.com ([127.0.0.1])
        by localhost (mta4.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oUW-Wq6hunBW; Sun, 20 Dec 2020 21:25:07 -0700 (MST)
Received: from ellen (unknown [139.60.10.209])
        by mta4.zcs.xmission.com (Postfix) with ESMTPSA id B06105004EA;
        Sun, 20 Dec 2020 21:25:05 -0700 (MST)
Date:   Sun, 20 Dec 2020 21:25:01 -0700
From:   Seth House <seth@eseth.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <20201221042501.GA146725@ellen>
References: <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
X-XM-SPF: eid=1krCku-0006ra-1v;;;mid=<20201221042501.GA146725@ellen>;;;hst=in01.mta.xmission.com;;;ip=166.70.13.68;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.68
X-SA-Exim-Mail-From: seth@eseth.com
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 03:14:23AM -0800, Junio C Hamano wrote:
> Seth House <seth@eseth.com> writes:
> > This is where I will part this particular debate.
> 
> Thanks for your contribution so far.

Re-reading my message now, I sounded overly final. I appreciated your
initial warm welcome and I'm still very much present on this list and
still very much invested in seeing this patch through to consensus and
completion -- and that includes writing code if needed.

To rephrase: I don't wish to spend any more of my time debating
`mergetool.autoMerge`
vs.
`mergetool.autoMerge || mergetool.$tool.autoMerge`
and I appreciate that others on this list have joined that debate.
I think all the angles and opinions have been covered at this point so
perhaps the time has come for a vote or for an executive decision.

---

The task of re-reviewing all the mergetools surveyed in the original
blog post is now complete. I took the opportunity to update most of the
original post to reflect the discussion and audience here.

https://www.eseth.org/2020/mergetools.html

The "Mergetools Comparison" section is long and is not very easy to read
with the current layout. Sorry. I wanted to get this published quickly
and I'll try to clean it up and add a proper TOC. For now, watch out for
the "Summary" under each tool.

tl;dr: I didn't see any noteworthy problems with any tool. Mostly
positive results and some no-impact results. The two minor impacts were
from the two tools that make use of LOCAL and REMOTE as historical
references; I think those are safe to ignore because one is mine and the
other builds on mine. All the other surveyed tools that reference older
versions of the conflicted file appear to actively query the Git
repository to obtain that info.

I'd still like to add more tools and do deeper dives with some of the
tools already surveyed so suggestions, feedback, and criticisms are very
welcome. That said, I am now feeling comfortable about adding this to
Git and defaulting it to enabled. :D

