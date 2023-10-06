Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9C2E92FCF
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 00:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjJFAkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJFAj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 20:39:59 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B2D8
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 17:39:57 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 485081A5E2E;
        Thu,  5 Oct 2023 20:39:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=2Hyoa99DJoR3WnSDncVm7vomDMDZXSnDk7L4LY
        os45k=; b=oths4UkVBkcc7eoEhFeySyDvgpQURAGO5IVo5t/yFVqcXzJyGARSHL
        kX21TZS6Nqt8AkVoy0VTpb+nydA4OJNLt6TV7sVHRWgCGLhmGX7PcSAaA/Ut7H+d
        nDkMPg67bRh+drJCpvE3brNkecfW1nks/V/BFC2lb7dWWlhkqTICY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FF5D1A5E2A;
        Thu,  5 Oct 2023 20:39:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E3041A5E29;
        Thu,  5 Oct 2023 20:39:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/10] some commit-graph leak fixes
In-Reply-To: <ZR732biF718ju9QU@nand.local> (Taylor Blau's message of "Thu, 5
        Oct 2023 13:52:25 -0400")
References: <20231003202504.GA7697@coredump.intra.peff.net>
        <ZR732biF718ju9QU@nand.local>
Date:   Thu, 05 Oct 2023 17:39:55 -0700
Message-ID: <xmqqjzs0bn38.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF625408-63E0-11EE-8C6C-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 03, 2023 at 04:25:04PM -0400, Jeff King wrote:
>> I noticed while working on the jk/commit-graph-verify-fix topic that
>> free_commit_graph() leaks any slices of a commit-graph-chain except for
>> the first. I naively hoped that fixing that would make t5324 leak-free,
>> but it turns out there were a number of other leaks, so I fixed those,
>> too. A couple of them were in the merge code, which in turn means a
>> bunch of new test scripts are now leak-free.
>>
>> Even though I saw the problem on that other topic, there's no dependency
>> here; this series can be applied directly to master (or possibly even
>> maint, though I didn't try).
>
> Thanks for carefully finding and explaining these various leaks. The
> series is a definite improvement, and after reviewing closely I couldn't
> find anything worth changing. LGTM!

Thanks, both.  Let's merge it down to 'next'.
