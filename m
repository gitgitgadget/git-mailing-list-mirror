Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3977C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C7E63272
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 12:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhHPMnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 08:43:16 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51539 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233824AbhHPMmn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Aug 2021 08:42:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C91C85C00FD
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 08:42:05 -0400 (EDT)
Received: from imap38 ([10.202.2.88])
  by compute1.internal (MEProxy); Mon, 16 Aug 2021 08:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm3; bh=esXKDN6/zzdXkzhN3Q9bc7flBwrMLHmTMi052A/u8fM=; b=BQ7FIQd5
        PhVWNF0bPGVnYH1Cp04vKUPXJ+OlmmnZ17vKiljxuKAe+8zo58gX8+I5TUrFamGf
        iOAc7N7f0rqsTkh57ObDH1juCLk4OsLdOQVc4sR9cR5lPKKGawLYe+oeJnSV5fVG
        lvKI6BX2yrdCqMX9XLE+u0Ja7DZVBv6+IEfpnkaMlufz8ngwrgvkGo3hnyHDiNpM
        Im1s4WEkLeD+ZNU0210/+2ha2futd4FePl3uON82dVfELKsADlM3gVham61f1DDy
        GxUjCBqYj8Aip8h2rzqjcg7bPBVzXMADnizdg2yyEGUEdAvaWxtXpXljzAcMoFCq
        YEQWPCicJNo9rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=esXKDN6/zzdXkzhN3Q9bc7flBwrML
        HmTMi052A/u8fM=; b=ZZhoLO4fmrCH8iXvLl69XMJEM0ZZH3R6UMk41wJMymCaK
        Tu/FTBhRUq8tFmuBg4gnYPr/blWtRF+1RfxGX5TgIlkT32ST/aHlCfgvYuq069st
        cQfQD4IynO0do+Q94a41X+nxkMA3d5+sSIVnSWOMzZQr95f6IjXWJe+PH7Bs9zca
        jOFqNGcTZrRUSpLouItT620X1KCt5GSfi3/xhTO5H6w2Lih6ReVk2KcPZLrPa1ht
        sVe9UeMbmS7SiLVHlWyVngXXQ5V8j9PdV7bn9iekURkk5T867PJ0tYFyRf8/h6NB
        6IiulW6+QrhlXs+nE1aTS/pzW3xQslDUIUiLuivxQ==
X-ME-Sender: <xms:HV0aYXEwnD2q1xaSp1Z5QwKD4YaY36b0dTcg2T8Lqe_ZLIVJGtgY1A>
    <xme:HV0aYUVCKH1tpz16wcD2LeHvx5YK3mIaioAbpiBWJ55bB9Hjgok8v0-2yPZE0rgL5
    b7xoE44XG965ycCGxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledugdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenuc
    fjughrpefofgggkfffhffvufgtsehttdertderredtnecuhfhrohhmpedfifhrvghgucfj
    uhhrrhgvlhhlfdcuoehgrhgvgheshhhurhhrvghllhdrnhgvtheqnecuggftrfgrthhtvg
    hrnhepveeiveeivdduteefueejffeludefteejkefhtddtkeevieegffdvudelffeuvdeh
    necuffhomhgrihhnpehgihhtrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:HV0aYZKNqloBHS-VC-TRDvURy8h54sw_vaHtvmsdCcKDTVsioWZ-Ng>
    <xmx:HV0aYVHfSjm43eIb5EM_swwqiHf3XeodG1oEy4eYex5ENzlkyckLQA>
    <xmx:HV0aYdWfcwI7wJVqG_Y1hnw6VFiQdGceYqcl_Sj5s9RGkWfOdw_ADg>
    <xmx:HV0aYVjY3a6rnewQZziKdaczz7-eZRg5lPUzOYZJTllhLlCJBysi2A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 61F8ECA0061; Mon, 16 Aug 2021 08:42:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <4e0eff48-4a3e-4f0e-9ed2-d01ec38442a5@www.fastmail.com>
Date:   Mon, 16 Aug 2021 14:40:27 +0200
From:   "Greg Hurrell" <greg@hurrell.net>
To:     git@vger.kernel.org
Subject: Bad behavior in xhistogram.c in the face of hash collisions?
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I think I may have found a bug in the histogram diff algorithm that
manifests when there is a hash collision.  This behavior seems to exist
in the JGit implimentation (https://git.io/J0Ud8) too, and was brought
across with the port-to-C in 8c912eea94a2.

In the following, any line numbers refer to xdiff/xhistogram.c as it
exists in 5d213e46bb (2.33-rc2), as seen here: https://git.io/J0UHS

There are two phases in the algorithm which look up slots in the
histogram hash table based on the value of a hash function:

1. During the backwards scan in `scanA`, each line in the old sequence
   is considered and hashes are used to assign items to histogram
   buckets.
2. During the forwards scan of the new sequence we call `try_lcs` with
   each line in turn and look up the corresponding histogram bucket.

Now, the original JGit code comments suggests the intended behavior and
purpose of the buckets is as follows:

> To prevent the algorithm from having an O(N^2) running time, an upper
> limit on the number of unique elements in a histogram bucket is
> configured by `setMaxChainLength(int)`. If sequence A has more than
> this many elements that hash into the same hash bucket, the algorithm
> passes the region to `setFallbackAlgorithm(DiffAlgorithm)`. If no
> fallback algorithm is configured, the region is emitted as a replace
> edit.

But when I look at both the JGit and Git implementations, this is what I
actually see:

During the backwards scan we select a hash table bucket (at line 115)
based on the value of the item:

    tbl_idx = TABLE_HASH(index, 1, ptr);

If there is a chain in the corresponding bucket and the values match
(ie. hash to the same hash code and are equal) we prepend to the front
of the chain (lines 121-133).

In the event of a hash collision, we proceed to the next item in the
chain (line 135):

    rec = rec->next;

and check for a match. By definition, this check is always going
to fail, because only identical elements ever get prepended onto
chains. So this chain traversal serves only to measure the count of
items in the chain, something that we could have done in constant time
by looking up `rec->cnt` anyway.

After reaching the end of the chain and exiting the loop, provided we
didn't exceed the maximum chain length, we now create a new chain,
overwriting the original occupant of the slot:

    *rec_chain = rec;

So, during `scanA` we'll effectively destroy chains whenever there is a
hash collision, which doesn't seem to be the intent of the original
algorithm.

In the second half of the algorithm, `try_lcs`, we have the inverse
problem. On line 165 we again look up the hash table slot:

    struct record *rec = index->records[TABLE_HASH(index, 2, b_ptr)];

On line 169 we start a loop that will consider each record in the chain:

    for (; rec; rec = rec->next) {

Due to the construction of `scanA`, we know that every item in this
chain must be identical, which in turn means that in the event of a hash
collision we are doomed to traverse the entire chain without finding a
match:

    if (!CMP(index, 1, as, 2, b_ptr))
           continue;

That is at best unnecessary work, but also means that whenever we have
collisions we will have a set of "orphaned" records that aren't actually
reachable from any chain in a hash table slot that we will look up, and
that doesn't seem to match the intended behavior of the algorithm, if I
understand it correctly.

Is this a big deal in practice? I suspect the reason we haven't noticed
it is that:

1.  Hash collisions are sufficiently rare (although, via the birthday
    paradox, not _that_ rare, especially because we use the next power
    of two to determine the number of slots in our hash table; ie. a
    200-line file would have a 256-slot hash-table associated with it);
    and:
2.  Their consequences tend not to produce obviously broken diffs,
    because the algorithm is just used to select split points around
    which to apply itself recursively; we still produce a valid diff
    even if we don't select the "optimal" split point.

Anyway, I just wanted to gut-check this analysis with the list to see
whether it sounds right or not. The bug is pretty benign as far as I can
tell, but still probably worth fixing, if it is a bug.

Cheers,
Greg
