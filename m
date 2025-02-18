Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D041122C336
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870535; cv=none; b=L1P2PykIr3gSsFuCQoYHmoKYjhoVguigQOK36pjvhE+ENGkcxAFq11lCNOvaKMgu5uyFMzSARFE7dz3ldbzyvQgU31xxYfQ1tOqMjmA8EKfHk/G8AS7jwQ2JTMYSZX5Mfryhfs3s75kLkLJNW+EoVdhV4HF++ukAdNgYJNDZjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870535; c=relaxed/simple;
	bh=wQz8NVW81yp1oPfub6mwDa5Y9xjEGo/KMrCYV4hl1xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhuL5zVeuIsQesjtjRJJe/DPVAdYnPsDUo3mdDq4ObmjLzGWeNQ/nvIE5lcrvdNGqNIC0E6zF+mjSZph6DYKFHqNOjSUxJp2ymUJoka6KxzfKceQ8OyQEwFM1eLe9K8zEN1zAqH2IhPRNe+sF6w67nZcPvYiRwp6RNdpYslMKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=So897czt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmMJFO0L; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="So897czt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmMJFO0L"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CFEC41380A47;
	Tue, 18 Feb 2025 04:22:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 04:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870532;
	 x=1739956932; bh=aXvLizE+mHU10KrTZmozgR3ifjP3Oxyl3QWB2kV9O5c=; b=
	So897cztmEg5fu3qo+5LOfGf/v/vSDiDAPWAwQauw8+CGbRf3W6+C7XWLMTw+fKX
	1m8Q8iYs2nG+w/KKY6kXiaiTZQifNEu7BjFiMVB7wwm7Vpx/o96wJdREHu0M0oyw
	ngwkDpgGQDDiffGR6clAyQPxqTTlPvnWgIbokHVySLES/Rsubx1J4/cMqLrg3Q6S
	kB3PaWGRKEvWUitcBBH2Bc6KGuOWiJQptivfgzXKZjcDzroH25cjyvdgk6jvCeC0
	I0PX/yPH6LPm01AaSruoR59eMD6LH70G/VpacWaijF3d4WaZD2QlfFUZjCXE7+7E
	Tj5NnqhPNOl6EeSmado09g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870532; x=
	1739956932; bh=aXvLizE+mHU10KrTZmozgR3ifjP3Oxyl3QWB2kV9O5c=; b=A
	mMJFO0L/Nsd5U8bZ0X71mbAG6BG6smUoFxorePfl5IL2zeHCjk2LquwDsrsBIqQK
	wjWSPU/3u9OJwXru+LyWb8p4WmeRleELq9SHh50IMIJ5eUI9m0iDZ/hdBejd66pU
	DLhCOGaR2mkIg9N/FRqMfC/kbriKY4F820BDxXHAK5lrENB6/WgX1QB9B1CieNyn
	6Qi25dCzFGVqVrdOOxzQrvIzgJTSSwwpvorjpoJXQc2CAmKwU236/YiW5ferp/yw
	41oAw/FPolu2Lg7hyZ1Kzp3dKgiI1W+gwXQgIMuw7qQWy7uS06C0ALX2a4EFaPuj
	1D4SFKZtaEFYC9exYgP/g==
X-ME-Sender: <xms:RFG0Z-hrkmk-PP9SjWI5_3fTUlX1ovglGTv18vKkH4EmQ3XsoqYGdg>
    <xme:RFG0Z_B9IHKopKmf3BYGqDpK_YCyIxR3mqCC0CeoAwUr8Ds5KmEXEamyNyENHYhc2
    PQhNC1QjYYFSvsOEw>
X-ME-Received: <xmr:RFG0Z2GXm_nfzs9FyCrrWjaSs_ImimOr1pcTKleJ823IK6yrd50ABxj44XgLI8B7q6ywhqYP9tRu1sOVyj7ZoquZSA0xqF4fLE0d5sUsdpRJufdu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepjh
    hlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:RFG0Z3QGkAE9BA8TyMgzVs-P8ItOVq2IrZpfwTdh37cmSGYxWe97Iw>
    <xmx:RFG0Z7y7UtdM1Fk-cbedaWhJlgolkSZjC99EFbczY10pYvrmbPjzTQ>
    <xmx:RFG0Z15zG52u5L4inCVYvQyqML4yLvv3TLq35DFryB5QqFCtL7olKw>
    <xmx:RFG0Z4wknN_-GDlaIVfOAW-GdMp3m4O-wNwsJkzY7CsF3XF5TR8jgg>
    <xmx:RFG0ZymbkoM08zu-mLkLe8ad5koeFEwvXy3o4_n390la7hPGq6ecrf5h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 24e14c40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:53 +0100
Subject: [PATCH v6 17/18] reftable: decouple from Git codebase by pulling
 in "compat/posix.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-17-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The reftable library includes "git-compat-util.h" in order to get a
POSIX-like programming environment that papers over various differences
between platforms. The header also brings with it a couple of helpers
specific to the Git codebase though, and over time we have started to
use these helpers in the reftable library, as well.

This makes it very hard to use the reftable library as a standalone
library without the rest of the Git codebase, so other libraries like
e.g. libgit2 cannot easily use it. But now that we have removed all
calls to Git-specific functionality and have split out "compat/posix.h"
as a separate header we can address this.

Stop including "git-compat-util.h" and instead include "compat/posix.h"
to finalize the decoupling of the reftable library from the rest of the
Git codebase. The only bits which remain specific to Git are "system.h"
and "system.c", which projects will have to provide.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/system.c | 2 ++
 reftable/system.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/reftable/system.c b/reftable/system.c
index e25ccc0da3c..1ee268b125d 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -1,3 +1,5 @@
+#include "../git-compat-util.h"
+
 #include "system.h"
 #include "basics.h"
 #include "reftable-error.h"
diff --git a/reftable/system.h b/reftable/system.h
index bb6a7e6285b..10055fbff2d 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,7 +11,7 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
-#include "git-compat-util.h"
+#include "compat/posix.h"
 #include "compat/zlib-compat.h"
 
 /*

-- 
2.48.1.666.gff9fcf71b7.dirty

