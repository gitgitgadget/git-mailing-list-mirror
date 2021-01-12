Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B42C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EB121D93
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbhALM24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:56 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:33047 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbhALM2y (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:54 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CCDE7A26;
        Tue, 12 Jan 2021 07:27:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Jan 2021 07:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=bS+BxXOY5f/2D1/Kak+84zwulUM
        MAhGZOQ/1/79D7Ao=; b=sCXMMmLdqdbGcnu/HI+hQbfodZ+fzvAN0wUYaWv7Jjw
        3Vog3dXqgR6yi8hQlrsQb6dlWpN30NNh2uASuOHHTnpYH6cg6kw23DWw5l4F0Csn
        MnjVGRlt0PwDURsXQtL5H64uMLzSu/gD5kPU7plG+UIZ5USr4qeoVevb9t0sU1UZ
        CYLlBG6nRvHIM0JQ8g0VAEvgmdZaRrV7uKXLrjhz1491vuPQLMuLTGMDb+Eq8BnZ
        I7H0Poqpd5f2aRd337uIGWQjOkWfL3H7d7sE1K8DNoaNRzVw8Q+FGCgkdq306UVm
        xVrH/ouCg5Bqa2NhScQ2Kgt/C9Up6rPXXYRviHOCN3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=bS+BxX
        OY5f/2D1/Kak+84zwulUMMAhGZOQ/1/79D7Ao=; b=HMUq8RuKX1sQsEdP5vZfCx
        EZgh6M+0C+0IqkAVE8Svi1OpzFgikkrUu3p3Jz7YQGnyzhgWynugQh8O+HrMrZC/
        16ETYplgts+5sLKsEK4hnGq4hIoEWuiP7e1zR/O0Gj8P24TQiRay11qYetHk0qrh
        YEAAYai1iPvYViu5mQkdiH/CMDdwQXcN0+uqn3C1tJZ3/B/1ag1Hp2sL17zb02Nl
        c1CYLaObWyqeHOP4far6jFi3fpGdoRdXTj5TXuWGJN9S+KRcPfn+dQd/Le2BnfRw
        9TUmp1P7Vv/pvwzGFEpwBDO+wT4vL5TAQBs+QXI/LZRx7YB7rEWTI8EldLU8nf9g
        ==
X-ME-Sender: <xms:tJX9X3IqH5K9KzGi7IiQeVzg03oC0pbg5tXpbiL49ubpQcCny9Iu4w>
    <xme:tJX9X7H_9JxN5cCy8dHt_s0x4fTdeoL9PemWeUmLi2EcPKrA3hyzR2dkpBatcFaGC
    nZ49ADaZLX-aM0RyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tJX9X8nZWshUUCjqRmKyvZt6L_KVScUDntnMsZs5zuFkanhFZuz3yA>
    <xmx:tJX9X4I9UMODbztezIIJ1IXKh_RVvKcR6NlWxchi95Z956H4UzyVMg>
    <xmx:tJX9X9YFRL_0ab-ANe2s-ZcSdOamdDsYzO6lHuOVqGRC_8ZqHnKWYg>
    <xmx:tJX9X5Yqawvoy_ERlSD358WJbW9kTRGJjCdjVzyT5CME0BIsV5rQYg>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 91B4B24005E;
        Tue, 12 Jan 2021 07:27:31 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3b266813 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:30 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:29 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/5] fetch: implement support for atomic reference updates
Message-ID: <cover.1610454262.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/h22/Y+T7Utgmd9y"
Content-Disposition: inline
In-Reply-To: <cover.1610027375.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/h22/Y+T7Utgmd9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fourth version of my patch series to implement support for
atomic reference updates for git-fetch(1). It's similar to `git push
--atomic`, only that it applies to the local side. That is the fetch
will either succeed and update all remote references or it will fail and
update none.

Changes compared to v3:

    - Fixed indentation of the switch statement in 1/5.

    - Added my missing SOB to 2/5 and fixed a typo in the commit
      message.

Please see the attached range-diff for more details.

Patrick


Patrick Steinhardt (5):
  fetch: extract writing to FETCH_HEAD
  fetch: use strbuf to format FETCH_HEAD updates
  fetch: refactor `s_update_ref` to use common exit path
  fetch: allow passing a transaction to `s_update_ref()`
  fetch: implement support for atomic reference updates

 Documentation/fetch-options.txt |   4 +
 builtin/fetch.c                 | 228 +++++++++++++++++++++++---------
 remote.h                        |   2 +-
 t/t5510-fetch.sh                | 168 +++++++++++++++++++++++
 4 files changed, 342 insertions(+), 60 deletions(-)

Range-diff against v3:
1:  61dc19a1ca ! 1:  9fcc8b54de fetch: extract writing to FETCH_HEAD
    @@ builtin/fetch.c: static int iterate_ref_map(void *cb_data, struct ob=
ject_id *oid
     +		return;
     +
     +	switch (fetch_head_status) {
    -+		case FETCH_HEAD_NOT_FOR_MERGE:
    -+			merge_status_marker =3D "not-for-merge";
    -+			break;
    -+		case FETCH_HEAD_MERGE:
    -+			merge_status_marker =3D "";
    -+			break;
    -+		default:
    -+			/* do not write anything to FETCH_HEAD */
    -+			return;
    ++	case FETCH_HEAD_NOT_FOR_MERGE:
    ++		merge_status_marker =3D "not-for-merge";
    ++		break;
    ++	case FETCH_HEAD_MERGE:
    ++		merge_status_marker =3D "";
    ++		break;
    ++	default:
    ++		/* do not write anything to FETCH_HEAD */
    ++		return;
     +	}
     +
     +	fprintf(fetch_head->fp, "%s\t%s\t%s",
2:  a19762690e ! 2:  fb8542270a fetch: use strbuf to format FETCH_HEAD upda=
tes
    @@ Commit message
         This commit refactors `append_fetch_head()` to use a `struct strbu=
f` for
         formatting the update which we're about to append to the FETCH_HEAD
         file. While the refactoring doesn't have much of a benefit right n=
ow, it
    -    servers as a preparatory step to implement atomic fetches where we=
 need
    +    serves as a preparatory step to implement atomic fetches where we =
need
         to buffer all updates to FETCH_HEAD and only flush them out if all
         reference updates succeeded.
    =20
         No change in behaviour is expected from this commit.
    =20
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## builtin/fetch.c ##
     @@ builtin/fetch.c: static int iterate_ref_map(void *cb_data, struct o=
bject_id *oid)
     =20
    @@ builtin/fetch.c: static int open_fetch_head(struct fetch_head *fetch=
_head)
      		fetch_head->fp =3D NULL;
      	}
     @@ builtin/fetch.c: static void append_fetch_head(struct fetch_head *f=
etch_head,
    - 			return;
    + 		return;
      	}
     =20
     -	fprintf(fetch_head->fp, "%s\t%s\t%s",
3:  c411f30e09 =3D 3:  ba6908aa8c fetch: refactor `s_update_ref` to use com=
mon exit path
4:  865d357ba7 =3D 4:  7f820f6f83 fetch: allow passing a transaction to `s_=
update_ref()`
5:  6a79e7adcc =3D 5:  0b57d7a651 fetch: implement support for atomic refer=
ence updates
--=20
2.30.0


--/h22/Y+T7Utgmd9y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lbAACgkQVbJhu7ck
PpS8ZhAAjEMT7Trw9sWZILq8oxCFmK6U3m0JFbQiaBOLwTnzkr7dMAIhVuqAims9
ljPez//lCLWYdF6paG6SomI4O5wqk0CU3dOHl7ctG4UfP1sBlCd9rL8/XzG0iGMR
Il1VOS5Rp5Rdn4Ns/qsQj1cy/6ITo8y8lVqO8eyed79pp4+2Ul7sSaCFrEET096m
Txr7CVWcbcuufrhzMl/UrAiwBYd2Jn+HXJ8FDdjJ3iNOxYdA7fyntvGSpSGmXTV9
AcfVWvTsHhr/2bDIo0vGGzbDyJD+lxKWO/8SDIDkXOBKnaYlVcMiIWoh/tw7nLn2
nau+Fsp0GQY/X7LaWvlgWO4Ibs3zVuuUDf13QChTi7RHF3WKJdYdxBVWiLkqqXMv
t0PjJKsY4ArIUO2qn2qC0qZupGti8DILCl2UoWe0jYyAP1obp/eHsae5XgzwZbIS
/nnBHGDjbCuecEQiJL190Z0F0aMxjWvcnVbHvSp3pObWtLgF6P0fFBx4Af60gu4q
qRMSMpWrPyMQA6JuOqTQTEFR9chqanacjKgaEivZWqICYdlr6ChlUBJf6gR1sWE+
Bn/9NsvsSlo7UtSQx0hyoebqWE7IgcqyG01xaCCbnKsreTKKkxYeNbs8WQSmfWMn
TUzHt1XVW0FOQrJzHkFdC6ZPxpZ5UK/h7oS83SBnZDkpNyCLaJ0=
=KeZo
-----END PGP SIGNATURE-----

--/h22/Y+T7Utgmd9y--
