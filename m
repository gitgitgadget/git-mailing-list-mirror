Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39DDC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 06:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiKKGuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKKGuC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 01:50:02 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9366C73A
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 22:50:01 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7A9BB3200935;
        Fri, 11 Nov 2022 01:49:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Nov 2022 01:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668149399; x=1668235799; bh=QNI8Rbb5Tm
        XGQu3/3gYTspNT24g8aC846zBIrCsfWLc=; b=F/C6uZ3G/bdDkL1oYi1OsbFk0u
        tPTxOhRN9lzfWao3MQYXITuzsP1W3xRz7P0kjoXUlzVo58KU3Uzn5V1QjlmUOmdp
        D7cngox2ueOtK2zfpI15Xklj/Kbdj8KNdBIPSAGiM5O3glI0v3Z18jn1zu3urSzm
        ncbLCrV+8cW7ZWEGdZejiD0in6FXFY3mWnKjcidoTEI6cGsaQYfDdLtmoIwU8bkF
        7xcZVSF/NsHI1c4NXxxP8gLP1kUXR1hGw11Fw8kr4ZrTX2e4XPjytggmKQlZtLSu
        lJHaC+ZE78mnAYTaNB20TIyl2qszypCkNIrDp2t5LHPWshx6vTIr4OdgYlAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668149399; x=1668235799; bh=QNI8Rbb5TmXGQu3/3gYTspNT24g8
        aC846zBIrCsfWLc=; b=Mx/5y+8n0UtmcW1lO7xgJo/eR/Zi7oLA1XwMrrDGq2Z+
        Vu3XNua+TKcGlQj82ygrqzlzny7fqixqOt9Suf4vyGeCfyd4ifA1aMPSG5sW2HMn
        m7/Q1L82iVJ3t8hXTDdl5dgIVWTdNlZKfONv55LkA4FuOES0ABHKIuQ8HFekS2Ko
        FWZFyOZBUm2Vvz5i7Ysh6QWlD4WuyjGeToC8L5/b6BPqpP5Juvsp917m+gTolCTE
        mYZ1YF8+VtECG+mTD4Xv3Knrh1m0VcU5t+EdCTdBoVpWjNX6wtJOxHPUcfpgFK0d
        qCZN3Ly7N/tqN2SNBB2K5jMMTddLcwfLQY+pLUzgXA==
X-ME-Sender: <xms:lvBtYysvLEwKKmCqYNB8NE8FKR3wdZUpsWZ1ZI8BAHeAP7GWcdDLBA>
    <xme:lvBtY3fTyi5TxpjPV5h-qdW9lXQzSEhlE8JAsp5FlxuuEQcYGjDqjg1tSoXaTFcDO
    BKhiPeyGwsHPDZX2w>
X-ME-Received: <xmr:lvBtY9xLbUG2I21kL7DhO15kyU-eIDB84KY0nBaOb9bKcj7Axt41c6l-lW8lgmD_f26YzM1fkn20gJanPrW6ET6DeJBLtmLTAGIoT3N8bZ7JVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:lvBtY9NgZAn6qF14FQX2iqrBFSLCY8QN7dkoKPcsAJw8WHrF7XdYGQ>
    <xmx:lvBtYy-Qgqeoqioqk4nRabU7mUKOylbK4u4Z00hqRzng0D55DkXMQw>
    <xmx:lvBtY1U6XM5MXkzTZvQh6PahlEt73ZpHca64jAvUHDMzFzbIDzlE6g>
    <xmx:l_BtY5a1DwHFKoPnukHrck1NLVBHnS0OF8KyZbdChbU1T5C_IWo8GA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 01:49:57 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a092501c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 06:49:53 +0000 (UTC)
Date:   Fri, 11 Nov 2022 07:49:54 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 1/7] refs: fix memory leak when parsing hideRefs config
Message-ID: <cfab8ba1a20c8a178815723504b16a5f10b5c413.1668149149.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1668149149.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="08vjOGzHqXxIvVWC"
Content-Disposition: inline
In-Reply-To: <cover.1668149149.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--08vjOGzHqXxIvVWC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When parsing the hideRefs configuration, we first duplicate the config
value so that we can modify it. We then subsequently append it to the
`hide_refs` string list, which is initialized with `strdup_strings`
enabled. As a consequence we again reallocate the string, but never
free the first duplicate and thus have a memory leak.

While we never clean up the static `hide_refs` variable anyway, this is
no excuse to make the leak worse by leaking every value twice. We are
also about to change the way this variable will be handled so that we do
indeed start to clean it up. So let's fix the memory leak by using the
`string_list_append_nodup()` so that we pass ownership of the allocated
string to `hide_refs`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 1491ae937e..a4ab264d74 100644
--- a/refs.c
+++ b/refs.c
@@ -1435,7 +1435,7 @@ int parse_hide_refs_config(const char *var, const cha=
r *value, const char *secti
 			CALLOC_ARRAY(hide_refs, 1);
 			hide_refs->strdup_strings =3D 1;
 		}
-		string_list_append(hide_refs, ref);
+		string_list_append_nodup(hide_refs, ref);
 	}
 	return 0;
 }
--=20
2.38.1


--08vjOGzHqXxIvVWC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt8JEACgkQVbJhu7ck
PpSAGQ/+KSkV3PxQXVXGah95g75zFowFZRJpR+TDzRMj3L2FLF9R+xwqPnJNOQI4
4zuBaLhSREwacIfdUEaJhw1bmv5WXIt5cGLnRDdUE0m3PK4eegBxGA/2HfvHBBXA
ynWfBV1Hx6Ll5fOdCYt3o7DgrP9H1XzPS3Dc0vfX4De+XSvGPyRv6zU8sUvc46WA
kl+nsWCoFH4w2sm3EFtb14nRynWjr0LkK8OlOob574fu0e6tGppdLUon6v/eim5p
ihzj4V3qM5uCZKD+QYdREF3fxzcatVIQBpQY6KpaEWnEeRC31BnOH7PdsKt3q/sl
K25XIZM6lkR/SENG/PsGhwc7r0JWkNMoBYO3fVdAqYrugVGOY1mK4qcIhDHIipVB
odLonBS1E1w4zsVEEy9Vyd8nxTzZu69qJ9RdQ8Y5Riit+/R2lel7es5ijTnkeqYF
dTBL2IwSjYZZSuV87OhmkdV/5e4ogPesaIxnk5u7+ENUCr98I4XGLQqRD72aYUGp
MggI2bEevJMi2opWp1l9caOjuOwVP9j2UUd5I3bkDJJpIVyHFFvLDSeH899h1AHT
5EekAyQ5jfHcAq9D+YQ7GOpmXMoXlUAmxxC6lRw5mG8YPnyTvwTI9WwmweYoDQQK
1su7KcMOnXyIlUbT7KF6A1wUhuieseaGgKDICGh7y7GsyHPt3g4=
=xw9S
-----END PGP SIGNATURE-----

--08vjOGzHqXxIvVWC--
