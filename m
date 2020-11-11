Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC41BC388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AC120756
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 10:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lrbDd2Py";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wgmtdkb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKKKAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 05:00:23 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46935 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbgKKKAW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Nov 2020 05:00:22 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 899035C033D;
        Wed, 11 Nov 2020 05:00:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Nov 2020 05:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jYpj+14CgasWuhEsBqaXAixGo2r
        s062WcQacMFG452Q=; b=lrbDd2PynyhHi6kNsl7vDfhtpHZ3WfWccSHYvp5vuj7
        2znO3qQSWxdwhS1UdI6Ynk7Kjw2WuZfIosQpnihKgXJ9Ho79GeFyRzDtD38numUW
        D8hXtK2D8U4WCqVKzY7v5dI6osjPvOKq6alL8ulMG9SJBmKrlFMdUERWjGdkUhhA
        Hxz1FgXZ9C1DXatGIRp5cNCfL2S9Ia8UubPInYQBWtPb9FLIOwzLoD6p36VHEVoh
        F0mVDH093GmmDaAg80VRLQ7DUYhVY4gjey5QoHLE3yZGoWULlfghbF1fnGOcN1+f
        7rcqCiPU4J3eFTg0h5Y3hDB3RFhSGbOs/IJDZu9hLZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jYpj+1
        4CgasWuhEsBqaXAixGo2rs062WcQacMFG452Q=; b=Wgmtdkb01Q7KOr/ZU8TJXl
        SlwhU1VcDBKgHSq7e3ATjh+tit+6W3gwmmt0BuEQMqaaXCtAKdFp6Pq6Furyri6V
        AOG442SKIaqsjVoF+qcDHvLrXtwqhii6JCzSzmE8ecZ/IW7HNSOSD4+rRmZ9MUDI
        g+ObQW73kyzsntU5KbeOpqkouanTjQTF3u63LflCKHKYRBFZivcKpSAU5SyAD/l9
        u1R4nlA2hcm3evCxTYeGi9DHvp7pGPO2Q+CZwzxi56PfajFxH25K0VYhTsNST+ct
        rFvcO27W5lTJfWNim4DOcjZxV8dTsZRmDz4soAOFkouevZYyOyBKtcHyYemvI08A
        ==
X-ME-Sender: <xms:NbarX50WZadHsLvzmdpJ3eMJlvunmqLcq0ipm_TlBxNfMInVhHq5MQ>
    <xme:NbarXwHLDV8nYPGEtMZSCH0cSelkcOXVREtGERgUPCVqZp_qmpCli9AfOX0TZHywF
    8PT0pvkuQKLJx1ThA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtffejieduudelhedvgfetieefleehje
    etvdetudeitdetvddtfffffefhvdfggfenucfkphepkeelrddugedriedvrdekkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:NbarX56tjtfpoFyLQHkVSjyEWkP4ROfAzJ3ZHnVo7qAr7Km9wjXoXQ>
    <xmx:NbarX21MR04JOWeDk5xyWm5iDGzxYqjBbpuV6TJEhhMmVu5Yc8nTUQ>
    <xmx:NbarX8E8xZmkFpy7yvBDg1nAWzAoUseUVDmzS-81NU6iwfTOfAS81Q>
    <xmx:NbarX2OYwDme4unfji2ILIRgDlJ0tUBtapwuXqq-ta6RpUA4JA7udw>
Received: from vm-mail.pks.im (dynamic-089-014-062-088.89.14.pool.telefonica.de [89.14.62.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id 83CEE3280066;
        Wed, 11 Nov 2020 05:00:20 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2a43db1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Nov 2020 10:00:15 +0000 (UTC)
Date:   Wed, 11 Nov 2020 11:00:15 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v3 1/4] t1400: avoid touching refs on filesystem
Message-ID: <X6u2Lz9khi+DeF87@ncase>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
 <e66b1bcc62139f62866dc9f25856eaebfe107056.1605077740.git.ps@pks.im>
 <20201111090454.GA4270@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0VbofZ+Ix015ieWd"
Content-Disposition: inline
In-Reply-To: <20201111090454.GA4270@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0VbofZ+Ix015ieWd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2020 at 10:04:54AM +0100, SZEDER G=E1bor wrote:
> On Wed, Nov 11, 2020 at 07:58:38AM +0100, Patrick Steinhardt wrote:
> > The testcase t1400 exercises the git-update-ref(1) utility. To do so,
> > many tests directly read and write references via the filesystem,
> > assuming that we always use loose and/or packed references. While this
> > is true now, it'll change with the introduction of the reftable backend.
> >=20
> > Convert those tests to use git-update-ref(1) and git-show-ref(1) where
> > possible. As some tests exercise behaviour with broken references and
> > neither of those tools actually allows writing or reading broken
> > references, this commit doesn't adjust all tests.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t1400-update-ref.sh | 72 +++++++++++++++++++++++--------------------
> >  1 file changed, 39 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> > index 4c01e08551..d7a57488ed 100755
> > --- a/t/t1400-update-ref.sh
> > +++ b/t/t1400-update-ref.sh
>=20
> > @@ -188,27 +194,26 @@ test_expect_success "move $m (by HEAD)" '
> >  	test $B =3D $(git show-ref -s --verify $m)
> >  '
> >  test_expect_success "delete $m (by HEAD) should remove both packed and=
 loose $m" '
> > -	test_when_finished "rm -f .git/$m" &&
> > +	test_when_finished "rm -f git update-ref -d $m" &&
>=20
> There is a leftover 'rm -f' here.

Oops, thanks a lot for catching. Funny that it still passed.

Patrick

--0VbofZ+Ix015ieWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+rti4ACgkQVbJhu7ck
PpSotxAAgh6xvNG7TGevWd7IZz5lYn72l1ikqyGydwgbceS5VbdK/sTChvncN6hF
8zliRzxl60xbE0gSehW5SINlogYUHg+f1zV1JspC1PHmJ5CBD52h7UDcB8QwE14L
AyICXvUdracCbqrvKIG5tgw1W5fOHn9u3ibl8TdjkW1IwhSVWft+2VrjsnIEn5sJ
MnNemzPwlz/wlORJz/2W7zeOLST/pMOvu4pxrEZvsFo1dpWsn8Jfsv7ZaMZe7Gv4
oErmbd+3CzBfCjy67c3AjP77zJDGvgvIdDOT2PpIDpAgp5QHYWv55ctXYeBDL16V
gYuee86Qy2T611fEbzpRplpPLEr8AUAPLSgPypvJNF5KakApx2tt3uN+RrUPuLVb
phpJorzhDAOaofNydI6iWGlMmXk1LHvZC1mJNz6IBSwnwMp27zHURnsXVueS3Gqx
pYJY3QNljVnEIwpIUjPuwAvMkp3U6noBf7dK/8ZG4XuGsHLz6xmBmzMfBMoyVDOJ
2PqvucMjGXQbZQY3EJEc9tGT/orCOR5Mcm2AlfXlh1GZJg9spWppVIE/cOY3ZBW1
damc3zaz9suIkH2bZ2IHtkpxz4xdndieUjyPWzb3198h2oZf28iwvAjrxOzaEIGT
2aUlLEN1Ne1Is4okQXdLhLDYJo6bpapFC43LThu/UKdai4/ZgHY=
=m4gI
-----END PGP SIGNATURE-----

--0VbofZ+Ix015ieWd--
