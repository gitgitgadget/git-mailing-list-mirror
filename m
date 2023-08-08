Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C5C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjHHRX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjHHRW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:22:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288A67295
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:09:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98CC11AE6B3;
        Tue,  8 Aug 2023 12:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H/1fwxCQQh4af2tEN+ANViHEX/gK+Mol97velt
        KSjvY=; b=L9lieSS7esS2RakLIGGIOgACao+xdp+hwOOU7sArYFTCyZIx8/n/Iv
        8USHvIuEB90IU613RFtMnf5yg5UdrIyN0XiyxJoer4aeSg0oHSMqQZ/9Ru5tUsKT
        N5Ev44lMKTSQJlitTxb18RWDh1WF2afvVa0MeH8fS53CehORwaEJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C1601AE6B2;
        Tue,  8 Aug 2023 12:08:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF8171AE6B1;
        Tue,  8 Aug 2023 12:08:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3] send-email: prompt-dependent exit codes
References: <xmqqttx1l3zp.fsf@gitster.g>
        <20230807165850.2335067-1-oswald.buddenhagen@gmx.de>
        <xmqqbkfifzry.fsf@gitster.g> <ZNIfDXJBqEVcHh+D@ugly>
Date:   Tue, 08 Aug 2023 09:08:56 -0700
In-Reply-To: <ZNIfDXJBqEVcHh+D@ugly> (Oswald Buddenhagen's message of "Tue, 8
        Aug 2023 12:55:09 +0200")
Message-ID: <xmqqmsz1a547.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E15B0736-3605-11EE-92C0-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> i think it's acceptable to expect them to adjust to the (from
> their POV) false positives,...

You are not in the position to unilaterally declare "it isn't really
worth it" or "it's acceptable to expect", though.  We know at least
one person want the program to signal failure when interactively
aborted.  We know that all other current users did not complain that
the program did not signal failure when they interactively aborted,
they may be they did not care enough, or they may be they are happy.
You do not know the population and neither do I, but that is not the
point.  This behaviour change is, even among Git developers, not a
bugfix but is a new feature that not everybody would want to be
subjected to.  It always is the safest to make such a backward
incompatible change a strictly opt-in feature.

>>Thanks.  Will queue but expect at least some documentation updates.
>>
> do you want a followup, or a v4 to replace the commit?

Replace it.  We do not want to do "oops that was lacking, here is an
incremental update" for anything that is not in 'next'.

Thanks.
