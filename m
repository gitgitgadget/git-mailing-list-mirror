Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E78C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 12:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AED2253A
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 12:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391940AbhARMql (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 07:46:41 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56647 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391796AbhARMpx (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Jan 2021 07:45:53 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 66C4C5C0131;
        Mon, 18 Jan 2021 07:45:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 18 Jan 2021 07:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=OLTlk7auf/sbGrFFXlUN8pop6E7
        n7IAr+0cwrwu1TPs=; b=bsqw+Jc03yj7q/HrfIK8Zqht4bvpjzdUzqjN+vP0kTB
        HJrI560GiRlkaKrCECfQdYfW4gy2O6o6lIc6GjVVUMmRm+z5S2o7gUaQuNm7xsfv
        a7vpTLuec/Zd10R+r2VEv1N0vAhiBuPvVy0B7CBsAVlRQQML9a3fQuVQMP+q1o9u
        cHuiCvHsyVWho7ocJUdUfKuDVX5/BlWIkrPT3utFtNX2GY/CJAMUYQKNXW7XaIcl
        xdvGz8PUlBo0YAPAPE1BQ26/PqH6Pl05WXoL1+re1HD0OkiIAhhPFsIjcRyShg+i
        uFtBDyZIdIbgd8AOp4/bcEqWokO4TfZ0N2Jp121RbXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OLTlk7
        auf/sbGrFFXlUN8pop6E7n7IAr+0cwrwu1TPs=; b=Vwh5Wwwn62xxWzPIFQWjex
        c48+JbMD/zftsO8NvYQ2t0gGJAi8qAfJGtVtTk8nVaKn1eVZL0txzyXHl8LcZDgR
        LMyupohJVGnaM9duk/JGIrK9yhAxsViSiWkZyt/VSoW7X7I410My7RtXc/vYluz4
        0sX5NOcNhvoSWgH3ChFsLQMCo4rUgc7e8XNBMrG3p1rumfraQe9N2oGDM0AHULkA
        633U5fzZOMStKXkke31OAJr29zTVlAKxQZIf/0wBSTDm0agZF8PeeOHsZgQ4c3S/
        +YP/lF4DR86fA2J8zU0sYR+aj9nxeoZZrA8IKEdV4KqAsXSMi1H79ISclDEA7pCQ
        ==
X-ME-Sender: <xms:zYIFYORvOuVNjRkEvIfBb7-PQU_n5w1QCMilBFoRbSB1U1EOw2MAQw>
    <xme:zYIFYDyYjkC80zDR4gJOr7ogSGCLERPvseqcYFsYi9voc2FqqgCeGlj07PlZL7UsQ
    SlnNoZz_9iwYsGFqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucfkphepjeekrdehhedrheeirddukedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:zYIFYL0RLfCH3T8kEAx9dgm521c8-B5hsEvuCoYAwxz6x_gMUJ35NA>
    <xmx:zYIFYKDHP0Yd7BbrV7jq1f9GtOu-WY_OW_Ql3bfGb49gO6pTtlMlMg>
    <xmx:zYIFYHiDRTo01UdloX5caukUA9Hx2vyPxM2EAiOSCMlrW8d9lOadBg>
    <xmx:zYIFYPYmrAC-dW3_NNviRk5lTOdqcGBtbEmgOSsZYOghPWYvM3c9sw>
Received: from vm-mail.pks.im (dynamic-078-055-056-182.78.55.pool.telefonica.de [78.55.56.182])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72CFE108005F;
        Mon, 18 Jan 2021 07:45:00 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a1eb55e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 18 Jan 2021 12:44:55 +0000 (UTC)
Date:   Mon, 18 Jan 2021 13:44:54 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] refs: Always pass old object name to reftx hook
Message-ID: <YAWCxk+T0U98ee6y@ncase>
References: <d255c7a5f95635c2e7ae36b9689c3efd07b4df5d.1604501894.git.ps@pks.im>
 <X8n1Qf7TJyqIOE/l@ncase>
 <X/4Pin4Zdf58n1jc@nand.local>
 <X/7X5ku3wvMr2hw6@ncase>
 <xmqqbldsy4un.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bh5EE2f5wKsuxPvK"
Content-Disposition: inline
In-Reply-To: <xmqqbldsy4un.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bh5EE2f5wKsuxPvK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 12:11:28PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Tue, Jan 12, 2021 at 04:07:22PM -0500, Taylor Blau wrote:
> >> On Fri, Dec 04, 2020 at 09:37:21AM +0100, Patrick Steinhardt wrote:
> >> > Quick ping on this patch. Is there any interest or shall I just drop=
 it?
> >>=20
> >> Apologies for completely dropping this from inbox. I am interested in
> >> it, and the patch looks good to me. I suspect the reason that this nev=
er
> >> got queued was that nobody reviewed it.
> >
> > No worries.
> >
> >> Would you consider resubmitting this patch if you are still interested
> >> in pushing it forwards?
> >
> > I can, but does it help to resubmit the same patch? Your response bumped
> > the thread up to the top anyway.
>=20
> Bumping without resending would often not help people to see the
> patch at all.
>=20
> For example, already-read-and-old messages are not even shown to me
> unless I ask my newsreader "I told you to show only the latest 200
> messages, and I see this recent 'bump' message, but it responds to a
> way old message so you need to show me the latest 3000 messages to
> cover that era in order to see the patch message(s) it bumps."

Fair point, I'll resend the patch. Thanks!

Patrick

--bh5EE2f5wKsuxPvK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmAFgsUACgkQVbJhu7ck
PpQVKw//cZVdSoMNUWy+I6A+oAGOgyeJANNnUFc/ANE1lGyQ1moUbZb/udiGeOe+
lkkUATA5XHYJ3v1PWyPIb+fsgoweW6wcB2E/TOvk6smFlXx247lmwXphFtn2SRLt
Fpg9HVesyVCUEzJDwwc0ADOe1tt/9v6EIo/2JFCa9kIb63eE9fa2wIs6BqabtB4o
iOV44WAxdlAVrVl8V0DMAJ9WdRbRT4N3jUm+gQgG9QGiyZ5xejhML18KMu/rwK8f
bpzoHV3JqFxoiI68SSm1//98qNSEZifg5Yz8eJqXb+Ru2CjowsRY3ltORrX1et7r
O3PolSEwQ+rgR9SRQI8Sf4Dn3hcgHrUzR/2M+FdErr9hx1orCSBTigtVrkaegUwl
8lUrrO88GqaQM2pUeeEIUO8HOAPk28l3hjOIVGCJWDcGHYT02vG9igCIcVapbDxJ
0LKHe8NnEZpyWvFNb6AQBZCFnUbJoyhJ0f2UkBkpJp7JyB9Im2LzW63ZAv8aPxJq
H36gTCiqvMZhRleJw+DjmQEFm8vf0tskUeuphiB9adguSFAhACJuqNqxJ2QlRl8d
xh9+ncS2XyChhYkDtQ5o0fw+YnX+WbyUtZVbWSChMggYAx7UZUf+jWygCJRemFI8
Xlwicp1Gzn21qqn21XRMSIlzh2rEZgcdFmuMhLt5CUgCtOLveNk=
=l/IL
-----END PGP SIGNATURE-----

--bh5EE2f5wKsuxPvK--
