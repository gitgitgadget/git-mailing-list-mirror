From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 5.5/22] Add documentation for the index api
Date: Tue, 09 Jul 2013 22:10:07 +0200
Message-ID: <87wqozpk9s.fsf@gmail.com>
References: <1373184720-29767-1-git-send-email-t.gummerer@gmail.com> <1373184720-29767-6-git-send-email-t.gummerer@gmail.com> <CACsJy8C0F+v3g+gPon6Y8+z7ObN1Jv8Ln==RNrVsRp7aya74hw@mail.gmail.com> <87pputqowr.fsf@gmail.com> <CACsJy8CtOWjpxKuNhQXYjPAv8MU0U6yTBEuQeqm0kxqVne6NjQ@mail.gmail.com> <871u78rcw0.fsf@gmail.com> <CACsJy8A9+1O_em=FtV_TUKags4FrSggV76dd1h6gsJ+JHfjZKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:10:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UweF5-0004vI-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3GIUKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:10:16 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:53585 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3GIUKP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 16:10:15 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so5933089pab.17
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 13:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=7ERgZuGiJgy/qjBfXfFDF6aWUpkmV4sSZ4zH0ZaQa18=;
        b=qY++gOpwRpN5rXNpKjNg0NAcVpe3RlC7/T1e4DfLSMgOf6CrIn4wnKM1Mbrri9DXt5
         VdTOh9v3FP6XdwiRotsn++SDB4RIdUdyrhf1SIzjvjYddtlTluJEkKG7wN8V1GsG8C0q
         bC1aMLILfnx7LPYs+3NkshSnam8vG/M875t0ud1A8jM5rAVjT25AUEFXyCmTqSPpsp+9
         rxGCoCfPljDhYwhxjPaabx7dWj41BUIR3d6wxJofQy0bDglHqdd6ka1PbuE64RODQfDy
         yi7Z/wja0cZGaBYV3NNbR8c9yaxhgw8FXYfbykf4wEge4HJ0v+DevrV+vpDPMn3VmAu3
         Sprw==
X-Received: by 10.66.246.133 with SMTP id xw5mr26813440pac.114.1373400614483;
        Tue, 09 Jul 2013 13:10:14 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:9227:e4ff:feea:9196])
        by mx.google.com with ESMTPSA id p2sm31825848pag.22.2013.07.09.13.10.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 13:10:14 -0700 (PDT)
In-Reply-To: <CACsJy8A9+1O_em=FtV_TUKags4FrSggV76dd1h6gsJ+JHfjZKw@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229997>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jul 9, 2013 at 3:54 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> As promised, a draft for a documentation for the index api as it is in
>> this series.
>
> First of all, it may be a good idea to acknowledge
> index_state->cache[] as part of the API for now. Not hiding it
> simplifies a few things (no need for new next_ce field, no worries
> about rewinding in unpack-trees..). Supporting partial loading (and
> maybe partial update in some cases) with this API and
> index_state->cache[] part of the API are good enough for me. We can do
> another tree-based API or something update later when it's formed (I
> looked at your index-v5api branch but I don't think a tree-based api
> was there, my concern is how much extra head pre-v5 has to pay to use
> tree-based api).

Yes, I think you're right, that simplifies everything a lot, while we
still can have partial loading.  Hiding index_state->cache[] was mainly
thought for future changes for the in-memory format, but I think that
will not be happening for a while.

>> +`read_index_filtered(opts)`::
>> +       This method behaves differently for index-v2 and index-v5.
>> +
>> +       For index-v2 it simply reads the whole index as read_index()
>> +       does, so we are sure we don't have to reload anything if the
>> +       user wants a different filter.  It also sets the filter_opts
>> +       in the index_state, which is used to limit the results when
>> +       iterating over the index with for_each_index_entry().
>> +
>> +       The whole index is read to avoid the need to eventually
>> +       re-read the index later, because the performance is no
>> +       different when reading it partially.
>> +
>> +       For index-v5 it creates an adjusted_pathspec to filter the
>> +       reading.  First all the directory entries are read and then
>> +       the cache_entries in the directories that match the adjusted
>> +       pathspec are read.  The filter_opts in the index_state are set
>> +       to filter out the rest of the cache_entries that are matched
>> +       by the adjusted pathspec but not by the pathspec given.  The
>> +       rest of the index entries are filtered out when iterating over
>> +       the cache with for_each_index_entries.
>
> You can state in the API that the input pathspec is used as a hint to
> load only a portion of the index. read_index_filtered may load _more_
> than necessary. It's the caller's responsibility to verify again which
> is matched and which is not. That's how read_directory is done. I
> think it gives you more liberty in loading strategy. It's already true
> for v2 because full index is loaded regardless of the given pathspec.
> In the end, we have a linear list (from public view) of cache entries,
> accessible via index_state->cache[].

Yes, and it's also partly true for index-v5, as the full content of a
directory is loaded even if only some files it it match the pathspec
that's given.

> If you happen to know that certain entries match the given pathspec,
> you could help the caller avoid match_pathspec'ing again by set a bit
> in ce_flags.

I currently don't know which entries do match the pathspec from just
reading the index file, additional calls would be needed.  I don't think
that would be worth the overhead.

> To know which entry exists in the index and which is
> new, use another flag. Most reader code won't change if we do it this
> way, all match_pathspec() remain where they are.

Hrm you mean to know which cache entries are added (or changed) in the
in-memory index and will have to be written later?  I'm not sure I
understand correctly what you mean here.

>> +`for_each_index_entry(fn, cb_data)`::
>> +       Iterates over all cache_entries in the index filtered by
>> +       filter_opts in the index_stat.  For each cache entry fn is
>> +       executed with cb_data as callback data.  From within the loop
>> +       do `return 0` to continue, or `return 1` to break the loop.
>
> Because we don't attempt to hide index_state->cache[], this one may be
> for convenience, the user is not required to convert to it. Actually I
> think this may be slower because of the cost of calling function
> pointer.

Yes right, I think you're right.  In fact I just tested it, and it's
slightly slower.

I still think it would make sense to keep it around, for the callers
that want the cache filtered exactly by the filter_opts, for convenience
as you said.

>> +`next_index_entry(ce)`::
>> +       Returns the cache_entry that follows after ce
>
> next_ce field and this method may be gone too, just access index_state->cache[]

Yes, this makes no sense when we're not hiding index_state->cache[].
The same goes for the get_index_entry_by_name function, which is
essentially the same as using index_name_pos and then getting the cache
entry from index_state->cache[].

>> +`index_change_filter_opts(opts)`::
>> +       This function again has a slightly different functionality for
>> +       index-v2 and index-v5.
>> +
>> +       For index-v2 it simply changes the filter_opts, so
>> +       for_each_index_entry uses the changed index_opts, to iterate
>> +       over a different set of cache entries.
>> +
>> +       For index-v5 it refreshes the index if the filter_opts have
>> +       changed and sets the new filter_opts in the index state, again
>> +       to iterate over a different set of cache entries as with
>> +       index-v2.
>> +
>> +       This has some optimization potential, in the case that the
>> +       opts get stricter (less of the index should be read) it
>> +       doesn't have to reload anything, but currently does.
>
> The only use case I see so far is converting a partial index_state
> back to a full one. Apart from doing so in order to write the new
> index, I think some operation (like rename tracking in diff or
> unpack-trees) may expect full index. I think we should support that. I
> doubt we need to change pathspec to something different than the one
> we used to load the index. When a user passes a pathspec to a command,
> the user expects the command to operate on that set only, not outside.

One application was in ls-files, where we strip the trailing slash from
the pathspecs for submodules.  But when we let the caller filter the
rest out it's not needed anymore.  We load all entries without the
trailing slash anyway.

> If you take the input pathspec at loading just as a hint, you could
> load all related directory blocks and all files in those blocks, so
> that expanding to full index is simply adding more files from missing
> directory blocks (and their files). An advantage of not strictly
> follow the input pathspec.

I actually already do that with the adjusted pathspec.  Even with
index-v5 currently there are some more entries loaded than actually
matched by the pathspecs.  Expanding to the full index still takes some
work, but should be possible.

> Some thoughts about the writing api.
>
> In think we should avoid automatically converting partial index into a
> full one before writing. Push that back to the caller and die() when
> asked to update partial index. They know at what point the index may
> be updated and even what part of it may be updated. I think all
> commands fall into two categories, tree-wide updates (merge,
> checkout...) and limited by the user-given pathspec. "what part to be
> updated" is not so hard to determine.

Hrm this is only true if index entries are added or removed, not if they
are only changed.  If they are only changed we can write a partially
read index once we have partial writing.  For now it would make sense to
just die() though, until we have that in place.

> If the caller promises not to update or read outside certain pathspec
> (part of API), we don't really need to load full index until
> write_index is called. At that point I think we also know what
> directory blocks are completely untouched by the caller (by promise)
> and could copy them over from the old index byte-by-byte (or something
> close, some offsets may be recalculated). That may keep tree compiling
> cost proportional to the number of changed entries, not the number of
> entries in index.

Yes that would make sense.  I think that should go in a follow-up series
though as it would be quite some work.

> There is another partial write case that's not covered this round (or
> was it discussed and discarded?): refreshing the index. This operation
> could be treated as a standalone, special one: refresh and update the
> index file directly without waiting until write_index is called. There
> are some commands that follow this scheme by doing
> update_index_if_able() after refresh_index(). Those will be cheaper
> with v5 because we don't need write a full new index.

I don't think it was discussed yet.  Partial reading will need a change
to the lock-file structure though, so I think it's a little more
complicated.

Thanks for your comments, I'll try to address them and send a new series
in a couple of days.
