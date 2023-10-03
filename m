Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D42AE7AD76
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 16:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjJCQPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 12:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJCQPR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 12:15:17 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458BAA9
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 09:15:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAFBD2A489;
        Tue,  3 Oct 2023 12:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=PQq8XtAlavU116qqKp/Jf2mNIUUpCkatzRwg91
        eWDVU=; b=kpW/Zpcny/rfqvWiF8d+dDEG3S8wiQ3+4LPI4un668x3IH/YDQrEQN
        1lzqz26AMEbxA7mROY0ig4Kd4QoEA4YOXD6HYoHxUVQsKSjXBpw/12eX2GlJC0my
        V+UPBKIbZUzZLP/vZpd65LRLeoAOxZgGg1f7gy6hbjyBeUw5favAs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D47D62A488;
        Tue,  3 Oct 2023 12:15:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DD6DE2A487;
        Tue,  3 Oct 2023 12:15:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: batch-command wishlist [was: [TOPIC 02/12] Libification Goals
 and Progress]
In-Reply-To: <20231003005251.M353509@dcvr> (Eric Wong's message of "Tue, 3 Oct
        2023 00:52:51 +0000")
References: <20231003005251.M353509@dcvr>
Date:   Tue, 03 Oct 2023 09:15:07 -0700
Message-ID: <xmqq7co33cok.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0640698C-6208-11EE-991F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Taylor Blau <me@ttaylorr.com> wrote:
>> * (Jonathan Tan) back to process isolation: is the short lifetime of the process
>>   important?
>> * (Taylor Blau) seems like an impossible goal to be able to do multi-command
>>   executions in a single process, the code is just not designed for it.
>
> -- Split out from https://lore.kernel.org/git/ZRrfN2lbg14IOLiK@nand.local/
> Thanks for posting in an accessible format for non-JS/video users.
>
>> * (Junio) is anybody using the `git cat-file --batch-command` mode that switches
>>   between batch and batch-check.

This is not exactly what I asked about---I was asking about the use
of the "a long living process serves many requests" pattern ;-)

> But it would be nice if --batch-command grew more functionality:
>
> * ability to add/remove alternates
> * ability to specify a preferred alternate for a lookup[1]
> * detect unlinked packs/removed repos

To the third you would also want to notice an updated index, too.

> Not sure if cat-file is the place for it, but a persistent
> process to deal with:
>
> * `git config -f FILENAME ...' (especially --get-urlmatch --type=FOO)
> * approxidate parsing for other tools[2]
>
> Would also be nice...

"git daemon" ;-)?
