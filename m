Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95FC2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C24E20730
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vKbep5DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgDGThf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:37:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61472 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGThf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 15:37:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B5D946714;
        Tue,  7 Apr 2020 15:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5oa1d/flIl7FubsbufykAdMvJtM=; b=vKbep5
        DYYMlNlnAGKhEUvelu4Zn9L11i2qXPZI6l3QX23E4TiaSkxwfwv8p96xZ/zM+yBb
        4v+y0D+fJjpWB6yiaGqm7ceRO/J5saa6pyIQ9mFQXBhxCi/eBvotoyZR7vMbgTyZ
        RXRmknMk428iJ2gj1bCcPcYvlvLAf1s2oN7ok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WfofmcFSNMEJD2nxWIrL7/kyxOsM2q+e
        gK/RCsb6ydmX8n97gZD4ZRNFkt52otsYgW8njIr7oYGGgjBjAFfGteo7oDbsr3Ij
        XWfEL8FcgHPbZuhkOA4Lg2U2/SRzfnIsLz/q4CVmEcYuZYT+TfSvabce7xHTPtn1
        5YSJLhQfLpQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2322D46710;
        Tue,  7 Apr 2020 15:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8BED4670F;
        Tue,  7 Apr 2020 15:37:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: teach --no-encode-headers
References: <20200405231109.8249-1-me@pluvano.com>
        <xmqqd08lwatm.fsf@gitster.c.googlers.com>
        <20200407034622.GA42812@pluvano.com>
Date:   Tue, 07 Apr 2020 12:37:31 -0700
In-Reply-To: <20200407034622.GA42812@pluvano.com> (Emma Brooks's message of
        "Tue, 7 Apr 2020 03:46:22 +0000")
Message-ID: <xmqq8sj7t7d0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39A580F2-7907-11EA-834A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> writes:

> It's also too vague and it's not entirely clear from the option itself
> what sort of encoding it refers to. I will change it to
> --[no-]q-encode-headers and format.qEncodeHeaders in v2 unless there are
> other suggestions.

I actually did not mean to push you into that direction.  We can,
and do want to, keep the most generic "--[no-]encode-headers" if we
do not anticipate us wanting to special case the Q encoding.  A
sample question to ask is "would it make sense to disable q-encoding
but still perform other parts of 'encode headers'?"  I haven't
thought deeply about such questions, but as a proposer of this
topic, you would certainly have, and I was hoping that you'd say
things like "Q-encoding is the only thing that we do to munge
headers, so there aren't any 'other parts of encoding headers' we
need to worry about", "there are things like X, Y and Z that we do
to the headers when we enable Q-encoding, but they all are what we
do not want when we do not want the Q-encoding", which would be a
very good sign that assures us that "--[no-]encode-headers" is a
good name.

Thanks.
