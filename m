Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EA5C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CBB23435
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhAGUY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:24:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64825 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbhAGUY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:24:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2842102268;
        Thu,  7 Jan 2021 15:23:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xNQbH1lVnuvE1eN99GFUE8Wff2M=; b=ZLSUjt
        iFSFlmaGiYajsdl++iap2jcTwyE6fgE44q8WkIQc+3Joi0hoszYgQ+vvBQSodqqA
        jSrPuSo7HXCjXRFpp1UA+fl39nOu6MrzbDKEGYMYHC5NnPw+qWnaVzOmk3dseifl
        Xo1uN5e6tFZkPXje7Ni1JFQJdf4XdtotiqreA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=djm+028ePirh4bzMdviCzS8srwDPtUef
        KFwZywa3qXuq92A98Mf0MZDqfYK0VmzeNs3szS1I+f6vIZ6Awd+T/sP1L5vIXrYt
        LCpK/inHhhZrn6lrcEMchQ2wU5OTMfpdAuUGzlrDDJM/2j1c6RASqHqx88D9RKJF
        9WchSrfPft0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A034A102267;
        Thu,  7 Jan 2021 15:23:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D40E6102264;
        Thu,  7 Jan 2021 15:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: What's cooking in git.git (Jan 2021, #01; Wed, 6)
References: <xmqqa6tkn9xw.fsf@gitster.c.googlers.com>
        <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>
Date:   Thu, 07 Jan 2021 12:23:39 -0800
In-Reply-To: <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 7 Jan 2021 10:21:40 -0800")
Message-ID: <xmqqpn2glcms.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B342BCE-5126-11EB-A344-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Larger picture provided last week[1].  I would now say that:
>   * mt/rm-sparse-checkout needs some small changes (Matheus: I'm happy
> to tweak the patch and add a Helped-by: Elijah to it if you want me to
> push those changes)

OK.

>   * the bug fix part of mt/grep-sparse-checkout could possibly be
> broken out and merged now (Matheus: similar question here...do you
> want help with this?)

It is always preferrable to fast-track a smaller and less noisy
change that is focused on fixing a bug.

>   * the other parts of mt/grep-sparse-checkout should probably wait
> off based on Stollee's sparse-index work mentioned later in that
> thread (Matheus: I'm so sorry we've delayed your series for so long.
> I feel bad.  But Stollee is proposing some rather big changes that
> could significantly affect this and several other things.)

Yup, I do not think I mind tentatively dropping the piecemeal
"improvements" bits if it makes it easier to solidify the foundation
to build on.  You guys decide.

>> * en/merge-ort-3 (2020-12-15) 11 commits
>>  - merge-ort: add implementation of type-changed rename handling
>>  - merge-ort: add implementation of normal rename handling
>>  - merge-ort: add implementation of rename collisions
>>  - merge-ort: add implementation of rename/delete conflicts
>>  - merge-ort: add implementation of both sides renaming differently
>>  - merge-ort: add implementation of both sides renaming identically
>>  - merge-ort: add basic outline for process_renames()
>>  - merge-ort: implement compare_pairs() and collect_renames()
>>  - merge-ort: implement detect_regular_renames()
>>  - merge-ort: add initial outline for basic rename detection
>>  - merge-ort: add basic data structures for handling renames
>>  (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-recursive and en/ort-conflict-handling.)
>>
>>  Rename detection is added to the "ORT" merge strategy.
>
> Is there a reason this is being held back in seen?  It was submitted
> and reviewed[2] before en/merge-ort-recursive which you've marked for
> merging to master.  I'm not aware of any outstanding review issues,
> and think it's ready to merge down.

Just getting overlooked and nobody bothered to ping the topic ;-)

>> * en/diffcore-rename (2021-01-04) 9 commits
>>  - diffcore-rename: remove unnecessary duplicate entry checks
>>  - diffcore-rename: accelerate rename_dst setup
>>  - diffcore-rename: simplify and accelerate register_rename_src()
>>  - t4058: explore duplicate tree entry handling in a bit more detail
>>  - t4058: add more tests and documentation for duplicate tree entry handling
>>  - diffcore-rename: reduce jumpiness in progress counters
>>  - diffcore-rename: simplify limit check
>>  - diffcore-rename: avoid usage of global in too_many_rename_candidates()
>>  - diffcore-rename: rename num_create to num_destinations
>>
>>  File-level rename detection updates.
>
> I'm curious again about your workflow and the meanings of your
> messages.  Here, I'm surprised by the change in date; in [2] you
> listed it as 2020-12-14.  Do you update the dates when you pull in new
> versions of the patch series?

These record the committer dates, which is much closer to the date
the version of the patches were exposed to public testing for the
first time, and probably is more appropriate than the author date to
use to judge how long each topic has been "cooked".

> Anyway, I'm not aware of any outstanding requests for this series; I
> think it's ready to start merging down.  Are there issues you are
> aware of that you want to see fixed?

Again, just getting overlooked and nobody bothered to ping the
topic; also I haven't had chance to give these patches serious
enough reading they deserve yet.
