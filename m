Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B461420281
	for <e@80x24.org>; Fri, 29 Sep 2017 17:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbdI2ReT (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 13:34:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37165 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752113AbdI2ReR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 13:34:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id 125so187497pgj.4
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wGTovfNdiHISFxRZU5fi6d4IQO/FKc6KWZ75ODkUioc=;
        b=JRJWHBWAiMngEVEJmd4S876myt3HY7+OyR0THAl0KHwFRwWCZSTRwuen1CFtB12aBg
         7hR92GZc6kQL/LJhDubcscNBz4r4j+LzIrWZUXzFRb70iLoC/WWc+TKDwax/IHEvh09k
         aJ7k7JGDnoaqSEAOS1YwMWKtJMTponvaddOjRlIc4uFB0halPEI3O7X9cNRZftRdFuqq
         9DE7zNQVrFAq2xCZXRLfNmpzLClnfLUy1O/lkjukmyKcevS3Im+4DqkRP1zXUEFe2rVU
         Xtnq6r1p6AgcLX0iKBk1i6s5dm+qIQCrOhr/0KEbjUpPuveqizcO4Bl3W/0OCTNxLgif
         fnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wGTovfNdiHISFxRZU5fi6d4IQO/FKc6KWZ75ODkUioc=;
        b=OeQbaMgs5m7HveXejTBCNChtFCLmObQGO2LFluOLHHpjh5ohx511ReFrZWZ55uGiyg
         +CZ9TZqijHies1Fk4Aa8T9tGQHg42dgJvVUMa//ExwZl4Ll5mWClRvvomro+giQW5/IM
         WLnNXzD1Y4BOsW/I/nx87CHUfwKhRru/rQPU0lIY/Ur7IBu7oVVd6Ogal+ipHbMs1vdC
         LfoIKpurKavExTsif19o8reumIlif1V7i0Y0SdA5CsobMp5ncpGzU0S4EaEmqFuO3pIe
         8nMbf2ENYzVURGqpOgR/keGFQzrVqyHcLy9UPM2s/HCXnzRaEMg2qczFcURdImPLlHQq
         AhFg==
X-Gm-Message-State: AHPjjUhHKoxau4bmghSXilnOXc2ZH6+ewm/HTYuoSnfaf2QYKQ1EgPq6
        YcO2FIsffelNHhKgvgq5e5w=
X-Google-Smtp-Source: AOwi7QBFpBAFWvwdDGom5WORPL43lMDTif5FcQSXSJLrPgVanTYls0Y+70YzKw+bEecIcClmoZp+cg==
X-Received: by 10.84.174.197 with SMTP id r63mr7611324plb.235.1506706456745;
        Fri, 29 Sep 2017 10:34:16 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c47c:760e:a02b:2eef])
        by smtp.gmail.com with ESMTPSA id n12sm7888851pfb.131.2017.09.29.10.34.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 10:34:15 -0700 (PDT)
Date:   Fri, 29 Sep 2017 10:34:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function
 transition
Message-ID: <20170929173413.GI19555@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
 <20170928044320.GA84719@aiede.mtv.corp.google.com>
 <xmqqo9puvy1w.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9puvy1w.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> This document describes what a transition to a new hash function for
>> Git would look like.  Add it to Documentation/technical/ as the plan
>> of record so that future changes can be recorded as patches.
>>
>> Also-by: Brandon Williams <bmwill@google.com>
>> Also-by: Jonathan Tan <jonathantanmy@google.com>
>> Also-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>
> Shoudln't these all be s-o-b: (with a note immediately before that
> to say all four contributed equally or something)?

I don't want to get lost in the weeds in the question of how to
represent such a collaborative effort in git's metadata.

You're right that I should collect their sign-offs!  Your approach of
using text instead of machine-readable data for common authorship also
seems okay.

In any event, this is indeed

Signed-off-by: Brandon Williams <bmwill@google.com>
Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>

(I just checked :)).

>> +Background
>> +----------
>> +At its core, the Git version control system is a content addressable
>> +filesystem. It uses the SHA-1 hash function to name content. For
>> +example, files, directories, and revisions are referred to by hash
>> +values unlike in other traditional version control systems where files
>> +or versions are referred to via sequential numbers. The use of a hash
>
> Traditional systems refer to files via numbers???  Perhaps "where
> versions of files are referred to via sequential numbers" or
> something?

Good point.  The wording you suggested will work well.

>> +function to address its content delivers a few advantages:
>> +
>> +* Integrity checking is easy. Bit flips, for example, are easily
>> +  detected, as the hash of corrupted content does not match its name.
>> +* Lookup of objects is fast.
>
> * There is no ambiguity what the object's name should be, given its
>   content.
>
> * Deduping the same content copied across versions and paths is
>   automatic.

:)  Yep, these are nice too, especially that second one.

It also is how we make diff-ing fast.

>> +SHA-1 still possesses the other properties such as fast object lookup
>> +and safe error checking, but other hash functions are equally suitable
>> +that are believed to be cryptographically secure.
>
> s/secure/more &/, perhaps?

We were looking for a phrase meaning that it should be a cryptographic
hash function in good standing, which SHA-1 is at least approaching
not being.

"more secure" should work fine.  Let's go with that.

>> +Goals
>> +-----
>> +...
>> +   c. Users can use SHA-1 and NewHash identifiers for objects
>> +      interchangeably (see "Object names on the command line", below).
>
> Mental note.  This needs to extend to the "index X..Y" lines in the
> patch output, which is used by "apply -3" and "am -3".

Will add a note about this to "Object names on the command line".  Stefan
had already pointed out that that section should really be renamed to
something like "Object names in input and output".

>> +2. Allow a complete transition away from SHA-1.
>> +   a. Local metadata for SHA-1 compatibility can be removed from a
>> +      repository if compatibility with SHA-1 is no longer needed.
>
> I like the emphasis on "Local" here.  Metadata for compatiblity that
> is embedded in the objects obviously cannot be removed.
>
> From that point of view, one of the goals ought to be "make sure
> that as much SHA-1 compatibility metadata as possible is local and
> outside the object".  This goal may not be able to say more than "as
> much as possible", as signed objects that came from SHA-1 world
> needs to carry the compatibility metadata somewhere somehow.
>
> Or perhaps we could.  There is nothing that says a signed tag
> created in the SHA-1 world must have the PGP/SHA-1 signature in the
> NewHash payload---it could be split off of the object data and
> stored in a local metadata cache, to be used only when we need to
> convert it back to the SHA-1 world.

That would break round-tripping and would mean that multiple SHA-1
objects could have the same NewHash name.  In other words, from
my point of view there is something that says that such data must
be preserved.

Another way to put it: even after removing all SHA-1 compatibility
metadata, one nice feature of this design is that it can be recovered
if I change my mind, from data in the NewHash based repository alone.

[...]
>> +Non-Goals
>> +---------
>> ...
>> +6. Skip fetching some submodules of a project into a NewHash
>> +   repository. (This also depends on NewHash support in Git
>> +   protocol.)
>
> It is unclear what this means.  Around submodule support, one thing
> I can think of is that a NewHash tree in a superproject would record
> a gitlink that is a NewHash commit object name in it, therefore it
> cannot refer to an unconverted SHA-1 submodule repository.  But it
> is unclear if the above description refers to the same issue, or
> something else.

It refers to that issue.

[...]
>> +Overview
>> +--------
>> +We introduce a new repository format extension. Repositories with this
>> +extension enabled use NewHash instead of SHA-1 to name their objects.
>> +This affects both object names and object content --- both the names
>> +of objects and all references to other objects within an object are
>> +switched to the new hash function.
>> +
>> +NewHash repositories cannot be read by older versions of Git.
>> +
>> +Alongside the packfile, a NewHash repository stores a bidirectional
>> +mapping between NewHash and SHA-1 object names. The mapping is generated
>> +locally and can be verified using "git fsck". Object lookups use this
>> +mapping to allow naming objects using either their SHA-1 and NewHash names
>> +interchangeably.
>> +
>> +"git cat-file" and "git hash-object" gain options to display an object
>> +in its sha1 form and write an object given its sha1 form.
>
> Both of these are somewhat unclear.

I think we can delete this paragraph.  It was written before the
"Object names on the command line" section that goes into such issues
in more detail.

[...]
>> +Object names
>> +~~~~~~~~~~~~
>> +Objects can be named by their 40 hexadecimal digit sha1-name or 64
>> +hexadecimal digit newhash-name, plus names derived from those (see
>> +gitrevisions(7)).
>> +
>> +The sha1-name of an object is the SHA-1 of the concatenation of its
>> +type, length, a nul byte, and the object's sha1-content. This is the
>> +traditional <sha1> used in Git to name objects.
>> +
>> +The newhash-name of an object is the NewHash of the concatenation of its
>> +type, length, a nul byte, and the object's newhash-content.
>
> It makes me wonder if we want to add the hashname in this object
> header.  "length" would be different for non-blob objects anyway,
> and it is not "compat metadata" we want to avoid baked in, yet it
> would help diagnose a mistake of attempting to use a "mixed" objects
> in a single repository.  Not a big issue, though.

Do you mean that adding the hashname into the computation that
produces the object name would help in some use case?

Or do you mean storing the hashname on disk somewhere, even if it
doesn't enter into the object name?  For the latter, we store the
hashname in the .git/config extensions.* configuration and the pack
index files.  You also suggested storing the hash name in
.git/objects/loose-object-idx, which seems to me like a good idea.

We didn't touch on the .pack format but we probably need to (if only
because of the size of REF_DELTAs and the cksum trailer), and it would
also need to name what object format it is using.

For loose objects, it would be nice to name the hash in the file, so
that "file" can understand what is happening if someone accidentally
mixes types using "cp".  The only downside is losing the ability to
copy blobs (which have the same content despite being named using
different hashes) between repositories after determining their new
names.  That doesn't seem like a strong downside --- it's pretty
harmless to include the hash type in loose object files, too.  I think
I would prefer this to be a "magic number" instead of part of the
zlib-deflated payload, since this way "file" can discover it more
easily.

>> +The format allows round-trip conversion between newhash-content and
>> +sha1-content.
>
> If it is a goal to eventually be able to lose SHA-1 compatibility
> metadata from the objects, then we might want to remove SHA-1 based
> signature bits (e.g. PGP trailer in signed tag, gpgsig header in the
> commit object) from NewHash contents, and instead have them stored
> in a side "metadata" table, only to be used while converting back.
> I dunno if that is desirable.

I don't consider that desirable.

A SHA-1 based signature is still of historical interest even if my
centuries-newer version of Git is not able to verify it.

[...]
> I take it to mean that the stride is defined in the "length in bytes
> of shortened object names" in the file header.  If so, I can see how
> this would work.  This "sorted table", unlike the next one, does not
> say how it is sorted, but I assume this is just the object name
> order (as opposed to the pack location order the next table uses)?

Yes.  Will clarify.

>> +  - A table of full object names in pack order. This allows resolving
>> +    a reference to "the nth object in the pack file" (from a
>> +    reachability bitmap or from the next table of another object
>> +    format) to its object name.
>> +
>> +  - A table of 4-byte values mapping object name order to pack order.
>> +    For an object in the table of sorted shortened object names, the
>> +    value at the corresponding index in this table is the index in the
>> +    previous table for that same object.
>> +
>> +    This can be used to look up the object in reachability bitmaps or
>> +    to look up its name in another object format.
>
> And this is a separate table because the short-name table wants to
> be as compact as possible for binary search?  Otherwise an entry in
> the short-name table could be <pack order number, n-bytes that is
> short unique prefix>.

Yes.  The idx v2 format has a similar design.

>> +  - A table of 4-byte CRC32 values of the packed object data, in the
>> +    order that the objects appear in the pack file. This is to allow
>> +    compressed data to be copied directly from pack to pack during
>> +    repacking without undetected data corruption.
>
> An obvious alternative would be to have the CRC32 checksum near
> (e.g. immediately before) the object data in the packfile (as
> opposed to the .idx file like this document specifies).  I am not
> sure what the pros and cons are between the two, though, and that is
> why I mention the possiblity here.

As you mentioned under separate cover, it is useful for derived data
like this to be outside the packfile.

> Hmm, as the corresponding packfile stores object data only in
> NewHash content format, it is somewhat curious that this table that
> stores CRC32 of the data appears in the "Tables for each object
> format" section, as they would be identical, no?  Unless I am
> grossly misleading the spec, the checksum should either go outside
> the "Tables for each object format" section but still in .idx, or
> should be eliminated and become part of the packdata stream instead,
> perhaps?

It's actually only present for the first object format.  Will find a
better way to describe this.

>> +  - A table of 4-byte offset values. For an object in the table of
>> +    sorted shortened object names, the value at the corresponding
>> +    index in this table indicates where that object can be found in
>> +    the pack file. These are usually 31-bit pack file offsets, but
>> +    large offsets are encoded as an index into the next table with the
>> +    most significant bit set.
>
> Oy.  So we can go from a short prefix to the pack location by first
> finding it via binsearch in the short-name table, realize that it is
> nth object in the object name order, and consulting this table.
> When we know the pack-order of an object, there is no direct way to
> go to its location (short of reversing the name-order-to-pack-order
> table)?

An earlier version of the design also had a pack-order-to-pack-offset
table, but we weren't able to think of any cases where that would be
used without also looking up the object name that can be used to
verify the integrity of the inflated object.

Do you have an application in mind?

[...]
>> +- Tables for the second object format, with the same layout as above,
>> +  up to and not including the table of CRC32 values.
>> +- Zero or more NUL bytes.
>> +- The trailer consists of the following:
>> +  - A copy of the 20-byte NewHash checksum at the end of the
>> +    corresponding packfile.
>> +
>> +  - 20-byte NewHash checksum of all of the above.
>
> When did NewHash shrink to 20-byte suddenly?  I think the above two
> are both "32-byte"?

Yes, good catch.

[...]
>> +Loose object index
>> +~~~~~~~~~~~~~~~~~~
>> +A new file $GIT_OBJECT_DIR/loose-object-idx contains information about
>> +all loose objects. Its format is
>> +
>> +  # loose-object-idx
>> +  (newhash-name SP sha1-name LF)*
>> +
>> +where the object names are in hexadecimal format. The file is not
>> +sorted.
>
> Shouldn't the file somehow say what hashes are involved to allow us
> match it with extension.{objectFormat,compatObjectFormat}, perhaps
> at the end of the "# loose-object-idx" line?

Good idea!

[...]
>> +The loose object index is protected against concurrent writes by a
>> +lock file $GIT_OBJECT_DIR/loose-object-idx.lock. To add a new loose
>> +object:
>> +
>> +1. Write the loose object to a temporary file, like today.
>> +2. Open loose-object-idx.lock with O_CREAT | O_EXCL to acquire the lock.
>> +3. Rename the loose object into place.
>> +4. Open loose-object-idx with O_APPEND and write the new object
>
> "write the new entry, fsync and close"?

Yes, I think we do need to fsync. :/

[...]
>> +Translation table
>> +~~~~~~~~~~~~~~~~~
>> +The index files support a bidirectional mapping between sha1-names
>> +and newhash-names. The lookup proceeds similarly to ordinary object
>> +lookups. For example, to convert a sha1-name to a newhash-name:
>> +
>> + 1. Look for the object in idx files. If a match is present in the
>> +    idx's sorted list of truncated sha1-names, then:
>> +    a. Read the corresponding entry in the sha1-name order to pack
>> +       name order mapping.
>> +    b. Read the corresponding entry in the full sha1-name table to
>> +       verify we found the right object. If it is, then
>> +    c. Read the corresponding entry in the full newhash-name table.
>> +       That is the object's newhash-name.
>
> c. is possible because b. and c. are sorted the same way, i.e. the
> index used to consult the full sha1-name table, which is the pack
> order number, can be used to find its full newhash in the "full
> newhash sorted by pack order" table?

Yes.

>> +Reading an object's sha1-content
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I'd stop here and continue in a separate message.  Thanks for a
> detailed write-up.

Thanks for looking it over.

Jonathan
