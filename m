Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0EEE14C1
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 18:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243598AbjIFSAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjIFSAO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 14:00:14 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F81BC5
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 11:00:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id CD6053200996;
        Wed,  6 Sep 2023 14:00:01 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Wed, 06 Sep 2023 14:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1694023201; x=1694109601; bh=S2lPiu9LkVxU0SNmge50SnnGS
        IqpL1FVMv2/DetduC4=; b=IY59w3Lwvb6hmXdXWEZj3GCms8mXOeN0l6KZ1DbpD
        a6WbD/Bp//VBrZ7LhqKUsHA8MAd74l1T/tp7dou4xkhUKDY3qnVPVM5yR/4EH7I4
        InSXpsPADhbwUQKqjTlRVdZbp7N4nbqum3BXsV5TuvBGX+jtxAxz3lJ7dRb5lmKE
        EqEPzzoIl+Vo6M8siY6HpW/eokELWfGsf7oCAVOptMAlJRSLCIQ9jHT4PXSpW1tN
        BkL+dQ3biLyNhIKWyNr7EoJcbBnnGLwQo2XGblMsacD7hoVFp5YURwkAw7lq6idW
        fV4Q90dpXaauQXwKJF96sijaTdmglnEytug3A+xtDCMcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694023201; x=1694109601; bh=S2lPiu9LkVxU0SNmge50SnnGSIqpL1FVMv2
        /DetduC4=; b=v7cxJkddDGxOVaJHqK/8Mx3CmjhhD+AzXMloPeM6lBkLTuyN+IH
        314bS4zbVluSjqkNUXYwUJ1UDaUfynPd2HH38R3aud6MiK32YZm8VSehby23K9Vj
        0GeIRnHOxJFc8cuxueV8oTkDEv3XhFdHAXs2l708z2iMBLHHvxdNtCED2N8KK/mj
        OAfaISuXdGHN66wh/956tDmdz7jK8kBPORWBvlMTPk/se5MJ+hPFkmqFblN09MiS
        Y1R8tJLshefNgTDwWWLSMIIWnUyyBaIB2Gc7WbxDXDtajqzn8DNDYe6hnFJdh4C6
        LbkCTp+CwnMyCr6cnTOLW+W1pJTZawntmIw==
X-ME-Sender: <xms:IL74ZCEO9WIKCgxmY5tSzhMVP6ehgEXUbnUt2dyn2Y4tYKVSpZP4zmA>
    <xme:IL74ZDXGajkgmIWGqniZuk2usixkh3oL_lE3v8aDhn3n2pkt7obbueRuYfe_d8uOo
    uMFi95djHQ8oRqpJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehfedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:IL74ZMJaxgaVa445uZpnChTgwn_e5YMGqXsXbyQ9N1ZiZRo3o6whlQ>
    <xmx:IL74ZMFcukOgr99onG-iWIdTAymkvXLZ-F_AkUtPUTTH_UNz1z73wQ>
    <xmx:IL74ZIWo3mG6jXgzt4EsyMRqLp-auzumEWG_AUVBgVCLUqfBs1bN8A>
    <xmx:Ib74ZGxuJ5hN6N_3BeiCHYxlhhz-YnKmtgE13A-oGHGcjhoXbWF1kw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BF50115A0092; Wed,  6 Sep 2023 14:00:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <c0a10738-86ba-4b3a-9e74-2568cc407621@app.fastmail.com>
In-Reply-To: <87edjbuugw.fsf@osv.gnss.ru>
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
 <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
 <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
 <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
 <87edjbuugw.fsf@osv.gnss.ru>
Date:   Wed, 06 Sep 2023 19:59:11 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Sergey Organov" <sorganov@gmail.com>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>,
        "Tao Klerks" <tao@klerks.biz>,
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

On Wed, Sep 6, 2023, at 18:39, Sergey Organov wrote:
>> -- >8 --
>> Subject: [PATCH] Try to reword what a worktree is
>>
>> ---
>>  Documentation/glossary-content.txt | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/gloss=
ary-content.txt
>> index 5a537268e2..5e192fb5dc 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -694,10 +694,14 @@ The most notable example is `HEAD`.
>>  	plus any local changes that you have made but not yet committed.
>>
>>  [[def_worktree]]worktree::
>> -	A repository can have zero (i.e. bare repository) or one or
>> +	A repository can have zero or one or
>>  	more worktrees attached to it. One "worktree" consists of a
>>  	"working tree" and repository metadata, most of which are
>>  	shared among other worktrees of a single repository, and
>>  	some of which are maintained separately per worktree
>>  	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
>>  	per-worktree refs and per-worktree configuration file).
>> ++
>> +Note that the directory tree of a <<def_bare_repository,bare_reposit=
ory>>
>> +may have linked worktrees, but cannot itself be a worktree since it =
has no
>> +working tree.
>
> Reading this with a fresh eye, I wonder if we'd better distinguish
> between "inline" worktree and "attached" worktrees?
>
> As I see it, in fact a repository can have zero (i.e. bare repository)
> or one inline worktree, as well as zero or more attached worktrees.

Ah, thank you. I felt like the glossary/nomenclature was missing a few
words and these ones seem to fill things in nicely.

Now I'm just skeptical of the other wording issue about =E2=80=9Cbare re=
pository=E2=80=9D,
which might be somewhat out of place in the face of zero-to-multiple
worktrees. Going back to my example in the previous email:

=E2=80=A2 `repository.git` is a *bare repository* which has no *inline w=
orktree*
  and three *attached worktrees* [I really like how inline/attached work
  here]
=E2=80=A2 `a` is an *attached worktree* of `repository.git`
=E2=80=A2 `a`, `b`, `c` are all the *worktrees* of the *bare repository*
  `repository.git` [=E2=80=9Cbare=E2=80=9D here just emphasizes that `re=
pository.git` does
  not have a worktree (=E2=80=9Cwhat about the worktree in `repository.g=
it`?=E2=80=9D)]

Does that sound right? (Asking no one in particular.) Personally I think
that it sounds more coherent than before I wrote it (than I thought it=20
would).

--=20
Kristoffer Haugsbakk
