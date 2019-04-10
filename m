Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1C120248
	for <e@80x24.org>; Wed, 10 Apr 2019 05:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDJFJm (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 01:09:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfDJFJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 01:09:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so1263840wrp.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 22:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O80FyglPAvbGK/0YNng85BCyEbJuETSAH81VkFUmITs=;
        b=prkI7u4ajgdCF/XFyFR8JGFFUgGrK4Ej3lKVBAmKpud5eZY9z3+5sj0Foj7PqF/BN5
         El6NoOSgoIPYOO7WDKi45Jnmf3TTuP6RFjKcBYIb5LRy+XRqsiWtdEa+1e5rA6I8Fo9G
         lI+6kPe/tVpaYTPnPF49KP8/mouJcGGR5488jiFAdinbfNjaB2LA+/KviMMTxMcUv8a6
         zBJYqgBG9YMMISct+zeE/drLBcsrcgqVcHZbp8CdySbn5EMqEcYwy0H8zXDwipXAUIjH
         tKfXkNVu6ySMYw/5pvvwkHLoj8navARvUgFTAGC8POWbVDH7yW8ei85UvVz+CSRTGjqQ
         U96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O80FyglPAvbGK/0YNng85BCyEbJuETSAH81VkFUmITs=;
        b=Vk34k4mCniYxI5hitYKXXRhKKPd4ZEU/HTbffUtSlSehZBXSrFJuVqwUrXIeKMPSsf
         nC3nZjTA0IVOdzQuCJy6UIJNYzAVJZ82AGT/B7YppCQEAztjSddjnBzqQXUmfmZj6eka
         it/K7oKvdNvUPdFv1cxE2w5cA/d9Aa+FUSvfV8io1AsMcjaM9bIS1iMZuO3UgPQuLu2L
         TJqtC7TuO3kkZxgm4G4dFPiuXYgMuKcI1l6si9uvuzJuGejx3lGRwZQR2bk254F0VAeg
         VfMbg1I/o5WPhefsi+kYxkFYu7HkCkaougEFtLE8DVPRGpz+6jWht2ejjwA/33qYni7/
         4zWw==
X-Gm-Message-State: APjAAAVhIq2msCByme2c9CLTZlEszCzwGrgyI52Bqn2F+ZSubvlon8jv
        G5ZCYiqq2biMCAl7Yf74tOA=
X-Google-Smtp-Source: APXvYqwFc6okur0bLXQ4iJkE4DliHqAU0NLvmW2WP2IMYZsF6i5+OLjPe0xtLaPf0Xund2o+ceaYVw==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr25290626wrn.193.1554872979903;
        Tue, 09 Apr 2019 22:09:39 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z18sm53764608wrr.90.2019.04.09.22.09.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 22:09:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GSoC] [RFC] Proposal: Teach git stash to handle unmerged index entries.
References: <CAMknYEMh=CN6GGRPD_fkafHy84e49JY5dK2dAgX6Z7542dJ-Uw@mail.gmail.com>
        <xmqqo95e1nik.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 10 Apr 2019 14:09:38 +0900
In-Reply-To: <xmqqo95e1nik.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 10 Apr 2019 13:40:19 +0900")
Message-ID: <xmqqk1g21m5p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As to the design, it does not quite matter if you add four or more
> separate trees to represent stage #[0123] entries in the index to
> the already octopus merge commit that represents a stash entry ...

I forgot that I was planning to expand on this part while writing
the message I am following up.

There are a few things you must take into account while designing a
new format for a stash entry:

 - Your new feature will *NOT* be the last extension to the stash
   subsystem.  Always leave room to other developers to extend it
   further, without breaking backward compatiblity when your new
   feature is int in use.

 - Even though you may have never encountered in your projects,
   higher stage entries can have duplicates.  When merging two
   branches into your current branch, and there are three merge
   bases for such an octopus merge, the system (and the index
   format) is designed to allow a merge backend to store 3 stage #1
   entries (because there are that many common ancestor versions in
   the example), 1 stage #2 entry (because there is only one
   "current brahch" a merge is made into) and 2 stage #3 entries
   (because there are that many other branches you are merging into
   the current branch), all for the same path.

So, a design that says:

   A stash entry in the current system is recorded as a merge
   commit, whose tree represents the state of the tracked working
   tree files, whose first parent records the HEAD commit the stash
   entry was created on, and whose second parent records the tree
   that would have been created if "git write-tree" were done on the
   index when the stash entry was created.  Optionally, it can have
   the third parent whose tree records the state of untracked files.

   Let's add three more parents.  IOW, the fourth parent's tree
   records the result of "git write-tree" of the index after
   removing all the entries other than those at stage #1 and moving
   the remainder from stage #1 down to stage #0, and similarly the
   fifth is for stage #2 and the sixth is for stage #3.

is bad at multiple counts.

 - It does not say what should happen to the third parent when this
   new "record unmerged state" feature is used without using the
   "record untracked paths" feature.

 - It does not allow multiple stage #1 and/or stage #3 entries.

For the first point, I think a trick to record the same commit as
the first parent may be a good hack to say "this is not used"; we
might need to allow commit-tree not to complain about duplicate
parents if we go that route.

FOr the second one, there may be multiple solutions.  A
quick-and-dirty and obvious way may be to add only one new parent to
the merge commit that represents a stash entry (i.e. the fourth
parent).  Make that new parent a merge of three commits, each of
which represents what was in stage #1, stage #2 and stage #3 (we can
reuse the second parent of the stash entry that usually records the
index state to store stage #0 entries).

As we allow multiple stage #1 or stage #3 entries in the index, and
there is no fundamental reason why we should not allow multiple
stage #2 entries, make each of these three commits able to represent
multiple entries at the same stage, perhaps by

 - iterate over the index and count the maximum occurrence of the
   same path at the same stage #$n;
 - make that stage #$n commit a merge of that many parent commits.
   The tree recorded in that stage #$n commit can be an empty tree.

I am not saying this is a good design.  I am merely showing the
expected level of detail when your design gets in a presentable
shape and shared with the list.

Have fun.


