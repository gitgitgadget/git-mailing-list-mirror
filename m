Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EF8C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCTMfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCTMfj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:35:39 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A421C7F9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:35:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B6C745C0176;
        Mon, 20 Mar 2023 08:35:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Mar 2023 08:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315734; x=1679402134; bh=tM
        OWCJ/PUxNppbY0RHiJmakpjYgYT/Ht+AFXXQNinDw=; b=jIJN+C7Y+Z6ym5exIS
        d3BmS6HCP8IinFuQ3xzzNTYLtncL5gIQOjVpEoJT7FAn1ryVElvMnESmn6vYV5xC
        NH7KYApHGsnEIzZaGIaK+ZO43rzSSPQnYzQz429Wc+EsdHUOmnMPKJKYhkkWDmXz
        s+j3E9eUAAVzm9pDzJ/aJDGeNTb4RWaoxQ4lyR+ZO/ZJbvVz26p9wIhKT8Srys6Q
        CPVy887EbGUmv1J6KGI8ZbQ/u9J9m6Tgrro2BGzD/2hH3F4V5iyZbnRu1yfk6zLF
        6heXLO4h2nk6NyI62XKsnzEo5iPZCrp23RGpAGIZYr1ti9MHI6N7FpmLo/llLWvT
        3EMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315734; x=1679402134; bh=tMOWCJ/PUxNpp
        bY0RHiJmakpjYgYT/Ht+AFXXQNinDw=; b=GPcUSXUYkQ22CXOiDzvaS5h/wrOdf
        mmu7UuOVDO2l4ObGJz9thEoyDfJ9syGLAebrArh/Js2Ezl1mb+WIE1IFTwHAF9JK
        rKHLnvxArvxjFaNKAjQZv+fVvJzhI6xOxR8pWQd5v2J1pjCaYdiuv0HuzoBSc8qU
        Zs/Ew7qYRzc/MjBImY1L2C+C4lR1NGwlUBG4uvPxqoNNys6w72fbV7ejafy4eIWU
        CWNoxAANL8oozKytbp+0F0xTIN8/Wy8PwFZdSizxJjot+H++0s5MHIyAxEBMyYys
        aiOKrXn6Q8x3Y35R/VNtLSBakg+GCrOvtw09m9s0pJk74jG32F99uqp/w==
X-ME-Sender: <xms:FlMYZGHhfAc42d5KY1u0Ki9zrVqsjVEEizZ7JtVpDwMHhfei4VfCfw>
    <xme:FlMYZHU4C461TvP2oNftEKlWa6VxQLcDlMsxxWxfi1wTHoAoGrF5t0qAq7N_ALp5K
    stsX08ZGx0oIl6nag>
X-ME-Received: <xmr:FlMYZAKAvAhuzdvb3orOFRHjRj19QeAzGtvcvwHSnudJKC-Ic2jr7C16ebzkUG0Y4KEVmN3FpJKyRk_mLmNuQpO5Zo0J367s2MX8xx2ySUOtvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FlMYZAG5_xXv7XSqurf18purfOpv5MdQdQmx93F36Hdo22qAlwdlJw>
    <xmx:FlMYZMVvSMWKRfvNU_wcSBtWcKKdNvDm9YmX47UlTvzA8dIXq2bprw>
    <xmx:FlMYZDMxxXRtzHTMHHHJTgFj8B8tX0sbbFpy1yxH23G1BC8_tQHnmw>
    <xmx:FlMYZHeDWiEnD50Fuzo3nb9XQDqY1LRl12sl-7BhZP7iEotufuIqVQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:35:33 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 059b5e82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:35:01 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:35:32 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 4/6] fetch: centralize handling of per-reference format
Message-ID: <e4c1ed4ad5c36839babd8910180f070b62a59ab6.1679315383.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
 <cover.1679315383.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4rUY/rMjp/NXnnEF"
Content-Disposition: inline
In-Reply-To: <cover.1679315383.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4rUY/rMjp/NXnnEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `format_display()` is used to print a single reference
update to a buffer which will then ultimately be printed by the caller.
This architecture causes us to duplicate some logic across the different
callsites of this function. This makes it hard to follow the code as
some parts of the logic are located in one place, while other parts of
the logic are located in a different place. Furthermore, by having the
logic scattered around it becomes quite hard to implement a new output
format for the reference updates.

We can make the logic a whole lot easier to understand by making the
`format_display()` function self-contained so that it handles formatting
and printing of the references. This will eventually allow us to easily
implement a completely different output format, but also opens the door
to conditionally print to either stdout or stderr depending on the
output format.

As a first step towards that goal we move the formatting directive used
by both callers to print a single reference update into this function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 81ba3900cb..a66428dfd8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -885,13 +885,14 @@ static void format_display(struct display_state *disp=
lay_state,
=20
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
-	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
+	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
 	if (!display_state->compact_format)
 		print_remote_to_local(display_state, display_buffer, remote, prettify_re=
fname(local));
 	else
 		print_compact(display_state, display_buffer, remote, prettify_refname(lo=
cal));
 	if (error)
 		strbuf_addf(display_buffer, "  (%s)", error);
+	strbuf_addch(display_buffer, '\n');
 }
=20
 static int update_local_ref(struct ref *ref,
@@ -1271,7 +1272,7 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
 							url_len, url);
 					shown_url =3D 1;
 				}
-				fprintf(stderr, " %s\n", note.buf);
+				fputs(note.buf, stderr);
 			}
 		}
 	}
@@ -1432,7 +1433,7 @@ static int prune_refs(struct display_state *display_s=
tate,
 			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), ref->name,
 				       summary_width);
-			fprintf(stderr, " %s\n",sb.buf);
+			fputs(sb.buf, stderr);
 			strbuf_release(&sb);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
--=20
2.40.0


--4rUY/rMjp/NXnnEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUxMACgkQVbJhu7ck
PpTRZxAApIIhgqDX1y0dbHURGvOf65w5MHBesgzox1PHItz1yzyOkon2a7d1tRt6
+/66CrDYmp+cuJXw4XuiAU8HKZJZpI+hGxahcTh9KRM8KopbKm2mHC0YWS3O018I
hPx5GPIPl/TthW8GEafILX2mSkvL/A8ycSOHGTMNeZMkKXCkhbSrhJWOQtF9q8Y0
+pAvlPcXkWWb1ciwUXhRH69nCZof+GwkDoZqKuDzkmaippAMJDOYhHgBVRZcNP7j
UZ5S+30OXqCxqT6LQSd6sdN0AAZKVLmDT7ai3FwVCnAr2ybf0d5/CL7/3KoptWEq
5jlyb+xuxVse4/Ck3mUvsdUQVudgRB4Gp3Am9QH+M3vmZ5sXu5/7VvuQVkufxNgF
Vuy+2XmGk8Gaazh4mm9LVN1/9gPWgRZHfPH/zs0AN4fLdjWUXWrN33UVJWbeSb70
HDPpT9LQegnaNQThpgzzPqvNicmSwS2gPCHlORbOHMYAmGfpLTcR9wh+1t/PNleg
TOjOewBkXEWwWgfr3r4YjEjQzJlhvSX7O99BX0nlLn65uK0bsheginD/ebqw5ZDB
00U++66uxRAVZFJyedda+GVPNXRQ+McNmcirgAOTKcg+sHYwULq4YdWoBonvRVri
6/zP9GZT1Aefslni5PDZJLKThY6eGrlIwlP4Ri4/nZFVioiPZ3Y=
=XQeT
-----END PGP SIGNATURE-----

--4rUY/rMjp/NXnnEF--
