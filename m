Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB502CD68ED
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 06:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442217AbjJJGgL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 02:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377808AbjJJGgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 02:36:09 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7691
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 23:36:08 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 82B2E5C024F;
        Tue, 10 Oct 2023 02:36:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 10 Oct 2023 02:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696919767; x=1697006167; bh=KI
        SMOtujk7NfyjP4opddkHzfwxjSPVuv069mTYQ2q0w=; b=rnT9PAcnHQZn9qwJmU
        OieZ/2NnlCNdK2+aHI4M2t0XLkM0RajxjBG0IV44/xg21EbFQCdUTVBZMJ3sXWZL
        k//ksc8mbquz0zKDujQb7ceSCYUr2eGpi7BDcRlbw+sK4hEZrqQRbwXdpbjz7r2/
        o2R1wbBVFAuohjjiEHcmLtmx7p9WG2lJQcVgKTyAOeIJ8XHrzw+hGN/CHEhueuLG
        uMZao1vHVeSbXfv7jvibynPR3twZwLj55srx4MRO5Yu6lkvIR9YkKj8aE6tcAs7t
        nOHqPq2k0YjKhDolb0E0C92/uYO0YjatAIjd6qbeGYLBGrGbfO3E899SvCbcOtLj
        Y/CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696919767; x=1697006167; bh=KISMOtujk7Nfy
        jP4opddkHzfwxjSPVuv069mTYQ2q0w=; b=UvXqc7xivZGoF2iyZdS57uR5s0efo
        lwvezC/FQUZ7VAXxNPKTlQaBstBZMrb38l+k1ekLggSnVjamoRhqjHZpBaUVDWIc
        fZYzfB8jYzWK1fvOxQLKUZiu+cQ4pvGRmcOnGC+643vxtsFGRACBtOKGakVENWV9
        wzDwZZ/jFWM9idy3MB/Ci93J8MRor7TDDEpo3vfgiLHAwmO7/LSHOkG+Qj2cp0Pk
        H2vIAl737YxcQoq1+vsZzB0OpwIuK1xMNSMqWu35xDrQ+ZHEGpJLvIHJNG8XPpbh
        q23CC+W+/X1wjW9WGRpn93ggk0eAsDDqS4H+j3SwxHZnZp+ewEHdwvsXQ==
X-ME-Sender: <xms:1_AkZeDoFTQAsODWwCVTZGBOnQU1fYs7cY0Han41IxBLzX4NKY0yww>
    <xme:1_AkZYiDAxP5uJGocGob23q8rjvnDmCIMB8j3NSXSb-nbfhY8l9Uz7YTy-bSCfWeZ
    rPEuKCId-FYbu0H_g>
X-ME-Received: <xmr:1_AkZRmJa2kddumjenWBg_ftyvtd_6FOFA-oi-r08t-9BquVnVAOHwjw6-3qrz8oZhSQTb9-lDsxmI6ugLe9ptTDVwiqVuVm8vfMRoVhExmX__F_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1_AkZcxB5dUzutTdcT_55g3DS3odOkieAkNPkMxwC8x8Uyafcsx6pg>
    <xmx:1_AkZTQQDthm7jifygPjBXjk6lfgqOVMtu9Av5X3WQKGsc6ypwSQQA>
    <xmx:1_AkZXY6YikN6Qn9CRLVpQsstFKB2qsGjEIsSE4ElQIDsqKcEsuWSQ>
    <xmx:1_AkZRP9c9pfsCCCWRJ0i2s8A-uejOtOrWsVF6Hf9utKJZwFZAdm-w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Oct 2023 02:36:06 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id e9d2ef4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 10 Oct 2023 06:36:04 +0000 (UTC)
Date:   Tue, 10 Oct 2023 08:36:03 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZSTw04yxPg3NiBOs@tanuki>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
 <ZSCR7e6KKqFv8mZk@nand.local>
 <ZSPb1OYRrQSUugtg@tanuki>
 <ZSQlgLDv+MrYmSp8@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yMc1aeXdfuAPJm+3"
Content-Disposition: inline
In-Reply-To: <ZSQlgLDv+MrYmSp8@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yMc1aeXdfuAPJm+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 12:08:32PM -0400, Taylor Blau wrote:
> On Mon, Oct 09, 2023 at 12:54:12PM +0200, Patrick Steinhardt wrote:
> > In Gitaly, we usually set up quarantine directories for all operations
> > that create objects. This allows us to discard any newly written objects
> > in case either the RPC call gets cancelled or in case our access checks
> > determine that the change should not be allowed. The logic is rather
> > simple:
> >
> >     1. Create a new temporary directory.
> >
> >     2. Set up the new temporary directory as main object database via
> >        the `GIT_OBJECT_DIRECTORY` environment variable.
> >
> >     3. Set up the main repository's object database via the
> >        `GIT_ALTERNATE_OBJECT_DIRECTORIES` environment variable.
>=20
> Is there a reason not to run Git in the quarantine environment and list
> the main repository as an alternate via $GIT_DIR/objects/info/alternates
> instead of the GIT_ALTERNATE_OBJECT_DIRECTORIES environment variable?

The quarantine environment as we use it is really only a single object
database, so you cannot run Git inside of it directly.

> >     4. Execute Git commands that write objects with these environment
> >        variables set up. The new objects will end up neatly contained in
> >        the temporary directory.
> >
> >     5. Once done, either discard the temporary object database or
> >        migrate objects into the main object daatabase.
>=20
> Interesting. I'm curious why you don't use the builtin tmp_objdir
> mechanism in Git itself. Do you need to run more than one command in the
> quarantine environment? If so, that makes sense that you'd want to have
> a scratch repository that lasts beyond the lifetime of a single process.

It's a mixture of things:

    - Many commands simply don't set up a temporary object directory.

    - We want to check the result after the objects have been generated.
      Many of the commands don't provide hooks to do so in a reasonable
      way. So we want to check the result _after_ the command has exited
      already, and objects should not yet have been migrated into the
      target object database at that point.

    - Sometimes we indeed want to run multiple Git commands. We use this
      e.g. for worktreeless rebases, where we run a succession of
      commands to rebase every single commit.

So ultimately, our own quarantine directory sits at a conceptually
higher level than what Git commands would be able to provide.

> > I wonder whether this would be a viable approach for you, as well.
>=20
> I think that the main problem that we are trying to solve with this
> series is creating a potentially large number of loose objects. I think
> that you could do something like what you propose above, with a 'git
> repacks -adk' before moving its objects over back to the main repository.

Yeah, that's certainly possible. I had the feeling that there are two
different problems that we're trying to solve in this thread:

    - The problem that the objects are of temporary nature. Regardless
      of whether they are in a packfile or loose, it doesn't make much
      sense to put them into the main object database as they would be
      unreachable anyway and thus get pruned after some time.

    - The problem that writing many loose objects can be slow.

My proposal only addresses the first problem.

> But since we're working in a single process only when doing a merge-tree
> operation, I think it is probably more expedient to write the pack's
> bytes directly.

If it's about efficiency and not about how we discard those objects
after the command has ran to completion then yes, I agree.

Patrick

--yMc1aeXdfuAPJm+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUk8NIACgkQVbJhu7ck
PpQCAQ/9HxYjxc7yANHA6NfpkW3cpbdhgpAK6RoLn2ilIdRnWycBTFF2EkAHO7L7
SW0Nx0WyjYMOqBXie8cwarVfAeN8UmSj96JMBVcaRDDGAYPmE3wNBy/qSVyhF1ts
LUgcRusmDQK9ZTmqRVobi8my2EflfCdllL8IEv5pymmGPOWuhc77mKSKBYmlNl5V
c236dmMBxOW3VSmwUbaN8TzbqsUZ3QkyaifBpx219cb2Ty5Ua9uaYyez7JwmHEol
U5/TufOLhjfcjyYYXY8sbCYxs4d7AyjtDzWsGWpkNmnV5FDhMdIFrFGfIUfrAxPt
77J1i5qsyeaG89w6CkyzyN87i6JU8vAhXcBYXvBC4p9k7XR1CItxznSiol/ecOvt
MoYzS0ZkmQ92zKGH61hWpKrJHFPI7gHxTBxp7AU0IbKqlyIEpbe+CqK5egxEUxs/
NIS/8I9PxF+L1DueDZv4q7GpGvsLt4Mo3koWSupgURhNjrIxsIIy4ySUKZtYDvJh
g93hkPc6pAa0wdu/rJlvaeH/fpmHLZ0F4QXMUPlrTBZQxISTY7FqPpe4fiPTANR0
G/VPn+pV73fWDvPWULw97QF5rPF4t7DIePKgY13e7fe+lwvm3lisy7jwXtNL86NF
0gAKHBhLwIsZJL6koQBDOvb2+zPZbCfdLSNDf7yqe445dChbeVg=
=ss2g
-----END PGP SIGNATURE-----

--yMc1aeXdfuAPJm+3--
