Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A3FEC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjIGUMR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIGUMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:12:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A05E47
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:12:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D3A965C01C8;
        Thu,  7 Sep 2023 16:12:09 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 07 Sep 2023 16:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694117529; x=1694203929; bh=jkSzkI6Ki369aUeTsDlI7G/vE
        4reluPKbHJjrjo/4o8=; b=W4cUZNd7eFL17Xe7eZkWToibycuKgs8ojjO7nS0yZ
        eHfuwV2ZJT5z44bCdnR4FcwR9lBF3cASGPbv8i3OSqqQ14n8jPiZBVSnnqvNBBe8
        DBetzTU4gcY+N7ou1eq69Ed7uUVNOmUhNNMqOfWFYqfjOQyyIjk4gMf1eBQyc7Xn
        V5vBDLrtyY07X/enkuATRZFdTVnZ3IJKmKVXbqVs17NlANGdDVxi1O26aBFK25HH
        QAVtNGt2zR6QoCH3DBauZVC12ZrCZGX3fe/LIHzfLk6RzoNq6NpdLdTGoPsfbQHx
        Ebj1n9REZFA/dakBAMRAwKyEJZZ27A9bYsvF1a+eBHa0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694117529; x=1694203929; bh=jkSzkI6Ki369aUeTsDlI7G/vE4reluPKbHJ
        jrjo/4o8=; b=DXfF2JGWGUP9kAdmYb8HJomZP00mu6CG/UXgBS2eX0mYrwJUFMo
        gvG/6xIzKbxI3J3j4LdpuwXqjNh/6EiDh4bOcu8pJa99Xpb5P6LuATrzt1iINzfZ
        417OEa+3yLKC7VmZ9/0gyxG4JRFsgraXNkBDvPQecq65p7r6LyfAbyGhHx/TNRa5
        cvn9wX5yUxo8Y0FZCYVWQ/tNX7u92l1VuyQYPniNZDUpBoTXqCTqtlS2TpRXSI9F
        GfE53VKfMaCRNfB3a0VP3FdhsXVM7BD2KR8zF3fAheUw4iLDNp04VtfBKKEu7GT6
        WzhOYsU6LHyQ97K7FGh7SdopZa72SfaT6GA==
X-ME-Sender: <xms:mS76ZD0S8fhz338bAu3SXwChpeCTDUPUsqHAmOaJBeXh6SEi5yiGslI>
    <xme:mS76ZCGuOZMiUJlpR6KWUdMWOwUiVtExE3uK_up9LuZOYNujEaouNiCJQD-hx3Hle
    X-ZXcNvYopHvL4p9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:mS76ZD4izZ2f-u-6FCACDKj1287hSt7tbrLP7bRtA_Wfn-HN_znO5Q>
    <xmx:mS76ZI20JhfqFs0K9RRpjVWU1QjafVJpi58_fdlV6ZxHdzhvqzERQA>
    <xmx:mS76ZGFS8ZUzQIq91Kwbz_rGG81UzcbqV53FpRV1kZIJAiIvqY-KRA>
    <xmx:mS76ZDOQijFbvhrs59Yc5XLRTLIu3DS5YndeYb_7jPvMNk1v9ywqQg>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F087415A0092; Thu,  7 Sep 2023 16:12:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <d65e5407-df82-4a86-8050-854caf0f8058@app.fastmail.com>
In-Reply-To: <CAPMMpojTLswqubRk0Ly3RQqkrnpx_9Hiu_TRK1=ASPbPNz4ApQ@mail.gmail.com>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
 <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
 <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
 <87edjbuugw.fsf@osv.gnss.ru>
 <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
 <CAPMMpohgkH3h1zC_Q7O-07gYw8_7mdSsyX7vu1K1u5+CxKUaUQ@mail.gmail.com>
 <xmqqledjm4k2.fsf@gitster.g>
 <CAPMMpojTLswqubRk0Ly3RQqkrnpx_9Hiu_TRK1=ASPbPNz4ApQ@mail.gmail.com>
Date:   Thu, 07 Sep 2023 22:11:48 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Tao Klerks" <tao@klerks.biz>
Cc:     "Sergey Organov" <sorganov@gmail.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap error in
 git gc.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again Tao

On Thu, Sep 7, 2023, at 06:53, Tao Klerks wrote:
> I've definitely changed my mind about "inline", I agree "main" is
> better. I'm not convinced it's the best word we could come up with,
> but if it's well-established, I'm happy with it.

Note that the conversation was forked:

1. New nomenclature to describe things more precisely
2. How good those words in themselves are at describing these things

I liked =E2=80=9Cinline=E2=80=9D since it helped to clarify the case of =
a bare repository
with linked worktrees. Sure, emphasizing that it has no =E2=80=9Cinline =
worktree=E2=80=9D
might be redundant (it can be inferred, perhaps), it's nice to be able to
emphasize things for pedagogical purposes.

(I'm less sure if =E2=80=9Cattached=E2=80=9D is needed.)

This is what we can say for certain about a repository:

=E2=80=A2 There definitely is a repository somewhere (maybe not in whate=
ver
  worktree you are in right now though)
=E2=80=A2 It has zero or more worktrees

So =E2=80=9Cmain worktree=E2=80=9D is optional. And that optionality mak=
es things awkward
since it also used to describe where the repository lives=E2=80=94even w=
hen the
repository has no *inline worktree* (it is bare).

The bottom line is that it's nice if one can avoid having to get into
situations like this made-up conversation:

A: =E2=80=94 I'm in the deployment worktree now. Where's the main
  worktree in our workflow? [I don't know how to use `git worktree`]
B: =E2=80=94 That's `repository.git`.
A: =E2=80=94 Okay nice. Is that worktree used for the mainline developme=
nt?
B: =E2=80=94 No, it has no worktree. It's bare.
A: =E2=80=94 What? But didn't you say that it was the main worktree?
B: =E2=80=94 Yes, in the sense that it's where the repository is. But it=
 has no
    worktree itself.

>> We can read that (1) a non-bare repository itself is considered
>> its "main worktree", (2) a bare repository, by inference, has no
>> main worktree (otherwise we wouldn't have said "if it's not"), and
>> (3) both bare and non-bare repositories can have linked worktrees
>> (again, otherwise we wouldn't have brought up a bare repository in
>> the description).
>>
>> Perhaps we should borrow it to update the glossary, like so?
>>
>
> Looks good to me, but that leaves me with a different nitpick: we say
> 'One "worktree" consists of a "working tree" and repository metadata,
> most of which are shared among other worktrees of a single repository,
> and some of which are maintained separately per worktree'
>
> This claims that the *shared metadata* (presumably the refs, the
> branch reflogs, the objects, the config, etc) are *part of the
> worktree* (a worktree "consists of" them and other things). That seems
> like a very strange way to conceive of things, to me.
>
> I would find it reasonable to state that the main worktree is part of
> the repo - certainly that's now most everyday users would think of it,
> if they were made to think of the worktree concept at all - but not
> that the shared repo metadata is part of the worktree, and especially
> not that the shared repo metadata is part of the attached worktrees.

Without getting into the subtle distinctions between is-a and has-a: I
think it could make sense to think of this in terms of which one needs t=
he
other one. A worktree needs a repository, so one could say that a worktr=
ee
=E2=80=9Cconsists of=E2=80=9D that. A repository on the other hand doesn=
't need to have
any worktrees.

(But the vice-versa also makes sense.)

> I imagine that this weird phrasing intends to allude to the fact that
> a worktree is "broken" without the repository metadata folder that
> contains both its worktree-specific metadata and the shared metadata
> that it depends just as much on... but can we come up with better
> "relationship words here?

I don't see why one needs to phrase or define things in terms of what
would make it corrupted or not-that-thing any more. Like, a =E2=80=9Cwor=
king tree=E2=80=9D
without a Git repository is just a directory tree=E2=80=94it's got nothi=
ng to do
with Git whatsoever.

> Sorry to continue nitpicking - I would love to see a clear
> nomenclature and description of these parts and their relationships
> for people (with less git experience) to "get it" more easily.

As a Git user I think this is a very productive topic.

Cheers

--=20
Kristoffer Haugsbakk
