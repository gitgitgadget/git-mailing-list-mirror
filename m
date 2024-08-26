Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF80139579
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656937; cv=none; b=dt8BwOZ4Rdil88dmxfakzzO697lM/Dnon869CqRK8pIl8gLlHkLqukqebGB944qx9p9ANq6pUU+wK/LrkG6Tgm4409KbOwj6PKI+uavvJZmdaCOCMoW89wQjaYaT0RsAZgzdZW5wdGlbxoakq1CzMjnKFEzQqgWaKw3B8UDUB4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656937; c=relaxed/simple;
	bh=iLaxqnHBcpBYrWPu4VQXDi+Ll5M/0GegBil4vWC9mLs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjxDqOD/bxBIgsWOVVQ2CS4neOh5aGnX04doVVHXhj9q0V7uSmxlwrZHkcqidaPYKFnIIL7+DLfrwbLO7DAx9i3aupNd88Zi4T+gD/wXUt5gVZMBKPG4N01JP824yMmmYGmtZ2vAChSemu1tmY1d6jpKcR9f6zD80x+Hi6GyqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q8Fyj5rV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7CUf1ex; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q8Fyj5rV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7CUf1ex"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4350F1151AA5
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Aug 2024 03:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656935; x=1724743335; bh=O9n5bHLoqf
	kgYkDwaoWwfLqxl81KWlZpv0BGaeTE1PM=; b=q8Fyj5rVgNfTEpbV3i3p9YQjBD
	FOHY1iABHxfRDVASd6ILD02Uwla1t7CVVVdCurBquqJGoroaR0x9s0FoLIQgrZm+
	F2EWcpGL9h3+1hlRHwjyAMRxDGscSvtqTLKkTsh5gK9dtNtbRCPmy6q5/1oX4LvR
	Daf4NJvUwWmarllMBJi0HfsP+d2kXDoY8a1pDVlqSM8d45Ivj71t+1D17BIraMCq
	IEpo4NWyax7Qsjsr0FjbhUfYp8M8Oep3soCOVkYCVw+kfvTiA/CAGkXGdgB1CbFD
	agTOEcCUXx6tNokFCz35wj31glpgqvWWpURlcVxn7VX8KaXOjktvhAet286Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656935; x=1724743335; bh=O9n5bHLoqfkgYkDwaoWwfLqxl81K
	WlZpv0BGaeTE1PM=; b=h7CUf1exZdR+vgwMx0Mb28JhGn0tCj07vcTTWHkgVH5I
	Rqd/T2YGN5YWi6xRnHotND/b2mKeCrLPhS3sQQERMTmz+rQJAmDTDkeLrRz8d2fD
	i71UPm4qCp24iMB94prs1gI19tQZbokmarVTAVFv4WjBtSk9XEFKi3rD2Ipbc5fD
	6byVDJCm921ZnKmkfNm0NwzH4Vz7Foa3NQNKWv9kizbLNeXkF/G/2P907lwemslr
	eIYv+4ECNCCwnbO1e9Tlkdl23yytQ3WKHhhowpWrJb1yPIr9tCmgAaGTRYAzJtiB
	1t2YenKWbZ1Lg3tnAkg2zvb0NQXJ8ih1w9FLBrxYZg==
X-ME-Sender: <xms:Jy3MZoDKyvu9VJhfvZYnkR6DwGKjw_kNLuJ1bP1B1romoIHZ09nyGw>
    <xme:Jy3MZqhUPV2tw84ow87EeVpOSPE96ZVk3RCXag7N5XYdicFgUzSVKtcwM666IKkUp
    f51CnehAfPjp4ixmA>
X-ME-Received: <xmr:Jy3MZrlTbH-zNfy2KAQLnnRkgv-TcUVlGc7UZriqfb7JkpWhZgRAI2kSR4TtJwbBP72VW4ZVSy79IxcU8juoFO9U0dsv8k5CpTzXiw5CQrnNwaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jy3MZuxHx3W9vdvFnToWHM0yKGbV3GIybMOTMJRuzCnm_T_mvALvpA>
    <xmx:Jy3MZtRrS2IGZSJTwinw30fHusYjLkuR3G0RuxVt7l0oKITv_y5GDA>
    <xmx:Jy3MZpb9U12XXzKCM8KRIh0JBclNh3TRpkaoHMY2Jq-0Imkjl03G7g>
    <xmx:Jy3MZmROfX-_cG7TYHyb7GyfnNlhSD95oD9WQby2hs3RALgd_cH31w>
    <xmx:Jy3MZsLkzghaqCQF-x7lDXKKWbUlpyWzygnNdudSVYhqR0hlSkA4YuhB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f98b5edd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:12 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/22] shallow: free grafts when unregistering them
Message-ID: <ec9a51432414cf3a62a1041542f0c9706377b235.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

When removing a graft via `unregister_shallow()` we remove it from the
grafts array, but do not free the structure. Fix this to plug the leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 shallow.c                | 4 +++-
 t/t5537-fetch-shallow.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index a10cf9e9d5d..7e0ee96ead9 100644
--- a/shallow.c
+++ b/shallow.c
@@ -51,10 +51,12 @@ int unregister_shallow(const struct object_id *oid)
 	int pos = commit_graft_pos(the_repository, oid);
 	if (pos < 0)
 		return -1;
-	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
+	if (pos + 1 < the_repository->parsed_objects->grafts_nr) {
+		free(the_repository->parsed_objects->grafts[pos]);
 		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
 			   the_repository->parsed_objects->grafts + pos + 1,
 			   the_repository->parsed_objects->grafts_nr - pos - 1);
+	}
 	the_repository->parsed_objects->grafts_nr--;
 	return 0;
 }
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 37f7547a4ca..cae4d400f32 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -5,6 +5,7 @@ test_description='fetch/clone from a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
-- 
2.46.0.164.g477ce5ccd6.dirty

