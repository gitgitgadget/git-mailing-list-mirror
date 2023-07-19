Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08382EB64DA
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 07:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjGSHYy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGSHYx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 03:24:53 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865461FE8
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 00:24:45 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4C8ED320090D;
        Wed, 19 Jul 2023 03:24:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 Jul 2023 03:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1689751481; x=1689837881; bh=hp
        BcbqL15EAc00WMErl7F0LZLgG2f/MMvbk4kftzAJg=; b=fJowwfZaSk5anGQPUz
        uZbf+dydDXWJD+y6nUNh3G5hJNH/q8bneIDaP2dfgQ4dqcGeW0ShDhNB8aRy0PeK
        +Kw1nA70uNlGccQVNPbiaGpdN4eOWl0X0zED1/yqDE6QdSc4D4rk4hwEUwu58opp
        kw+kf4PH5giqAIHzWSdS3b3C8qKxtvWNDqGfViQVU/0NsC1PHMpad12IKFx0oLOB
        095htNY+LsYJ+q/EDPXWF2CxAvISHm+psEtMHFJ7cu1DwjcjaI1+pgqMqlMvypRZ
        sxWN53msB+wZbyNt7jrMZIbtqEyvjZcSl7OhKWfmAq0iciwEXF3fba7Ik1h9uasB
        166A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689751481; x=1689837881; bh=hpBcbqL15EAc0
        0WMErl7F0LZLgG2f/MMvbk4kftzAJg=; b=gQ3Y8y33UkRJpdG6rI9p7AJTPHnZZ
        oDqFhoFWK/n9srVqeJX074IMvc23FW1W+x7N+cscAwj4jfnqUQ3VupbpxK+6jmgV
        dmcZJ8OnkNQC1SduGjh8GJjGqL+3p9i1xXDFblJOjtyE3D68H2306sSUxcZ27P3D
        B4Zmn2yf3Vvr+H3I+KMiYv1KmWfjfoBZzeNafUNyqPKk9GhdffgzQiHrh4y0r1MI
        rpdELxudcJpcLDGgqqueb+hX54h6Wh92nOM2QmAlfFO6HA93fR2mQyUlWZr7JI0a
        HK2db4YKu7DG3Mp+Bhbl+zpQRWDebZkTSPEL1O8nSvrOjjThlrHdYcRNg==
X-ME-Sender: <xms:uY-3ZMcdKTV43tGOoSbV2nDFz9achALDs5qGPhxnfLWOwgWtJuR2OA>
    <xme:uY-3ZOOTrOBTXBfn9ICBPtTCmP597J0BitXMrMMU_cg-yFcE7UcEKJrVJ7yLOC6JK
    lqC4S_GPkntRaeLqA>
X-ME-Received: <xmr:uY-3ZNhB_dziZp2zI_yZu0tfwijzq9orBwYBEAz1QY9msh8QBERalJOECOhdEl68UKD1PMbPyFtgE6WVU_rsh5ljGm2lGTnP9BaNOv46-nAO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeehgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjefggfejveevvdelheevkeehteeuuddugfffveeuleetjeehudefvedtvdduffeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:uY-3ZB-FAOkUx1rpIy7x4aBxR0JmIANfhEX-m-WMJ95sDO9X2N8vfA>
    <xmx:uY-3ZItMqoNyXoktYC6yvKvrNEr4tP4kRs6YWSXpZTcYQJkgRvfsow>
    <xmx:uY-3ZIEVUqt_sFAHbPSMy_SJYDi5MHahbcpHRSk73Kk-qGSRPztA-w>
    <xmx:uY-3ZFV1kfXBCBguld4PnB5e2zkgEKt1w3M08dQaO8WJnS0H_JE51A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jul 2023 03:24:40 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id cfecd303 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Jul 2023 07:23:22 +0000 (UTC)
Date:   Wed, 19 Jul 2023 09:24:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: Teach git-fetch(1) to use a quarantine directory
Message-ID: <7tprum2so74wdccd3vmzgrt7d4ds6lgsq2y6bsxcxflbxw7ds4@qv3sqnph7gyc>
References: <87edl6bx7o.fsf@iotcl.com>
 <ZLVK5nzVZU48uvYE@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6nl74wwjpxj7es3w"
Content-Disposition: inline
In-Reply-To: <ZLVK5nzVZU48uvYE@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6nl74wwjpxj7es3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 10:06:30AM -0400, Taylor Blau wrote:
> On Mon, Jul 17, 2023 at 12:48:17PM +0200, Toon Claes wrote:
> > Hi,
> >
> > I've been looking into making git-fetch(1) to use a quarantine
> > directory, but I'm a bit stuck on direction.
>=20
> What are you hoping to accomplish? receive-pack quarantines its objects
> to ensure that the pre-receive hook(s) are all OK before accepting the
> push. See 722ff7f876c (receive-pack: quarantine objects until
> pre-receive accepts, 2016-10-03) for more of the details there.

> Are you suggesting that fetch be taught the same, so that we can
> quarantine the pack sent from a remote before moving it into the main
> repository?

Yes. If we quarantine received objects it becomes easier to reject them
in case it's determined that they are bogus in any way.=20

git-fetch(1) already does perform some checks, namely it will fsck
objects when `fetch.fsckObjects` is enabled. I would consider it an
improvement by itself already if the incoming objects were quarantined
and discarded if we notice that any of them are corrupt. Right now, they
will end up in the repository even if the consistency check declares
them as broken. This makes the whole option less useful in my opinion.

Also, it makes it easier to prune incoming objects in case Git crashes
or gets killed abnormally, e.g. due to a server crash. Mind you, it's
not a perfect solution as the operation may be killed after objects have
already been migrated or midway through. But it at least makes it easier
to clean things up a little bit.

Patrick

--6nl74wwjpxj7es3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmS3j64ACgkQVbJhu7ck
PpQkYA/+Jen288MwycUazVqt6BLYzGZrKF5k5kc3Mg8OFBR3nORohQN/xEDkTv2M
/5xeuv0KHddOHv98U1xW5Wi+W8WGcB91RA0ZtU/D6z0nij3frUlXm35/eZuSYzhf
sE3zrhWmCrWrgk34OftFfZziR0+tSan9WHVJyMH1iR1GxTd1e2SwTrGAJUd5+9tR
YM9PkgWmS+oM7F+EcMcoeE/N7fP+YToJRTgWtFTaOy4+BuNypJhpE8vbnPMKcSWL
2gE7OvM5jB/sWV0xKvcJ5ymwjY7Iivtc+L9oJHTNiPCaN5YQbYqnPNmvzSqBnuBy
fvCCn16qiQIICx/YUw0QEGBSN/XHRQ8uE88ee3HsfhNxKgINlkK9Nlcc7/pzJZh+
dvHI1nMx/T8LZFrKfj0GN1Wg2h66K5PCG6CokhXyB1emXdbhtchz54kV5/L8Tu96
opIg3QD7IbSPVViizsWRuWiuWhmEcoiw8rYV8pgHSHVTbOskpfxRs7uydpWnz0IN
dYuUA/Xrz/3p3kjSDz+USeNLw7x7rBNixxXu7x9YNiGHKTetsGE/o7b/ezUFMbDX
1effexqfscabTod5+2gaN4H2M0O77zF0+imk5zqDsbtNbr3xM7uwG9tz/2kCkaPz
YPVypCRkQRNDVoYR67Jm5+ywXlV16wzGnZvRkafDzudwFJpcy5M=
=tGLR
-----END PGP SIGNATURE-----

--6nl74wwjpxj7es3w--
