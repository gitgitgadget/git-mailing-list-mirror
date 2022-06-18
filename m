Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA842C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 23:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiFRXEW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 19:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiFRXER (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 19:04:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038912776
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 16:04:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B921F13B29C;
        Sat, 18 Jun 2022 19:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nXGphs8367PTvasY8NlD2wxjqrvRUoD/19DUdo
        suvgk=; b=c6RzBUJRLf8hQXd4krztffB2ep+VHlbJw4a8GFuO9eu2ia2/BvxiUv
        vd19UBfKsBh/I6JhFwRKjVEzrI9sQ/VnKjAnGtxfcLNXpZJ7khHEjkXKrM2HgV2Q
        sQ+zmbehSm/AcPCDQWsC/lviAa9hZE3OV2NnZ83+bPC7HkOeZ8/UY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF55013B29B;
        Sat, 18 Jun 2022 19:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1875313B29A;
        Sat, 18 Jun 2022 19:04:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
Subject: Re: Plumbing for mapping from a remote tracking ref to the remote ref?
References: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com>
        <xmqqilp1znn1.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2206182358350.349@tvgsbejvaqbjf.bet>
Date:   Sat, 18 Jun 2022 16:04:12 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2206182358350.349@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 19 Jun 2022 00:04:08 +0200 (CEST)")
Message-ID: <xmqqczf5lgk3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F829170C-EF5A-11EC-BB1E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> 	$ git refmap refs/remotes/somepath/{branch-A,branch-B}
>> 	origin refs/heads/branch-A
>> 	origin refs/heads/branch-B
>>
>> IOW, you give name(s) of remote-tracking branches and then you get
>> the remote and their ref for these?
>
> Modulo introducing a new top-level command (a subcommand of `git remote`
> would make much more sense and make the feature eminently more
> discoverable), and modulo allowing patterns in the ref to match, I agree.

"git remote" is primarily about "I have this remote---tell me more
about it", but this query goes in the other direction, and that is
why I threw a non-existing command to solicit alternatives that are
potentially better than "git remote".

FWIW, I did not have any opinion on where the feature should appear
or what the syntax to query the remote.<nick>.fetch refmap should
be, when I wrote the above.  I still do not (yet) have a strong
opinion.

I do not oppose to the "find remotes I can fetch from to update
these remote-tracking branches" feature existing.  I just wanted to
make sure whoever will work on it is aware of the fact that they
must consider the case with overlapping destinations.

Thanks.
