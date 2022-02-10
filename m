Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80380C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344803AbiBJWFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 17:05:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344801AbiBJWFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 17:05:55 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213DFF23
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 14:05:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9013E10A018;
        Thu, 10 Feb 2022 17:05:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2+LrMrqblyHRvwVxO3uj2RImHX/ODkz+T27X0s
        qqOOw=; b=HkeZeHsZM7kW4cqr3T3zgxHiB/bXOrC6nnR9AwKY2Q/mVwuN4wYmhQ
        Ed8deuXIKi0e1NcChYtGZufmmbtW34GTH4yVeHyf+qvHk+znDSikm4FIf0ZrHMsD
        1bBqImxXtjKLXoJe4IpMX9QKULJ9cuTIjPxrtfW7n+J/yE4nAhk4o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8910710A017;
        Thu, 10 Feb 2022 17:05:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E31D010A016;
        Thu, 10 Feb 2022 17:05:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/8] submodule: store new submodule commits oid_array in
 a struct
References: <20220210190015.657085-1-jonathantanmy@google.com>
Date:   Thu, 10 Feb 2022 14:05:50 -0800
In-Reply-To: <20220210190015.657085-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 10 Feb 2022 11:00:15 -0800")
Message-ID: <xmqq4k56fkch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C6CBFB0-8ABD-11EC-8E35-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>> +/*
>> + * Holds relevant information for a changed submodule. Used as the .util
>> + * member of the changed submodule string_list_item.
>> + */
>> +struct changed_submodule_data {
>> +	/* The submodule commits that have changed in the rev walk. */
>> +	struct oid_array *new_commits;
>> +};
>
> Overall this change is straightforward and looks good, except that I
> think that the struct oid_array can be embedded directly instead of
> through a pointer.

True.

I am a bit behind and haven't seen the simplicity 1/8 promised to
bring to us, but hopefully we'll see soon enough why 1/8 is a good
idea.
