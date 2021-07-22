Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEC6C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31A960EB2
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 22:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhGVV5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:57:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57161 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhGVV5F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 17:57:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 334BF14F788;
        Thu, 22 Jul 2021 18:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YoaLBFvk93Fp
        S+ftDgqT90SFgWqYlqi3hhq3SgsZeSM=; b=uFDFiBAjTOD7bgTbviETF9tK0Vnb
        fkvjHu1jkHvJ879wdo2MG7Fs+FaMdUWkcs/6aQLWTNW19ZkEyVKKwoWqrmyZqXbC
        WUKT9A5K91oEa99oYbmwuCjzCJMRlDel+z5B48/R4g4Gg/iheCUW0nvkvTvXfi4X
        BxtF0P1tWIh5Yoo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C22214F787;
        Thu, 22 Jul 2021 18:37:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 720B414F786;
        Thu, 22 Jul 2021 18:37:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Jul 2021, #05; Wed, 21)
References: <xmqqo8av9j7f.fsf@gitster.g> <87a6mevkrx.fsf@evledraar.gmail.com>
Date:   Thu, 22 Jul 2021 15:37:35 -0700
In-Reply-To: <87a6mevkrx.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 22 Jul 2021 09:33:39 +0200")
Message-ID: <xmqqbl6u7z68.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A5B47E6-EB3D-11EB-8C9A-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> * ab/refs-files-cleanup (2021-07-20) 12 commits
>>  - refs/files: remove unused "errno !=3D ENOTDIR" condition
>>  - refs/files: remove unused "errno =3D=3D EISDIR" code
>>  - refs/files: remove unused "oid" in lock_ref_oid_basic()
>>  - reflog expire: don't lock reflogs using previously seen OID
>>  - refs/files: add a comment about refs_reflog_exists() call
>>  - refs: make repo_dwim_log() accept a NULL oid
>>  - refs API: pass the "lock OID" to reflog "prepare"
>>  - refs/debug: re-indent argument list for "prepare"
>>  - refs/files: remove unused "skip" in lock_raw_ref() too
>>  - refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
>>  - refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
>>  - refs/packet: add missing BUG() invocations to reflog callbacks
>>  (this branch is used by hn/refs-errno-cleanup.)
>>
>>  Patches are mostly good, but needs typofixes etc.
>>
>>  Will merge to 'next'.
>
> Yay, thanks!

Yikes, I shouldn't have said Will merge when I clearly said "needs
typofixes".  If you are employing the strategy to wear me out and
mistakenly merge topics prematurely, it is succeeding X-<.

>> * ab/attribute-format (2021-07-13) 5 commits
>> [...]
>> * ab/imap-send-read-everything-simplify (2021-07-07) 1 commit
>> [...]
>> * ab/pkt-line-tests (2021-07-19) 1 commit
>
> Thanks!

Thanks for all of these.

>> * ab/bundle-doc (2021-07-20) 3 commits
>>  - bundle doc: elaborate on rev<->ref restriction
>>  - bundle doc: elaborate on object prerequisites
>>  - bundle doc: rewrite the "DESCRIPTION" section
>>
>>  Doc update.
>>
>>  Expecting a reroll.
>>  at least for the second patch.

Sorry, I think we have a reroll that updates the second one and that
is what we list here.  IOW the comment is stale.

> My reading-between-the-lines of
> https://lore.kernel.org/git/xmqqsg08hhs0.fsf@gitster.g/ and
> https://lore.kernel.org/git/xmqqo8awhh5z.fsf@gitster.g/ is that you'd b=
e
> happy toh have this be merged down in its current form, no?

As I commented, the tip one's mention of show-ref is rather iffy.
I thought you'd be rephrasing it further in response to Philip's
"what about list-heads?" (I am not sure if it is wise to stress on
list-heads, which was a debugging aid, when ls-remote is available).

Also, the second one talks about "object prerequisites" (I think
calling them "prerequisite objects" would be more natural, though)
and the third one uses "basis" (I take that the "bases" in "the
given bases" is used as the plural for the word), but it is not
clear to readers that these mean the same thing.  If we are touching
the doc, we may want to make sure the end-result as a whole gives a
coherent narrative.

>> * ab/pack-stdin-packs-fix (2021-07-09) 2 commits
>>  - pack-objects: fix segfault in --stdin-packs option
>>  - pack-objects tests: cover blindspots in stdin handling
>>
>>  Input validation of "git pack-objects --stdin-packs" has been
>>  corrected.
>>
>>  Ack?
>>  cf. <YND3h2l10PlnSNGJ@nand.local>
>
> Have re-rolled & addressed that, I think
> https://lore.kernel.org/git/YPcA0oxJgedIf57K@nand.local/ can be read as
> "sure, let's take =C3=86var's v2 as-is", but let's have Taylor Ack that=
 :)

OK.

>> * ab/make-tags-cleanup (2021-06-29) 5 commits
>>  - Makefile: normalize clobbering & xargs for tags targets
>>  - Makefile: don't use "FORCE" for tags targets
>>  - Makefile: fix "cscope" target to refer to cscope.out
>>  - Makefile: add QUIET_GEN to "cscope" target
>>  - Makefile: move ".PHONY: cscope" near its target
>>
>>  Build clean-up for "make tags" and friends.
>>
>>  Expecting a reroll.
>>  Hopefully with a final reroll it would become good enough shape for '=
next'?
>>  cf. <YN5AwdVC3QAcy2tA@coredump.intra.peff.net>
>>  cf. <67c45b13-df8f-8065-377a-fbd2f80992ee@ramsayjones.plus.com>
>
> Re-rolled since & addressed those, hopefully ready for "next" now:
> https://lore.kernel.org/git/cover-0.5-00000000000-20210721T231900Z-avar=
ab@gmail.com/

Thanks.
