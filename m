Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B1B1F424
	for <e@80x24.org>; Fri, 30 Mar 2018 11:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeC3LKP (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 07:10:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37385 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC3LKO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 07:10:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id l49so7783974wrl.4
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2yIDjSram/PKL0Urkglz/b4BWK4PQ29xrzOy3MNewIc=;
        b=Ws3Ip4u+VSCy+gvvMFQ8WZ4c/J3crAyHGSk90GXl56k/n8b76eqP7DPQ46PMnucIC3
         mXITxqrXPzVXkIdzmrfun5TGJJv2YrHtEx8X7awK5NsrjJcwGXl8u8Pjp3veKt1+E3dH
         qzQja7WIBORRuT4ZlX9/uTsgmiS8Hgx4rAqb5U4CXJFvA0S7qvVLRPThvjmaeaFcU7G9
         ZAiteWkQeHtNtTAPTgCzbJ4VOVY+LZpDlMkaUwaj9B1PpDpLeSYwRzltRtyofD/TaYmZ
         ulrmtR7eOrPfMCjbGe0aE/gGU3XUNsia1QNgWsEd35IsT3/Qw5WCNWcTK7kLXfBq+kV1
         /KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=2yIDjSram/PKL0Urkglz/b4BWK4PQ29xrzOy3MNewIc=;
        b=to+2bL8Pqb4X3yzRcz8FAbuLiAbxZ/WXGS/lZLR6ajfIrsS1Nl0tZZ0T5zkTWTrwtT
         1E7oIhsGH7QfB3OopvMe7IbEX8kBhwASrawrjW4FyoeQyPtvkZ3DTPpZC1ZfdMIwUF/E
         +VAlaFbLtXWQW/MrV2C4tANeHtewp+mk0YvhGgKmnugxMFZ9Sh+2QEZKM55G8Eo5LgFs
         uGKdF0HvvKTvopGeXDM2XsUpacmbiMi6PWmwXCpCQet9Vo1PN9fjzy9N28/kiluR/6IR
         zrG4UtQdkl6IFP34QGvcrgZpNiJtAfPfoBsImOAhnSWEZt+J3HzkIo+V5scFxriVlocJ
         pPeA==
X-Gm-Message-State: AElRT7ELbuyRfvOak29xqTdHKPiX9Mos7Q6o4zvJeVHS0lrwS0uzC/Mq
        92Hzc29pVYPJ/DNVpv52BBY=
X-Google-Smtp-Source: AIpwx4+ZsCVZFYBq1CHKwZYxsV/bhxzdBakU+Vgaer40VbHWSKqd19iOV65iojvqVwY+CfOND5a8kw==
X-Received: by 10.223.182.132 with SMTP id j4mr9325127wre.66.1522408213156;
        Fri, 30 Mar 2018 04:10:13 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (agd201.neoplus.adsl.tpnet.pl. [83.25.159.201])
        by smtp.gmail.com with ESMTPSA id 6sm2315329wmd.40.2018.03.30.04.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 04:10:11 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 00/13] Serialized Git Commit Graph
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
Date:   Fri, 30 Mar 2018 13:10:05 +0200
In-Reply-To: <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:13 -0500")
Message-ID: <867eptkeeq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hope that I am addressing the most recent version of this series.

Derrick Stolee <stolee@gmail.com> writes:

> As promised [1], this patch contains a way to serialize the commit graph.
> The current implementation defines a new file format to store the graph
> structure (parent relationships) and basic commit metadata (commit date,
> root tree OID) in order to prevent parsing raw commits while performing
> basic graph walks. For example, we do not need to parse the full commit
> when performing these walks:
>
> * 'git log --topo-order -1000' walks all reachable commits to avoid
>   incorrect topological orders, but only needs the commit message for
>   the top 1000 commits.
>
> * 'git merge-base <A> <B>' may walk many commits to find the correct
>   boundary between the commits reachable from A and those reachable
>   from B. No commit messages are needed.
>
> * 'git branch -vv' checks ahead/behind status for all local branches
>   compared to their upstream remote branches. This is essentially as
>   hard as computing merge bases for each.
>
> The current patch speeds up these calculations by injecting a check in
> parse_commit_gently() to check if there is a graph file and using that
> to provide the required metadata to the struct commit.

That's nice.

What are the assumptions about the serialized commit graph format? Does
it need to be:
 - extensible without rewriting (e.g. append-only)?
 - like the above, but may need rewriting for optimal performance?
 - extending it needs to rewrite whole file?

Excuse me if it waas already asked and answered.

>
> The file format has room to store generation numbers, which will be
> provided as a patch after this framework is merged. Generation numbers
> are referenced by the design document but not implemented in order to
> make the current patch focus on the graph construction process. Once
> that is stable, it will be easier to add generation numbers and make
> graph walks aware of generation numbers one-by-one.

As the serialized commit graph format is versioned, I wonder if it would
be possible to speed up graph walks even more by adding to it FELINE
index (pair of numbers) from "Reachability Queries in Very Large Graphs:
A Fast Refined Olnine Search Approach" (2014) - available at
http://openproceedings.org/EDBT/2014/paper_166.pdf

The implementation would probably need adjustments to make it
unambiguous and unambiguously extensible; unless there is place for
indices that are local-only and need to be recalculated from scratch
when graph changes (to cover all graph).

>
> Here are some performance results for a copy of the Linux repository
> where 'master' has 704,766 reachable commits and is behind 'origin/master'
> by 19,610 commits.
>
> | Command                          | Before | After  | Rel % |
> |----------------------------------|--------|--------|-------|
> | log --oneline --topo-order -1000 |  5.9s  |  0.7s  | -88%  |
> | branch -vv                       |  0.42s |  0.27s | -35%  |
> | rev-list --all                   |  6.4s  |  1.0s  | -84%  |
> | rev-list --all --objects         | 32.6s  | 27.6s  | -15%  |

That's the "Rel %" of "Before", that is delta/before, isn't it?

> To test this yourself, run the following on your repo:
>
>   git config core.commitGraph true
>   git show-ref -s | git commit-graph write --set-latest --stdin-commits
>
> The second command writes a commit graph file containing every commit
> reachable from your refs. Now, all git commands that walk commits will
> check your graph first before consulting the ODB. You can run your own
> performance comparisions by toggling the 'core.commitgraph' setting.

Good.  It is nicely similar to how bitmap indices (of reachability) are
handled.

I just wonder what happens in the (rare) presence of grafts (old
mechanism), or "git replace"-d commits...

Regards,
--=20
Jakub Nar=C4=99bski
