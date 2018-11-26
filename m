Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C021F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 05:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbeKZQk4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 11:40:56 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62672 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZQk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 11:40:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EB881D74C;
        Mon, 26 Nov 2018 00:47:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K5H78tKJ11YXtzFyB+Y4atduAJU=; b=mYBVD0
        1FECl2VnrS+tg3KA0DgCicFpXx3rzQ/WvQ7WBvsqXDjLRMP7yZu0Yj5BHMGHityP
        ILYOmkG4k6ZsokO/nmrauwXhjsauawlGXNoJbYhFFrrIvgBLrxttm208E7/VNG+c
        dgbWIwPrvE/2rQgjm0VrVYle7e/X1L1IAJWmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rtfDOwYQibPyWPqa6GcXbpjoA/EYdlPa
        IUin8KL7IG/RMOfV+FvcU2QumAVm3DrWg15iGxIDCTI59jWclGdLIYeSbgOa/Yfs
        p9NamGx8gmD9v28PKf7QLq7tR5dOx+GewHSiUfQp/P3JAjFjGXyIxAePVR2OI1Fc
        Qs0T90eq8Dw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47E701D74B;
        Mon, 26 Nov 2018 00:47:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E67D01D74A;
        Mon, 26 Nov 2018 00:47:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v11 00/22] Convert "git stash" to C builtin
References: <https://public-inbox.org/git/cover.1539553398.git.ungureanupaulsebastian@gmail.com/>
        <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
        <20181125215504.GJ4883@hank.intra.tgummerer.com>
Date:   Mon, 26 Nov 2018 14:47:49 +0900
In-Reply-To: <20181125215504.GJ4883@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sun, 25 Nov 2018 21:55:04 +0000")
Message-ID: <xmqqa7lwz8xm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D049C2E0-F13E-11E8-9E5F-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Thanks for your work on this!  I have read through the range-diff and
> the new patch of this last round, and this addresses all the comments
> I had on v10 (and some more :)).  I consider it
> Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>

Thanks.

One thing that bothers me is that this seems to have been rebased on
'master', but as long as we are rebasing, the updated series must
also take into account of the sd/stash-wo-user-name topic, i.e. if
we are rebasing it, it should be rebased on top of the result of

	git checkout -B ps/rebase-in-c master
	git merge --no-ff sd/stash-wo-user-name

I think.
