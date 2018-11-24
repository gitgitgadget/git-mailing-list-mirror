Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F216A1F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 07:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKXSqS (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 13:46:18 -0500
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:59586
        "EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbeKXSqS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Nov 2018 13:46:18 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id QSprgX3lN5Bu5QSptgOFbU; Sat, 24 Nov 2018 00:58:42 -0700
Date:   Sat, 24 Nov 2018 09:58:38 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Carlo Arenas <carenas@gmail.com>,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] t5562: do not reuse output files
Message-ID: <20181124075838.GG5348@jessie.local>
References: <20181124070428.18571-1-max@max630.net>
 <xmqqbm6f2ajn.fsf@gitster-ct.c.googlers.com>
 <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7eh23ojc.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfJpr8cuTf/dFdfLUz3Xwuesa+ZYDQ2FNXDKC+uUXUe7W2Dk1UwsKIIXuwoqcKsDfKO//pPppgWRA+BMZSI3AJbSa4waBiRM8KUltM3nBBGdXHot6NRRf
 Hc03Vu5Nsl6WGLXLJN9qayWSj3Yv08fIuS/c9n9TZ8FfxwhucVdX8PKCcSwHBJX1sGdPKMRJL9CcAjRypQqOoQTybFuIfIEZvRRxEEDWg7bPlWuDgeg4uujC
 mcy0J7CjlWWMnvCUPYh+tugEkKqDzJIka9aS0k2r804=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 24, 2018 at 04:47:19PM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> a better workaround might be to write into unique output filenames
> (act1.out, act2.out, etc.); that way, you do not have to worry about
> the output file for the next request getting clobbered by a stale
> process handling the previous request.

Yes I agree

> But at the same time,
> wouldn't this suggest that the test or the previous request may see
> an incomplete output,

Yes it may miss the child's message. But in this case of failed
http-backend process, there should be already one "fatal:"
message in the act.err from the parent, and missing another
one does not change the outcome.
