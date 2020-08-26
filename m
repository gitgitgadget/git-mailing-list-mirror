Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171DBC433E3
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED28C2074A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XdvJlyjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHZQsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:48:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64249 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgHZQpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:45:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D38116880B;
        Wed, 26 Aug 2020 12:45:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZQsuomId4DRHTAcMvqQRknrdDiw=; b=XdvJly
        jAIL1ma3GOd0bh7ArnI3cI2EgUxxshu6w/V0elMD8TUndZiQ184HIS859JuP0LRI
        aNiQ6cBmkYJiLgBxSgnWRNJrBvVsZjoLFuya5J3Oa8X7+qcxmRCm/ib0tuOxyS65
        g7pNG+YnONmASCC6/vDbgvgBzIyuy9Duw2d0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qDF2KxEad2W2Mb4oPMLMCbGC0vS6uoky
        YRr8PQSMya/dx3kAACy1d35z6gaMTF3YoPSJhLYta6jeDjouMCTGR/wVCPiB9hys
        3SHr/ss1VPSbUxYLiUEuuwj6AG+s9FjNBqjNwaJFA/V30rAlaEQFm/eoPQMjTZvh
        xGttk4f7nRo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA9AC68809;
        Wed, 26 Aug 2020 12:45:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 507CD68808;
        Wed, 26 Aug 2020 12:45:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 0/3] War on dashed-git
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <nycvar.QRO.7.76.6.2008261007100.56@tvgsbejvaqbjf.bet>
Date:   Wed, 26 Aug 2020 09:45:42 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008261007100.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 26 Aug 2020 10:09:25 +0200 (CEST)")
Message-ID: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9507F74A-E7BB-11EA-AA41-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So maybe this patch series would be a good first step, but if we truly
> wanted to break that 12-year old promise, we might need to have another
> patch on top that _does_ install the dashed commands, but into a
> subdirectory of `libexec/git-core/` that is only added to the `PATH` when
> an "escape hatch"-style config setting is set.

Yes, I think that is a much more reasonable approach.  Instead of
checking another environment variable that does not do anything but
bypass the "you used dashed form for builtin" check, we install non
builtins in libexec/git-core and leave the exec-cmd.c::setup_path()
as-is to add it to the PATH.  A new location will have the buitlin
binaries, say in libexec/git-core/builtins, and it is not added to
the $PATH by us.  The scripts that the users updated 12-years ago by
adding the former to the $PATH now needs to also add the latter,
too, and those users will loudly complain (which is what we want to
see happen [*1*]), but doing so is an easy way to unbreak them while
we reverse the course.

I think the cvsexportcommit and transport-helper changes are worth
salvaging even if we don't remove builtin binaries, so I'll split
them and whip them a bit more into a reasonable shape to be merged
to 'next'.  The "break those who say 'git-cat-file'" can be left for
future.

Thanks.


[Footnote]

*1* In the ancient thread, I was sick of hearing complaints that
beat the dead horse, but in this particular case, we do want to hear
from them---that is the primary reason why we are doing it.

https://public-inbox.org/git/7vr68b8q9p.fsf@gitster.siamese.dyndns.org/

