Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40215C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiKHOtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233203AbiKHOtn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:49:43 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECF3E25
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:49:42 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 947915C00CD;
        Tue,  8 Nov 2022 09:49:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 08 Nov 2022 09:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667918981; x=1668005381; bh=gF6p7Vb8Ka
        c9N3JfM0EiM7CkSySATtsQ4UhfIzp0zO8=; b=ZornNM6DdFaMAeKfOyNKCTfYgk
        nfQ+ioeQbpRdmxHcv9C0psBFPeuA3Yd2jE5hfMwTIPCwYzLml/skPXCHcvUfyvIe
        vf+uoopymECaN4Q3nnjlo0Z1CKXrH/tzq8gvCTkY6jn+Jn2ln9uMZWnHFnaeP7cf
        HtYFAY58ltdPPg8C78R+uAI3lwexXYHo56NbDZgR0ccL6wqD58WaXddMMpFeKdYu
        52ZAv3SqERS7w0FfkI2vuYdxQF4jXOgJ8JmS7TDK38jR329KIhKjc/IB42XYkHCv
        3YXi6BQmM0crHo8zrO9fuUw8GDmwABplpYIuaXMlOgn3hlzwL02pqqUdDXIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667918981; x=1668005381; bh=gF6p7Vb8Kac9N3JfM0EiM7CkSySA
        TtsQ4UhfIzp0zO8=; b=Jq+G1yyzRkVXY1vTphVyk7/CQ3BmIhnhf2xQ+xOKgaoI
        VttUM1eA87DZ45cuZXD6xcBsNcpeq1mvCUkEYuJJMWa2KIImU4mX4Mox3rNPNdN4
        oOZgWqXdrRubp3h0QtoIQehlQNnMpiJwd61W87+mfrZFoRbskczLrQgq2Hby7bPO
        w/nJf9LtwDytXSTN+wcPRTgcFz0qVawRcC20JXr4EiBWx3z+iMiPTHIUX4CCjBmL
        WUiwve5TGG7yGgPLSBlHGUZJRDfLYZ/wXaauAEgTj2q6Rxp1H/gATHF5RwdBL19D
        ib4eapS63SD3K+tRHoIrMBbF1pPnJLjjOFJG1rOdAg==
X-ME-Sender: <xms:hWxqYxS8mzCaJzN3Kp3j3lUBI87pyuiNb-H9CrIxyrwipXzr0oNsgg>
    <xme:hWxqY6wor5-ukBKzCjMoN0MEgqYCCxXWOfJaRLExKMn0x38xbcnpIkQOvL-YxJR84
    BNz3lryGWrEhcaqRg>
X-ME-Received: <xmr:hWxqY20xD_pRtgt5tygtyV1Qw-AIGXkO-PBmbc9RhnaqCY88ofbxC3-XlBdgbdvjhy1bTVNJx0jW8qxdXtQ9JSEmH54n6nj6NLxEjDgxF4e6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfedvleefueetgeeitdekheelffekkefgff
    duhfduvdefffdtheekiefhkeejkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:hWxqY5BlP3rGWOJIBXoIy9GedyrKYsJtHLpqC4eVrdEtP1CtMIiobA>
    <xmx:hWxqY6hiQb9BBlOyu8GZlzGnmJATAb3JsBPGWLrKQOeGaEWVwxaolA>
    <xmx:hWxqY9qNQFEBtPeFXm9T75mc1Fo-KzgCazx5GJq_XMt2pwXmw3yTlg>
    <xmx:hWxqY7sUl13XJtnKVXLBuPJ3-GOqM5LRPMdj0rK0unUJ0Jc3NVtksA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 09:49:40 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 434b7ab3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 14:49:30 +0000 (UTC)
Date:   Tue, 8 Nov 2022 15:49:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/6] refs: get rid of global list of hidden refs
Message-ID: <Y2psfpS3rxg46SHV@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
 <34afe30d60e4dbc7e50a590541440c20c27507a6.1667901510.git.ps@pks.im>
 <221108.86leolsgze.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3z760mY0duYyUZrL"
Content-Disposition: inline
In-Reply-To: <221108.86leolsgze.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3z760mY0duYyUZrL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 02:36:04PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Tue, Nov 08 2022, Patrick Steinhardt wrote:
>=20
> > @@ -2591,6 +2592,7 @@ int cmd_receive_pack(int argc, const char **argv,=
 const char *prefix)
> >  		packet_flush(1);
> >  	oid_array_clear(&shallow);
> >  	oid_array_clear(&ref);
> > +	string_list_clear(&hidden_refs, 1);
>=20
> In the v4 re-roll you got rid of the "1" for some other string_lists,
> but is this one still needed, i.e. does it use "util"? At a glance it
> doesn't seem so. There's another "hidden_refs" (maybe just semi-related)
> in 4/6 that doesn't use it when clearing.

Oh, right, I missed this one. Will wait a bit though for other feedback
to come in before sending a v5 only with this one-line change.

Patrick

--3z760mY0duYyUZrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqbH0ACgkQVbJhu7ck
PpRwIhAArgRArPJecNozrcgIgJNrhjB8FtOsL5STPsGIYIC84ZBY9BPDFFzjFbRU
7g8ELgI1CK8+cabAM2/Incs9sy2qzI3rEXlxl+ksLzhDXzjQ+53Xl5N/uMylxROY
pmHG5blQ68cgU4ToJqqhk8lqj5dDqThhhP66+iRiAbvC33u41/2jy4ImvZ4ZLyLR
k7YFof4AmDDm0UvYaoy91pEF2oHgwN9d1vAC36gPQX7EvyfU0WT5ulTSAaLuGuGJ
SrYr0Z0aocDBK42xZBibjhF+OJJZlGt3mxCDfDoShXqHUY2fVrzA2V+KsMpSbygb
WqcRrC7dGPCtZFT5HqYrew/iynpuRrALohwJPyeX9TNB5ODY8cygeQKq+W0aO55S
+WNFO6qQwfpl8uyl/MbVplBml5SmACY5yV5veorpMQrLcx7Jro0gxJOJBWbRVUGT
fNYovG7NXdoWK48ZhXqKOBIkE8lwkVLEuVnkcGR9Ffse+4OjonEUFoDB6NgzPRts
Pazj/Gh4jCJZ//SdA3dnQR1vfyc5TsfsJOEtFMA7ZQ1F97DU1/Qdn4DaEvKYtGTx
xoqZei9ac4gAr3OtGIqoeuiIYssGB2exv8tbd4aWYBFH8t2LqgMW4qxdGR/+R/4R
+GvhD5nUWssegu10hDweY5wucnyqFiqHmltAPwGiDTD2kL49Gjw=
=poaq
-----END PGP SIGNATURE-----

--3z760mY0duYyUZrL--
