Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1AAC74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 10:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCQKDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjCQKDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 06:03:09 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5048E52F55
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 03:03:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BB6CE3200B82;
        Fri, 17 Mar 2023 06:03:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 17 Mar 2023 06:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679047387; x=1679133787; bh=Bz
        9sEIcCVcM7WMz43DH4upsX4NmzZyl4GELuz9yEgrM=; b=Fv4DajkvmH9rAcCMRc
        Lhn1LPIOBrUhs4/5pu1mdkMIQSmkWzsd9dNiIaJFouJ0Z8GeKNBQ4e0D8KHEU0Uj
        8DxpyfaoibNbGBhFEEjF4pD9xurG0jQRumQ69tLsMFjVWKp4AQPBoc9sh3+aD9pS
        oTy8lbvFquGXDJi+rq+qvPb0+sw8RvSiALRGK9t6CrO5OujlbYcMo/wSiWms7m1y
        tgIdVqBIeCv1p2/RWwdukykHIm6MqrJlhRC3gnRFHzhq6wcb5xWvfVTQLEFVaIzK
        RoYbuRC/Gc1EMnx6Xikw0lcMaMqk+koz6ywXhE/dRV9Zecib4gDQMf2z/1KO0l3X
        piqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679047387; x=1679133787; bh=Bz9sEIcCVcM7W
        Mz43DH4upsX4NmzZyl4GELuz9yEgrM=; b=biRHaS7YDQHAPG8imJaEVVsMrgJPA
        x4BnP7ZNA/GygEWFwoUH6hy+Np74+5gUo021/qnYaU/btCDWXY5wgnCxl28XsifT
        drcgDGF/QQvnu6VxEbo8atAUf0ji8FYNxlneyNfrryOB8MDbfVk8vR28SaVfj3Po
        vp8ecba7ROBZ0RNYV00yeJ94Qx0N8Nc0dJsDScJMiuyav8OPe2wQ+floz3+2IFfW
        +4SaX7Riv0zvhS24xZr05CJrN535ouoqOgAKBYBi40z2cs7WWwzOYkZ2ckdx2X3R
        P8Cp7mQl5ToZDWR9HErEi9XTMJGjR5s85yXqf8XP5EloK3lQzzh0RosOQ==
X-ME-Sender: <xms:2zoUZBTXHWwReyqVKfXa3PFdFK-GzPB4ccS43JaiIgqrnDg78uU_cg>
    <xme:2zoUZKynVr4FTmkP_emWC-CDb2ficn-rhpmsAhv1fl3lJkt2BkMnhSaTAOVbcpNHp
    2LpzpzZp8OGiy80UQ>
X-ME-Received: <xmr:2zoUZG1EepeNrFSigg6MTgfQkab5NE-Lp2fiUfoxwaTGnNBZ76saelh96KAwCpO2MCopEMhvhdXKpq6Bb79CgNXzMF1anL0QNMD3EfyHKBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefvddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2zoUZJB86Dce1JfzoZTMEE1mg2bzsxBfh2ODQUP1ZZuXCbBnQppv_g>
    <xmx:2zoUZKgt6p5eom51W8Yb9OteAFRsPBktvNxlXmwJkashyT7HhuQp0w>
    <xmx:2zoUZNr8gFbQEwEgqZ-DXqZQOupg2D0Oq2GNuz6PiSB1Ic8tHaKePg>
    <xmx:2zoUZCKiUDZkf_qWHJddGS8BGJePD8yXc6F-qHos8L_H7tWJWesBwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Mar 2023 06:03:06 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1842c3c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 17 Mar 2023 10:02:38 +0000 (UTC)
Date:   Fri, 17 Mar 2023 11:03:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/8] fetch: move reference width calculation into
 `display_state`
Message-ID: <ZBQ612KWqYg4ky2j@ncase>
References: <cover.1678878623.git.ps@pks.im>
 <aa792b12a468263d05e8615d4b3691ed8fe823ff.1678878623.git.ps@pks.im>
 <xmqqedppohno.fsf@gitster.g>
 <ZBMwUmBhqEd74YAx@ncase>
 <xmqqpm98mzzy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pmzuqRU4kkLsZt6/"
Content-Disposition: inline
In-Reply-To: <xmqqpm98mzzy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pmzuqRU4kkLsZt6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 09:18:09AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Given that in the previous step, what used to be called display got
> >> renamed to display_buffer (I think "buffer" ought to be sufficient
> >> in this context, though), the variable of "struct display_state"
> >> type should NOT be named "display", as it would be confusing when
> >> two things are related to "display" and only one of them is called
> >> as such.  Either "display_state" or "state" would be fine.
> >
> > Fair enough. In that case I may just as well drop the first patch.
>=20
> If you plan to get rid of an independent "display_buffer" in the
> endgame by moving it into the bigger struct as its .buffer member,
> then I think the naming is fine as there will remain only one thing
> that is "display".  The fact that I didn't see that plan through
> when I read only the first two patches would probably mean that the
> route this iteration of the series took was somewhat roundabout, and
> there may be a more transparent and possibly a more direct way to
> get to that goal?
>=20
> I am not entirely sure if the buffer should go inside the
> display_state structure in the endgame.  An alternative may be to
> make it a on-stack variable of format_display() (which will later be
> modified to do everything up to and including writing out the
> result) and pass it through the callchain below to its helpers, just
> like the current code already does.  And in such an approach, you'd
> still need to name that variable passed to the helper functions
> called by format_display()---"buffer" would be a good name for that.

Well, we could make it an on-stack variable just fine. But I suspect
that the only reason that this buffer exists is to optimize memory
allocations: a git-fetch(1) can easily end up printing thousands or even
hundreds of thousands of updated references, and reallocating that
buffer for each of them is quite wasteful.

Another alternative would be to make the buffer static and local to the
function. But you now have shared state again, and furthermore you have
no easy way to unleak its contents.

In the end, I think that having the buffer as a member of the display
state is the most straight-forward approach. It's self-contained and
allows us to reduce the number of allocations to a minimum. That being
said, I'm obviously biased here.

Patrick

--pmzuqRU4kkLsZt6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQUOtYACgkQVbJhu7ck
PpTykg/9Fd5k8+brJIECgdyI5/MziYWGDUliA5EesNCySmWW0Mzo3GZWwKr39YUJ
XkpB5VmqtiWi+Mj6/o8ynbCkCcehntDAN8ZAVD+es79w42Tvckuyl78uUpL8Yyqa
goWx01sMot/GnMhTTwqKVJh52F+T8nMsY8tSTfc0WvJUd/5oYNlvb9z+8qvDDrlQ
WSdhl4kLecqrXXIMtPZUFYxNDMZ6DJbz/NxMzXWItAYc6MGtSv03kuIEU2VPls1c
3b1Q8f4SZsC/cRSRTYxhXkO7yf8e5s6oikXw5HfODuProPNxVFnWJlLmGBXx+BK3
w8ME1/imzEkVylUotQYOdmiKhThWfp25RNnyZuGhbdoQQLx2ZRaOGCmoiKaQIuEy
SWYJrmLMBY2dRLN3xQy0zQRLk0ga2Q+euhhxTIqh+I27m2a3JG9qnvwM6CLxUSxE
oe1B41VhgcglKgVQSkeTE4D2KsuNT7B79uio4k7QDQreqhsGOGyOGf/rcxoVSXI/
YrqwAY4SiqztBnJcfdkfuy0UZjnzLEDLe7i9KT3Q13SpP8N4am74rv44ik0zrYbf
1XitrCTo14DI+UnF/9Mmwt6FPEJv6OmsDHuRlS1gltVXV3X/s8OSgL6p9tHkvCiz
wDzXtlbwNL+XeudfY37ry+Q4IlcVYYGW1e/qBkvbPwk8BAem3OE=
=1q13
-----END PGP SIGNATURE-----

--pmzuqRU4kkLsZt6/--
