Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 586DE20899
	for <e@80x24.org>; Wed,  2 Aug 2017 17:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbdHBRjD (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:39:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33494 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdHBRjC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:39:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so6467856pfl.0
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/QrD9Ifn3pZ2ZTkGOZDedBafiYyjUo1VPDoxQbOmKA=;
        b=sjimgj2lBy6lBtfINx0A6P+Yx8UkE+34STr7OYucg/gcAVbyB1PZvdDh/JYKQEmQsX
         W7ySdWR8XqXq47kxj3fB8zG/65dB2Rp3x0p8x4D1H6HtjWRVioODKeNKBj+qWnCQinO6
         ERy1THfMmJpWTZI3HHp3VrbQxUE5dFq57UmkPVtk0xiUcTCz7nZ6CmCNMb2O52eCBPO9
         iA1/j1psvSE/ISER+2o7ECik1bymgxgVQ32Gb5yOUG5h0t3FpKjX3B0gvCoOPW3mqRy8
         Qt70XbSb3pgOYHD5zO4dcgZaCYGAMim7ITs9km8zl1u48DrflpY6XgshBYiDp2Av9i9S
         THVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/QrD9Ifn3pZ2ZTkGOZDedBafiYyjUo1VPDoxQbOmKA=;
        b=ZyL8t89TNEMf0cRsT7Kq/M9zpRz4jF5r+uTjqYf79tghJqvUJUfGgQsX6BCnXQ+Lbb
         7iVurfkuToapTk1kDGwFqAKoKlbGiWn7DKB+ihnNx3N+8TTJGRIBXneM4kEUKLUbs8o+
         bME+WCRYxi2Mba0LNxoz/dJqdmCnrYJAcEiSZwCy/HO7oilqdYD4J7apXrekMlRfJJD+
         AfwgW2Jey6BlTq0/qKehli9angxhb5Cz4+ijzf/6llQGDWnuNTThjBUbTBLkQ81THGGa
         9Uq54nkhnFsOQLqEa731oJs60lO42GgBk+a9lW5wkqRUm+IqwTqenFb2VNn6wYFAy6D8
         3nJQ==
X-Gm-Message-State: AIVw112sFhPwGwJ80m1QnFDSqB9V2618sHzaZ26PVlNIhJISMnD7EZvs
        g4oRHfL54VbEGw==
X-Received: by 10.84.217.144 with SMTP id p16mr26681643pli.276.1501695541375;
        Wed, 02 Aug 2017 10:39:01 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:edc3:2705:cd6c:d8b2])
        by smtp.gmail.com with ESMTPSA id y6sm58135824pgq.41.2017.08.02.10.38.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 10:38:59 -0700 (PDT)
Date:   Wed, 2 Aug 2017 10:38:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual
 invocation of loader
Message-ID: <20170802173857.GU13924@aiede.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
 <cover.1501532294.git.jonathantanmy@google.com>
 <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
 <20170731160533.0a446244@twelve2.svl.corp.google.com>
 <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
 <20170801171944.7690a63f@twelve2.svl.corp.google.com>
 <xmqqefsudjqk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefsudjqk.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:

>> One possibility to conceptually have the same thing without the overhead
>> of the list is to put the obtained-from-elsewhere objects into its own
>> alternate object store, so that we can distinguish the two.
>
> Now you are talking.  Either a separate object store, or a packfile
> that is specially marked as such, would work.

Jonathan's not in today, so let me say a few more words about this
approach.

This approach implies a relaxed connectivity guarantee, by creating
two classes of objects:

 1. Objects that I made should satisfy the connectivity check.  They
    can point to other objects I made, objects I fetched, or (*) objects
    pointed to directly by objects I fetched.  More on (*) below.

 2. Objects that I fetched do not need to satisfy a connectivity
    check.  I can trust the server to provide objects that they point
    to when I ask for them, except in extraordinary cases like a
    credit card number that was accidentally pushed to the server and
    prompted a rewriting of history to remove it (**).

The guarantee (1) looks like it should be easy to satisfy (just like
the current connectivity guarantee where all objects are in class (1)).
I have to know about an object to point to it --- that means the
pointed-to object has to be in the object store or pointed to by
something in the object store.

The complication is in the "git gc" operation for the case (*).
Today, "git gc" uses a reachability walk to decide which objects to
remove --- an object referenced by no other object is fair game to
remove.  With (*), there is another kind of object that must not be
removed: if an object that I made, M, points to a missing/promised
object, O, pointed to by a an object I fetched, F, then I cannot prune
F unless there is another fetched object present to anchor O.

For example: suppose I have a sparse checkout and run

	git fetch origin refs/pulls/x
	git checkout -b topic FETCH_HEAD
	echo "Some great modification" >> README
	git add README
	git commit --amend

When I run "git gc", there is nothing pointing to the commit that was
pointed to by the remote ref refs/pulls/x, so it can be pruned.  I
would naively also expect that the tree pointed to by that commit
could be pruned.  But pruning it means pruning the promise that made
it permissible to lack various blobs that my topic branch refers to
that are outside the sparse checkout area.  So "git gc" must notice
that it is not safe to prune that tree.

This feels hacky.  I prefer the promised object list over this
approach.

>                                                "Maintaining a list
> of object names in a flat file is too costly" is not a valid excuse
> to discard the integrity of locally created objects, without which
> Git will no longer be a version control system,

I am confused by this: I think that Git without a "git fsck" command
at all would still be a version control system, just not as good of
one.

Can you spell this out more?  To be clear, are you speaking as a
reviewer or as the project maintainer?  In other words, if other
reviewers are able to settle on a design that involves a relaxed
guarantee for fsck in this mode that they can agree on, does this
represent a veto meaning the patch can still not go through?

On one hand I'm grateful for the help exploring the design space, and
I think it has helped get a better understanding of the issues
involved.

On the other hand, if this is a veto then it feels very black and
white and a hard starting point to build a consensus from.  I am
worried.

[...]
>> I mentioned
>> this in my e-mail but rejected it, but after some more thought, this
>> might be sufficient - we might still need to iterate through every
>> object to know exactly what we can assume the remote to have, but the
>> "frontier" solution also needs this iteration, so we are no worse off.
>
> Most importantly, this is allowed to be costly---we are doing this
> not at runtime all the time, but when the user says "make sure that
> I haven't lost objects and it is safe for me to build further on
> what I created locally so far" by running "git fsck".

check_everything_connected is also used in some other circumstances:
e.g. when running a fetch, and when receiving a push in git
receive-pack.

Thanks,
Jonathan
