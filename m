Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC449C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 11:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiEBLPp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiEBLPo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 07:15:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9ED2DD1
        for <git@vger.kernel.org>; Mon,  2 May 2022 04:12:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 15141320090B;
        Mon,  2 May 2022 07:12:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 02 May 2022 07:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1651489933; x=1651576333; bh=/VY6IBhn5h
        dK1Kr8nC7IJAG13uuUyyoUWupt0DHVwUI=; b=b8lLgFKBEWCMFPo9gBP5YPk5JR
        inJlhWaE+c5rClYL9Jt1B9BpPoK6QpH9/8x19Vh2MJBPriJ8vPRvFmhmDopiyX0d
        pf1HDrV9t3kZZug4KthOBYCWiqJ9ctMy2zNx3xzKzYaVaZF6mL6VqgX9FekqaNq6
        +v33NNN7kIFWdbPtc0P62Eh4yYv9hjPMrcyLoUhJIeCgkJx9yCn8kQM7scEoU6ip
        tX7jsi1GstXWgvWafyB22N3L/OUFj7hzmAO7wVNiAr5mccrlCC2EYz7jfagXAKJs
        KQgvDG14PBNnqI8qL9QQVotLGmW8pNYQSQmxnSQiRB8YEQOBHhRwa4XPeb0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1651489933; x=
        1651576333; bh=/VY6IBhn5hdK1Kr8nC7IJAG13uuUyyoUWupt0DHVwUI=; b=E
        DF+XPBksj/f+LAEZlqai3uGbEbUGBsbvbah1smW2lLLDr1PpAaRB1PRrhVUYFfvJ
        wfbaw14KMtffbC3rIwH3ALxKDLVNDL0hCT4OrhylDo6aLh3iFOiNTY2jzrIi+TeZ
        GIx8BZhhwlLZkcHYab0s85wwNopQ53ZWY5rlrEZAEybiGL3GDiJaQrFi1MOFDYKn
        w4KzrCZtXcMVISKfuaLQq8oB/FCxCtI3FigQBkpaPI62u52CDL8O91LIxeZy3yjf
        z3dQRr0a9JJDkUqORZcDMWZtHk/msH3Dc8SjOTO+Uetq8tcot3lCoKo0h/ZHswKJ
        NJMVwyLWPh4s7MKztfcoQ==
X-ME-Sender: <xms:jbxvYjsuS8IHEGAhnL2K_6TCSzz-hPsXTQvN9rQ7nyyJcyKKaXqRrQ>
    <xme:jbxvYkfN5VXLw7QvxqNzU88wuO8e2VKMm-8SW7Rp-LyvlAld49eRLTL2MggLivj_h
    H96Db3MrwIapCOAcA>
X-ME-Received: <xmr:jbxvYmyJGtARG0A5GaklNsncqkrFctGZBXGI3_7MnnL0wKITgrpA4-lFYW4Az94sguJWVMxK92w-P-E6ssMYvQzhe0tqFV8ZAaQoVuWYgLRJXkMoPyktH20>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:jbxvYiP3Ng8JuX1p0ukD6-VOCVLpQbBmk54ydAM-LV0jel_jwVQgOA>
    <xmx:jbxvYj9w-EZg2IC_N4Zg9hFEM4RQWjOEKVBk_tNPps7XOiJf8axL7A>
    <xmx:jbxvYiUBmwlL0f4yd1txYaTPbJMfGkPIPJFP6AtzusNofTeK-Zz0wA>
    <xmx:jbxvYlKmo4o2CM8xEJmv2sqaR_15UMi2RoZXLV7n3DNmbtLMGSxGTQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 May 2022 07:12:12 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c42d57ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 2 May 2022 11:12:09 +0000 (UTC)
Date:   Mon, 2 May 2022 13:12:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Michael Heemskerk <mheemskerk@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: reference-transaction regression in 2.36.0-rc1
Message-ID: <Ym+8iCCy5TlfmObq@ncase>
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
 <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
 <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
 <xmqq4k2w92xo.fsf@gitster.g>
 <CAGyf7-EU4aBO5JGfDAK+rkrjMwmDjZdCBeXBh_=z0Cqv=KnCkg@mail.gmail.com>
 <220415.86sfqebhl6.gmgdl@evledraar.gmail.com>
 <xmqqr15ye19j.fsf@gitster.g>
 <CAJDSCnOUQm-doY-xTobPk64oeiSsTd+vSFzsb_cz9BLORAxXGA@mail.gmail.com>
 <YmkjfyB3gIQ2t45V@ncase>
 <CAJDSCnM767fdo6qy085jc9sqezvbBqDD4ikXz1y5tHEjSYED2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xGKfp1lHGmQtZRf+"
Content-Disposition: inline
In-Reply-To: <CAJDSCnM767fdo6qy085jc9sqezvbBqDD4ikXz1y5tHEjSYED2A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xGKfp1lHGmQtZRf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2022 at 11:41:26AM +0200, Michael Heemskerk wrote:
> > > I'd be happy to provide the fix to files_delete_refs in a patch
> > (including
> > > some extra tests) on top of Patrick's
> > > avoid-unnecessary-hook-invocation-with-packed-refs series if and
> > > when that series is unreverted on 'next'.
> >
> > That would be great. To be clear, do the fixes you have also fix the
> > pre-v2.36.0 issues Bryan has mentioned?
> >
>=20
> That is correct. The pre-v2.36.0 issues are caused by files_delete_refs
> first
> preparing and committing a transaction for the packed_ref_store, and then
> iterating over each of the to-be-deleted refs and preparing and committing
> another transaction per ref. This latter transaction triggers the usual
> ABORTED (from packed_ref_store), PREPARED (ref_store),
> COMMITTED (ref_store) callbacks.
>=20
> As far as I can tell, all we need to do is remove the separate transaction
> for
> the packed_ref_store.

Do you mean that we should just get rid of the transaction and instead
delete the refs in the packet-refs backend one by one? If so, then I
think that would be a performance regressions in a lot of places. If you
are deleting a bunch of references at the same time, then you do indeed
want to make this a single packed-refs transaction or otherwise we'd
repeatedly rewrite the whole file. And given that this file can easily
range in the hundreds of megabytes this can easily go into pathological
cases.

I think what we need to do instead is a bit more complicated:

    1. Lock the packed-refs backend. This is to ensure that it's not
       being updated while we update loose refs.

    2. Create a transaction for the loose-refs and queue all refs that
       we are about to delete. Now we're safe to prepate the loose refs,
       and at this point in time nothing has been pruned yet. As a
       result, it is still possible for the reference-transaction hook
       to intervene even if the refs only existed as packed-refs file.

    3. Now we have to prepare and commit the packed-refs file. This is
       to avoid a race where deleting loose refs would uncover anything
       that existed in the packed-refs file already.

    4. Unlock the packed-refs backend.

    5. Commit the loose-refs transaction we have prepared already.

This should be race-free and fix the usecase for aborting ref deletions
via the reference-transaction hook. It has the downside though that
packed-refs are locked for far longer than they had been before because
the lock also spans over preparation of the loose-refs transaction.

> Another thing we need to decide is whether or not to backport the fix to
> 2.36 and possibly older. My suggestion would be to only apply the fix to
> 'next' and NOT backport it to older git versions as changing the
> reference-transaction semantics in a patch release would be unexpected.

The way it sounds like this has been a longer-standing issue.
Furthermore, it's not a regression: it just hasn't ever been working. So
I don't feel like it's critical to backport this.

> > Please let me know whether you want to pursue this and whether you need
> > any further help with it.
> >
>=20
> I'm happy to provide the patch, but assume that I need to wait for Patric=
k's
> series to be reapplied to 'next'? Alternatively, I can send the patch to
> Patrick
> to be included in a reroll of the series.
>=20
> Michael

Given that you said that my patch series made the preexisting problem
worse I'd prefer to first land a proper fix for this issue, and only
then reapply my own patches on top. I'm also happy to fix the issue
myself -- at GitLab, we also care about this working correctly. Just let
me know your preference.

Patrick

--xGKfp1lHGmQtZRf+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmJvvIcACgkQVbJhu7ck
PpST9w/+OarSadAkdIHVlcJQyhcLXQcSIDDPY8Lue1ntFaO0we2bkrXHid9arITC
fHJmXG9ZXnwmOOjs0V9gCr611d6RQZmm41wQpPR2alkzqLIEyoPTpsf/+1IiZBPA
2MQfUWRYylJrmM1OqSaOZiVqJIxRdUMzRlvbv1178TTwKXgzCdY0wdEU54RnxC7o
DQh60coOUMW/aDCXOhPsgOigvMELG6sk5LZUnRPOw5IQZvPZsCclae0aGp4zXSpv
OxZA4Qju0gSsVXfBjuKmTi+p23fzOWIxYRgpgekTrodv2WYXjvXvH9f7mZD3p+ng
T403sXmRSxR0oNdILVOp2l+6rrW0djLOn48llz0rohhPu5R2Ty6KSSYLZbY/5uFx
hbGVQ0uaOiVZsFX+cY1v8nb0QvFDxyTIF4O4wnIZSczC3C5H6hv+IgHyEsvxI+gi
WVF2y7ceHLc1QgEdamgofkZ8FR16SINib2Q3LZxQwdVn5i6nXhNk43Xnx1MPbZUW
JrROy0ZHgz0C05z6+Zcu5Xvu/IVH3vJ2gOcyHwb4D9W8aHthJViUW6z8c7vbawRb
m59hqVz2Syd6bI1MdkNMQurRWqvSO4KYTqvRG2lvzf2X84beLH7tsAgis6EdPBhZ
fB8Rio6GBXVGIA/g/zqXtjNXRqRDE7AM3J6qZ2WT+Xb6E7jObqY=
=wAHR
-----END PGP SIGNATURE-----

--xGKfp1lHGmQtZRf+--
