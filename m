Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A95C1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 20:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbdCBUEA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 15:04:00 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:33161 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdCBUD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 15:03:56 -0500
Received: by mail-it0-f46.google.com with SMTP id 68so4074743itg.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 12:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WSCId2277P3PfkhoRh8R7T9xOR9IEKP0Hs14AQQ0/w4=;
        b=nTjD0N7FVFqNA0ssvm/oPz64ZjoseCjBx+qgRVvcM6pMzkmMhmpo5F+g39O/uZdIzQ
         ycLKQBvRUIvSytNd6UgVPqjBnZInMdSsoS1k20cDNLKgJnvsNs+GMtd8mDlb8JmBpQLx
         uZDWCkLC+Rj9s3ri2inAI1pNqDrjJsFz39aaWFTGScB45NnyYJAnsfZBjWlsWDcG1L8p
         ntIfnT7TWu4eHik7opcL4cTidB3QgLTYzkU0Cmg5+aW6hJ95GHlMEMEng8xN2rpg94e2
         uq6XYBid6D4Zvx37JIQ03SVaXAePTmYR1bk+4lrG9g/4xtYySCL9CRs5qrJK2Cyh98u6
         v8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WSCId2277P3PfkhoRh8R7T9xOR9IEKP0Hs14AQQ0/w4=;
        b=LEIp9gZsGBjZ/ntHBByMja1oHWSk0miPirFAuh+2l6CRoNLN8j2rJ23xxddSzuObe5
         2lAUgLOlhdZVnoi0Voxwg4R5KA0/osXryCC8h+Maa8oT9TqqRCrQzf1GhLbOhS7kuU5p
         dwIWJ04TR61N2JAUNS8dqPwlcKrtpDeoT9kVsCzOI/AGqmY7yIgETXTuW3DX4o2Jl4CB
         Vcpejsbzm1NImQCaWbSRqJf3dmHi8JCNCxDXFxr4TbsTpy9b1LqPAq6spC36sDBcSADv
         nIuZaVqnW2aOmv4OonZSpaF/w92W+JyWY7NQNAkWrY1bVMPH4VL0IpGEyUNrBbcsSufy
         Rq2Q==
X-Gm-Message-State: AMke39njRyVVKIwhccZVLa6ge/8jrUh4bze+Jxi7dasYRCkEKY76PYsYzp5JxS7IzUVmbfAFd0zZrrN09Fy+Ww==
X-Received: by 10.36.144.132 with SMTP id x126mr10938itd.35.1488484546782;
 Thu, 02 Mar 2017 11:55:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Thu, 2 Mar 2017 11:55:45 -0800 (PST)
In-Reply-To: <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2017 11:55:45 -0800
X-Google-Sender-Auth: 3yFgmL2GlnWltcYL6wMxcZXnz8s
Message-ID: <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 4:39 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, I think that a primary goal for a new hash implementation
> absolutely needs to be to minimize mixing.
>
> Not for security issues, but because of combinatorics. You want to
> have a model that basically reads old data, but that very aggressively
> approaches "new data only" in order to avoid the situation where you
> have basically the exact same tree state, just _represented_
> differently.
>
> For example, what I would suggest the rules be is something like this:

Hmm. Having looked at this a fair amount, and in particularly having
looked at the code as part of the hash typesafety patch I did, I am
actually starting to think that it would not be too painful at all to
have a totally different approach, which might be a lot easier to do.

So bear with me, let me try to explain my thinking:

 (a) if we want to be backwards compatible and not force people to
convert their trees on some flag day, we're going to be stuck with
having to have the SHA1 code around and all the existing object
parsing for basically forever

Now, this basically means that the _easy_ solution would be that we
just do the flag day, switch to sha-256, extend everything to 32-byte
hashes, and just have a "git2 fast-import" that makes it easy to
convert stuff.

But it really would be a completely different version of git, with a
new pack-file format and no real compatibility. Such a flag-day
approach would certainly have advantages: it would allow for just
re-architecting some bad choices:

 - make the hashing be something that can be threaded (ie maybe we can
just block it up in 4MB chunks that you can hash in parallel, and make
the git object hash be the hash of hashes)

 - replace zlib with something like zstd

 - get rid of old pack formats etc.

but  on the whole, I still think that the compatibility would be worth
much more than the possible technical advantages of a clean slate
restart.

 (b) the SHA1 hash is actually still quite strong, and the collision
detection code effectively means that we don't really have to worry
about collisions in the immediate future.

In other words, the mitigation of the current attack is actually
really easy technically (modulo perhaps the performance concerns), and
there's still nothing fundamentally wrong with using SHA1 as a content
hash. It's still a great hash.

Now, my initial reaction (since it's been discussed for so long
anyway) was obviously "pick a different hash". That was everybody's
initial reaction, I think.

But I'm starting to think that maybe that initial obvious reaction was wrong.

The thing that makes collision attacks so nasty is that our reaction
to a collision is so deadly.  But that's not necessarily fundamental:
we certainly uses hashes with collisions every day, and they work
fine. And they work fine because the code that uses those hashes is
designed to simply deal gracefully - although very possibly with a
performance degradation - with two different things hashing to the
same bucket.

So what if the solution to "SHA1 has potential collisions" is "any
hash can have collisions in theory, let's just make sure we handle
them gracefully"?

Because I'm looking at our data structures that have hashes in them,
and many of them are actually of the type where I go

  "Hmm..  Replacing the hash entirely is really really painful - but
it wouldn't necessarily be all that nasty to extend the format to have
additional version information".

and the advantage of that approach is that it actually makes the
compatibility part trivial. No more "have to pick a different hash and
two different formats", and more of a "just the same format with
extended information that might not be there for old objects".

So we have a few different types of formats:

 - the purely local data structures: the pack index file, the file
index, our refs etc

   These we could in change completely, and it wouldn't even be all
that painful. The pack index has already gone through versions, and it
doesn't affect anything else.

 - the actual objects.

   These are fairly painful to change, particularly things like the
"tree" object which is probably the worst designed of the lot. Making
it contain a fixed-size binary thing was really a nasty mistake. My
bad.

 - the pack format and the protocol to exchange "I have this" information

   This is *really* painful to change, because it contains not just
the raw object data, but it obviously ends up being the wire format
for remote accesses.

and it turns out that *all* of these formats look like they would be
fairly easy to extend to having extra object version information. Some
of that extra object version information we already have and don't
use, in fact.

Even the tree format, with the annoying fixed-size binary blob. Yes,
it has that fixed size binary blob, but it has it in _addition_ to the
ASCII textual form that would be really easy to just extend upon. We
have that "tree entry type" that we've already made extensions with by
using it for submodules. It would be quite easy to just say that a
tree entry also has a "file version" field, so that you can have
multiple objects that just hash to the same SHA1, and git wouldn't
even *care*.

The transfer protocol is the same: yes, we transfer hashes around, but
it would not be all that hard to extend it to "transfer hash and
object version".

And the difference is that then the "backwards compatibility" part
just means interacting with somebody who didn't know to transfer the
object version. So suddenly being backwards compatible isn't a whole
different object parsing thing, it's just a small extension.

IOW, we could make it so that the SHA1 is just a hash into a list of
objects. Even the pack index format wouldn't need to change - right
now we assume that an index hit gives us the direct pointer into the
pack file, but we *could* just make it mean that it gives us a direct
pointer to the first object in the pack file with that SHA1 hash.
Exactly like you'd normally use a hash table with linear probing.

Linear probing is usually considered a horrible approach to hash
tables,. but it's actually a really useful one for the case where
collisions are very rare.

Anyway, I do have a suggestion for what the "object version" would be,
but I'm not even going to mention it, because I want people to first
think about the _concept_ and not the implementation.

So: What do you think about the concept?

               Linus
