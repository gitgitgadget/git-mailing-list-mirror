Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3B120D09
	for <e@80x24.org>; Sat, 15 Apr 2017 10:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752855AbdDOKDp (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 06:03:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64495 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752102AbdDOKDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 06:03:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DE3179181;
        Sat, 15 Apr 2017 06:03:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hYv3J4ZgWW7lKYpgdgmWWqR+LEg=; b=SWpdRd
        dECba9Nh0FZXn4dPLxmntR/4uu9qVN2M0WR5iJWl+NLTFLC/hkqXCDt0GPhsGiDH
        g5T2UMRGKo/AlvITOMrBSqeNkf0PWQ/romqbNlaVNETbo6HpmsuSd9OZmlCwAFsn
        6AuZ9GBYZb5skTTfX+pDOZwpLNpdQX70HAkBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jK2GsIMQ5fENP0RzFWj+MCS/ZmE2W6Sv
        6kMquJIbEh5tOxGyQxaeEUL23H+x55HoSYc039FoHSyJKgxEyAxPlUkLd8LGAFWn
        fn8fnZEbeLEFLrpIsOtLc1uyNGU7tX8rQ5yWPoWPRBvtvpmyUvpwye5Q9SYCMoXd
        fT/eEkipboc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 630B67917F;
        Sat, 15 Apr 2017 06:03:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C72D77917E;
        Sat, 15 Apr 2017 06:03:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git ML <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCHv3] rebase: pass --[no-]signoff option to git am
References: <20170414225713.29710-1-giuseppe.bilotta@gmail.com>
        <xmqqefwum3mh.fsf@gitster.mtv.corp.google.com>
        <CAOxFTcwDrYvg5Nf1w9SfmM=Nt7XYsJPhKSYkJzMC0123EY94Aw@mail.gmail.com>
Date:   Sat, 15 Apr 2017 03:03:40 -0700
In-Reply-To: <CAOxFTcwDrYvg5Nf1w9SfmM=Nt7XYsJPhKSYkJzMC0123EY94Aw@mail.gmail.com>
        (Giuseppe Bilotta's message of "Sat, 15 Apr 2017 11:36:44 +0200")
Message-ID: <xmqqa87im1hf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDCE21E8-21C2-11E7-B6DB-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

>> We need new tests for "git rebase --signoff" that makes sure this
>> works as expected and only when it should.
>
> Would the norm in this case be to introduce the test in the same
> commit, or in a previous commit (as in: this is the feature we want to
> implement, it obviously doesn't work now, but the next commit will fix
> that), or in a subsequent one?

For a new feature (especially with this small implementation), it is
best to have the test in the same commit.  

We often use the "start with expect_failure, update the code while
flipping _failure to _success" pattern but that is primarily
suitable for bugfixes.
