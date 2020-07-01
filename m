Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6595C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 20:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9B62082F
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 20:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P/cWh7y1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgGAU4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:56:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56443 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgGAU4u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 16:56:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1855C6BCA;
        Wed,  1 Jul 2020 16:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m1UR0ztUbr7ye8rwNb5ZAMBfNLc=; b=P/cWh7
        y19P7Sn2naZrJWbyzZi/e5S4hlpKikKb8rrLYbCxI8Qt1vHyjlgNVouAjGKliHnf
        8ZjcOoOfYtFLWmbvywwA8c1pRvwSPRE98yEk+MCNd+x9SlA9DGmUVoINcGIQMqCE
        D0leo0c3sUlRDh++FUd97NBQCju5Z1HhJgbmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IcC+H+OHO0qVASFU87PYGdGS82hf/aul
        KOLz/c2AsG4mEIDwf8ZFUAAimCKu0ATHb4Sk2YTk3770oiyGbEN6nFs9qFH0NwRM
        SOeBwrUvd+RbNL/i8Hp87KcohY/Zjdv54+MD+ZWqU7gheuHuer/xL0QoPfMawxL8
        rrlCu3RKf/E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9617C6BC9;
        Wed,  1 Jul 2020 16:56:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00644C6BC6;
        Wed,  1 Jul 2020 16:56:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v19 00/20] Reftable support git-core
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <xmqqimf9fppn.fsf@gitster.c.googlers.com>
        <CAFQ2z_MbiTEzztU9a8beMAQFn1-ozBUwKD1JyhXHUnoTTto0TA@mail.gmail.com>
        <xmqqbll0drtz.fsf@gitster.c.googlers.com>
        <CAFQ2z_MZoc3Q15O0LDTgVYV7nKEK1Oc8GLWEZYrrFjU9VSsUCQ@mail.gmail.com>
Date:   Wed, 01 Jul 2020 13:56:42 -0700
In-Reply-To: <CAFQ2z_MZoc3Q15O0LDTgVYV7nKEK1Oc8GLWEZYrrFjU9VSsUCQ@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 1 Jul 2020 12:16:47 +0200")
Message-ID: <xmqqmu4jc5th.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC24A32-BBDD-11EA-B667-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Jul 1, 2020 at 2:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > Do you have an opinion on
>> > https://public-inbox.org/git/pull.665.git.1592580071.gitgitgadget@gmail.com/
>> > ?
>> >
>> > There is some overlap with in sequencer.c, and Phillip's approach is
>> > likely more principled, so I'd like to base reftable on that.
>>
>> I assumed that these were offered to you as possible improvements to
>> be folded into your series, so I didn't read them very carefully and
>> I didn't queue them myself.  I expected that I would see them,
>> possibly modified to fit the context better, as part of your series
>> sent from you, perhaps to become a part of early clean-up portion of
>> your topic.
>
> They are changing the signature of widely used functions, which is
> useful for my series but not completely necessary. I would rather that
> someone else decides on how to go forward with the series.

I was about to say that having written one ref backend, you are
likely to have better context to judge how much better Phillip's
patches would make the world be than I do ;-), but having worked on
the "cleanse caller-supplied reflog message at generic layer"
illustration patch, I think I am familiar enough with these three
functions Phillip's patch touched to comment on them.

I am not sure why delete_ref() needs to be modified to take a
caller-supplied repository when refs_delete_ref() is already even a
better way to do so (it allows the caller to give a ref_store, which
is a part of a repository).  The same between update_ref() and
refs_update_ref().

Introducing a new repo_delete_ref() to extend the API into a
three-tuple,

	delete_ref(...) {
		return repo_delete_ref(the_repository, ...);
	}
	repo_delete_ref(repo, ...) {
		return refs_delete_ref(get_main_ref_store(repo), ...);
	}
	refs_delete_ref(...) {
		/* as we already have it */
	}

_might_ make sense, but then we should do so for not just delete and
update, but for all the operations consistently.  I do not know if
that is worth it offhand.  The issue Phillip's patch addresses looks
like a mere "lack of convenience", not a fundamental "without this
we cannot write correct code easily", at least to me.

What disturbed me more while I was looking at refs.c was that some
operations are not done (perhaps cannot be done) as a part of a
transaction.  refs_delete_refs() and refs_rename_ref() directly call
into the backend layer, for example, and that does not smell right.
