Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABBEC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 06:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiFGGZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiFGGZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 02:25:40 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B78C9677
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 23:25:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg6so13257768ejb.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 23:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BLyVOYbc64fUAptGgklb3t4gICdmxX14L8rwP1bcsLg=;
        b=BmhBfoY44UBT4EyHGA7/14BtsLObTfxfSvBR6XbbpmOB0GVJFXliARMCeeNs79uQZj
         aKje1eYRnke56hg8vJMC6/T+wFeaIcK5gMTkv6hKWXstVq0JDw7TOi4VRR1wQrnlfeJd
         efg3Q4av6Se13YQ3PZwAQ4JfdJQZOn4677SJfs93IJdkWfOf6kY+1dcSjLER5hDX6ioQ
         JFDuZHWNXcWXBqAIvqYAdL/NqpwJADjTleXVMG9jJXm3SE/aZuACulil52/J9mqkvhQf
         2Mr21qv6/2qgWGMlZ7H6rTkrNNOcvhP1wPa/H+E/bHCNLpVwEbG5gv8h3X8YcFLo3r/Z
         u3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BLyVOYbc64fUAptGgklb3t4gICdmxX14L8rwP1bcsLg=;
        b=WENNxg+/cD2C//NdHcRJuhfkKhV0xLKeYbsp7RFV7VRguevmSPgmC0wij1HeLYXrqe
         iXAMRnyrfBld/4iLfAk/6m74MCclstJ/cObQ6VhLUTnPZ6L2IS+ZyHS+CwRrUBsN5BMM
         Tl7wmjDcifMF9c7G/vNllUNNu0XQyTcM1kYBIb87iILsOe4P2+zw3gjjbELSpXdIyD4f
         UKR3rK2SH5M6RU5eT7SWebC3O775d9NSI+wazhBTJv/G9HU44yQb+q0KdM+XxE2WipZ6
         HHnK3Z8bo0cued0sOWQROY8xveKtarSr64vCSm7GsCTU+efeSoEnfktCUPMZnx1PQH1m
         hqqg==
X-Gm-Message-State: AOAM531m0YZtA8RteyDNmKtPvekFlqPw6rz1Gg2NfvxXl/+znxk8rqQ2
        pfSwb4re9yHP47pjP0bbpgA4iMCZ9N+gzsw3j9k=
X-Google-Smtp-Source: ABdhPJzgLZy3Jqel3n25RWjesSnECDATMjRlk5MG0ye2Jncr2TaO6ieQTuhC/mQuxELaQYeR9LS8xLzY6ycSkrQFxrY=
X-Received: by 2002:a17:906:a245:b0:708:ce69:e38b with SMTP id
 bi5-20020a170906a24500b00708ce69e38bmr25176674ejb.100.1654583137124; Mon, 06
 Jun 2022 23:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Jun 2022 23:25:25 -0700
Message-ID: <CABPp-BEOV53oBoBp4YjiRfksZMmAADanZUUemhxwn7Wor=m-nA@mail.gmail.com>
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 3, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is a feature I've wanted for quite a while. When working on the sparse
> index topic, I created a long RFC that actually broke into three topics for
> full review upstream. These topics were sequential, so any feedback on an
> earlier one required updates to the later ones. I would work on the full
> feature and use interactive rebase to update the full list of commits.
> However, I would need to update the branches pointing to those sub-topics.
>
> This series adds a new --update-refs option to 'git rebase' (along with a
> rebase.updateRefs config option) that adds 'git update-ref' commands into
> the TODO list. This is powered by the commit decoration machinery.
>
> As an example, here is my in-progress bundle URI RFC split into subtopics as
> they appear during the TODO list of a git rebase -i --update-refs:
>
> pick 2d966282ff3 docs: document bundle URI standard
> pick 31396e9171a remote-curl: add 'get' capability
> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
> pick 6adaf842684 fetch: add --bundle-uri option
> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
> exec git update-ref refs/heads/bundle-redo/fetch HEAD 6c5840ed77e1bc41c1fe6fb7c894ceede1b8d730
>
> pick 1e3f6546632 clone: add --bundle-uri option
> pick 9e4a6fe9b68 clone: --bundle-uri cannot be combined with --depth
> exec git update-ref refs/heads/bundle-redo/clone HEAD 9e4a6fe9b68a8455b427c9ac8cdbff30c96653b4
>
> pick 5451cb6599c bundle-uri: create bundle_list struct and helpers
> pick 3029c3aca15 bundle-uri: create base key-value pair parsing
> pick a8b2de79ce8 bundle-uri: create "key=value" line parsing
> pick 92625a47673 bundle-uri: unit test "key=value" parsing
> pick a8616af4dc2 bundle-uri: limit recursion depth for bundle lists
> pick 9d6809a8d53 bundle-uri: parse bundle list in config format
> pick 287a732b54c bundle-uri: fetch a list of bundles
> exec git update-ref refs/heads/bundle-redo/list HEAD 287a732b54c4d95e7f410b3b36ef90d8a19cd346
>
> pick b09f8226185 protocol v2: add server-side "bundle-uri" skeleton
> pick 520204dcd1c bundle-uri client: add minimal NOOP client
> pick 62e8b457b48 bundle-uri client: add "git ls-remote-bundle-uri"
> pick 00eae925043 bundle-uri: serve URI advertisement from bundle.* config
> pick 4277440a250 bundle-uri client: add boolean transfer.bundleURI setting
> pick caf4599a81d bundle-uri: allow relative URLs in bundle lists
> pick df255000b7e bundle-uri: download bundles from an advertised list
> pick d71beabf199 clone: unbundle the advertised bundles
> pick c9578391976 t5601: basic bundle URI tests
> # Ref refs/heads/bundle-redo/rfc-3 checked out at '/home/stolee/_git/git-bundles'
>
> exec git update-ref refs/heads/bundle-redo/advertise HEAD c9578391976ab9899c4e4f9b5fa2827650097305
>
>
> The first two patches are helpers that are needed, but the full logic of the
> --update-refs option is introduced in patch 3. The config option is
> available in patch 4.

Very interesting; nice to see that others are thinking on a similar
wavelength.  I've got some related work in git-replay, and it heavily
uses update-refs style handling.

Not sure if there are any differences worth affecting your design or
mine, but perhaps it's worth mentioning my current work and plans in
git-replay related to the use of update-refs:



Since git-replay doesn't touch the working tree or index, I had the
natural question of what the output should be and whether ref-updates
should automatically happen.  I decided that like git-merge-tree, ref
updates should not be automatic (and thus it behaves somewhat like a
"dry run" version of rebase/cherry-pick).  Since I also want to
intrinsically handle replaying multiple branches simultaneously, the
update-ref style output seemed like a natural fit to me (meaning users
would pipe the output from git-reply to git-update-ref).  Thus, one
can do:

    $ git replay --onto main startpoint..mytopic

and see git-update-ref style output:

    update refs/heads/mytopic ${NEW_mytopic_HASH} ${OLD_mytopic_HASH}

where ${NEW_mytopic_HASH} is the commit at the tip of a chain of
rebased mytopic commits.  (Sidenote: There's the question of whether
to update 'main' (i.e. cherry-picking) or 'mytopic' (i.e. rebasing);
thus, users have to choose --advance vs. --onto to specify which of
these should happen, except in cases where it can be implicitly
determined.)

Or, if you have several branches to update:

    $ git replay --onto main ^startpoint mytopic1 mytopic2 mytopic3

and see

    update refs/heads/mytopic1 ${NEW_mytopic1_HASH} ${OLD_mytopic1_HASH}
    update refs/heads/mytopic2 ${NEW_mytopic2_HASH} ${OLD_mytopic2_HASH}
    update refs/heads/mytopic3 ${NEW_mytopic3_HASH} ${OLD_mytopic3_HASH}

(and yes, common commits from before will be replayed and then shared
by the new branch versions.)

If the topics are totally contained within each other, you can do this
more simply as

    $ git replay --contained --onto main main..my_tip_topic

and still see all the update commands:

    update refs/heads/mytopic1 ${NEW_mytopic1_HASH} ${OLD_mytopic1_HASH}
    update refs/heads/mytopic2 ${NEW_mytopic2_HASH} ${OLD_mytopic2_HASH}
    update refs/heads/mytopic3 ${NEW_mytopic3_HASH} ${OLD_mytopic3_HASH}
    update refs/heads/my_tip_topic ${NEW_my_tip_topic_HASH}
${OLD_my_tip_topic_HASH}

The option to list several refs provides a natural way of allowing
users to control what gets updated without updating all contained
branches, though rebase's implicit ranges doesn't really have a nice
analogue for you due to its implicit range handling.

Right now, git-replay doesn't handle conflicts (it just die()s).  That
and a few other thing are still TODO.

However, git-replay does already handle basic replaying of merges,
including ones with evil changes (so long as none of the merges
involved have conflicts).  So, I'm hoping git-replay will also useful
for stuff like:

   $ git replay --first-parent --interactive --onto next ^next
special_topic seen

where special_topic is one of the topics previously merged into seen.
This last commit would allow seen to be rebuilt with some changes to
special_topic.  Basically, it makes whatever interactive changes are
specified to special_topic followed by replaying all the merges in
next..seen (including any necessary conflict resolutions or other
semantic changes recorded in the merge commits being replayed), unless
those .  However, I do need to figure out some syntax for keeping
special_topic from being transplanted onto next here...
