Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520415FD13
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655980; cv=none; b=Kmkmct5YNRgCIo7oDtAecVvKFTZR90Xu51V+iZsqHTSfY7WUi8YZ1TqWiRPn60UX0SvqYbOwpci2qfSmwKg0okxVk/7yEiaTltTP0Q4xuVfNWCmGstjKtI60hIj0V2wMyUE3+8mfDLC6U0Dq1TciDZw9Kx503a1urJGHhtx8isE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655980; c=relaxed/simple;
	bh=VHIKtREkJl62lPJ1NE38t6/vxwwWgUU9AmbOe+C6jcM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=aXTqZm/nTpWZcaZR3eMHwyM1eg9yzMihKD4F94io7AHqG+y/Sr7XwphsKT+lbwExF+dmL8gOJ0cV2r/nJuvsV78WY62e5G047k6Yli3SCsnn8YnW7tNvBldNALIBUr6wCyLIXBSjE1Y8kMbAUgGYkrksvLcX75qMCKwCfZIMopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ct4Ne1Jq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/5Js1En; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ct4Ne1Jq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/5Js1En"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 00FCA1380224;
	Fri, 15 Nov 2024 02:32:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 15 Nov 2024 02:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655977;
	 x=1731742377; bh=kc9EE2fdIb5NrjO3SF3ccRwVGScT/h+tzn4Wj8nUWhA=; b=
	ct4Ne1JqMPRdQlYMaIz0Qt5zogC7U1IDJF+bYf0JdfGjPEJ/SjD5oqy1frClNKCO
	CWId/52pDnbwG4ANylFg88ypSUwz4d8Ds6ae63ldTcuAAwUEBZFgd1SWfEY4aS5M
	G4XCk8FsOJsyMjJzhwrl9udR4KIV6bgEL3+4jdybWmMnzy8t6fn4FfWPbLxYHy/x
	CXPPzWmLnG+CriV9G8GIgVIMjeCupow/6OsBTDMjy0VZaM4UIIZW3UNafUKfRXjb
	dfaG4/OGbgh2Gkgb0UGiAaETvY5S1coZldbkNmR0tNiowAEcYZHapUIX4gGjhrkH
	3pSw1cbReM/gLceUWMOQKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655977; x=
	1731742377; bh=kc9EE2fdIb5NrjO3SF3ccRwVGScT/h+tzn4Wj8nUWhA=; b=j
	/5Js1En06BGWBRKRkqTBV68rJDRg0sXhOgz++6sxuyEJcwc4w1RZoG4V/BxAbDDh
	cXThrRZz035lkMbyPgYZDmn1NrDjYx0f8EAz4v1+uoauvPYziztxxMbqx1yhpAY6
	4K8ZL6/8xip5hJOxiNr1B9H6qmalJK3qr5IjbzfeB06ovIxEk8kfaSrGqbWpCYK0
	z7JPTwztqUQ9ONv3rp/8q2vnzb1nB5iKjOcBejjCATvRzRymGKnHIIIhNGe/vPDM
	l9fPI+dHj89GefnE/IOruD9nBCjiZ3+Dbl1w341axxQ9ZL9yj8q5ESlixQ3Ysr77
	b/3yyoatYArS8ckRQ4EXg==
X-ME-Sender: <xms:Kfk2Zx7xdULOtCUdl64z6kZXVpFDcEz7fe8caR4lGdUJ-UXi-cLOrA>
    <xme:Kfk2Z-65dtZcvQmQEBDFFUCslTi9s6J29gdkJrb0eis2v7Wqr9kAJlDWd39cVdTqn
    uc8j5zAwI3KXhFUZQ>
X-ME-Received: <xmr:Kfk2Z4dWYb5Efljf5183he1c3ymkGpjRDlUAbHjtWIw-CJsKhkbUGaL55JOU_xYNxaiYUQAajkVngzebnB9I9Zay8BwoTYL0xFBglmcrsKbDqEGA2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:Kfk2Z6KNhp7USzPMjNfIH4KPIjut7yheUrKK4kNltSXTwkaeJE8neA>
    <xmx:Kfk2Z1KeJazNjhjDQJRRwzsiDDyUYqbR7TclP9UzwszgaBLgbK8m1g>
    <xmx:Kfk2ZzyxwKhe8JGyBkkKoE-Smf3_a7BbI3woKGqXAdRbKTX1Wovsnw>
    <xmx:Kfk2ZxLwNNflfKQ_fUEPQj0vQl5mlQjCHiPqMZTahAJmgYa2eLrUHA>
    <xmx:Kfk2ZyGvedT5reiarWhw1QerfKXTpLyL6L6dCOEKXybWFAqbYUkcAa2j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:32:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2882ad7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:32:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/4] Build improvements for clar
Date: Fri, 15 Nov 2024 08:32:40 +0100
Message-Id: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABj5NmcC/43NywrCMBCF4VcpWRvJJL268j3ERZpM7WBvJDUop
 e9u2oW4Epf/YfhmYR4doWenZGEOA3kahxjqkDDT6uGGnGxsJoVMAUTJp7vnptOO1w/qLKd+cmP
 AHofZczCqyqWudFE1LAqTw4aeu365xm7Jz6N77c8CbOt/bgAuuMwMNJhnBlVxjtdH6tmGBvkFA
 fyGZIRsWlSpLS3USnygdV3f0mKI1gwBAAA=
X-Change-ID: 20241108-pks-clar-build-improvements-1c3962a9a79f
In-Reply-To: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

Dscho has reported in [1] that the CMake build instructions for clar do
not work well on Windows/MSVC because we execute the shell scripts
directly instead of using the discovered `SH_EXE`. This small patch
series fixes the issue.

Changes in v2:

    - Wrap overly long lines in the CMake build instructions.
    - Add the VERBATIM option.

Changes in v3:

    - Fix missing word.

Link to v1: https://lore.kernel.org/r/20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im
Link to v2: https://lore.kernel.org/r/20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im

Thanks!

Patrick

[1]: <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>

To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>

Patrick Steinhardt (4):
      t/unit-tests: convert "clar-generate.awk" into a shell script
      cmake: use SH_EXE to execute clar scripts
      cmake: use verbatim arguments when invoking clar commands
      Makefile: let clar header targets depend on their scripts

 Makefile                             |  6 ++--
 contrib/buildsystems/CMakeLists.txt  | 16 ++++++---
 t/unit-tests/clar-generate.awk       | 50 ----------------------------
 t/unit-tests/generate-clar-suites.sh | 63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 57 deletions(-)

Range-diff versus v2:

1:  90d2402c5a ! 1:  dc713c236b t/unit-tests: convert "clar-generate.awk" into a shell script
    @@ Commit message
         may otherwise be a problem with build systems on platforms that use a
         different shell.
     
    -    While at it, wrap the overly lines in the CMake build instructions.
    +    While at it, wrap the overly long lines in the CMake build instructions.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  cf298664d8 = 2:  19d292cc5c cmake: use SH_EXE to execute clar scripts
3:  ff557f8985 = 3:  52f5090a76 cmake: use verbatim arguments when invoking clar commands
4:  c634e2a6d4 = 4:  35117454d4 Makefile: let clar header targets depend on their scripts

---
base-commit: facbe4f633e4ad31e641f64617bc88074c659959
change-id: 20241108-pks-clar-build-improvements-1c3962a9a79f

