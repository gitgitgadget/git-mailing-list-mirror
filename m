Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCA9C4332F
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 20:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392487AbiDUUk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392473AbiDUUkx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 16:40:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE144DF79
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 13:38:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 38CB2320470B;
        Thu, 21 Apr 2022 16:38:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Apr 2022 16:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1650573479; x=1650659879; bh=CaXgXmnJux
        Aj15FERNc9EYn72QZXG1b4I/dbAlcNdMU=; b=PbHjoryozdl5rvNKl+RB7O91g/
        BCWFSba9Lwis15BGhheLv2G0JGyX0vVf0hKkGGkMdyeurvbqp0U4rQuj10oiUu1K
        xsxmOoXBx9UflM/0JTMQ+i9yp2gzdC1yVwlSE0SyWAdk60OBKCaq1bO6PCFwIRfd
        pt/PzrDzoL4j+AAZjlYN7oWRz6iqhe5mYQk1t8INz5jVnhZGHZ1yuCgkXdRmpXHk
        +Sf70614LCVi+xsQ3T3B/x8GTjdgr1aC9d9v+sV50QN0Gu4Ss3kVNYoylguqikRj
        cZDOKIiNP3AErFmWjj3a6tFkRG2YolEq+D+a7ixe9HAqroowg7L7CFvUbLHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650573479; x=
        1650659879; bh=CaXgXmnJuxAj15FERNc9EYn72QZXG1b4I/dbAlcNdMU=; b=t
        YNmcutWGAffhqpBJQOxQ/Q8zjPWrwOPwwN7D4phXaKuoLACoaKbmYippU6lfR4+v
        RubcuaiGQsu/0pSdIR9j4TWUUOTaV2eJbuSnYnEOWEipIfz1J08HPp6zETx/aMwp
        KS37ApJ04Xt7qyJUt1itWtVdWQIunTpSFOQqJiivm5fN4MzbpQ3Z//wAiZ/UWMG0
        c0ZiYFSrLtDxjDR4IHtauvbzBlphoSvQqwKLht9gasmH3quuW+MpFrpaQVDNKWo4
        mYV9bYkyf6TVHNfTiOuaQ3dExbsQN6xgKa975Atm620yOZe5A1Cg9hygZ2LXCH/O
        gnnEDUvEwdFGoeVDjx6AQ==
X-ME-Sender: <xms:p8BhYnSo1_d-c3IyfY5OJ0fFCRpY3_fQ9lxu0LuFYpKXXlH8AdovPg>
    <xme:p8BhYowNEXN0wyy8Ak4VYnFBomY9bKjTquiS-FU_-Cx670qDjqRKrWe8u76GiGp5P
    Vj6aN9dak-ZdWGxuw>
X-ME-Received: <xmr:p8BhYs3k3iz0KRgYVYmDfF16FW0ly7_ffSBXUXe0YurSG0Jv6RRU9l75PrQf6H7jUyggl-hQyKINVHyj93vEr_Xovtk_kxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtddvgdduheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdr
    ihhsqeenucggtffrrghtthgvrhhnpeegjeeigeejhffgffehueeludevhfeiffefudegvd
    egudfhudejheefhfeugfeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehqhihlihhsshesvghvvgdrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:p8BhYnAFV1SU3tb5aZWHGIaIOnMaZgo1K2l7oeHMOGsQqJShvjRHow>
    <xmx:p8BhYgi1c3fg4myqOvBtNhMfepGLtA6yC4CMs4M4iovo4CGHrowSXA>
    <xmx:p8BhYrrgLyXTBvwvWD4xRyVN4p4R_dIbWRSFgPgIxRXHFuVOtpheSw>
    <xmx:p8BhYsZOH2BRztdBYCcZ1engcAZ3WrHzRhBDypy_yuF7VQN5hbHSqw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 16:37:59 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 11E5ADD; Thu, 21 Apr 2022 20:37:57 +0000 (UTC)
Date:   Thu, 21 Apr 2022 20:37:57 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Should sendemail.confirm default to always?
Message-ID: <20220421203757.btisgy3bit4iboxv@eve>
References: <20220421194832.lshqkl3bogy2f2hy@eve>
 <xmqq8rrygq42.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dewrnrohxygv7pry"
Content-Disposition: inline
In-Reply-To: <xmqq8rrygq42.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dewrnrohxygv7pry
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2022 at 01:04:29PM -0700, Junio C Hamano wrote:
> Alyssa Ross <hi@alyssa.is> writes:
>
> > I was recently having a conversation with some people used to the
> > GitHub-style Pull Request workflow, who told me that they feel scared of
> > using git send-email in case they make a mistake and e.g. get the
> > recipients wrong, since they can't correct it after sending.  They can
> > resend, but if they do that they'll feel like they're bothering some
> > very busy people by having sent them the same message twice (regardless
> > of whether those people are actually bothered by it, it's scary).
>
> If it truly makes sense to give a roadblock before sending to
> prevent mistakes, I wonder if making "--dry-run" the default is even
> a better idea.  Getting "are you sure [y/n]?" and saying "yes" out
> of inertia is much more likely to happen than typing Ctrl-P on the
> command line to take the previous command (which did a dry-run by
> default) back on the command line and then adding "--no-dry-run" on
> the command line to allow the command to actually send out the
> files.

In all the time I've been using sendemail.confirm =3D always, I've never
accidentally said "yes".  I'd be curious whether =C3=86var has, since they
also said they've used it for some time.

I think always confirming is better than --dry-run because it allows
making a decision for each message in a series, and because it makes it
easy to insert commentary.  (If you end up sending the first few
messages in a series, then deciding not to send the rest before fixing
something, the man page is good enough that it's possible to figure out
how to resume sending, in my experience.)

If you had to pass --no-dry-run every time, I'd worry about that being
replayed unthinkingly from shell history, defeating the purpose.  By
contrast, interactive per-message confirmation won't end up with the
bypass being automatically saved in shell history.

> Another idea is to forbid the form of "git send-email" invocation
> that internally runs format-patch by default and force users to
> prepare format-patch into files beforehand.  Doing the format-patch
> as a completely separate step means that the user has a final chance
> to proofread the log messages (and correct them as needed) while
> adding and verifying CC's, and removes the pressure of "pressing
> this button is a point of no return; did I catch all the
> embarrassing mistakes?" at the last second.

I thought about that, but I don't think it would be as good either,
because it's difficult to predict what the final set of recipients will
be just from looking at the patch files =E2=80=94 if I recall correctly,
automatic CCs (from trailers, cccmd, etc.) aren't added until send-email
time.  So even though I often run format-patch beforehand, I'm still
grateful to be prompted before each message.

I also think that encouraging novices to format-patch first would make
the workflow seem even more arcane and confusing.  I definitely found it
very strange the first time I encountered it (more so than all-in-one
send-email).

--dewrnrohxygv7pry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmJhwKMACgkQ+dvtSFmy
ccClZA//RJOfBb6kToJlRX5eRNbsUR4U5n/MHO0gHWu5ZPBcM/5kbzDYM4EqYpnV
s13N5SDZYEPWfczOf+vCVfsCTvLwmKcKdJ7mz0POwuU0cOrrHZBLznDs02t6OmFR
J9XMyENEg9Nu+NCUYX4t61jVyKlZ78MaQxJfvBQ+2UgQObVwkigOSNWm6f8fSl64
Fb1XMNze1sj4mg1+Kb5LIXMUiqQRs7AmLNzhICH0adquTTy1/TaxdfLXEhk72z4H
mR2qOAFdxMnHdOI4H9XXWP7uVR6XNtvn1ZpB3gBfT2OILdkdf0LagVdlbugpGBt+
ybYZyq681itlqzYyBNiXZjXRVNE9WUryfJqTk4X5u3iDKsiJB/epjLBP9EQiDHHg
EX3YH8tYN43aAOOZY64Id4xo4UEBzn3yckktAMlmhCmmwxZXFXnHDB1TGNQw7kgh
zaUrPfYzXiluddFfJ2N76s4F95uU5lGgeliuwHTRHc7K+F2DzaLlmTiP0T3pb+De
VgGqBQNp0vQ8rJLwyE1uJtqGIJassd+ELRIVQR3JhVaPA8reIRneqW7tTnmlNnPn
Q/fDjUYmxtSrcfB1cVivPk2igGtX3UO0VAaz6rtriOKz465P8R4NVtxuUouy2oyJ
ZcPrGB5yCfaCtwVgWM/5vJfutqwDqrlc9vuQn8lwdOPfHmRlCYY=
=T0Eo
-----END PGP SIGNATURE-----

--dewrnrohxygv7pry--
