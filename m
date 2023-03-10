Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EBDC64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 06:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCJGwb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 01:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCJGwY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 01:52:24 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792C8F6014
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 22:52:17 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B84F632008FB;
        Fri, 10 Mar 2023 01:52:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 10 Mar 2023 01:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678431136; x=1678517536; bh=JT
        OStiPmEUWhkJkl5DXkcYsnqyYTA6n6awxkWJj7Hgw=; b=R+hblFPlNjnSrdA6Jx
        jRw5GBEJQlpcbQVoIjf8A+YPIMaeBMMEIHeCgvJDGXgEwmjCnjVg1h6TlB7CHHJU
        kPOOW15N7IJ5k8csbTNWMVxysqrmR2+lV+3Z/bHEtKr9yteijZIX73RvZeS9M+Lx
        Tebhc31h9XSQrAHuu8jeU8zdS7jTV7Xd/LIC8/aWLvnWP5B208bOSbXWuJyBbD1i
        laMIOSS0t9Ru49Zg2EjJwGFfrKf0qQetep44dlk3iZKq8j57lP2z7MflwvwQ96f1
        AJ4mRLXFdZIIergyK4cpVfgAr6p9c0WAPi5ItIVR/d7Oh2lOZOMT7CfIyPZPV33U
        gSbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678431136; x=1678517536; bh=JTOStiPmEUWhk
        Jkl5DXkcYsnqyYTA6n6awxkWJj7Hgw=; b=LpdV22kQFrQUg99tSU1NgpToJwfwW
        nESljB6pm4NZbOHngVOItEd7md7uDyCa28mUAYkzMIzhNcYJpoO0i/E3QFWpFOE6
        kodXWtcb5MIizZzApauob1+w81pdIGHzElwecDHFtnygyK+Q4UBVb8xk0esewnHz
        DvtyJgXXQGZZdB/UIejJcIvbhgwNnk0E4VS9QdC5CIy6ra8jRzIFyK2zzSDtAXyB
        jZ2WF1GtYCaCz5/cm2kPigj3UK5HoLbK+gEu9BA+ka3Me6SOP7u0vJSB+SLQl8jt
        TTCmIQoPACteyNcYeGi8yPTKdY4c+AfgaV1UBYsqrg09diJRsm6xoVgjA==
X-ME-Sender: <xms:oNMKZKbrWTsbhRdx1dZQyJoPOU7EhAJW-8Ix58gGFFFOx0BjPn5mgg>
    <xme:oNMKZNaV_oc0NMeAiJW5Wj8g25qGzja5Tmzg2PZybtMTGI1fRE4zDDYocSOm7XN37
    FfC2U519tD15CWOSg>
X-ME-Received: <xmr:oNMKZE9orE6KKHOk_x0JaCHEe7K2dYlwufc-k8JC12HfBHT6WTWyZd6W0e1JpI29YbnivBYW0T8D8rHBATTVTwkIlSI9YynUI_M1FH-a85x8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddujedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:oNMKZMrP1lTluGD1oSjnkeoW26qX3ZWNvqY4idHWaJOT493J83DqFg>
    <xmx:oNMKZFq5oRRPivS8auMeRJQeWlNXml-XgS-aib1hs5G_1gVmwNofwg>
    <xmx:oNMKZKRjQYFt0JOdjB-XXWrrmY0c7lFfZzBMoct3ofwHhRTQpKGGhw>
    <xmx:oNMKZM3XxIcwkP1uLYSndYOJ76Cf0zgtmcG_RMzFprMg7l3jQSB5aA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Mar 2023 01:52:15 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e0edf11f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 10 Mar 2023 06:52:01 +0000 (UTC)
Date:   Fri, 10 Mar 2023 07:52:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] receive-pack: fix stale packfile locks when dying
Message-ID: <e1ee1d8026a361bc58d16bc741e2b347ada7a53e.1678431076.git.ps@pks.im>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CwF3+5Q/askrvk+7"
Content-Disposition: inline
In-Reply-To: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CwF3+5Q/askrvk+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When accepting a packfile in git-receive-pack(1), we feed that packfile
into git-index-pack(1) to generate the packfile index. As the packfile
would often only contain unreachable objects until the references have
been updated, concurrently running garbage collection might be tempted
to delete the packfile right away and thus cause corruption. To fix
this, we ask git-index-pack(1) to create a `.keep` file before moving
the packfile into place, which is getting deleted again once all of the
reference updates have been processed.

Now in production systems we have observed that those `.keep` files are
sometimes not getting deleted as expected, where the result is that
repositories tend to grow packfiles that are never deleted over time.
This seems to be caused by a race when git-receive-pack(1) is killed
after we have migrated the kept packfile from the quarantine directory
into the main object database. While this race window is typically small
it can be extended for example by installing a `proc-receive` hook.

Fix this race by registering the lockfile as a tempfile so that it will
automatically be removed at exit or when receiving a signal.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cd5c7a28ef..b5369d7429 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2184,7 +2184,7 @@ static const char *parse_pack_header(struct pack_head=
er *hdr)
 	}
 }
=20
-static const char *pack_lockfile;
+static struct tempfile *pack_lockfile;
=20
 static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 {
@@ -2251,6 +2251,7 @@ static const char *unpack(int err_fd, struct shallow_=
info *si)
 			return "unpack-objects abnormal exit";
 	} else {
 		char hostname[HOST_NAME_MAX + 1];
+		char *lockfile;
=20
 		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
@@ -2280,8 +2281,14 @@ static const char *unpack(int err_fd, struct shallow=
_info *si)
 		status =3D start_command(&child);
 		if (status)
 			return "index-pack fork failed";
-		pack_lockfile =3D index_pack_lockfile(child.out, NULL);
+
+		lockfile =3D index_pack_lockfile(child.out, NULL);
+		if (lockfile) {
+			pack_lockfile =3D register_tempfile(lockfile);
+			free(lockfile);
+		}
 		close(child.out);
+
 		status =3D finish_command(&child);
 		if (status)
 			return "index-pack abnormal exit";
@@ -2568,8 +2575,7 @@ int cmd_receive_pack(int argc, const char **argv, con=
st char *prefix)
 		use_keepalive =3D KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si,
 				 &push_options);
-		if (pack_lockfile)
-			unlink_or_warn(pack_lockfile);
+		delete_tempfile(&pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
 		if (report_status_v2)
 			report_v2(commands, unpack_status);
--=20
2.40.0.rc0


--CwF3+5Q/askrvk+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQK05kACgkQVbJhu7ck
PpQPlg//Zxmh76wK2foymoLI8PJQzQ2fw0dm/aZReiyMVHmz/toc+120Cu+i8AnX
pCLoqEL06uyPIQnLHPWT4E1VTs0NEgTiRV1B9o2cf4650jc0y34kHaq5AEsnr8iw
7KT6CDSHExn9ORvsND5gSixTW09qDrnLQ1479nWzvrYs+Qi5zz7n88pISn1uziYf
+yAfXwPYTSCxjNzCysHEVEuQO3IQzckWA3okYHQP1ykCCQ5Z8PqC8nYJaFk0g/PC
gBm4vBmy2Fi3UPHA8WccHiEFYR4iS8zciqX/zZO02pFe3X4AslbcDKFR8UwZZ6Ic
ZLZVHNM5rk+M26JiluQqRyJQZZ2cfvqXAH8m/hastWFDeRlAc5G8nkuxBTGa8NmT
bLIZ1bOEGgR+i9KCE77bSNJEWTRrGU6KSDFgptUthZhcwJ2jYBOjhGatMs7DRnd1
Eq4+fXTbaVE6qO2bWhvPAbPs0JUhADZZOFNuIFe6RnuuwoZLIB9F13Lhf10eCSzF
HZ55jhdzAqPM3PJ1ZoEslHTszck+fMTNqEuzdnu0xc1KKw2hM6ONVfCSOBuI9OzF
gV3DeWtU0klEu1UAbcNgrqdhkY+Tgi1OQoqUDslGtdTshCHXuNcurJLcQ2y2B54q
psEfleCU4LjQ7wEDPP1RCVbUIzVaW9MjuSSJxNeK1VGkQnJNzc4=
=TA3B
-----END PGP SIGNATURE-----

--CwF3+5Q/askrvk+7--
