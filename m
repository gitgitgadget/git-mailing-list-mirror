Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6608BC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 09:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjDYJ6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjDYJ6i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 05:58:38 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7597ABF
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 02:58:35 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F2F1E5C00F2;
        Tue, 25 Apr 2023 05:58:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Apr 2023 05:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682416714; x=1682503114; bh=EQ
        EI5o19JYFBd3wTAXje3czUu5FhAIbIIva0LucdKuU=; b=kn/RQ9ndKprRdEA7ox
        DeDvZ2btU7HOiFpPeNHrXG8b3SMhJAW780Hw7BjQh/dgI3KftwoXAgnjHDgrwAp6
        m/3BaxAStWfzU3BCHKz399gd+8yH1aN8UJGJTqRnYoWl0L3LUGKc5XuYjSbp6gNz
        9WmHBeFIvZQHIO7eerdopRIrl7a5TA0kWQtF0/FpFGXg+aSz7dV/sl2O5MVCoS6h
        hw9tOtjRXSG4ChzogetWoihCCk7+HDFqErEQNOWuG06Sx3RPASv2ONVXMjhoeVOf
        FPdFJ2ZJmWtLGsBvC7Yl2n62sfke9IDsnLqCDlQE/HX8nJaHc++Se8aB17QrToPy
        0zXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682416714; x=1682503114; bh=EQEI5o19JYFBd
        3wTAXje3czUu5FhAIbIIva0LucdKuU=; b=kI/rrNFXB6AKVTq3zQWB0206ehDRm
        OYLsro8041W6/Utl6Ame8AigM7iBBuLkM8dNv+UKug0+YJYZRZA7oEGa2jNoTnCU
        BbJIPhCKXQ4lP1RT+/6UlSz2UdaJu5gkCxVejXQSs0TiitslxmE7IVgTACH/RJfh
        3BhdhTrdokMrJwQb4GuDFJiWgrNhoUh/wVDuPiuxxdJc2TiEiF/r6nDG/KC+l/cx
        n+picpiEMKglT/lzowTA2KCdChCMi5yWyDkToeZb/y7JTwvVw+zgO06PyUccouzy
        sOoPF8OGAGdHxFS3fbV1V/JzsvP9fXB7FDt4yCEKEr2GHq7gVZhoECLzw==
X-ME-Sender: <xms:SqRHZKb9s8rhF_Ok_9I3oEtwbNH7LGvq_nzcCJbxwTjR3YV74GKUaA>
    <xme:SqRHZNY_hBXOfzvMAse4HbsJbujDnIOajKOameoWoaeuk4m-NQlIF-LSMQ2XwIbT1
    8GoZibNyTx0HxI_hw>
X-ME-Received: <xmr:SqRHZE_KUV8NMEDlix90fYWlOI_15YXt1hfFOspthTHtZw7-_n8KcuMIqOh2775LTQ122bOm77ldkyz_Rf1XiXFIvx153B4nMlPgWYJYal-h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SqRHZMqJTVkK8BHCeS6KcqfD009Fpn9KcrNy1V_AhLMtljeA56Tx6g>
    <xmx:SqRHZFrrSh4YeEziCSfyWuAceQ52zykIX9bmgyuL-KDylwoF6E8J-Q>
    <xmx:SqRHZKStN7leQ3j77vEKS4X4jo37B49cr1FGVYMzNFCEoYhDptgdVg>
    <xmx:SqRHZGBEHCca0TBivaTTDutwZtzc5Coc8KWl6OpSRqytYm0C7siSTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 05:58:33 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 66eb7705 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Apr 2023 09:58:06 +0000 (UTC)
Date:   Tue, 25 Apr 2023 11:58:28 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/8] fetch: introduce machine-parseable output
Message-ID: <ZEekRNuPmObU9Vsq@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <6446e3db4702d_cd6129452@chronos.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UfrLB+SJB5jKl2x7"
Content-Disposition: inline
In-Reply-To: <6446e3db4702d_cd6129452@chronos.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UfrLB+SJB5jKl2x7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 02:17:31PM -0600, Felipe Contreras wrote:
> Patrick Steinhardt wrote:
> > Parsing the output of fetches is mostly impossible. It prettifies
> > reference names that are about to be updated, doesn't print the old and
> > new object IDs the refs are being updated from and to, and prints all of
> > that information in nice columns. In short, it is designed to be read by
> > humans rather than machines.
> >=20
> > This makes it hard to use in a script way though, e.g. to learn about
> > which references actually have been updated or which have not been
> > updated. This patch series intends to fix that by introducing a new
> > machine-parseable interface:
> >=20
> > ```
> > $ git fetch --output-format=3Dporcelain --no-progress
> >   fff5a5e7f528b2ed2c335991399a766c2cf01103 af67688dca57999fd848f051eeea=
1d375ba546b2 refs/remotes/origin/master
> > * 0000000000000000000000000000000000000000 e046fe5a36a970bc14fbfbcb2074=
a48776f6b671 refs/remotes/origin/x86-rep-insns
> > * 0000000000000000000000000000000000000000 bb81ed6862b864c9eb99447f04d4=
9a84ecb647e5 refs/tags/v6.3-rc4
> > * 0000000000000000000000000000000000000000 83af7b1468c0dca86b4dc9e43e73=
bfa4f38d9637 refs/tags/v6.3-rc5
> > * 0000000000000000000000000000000000000000 ab3affb8ed84f68638162fe7e6fd=
4055e15bff5b refs/tags/v6.3-rc6
> > * 0000000000000000000000000000000000000000 1c8c28415e8743368a2b800520a6=
dd0b22ee6ec2 refs/tags/v6.3-rc7
> > ```
>=20
> Makes sense, my only question is what other format could `git fetch` have=
? I
> think `--format=3Dporcelain` is clear enough.

Yeah, I'd be perfectly happy to rename this to `--format=3Dporcelain`.
I'll wait for the Review Club that discusses this patch set tomorrow and
will send a new version with that change afterwards if nobody disagrees.

Patrick

--UfrLB+SJB5jKl2x7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRHpEMACgkQVbJhu7ck
PpQhIw/4kw3iB29OhOYVvl0rX7oH4VyL+RGINlRFEI3gQcMVRMhac9P5LQqIGbpM
VjeGGHsonU1jJMbNLLhEU1nxO6ZFmNJQ5fbzLYTib/FEXL/vjlhACRVQP1bW577o
ABr5zZBNuaEE47scYIu6ILryTMPIFsdvJhDyiTOuuMcNi4gDj+WmKjtFwC1mbBhO
r5nhPs69YK45riixMenC70Dm5AzpWiIMFeCquIHLDXdZJMZaJW8vue+JdpPeFpQC
uOMm/xGbupSeJrGPO3/OQAZZUQMSpSyMFEnzkNc5FTh/x/sB8UGYTDwdije42RcV
wkGPu5h+Lh/s6f35GnYsKMW8e4rUwRXU4j58tG4a7u8Pui1yKuyRdGlUZMDYVbGs
AkDAAojKLKTxJXU7YXEwtw7hjuuqAeoEQFEVyVefqJLjBTh9sJdmr68MXBT0MIQK
5UjwHkJ79Oi7Ls8p05un+ldyWMAseArfe/+/UFiapOjEu71tTYOPLhAmCSeZv1qy
GxG6U/fdZwhAIyyoXxuIK6WPLZFx6DCzESEE+JryZ8Du/Lhkke8mGKvbxXNx1ImK
kpKGrm4LumpqaIbn+lJMwsJKssiHUPrzFWYksRDofOtg84IbsIr+PAkA1VOpO8k+
EEUKu6rkbSET7Zo+ke2OhBdJ68TxpuaYb18Mml8CKPakiMTx6A==
=yKG9
-----END PGP SIGNATURE-----

--UfrLB+SJB5jKl2x7--
