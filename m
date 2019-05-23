Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9691F462
	for <e@80x24.org>; Thu, 23 May 2019 19:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbfEWTJv (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 15:09:51 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:32872 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbfEWTJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 15:09:50 -0400
Received: by mail-wm1-f52.google.com with SMTP id c66so7785545wme.0
        for <git@vger.kernel.org>; Thu, 23 May 2019 12:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=57rHKVoeb7bJ5ZcbTtREWbPGX5rTD7XD55GGn6UgOmU=;
        b=bl8PMZMhfZzt4lbk8+JvaYymVWGMOsNh388a396gw5BMgkRp971+t/eD2QFS6Ea4Yl
         SiiDXc1/3h1mKJEF6Ccp0qK6SGgrgd8OOYqF9RQVk32xf7Q/0WttPW1t+bwVYsGEv2JE
         c62XH4dgfmEzQpNatSFNExRceP19Qhm+giHQORuslVD1qXC1SRZovWnWocnTcalvkYMg
         bsslTVwx7b5gpUd2GGm6WGisZctyDQ5zK2jOedp310/1f3Nxs6f/kkoUCyDmpCOhRSPe
         fcRwliAGu6L2QRoQ/jWsst7FRhudSMDcrAzfORQAdJ7vlrexzoNGYq5460YDUYy6TCWQ
         bEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=57rHKVoeb7bJ5ZcbTtREWbPGX5rTD7XD55GGn6UgOmU=;
        b=hP1XNEhDJanSE3FFPrin/k8CZzFhaC/g3Uifk7VFIuxotM7XWv2dLWt/DKTMY1PBLX
         hQ1N9r/FTW4p1FOS3QuqIl8F0273b/y5G3B5NdLaK2drFRsrA2Evsz3pbBlQ80WwaLfX
         UfMz/WXljFwTYu99YsgW6IrkfH6DBrOpgta2NCMS2o73oPK5fjk9u7oupVrvJucG5mp4
         vIjeuFa/JPqQCbSb4hwWu/Q4E+rEcc1Pb4l4XGR+lB97t+GMOuXmjKlrWO+QiAC1OvFL
         hHmI+2PuxyBrjUrcuikhzvlvJq4IQUoUI/l0dReueN8mt5hSI6MEfmgFxHcMKwi608lo
         lcFg==
X-Gm-Message-State: APjAAAVKoCAcILhefc9wdY4HnCPA2t0fqOFwSVr3OoYso/1HTl/w/a5M
        JQhj5ClDWOsdMssUG+v+FTZmOshrDSY=
X-Google-Smtp-Source: APXvYqyIsrNTncFrOsxd12TLoyGEhiXQbFUZI1FyxmvhpI2PrAE6H9EsiSNPnAAvAaB9xEBnd/MZdg==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr12586857wmj.127.1558638587023;
        Thu, 23 May 2019 12:09:47 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (ekn89.neoplus.adsl.tpnet.pl. [83.21.181.89])
        by smtp.gmail.com with ESMTPSA id n2sm200404wro.13.2019.05.23.12.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:09:46 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     esr@thyrsus.com (Eric S. Raymond)
Cc:     git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
References: <20190521013250.3506B470485F@snark.thyrsus.com>
Date:   Thu, 23 May 2019 21:09:44 +0200
In-Reply-To: <20190521013250.3506B470485F@snark.thyrsus.com> (Eric
        S. Raymond's message of "Mon, 20 May 2019 21:32:50 -0400 (EDT)")
Message-ID: <86h89lq96v.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

esr@thyrsus.com (Eric S. Raymond) writes:

> I have been thinking hard about the problems raised during my
> request for unique timestamps.  I think I've found a better way
> to bust the box I was trying to break out of.  I am therefore
> withdrawing that proposal and replacing it with this one.
>
> It's time to separate commit identification from Merkle hashing.

Documentation/technical/hash-function-transition.txt identifies similar
problem, namely that existing signatures in signed tags, signed commits
and merges of signed tags are signatures of their SHA-1 form.  We want
to be able to verify those signatures, even if this verification may be
considered less secure now.

You want both more (stable IDs for all commits, not only those signed)
and less (you don't need verification down the tree using IDs used for
commit ID).

> One reason I am sure of this is the SHA-1 to whatever transition.
> We can't count on the successor hash to survive attack forever.
> Accordingly, git's design needs to be stable against the possibility
> of having to accommodate multiple future hash algorithms in the
> future.
>
> Here's how to do it:
>
> 1. Commit IDs and Merkle-tree hashes become separate commit
>    properties in the git filesystem.

The issue you need to consider is that for signatures to be secure they
must be over verification-hash Merkle-tree.  It is not only commits that
are identified by hashes, but also trees, blobs and tags.

Commits reference other commits ("parent" lines) and a tree ("tree");
trees reference other trees, blobs and possibly commits (if submodules
are used).  Tags can reference any object, but most common reference
commits.  Blobs, i.e. file contents, do not reference any other
objects.  For security, all those references should use most strong hash
function.

Changing referecing hash (e.g. "parent" uses SHA-256 instead of "SHA-1")
means that the contents of object changes, and thus its hash.
Documentation/technical/hash-function-transition.txt therefore talks
about SHA-256 and SHA-1 forms and SHA-256 and SHA-1 object names.

 "The sha1-name of an object is the SHA-1 of the concatenation of its
  type, length, a nul byte, and the object's sha1-content. This is the
  traditional <sha1> used in Git to name objects.

  The sha256-name of an object is the SHA-256 of the concatenation of its
  type, length, a nul byte, and the object's sha256-content."


> 2. The data structure representing a Merkle-tree hash becomes
>    a pair consisting of a value and a hash-algorithm tag. An
>    empty tag is interpreted as SHA-1. I will call this entity the
>    "verification hash" and avoid unqualified use of "hash" in the
>    rest of this proposal.

Currently Git makes use of the fact that SHA-1 and SHA-256 identifiers
are of different lengths to distinguish them (see section "Meaning of
signatures") in Documentation/technical/hash-function-transition.txt

There might be, I think, the problem for "tree" objects.  As opposed to
all other places, "tree" objects use binary representation of hash, and
not hexadecimal textual representation (some consider that a design
mistake).

>
> 3. The initial value of a commit's ID in a live repository is a copy
>    of its verification hash, except in one important case.
>
> 4. When a repository is exported to a stream, the commit-id is dumped
>    with other commit metadata.  Thus, anything that can read a stream
>    can resolve commit references in its change comments.
>
> 5. When a stream is imported, if a commit has a commit-id field it
>    overrides the default assignment of the generated verification hash
>    to that field.

I think Documentation/technical/hash-function-transition.txt misses
considerations for fast-import format (it talks about problem with
submodules, shallow clones, and currently not solved problem of
translating notes; it does not talk about git-replace, either).

>
> 6. Commit IDs are free-format and not interpreted by git except
>    as lookup keys. When git changes verification-hash functions,
>    commit IDs do not change.

All right.  Looks sensible on first glance.

For security, all references in Merkle-tree of hashes must use strong
verification hash.  This means that you need to be able to refer to any
object, including commit, by its verification hash name of its
verification hash form (where all references inside object, like
"parent" and "tree" headers in commit objects, use verification hashes).

You need to store this commit ID somewhere.  Current proposal for
transitional period in Documentation/technical/hash-function-transition.txt
talks about loose object index ($GIT_OBJECT_DIR/loose-object-idx) with
the following format:

  # loose-object-idx
  (sha256-name SP sha1-name LF)*

In packfile index contains separate SHA-1 indices and SHA-256 indices
into packfile, providing fast mapping from SHA-1 name or SHA-256 name to
position (index) of object in the packfile.

Something similar might have been needed for commit IDs mapping.

One problem is that neither loose object index, not the packfile index
are transported alongside with the objects.  So we may need to put
commit ID elsewhere...

Note that we cannot put X-hash identifier into X-hash object form, that
is you cannot add "id" header to object (though you might add "other-id"
header, assuming that if ID is hash based it is on the other-id form
without other-id header).

  id <sha-1 identifier of this object>
  tree 0fa044a4d161254a3eae0bd06c0452d79e489593
  parent 6505413ad94ddfc01f9e2f5c1b79ea6b8ffbabbb
  author A U Thor <author@example.com> 1558619302 +0200
  committer C O Mitter <committer@example.com> 1558628753 -0500

  fixes


> Notice several important properties of this design.
>
> A. Git becomes absolutely future-proofed against hash-algorithm
>    changes. It can even support the use of multiple hash types over
>    the lifetime of one repo.
>
> B. All SHA-1 commit references will resolve forever even after git
>    stops generating them.  All future hash-based commit references will
>    also be good forever.

We might need to be able to distinguish commit IDs from hash-based
object identifier of commit on command line, perhaps with something like

  <commit-id>^{id}

This is similar to proposed

  git --output-format=3Dsha1 log abac87a^{sha1}..f787cac^{sha256}

> C. The id/verification split will be invisible from clients at start,
>    because initially they coincide and will continue to do so unless
>    an explicit decision changes either the verification-hash algorithm
>    or the way commit-IDs are initialized.

The problem may be with reusing command output for input (to refer to
objects and commits).

>
> D. My wish for forward-portable unique commit IDs is granted.
>    They're not by default eyeball-friendly, but I can live with that.
>    Furthermore, because they're preserved in streams they can be
>    eternally stable even as hash algorithms and preferred ID
>    formats change.

Good.

>
> E. There is now a unique total order on the repo, modulo highly
>    unlikely (and in priciple completely avoidable) commit-ID
>    collisions. It's commit date tie-broken by commit-ID sort order.
>    It too survives hash-function changes.

Nice.

>
> F. There's no need for timestamp uniqueness any more.
>
> G. When a repository is imported from (say) Subversion, the Subversion
>    IDs *don't have to break*!  They can be used to initialize the
>    commit-ID fields. Many users migrating from other VCSes will be
>    deeply, deeply grateful for this feature.

There would also need to be some support to retrieve commits using their
"commit ID" stable identifiers.  It may not need to be very fast.

>
> I believe this solves every problem I walked in with except timestamp
> truncation.

Best,
--
Jakub Nar=C4=99bski
