Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05632047F
	for <e@80x24.org>; Tue,  1 Aug 2017 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdHAX17 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 19:27:59 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:33707 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdHAX16 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 19:27:58 -0400
Received: by mail-ua0-f171.google.com with SMTP id 80so13780041uas.0
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X/6n+SscaoOixTOJxJ+eJ+LradG0zAoh03zo3YFrdY0=;
        b=Zc3CKeAXTU+juB6Z77Ux/X0GpLxrOEewLsegnKvpTi+6OikBtAYbAqbs/jn9JTc0TX
         NNRmFm33vbeNcaLFIToPAgOVfDgn+7pbitNQ78wWiYVpYEbon/+8HCNMxLQ4lCyjvBQT
         Xags9dWiK6PiEKvMMjetcR4168SmG8B7ajZsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X/6n+SscaoOixTOJxJ+eJ+LradG0zAoh03zo3YFrdY0=;
        b=iNyqrMOAGZ1W+QnTfOHcb/AIi0PUSSxw0e7FxwUbmlbQdO66XTPY7ezdzJeVW94bNz
         nIpb5PKFlMqPaKW4MelGm7tX2321APsEEJsVBtrky4tg0gCRyKac6C8sfeMt4be/47Ep
         nnQ815TL3CexL3jYT2GMSBlytAjt1mfO3kPMo+LTi0xZKVOxrHOhfvvirNqkEJTYT1ht
         lgBDajX2IkFVP8tAbQKVxVuM+9x+9boJZ3kaubySbdRrNYYFJyLkGViKiNc50Nyr9qcR
         eOLt4KpDwXUrxbhXFQeuDKSBd2gmoPdzLS/sEf12oASDz732nwx922ErHEyRqN4i4hhk
         jxIA==
X-Gm-Message-State: AIVw111UbAwDIM8RSb07g1t0nbyDixRc4uXNB9CiZj1KKFwasVIBdvXj
        YCiZcywfSU98n8PyTmMyx8xi9QQEr4zk
X-Received: by 10.176.70.96 with SMTP id z32mr14774478uab.37.1501630077226;
 Tue, 01 Aug 2017 16:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Tue, 1 Aug 2017 16:27:36 -0700 (PDT)
In-Reply-To: <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 1 Aug 2017 16:27:36 -0700
Message-ID: <CAJo=hJvFRJ7honjenB6sUofK14xiUXGwJ1DQHZyTauVKA5v5vw@mail.gmail.com>
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

On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>> 4th iteration of the reftable storage format.
>> [...]
>
> Before we commit to Shawn's reftable proposal, I wanted to explore
> what a contrasting design that is not block based would look like.

I forgot to look at a 1k chunk size, as you suggested that might also
be suitable. Here is the more complete experiment table:

       | size   | seek_cold | seek_hot  |
mh  1k | 36.6 M | 20.6 usec | 10.7 usec |
mh  4k | 28.3 M | 24.5 usec | 14.5 usec |
sp  4k | 29.2 M | 63.0 usec |  5.8 usec |
sp 64k | 27.7 M | 35.6 usec | 23.3 usec |


A couple of other notes about your contrasting design:

>     elif chunk_type == INDEX {
>         chunk_length : varint

Using a varint for the chunk length made for a complicated reader.
JGit doesn't have the luxury of mmap to access the file, so we have to
allocate a byte[] and read data from a file descriptor to do anything
fancy like decoding a varint. For my experiment I wound up just
hardcoding the IO to read 1k or 4k from whatever address.

A "real" implementation would likely prefer to read a fixed width
field here such that chunks have a 3 byte header (1 byte chunk_type, 2
byte chunk_length), and then issue a second read to acquire the rest
of the chunk. Given that encoding a chunk length of 1024 or 4096 both
requires 2 bytes of varint, its always going to be 2 bytes in your
design anyway. With the way chunks are scanned, I don't think you want
chunks as large as 16k, which would have caused the varint to go to 3
bytes (but still fits in a fixed 2-byte chunk_length).

My reftable proposal should still do well in a mmap region. Most of
the cold start penalty for reftable is JGit copying the ref index from
the file descriptor to the memory block where we can parse the format.
That is why the cold_seek time declines for a larger block size, the
index is smaller.


>         first_child : {
>             refname : varstr
>             index_payload
>         }
>         other_children : {
>             # Length of prefix being carried over from the previous
>             # record:
>             prefix_len : varint
>             suffix : varstr
>             index_payload

Having no prefix_len on first_child made for a slightly funkier
parser. It does save you a byte, but the parser has to know if its
looking at the first child, or an other_children to know if it should
expect the prefix_len. Its a simple condition, but it kind of grated
on me when I wrote that particular section of the experiment. For the
majority of records the parser considers, the prefix_len is always
present.

That is why I proposed the restart_offsets point to the prefix_len,
and prefix_len = 0 at restart points. It slightly simplified the
parser.


>     elif chunk_type == OBJS_INDEX {
>         chunk_length : varint
>
>         # The offset, relative to the start of this chunk, of the
>         # chunk containing the next level of the obj index, for each
>         # of the possible "next" bytes in the SHA-1, or zero if there
>         # are no references with the given next byte.
>         child_offset : varint * 256

This is space saving and cute, but kind of annoying. If it was fixed
width 32 bit you can address up to 4G away from this chunk's address,
and you can directly jump to the byte of interest. By being varints
you do save a little space, as most files will probably only need 3
byte varints, and the 0s do collapse down to 1 byte, but you have to
linearly walk the list to find any specific byte.


> ref_payload = {
>     value_type : enum NO_VALUE
>                     | DELETED
>                     | VALUE | VALUE_PEELED
>                     | SYMREF | SYMREF_PEELED
>                     | SPECIAL
>     log_type : enum NO_REFLOG | REFLOG | REFLOG_COMPRESSED
>     symref_target : bool

FWIW I didn't implement log_type or symref_target in my experiment, so
the size per ref was maybe a few bytes smaller than what you outlined
here.


>     # This field is used to keep backwards links from references to
>     # any symrefs that point at them, to make it tractable to update
>     # the reflog of the symref if the reference is changed directly:
>     if symref_target {
>         referer : varstr
>         varint(0)
>     }

I wonder how desirable this feature is. Most updates are done through
HEAD, which is a symref and can therefore update both HEAD and the
target's reflogs in the same operation. It seems to me its rare to
issue an update directly on the ref that HEAD points at. Its even
rarer to have a non-HEAD symbolic reference whose reflog you expect to
track something else.

Is this for refs/remotes/origin/HEAD to be a symref and have its
reflog mirror the fetch operations that touched the underlying ref?
