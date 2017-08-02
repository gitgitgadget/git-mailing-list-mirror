Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEAA2047F
	for <e@80x24.org>; Wed,  2 Aug 2017 02:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbdHBCjA (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 22:39:00 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33926 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdHBCi7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 22:38:59 -0400
Received: by mail-vk0-f41.google.com with SMTP id n125so13134367vke.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o9oIvPRx9mlCsvYn5qyhmaWvOnrfxwkcct2kQwEAYaY=;
        b=Zv+0IBwQzQOuNqEEQeSrFD/XFZVXm7uN2HA75I8oD71JCxd3E4a4jtfLI29L9wATEp
         LJWjDRIqCfCVuIOIm5xbmenid1TFbF28XH6xw1qnzGwaZQxT+rvmKBrLTq5a9q7daa/S
         OX12hBoG4AzLq1Be+19S3jNlzZmu3xeHuMVqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o9oIvPRx9mlCsvYn5qyhmaWvOnrfxwkcct2kQwEAYaY=;
        b=ghLV9n8GOtDGh0xxlAiYKmf+ZhVd2WjqRYvtgakAmStKRfBp57BVkxeQffk2cTyLTb
         xhGqsdlJCZYrF+rwxBqhMt5K9oG5BpsD60GZkU2Txsp74lYsw651zw3JfqbKldj6Otx8
         yyjlkrjfIMcYQ3zJslO4et1bDKCvn+HVUkWKknm6eTFHYseTGFa1kZye5o32HqSQe3Ps
         NZnqSCl7fLW/ProkLa9iyCUESgFG4Gh5TRmZM3wl0slYdSefKXdfVo8DBO5cLgQrzlbx
         HYUSDadBtCer/NhqBaU4L4dBcy6wD/hmJywdEKqdh4jxy81J0FB7WmhqEyi8vO4O4VZ1
         +T5g==
X-Gm-Message-State: AIVw113lkYVM0IrDgsalJzxB2k6z7CmgufcEu4qUptj0bv7ptwsRIFPc
        8yATy87TPCcD4TXzgwtTx7tdP2E3h/9K
X-Received: by 10.31.195.3 with SMTP id t3mr14461227vkf.98.1501641538245; Tue,
 01 Aug 2017 19:38:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 1 Aug 2017 19:38:37 -0700 (PDT)
In-Reply-To: <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
 <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com> <CAMy9T_HUoD4--s1gNTUjnCgdiAqfYbX-GSqygDwNO-JRwdh4NQ@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 1 Aug 2017 19:38:37 -0700
Message-ID: <CAJo=hJv=zJvbzfAZwspxECXrnBJR4XfJbGZegsNUCx=6uheO2Q@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 6:51 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Tue, Aug 1, 2017 at 4:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>>> 4th iteration of the reftable storage format.
>>>> [...]
>>>
>>> Before we commit to Shawn's reftable proposal, I wanted to explore
>>> what a contrasting design that is not block based would look like.
>>
>> I forgot to look at a 1k chunk size, as you suggested that might also
>> be suitable. Here is the more complete experiment table:
>>
>>        | size   | seek_cold | seek_hot  |
>> mh  1k | 29.4 M | 20.6 usec | 10.7 usec |   <== Row fixed
>> mh  4k | 28.3 M | 24.5 usec | 14.5 usec |
>> sp  4k | 29.2 M | 63.0 usec |  5.8 usec |
>> sp 64k | 27.7 M | 35.6 usec | 23.3 usec |
>
> At least in this case, the 1k block size seems like a good tradeoff.
> Did 1k vs 4k change the number of index levels required?

Yes. 1k needed 4 levels of index; 4k needed 2 levels.
More chunks, with smaller index chunks, forces a deeper index depth.


>> A couple of other notes about your contrasting design:
>>
>>>     elif chunk_type == INDEX {
>>>         chunk_length : varint
>>
>> Using a varint for the chunk length made for a complicated reader.
>> JGit doesn't have the luxury of mmap to access the file, so we have to
>> allocate a byte[] and read data from a file descriptor to do anything
>> fancy like decoding a varint. For my experiment I wound up just
>> hardcoding the IO to read 1k or 4k from whatever address.
>>
>> A "real" implementation would likely prefer to read a fixed width
>> field here such that chunks have a 3 byte header (1 byte chunk_type, 2
>> byte chunk_length), and then issue a second read to acquire the rest
>> of the chunk. Given that encoding a chunk length of 1024 or 4096 both
>> requires 2 bytes of varint, its always going to be 2 bytes in your
>> design anyway. With the way chunks are scanned, I don't think you want
>> chunks as large as 16k, which would have caused the varint to go to 3
>> bytes (but still fits in a fixed 2-byte chunk_length).
>
> That's a good point for INDEX and OBJS_INDEX blocks. Though for REFS
> blocks that include reflogs, the block size has to be large enough to
> hold the whole reflog for a reference, which can be arbitrarily large.
> (Maybe this is a weakness of the design?)

Gah. I missed that part about the whole reflog needing to fit in the
same chunk when I wrote the quoted text above. That is a pretty big
downside for very busy refs.

Even when you isolate logs into their own file, the reflog for a busy
ref could be huge. A naive reader would want to "page in" the entire
chunk_length before parsing. That isn't tenable if the reflog for a
busy ref was say 50 MiB. It complicates the reader more. My reftable
proposal deals with this by breaking the log up with its special key
structure.

Requiring the entire reflog of a single ref to fit into a single chunk
does seem to have its downsides.


> OBJS blocks can also be
> unbounded in size if very many references point at the same object,
> thought that is perhaps only a theoretical problem.

Gah, I missed that in reftable. The block id pointer list could cause
a single object id to exceed what fits in a block, and that will cause
the writer to fail unless its caller sets the block size larger. I
basically assumed this overflow condition is very unlikely, as its not
common to have a huge number of refs pointing to the same object.


>>>     elif chunk_type == OBJS_INDEX {
>>>         chunk_length : varint
>>>
>>>         # The offset, relative to the start of this chunk, of the
>>>         # chunk containing the next level of the obj index, for each
>>>         # of the possible "next" bytes in the SHA-1, or zero if there
>>>         # are no references with the given next byte.
>>>         child_offset : varint * 256
>>
>> This is space saving and cute, but kind of annoying. If it was fixed
>> width 32 bit you can address up to 4G away from this chunk's address,
>> and you can directly jump to the byte of interest. By being varints
>> you do save a little space, as most files will probably only need 3
>> byte varints, and the 0s do collapse down to 1 byte, but you have to
>> linearly walk the list to find any specific byte.
>
> The reason I used varint here was mostly because I expect the lowest
> level of the OBJS_INDEX to be placed close to the OBJS chunks that it
> refers to; hopefully within a 2-byte varint. Let me consider more
> carefully whether that is realistic...

Ah, ok. So you were expecting the writer to interleave OBJS and
OBJS_INDEX chunks, with the OBJS_INDEX appearing every ~256 OBJS
chunks. And then storing the next level of OBJS_INDEX consecutively.

I think your math is still wrong about the lowest level OBJS_INDEX
needing only 2-byte varint for child_offset. Given a 1k chunk size,
you still have to address backwards about 256k, which requires a
3-byte varint.


Given the uniform distribution of SHA-1, I think you still wind up
with most of the OBJS_INDEX populated. E.g. in my 866k ref/865k obj
example the unique object abbreviation is 6 raw bytes. The OBJS chunk
storing 2 bytes means we have 4 levels of OBJS_INDEX to cover the
first 4 bytes. That leaves ~844 obj_records in each OBJS chunk. If
those are 7 bytes/obj_record, the OBJS chunk is ~5.7 KiB.

Forcing the OBJS chunk to stay under say 4 KiB will absolutely cause a
lot more holes in the OBJS_INDEX levels.


> Peff and I discussed off-list whether the lookup-by-SHA-1 feature is
> so important in the first place. Currently, all references must be
> scanned for the advertisement anyway,

Not really. You can hide refs and allow-tip-sha1 so clients can fetch
a ref even if it wasn't in the advertisement. We really want to use
that wire protocol capability with Gerrit Code Review to hide the
refs/changes/ namespace from the advertisement, but allow clients to
fetch any of those refs if they send its current SHA-1 in a want line
anyway.

So a server could scan only the refs/{heads,tags}/ prefixes for the
advertisement, and then leverage the lookup-by-SHA1 to verify other
SHA-1s sent by the client.

> so avoiding a second scan to vet
> SHA-1s received from the client is at best going to reduce the effort
> by a constant factor. Do you have numbers showing that this
> optimization is worth it?

No, but I don't think I need to do much to prove it. My 866k ref
example advertisement right now is >62 MiB. If we do what I'm
suggesting in the paragraphs above, the advertisement is ~51 KiB.

> OTOH a mythical protocol v2 might reduce the need to scan the
> references for advertisement, so maybe this optimization will be more
> helpful in the future?

Yes, I'm hopeful we can get a v2 protocol built on the work Jonathan
Tan is doing, and switch the advertisement around to "client speaks
first", so that we can be smarter on the server about which refs are
read and sent. That is a long way off, lets say 3-5 years before its
really common in clients.


>>> ref_payload = {
>>>     value_type : enum NO_VALUE
>>>                     | DELETED
>>>                     | VALUE | VALUE_PEELED
>>>                     | SYMREF | SYMREF_PEELED
>>>                     | SPECIAL
>>>     log_type : enum NO_REFLOG | REFLOG | REFLOG_COMPRESSED
>>>     symref_target : bool
>>
>> FWIW I didn't implement log_type or symref_target in my experiment, so
>> the size per ref was maybe a few bytes smaller than what you outlined
>> here.
>
> But value_type, log_type, and symref_target should all fit within a
> single byte, no?

Yes. So my experiment was maybe ~866 KiB off in total file size. :)


>>>     # This field is used to keep backwards links from references to
>>>     # any symrefs that point at them, to make it tractable to update
>>>     # the reflog of the symref if the reference is changed directly:
>>>     if symref_target {
>>>         referer : varstr
>>>         varint(0)
>>>     }
>>
>> I wonder how desirable this feature is. Most updates are done through
>> HEAD, which is a symref and can therefore update both HEAD and the
>> target's reflogs in the same operation. It seems to me its rare to
>> issue an update directly on the ref that HEAD points at. Its even
>> rarer to have a non-HEAD symbolic reference whose reflog you expect to
>> track something else.
>>
>> Is this for refs/remotes/origin/HEAD to be a symref and have its
>> reflog mirror the fetch operations that touched the underlying ref?
>
> What I was thinking is that we don't update symrefs' reflogs correctly
> if the pointed-to reference is updated (except for HEAD) and it would
> be nice to fix that problem. Your case of `refs/remotes/origin/HEAD`
> is an example. Or on GitHub's servers, if we wanted to store all of
> the forks of a repo in a single repository, we might want to use a
> namespace for each fork, like `refs/forks/NNNN/*`, and store the
> fork's default branch in `refs/forks/NNNN/HEAD`. The current refs code
> wouldn't know to update such a symref's reflog (though of course it
> could be special-cased in like HEAD is now).

Servers today don't update HEAD reflog when a branch is pushed. I
think trying to record that is overkill, you have the reflog data in
the ref itself that the client sent the command to modify.

> That's what I was thinking. But I've yet to hear anybody complain
> about missing reflogs for symrefs if the underlying reference is
> updated directly, so maybe we should just leave that "problem"
> unsolved. It is certainly simpler and less brittle not to have to keep
> backreferences like these in sync with the forward references.

Yup, that is my take on it, and why I didn't try to put this into
reftable drafts, even though it was discussed between us on the list
in earlier messages.
