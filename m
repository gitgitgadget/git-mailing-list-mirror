Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803482089D
	for <e@80x24.org>; Fri, 28 Jul 2017 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdG1WMq (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 18:12:46 -0400
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35497 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbdG1WMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 18:12:45 -0400
Received: by mail-vk0-f43.google.com with SMTP id d124so634461vkf.2
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 15:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5uywwVl0DLqDe+70iT5ubaVPHwwKMeDnJGNQ2OrveOA=;
        b=InMTp1iv1Iof84VVUoagZRzYG/uWJmLYWVTURGSdhmnA91GOT5PnFgg6WrlWNaIEDN
         Xc3BWg0AT5h1rRY9Vz7BCWqIuqr4ztjDjS/ABceiFhRbPERlpIUhuPPFcOFv9+J4SELC
         zo6XFoJrQNTzKH5nuSZLUmdZiENfAnZaAGCq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5uywwVl0DLqDe+70iT5ubaVPHwwKMeDnJGNQ2OrveOA=;
        b=T1cVUHT20cO1np8rAn4EVuJg++JmiH5ZmsGIjaif6U118S36MMEvnWRVNQekiHPpe3
         +yJxWVayy2hMkjRwV/m8DGMSx0+csHj2/3AnyTkw0MbVFip8sMZwz2uy4ZL0tr3SmXfV
         MJ+bvo6enPuDstno+Dl5M83Ke2y028POmN5DUUpX+pmNC8ojAyge1i5wxk0SP/jR9x49
         MXe50j0VRnlZULQLl9jmWFvPoL5c0mKqYLe/8Rtx3VjbtKNeWYayRJvHRr6SuMrsDOwe
         +2UOqDx5ZxkCd9Z+AjQXpqOMnWUA0/L66VPM/AW4LXRddY9bnU1GKsbYspAsTKqq9MR9
         0A2Q==
X-Gm-Message-State: AIVw111kLPBlHpMpcgFWROwj39HtjAZtrqTAZypMwXdRjuvgtTU+TsA4
        pD/6OrxisirORGnqSOeMF0pW/BQ2w8rd
X-Received: by 10.31.138.78 with SMTP id m75mr1507159vkd.149.1501279963951;
 Fri, 28 Jul 2017 15:12:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.137.4 with HTTP; Fri, 28 Jul 2017 15:12:23 -0700 (PDT)
In-Reply-To: <CAMy9T_GeE5Xh7HJ7VZPX5B5SGUmjUbELER07-u0se5Y0ZJ5YtQ@mail.gmail.com>
References: <CAJo=hJvxWg2J-yRiCK3szux=eYM2ThjT0KWo-SFFOOc1RkxXzg@mail.gmail.com>
 <CAMy9T_GeE5Xh7HJ7VZPX5B5SGUmjUbELER07-u0se5Y0ZJ5YtQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Fri, 28 Jul 2017 15:12:23 -0700
Message-ID: <CAJo=hJvR_rV356Mna0cMoTY2mrVnG9MH39wDS1tLCRT1h_f65Q@mail.gmail.com>
Subject: Re: reftable [v3]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2017 at 7:28 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Sat, Jul 22, 2017 at 11:29 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> 3rd iteration of the reftable storage format.
>>
>> [...]
>> ### Objectives
>>
>> - Near constant time lookup for any single reference, even when the
>>   repository is cold and not in process or kernel cache.
>> - Near constant time verification a SHA-1 is referred to by at least
>>   one reference (for allow-tip-sha1-in-want).
>> - Efficient lookup of an entire namespace, such as `refs/tags/`.
>> - Support atomic push `O(size_of_update)` operations.
>> - Combine reflog storage with ref storage.
>
> I think that the optimization enabled by obj_records is only
> interesting for server-side repositories that will frequently be
> fetched from, and which additionally have allow-tip-sha1-in-want
> turned on, right? So could we make it explicitly optional?

Correct. Its already optional. Maybe I'm just not clear enough about
that in the document. I agree its not required in the file, and
writers can choose to omit obj_record.


>> #### obj record
>>
>> An `obj_record` describes a single object abbreviation, and the blocks
>> containing references using that unique abbreviation:
>>
>>     varint( prefix_length )
>>     varint( (suffix_length << 3) | cnt_3 )
>>     suffix
>>     varint( cnt_rest )?
>>     varint( block_delta )+
>>
> [...]
>> Each record contains `block_count` number of block identifiers for ref
>> blocks.  The `block_count` is determined by:
>>
>>     block_count = cnt_3
>>     if (cnt_3 == 0x7) {
>>       block_count += cnt_rest
>>     }
>>
>> The `cnt_rest` field is only present when `block_count >= 0x7` and
>> could overflow the `cnt_3` field available in the record start.  This
>> encoding scheme is used as the vast majority of abbreviations are
>> only one reference (or at most a few), and unlikely to exceed 6 blocks.
>
> I agree that this `cnt_3` handling is overly cute. There will never be
> records with `block_count == 0`, will there? Then I propose that
> `cnt_3` be set to zero if `block_count` is greater than 7, in which
> case the full block count is stored as a varint. It's simpler, and I
> think the only `block_count`s for which this scheme costs a byte more
> than your scheme are implausible: 128-134, 16383-16390, etc.

That is a great idea, thanks. I've updated the draft to reflect your
approach of cnt_3 = 0 indicates the actual count follows in a varint.


>> [...]
>> ### Log block format
>
> I'm still not happy about how you store reflogs. Here are my objections:
>
> * You store reflogs by appending a high-resolution time to the
> refname. This is awkward:
>   * There is always some uncertainty about uniqueness, even with a
> high-resolution clock. If you want to eliminate that uncertainty, you
> have to read the last entry in the reflog for the reference *for every
> update* to be sure that your timestamp is not already "in use".
>   * There is a need to invent microsecond values on systems with
> low-resolution clocks, again to ensure uniqueness.
>   * If there is clock skew, then either you lose information about the
> *order* of reference updates (which I would consider unacceptable), or
> you might have to invent fictional times for new updates to retain the
> order relative to previous updates. But inventing fictional times is
> very problematic: suppose somebody's clock is incorrectly set to the
> year 2020 when they make a commit. As far as Git is concerned, that is
> plausible, so the reflog entry gets that timestamp. Then the user
> corrects the clock and makes another commit. We would either be forced
> to rewrite the old reflog entry(ies) or to give a timestamp in 2020 to
> the new update.
> * With reftable storage, multiple-reference updates can be done
> atomically. But the reflogs don't retain the information about which
> references were updated together.
> * Even if all reflogs are retained, it is not possible to deduce the
> global state of all references at a moment in the past.
>
> I propose to solve all of the above problems, plus some others, as follows:
>
> Let's keep an integer `update_index`, which starts at zero and
> increases by one each atomic reference update (i.e., it increases by
> one even if the update touches multiple references).
>
> Let's store reflog entries under keys `(refname, update_index)`, and
> store the timestamp of the entry *within* the record rather than as
> part of the key. The tuple `(refname, update_index)` has to be encoded
> somehow that ensures the desired order; see below. This encoding
> ensures that the order of reference updates is well-defined regardless
> of clock skew, and that one can use the reflog to determine which
> references were updated together and what the complete state of
> references was after any update (assuming that the user retains all
> reflogs).
>
> Let's store in the header of each reftable file the `min_update_index`
> and `max_update_index` that are covered by the file. Do this such that
> the indexes chain together properly for the reftables in the stack;
> i.e. `reftable[n].min_update_index == reftable[n-1].max_update_index +
> 1`. This has two purposes:
> * The current `update_index` can be read quickly from the header of
> the top reftable in the stack. When you want to create a new reference
> update, you can set its `update_index` to that value plus one and know
> that it is unique.
> * If the table of contents should somehow get lost, the order of the
> reftable files can be reconstructed from their `update_index` ranges.
>
> If a range of reftable files is compacted together, the new file gets
> its `min_update_index` from the oldest file being compacted and its
> `max_update_index` from the newest file. If reflogs are expired, that
> doesn't affect the `min_update_index` or `max_update_index` for the
> reftables even if some of the `update_index`es in that range no longer
> appear in the file.
>
> How to encode the `(refname, update_index)` tuple so that it sorts the
> way we want, namely with entries grouped by refname and backwards in
> time? The simplest way would be `refname + \0 + uint32(0xffffffff -
> update_index)`, and that should prefix-compress relatively well. One
> could squeeze that down a bit by using a custom sort function, but
> that would complicate the code, and anyway, zlib hides all sins,
> doesn't it?

I'm with you this far, and like the {min,max}_update_index in the
header. I'm concerned about update_index in 32 bits. At some point you
need to reset the counter, or the repository is broken. 4b updates is
enough for anyone? I'd feel better about this being a 64 bit field.


> I'm also still unhappy that completely packing references down to one
> reftable will require all reflogs to be fully rewritten, even though
> the reflogs will mostly be append-only. And I'm worried that your
> comforting numbers about how well the reflogs compress won't apply to
> GitHub, because we store lots of information in our reflog messages. I
> think that some small tweaks would improve the situation.
>
> Suppose one could create `reflog-only` reftables. Then a `pack-refs`
> implementation could choose to create one or more `reflog-only`
> reftables at the bottom of the stack for accumulating reflogs (such
> files would rarely have to be compacted), and on top of that a big
> reftable holding most of the reference values, and on top of that
> multiple small reftables containing both reference values and reflogs
> (for recent updates). Perhaps one would even record in the table of
> contents which files in the stack contain what kinds of data, to avoid
> (for example) having to open reflog-only files at all if you are only
> interested in reference values.
>
> This would require a small amendment to my `update_index` suggestion
> above, namely that reflog-only and ref-only reftables might have
> overlapping `update_index` ranges, but the end result should be that
> the files together cover the whole range of `update_index`es for refs
> and also for reflogs.

Ack, I see the value in your suggestion for a reflog-only table.

I'll rework the document to incorporate your feedback above, and post
another iteration to the list.
