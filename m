Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12760EE14AC
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 16:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242887AbjIFQCx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 12:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242865AbjIFQCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:51 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69F1733
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 09:02:41 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 97C3C3200970;
        Wed,  6 Sep 2023 12:02:40 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 06 Sep 2023 12:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694016160; x=1694102560; bh=5c3VtUvrjixHGu6OUMgj9IgCF
        Ns9+EIsxGHv7HOx6X4=; b=e8yoOnsLXJmYMezrV2C2JkdtYWrnLOkPwolrRNOcy
        blcBiG7Brq4jr+y5Awps0O0H3uPz/M8rAVXXASUWyt+M8Wp7g++x6Vip4W0cSkbd
        1VGEyjRHG+9IYhYq0y5DazA9aty+IQVzgg3hk0NS5cS+DGspmZnvWdSxXQ4Cz+1u
        8BF+gJQqjyyutQUidaDb5/SUfu541T+Wjj9aWh8c6oq/SV3zXuxVNIWPuJI2pJxL
        nLr7j9FE5auX1nZM42leAFgoYvkakQ4qnWMXiRsEP7tCvsJUZRzLbUHez+pfV0c0
        vZ4hLdSBRMMlqongE7XNr4s0S2Jna0UChDy5acd/YUCYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694016160; x=1694102560; bh=5c3VtUvrjixHGu6OUMgj9IgCFNs9+EIsxGH
        v7HOx6X4=; b=auA4txJWIE9dTAA5+nkGMhmLWouk3wFZyxZfIWlzrptFmVNQiSr
        P+1ovXvjPOd8UPqBzdSDZ5M+X3qslncNhabA3kwdwOQ9P7fjXaqHL9MIq+70bv9T
        zvvCjYvxkJYheWZmLmK5o1FWBSkU80FYduSIjFbup80W6cB4EDdBJIbe1z81bGo/
        03U9Wc4Xm0f4g7scCb2L9Nlqur4XCEV2B8pQ9+poBkQrIv/wQ6VF6NqCiJqxrL8K
        KxOcjBxDJELoy6wbxNiDjzHr53anGHJ4mSaN0O7+fwv2dkMhUWBtt1TGOMSB8I/2
        fDHQHkhdUIM3lsr6xBZO5q5W9Ttv67TeTlg==
X-ME-Sender: <xms:n6L4ZF87rRpvcnhFNcmRPhaUVSCl_TTBypq_5ExuFjMb-IVZ5Hz8KPY>
    <xme:n6L4ZJu9o2Td8SFr777Uj_2xcrzYv6AEoWCovK5jD3esUcwe94UkkecgYIJTEmcfu
    aq102QZel1tFk-9DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedviedtvdetleetvdetvdeiveehgfei
    ffeujedtudfhtdeigeejheehteehfeehveenucffohhmrghinhepghhithhhuhgsrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:n6L4ZDBVVSI8n9p4gk0uZ5kLgAB-c0lWUSFVsJlKzQDq3pgWvZEdXQ>
    <xmx:n6L4ZJfRAbbYXpazx4wwErpsbK1R_C4Y1k4oY7yFnju0z5ibR_gymA>
    <xmx:n6L4ZKOri4aDbG9gnPNM4JcsXuyEDV7Ff_RMGMYmA0RSMwcexMSHXQ>
    <xmx:oKL4ZHrGsaUE7DM9zOr0308GfNjqXQN6eA2jVYLzSHkSUda7MW1MFw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 40AEA15A0091; Wed,  6 Sep 2023 12:02:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
In-Reply-To: <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
 <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
Date:   Wed, 06 Sep 2023 18:00:26 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Eric Sunshine" <sunshine@sunshineco.com>
Cc:     "Tao Klerks" <tao@klerks.biz>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird? Bitmap error in
 git gc.
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2023, at 02:38, Eric Sunshine wrote:
> Speaking as a person involved in the implementation of worktrees,
> including support for them in combination with bare repositories, my
> reading of this is perhaps biased so that I understand its intent.
> However, if I squint hard, I suppose I can see how you could read it
> as meaning that a bare repository can't have any worktrees associated
> with it. So, perhaps, the documentation could use a bit of touch up.

My interpretation of the documentation leads to contradictions. So I
thought of another one: A bare repository *can* have worktrees, but if it
does will in that case only have *linked* worktrees, since the
`repository.git` directory by definition does not have a working tree and
it therefore cannot be considered a worktree itself. By extension, a
linked worktree might be linked to a bare repository. Thus there is no
contradiction.

For example: there are four directory trees associated with the `repo`
repository:

1. `repo.git`: the directory tree with the bare repository; no worktree =
in
   *that* directory tree
2. `a`: worktree with a gitfile that points to `repo.git`
3. `b`: worktree with a gitfile that points to `repo.git`
4. `c`: worktree with a gitfile that points to `repo.git`

So you have:

=E2=80=A2 One repository
=E2=80=A2 Four directory trees
=E2=80=A2 Three worktrees

This interpretation seems completely in line with =E2=80=9Cbare reposito=
ry=E2=80=9D in the
glossary:

  =E2=80=9C A bare repository is normally an appropriately named directo=
ry with a
    .git suffix that does not have a locally checked-out copy of any of
    the files under revision control. That is, all of the Git
    administrative and control files that would normally be present in t=
he
    hidden .git sub-directory are directly present in the repository.git
    directory instead, and no other files are present and checked
    out. Usually publishers of public repositories make bare repositories
    available.

But not with =E2=80=9Cworktree=E2=80=9D:

  =E2=80=9C A repository can have zero (i.e. bare repository) or one or =
more
    worktrees attached to it. ...

Since this entry claims that =E2=80=9Cbare repository=E2=80=9D and =E2=80=
=9Czero worktrees=E2=80=9D are
equivalent.

Nothwithstanding any implementation/documentation disagreement, I think
that this interpretation at least is coherent.

But note how (for me) it is a bit awkward to refer to a =E2=80=9Cbare re=
pository=E2=80=9D
in this context since I need to add =E2=80=9Cthe directory tree=E2=80=9D=
 in order to
emphasize that we are talking about `repo.git`; normally you can kind of
loosely talk about =E2=80=9Cthe repository=E2=80=9D and still get the pr=
ecise meaning that
you intend across, but in this case we have four directory trees which a=
re
all *the same repository*. (Right?) So just saying =E2=80=9Cthe bare rep=
ository=E2=80=9D
can be misleading since it might hint that the three worktrees are not
part of the repository. (Perhaps there isn't enough nomenclature to
clearly talk about this particular case/setup?)

But with all of that in mind, perhaps the glossary could read something
like this instead (no reflowing):[1][2]

(`man git-worktree` might also need to be updated.)

=E2=80=A0 1: Applied onto 1fc548b2d6 (The sixth batch, 2023-09-05)
=F0=9F=94=97 2: https://github.com/git/git/compare/master...LemmingAvala=
nche:git:bare-and-worktrees?expand=3D1

Cheers

Kristoffer

-- >8 --
Subject: [PATCH] Try to reword what a worktree is

---
 Documentation/glossary-content.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary=
-content.txt
index 5a537268e2..5e192fb5dc 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -694,10 +694,14 @@ The most notable example is `HEAD`.
 	plus any local changes that you have made but not yet committed.

 [[def_worktree]]worktree::
-	A repository can have zero (i.e. bare repository) or one or
+	A repository can have zero or one or
 	more worktrees attached to it. One "worktree" consists of a
 	"working tree" and repository metadata, most of which are
 	shared among other worktrees of a single repository, and
 	some of which are maintained separately per worktree
 	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
 	per-worktree refs and per-worktree configuration file).
++
+Note that the directory tree of a <<def_bare_repository,bare_repository=
>>
+may have linked worktrees, but cannot itself be a worktree since it has=
 no
+working tree.
--
2.42.0
