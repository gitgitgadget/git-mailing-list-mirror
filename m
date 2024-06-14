Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A71487DA
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347876; cv=none; b=bIrnl0f4M449E1gCJez2JCn5to34HI1b7JiVen3u2vr2pQeIzB13Uo0P8ITkWV/kvcR2QsP3lQgeHHn2alXkqYrDTkNtKU7pq2FSUd87vcXPoqkgMyQamSxSmJTdo4J26F5VlW9zzZkOEoFY704q2zATXiromO+PL4F7KYouTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347876; c=relaxed/simple;
	bh=yqL6BPZETSaCqazuoBKbMIh+IrqflPwYhSpZjBr8WUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhVy38OynQBBOfAoQCxIcwjLWXb2xYpquL+ALeXqD35O0pL/vsCbpcsaef6nAVIeY8DnLhO5Aq50dkrKUKvaEjIs9+PeTA8xxIA+D4+8I+xNTXOg59gixvIqzSOE+EplQNmn5VOiDJtoZXx5Wzu4eJWcCFQ8EqwWDDpg2BkLwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cG3Nx0xY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zqrqd/Kq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cG3Nx0xY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zqrqd/Kq"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3DB7A1140259;
	Fri, 14 Jun 2024 02:51:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 02:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718347874; x=1718434274; bh=FkIm+7fpTh
	ZfCpBhTwRUMDWM77oBFv09ycZV8XuaxKw=; b=cG3Nx0xYm8737ZAcMFlGYSISin
	FBdybV6JSgWNeDVVWiLlqhB8dWEV+oOea1vTUJiDxwWXrazgw2JNGIWL4qEItwjW
	rhAyTpYfUhUq6PicvHXeFBN3qi+PPGZf4jcRi1e7AakbFPt6TPmVkJniiHfAdW4l
	azCA1sgwc9quNEptwxSNbSbCsnI0Qmi6ksz0xshT9+WI6j+BcmM5gCs7SRIf5ISz
	rfJPK6i5htEG+6sDJjOZoJQPb3C0EefabN0ybVx9m1euhE1lWI+5p+LZAwEQuOx5
	jAviZ8++mt6o5/WzbjCpETPqodJRFskrA+rJsQwBzaRhMC2Qbb6K9X4XjrqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718347874; x=1718434274; bh=FkIm+7fpThZfCpBhTwRUMDWM77oB
	Fv09ycZV8XuaxKw=; b=Zqrqd/KqRxyR25a6J6Zb/JVqB25ExPGKqHKlYOwEP3Li
	6uIbpgGMU7jHrb1pK1Dn9MtmMzyNBYkQSEzOqP0GmXLyLdFP9EOm+q1bmIjgyVD4
	sQcWIG1O7Wk8ZNI830VJF+Zak3I9oxMbOmP9Zd2EQoXfA7I49QBAcnDIToo0sXMf
	EIsV+s9ujL2Vhz+MDPklOERmii8wmryQRMCB10+8dXdX977h9MO2XK4Fb+SwCWiW
	7SNH5MiH7DUeyw2I38rBeCGb4oxJiHhyM09x+UHndqifpnRRsSTUCJ49LGsFYfzX
	eV/C2WbPdnORCGyrTngre+JVLBL837nMimPWl0u8xA==
X-ME-Sender: <xms:YuhrZtV4uUE2DXXMuJzOtwA_l5juglDq9KKbuehWN03kEdhhwAFXjA>
    <xme:YuhrZtns2QBH4OaTuSHBqi3tSBCgx6k-byRMkjUoRaAd2WAVPJ1w3z5-8DMUmp8mc
    rJD9HWNh4PgIMUGpw>
X-ME-Received: <xmr:YuhrZpYmAaXsFgXi8DNdL9j7dcY37lW8r4MiPGZj1E4rtJFlv9tDf9SZRLDBHzadzWSxfaqzp-V95R3wNZIfTlbBy7pIN8rN8SINc0aMimcT5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YuhrZgWeUzXBAKUU5t8B0ncG1WWH462taL9bhZxPBikIYIIxAhfefw>
    <xmx:YuhrZnmKchMPUIcoK0Th0rwi_neidXgxBWegJ3G6D6cnjDoJRJmK9A>
    <xmx:YuhrZtdHoEYycfDweqmYphxCxCg2oKf1eUI6caTsKQ3zQTl9o5P3UQ>
    <xmx:YuhrZhFSmzFl0LGLb8yuHh4wKk0GE2ZMiaZvzOIFX8vdngPoyo08kw>
    <xmx:YuhrZivAFMhZtb3lHj7eiNeiSNxD3S5ZsJyeSYhWVy43hTiY8mVWDq3m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 02:51:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 772f53e5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 06:50:57 +0000 (UTC)
Date: Fri, 14 Jun 2024 08:51:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 19/20] t/helper: remove dependency on `the_repository` in
 "proc-receive"
Message-ID: <5de7a01af54267fa65e6b3269abe80b1c5301919.1718347699.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718347699.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7OIi5LAdN4xHtFyz"
Content-Disposition: inline
In-Reply-To: <cover.1718347699.git.ps@pks.im>


--7OIi5LAdN4xHtFyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "proc-receive" test helper implicitly relies on `the_repository` via
`parse_oid_hex()`. This isn't necessary though, and in fact the whole
command does not depend on `the_repository` at all.

Stop setting up `the_repository` and use `parse_oid_hex_any()` to parse
object IDs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-proc-receive.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index f30022d222..29361c7aab 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -3,8 +3,8 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "pkt-line.h"
-#include "setup.h"
 #include "sigchain.h"
+#include "string-list.h"
=20
 static const char *proc_receive_usage[] =3D {
 	"test-tool proc-receive [<options>]",
@@ -92,9 +92,9 @@ static void proc_receive_read_commands(struct packet_read=
er *reader,
 		if (die_read_commands)
 			die("die with the --die-read-commands option");
=20
-		if (parse_oid_hex(reader->line, &old_oid, &p) ||
+		if (parse_oid_hex_any(reader->line, &old_oid, &p) =3D=3D GIT_HASH_UNKNOW=
N ||
 		    *p++ !=3D ' ' ||
-		    parse_oid_hex(p, &new_oid, &p) ||
+		    parse_oid_hex_any(p, &new_oid, &p) =3D=3D GIT_HASH_UNKNOWN ||
 		    *p++ !=3D ' ')
 			die("protocol error: expected 'old new ref', got '%s'",
 			    reader->line);
@@ -128,7 +128,6 @@ static void proc_receive_read_push_options(struct packe=
t_reader *reader,
=20
 int cmd__proc_receive(int argc, const char **argv)
 {
-	int nongit_ok =3D 0;
 	struct packet_reader reader;
 	struct command *commands =3D NULL;
 	struct string_list push_options =3D STRING_LIST_INIT_DUP;
@@ -154,8 +153,6 @@ int cmd__proc_receive(int argc, const char **argv)
 		OPT_END()
 	};
=20
-	setup_git_directory_gently(&nongit_ok);
-
 	argc =3D parse_options(argc, argv, "test-tools", options, proc_receive_us=
age, 0);
 	if (argc > 0)
 		usage_msg_opt("Too many arguments.", proc_receive_usage, options);
--=20
2.45.2.457.g8d94cfb545.dirty


--7OIi5LAdN4xHtFyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr6F0ACgkQVbJhu7ck
PpRJJRAAi5iQWU1A+KkRn9Djrt9csieVb2NBJ1IIEtZxCrrD1vxP7xAWpxhbliza
Ya08qmMO9OMVNazJicoXoxqujx/bnZBe/5qzuS1549dabXgLjDSMSAb1j6eImllL
c7b77VGFApsViJfHWJZUHLMQ1U7h3lGcQwNCo99cagnUaW76UcOZljG7zwh8FEG5
8GIB7EYAVAaFZ4jSRzAYJ35RdxloEbjWzFJEaP4dlIbgE5vmMzFxqC/ksR7knCEW
eXcwIYSt6prRI6fftEnOjww4NbcEG6D9gXJIydR8Ma7HcRZYb0E/TX9qBC83xoe3
OSA9KEFggdspu7nSvLvD22gknEeUmr4nGEfQICvnj0evbq+NLZKgo8CnEmRPfMH0
YEmJjib7+/IqyejTJjnVjZVTpdITWX9kyx+6US3WW2ZFlHbT3MdcU1SOXRXAgvrT
lpQsGIW7kKeZkq8SEt8uBSD1TKiaigl+oihaSFztK7IEYDta2Z34PJaQpZ5AywHm
mcsA87DFbGuU86O04U3ots4vkWenigj+pHswhrBJYS5XRfbR7SkcwBfyNp8fp13v
Ceq3Ew0HPZbo6Xw2IAyZo1aR47YCmONF3rvnHz/3DbnceiHVttCcMqMP4TZYBhiA
glaWSTMQDmyi25uynl7VzWWZr6NPT+b7uBSBQ1j2dDGbabIVxuc=
=IfLU
-----END PGP SIGNATURE-----

--7OIi5LAdN4xHtFyz--
