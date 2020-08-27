Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB215C433E3
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639C82177B
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lmb6IK5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0P60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:58:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50063 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgH0P60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:58:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 107CF862C4;
        Thu, 27 Aug 2020 11:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WHriKrT0sflXKm9zV+dpJsTnu24=; b=Lmb6IK
        5i0y+gEYPrTzmzDKko0GY9m9b9NgOaksKhhMTxUk9gHFeZSQD5LVxeEiyeqBTYt8
        KAUGa+UryyTgIU0EqZXepQo/uJO99YbYcz9O1KiScUujOndM+sIrIb1ao3OSXlha
        JqCQCm8SHCha3jpUnhrQbulWLva3yxe2zzd6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UxEzTQySkKFVq75iu+cO8rh7xMc5H6AH
        p5fCi25JAKbsPyT3JEHPVY20AD1C7Yiopimz1CX1WCz1GzlayJLljHxiDkI7sJY1
        CqB8DSEErqCfwZ2l6etAHHp2dA06q+91+Kay5LYVpGOBmo7uxAzSn3XgI99N7GSG
        l8H1JlB140E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 094A4862C3;
        Thu, 27 Aug 2020 11:58:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 889BD862C2;
        Thu, 27 Aug 2020 11:58:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Toni Brkic <brkict@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>, git@vger.kernel.org
Subject: Re: feature request - add --only-author option to git push
References: <CAF2SHyBYZ7=vcL4sPdP=T9zRCBrwW_z0-o1v9=gC4=oPqv4oXQ@mail.gmail.com>
        <20200827101924.iklvsy6lnscrpojs@yadavpratyush.com>
        <CAF2SHyA_bg1wxaDaLN=m2G+0sZB=b30LTnm3rOPVEYgAx9Uazg@mail.gmail.com>
        <20200827115350.q3xzad3c2v4sgvaf@yadavpratyush.com>
        <CAF2SHyD2EO7o7RhKRGmMaffAa2=6z_rkO+CeBPWREObD=4HmuQ@mail.gmail.com>
Date:   Thu, 27 Aug 2020 08:58:22 -0700
In-Reply-To: <CAF2SHyD2EO7o7RhKRGmMaffAa2=6z_rkO+CeBPWREObD=4HmuQ@mail.gmail.com>
        (Toni Brkic's message of "Thu, 27 Aug 2020 15:32:12 +0200")
Message-ID: <xmqqv9h4qdwh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22CF8B52-E87E-11EA-ACA6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Toni Brkic <brkict@gmail.com> writes:

> ... If this would be
> something that would be of interest to be added I could take a look
> myself and try
> to write a patch.

I am personally not interested with "all my commits must be from me
and nobody else", but it might be a useful thing to have if we can
come up with an easy way to give a "git shortlog [-s]" (and other
"history summary" command the user can ask with configuration
variables and such) over the range of commits that will be pushed
(which theoretically cannot be known before "git push" starts
running) before the actual push happens.

Thanks.
