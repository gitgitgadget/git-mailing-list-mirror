Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF2C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FCA21531
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 18:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="joB5oR8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504186AbgJUSeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 14:34:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61421 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439031AbgJUSeq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 14:34:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 756A6102DC4;
        Wed, 21 Oct 2020 14:34:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZAzwyFuxz63q66D7DZdwIxFV7LI=; b=joB5oR
        8UNETfSLiknQOXGmTuOR1BQglLbqHtVak3zpTjRNuiLythimVNB3e61oLNehuttz
        PJSg0wSfb9jr6p7HaBxb+hNQV1ss4oFOgjBuar7Pl7HHRl580FRMZQ475Qy3v6qd
        9cX1DUEptQ/nn8utmH3gJsBTVpt8nsRiJqX3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EdYjLocFthjAcVhYUAJ7GW7P5S0ORRlk
        mBXUyEDfenkoUEaDaWdAqLMe1fkidcJasF5qJN7LLTMdJ4hGyd95O6kqoK6JVh6t
        m9nihKJTjSrZJa4Ezam4ueCvW7+7CSavCHpjrXIdnMUeFiH8krcMLRUc+WVSkm+O
        1UhCBoJ883Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6DDE2102DC3;
        Wed, 21 Oct 2020 14:34:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 44F21102DC2;
        Wed, 21 Oct 2020 14:34:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael Forney <mforney@mforney.org>, git@vger.kernel.org
Subject: Re: SKIP_DASHED_BUILT_INS does not install git-*-pack
References: <CAGw6cBsEjOnh-ZqXCPfFha=NYEdy7JDddha=UzAau0Z1tBrWKg@mail.gmail.com>
        <nycvar.QRO.7.76.6.2010211626430.56@tvgsbejvaqbjf.bet>
Date:   Wed, 21 Oct 2020 11:34:37 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010211626430.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 21 Oct 2020 16:27:35 +0200 (CEST)")
Message-ID: <xmqqd01b8m2q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 147D6406-13CC-11EB-92B0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Reverting that hunk restores git-receive-pack, git-upload-archive, and
>> git-upload-pack (and only those).
>
> Indeed. I purposefully investigated without having a look at what you
> linked at, and came to the exact same conclusion.

Good---that's sort-of "independent verification" ;-)

Thanks, let's fast-track the fix for 2.29.1.

