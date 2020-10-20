Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5149C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAF122256
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 22:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vn8WmEIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410315AbgJTWGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 18:06:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54091 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391762AbgJTWGM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 18:06:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 91B3AFB253;
        Tue, 20 Oct 2020 18:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zua2OM/PkjB+EQPChkUbkIFNxaE=; b=Vn8WmE
        IM19QzeDQ9N5raVEKC99y7oaAG2iSxFAGtN3po6doJTCD1rTGrEXy2RLWhltjlNV
        +D5/ITpNCc4aXKPSZf/FDmQjkiLDk/twc8cM3i1gf6enLmqmLdziTzFseAb6JILn
        mOka2CU8WJM4WG6DbF/+CbNVImaGr3k/+O48I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YsJ80X1AfnEVLdHoEIjVWVPSsil8eqZc
        fqVUoW6+6330d4JISTsXV/LvHusNvmy8jCwNy220pcYgw2eF+KWqJ9b29FFIPN0j
        Zk+sxPsAT2ZC1YLGZm4doNlMs55HnpNLC6mJ7vIQHW0MVrJtsQmLzm2eYIBX/ycm
        BLHVClA9+LM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A7ADFB252;
        Tue, 20 Oct 2020 18:06:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2915FB251;
        Tue, 20 Oct 2020 18:06:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 0/4] clarify meaning of --signoff & related doc
 improvements in describing Signed-off-by
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
        <20201018233136.GA4204@nand.local>
        <20201018194912.2716372-1-gitster@pobox.com>
        <xmqqmu0it6ls.fsf@gitster.c.googlers.com>
        <cover.1603142543.git.bkuhn@sfconservancy.org>
        <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org>
        <20201019220214.GB49623@nand.local>
        <cover.1603155607.git.bkuhn@sfconservancy.org>
        <20201020023407.GB54484@nand.local> <20201020212820.GA1368742@ebb.org>
Date:   Tue, 20 Oct 2020 15:06:05 -0700
In-Reply-To: <20201020212820.GA1368742@ebb.org> (Bradley M. Kuhn's message of
        "Tue, 20 Oct 2020 14:28:20 -0700")
Message-ID: <xmqq7drka6ya.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73DE5F4C-1320-11EB-8869-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Bradley M. Kuhn" <bkuhn@sfconservancy.org> writes:

> I wasn't sure what I should be doing with the patch set once it was already
> in 'seen'.  The only two references in SubmittingPatches I could find were:

Being 'seen' is an indication that it has been seen and does not
mean anything more than that.  It is appreciated that a topic in
such a state is improved by replacing.

> From Documentation/SubmittingPatches:
>>> In any time between the (2)-(3) cycle, the maintainer may pick it up from
>>> the list and queue it to `seen`, in order to make it easier for people
>>> play with it without having to pick up and apply the patch to their trees
>>> themselves.

Yes.  Other people then can "git fetch" from me and follow the first
parent chain "git log --first-parent origin/master..origin/seen" to
find the tip of your topic, instead of finding your message in the
list archive and running "git am" themselves.

The original submitter/owner of the topic can also find the tip of
the topic _in_ my tree the same way as others and reset their branch
to what is queued in 'seen' if they wanted to keep minor fixes I
made based on review comments while applying the e-mailed patches.

Then they can further work on polishing the topic with the usual
means, e.g. using "rebase -i", and finally "format-patch" to send
out a new round.  Being or not being in 'seen' does not change the
workflow that much.

>>> `git pull --rebase` will automatically skip already-applied patches, and
>>> will let you know. This works only if you rebase on top of the branch in
>>> which your patch has been merged (i.e. it will not tell you if your patch
>>> is merged in `seen` if you rebase on top of master).

This is talking about a fairly mature topic that has already been in
'next' and was on the course to graduate to 'master'.  The topic
would eventually be in 'master', and at that point "pull --rebase"
would notice that the patches are no longer needed (or were merged
in a different form).  But that does not apply to topics that are
not in 'master' yet.

Where the workflow changes is when the topic hits 'next'.  After
that, we request you to give incremental updates to refine what is
queued already.  

The reasoning behind this is simple and arbitrary.  It often is the
case that keeping mistakes in early iterations, and fixes to these
mistakes, recorded in history is not worth the attention of future
readers of "git log" who need to study the history, assuming that
trivial mistakes are caught early.  Once earlier rounds of review is
done and everybody is more or less happy, the topic gets merged to
'next', and after that point, a new issue that gets noticed and
fixed _are_ worth recording in history, because both the original
contributor and reviewers failed to catch such glitches.

> I'm curious to know if I went wrong somewhere and the workflow and would be
> glad to propose another patch to improve SubmittingPatches with a section of
> what to do when patches show up in `seen`, but since I'm a n00b (at least as
> an upstream Git contributor :), I'd need to know how to DTRT in this case to
> do that.

I thought your v3 did things perfectly.

Thanks.
