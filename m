Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD68BEE14C0
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 17:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjIFRbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 13:31:38 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09195199B
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 10:31:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id D8C743200805;
        Wed,  6 Sep 2023 13:31:31 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 06 Sep 2023 13:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694021491; x=1694107891; bh=vSHIRCKJ4UXdLoaX37xItFzD+
        jV36VrPlruNtlblEfw=; b=JjyeSyfyGh5GIn0/Yzv9d3LWFZXmftY6siwYfMo9D
        2nwFz3P4hqrkdMETwFnbg6ZH1/UkT+l2wLrbCpdDfKZY+AMo2JO2rXnxg2QYGouk
        bobsYaNuw11ng6WL7KWpJtK0jwfPclZVKPDRxjccekByp+73VxnVqV9b+c6zfQ0w
        fJ6HCZ/ucouhtq1lsNIwGZzZbBTfFHpnVDUexoycLkFnScljE/fgcOm/zbZ+wjp0
        aRa9D84yrKp7I4mXLku4cGzUilh5eiCeUaAR1VlTHlbY5jkAKOoOVdKKvh5wkU5Y
        FAr09GFnsH8T6eUgWczvawWQQ5IlR8uu6EAhRAaQX4EYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694021491; x=1694107891; bh=vSHIRCKJ4UXdLoaX37xItFzD+jV36VrPlru
        NtlblEfw=; b=toe1o+CYUIxnPJd3me+IXPSJzOXW29BPz1qNbctjZR8Q3VIb6s4
        OUJ7JMqhlvTPxuWeGvvFK7sqpOoCjirB0bUCSa06XhCIRfHajU5NJeUf4Qk/ReTB
        ltU8oo5cwKdUC9tTddjwMdcxbK6FA1qZzDyAMXCChOEV3dgxIgTxv6+sHLLDdE0z
        zD+ZOdbycrC8and5KOVjCkm/b0R99GEfAHaRYfhCtB3tQKuFrXHkYIW9P3F02Pt5
        3QTKPmFi1v6kC72xkWsKIpWzTp4qyMt4nGsMiY3WhbTn+65C7xL+TR/SwFGDbWpA
        GL48GER0ynBCNUSrhdd51Zsfx4TjebQslfA==
X-ME-Sender: <xms:crf4ZNs4Qa4j5REkHrTkgFbDo9cxgdhXCjuTDU0ieerTv0megeR_ew8>
    <xme:crf4ZGcTtGZ9aLxN2qMWU69FHcO3IDmBvHdc9aiX-401sXh-gdiSyConlbTZqyrCf
    sLa1vLOmXDaccsZRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:crf4ZAwlb7BsS7os6AKrCw8IXkvzoj82k2QzUmqUFqih-VI9UZveWg>
    <xmx:crf4ZEP6js5qfBUey6PJX9pX-NObMIcU5I13rOBqlQrt919qNdZG7g>
    <xmx:crf4ZN-EwHMFjiNGNBk46NoxkRS5FvHXN6Y3Tj4F9uDXtqzvwCS0ZQ>
    <xmx:c7f4ZJZGAqZryyGqZERpasjFZ9MI1sx3g5c4MIJBcP-JjEJrJHOkvw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0A88715A0091; Wed,  6 Sep 2023 13:31:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <f782d554-d588-467e-806f-420549ed2f5a@app.fastmail.com>
In-Reply-To: <CAPMMpogm2tr0dy1nsV9NtF4O8-JS=_L3J0+yKRc7KbyAJ-PNbQ@mail.gmail.com>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <CAPig+cTeQDMpWQ-zCf6i9H-yhrdCndX6gs67sypuqmHZZcHm7w@mail.gmail.com>
 <xmqqedjdtoh5.fsf@gitster.g>
 <CAPig+cRJhrGmnBRm2dporcXiRr4SzRmpM2LTMm0S7wo0XbOU9Q@mail.gmail.com>
 <xmqqmsy0slei.fsf@gitster.g>
 <CAPMMpogm2tr0dy1nsV9NtF4O8-JS=_L3J0+yKRc7KbyAJ-PNbQ@mail.gmail.com>
Date:   Wed, 06 Sep 2023 19:29:27 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Tao Klerks" <tao@klerks.biz>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap error in
 git gc.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2023, at 18:25, Tao Klerks wrote:
> Fwiw, Eric's reading was my intended one. The people I have spoken
> with, as well as myself, have started using "git worktree" by doing
> the former, and only later felt really transgressive when placing the
> worktrees explicitly on a higher level, on equal footing with the
> "main worktree". To me it seemed natural that the "nested worktrees"
> approach was the expected one, as otherwise it gets even harder to
> explain/justify the operational difference between the "main worktree"
> and the other worktrees - then leading to the bare+worktrees approach
> to eliminate that operational difference.

Let's consider a use-case that `git-worktrees` can replace: just cloning
the repository again to do some particular task.

My coworkers have to work on some branch `divergent` which requires a
complete rebuild of the project compared to the main branch. But they al=
so
need to work on small derivative branches of the main branch. In order to
not rebuild all the time they simply cloned the project again and work in
*that* repository when working on `divergent`. And since this is an
Intellij project it was cloned in the same directory as the original
clone.

Replacing this use-case with `git worktrees` would be:

    git worktree ../divergent-project

In this case, `git worktrees` is a more streamlined and better version of
cloning a separate repository:

1. Only one object store
2. No need to remember to fetch from both
3. No risk of forgetting that you have some n-iary clone on your machine
   with original work

But crucially they also had the luxury of just cloning the project again
since it is less than 1GB; people with larger repositories (like
yourself) might have to immediately use the streamlined approaches like
`git worktree` since the straightforward approaches are too costly.

So I think the sibling directory tree makes sense when you arrive at this
command/workflow from the brute-force approach. But maybe that's not the
case when you have to design the proper way of doing it up-front(?)

> Is there a manual for "expected typical usage of git worktree" somewhe=
re?

The example in =E2=80=9CDescription=E2=80=9D of `man git-worktree` uses =
a sibling
directory: `git worktree ../hotfix`.

>> Even though deriving the worktree(s) from a separate and protected
>> bare repositories does protect you from total disaster caused by
>> removing "rm -fr" and bypassing "git worktree remove", it still
>> should be discouraged, as the per-worktree states left behind in the
>> repository interfere with the operations in surviving worktrees.
>
> Right, that's fine. Of course you're going to encourage deleting the
> worktrees carefully... but equally of-course, some people *will* do
> "rm -fr that-worktree-I-dont-know-how-to-clean", and when they do,
> telling them "just 'git worktree repair'" is much easier than telling
> them to "recover deleted files 'cause your local branches just
> evaporated"
>
>> Teaching folks not to do "rm -fr" would be the first step to a more
>> pleasant end-user experience, I would think.
>
> The less arcane trivia you *need* to teach users for them to be
> effective, the better the experience is for everyone.
>
> The fact that "deleting a standalone git repo only deletes what's in
> that standalone git repo the way you've done your whole life, but in
> this environment what look like multiple repos are actually
> 'worktrees', if you ever delete one your life *might*, if you choose
> the wrong one, suddenly be very unpleasant" is arcane trivia, in my
> opinion. Better to set things up so they *can't* shoot themselves in
> the foot with a bullet of that caliber.

I don't see how the principle of respecting the level of abstraction
doesn't apply here.

Before you might be able to delete a branch `b` by doing `git rm
.git/refs/heads/b` and be content when that either finishes successfully
or when it complains that the file doesn't exist; you can feel confident
that there is no more `b` branch. Now though the ref `b` might be a
*packed ref*, so you cannot do that and be sure that the ref was removed.

So if you create a worktree with `git worktree`, you should probably
remove it with the same command.

(Am I missing something? I probably am. I might not have understood the
context for wanting to run rm(1) on these directories.)

Personally I like to conceptualize worktrees as having equal status to
each other as far as me (the user) is concerned, since there isn't
anything you can do in the main worktree=E2=80=93or at least I haven't f=
ound
anything like that=E2=80=94that I *can't* do in a worktree *at that leve=
l of
abstraction* (directly manipulating files in the `.git` or
`repository.git` directory doesn't apply to this level of abstraction, so
that the linked worktrees only have a gitfile is irrelevant here).

--=20
Kristoffer Haugsbakk
