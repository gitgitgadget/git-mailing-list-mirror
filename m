Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF225C32771
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 17:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991CF2176D
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 17:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WAc4I/Zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgARRvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 12:51:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50917 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARRvf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 12:51:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4078DAEDAC;
        Sat, 18 Jan 2020 12:51:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cpvhbJDXFd43abfraJK4nw+NK38=; b=WAc4I/
        ZffniJZzsohqcVTMhOiqwywyjq/bRQKVJE1+fIDQoX4wqjwze65MA05xpVA8h53L
        fC4gte2E9JzBvlMAdokkipTvE+/aq88RhVtLctx6zkdRK66Vi4lj0HDlTosTTXEO
        jfp/0yEr4XbwZSb4xzNAlz+jeFObGQu6GtalI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ml3P4LwSkjbxSk3vM7ieWhW/XwI7kiSP
        tQVC5matYmn0yDyh6jGMqerTZRppZkOAu4idos/iWyWEgyxN4PTiZcvxxYpqJFHY
        xOJCtqjluCjpRtTY9qzEP43FFk//ClZgZE0Vo+cVx7rJDymHR8xChiSAErFU/aLM
        Kfywtutaeic=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26339AEDAB;
        Sat, 18 Jan 2020 12:51:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 46C7BAEDA9;
        Sat, 18 Jan 2020 12:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eyal Soha <shawarmakarma@gmail.com>
Cc:     peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums
References: <CANsz78JyawDpp_SewRQp4_AbZVduSYiazhvCqUcqUV810az5MQ@mail.gmail.com>
        <20200118145318.5177-1-shawarmakarma@gmail.com>
Date:   Sat, 18 Jan 2020 09:51:27 -0800
In-Reply-To: <20200118145318.5177-1-shawarmakarma@gmail.com> (Eyal Soha's
        message of "Sat, 18 Jan 2020 09:53:16 -0500")
Message-ID: <xmqqftgcd55s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 284FC9DC-3A1B-11EA-A23A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eyal Soha <shawarmakarma@gmail.com> writes:

> Subject: Re: [PATCH 1/3] color.c: Refactor color_output to use enums

Please downcase Refactor; that way this change would not
meaninglessly stand out in the "git shortlog --no-merges" output.

> Signed-off-by: Eyal Soha <shawarmakarma@gmail.com>
> ---
>  color.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

You got help from multiple reviewers on your earlier round and at
least the discussion thread would have made it clear what kind of
things would help readers understand what design decision was made
(e.g. .value is not 0-7 but 30-37, the caller passes "am I talking
about the background color?" boolean, there are others) and why this
design was chosen (e.g. .value is not 0-7 because we want to add
brighter variant later, there would be others that correspond to the
"here are the design decisions I made before coming up with this
version").

The reviewing is *not* just about explaining your thought to and
convincing your reviewers---it is where reviewers help you to
explain what your change wanted to do and why it did so to future
readers of "git log".

The blank before your sign-off means all the times spent gets
discarded, which is not exactly encouraging to the reviewers.  
