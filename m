Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CBC208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 20:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbdHUUsI (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 16:48:08 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33546 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbdHUUsH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 16:48:07 -0400
Received: by mail-yw0-f181.google.com with SMTP id h127so29426522ywf.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LRjYncyWacqUI6MvZ7gPDrm5uVLMNPS82qED/6pdVic=;
        b=P4GVNnnccmsogEm7SwvqWK6GhpgTwVPLbjEysLpaA/sA+oRVZZuU70WYhBma+tbWM+
         /ooXhcCmC211uNdcjZ4arqa/RG/Iblugrpbxy2wCfs2yo148gPPnD6O03k8EB782hD24
         ci1yo2KZ0gsiTXJPOi+Ok2+PqwZwkJiFklEDR1uJ0LObHfgtFQRpA9jU1+LTrqmbit1+
         Bl8GBwQ6lvJnMTEZPCT2IonKrHt/e+GDqAOjxAsRKbLPGxmeB+AH2Z8rvh+1ftXF+Q8N
         ++766ndnShjb+LaOJHejeRdPU2fwR3+xIum6dUEqAWkgvmHIvaWSz+TUynBGrJuDO82J
         KvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LRjYncyWacqUI6MvZ7gPDrm5uVLMNPS82qED/6pdVic=;
        b=BZuZtg0wDE0tzapEwzBygauEuhv8A9NSw16P+3jOKXCdMyImuoiPN6aJBgdC4dyczG
         Gn9RSIuMUn9ODy3FXTJfJrePaJDHiy7Le0B7kqxi5vH5haN+1eF95QCl3AL+NrAmCD0h
         kvPjzd0skF5rgH6x7iVFZV4b3zGWI+j84poi2wPDoMAX4bIUQOLzKv0GIFBnkO7fa/VL
         FHCu9yRRjxFN9fox2pm73JAjicOSrmhcFuhap55cFYyIFzAh/1Vv1uTmqfd/TuIMnEWk
         Vwf0QiKG29+1yZ5/3S9Jl9H9NPeBpVHK0DlA0ScHH2Q4VDeiNr68bxLi+nWW9aJLsBY9
         B4Hw==
X-Gm-Message-State: AHYfb5g1Fsz4eyRhFjbMVqDU7ItGh3yH69til+xj0VcpBlbB/pgI1GQZ
        DyUE8nSQwrR/EOf0M2Yy81jg/U4DfFhB
X-Received: by 10.13.212.149 with SMTP id w143mr2815583ywd.4.1503348486373;
 Mon, 21 Aug 2017 13:48:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 13:48:05 -0700 (PDT)
In-Reply-To: <20170821000022.26729-1-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 13:48:05 -0700
Message-ID: <CAGZ79kZ1CTza=PEqP=3gTT=81HRAAUfPWQyWKxNXKf5G0e+nNg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Hash Abstraction
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2017 at 5:00 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> = Overview
>
> This is an RFC series proposing a basic abstraction for hash functions.
>
> As we get closer to converting the remainder of the codebase to use
> struct object_id, we should think about the design we want our hash
> function abstraction to take.  This series is a proposal for one idea to
> start discussion.  Input on any aspect of this proposal is welcome.
>
> This series exposes a struct git_hash_algo that contains basic
> information about a given hash algorithm that distinguishes it from
> other algorithms: name, lengths, implementing functions, and empty tree
> and blob constants.  It also exposes an array of hash algorithms, and a
> constant for indexing them.
>
> The series also demonstrates a simple conversion using the abstraction
> over empty blob and tree values.
>
> In order to avoid conflicting with the struct repository work and with
> the goal of avoiding global variables as much as possible, I've pushed
> the hash algorithm into struct repository and exposed it via a #define.
> This necessitiates pulling repository.h into cache.h, which I don't
> think is fatal.  Doing that, in turn, necessitated some work on the
> Subversion code to avoid conflicts.
>
> It should be fine for Junio to pick up the first two patches from this
> series, as they're relatively independent and valuable without the rest
> of the series.  The rest should not be applied immediately, although
> they do pass the testsuite.
>
> I proposed this series now as it will inform the way we go about
> converting other parts of the codebase, especially some of the pack
> algorithms.  Because we share some hash computation code between pack
> checksums and object hashing, we need to decide whether to expose pack
> checksums as struct object_id, even though they are technically not
> object IDs.  Furthermore, if we end up needing to stuff an algorithm
> value into struct object_id, we'll no longer be able to directly
> reference object IDs in a pack without a copy.

Note that the checksum hash could be different from actual object ids,
so it may be easiest to introduce a "new pack format", which is just
s/sha1/<new hash>/g for any object ids, though I guess the work needed
is just the same for converting checksums to the new hash, too.


> This series is available from the usual places as branch hash-struct,
> based against master.
>
> = Naming
>
> The length names are similar to the current constant names
> intentionally.  I've used the "hash_algo" name for both the integer
> constant and the pointer to struct, although we could change the latter
> to "hash_impl" or such as people like.
>
> I chose to name the define "current_hash" and expose no other defines.
> The name is relatively short since we're going to be typing it a lot.
> However, if people like, we can capitalize it or expose other defines
> (say, a GIT_HASH_RAWSZ or GIT_HASH_HEXSZ) instead of or in addition to
> current_hash, which would make this name less interesting.
>
> Feel free to propose alternatives to the naming of anything in this
> series.
>
> = Open Issues
>
> I originally decided to convert hex.c as an example, but quickly found
> out that this caused segfaults.  As part of setup, we call
> is_git_directory, which calls validate_headref, which ends up calling
> get_sha1_hex.  Obviously, we don't have a repository, so the hash
> algorithm isn't set up yet.  This is an area we'll need to consider
> making hash function agnostic, and we may also need to consider
> inserting a hash constant integer into struct object_id if we're going
> to do that.  Alternatively, we could just paper over this issue as a
> special case.

We could introduce new files .sha1 or .sha256 in the config dir, whose
existence can be checked prior to validating the HEAD.

Maybe the HEAD validation can be non-strict and could check
if we'd have at least 'n' hex chars and at most 'm' hex chars. 'n' and 'm'
depend on the hash functions supported of that version of git. (Maybe
we'd validate later again to have the correct hash function length,
or we could also allow abbreviated hash names for HEAD)

> Clearly we're going to want to expose some sort of lookup functionality
> for hash algorithms.  We'll need to expose lookup by name (for the
> .git/config file and any command-line options), but we may want other
> functions as well.  What functions should those be?  Should we expose
> the structure or the constant for those lookup functions?  If the
> structure, we'll probably need to expose the constant in the structure
> as well for easy use.
>
> Should we avoid exposing the array of structure altogether and wrap this
> in a function?
>
> We could expose a union of hash context structures and take that as the
> pointer type for the API calls.  That would probably obviate the need
> for ctxsz.
>
> We could expose hex versions of the blob constants if desired.  This
> might make converting the remaining pieces of code that use them easier.
>
> There are probably dozens of other things I haven't thought of yet as
> well.
>
> brian m. carlson (6):
>   vcs-svn: remove unused prototypes
>   vcs-svn: rename repo functions to "svn_repo"
>   setup: expose enumerated repo info
>   Add structure representing hash algorithm
>   Integrate hash algorithm support with repo setup
>   Switch empty tree and blob lookups to use hash abstraction
>
>  builtin/am.c        |  2 +-
>  builtin/checkout.c  |  2 +-
>  builtin/diff.c      |  2 +-
>  builtin/pull.c      |  2 +-
>  cache.h             | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  diff-lib.c          |  2 +-
>  merge-recursive.c   |  2 +-
>  notes-merge.c       |  2 +-
>  repository.c        |  7 +++++++
>  repository.h        |  5 +++++
>  sequencer.c         |  6 +++---
>  setup.c             | 48 +++++++++++++++++++++++++++---------------------
>  sha1_file.c         | 29 +++++++++++++++++++++++++++++
>  submodule.c         |  2 +-
>  vcs-svn/repo_tree.c |  6 +++---
>  vcs-svn/repo_tree.h | 13 +++----------
>  vcs-svn/svndump.c   |  8 ++++----
>  17 files changed, 133 insertions(+), 53 deletions(-)
>
