Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105AFC433F5
	for <git@archiver.kernel.org>; Fri, 13 May 2022 18:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380458AbiEMShP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347818AbiEMShK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 14:37:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DD38D9D
        for <git@vger.kernel.org>; Fri, 13 May 2022 11:37:09 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B380E1248BB;
        Fri, 13 May 2022 14:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=seDbygEBHRTPBvDzMsK2KgqMg2nCCXeFd046Nqg2vTM=; b=lQFn
        p2nRC7X6D51y/pnpx1lq+t5S+aT+tnD7FrQwYMzdUJTalMxfeEmev2+aBTRIVjR3
        WntHg8AxL3LALLL9a/lmuenfGMzDy4Uq0r/if7Wb0zGgpzi31G3eBuA2tWL9Oll3
        1qJMKdX4CmOPJDjbTPP6HQBb6wY3OSVrm4l0bR4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA0151248B9;
        Fri, 13 May 2022 14:37:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EF18A1248B8;
        Fri, 13 May 2022 14:37:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
References: <xmqqmtfqd25h.fsf@gitster.g>
        <20220513134946.1581-1-chakrabortyabhradeep79@gmail.com>
Date:   Fri, 13 May 2022 11:37:04 -0700
Message-ID: <xmqqk0ap9t4f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B061A6D6-D2EB-11EC-93DA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

> Else you can drop the idea and suggest them to introduce a new flag
> (depending on the situation). If you still have some doubt about my
> PR i.e. if you can not determine which category my PR belongs to, I
> can go with adding `show-partial-clone` flag. The downside would
> be that `remote -v` will not give the full summary in case of partial
> clone.

If majority of partial-clone users find it unnecessary noise, then
it may be an upside to give only reduced summary that is less than
full that may be given by `remote -v -v`.

Worse downside of adding it as an option is that it invites more
options.  It is less worse to add new ones to `remote -v -v` (or to
`remote -v`, or not adding it at all) than adding another option, I
would think.

Perhaps tagged output that can be easier to parse would be better
"extensible" output format for adding more random pieces of
information than going tabular.  I dunno.
