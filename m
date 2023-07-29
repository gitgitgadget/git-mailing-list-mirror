Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B8AC0015E
	for <git@archiver.kernel.org>; Sat, 29 Jul 2023 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjG2QSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jul 2023 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjG2QRz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2023 12:17:55 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0163A9C
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 09:17:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C0CBD32002F9
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 12:17:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 29 Jul 2023 12:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=masklinn.net; h=
        cc:content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690647472; x=1690733872; bh=7B
        yK40rr3mvB5gOE1YOI4lSBxqqwXV1d6FmK2yFQWWQ=; b=P4kGr+fmY3pQ9z6ZxD
        yUSCdnqaBJDY0ERDJVgrDdIWcSZMV8up4Vdc6E7NySrze3iEaYUu2oHXoyOVSmWU
        VIca3XKFqtXGs/Sa56NtpmKEoi5GsgDfV4fVDOExMq8Z1OFJE+4Cl6eJ671aT8M1
        xYMRhAX0wBFMtgeh1l8L05/e9lJiE7rm/MSD58t92r4thLxWyrD5adP8vJGD92TA
        rM5uFMn5ercSiO/Kv2OjN55sFjSL44Syo2eXkB+Sutm4s4o9ljq4BoxaAdn+QsnA
        zW60WfLT9BEosUKwjdTIKKZfCQtNGCFgvfGJEx5nBiFySjsZ8FjH4k6mfSXjajX0
        hyzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690647472; x=1690733872; bh=7ByK40rr3mvB5
        gOE1YOI4lSBxqqwXV1d6FmK2yFQWWQ=; b=PgodVhow3xj6me3gOV+TfV1Z8TDGJ
        kdr/dJ2aZ3q5YRMhOXSUlaea1Cat1dFUO/xmQu8RvOL9RFAphFdRVCBT2WbJssL6
        uFCNUQANYNRMXmPGL9E41fMVZVYBghGE2AN48zbtyYaNPyRCe07eOApVA0z6id1M
        pnPU35jPQoNrqy0z50QsTE6ANCg6s172jIh5qfEXa0mX3CHvNQTOdaFjjjnVg13/
        31QM8WSQUprUwgTIgjaSmSSmirvhQsSKOjYwFVytdJzJ6WEZqnX5CK/LzUZuHgWZ
        +dbptDj4pbhROLDdgTDMEKjr8bavdGCM8Y1LqKWPaE4Wq5ypRhRx9y+Tg==
X-ME-Sender: <xms:sDvFZH1ULRwJ9pWt2CAMG-0Civu7SpvPkA_JeR2YKGiD3_C33Q65Yw>
    <xme:sDvFZGFjZ0oPfKz_dtSmYCqrpeTA3tRFOYWCOEvgTzGOv4bznrqndKbf8-WTwRU5k
    xnqQYGnQI_FjzcOu6s>
X-ME-Received: <xmr:sDvFZH7OGkT29_uTibHCv82kA2X6FAFL8o1RZ6G_y9bK3bUuCwFFvffkYFYu4MOK_AHwCVehVwUr86ew4qtnI1vvjW9V6IRYT_AqqRVVXelXQQHzFAhh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieekgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthh
    dtjeenucfhrhhomhepiggrvhhivghrucfoohhrvghluceogigrvhhivghrrdhmohhrvghl
    sehmrghskhhlihhnnhdrnhgvtheqnecuggftrfgrthhtvghrnhepgeeggfelveevgeetje
    etiefgheelgfeuteetffeiheduveekkeefheejteevvdelnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgigrvhhivghrrdhmohhrvghlsehmrg
    hskhhlihhnnhdrnhgvth
X-ME-Proxy: <xmx:sDvFZM2L-vkwCBPCR9v37LKRSZBN8Dt1LlbRqQYadMPPqW29ABrrwQ>
    <xmx:sDvFZKF4h2zgZKDUXefIMFdQBaUEVGcJhfMvsx5vdnjdNDA5yRSxuQ>
    <xmx:sDvFZN-eYT-71Mvq7dJxHrU3gouod3O3-lcOlNaRv3rm_AIQ1qwT5g>
    <xmx:sDvFZFxB1tnwwcpxexDi6zX-o3HfW_wt9GjYbIXpuvxmLat0MSi4SQ>
Feedback-ID: i3619468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sat, 29 Jul 2023 12:17:51 -0400 (EDT)
From:   Xavier Morel <xavier.morel@masklinn.net>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: fsck: various diagnostics never triggering
Message-Id: <305BF2BA-6F33-4C34-8E2F-DB194AC38C2C@masklinn.net>
Date:   Sat, 29 Jul 2023 18:17:48 +0200
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First I'd like to thank John Cai for the work of collating the fsck
msg-id, figuring out what to look for is much easier when it's all in
one place.

While looking at git's handling of invalid objects (again) I found out
that several documented fsck diagnostics can not fire =E2=80=94 and
furthermore have somewhat debatable diag levels =E2=80=94 because they =
trigger
a parsing error upstream from the fsck code which actually checks the
relevant properties.

Some of them are actually present in t/t1451-fsck-buffer.sh but I'm
not sure if that is relevant in any way.

The testing / checking was done with Git 2.41.

------

    emptyName (WARN) A path contains an empty name.

`fsck_tree` ultimately calls `decode_tree_entry` which fails (returns
-1) if the mode is invalid (e.g. the mode is immediately followed by
\0) or the path is empty. In fsck_tree, this translates to a generic
`badTree` error.

Also not sure how relevant that is, but a badTree error yields a lot
of spam e.g. when specifically fsck-ing the broken tree I get:

    error: empty filename in tree entry
    error in tree {oid}: broken links
    error: empty filename in tree entry
    error in tree {oid}: badTree: cannot be parsed as a tree
    error: empty filename in tree entry

but for the specific error message, this reproduces for every
error which results in a "badTree" (mode is empty, mode is
invalid, oid is too short, oid is too long, tree object is too
short).

It's possible that part of it is an artefact of my test setup e.g. I
get this if I fsck the object specifically (passing its oid to "git
fsck"), asking fsck to check the repository rather than the specific
object seems to remove the last message in the sequence.

    missingTree (ERROR) Missing tree line in a commit object.

If a commit has no `tree` line, or a `tree` line which is not 45 bytes
long (excluding newline), fsck reports

     error: bogus commit object {oid}
     error: {oid}: object could not be parsed: {path}
     error: {oid}: object missing

but no missingTree.

    badTreeSha1 (ERROR) A tree has an invalid format.

If a commit has a tree line which is 45 bytes long, but the last 40
bytes are not a valid hex string, fsck reports

     error: bad tree pointer in commit {oid}
     error: {oid}: object could not be parsed: {path}
     error: {oid}: object missing

    badParentSha1 (ERROR) A commit object has a bad parent sha1.

Here whether the parent line is too short, too long, or not hex, fsck =
reports

    error: bad parents in commit {oid}
    error: {oid}: object could not be parsed: {oid}
    error: {oid}: object missing

-------

Finally at least one diagnostic seems to have an incomplete =
documentation:

    fullPathname (WARN) A path contains the full path starting with "/"

but the code uses "strchr" on the name, so it checks if the name
contains a "/" anywhere. The message is also not the best:

> contains full pathnames

-------

There is also a minor inconsistency in the authorship date parsing:

    0+0000

triggers "zeroPaddedDate", but=20

    1+0000

triggers "badDate".

I assume that is because the code first checks if the date is a 0
followed by a non-space (assuming it's zero-padded), and only after
that does it check if the timestamp is followed by a space.

This is probably too minor an issue to bother complexifying the checker
though.=
