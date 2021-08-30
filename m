Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7940BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEBA6102A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbhH3Xpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 19:45:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60507 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbhH3Xpd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 19:45:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E422E7C8E;
        Mon, 30 Aug 2021 19:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PTwNS71mIBoa
        +dM+70GKNRPPEloc0nExEK1sh913jbs=; b=Da4hTUEVPqevLaJbszo790LAlLUI
        a5nlXPMlEgs4av6/5y9/lh0TrR/1SWh8gFMwh/A93mZMKPouyP/SmjlX5ebbKpal
        I7TLlr/6XQXfp7hIDE9hjZJv4yUMJzVX1cCjRXpyqnN4Q0A9qyaxhIOEnYHOgzCr
        A2WcmYBsZ1mdmMs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04257E7C8D;
        Mon, 30 Aug 2021 19:44:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F4FDE7C8B;
        Mon, 30 Aug 2021 19:44:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Clemens Fruhwirth <clemens@endorphin.org>
Subject: Re: What's cooking in git.git (Aug 2021, #09; Sun, 29)
References: <xmqq35qr7mq5.fsf@gitster.g> <87tuj7xhqo.fsf@evledraar.gmail.com>
        <CAFQ2z_PCUr3D0H-fzfHcFFayzdDJc64=JgVM5_2kuLJn-G9awA@mail.gmail.com>
Date:   Mon, 30 Aug 2021 16:44:37 -0700
In-Reply-To: <CAFQ2z_PCUr3D0H-fzfHcFFayzdDJc64=JgVM5_2kuLJn-G9awA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 30 Aug 2021 14:23:20 +0200")
Message-ID: <xmqqtuj6zee2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3D33EFA2-09EC-11EC-8C1E-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Mon, Aug 30, 2021 at 2:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
>> Han-Wen: It would be really nice to have this re-rolled sooner than
>> later, my and Junio's "fixup" commits at the end are a band-aid, but I
>> already ran into wanting to bisect something between master..seen that
>> was unnecessarily painful due to the series now not compiling without
>> the "fixup" commits at the end.
>
> I am folding in the __FUNCTION__ fix.
>
> However, I thought patches should be sent against the master branch
> and not against some intermediate  version of 'seen' ?

Sure, but in this case I think these errno and reftable patches have
been made to build on top of them, forming a single gigantic series.
Here is what I have for now.

$ git log --first-parent --oneline --decorate master..hn/reftable
447290b6a4 (hn/reftable) SQUASH??? https://github.com/git/git/run...
f76d6f0ad8 reftable: fixup for new base topic 3/3
dd1c4edcf2 reftable: fixup for new base topic 2/3
3b5bcd75c0 reftable: fixup for new base topic 1/3
6f5b8c7d12 t1404: annotate test cases with REFFILES
1de26b03cf t1401,t2011: parameterize HEAD.lock for REFFILES
ed288d74ad t1301: document what needs to be done for reftable
9e4385c42a Add "test-tool dump-reftable" command.
1792a05f21 git-prompt: prepare for reftable refs backend
07aab82357 refs: RFC: Reftable support for git-core
a83701eef8 reftable: add dump utility
385d6c58c5 reftable: implement stack, a mutable database of reftable file=
s.
b9e7eceb13 reftable: implement refname validation
b6e5675982 reftable: add merged table view
38119bdd8d reftable: add a heap-based priority queue for reftable records
d0c6772ff7 reftable: reftable file level tests
c6c539dd32 reftable: read reftable files
f65d21f3b1 reftable: generic interface to tables
897ad67203 reftable: write reftable files
015556832e reftable: a generic binary tree implementation
7c4b155181 reftable: reading/writing blocks
92c1c3179f Provide zlib's uncompress2 from compat/zlib-compat.c
784075c5f6 reftable: (de)serialization for the polymorphic record type.
5440a522c3 reftable: add blocksource, an abstraction for random access re=
ads
cc2a68a200 reftable: utility functions
2efae91445 reftable: add error related functionality
af64fc6ba6 reftable: RFC: add LICENSE
1ade5fa369 init-db: set the_repository->hash_algo early on
f39a30dc25 hash.h: provide constants for the hash IDs
3fde557f7f (ab/refs-errno-cleanup) refs: make errno output explici...
86c9090d90 refs: explicitly return failure_errno from parse_loose_ref_con=
tents
30f5e21f7f branch tests: test for errno propagating on failing read
f3df9ee957 refs: add failure_errno to refs_read_raw_ref() signature
5b12e16bb1 (hn/refs-errno-cleanup) refs: make errno output explicit for r=
ead_raw_ref_fn
1ae6ed230a refs/files-backend: stop setting errno from lock_ref_oid_basic
20d422cfd7 refs: remove EINVAL errno output from specification of read_ra=
w_ref_fn
3fa2e91d17 refs file backend: move raceproof_create_file() here
48cdcd9ca0 (ab/refs-files-cleanup) refs/files: remove unused "errno !=3D =
ENOTDIR" condition
245fbba46d refs/files: remove unused "errno =3D=3D EISDIR" code
ff7a2e4dbb refs/files: remove unused "oid" in lock_ref_oid_basic()
cc40b5ce13 refs API: remove OID argument to reflog_expire()
ae35e16cd4 reflog expire: don't lock reflogs using previously seen OID
7aa7829f75 refs/files: add a comment about refs_reflog_exists() call
6f45ec88d2 refs: make repo_dwim_log() accept a NULL oid
81bc122589 refs/debug: re-indent argument list for "prepare"
640d9d55c3 refs/files: remove unused "skip" in lock_raw_ref() too
11e984da07 refs/files: remove unused "extras/skip" in lock_ref_oid_basic(=
)
491ad946b2 refs: drop unused "flags" parameter to lock_ref_oid_basic()
212631ed50 refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
881aebffcf refs/packet: add missing BUG() invocations to reflog callbacks
