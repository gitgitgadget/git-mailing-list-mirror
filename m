Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D432463B86
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789389997; cv=none; b=oWkGyOs4ZZ/88hPGjyhRCnyEDA4Do+NMZyKTrNdAURny8xEmFcTGS40RkMC5oi5f4UygbG/Y9Sr9syI9KLcI6+SxXr5QSgcH4X1DF57Pxebrx70NqNnvRHvSDFH7egwogL3TVksiHrg9Q4ZvFD82uKG59I8WOpZxjzXRtjsp0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789389997; c=relaxed/simple;
	bh=ORBlZW0RFfVAwbotQhn+MGy6zhnUIFNeu5Xnw9LHt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVgiAhOenC6AbA7l6rjfGR+IocNVvBfaX++9zera30VzCTO8qeSaZ6aaWrTSndhkp4TWKlh80uj0bJoA+ySTFagvbXMKyFasxPcL8hk3r54/H9AhjriF0OM/WE1vCRsZiKrng4T31StcJS5OPJEFTniPrZZ3ab9lUl0IrMzfxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eyRrx7kY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c9hHyMcw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eyRrx7kY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c9hHyMcw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 716681D000B2;
	Mon, 14 Sep 2026 08:46:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 14 Sep 2026 08:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789389995; x=
	1789476395; bh=w94+GoJdGrZT3tZ/E81U5mu1FLS9cHt6GJu6WjpF5pA=; b=e
	yRrx7kYb4KVaxuzdwyAQrNROlB4Iopc4Ur7xCfiqaL+exdJpZmYUyT/Ta4MRAyPK
	FvW6++8Tr3Lgn4FhgxDlmw3Wah5lxYnncq3FXM7Z/QIwppZ7afwbIp7btii/kd3Z
	puT2ZSX7Snia2ke6z1nX0WcvA2HLjc2PgYv1rPyPhlUDoKAqSZZvQ0oRWETTlybg
	g3VLEvkLAPhQpxlEOs3Cjy/Kh6AuD+jZaTo4HGAippjM6YNtIxWpSsXEe3TmjNSN
	r0QkqlIOJVkgsuRKfW2YS1ofJy6mrKe0FLUPiBysI/doIZi2KZsRSSAo+zgkBI8Q
	PFaRRP1f/XY4j/bj5O72w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789389995; x=1789476395; bh=w
	94+GoJdGrZT3tZ/E81U5mu1FLS9cHt6GJu6WjpF5pA=; b=c9hHyMcwbzGsKAr6I
	INQA4OvS41j26+WyvUrZfNyTj9MnrzPhy11Eo4e0XaF0muHsSgW2fqhmCs62D/lM
	2JHnZh260lVXrttT+Lzi2hlgwWfnd5b1ULyMmYiXFaXU4pzyNIpkEIylDupF+dV2
	Bv5v8ffhLvTyLqFBS9qY7JUiJReiDQoo46ZcU4nwo469vCBzkqoMW6xLupSjsa5x
	zbbGzCN7DDuUcUFpjSigNaqL6ZtJ90uPUe6GAkqwakrzle3havmBMlu7Dj9ITEWf
	n1b0ZCBpkmZ7x9ktwJOywaX9Qai+qi6l8O1YgM0z8+hKk+AZykZ7wcxxHx0Yv/Dd
	sm9bQ==
X-ME-Sender: <xms:q-ynajmHPQHtw-5RdyJm5zcJ_MTQ8UTdOXHrWlUDlBQAiQqWE0112A>
    <xme:q-ynas1oz71y-EHr51XlZDrcY3NQKCt9dwqUe39qBNq8isMosdUEjXlrGvzs_pJss
    n0UChQ_AymR2pxqIrTwoI8Z_s1kFVoqqh9z86qlZwE3fNk-smWrFX8>
X-ME-Received: <xmr:q-ynanTDvMAEv7a6erVVl9w5PSieuxZkp7Hc-ed6n6mWl6pr5DrRKAbg7pd48zrAppn0dee2OSnku9SWPElhnl9dLR9b9VSVAZSBb7B-4mN6CcjD0lNOqXVxaDzvNu2HzJS7BDSUtNacOKFF>
X-ME-Proxy-Cause: dmFkZTEy8WjatDA++yKrt3sVVFdML6iRX9Hq3w9e/dOk5Inw/5lypFtwLUkT0Sagd2OFsV
    T3FKmcjqMN4uhOcvw330EMtXzWqyv8CyBquxzLOMo3rvM/apP0nBVLaCFTCj6L2GZrFrQp
    jBOgqECBrItXX1u9HovTTgZEfnTq6ckuMATWjQ4LjDek7gIAvZ2Jcf2ijQD73vOvJy85yc
    WJBT8s/sSd4LKsrtrQKwicuryJ7bgv0cF9fE+ZYF570XJnKFiwVACBuMPgvIBStGo+jQpI
    CTqeVIfED9xnauAclg6Nf1m3P2sFHilqTBqbCskG/RCsm8P1v/FdFX0eJEwxVwa+TGW/qL
    fpvtQaDqfA1OGPTzjUZFr5FFyIU/FMuq7rBnxD5HwetrW348d1QLAg8xeu2x93pMLBk7/Q
    Kn9J0wSs34OnDG880RHg3uB0F39glonBJ5AQinxYawNTYYbnGycYzWSHx0lEeF2PFbJzt/
    zjwQtkrXfZVhyQTTkYxcapdaVWTn1Pag34PEGQhASCjO/EEtg14r2QZ/Ism6qiDkaCxQL0
    dnGNGFKemah+9tM18g0Soq4KYhQY2T4QRpqfhIPYtBpGV5F7emzbmycfMgeXKa7D5KfW0o
    nhQkQgybK8Ug/UrmpJwn4gCXoCLhzpQLENLPhgwJ5+hbkjfGjmgZeqeFvcJg
X-ME-Proxy: <xmx:q-ynamu5w5bs1MISjXhCFjYbIgQ7nzbSR5hWwuQHTFEjbITJHaVZfw>
    <xmx:q-ynakaSVqz4z5M4xArM2fWH8-U8A_0rRTS5iNzrJdLxeVGnBGmRXQ>
    <xmx:q-ynajsXZ1LGGXxY5OsBtzY-TaG89J6nXMjKKcfSZEOp8R0ICoQjfQ>
    <xmx:q-ynauGYvCSKh7v5n5-h5xwOjM0U0tANxnQHCTZiOpIfcMocYiK5lQ>
    <xmx:q-ynau-lqz6ymwcM_R4yBqP__lFxSqzIBDdz_sDvzS3c4AOIDFBs5aHq>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 08:46:34 -0400 (EDT)
From: Todd Zullinger <tmz@pobox.com>
To: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Cc: git@vger.kernel.org
Subject: [PATCH v2 2/2] doc/refs: backtick-quote commands and options consistently
Date: Mon, 14 Sep 2026 08:46:28 -0400
Message-ID: <20260914124630.154107-3-tmz@pobox.com>
X-Mailer: git-send-email 2.56.0.rc0
In-Reply-To: <20260912191509.844954-1-tmz@pobox.com>
References: <20260912191509.844954-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-refs doc was converted to the synopsis style in 89be7d2774
(builtin/refs: add '--no-reflog' flag to drop reflogs, 2025-02-21).  The
commands and options were not backtick-quoted at that time.  84f3d6e11e
(doc lint: check that synopsis manpages have synopsis inlines,
2025-08-11) applied backtick-quotes to the existing commands and
options.

Subsequently, a number of commands and options were added without such
quoting, leaving the documentation rendered inconsistently.  Apply
backtick-quotes to all entries.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/git-refs.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 9063892651..9dc08cbca9 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -54,40 +54,40 @@ These limitations may eventually be lifted.
 `verify`::
 	Verify reference database consistency.
 
-list::
+`list`::
 	List references in the repository with support for filtering,
 	formatting, and sorting. This subcommand is an alias for
 	linkgit:git-for-each-ref[1] and offers identical functionality.
 
-exists::
+`exists`::
 	Check whether the given reference exists. Returns an exit code of 0 if
 	it does, 2 if it is missing, and 1 in case looking up the reference
 	failed with an error other than the reference being missing. This does
 	not verify whether the reference resolves to an actual object.
 
-optimize::
+`optimize`::
 	Optimizes references to improve repository performance and reduce disk
 	usage. This subcommand is an alias for linkgit:git-pack-refs[1] and
 	offers identical functionality.
 
-create::
+`create`::
 	Create the given reference, which must not already exist, pointing at
 	`<new-value>`.
 
-delete::
+`delete`::
 	Delete the given reference. This subcommand mirrors `git update-ref -d`
 	(see linkgit:git-update-ref[1]). When `<old-value>` is given, the
 	reference is only deleted after verifying that it currently contains
 	`<old-value>`.
 
-update::
+`update`::
 	Update the given reference to point at `<new-value>`. If `<old-value>`
 	is given, the reference is only updated after verifying that it
 	currently contains `<old-value>`. As a special case, an all-zeroes
 	`<new-value>` deletes the branch, whereas an all-zeroes `<old-value>`
 	ensures that the branch does not yet exist.
 
-rename::
+`rename`::
 	Rename the reference `<oldref>` to `<newref>`. The old reference must
 	exist and the new reference must not yet exist, and both must have a
 	well-formed name (see linkgit:git-check-ref-format[1]).
-- 
2.56.0.rc0

