Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC01C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A59206CB
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 16:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KzgNrVYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbgJLQOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 12:14:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56438 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390043AbgJLQOh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 12:14:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 562E4F694C;
        Mon, 12 Oct 2020 12:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=awg5/iarTlkhNQngt1BhLJpqHK0=; b=KzgNrV
        Yb/Qv511fzScPXmIl7i4F+qT69bRIBvftq83e+HGJAVHk6Hq5HciaFNTGGS0DdKJ
        ZU+otLTJ+abga9pQx6COC/WnRM63Ri8MGIvAD/2+qQPXJ1fWUfns9W1Y0hmMu3F1
        MelYsjkXxHhjyL1QosZiRWm0sNgzl6gMHXGtY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KisLBBJWO26kXzmcHTvUAaobtg1TSpyV
        HXIv7KKp7ecgYV0sf3yR1WSbipJBmiOt4HMgyZIbA2enxX9mp68bKDELyYBOXhyx
        ITlxA7B98ly/j79l0MN/4dQfwEju57Z8FtqYvNrw+j6+pgLHvipdKTG/d/qHybaR
        42PVbcM9E58=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FD1BF694B;
        Mon, 12 Oct 2020 12:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C32CF6948;
        Mon, 12 Oct 2020 12:14:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Robert Karszniewicz <avoidr@posteo.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH] log: add log.showStat configuration variable
References: <20201008162015.23898-1-avoidr@posteo.de>
        <bec999ef-5f9c-0ca1-ddd9-70b54b8c51b1@gmail.com>
        <20201011095916.GA14933@HP>
        <1f53a7d8-6aa5-e1c7-ecb9-b99a37500034@gmail.com>
Date:   Mon, 12 Oct 2020 09:14:31 -0700
In-Reply-To: <1f53a7d8-6aa5-e1c7-ecb9-b99a37500034@gmail.com> (Derrick
        Stolee's message of "Mon, 12 Oct 2020 08:50:35 -0400")
Message-ID: <xmqqtuuzqv4o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 036D7E1C-0CA6-11EB-B7AA-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> I worried about that, too. But I think the initial step was already in
>> 2015, when stash.showStat and stash.showPatch were added. No flood of
>> options happened since then? I was actually surprised about it, too,
>> that it took so long until someone wanted to have showStat for show and
>> log, too.
>
> I'm not sure these examples will help your case.
>
> Does 'stash' have more things that would be beneficial to show
> every time? If no, then 'stash' is much more specialized than
> 'show' and 'log' which have many more options. If yes, then this
> is exactly what we want to avoid happening: an incomplete set of
> config options that are tailored to a small subset of options.

Well said---I do not have anything more to add to that point that
'stash' is not a very good example to mimic.
