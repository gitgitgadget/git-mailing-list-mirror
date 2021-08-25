Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D588AC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47D760F35
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 18:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbhHYSA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 14:00:58 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47097 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240698AbhHYSA5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Aug 2021 14:00:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 487F73200AC3;
        Wed, 25 Aug 2021 14:00:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 25 Aug 2021 14:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=cvQsC88jif+mD3ElLXsOAPwuMBa
        0K8QoQMdNGyHFZ0U=; b=i/s1lyfVKZepZPLonQhrElI0a3rgOvwFk0dh/CRPYLe
        44GFhmF16d6L4BnV+yXxkGFV0LP8Nsc+9FD/hXhzoGRBCp86aEQNP9O7lQ6IlLJJ
        gjBc4uNpB+Ii4Kdakw2swS+eupg62VGkIILBP6en12LD0uhCSmEdLaQdgg8KPIRi
        2rv1a56D0vRXm4CYMkpBO2SSR+/ByprqK/6Yf6mfs5/1O7SCMUNWj0WB7VGEQ5Lx
        ktd/WwpPtF4B4kY+nYDBbhZbAxOEp3cv2YM71UocKCsOszOthlFjemoxkxQoa49S
        jNTRYm21xghU7/gjjQ9llm4TJ/QFSFuiQKq77rd4+eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cvQsC8
        8jif+mD3ElLXsOAPwuMBa0K8QoQMdNGyHFZ0U=; b=BicjNO0Dv3nwJ5JK8mMmsi
        J7OziF0z5+300bCp/8oc+mHsvfcRETKH+M2HfXbYRUh61tXPCP6azVSs6plQYeT8
        6A1Y+jtGxXXfjkqGaxwqAqwxMFqJIZozsIxGp7H3IugZNl4YaJOjJxbzJp3rROnd
        f6PyWlT1n0o6uGyKG+j5neoci33+MlrMVIjmZ1GMOaQZ3XjW6bDdemXL0mTFH7wW
        2jBmoWGuV0tPyrNxJFt7LMF0242eY53RWZv7sfZHtg5nGjOC6Mpf4sUV2gTBAI9g
        ddjxuqaNWINxnYGQ0XYNefSWUjMfd5pnep3HM9CGnR429Z05IxZQFvIF+Eabd7Qg
        ==
X-ME-Sender: <xms:KoUmYXhfHa3tbjfH8kwLkvQxkjyEmdq1BXyUKnroxH9HFJ6ow5JSiw>
    <xme:KoUmYUCS3XMiotvuDKuqUz6W2bTLtqPpmITlEHoarub-HPgOkEFGQUvItxTzwhotN
    43InUXTiNkW2s4ltw>
X-ME-Received: <xmr:KoUmYXEdHbGWoPzLuIgdTFsaqXPMcYq1O4O821sUno6q58myDqecMlumwJ-RdGTqB8XNrA3OnZEQa0D2DpaJb1-Oosj051rseBk54gdrfRTvriFDwuUeDeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtledguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtffejieduudelhedvgfetieefleehje
    etvdetudeitdetvddtfffffefhvdfggfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KoUmYUR76Pil7FK36zPNA2Y6odXphImjYgiDgET3b6XOGaSPbmeVqA>
    <xmx:KoUmYUxYr7CoMj1VOjq3xBbSFR6mPDgqAlIhio5vfCEovUcX5V3m3w>
    <xmx:KoUmYa5885Img4vZm-LDr1PsG3F05wy9CqZmfQaEAxwlBNqkRjo1UA>
    <xmx:KoUmYRorsqI5qzXvZVIof5Tp2wqxyVgLcACuGApKzdohG-ApAMeSew>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Aug 2021 14:00:09 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e89b8d96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Aug 2021 18:00:06 +0000 (UTC)
Date:   Wed, 25 Aug 2021 20:03:06 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] fetch: skip formatting updated refs with `--quiet`
Message-ID: <YSaF2h67u1WTz1b3@tanuki>
References: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
 <xmqqv93tif9g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FN6Y6aJDyyyhrYxL"
Content-Disposition: inline
In-Reply-To: <xmqqv93tif9g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FN6Y6aJDyyyhrYxL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 10:51:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When fetching, Git will by default print a list of all updated refs in a
> > nicely formatted table. In order to come up with this table, Git needs
> > to iterate refs twice: first to determine the maximum column width, and
> > a second time to actually format these changed refs.
> >
> > While this table will not be printed in case the user passes `--quiet`,
> > we still go out of our way and do all these steps. In fact, we even do
> > more work compared to not passing `--quiet`: without the flag, we will
> > skip all references in the column width computation which have not been
> > updated, but if it is set we will now compute widths for all refs.
>=20
> Interesting.  This line
>=20
> 	/* uptodate lines are only shown on high verbosity level */
> 	if (!verbosity && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
> 		return;
>=20
> at the beginning of the adjust_refcol_width() function indeed does
> not skip if verbosity is negative, so the comment is wrong---it is
> not only computed on high verbosity level.  Why doesn't this patch
> include a change like this then?
>=20
> 	if (verbosity <=3D 0 || oideq(&ref->peer_ref->old_oid, &ref->old_oid))
> 		return;

This was indeed my first iteration. But if we just fix the condition
like you do here, then we still iterate over all refs even though we
know that we're not going to do anything with them. So my version just
skips over the iteration completely.

> Another thing I notice is this part from store_updated_refs():
>=20
> 			if (note.len) {
> 				if (verbosity >=3D 0 && !shown_url) {
> 					fprintf(stderr, _("From %.*s\n"),
> 							url_len, url);
> 					shown_url =3D 1;
> 				}
> 				if (verbosity >=3D 0)
> 					fprintf(stderr, " %s\n", note.buf);
> 			}
>=20
> We no longer need to check for verbosity, right?

Right. It would be less obvious though that we indeed never print to the
buffer if `verbosity < 0`, which is why I bailed on that refactoring.

I wonder whether we can just refactor this such that the buffer is
caller-provided. If `--quiet`, the caller just passes a `NULL` pointer
so it's explicit that it cannot be written to. This would also address
=C6var's feedback about the "tricky action at a distance", which is valid
criticism in my eyes.

Patrick

--FN6Y6aJDyyyhrYxL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEmhdkACgkQVbJhu7ck
PpR4iRAAqItWfQydLiF0u8coj2VQDhESqkT2ZoXJnnXluYwPmT5nScCodIJ470oo
ZTAWYhIph8mjkMHkwHqlq+sqB1C4Zp1WUjmK63fwj1ShObmE8aW8sHdK6ULFuYez
S5c508qIyA7Z7oc/GdmdMfVhok75tu2iQQjZTojLGinhvFumkFbXZWjqKYroNips
APEhy/1CXZkQnpAr+SrnBRYVLZMISDShM1At+IZnS0KcfDhFHobmOE0ucxsT8ppq
d5Kfcv9PThJywOB/y8P+RiViXm7RVFFKrf7e5H5FAMdsoQb37H9IRVgpNEgcjRS0
aOQ98LaO70t2DSY5hhkkjYgV6c3/9yFPCx/j2aSvN5fYfjp1M84bojakcioQlyy3
T7xi52dbF55kqUdwcHFz3ZGnSIdh5cKoVLBRPs0jpeUe45OEXMJM4Im4VZLgUFHT
MZ+YEGy/w0kVQek6sq8BuU8IOY6cNh85SzJtuAfEGekBY5tYN/DM4Q8ShXg6jwVJ
t65/ksnYYI6Hgecdm59eZkGxg3ghJhTuRi9kFjyRKekwVRItCBzwwnfzIwEJeAt1
Q4BRzmVOKVaKmDgKwfjC2URo3NerMKVWe0TTb5vth7nkUAAOrjBbK+gLEpECfCMK
luP/Bh7XZLMkcbiZQ9g4Z9WPmVLFBgfVXTniUZ4Dvko3aEV6cuQ=
=qzEn
-----END PGP SIGNATURE-----

--FN6Y6aJDyyyhrYxL--
