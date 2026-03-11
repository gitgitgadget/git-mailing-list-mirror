Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9C391E49
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268321; cv=none; b=lU//EgSlteIizL3lQYKd0Nt5wC8lE61abX518rGPAkGklDgWdinXGaUjnqrJAbBMRQoMaJWJynNmTyCLZWiED/lOicayGEct0nLgLIU1N5XE9yV7G26MNvzhJ0Eab3tgu4NFAQTZ3/jA6eWLtBN7DIIMiK/6CbYusZdZj04WxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268321; c=relaxed/simple;
	bh=x5EWXtHn0oGHCBsYvcrhXx0v5QDU2P8F/Wzs23e0hNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYe2mQraOhdxNS+/afIjQkdiNKUhh3KaDmawRMCizmaqHj06pqNTQc+Z5zmJgl0Gu4PDApGmj/n6JQT+cc1g1g9/QHMqu31tsMSza27oqp5aEINGZr2WFv1Rs9RFFxMJSa3Jdj4igx6uuuodL5Vy/7T+0q8ecY75Ewyaw3F6Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cP5ZNufj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjXgvuRe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cP5ZNufj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjXgvuRe"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 525571D00124;
	Wed, 11 Mar 2026 18:31:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 11 Mar 2026 18:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773268319;
	 x=1773354719; bh=AmC0cn3XGIjL8+inxBa8Lj4gk30s/mYLc27cheaFfkU=; b=
	cP5ZNufjXozjgy5L7XLY2LK2USXtIKQJTUjX6EhwyTMhihYpoSG6gSDR7eZtplXH
	LHbVUU4vjta/uUzPd97zG8kxz2Bv8/eOIX5mepEDRI5WW/8unAbsRhZAcG3/vddD
	UWIt0I8E5L1rSfK8nLzmcTGXSX3okTvy7V543gGQmlwNAhWa7mKFd+lwc5jcaOIE
	U/HrBaNZCOlX+62UK0aaYp2Tb8HwepM9xG//+P02vkaUIRdPV/oh7UZK8NXmIVRp
	0QHywlxCvpOE0PQ/D2sNqcV2fXJ3m1VIBEEAHg4eu691haTDCcgWRpzd7Z8xYSmB
	pCC2qO6Jhg/xTRDQ2tI7rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773268319; x=
	1773354719; bh=AmC0cn3XGIjL8+inxBa8Lj4gk30s/mYLc27cheaFfkU=; b=G
	jXgvuReY9gdwyohqkamgBprviGOoogsHscNN1j3ZoLjX5oJut8RPrU1D1VVtbr0U
	aFvfau1pe9WxQZD1X10hScXHS+nLeTsCKWiBptyb9AIbGdov08Z8xbZpL4UoXmK5
	DVYS9Lwpxb1DQcD4h62Kc2U31ifLpG7+T8nQT405FwqVbCN2e8j75gM1tBV1bo72
	+5xZ2OrIzdMi92VuOSOunktaO5CLs4SJOwseCmZELsNs7DzSSmBVtN3NhCcSFkc9
	m+E6fP59YQNqJ6bBH8w70xqScz4cq+iyo9Q3z/HwJN0523BHsBAY6BwNA+74BhI5
	SGib80IWb4HJrLBe+gI9Q==
X-ME-Sender: <xms:X-2xaa78luthNQeCx912C6V1OT_MxkZ7h3fO2hweIpA3VrumpxXx6i4>
    <xme:X-2xabXhh3x6bMQ34nqhKv3s0Kr3xWRoEiOv_Jerf353hnC6HbAAb0JKM41oWqjDh
    IzZeoUmevOTtuUeXsdwqY8LQxyPbrevJtnaqgivxy3krN2X8X0OqqA>
X-ME-Received: <xmr:X-2xaW3A_Ves8gVaNbkPP-rnKg0VoBoE9J0k25Tx7Pdyx9kd0MIt6qIYy9I0xnvFKmQZJmQGwQy3RDb4ezQJbr1-FftqwW799tFBTNewtQXKdgqKZqKpTGXjIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrh
X-ME-Proxy: <xmx:X-2xaQ1gM0UbwJP7aOzspOfSyr_aT4lKe1_j-MaNpuUlkwtELGKvrA>
    <xmx:X-2xaR8PidvbXoKTsoA6P2z4dquuCoHXVEf9P08ETc1Kp0eeaC-d9g>
    <xmx:X-2xaV3LFno0pvAr3wQrMgORqvaGi0vQPlcPf9b3OKdAkdjEe9lQ_g>
    <xmx:X-2xaW8u-QNx30UXLYS6Q6sBgap3pt9Ef-BYlBo3DWEmQuRCl4YhcA>
    <xmx:X-2xaf9ftisu19e1-GoQhw4AY_58bcBf4NyRmi5nIvziVcToURRSHQ2l>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 18:31:57 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 2/3] doc: interpret-trailers: normalize and fill out options
Date: Wed, 11 Mar 2026 23:31:05 +0100
Message-ID: <doc_interpret-tr_options.48c@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
In-Reply-To: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
References: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Some negated options are missing according to
`git interpret-trailers -h`.

Also normalize to the “stuck form” (see gitcli(7)) like what was done
in 806337c7 (doc: notes: use stuck form throughout, 2025-05-27).[1]

Also normalize the order of the regular and negated options according to
the current convention.[2]

Also note that `--no-trailer` will reset the list.

† 1: See also https://lore.kernel.org/git/6f7d027e-088a-4d66-92af-b8d1c32d730c@app.fastmail.com/
† 2: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-interpret-trailers.adoc | 66 +++++++++++++++--------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-interpret-trailers.adoc b/Documentation/git-interpret-trailers.adoc
index 8a6c1bff472..e5da0462fad 100644
--- a/Documentation/git-interpret-trailers.adoc
+++ b/Documentation/git-interpret-trailers.adoc
@@ -112,64 +112,80 @@ rules for RFC 822 headers. For example they do not follow the encoding rule.
 OPTIONS
 -------
 `--in-place`::
-	Edit the files in place.
+`--no-in-place`::
+	Edit the files in place. The default is `--no-in-place`.
 
 `--trim-empty`::
+`--no-trim-empty`::
 	If the _<value>_ part of any trailer contains only whitespace,
 	the whole trailer will be removed from the output.
 	This applies to existing trailers as well as new trailers.
++
+The default is `--no-trim-empty`.
 
-`--trailer <key>[(=|:)<value>]`::
+`--trailer=<key>[(=|:)<value>]`::
+`--no-trailer`::
 	Specify a (_<key>_, _<value>_) pair that should be applied as a
-	trailer to the inputs. See the description of this
-	command.
+	trailer to the inputs. See the description of this command. Can
+	be given multiple times.
++
+Use `--no-trailer` to reset the list.
 
-`--where <placement>`::
+`--where=<placement>`::
 `--no-where`::
 	Specify where all new trailers will be added.  A setting
 	provided with `--where` overrides the `trailer.where` and any
 	applicable `trailer.<keyAlias>.where` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
-	`--where` or `--no-where`. Upon encountering `--no-where`, clear the
-	effect of any previous use of `--where`, such that the relevant configuration
-	variables are no longer overridden. Possible placements are `after`,
+	`--where` or `--no-where`. Possible placements are `after`,
 	`before`, `end` or `start`.
++
+Use `--no-where` to clear the effect of any previous use of `--where`,
+such that the relevant configuration variables are no longer overridden.
 
-`--if-exists <action>`::
+`--if-exists=<action>`::
 `--no-if-exists`::
 	Specify what action will be performed when there is already at
 	least one trailer with the same _<key>_ in the input.  A setting
 	provided with `--if-exists` overrides the `trailer.ifExists` and any
 	applicable `trailer.<keyAlias>.ifExists` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
-	`--if-exists` or `--no-if-exists`. Upon encountering `--no-if-exists`, clear the
-	effect of any previous use of `--if-exists`, such that the relevant configuration
-	variables are no longer overridden. Possible actions are `addIfDifferent`,
+	`--if-exists` or `--no-if-exists`. Possible actions are `addIfDifferent`,
 	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
++
+Use `--no-if-exists` to clear the effect of any previous use of
+`--if-exists`, such that the relevant configuration variables are no
+longer overridden.
 
-`--if-missing <action>`::
+`--if-missing=<action>`::
 `--no-if-missing`::
 	Specify what action will be performed when there is no other
 	trailer with the same _<key>_ in the input.  A setting
 	provided with `--if-missing` overrides the `trailer.ifMissing` and any
 	applicable `trailer.<keyAlias>.ifMissing` configuration variables
 	and applies to all `--trailer` options until the next occurrence of
-	`--if-missing` or `--no-if-missing`. Upon encountering `--no-if-missing`,
-	clear the effect of any previous use of `--if-missing`, such that the relevant
-	configuration variables are no longer overridden. Possible actions are `doNothing`
-	or `add`.
+	`--if-missing` or `--no-if-missing`. Possible actions are
+	`doNothing` or `add`.
++
+Use `--no-if-missing` to clear the effect of any previous use of
+`--if-missing`, such that the relevant configuration variables are no
+longer overridden.
 
 `--only-trailers`::
-	Output only the trailers, not any other parts of the input.
+`--no-only-trailers`::
+	Output only the trailers, not any other parts of the
+	input. The default is `--no-only-trailers`.
 
 `--only-input`::
+`--no-only-input`::
 	Output only trailers that exist in the input; do not add any
 	from the command-line or by applying `trailer.*` configuration
-	variables.
+	variables. The default is `--no-only-input`.
 
 `--unfold`::
+`--no-unfold`::
 	If a trailer has a value that runs over multiple lines (aka "folded"),
-	reformat the value into a single line.
+	reformat the value into a single line. The default is `--no-unfold`.
 
 `--parse`::
 	A convenience alias for `--only-trailers --only-input
@@ -177,11 +193,15 @@ OPTIONS
 	input without influencing them with any command line options or
 	configuration variables, while also making the output machine-friendly with
 	`--unfold`.
++
+There is no convenience alias to negate this alias.
 
+`--divider`::
 `--no-divider`::
-	Do not treat `---` as the end of the commit message. Use this
-	when you know your input contains just the commit message itself
-	(and not an email or the output of linkgit:git-format-patch[1]).
+	Treat `---` as the end of the commit message. This is the default.
+	Use `--no-divider` when you know your input contains just the
+	commit message itself (and not an email or the output of
+	linkgit:git-format-patch[1]).
 
 CONFIGURATION VARIABLES
 -----------------------
-- 
2.53.0.32.gf6228eaf9cc

