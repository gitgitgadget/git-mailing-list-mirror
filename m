Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F935C4363C
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C901723A61
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 21:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LXS/KeRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgIUVTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 17:19:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58883 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIUVTr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 17:19:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0DF1FC1E3;
        Mon, 21 Sep 2020 17:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D2SM4AYwHWWiRKqEE3iedw+K7Bo=; b=LXS/Ke
        RNZAxWTUji6qdZQBMum7QQZc2INEsOTDyv49MKXO5sKMxoUTvwaN/Wjirll4Vqe1
        yXbYikhszCqTLM8DBpunOpY/Hlr5ZkOlxzTKFL6uzeFvsIXtbTCj0kJMQK41P0sv
        N7BU7HpKI31bNXxDJ0nZk0kTKSnHCSonjsq/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nui2mni3mywPECTHmIyHGXgPVCxaxulh
        WuSE7/HfmfnDMGYYWVsMMTZvpQNYBOBqn0sub24YnwqBQrO3aWSt1fzVBOyQWU2b
        VRrfrR23/+xTgmtHd0HyuXvckRI7ButrdQE9tAiV+IaZWkKqhxhw6EaJz6ulYIzR
        VrN1qaURdlE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99EC4FC1E2;
        Mon, 21 Sep 2020 17:19:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCF69FC1DF;
        Mon, 21 Sep 2020 17:19:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
        <xmqq363gs1mt.fsf@gitster.c.googlers.com>
        <20200918104833.GB1874074@generichostname>
        <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
        <20200920110148.GA227771@generichostname>
        <xmqqzh5jf73t.fsf@gitster.c.googlers.com>
        <20200921172740.GA946178@generichostname>
        <xmqqwo0met17.fsf@gitster.c.googlers.com>
Date:   Mon, 21 Sep 2020 14:19:41 -0700
In-Reply-To: <xmqqwo0met17.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 21 Sep 2020 14:09:24 -0700")
Message-ID: <xmqqo8lyesk2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A8546E4-FC50-11EA-9FB6-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Another possibility is to error out when "--merge-base A..B" is
> given, which might be simpler.  Then the code would look more like
> ...
>
> While we are at it, what happens when "--merge-base A...B" is given?
>
> ...  Is this something we want to diagnose as an error?  I am
> inclined to say we should allow it (and if it hurts the user can
> stop doing so) as there is no harm done.

My recommendation is to allow both "git --merge-base A..B" and "git
--merge-base A...B".  The discussion about A..B and SWAP() would
equally apply to builtin/diff part of the patch.  The posted patch
ignores the swap logic when --merge-base is given, but we should
apply the swap logic first and then make sure the merge_base logic
will have the oid[0] and oid[1] in the correct order.
