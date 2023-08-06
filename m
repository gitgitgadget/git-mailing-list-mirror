Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D3C001B0
	for <git@archiver.kernel.org>; Sun,  6 Aug 2023 21:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjHFVtg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Aug 2023 17:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFVtf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2023 17:49:35 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A197
        for <git@vger.kernel.org>; Sun,  6 Aug 2023 14:49:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2B27D3200302;
        Sun,  6 Aug 2023 17:49:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 06 Aug 2023 17:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1691358573; x=1691444973; bh=xN711cMgCXKE66RuJgDRe04AB
        7Sp6DWD4C6d0OrP6z4=; b=gKt2K05LKkPXWqT2ii0M1jgXosRjDr8Dun0dtfmWQ
        xxIHkLu3ChHoh+wbtvLEVLNxsGuP+yq4NcwzMRCadqZvtZFVJYA27VLeZI73jp2Z
        4od8sLrCYgmg/vfGHzeQkAqdkRLxmziz63TqxA4w4CqPSnRdhq/g5L3nvXrb6W/H
        0XXNd8T1vo6WLIeCTHQI4vW4gnIBhzQ4P8VpXmsom8cFWD/1owNRE6qGv3ZmLyzc
        wVjn7vlRScFRbhwS5qzdw2EQaSktTM4lJPHCfq8GEBS2oris0eJhZe/bSPxJZiLS
        L+7T3e7wAM1T/jxPS1vuNsHfnQQz41yBgckdhdCXySoTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691358573; x=1691444973; bh=xN711cMgCXKE66RuJgDRe04AB7Sp6DWD4C6
        d0OrP6z4=; b=Ss/0G2A/ZA5rfc+tKwisfYE+hSGPfRy04isKYo7fUxULuzy3ncm
        uKkSsopr05Sxc4qAZZvVHK5hco2tbp3sypJFnpdHjDG6R2WT7H6o2zkuPDBruRbJ
        FkXwKfs58mrSvcJu27djSnPNcE8PFu9vmtpFQQKWX1qbh2yA6yaaVyTfiOCN0c9V
        fNiu+HYcJfzTZ3XrsqBob5PJZSCtsY2dPhz09L4Dn+BmjMi3i0yTXUZlBmlPF4J8
        HRpH8GnuPB81iTVkf94BIVWd7uVzMz+ovM7rC4eYAWpgqA431/vM7/z6C03w+F3r
        oLPUJRnb7QfRMJAGuIP8FB3yCS5+qI+gn+w==
X-ME-Sender: <xms:bRXQZHvC0c7ly1FiL2A-ddm2qAV3y6FYpyjIh2OJqi8ZkSOsMyWKYw>
    <xme:bRXQZIdsZL-J4nMTtjx47d-UMMmhqitCQfVtLj4MAsxjLbDx57W3oQp2bynk47HmT
    Hh4vy9pya_532en>
X-ME-Received: <xmr:bRXQZKzXF80pEUAagud_J9XrODQxDJNaUxYoB0jYGrLtNzeA1tkZxDgvJBledLK90Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurheptggguffhjgffvefgkfhfvffosehtqh
    hmtdhhtddvnecuhfhrohhmpeeurhhoohhkvgcumfhuhhhlmhgrnhhnuceosghrohhokhgv
    segrlhgthhgvmhhishhtshdrihhoqeenucggtffrrghtthgvrhhnpedvvdejveevhfeiff
    elfefggeeitdejfffgfeelhfetudehgfehjefhteekueegveenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihho
X-ME-Proxy: <xmx:bRXQZGPIXv4qIeayZ2iZDiyoDLRylrSLntxHVM3_K0eljs4HHPw1HA>
    <xmx:bRXQZH8I7Ee0AWQVEJqNlb2fRszayiibLT7vQnOI2aWPrI2aro2qeg>
    <xmx:bRXQZGVUHCc3UShXb9Ev8sVfors4hI6Qv12xlPCc5kYY7A06bBNvbg>
    <xmx:bRXQZEG-L2eW-HFTILn_Uo-chClvVyMfB2DLxgLHi11COfD3Abi0ng>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Aug 2023 17:49:33 -0400 (EDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: Git Commit Notes (fetching/pushing)
From:   Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <ZM/9+YyOAbWWXQtC@nand.local>
Date:   Sun, 6 Aug 2023 15:49:22 -0600
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A1AEE32-4A0C-445D-A1D8-146CDCA03563@alchemists.io>
References: <D01976C3-4B91-464B-ACF0-78DFFB066747@alchemists.io>
 <ZM/9+YyOAbWWXQtC@nand.local>
To:     Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3731.700.6)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Taylor. Thanks. Is there a way to configure the pushing of notes for =
ALL repositories? Basically, I'd like to configure this once (via my =
global Git configuration) and know that notes are being pushed and =
fetched across all repositories without having to configure each =
repository individually.

Originally, I was trying to use my test repository as a proving ground. =
I think I understand why only my notes were being pushed but not sure I =
understand why the default fetch and push refs were overwritten? I =
thought each fetch/push configuration entry was additive but I guess =
that's not the case?

Here's my complete local configuration in case it helps:

[core]
repositoryformatversion =3D 0
filemode =3D true
bare =3D false
logallrefupdates =3D true
ignorecase =3D true
precomposeunicode =3D true
[remote "origin"]
url =3D https://github.com/bkuhlmann/test
fetch =3D +refs/heads/*:refs/remotes/origin/*
[branch "main"]
remote =3D origin
merge =3D refs/heads/main
rebase =3D true

I was hoping to update the remote "origin" as:

[remote "origin"]
url =3D https://github.com/bkuhlmann/test
fetch =3D +refs/heads/*:refs/remotes/origin/*
        fetch =3D +refs/notes/*:refs/notes/*
        push =3D +refs/notes/*:refs/notes/*

...but the addition of the push configuration entry makes it impossible =
to push the feature branch up. Only the notes are pushed, like you said. =
...but I'm missing the connection as to why default branch push behavior =
is being ignored/overwritten. I'm also failing to find documentation on =
why I can't create a branch, add some commits, add some notes, and then =
push all of these changes up (as well as fetch them back down again).

> On Aug 6, 2023, at 2:09 PM, Taylor Blau <me@ttaylorr.com> wrote:
>=20
> On Sun, Aug 06, 2023 at 12:35:50PM -0600, Brooke Kuhlmann wrote:
>> I'm noticing issues with GitHub and GitLab when fetching and pushing
>> commit notes and wanted to know if there is a correct way to =
configure
>> my Git configuration for working with these servers (or maybe notes
>> aren't supported at al)?
>>=20
>> Here's my configuration:
>>=20
>> ```
>> [notes]
>>  rewriteRef =3D refs/notes/commits
>>=20
>> [remote "origin"]
>>  fetch =3D +refs/notes/*:refs/notes/*
>>  push =3D +refs/notes/*:refs/notes/*
>> ```
>=20
> It looks like your refspec may not be doing what you think it is.
>=20
> Here, you set both the default fetch and push refspecs to
> "+refs/notes/*:refs/notes/*" which means to update anything under
> the "refs/notes" hierarchy on either side, even when the updates are =
not
> fast forwards.
>=20
> Since you overwrote the default refspec, you end up only pushing the
> notes, which we see from the response that you got back from GitHub:
>=20
>> remote: Resolving deltas: 100% (1/1), completed with 1 local object.
>> To https://github.com/bkuhlmann/test
>>   5811bd44c32b..0f2422597c5d  refs/notes/commits -> =
refs/notes/commits
>=20
> Indeed, refs/notes/commits is updated on your bkuhlmann/test =
repository,
> which I can fetch from:
>=20
>    $ git remote add origin git@github.com:bkuhlmann/test.git
>    $ git fetch origin 'refs/notes/*:refs/notes/*'
>    remote: Enumerating objects: 41, done.
>    remote: Counting objects: 100% (41/41), done.
>    remote: Compressing objects: 100% (29/29), done.
>    remote: Total 41 (delta 14), reused 34 (delta 7), pack-reused 0
>    Unpacking objects: 100% (41/41), 4.66 KiB | 1.55 MiB/s, done.
>    =46rom github.com:bkuhlmann/test
>     * [new ref]           refs/notes/commits -> refs/notes/commits
>=20
> I suspect you want an additional refspec that gathers any branches or
> tags that you want to push along with refs/notes/*.
>=20
> Thanks,
> Taylor


