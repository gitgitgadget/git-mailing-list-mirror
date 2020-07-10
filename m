Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE23AC433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775602075D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C6O7aoTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgGJT65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:58:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58271 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgGJT65 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 15:58:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 492E76B46D;
        Fri, 10 Jul 2020 15:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EHPKOLhDCRVO0u/XqAD7As6Z7o8=; b=C6O7ao
        ThK4ep12bchw7/TpDywzr8jcy/LxFV+CgEiDkNF8KObNHAZRoZuBEPZHI/PwjueO
        cy+fbEMHxQs717w8BL3RQj1Bz97nSVr2ic9vwuxsEWc8hMPlHatjkv5XygvgrVHP
        xJw1fGnrXfXrdhHRM7lxszw0rTIjxr0lMl+A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvHzyYAs8GGOf9JLVP27KYDsmSa0PxZn
        PEr3a8DaY+a7wnqsoVqk+eH1cJA2kGWoU8MHu7BEWCr2h+HDLg94sFkvAlqaK1f7
        yiDqJLtzQnakx5mCB25x5wAB7xh5Uv7D2ai5SWQqZBem5XfitV43zk5EfroBN7Io
        pPbov8ip5ig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 40A236B46C;
        Fri, 10 Jul 2020 15:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C86146B46B;
        Fri, 10 Jul 2020 15:58:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] progress: remove redundant null-checking
References: <20200710014242.1088216-1-emilyshaffer@google.com>
        <20200710014242.1088216-3-emilyshaffer@google.com>
        <aebbc1ca-9936-ce1b-bacc-855d353f83f9@gmail.com>
        <20200710022040.GB39052@syl.lan>
        <xmqq1rljurvj.fsf@gitster.c.googlers.com>
        <20200710192731.GE3189386@google.com>
Date:   Fri, 10 Jul 2020 12:58:54 -0700
In-Reply-To: <20200710192731.GE3189386@google.com> (Emily Shaffer's message of
        "Fri, 10 Jul 2020 12:27:31 -0700")
Message-ID: <xmqqpn93ta4h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8AF31B0-C2E7-11EA-82E8-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Will it make your life easier if I base this series on the other topic?
> Or would you rather I leave it to you?

Either is fine.  

Just don't expect any quick turnaround time for a new and involved
change like this while we are entering the pre-release freeze.  We
are supposed to be stablizing, not churning ;-).
