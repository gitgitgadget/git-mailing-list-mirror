Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F18C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbjEJMgC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbjEJMfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:35:37 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49572AD03
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:35:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6520D3200921;
        Wed, 10 May 2023 08:35:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 May 2023 08:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722113; x=1683808513; bh=Ie
        em9zQpSNXiGG1bJMV2UtOxy7Ee0B2L9g0DuINvJ40=; b=GmOlwF8oinjMdXx7Ii
        Fq3OvIx07Jo4vb55MwliCLTdahYvxUyg4UPo/1o79dxHg4iorR9/QEQljG3tqw8U
        YHi6LAvlPl9Zqr69hnf4E9Y27XdYXXPc/p66ZVv7BxpvdWAQ+LtdWtW6ydnrM4VV
        jRvdZSp8tj3CBVtkyE0aopUcVCbQF941S1deiBFU+Fa5XlR36Ts2MSm1WV0DXKeV
        0rgDnQVERrYMtUpMFdkwNsGSe/1fNd3FZFZwVw8UHO4hMQ5/1n6o1/NZMHMmD6ed
        AMzSWMvaBxqFHGFyGq3IwvDaJgOz/Q7gZw89LdIK0nYiD6oiydmuzCPTsqYtwxu/
        Fu6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722113; x=1683808513; bh=Ieem9zQpSNXiG
        G1bJMV2UtOxy7Ee0B2L9g0DuINvJ40=; b=cJ3IKoXe45m//03WIp61Q80oNiR5n
        c3BH63v8WTFSlNsAuzBLZ+EsyktwRqm9Q8QbLxSoLmBA3qXCyv/c1ZaKyb3FSrqh
        0Q7+0/FK42HwUG0ISt+6+qRqHwWiIt1buiclIn0jeWmvz18rgI/1SEeFHvnJV4Kv
        nsRILkCNu+rKoS6qMJM3cPSsmpHfm5gJTn8lcASgykx8NLUbJ+wStIELbLikI0q1
        N4XqeBq4LE03fru1xhCiALupOVwK2njHISTeNdXRq3YuXOQYcwnFuMvdfm86/uxi
        L86Ocw6AuuTXOiByAr+PIJHm5B6xSabtBcgG33nyclRB63HsQ5WQ9NXsA==
X-ME-Sender: <xms:gI9bZFRpndInXQqFvc5cNNj66gBGBI1aaiNJQ5nbCt5WASSvAuUPSg>
    <xme:gI9bZOxsDVMw4UOZL-UHbkcwpUoR15q-SAT6PeVaFHhkwuhbx9LYpC3GTrA3C6sMC
    vBGWUdmMO_VhEKcEw>
X-ME-Received: <xmr:gI9bZK3Ag3Wkon0UWi7Ex_OpmZMnMLjdQXkYCEVwzduBbq75W4ECA0TjsFduBXOTTMidOHaRwmb3EdJ3P9pN8gfXlvAWg-8li0lq_peQ0rGb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gI9bZNDjk1KY553sfRAGaeIBRc5H9dauB4zVo2kBbIb6wV_fYTOfzQ>
    <xmx:gI9bZOijqKcv45vf68mtsn1xbXbmzQhRHhNbsghNgEikibRAKdxI_w>
    <xmx:gI9bZBrW1rAZtDPleHrgnfObNMprqGo9CPdTtrLSMQYR9Xq8o1CaHw>
    <xmx:gY9bZGfgnmDD73sAkAU2fUveyr78dMbHzfIIFduzkqQ4bgHlJsWCwA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:35:11 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id aa1fdaa3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:35:02 +0000 (UTC)
Date:   Wed, 10 May 2023 14:35:09 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 6/8] fetch: move display format parsing into main
 function
Message-ID: <ZFuPfYBqFcCza21J@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
 <826b8b7bc0d7d6a76f6fd19d8f4a8460af61e9cf.1683636885.git.ps@pks.im>
 <kl6l1qjp16k6.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rDLMKScZ8jPQWdvx"
Content-Disposition: inline
In-Reply-To: <kl6l1qjp16k6.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rDLMKScZ8jPQWdvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 03:30:33PM -0700, Glen Choo wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > with the `fetch.output` config key set. We're thus going to introduce a
> > new `--output-format` switch for git-fetch(1) so that the output format
> > can be configured more directly.
>=20
> This is stale as of v3, since isn't named --output-format any more. Let
> me see if there are other instances of this.
>=20
> (I should have caught this earlier; I only saw it because Junio quoted
> it in a reply of his.)

Good catch, fixed now.

Patrick

--rDLMKScZ8jPQWdvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj3wACgkQVbJhu7ck
PpRMVA/+KzlltooY3/yW9IzV5xR65A53J5pENTKmKTQ+8P2mTkSDl7NKVWdff+wQ
BfiJ1IJCBeeYFBrhfHXQAwjCIZiXZ8L4UfyCPwY11C3clllMsARJ1SQPVJo58E2a
5Woa62OSaDoaS6k+3FOPt87AwulavXd4vVVbIH4C4q434xoEXDjh7skc6LwoB/5x
Wx4woBubZGLT1hmIgTISueLeuayzL869PZLGIpaV7doL0J0xGMO3jEpZv82ZHpNc
H2JnSZZVYrD4QnGv8+XXz9C04noDZDdpTSlYY9dr9JiwIltV7gN796lBJAaAnRNs
r1FlPK1G7nhv9PYZ9hOwWZQgZ1K1iDSyVY/odaIRjn5lXSyu/LZhxG/dW4uuM4aI
qJeO6P8H02QAf9oaABXBNndHVkFJGOb7kHNN9ocHyl4tmyb8MbK0yjao1mhe0F65
hUS7DlKr82wfAEJCzhWpw2l2jaGxfhjYAPYUFUGsIU7q2dhOynHxze+ufWxRwJvh
qw+vCk03jebqKmJxqo/6SA+ThBUoTZAo980HsSOTLipAiM+ulDz2zFUM8TMJzVR5
N5NiHe8AUz83SaOXIxYakzcHp5t6wpHHAVdkn2PDROl9MrGSKungblHcllReWvVf
FAf3P0JYujed/0KbBbaDF9hLclbpLEB/m9MfQtW2c+wXPbrLdDE=
=/Tqe
-----END PGP SIGNATURE-----

--rDLMKScZ8jPQWdvx--
