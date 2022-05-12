Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861ADC433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 13:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354068AbiELNCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354064AbiELNCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 09:02:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B2662133
        for <git@vger.kernel.org>; Thu, 12 May 2022 06:02:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 79C56320028E;
        Thu, 12 May 2022 09:01:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 May 2022 09:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652360516; x=1652446916; bh=LGUuOVL6Re
        xMHJiekp2kLRHbhbkEvtO7tFGOS+9x3w8=; b=ecv5Rl0kBRzE29lABtvJThrUxX
        BUBkld1NxXryAVLdHtygHG+k2DH9OsK870ir/nHyW4R0OWKpmAV7E2MU666wrKXl
        cez6bQnS3V4lUQJsa2Q90jzTZTcnmIqKD4gnnc2k8//QoA/IZFL4/heOkJFNvJ4m
        swcU9BEk6fbm2bmcxN/YmUW8VXgR1k+R2DjaTm7lZFZE2vC9pe3JEm6jlvH2qzZV
        TfmUCc4t2GzOLpJ/0CbKEmfzD8FCSGprh2q68OTy+4FDL99i3TnI5s0laQwrTg/B
        xpRR4dk8F0OX+2k8QZRfiqRn8GV/MnAs8ajvxtYcZPzQIr5Un4XjKvyQomnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652360516; x=
        1652446916; bh=LGUuOVL6RexMHJiekp2kLRHbhbkEvtO7tFGOS+9x3w8=; b=p
        +ykPHS2O5cfBxu5H/3Q/v3Pn3ac/wS+qsGKTk6Ies5Bj9TdMtFnNdiGhddg+Zl0x
        /1G+H8RjgVpp9b+i119pyoWTUUJf22P3T37GVnpQzWlKEkw7C9zuYBTCgRBCmgA/
        K7OH5OggxbLUMecuOJ0VfVtzg1B4JmPUUwHubZknZc3C8+utgTq4anvQOqWkGjJ9
        19FDB4BNAgDVRVkTgGYMP6/3HDnWr1913BTHGIjw93qqfR67qS0bYIV9i2heimnI
        6dQ9JloAJkfa5wAGOzpUS2inn31fdBGFKjujuDQ7BSXV2QlEelUXWB8RYvQ/RG7d
        q0qW1gQ6u3dYhgVY8hRyw==
X-ME-Sender: <xms:RAV9YpVBC3j31_2X72-Kq2-nP_2IlSk3jkniKvtA2l2tqByN5LodLA>
    <xme:RAV9YpnmCC0D4yYvyhD9hHNOolw8CUJFFfZXGB4AJ0WoXXJL111ikVD5U2iO4aIRq
    0Pfm_CCrQIUA5CPvg>
X-ME-Received: <xmr:RAV9Ylb9Y2YVFApoLwrK6xtnGJ2maLAa239aQaNiWQgJXz_8_ODOwlmUS-KU5U7KxugY8KXTZWlBH8d0YdiPghOoncfvTcV7jSrDVgqX40JbX_Cu3EuBIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetjeelvdduvedvgefgheeuueekveekkedutdfhteeludfgkeeikeffudetkefgleen
    ucffohhmrghinhephhhtthhpqdhfvghttghhqdhsmhgrrhhtrdhshhdphhhtthhprdgtrg
    hllhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhm
X-ME-Proxy: <xmx:RAV9YsWNWdIj4geJ1r19-jhEfv2w8sQf4QmPhqrBY9qmSHrKR_sSZA>
    <xmx:RAV9YjkfYMlRG2JUy6Izb5s6qFmgOuadlYIdLq-7DfpZWDtqoKmkMA>
    <xmx:RAV9YpcdbdH7jb1fboiBpI6sxopIBCbODGOwYpr2mdiA3NYsrYHH7Q>
    <xmx:RAV9YsDMy-kpnl5ChushPkt133gcdbRFl100yulJDp3GdPZ_aTn29A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 May 2022 09:01:55 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0874d5dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 12 May 2022 13:01:51 +0000 (UTC)
Date:   Thu, 12 May 2022 15:01:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3] http: add custom hostname to IP address resolutions
Message-ID: <Yn0FPkoUNacvctAp@ncase>
References: <20220504104601.136403-1-chriscool@tuxfamily.org>
 <20220509153834.485871-1-chriscool@tuxfamily.org>
 <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OTtI2u7bxrN3BJDG"
Content-Disposition: inline
In-Reply-To: <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OTtI2u7bxrN3BJDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2022 at 11:20:41AM -0700, Carlo Arenas wrote:
> On Mon, May 9, 2022 at 8:38 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index f92c79c132..4a8dbb7eee 100755
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to =
v0 to match server' '
> >         grep symref=3DHEAD:refs/heads/ trace
> >  '
> >
> > +test_expect_success 'passing hostname resolution information works' '
> > +       BOGUS_HOST=3Dgitbogusexamplehost.com &&
> > +       BOGUS_HTTPD_URL=3D$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
> > +       test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" =
>/dev/null &&
> > +       git -c "http.curloptResolve=3D$BOGUS_HOST:$LIB_HTTPD_PORT:127.0=
=2E0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
> > +'
>=20
> Is setting it up as a command line config option the way you expect to
> use this, and if so why not make it a full blown command line option
> with the previous caveats that were discussed before?

If you did this as a command-line option, you'd now be forced to add it
to every single command you want to support this: git-fetch, git-pull,
git-remote, git-ls-remote and maybe others I forgot about. On the other
hand, by having this as a configuration variable in `http.c` all of
those commands benefit the same.

Furthermore, using a config option is a lot more flexible: you can
persist it at different levels of your gitconfig, can easily inject it
in a script via the use of environment variables, or directly override
it when spawning a command with `-c`.

Overall, I think it is preferable to keep this as an option as opposed
to adding such an obscure parameter to all of the commands.

> I also think it might be a little confusing (and probably warranted of
> an advice message) if git will decide based on a configuration
> somewhere in its resolution tree that the IP I am connecting is
> different than the one I expect it to use through the system
> configured resolution mechanism for such a thing.

That's true already though, isn't it? A user may set `url.*.insteadOf`
and be surprised at a later point that their URLs are getting redirected
somewhere else. And there's probably a lot more examples where a user
may be confused when forgetting about certain configuration variables
that change the way Git behaves.

I also don't think that using an advise here would be ideal. The main
use case of this configuration variable is going to be servers, and
there is a high chance that they might actually be parsing output of any
such commands. Forcing them to always disable this advise doesn't feel
like the right thing to do.

Patrick

> I assume that if you want to use this frequently, having that advice
> disabled in your global config wouldn't be a hassle, but it might be
> useful to know that I am interacting with a potentially different IP
> when referring to some host by name in my local repo, maybe because I
> forgot to change that setting after some debugging.
>=20
> I am sure all those folks that forget to edit their /etc/hosts after
> they are done with their local site versions might instead use this
> and then be happy to be warned about it later.
>=20
> Carlo

--OTtI2u7bxrN3BJDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmJ9BT0ACgkQVbJhu7ck
PpS0OQ/8Dp2PG0AXVa5HtB3EaqrhStGgb8jtNqDFsQtI5sI9Ss84667BQYT7M8De
EdJRsWdro/qeJM6hMg2SNJkOliEnSTdCzcLUglS1O/o7Gx22t1DWRZJaCdBTGlit
4FcyzAc2RxfIW4A2JxDTDikPPXmeed52ky9iUOb7y99CX/XjgU5MfKFpkwGMji6g
2qdw1M4XNEFAyjEwLq+x4VdFJQGmHsKnwSuRo0J2wQ1NvLy3QJf+kjbLqIChdW17
PmqW7nBAC2MUswlqrHM1sM/3WIY6b1rwdehZ1dktsJnWGuxMD+MvE4Mgos2+yjge
0/NeL/hEMQNYT3QWsclAgMm9O3/5Sp+zGEPGNqRIDGbfYa6p46ky0F0jHez/WO5d
WVci+VIVJhWXGqwaJZhMMMEqBi6vGvKgmjq+M1pJiwdHf/7HCmgj0vaPExj95Ccq
ACXOibqDCeg2aGhFyeJBzi33x9//48k2c3dNg/jN/qybia4qt+TOuY8HoZuIQKqV
aR/kWBW31LObztDLsV6V5hDWqZs6xJzjGvvzOoJ/fsyqOmJBe6N9ad0Hya3IJhqf
5Cf3gxrujVvP+QWLrQQiNsVkH2kTIcgxgUjqtXnd2XlMLfcHB+Nx6LbrLAo7HzVw
62DpRZDVZI+fl7+VbspC1oES0ZFb4Sagw4gWvdKa8nzIdJVBg+E=
=HyfH
-----END PGP SIGNATURE-----

--OTtI2u7bxrN3BJDG--
