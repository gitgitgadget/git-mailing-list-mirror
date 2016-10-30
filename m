Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1A520193
	for <e@80x24.org>; Sun, 30 Oct 2016 22:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753900AbcJ3WyC (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 18:54:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752800AbcJ3WyA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 18:54:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 239AD4C382;
        Sun, 30 Oct 2016 18:53:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KQ80O40xJYNc
        u8KYZb1uSHKL8Qk=; b=otfQPfq38CeWIPz22qOvPH4NNY5gFddi483+Yo0UfTAf
        Npgmb+iUgjH4O+gB2U3TvJycv+JJ1FoXEza8wYePLMMV44ICo6Y4Au6hl9X46NVM
        6YoKZjBOHx7RFIHO/suFYP34FGneBR2XDwqj7Nh3k4gPWf29X7cc1gojm1ZyI+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aTdnm9
        AyNe4NT4NC3zRme+XJednmQLmpfrw7+tx8vWktsQ2AQwF3ajJu4A0yPRYWCR5Eol
        HfkzCEm9kRx7VWS+TzLbiBaEraeX/id1eJ/kZ9hn34L4ldLhQn58rgZjJmLhiRpT
        lMDw1Mz/ZZeDHfn28ehLTGaLA6AmdBq54PFkQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AAC44C381;
        Sun, 30 Oct 2016 18:53:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CA9B4C380;
        Sun, 30 Oct 2016 18:53:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
        Anders Kaseorg <andersk@mit.edu>, 842477@bugs.debian.org,
        Git Mailing List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside scripts
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
        <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com>
        <alpine.DEB.2.10.1610301503280.60842@buzzword-bingo.mit.edu>
        <223121D101D844DEBF086AC40A5AF4CB@PhilipOakley>
        <20161030211227.4gqovv7mt7mtnpy7@sigill.intra.peff.net>
        <CACBZZX6ArQdG202n-SouwDhoTE1LF=69mKjWQv8HPKJ+K_0fJQ@mail.gmail.com>
Date:   Sun, 30 Oct 2016 15:53:55 -0700
In-Reply-To: <CACBZZX6ArQdG202n-SouwDhoTE1LF=69mKjWQv8HPKJ+K_0fJQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 30 Oct
 2016 23:11:10
        +0100")
Message-ID: <xmqqh97tv470.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD98B5B0-9EF3-11E6-BC28-987C12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

(commenting out of order)

> It's probably worthwhile to split off git-sh-setup into git-sh-setup &
> git-sh-setup-internal along with a documentation fix. A lot of what
> it's doing (e.g. git_broken_path_fix(), and adding a die() function)
> is probably only needed internally by git itself. The
> git-sh-setup-internal should be the thing sourcing "git-sh-i18n", I
> don't see how anyone out-of-tree could make use of that. Surely nobody
> needs to re-emit the exact message we shipped with our *.po files.

My reading of d323c6b641 ("i18n: git-sh-setup.sh: mark strings for
translation", 2016-06-17) is abit different.  It needs to dot-source
the i18n stuff because the shell library functions it contains need
the localization support in the messages they emit.  IOW, I do not
think i18n belongs to -internal at all.

> I don't see why we shouldn't have some stable shellscript function API
> if that's needed either.
>
> I just wanted to point out that currently git-sh-setup isn't
> documented as such. So at least a follow-up patch to the documentation
> seems in order.
>
> This did break in v2.10.0, and it's taken a couple of months to notice
> this, so clearly it's not very widely used, which says something about
> the cost-benefit of maintaining this for external users.

I am not sure if "stable API" in sh-setup is a good thing for the
ecosystem in the longer term.

As more and more in-tree scripted Porcelain commands migrate to C,
many helper functions in sh-setup will lose their in-tree users.
For example, get_author_ident_from_commit used to have three in-tree
customers (git-commit.sh, git-am.sh and git-rebase--interactive.sh),
but the first two is long gone and the third one may soon lose its
need to call it.  Once a helper function in setup-sh loses all
in-tree users, we may no longer _break_ that helper, but that is
simply because we feel no need to touch it.  The in-tree Porcelain
commands that migrated to C however will enhance the counterpart
they use in C to be more featureful or fix longstanding bugs in the
C version they use, while sh-setup version bitrot and making old
practice obsolete for "modern" use of Git of the day. =20

Keeping such a stale version that we do not use, or even we attempt
to update it without having a good vehicle to test the change
ourselves (because we no longer have any in-tree users) will be
disservice to third-party scripts---the only thing they are getting
by using the stale one, instead of reinventing their own that they
may be responsible to keep up to date, is that they share the same
staleness as everybody else that use the sh-setup version as a
third-party.

I am not arguing that we should remove what loses all in-tree users
immediately.  At least not yet.  But I wanted to point out that it
may not be a good use of our brain cycles to keep the API "stable"
by keeping what in-tree users do not use anymore, especially if it
does not help third-party users in the long run.


