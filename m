Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A486C4BA18
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4920424680
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 17:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M9WWE7Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBZRgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:36:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55891 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgBZRf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 12:35:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D0A13933C;
        Wed, 26 Feb 2020 12:35:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ut6D6JL1Xb+Ikk0IMXGcONrfA5E=; b=M9WWE7
        Wks33owASqlK2s1ejcs9cg3OVU16ACLVGvzgBuc59pbTFM9MZqzD98pL7Ae8TLQO
        Rrt/TtHVkk5CRBTu/pNdmzpbKSdTQ61g0JZ531Yq4j2QirrHgvoXKKhlccbHqIyD
        Kp3/VPqnReLiryaNIE/QALUyOiTQa8/nJqj28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kl8fXTeu+2hqDbobDFCyYTd5k6KYScg4
        NDLK+nlV/1xMF2eVlfK9WoTX6ewd2luFhojX4Ks5RRDTlfekaAjR+5Ns7rOughCs
        x5j61LlMkfAP2AsqeBXC9JZU1FEnBTbm7VXO27zAfGXYhORA0KminNA62yCL6nDW
        9emhJ++XJBk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8406B3933B;
        Wed, 26 Feb 2020 12:35:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E29113933A;
        Wed, 26 Feb 2020 12:35:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 0/6] Reftable support git-core
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 09:35:56 -0800
In-Reply-To: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Wed, 26 Feb 2020 08:49:40
        +0000")
Message-ID: <xmqqk149jloj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72B0BE48-58BE-11EA-9B49-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds the reftable library, and hooks it up as a ref backend.

I do not see the promised .gitattributes addition; please add one
early in the series, before the step in which you start adding files
that want different whitespace rules, so that I do not have to apply
with "git am --whitespace=nowarn".

It is rather unfortunate that you included Jonathan's reftable doc
patch in the series---it has separately been queued and merged
already in 'next'.  I'll fork hn/reftable on top of the reftable doc
topic of Jonathan's, while dropping the extra copy [4/6] in this
series, to cope with this (an alternative would be to revert the one
in 'next' and take this series as-is).

>  * spots marked with XXX in the Git source code.

What follows is my notes while "git diff master...hn/reftable" and
looking for those lines, except for the ones in the reftable
implementation proper (for which you would be a better judge).

The init-db call in clone hardcodes DEFAULT_REF_STORAGE and that
should be OK at least for now.  Eventually the code would want to
read from the system-wide and the per-user configuration files to
figure it out, but I do not think the config subsystem is prepared
to read the configuration before making this call to init_db() right
now---let's leave such a complication until after the basics is
done.  After all, "git init && git add remote && git pull" can be
used as a rough approximate for "git clone"; as long as "git init"
can be told what backend to use, that would be sufficient to get us
going.

It sounds a bit too magical to convert the repository by running
"git init" again on an already existing repository.  But a user who
runs "git init" in an existing repository and asks to use settings
that are different from what the repository uses from the command
line cannot be expecting the command to error out when the settings
do not match (i.e. as a mechanism to check the setting)---the only
sensible way to interpret such an invocation is as a request to
convert the existing repository.  Again, I do not think it is a huge
loss to do without such an automatic conversion in the initial
deployment.

In refs.c, I am puzzled by the fact that a call to ref_store_init()
in the get_submodule_ref_store() needs to pass DEFAULT_REF_STORAGE,
or any format for that matter, at all.  Wouldn't the gitdir argument
sufficient for ref_store_init() to learn what backend the repository
uses?  IOW, I am not sure why the caller needs to pass the backend
format.  

The way r->ref_storage_format is used by get_main_ref_store(), at
least when the field is set, looks a lot more sensible.  Would it be
possible that get_submodule_ref_store() function would also want to
have, not just a submodule as a mere "string", but an instance of a
repository for that submodule?

Speaking of the use of ref_store_init() and r->ref_storage_format in
get_main_ref_store(), when is the storage_format field unspecified?
Is there a chicken-and-egg problem around here?

The same comments apply to the use of the default format in
get_worktree_ref_store(), but do we foresee to "add" a worktree that
uses one ref backend off of a repository that uses a different ref
backend?  Even if we do, it probably makes sense to default to the
same format as the primary worktree uses, I would think.  It is
still unclear to me why ref_store_init() wants the format in the
first place, though, given that it takes a path to the .git/
directory (or its equivalent), and ref_store_init() should be able
to figuire it out without being told.

I think it is fine to define the textual name of the default ref
storage in refs.h

Thanks.
