Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 18:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245717AbiBJS2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:28:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiBJS2d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 13:28:33 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB58CED
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:28:34 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70986119093;
        Thu, 10 Feb 2022 13:28:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gc/mMuUbeJC8g6RPGUqEv3qCKnMLwaJIsB4V9N
        71fmA=; b=wGXfoUlfjRZgHv/yzfu3tuPEngeALv6GVUNQppItjbzVxxbx8pkcjT
        vW6LJxagLr/gJKi+oi+n28RKvv7smIegr3DyycpNokEARkzKCV3ssNBBweRa77fy
        +BeHki1HB3RNHItJSCE7KrEaRwZ6wDey7yj635vKUIOR0n5IevY3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67B1D119092;
        Thu, 10 Feb 2022 13:28:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA2F2119091;
        Thu, 10 Feb 2022 13:28:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
References: <xmqqczjvxy3o.fsf@gitster.g>
        <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
        <xmqqiltmwufw.fsf@gitster.g>
        <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
Date:   Thu, 10 Feb 2022 10:28:31 -0800
In-Reply-To: <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 10 Feb 2022 19:07:22 +0100")
Message-ID: <xmqqh796tw34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4083A506-8A9F-11EC-B9B1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, Feb 10, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >>    One thing that makes me worried somewhat is what I did not touch,
>> >>    namely, how pseudo refs are defined.  I know MERGE_HEAD is very
>> >>    special and it may be impossible to coax it into refs API for
>> >>    writing, so the text there makes sense for it, but there are
>> >>    other all-caps-and-directly-under-dot-git-directory files like
>> >>    ORIG_HEAD and CHERRY_PICK_HEAD that are written using the refs
>> >>    API, so the description would have to be updated there.
>> >
>> > I'm not quite following; why would the description need to be updated?
>> >  Sure MERGE_HEAD is written without using the refs API, but we didn't
>> > mention how the pseduorefs were written in the description, and all of
>> > MERGE_HEAD, CHERRY_PICK_HEAD, ORIG_HEAD, REVERT_HEAD get written
>> > per-worktree so doesn't "pseudorefs like MERGE_HEAD" cover it as far
>> > as the reader is concerned?
>>
>> Here is how pseudo refs are defined.
>>
>> [[def_pseudoref]]pseudoref::
>>         Pseudorefs are a class of files under `$GIT_DIR` which behave
>>         like refs for the purposes of rev-parse, but which are treated
>>         specially by git.  Pseudorefs both have names that are all-caps,
>>         and always start with a line consisting of a
>>         <<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
>>         pseudoref, because it is sometimes a symbolic ref.  They might
>
> refs.c says
>
>         if (is_pseudoref_syntax(refname))
>                 return REF_TYPE_PSEUDOREF;
>
> Ie. ref_type("HEAD") == REF_TYPE_PSEUDOREF
>
> This may be partly my fault (commit 55dd8b910 "Make HEAD a PSEUDOREF
> rather than PER_WORKTREE.").
>
> From the source code I had only understood that pseudorefs are ALLCAPS
> names and are in the toplevel namespace.
> (HEAD, FETCH_HEAD and MERGE_HEAD have special-cased support in various places).
>
> Is this glossary the official definition of what things are? If so,
> the source code should refer to there. If not -except for confusion-
> how bad is it if the info in the glossary is inaccurate?

Developer and end-user confusion ensues.

>> What worries me the most is that we cannot simply say "all-caps
>> names that end with '_HEAD' all behave like refs except that they
>> will not be symrefs without reflog." MERGE_HEAD is the only known
>> exception if I am not mistaken, and I am OK to single it out as an
>> oddball.  The current description however gives that there are a lot
>> more differences _among_ pseudorefs.
>
> It might be possible to add this extra info the reftable format as a
> further subtype of the ref record.  We'd have to update the JGit
> implementation, though.

As you said earlier, the true oddball is FETCH_HEAD X-<.  I actually
think in all the discussion in this thread around pseudoref, I meant
that one when I mentioned MERGE_HEAD, and I suspect the glossary
entry also made the same mistake of not mentioning it.  MERGE_HEAD
is also different in that it can list more than one commit, but
FETCH_HEAD has a lot more information per commit.

The format was invented solely for the purpose of passing
information from "git fetch" to "git merge" as an implementation
detail of "git pull" to describe each commit/tag that are being
merged, so that it can in turn pass the extra info to drive "git
fmt-merge-msg" internally to prepare merge template.

"git pull" did have to use such a special format temporary file
(which is what FETCH_HEAD really is, rather than a ref that records
more than one commits), but we didn't have to treat such an oddball
temporary file as if it were a ref.  But we allowed "git rev-parse"
to read only the first object name in the file and ignore the rest
as if nothing strange happened, which probably was a mistake made
out of my sloppyness when we did "pull is fetch followed by merge"
callchain.

For backward compatibility, "git merge FETCH_HEAD" still may have to
work the way it does (i.e. if FETCH_HEAD has multiple lines, the
resulting merge would become an octopus merge, and merge message
will say not just the commit but mention where they came from).  But
I am not sure if it is essential for us to keep treating these
oddball temporary files as if they are (sort of) refs.
