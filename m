Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CC1CC153
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017069; cv=none; b=iNcJLtCHNFGkWzEJjZ0YbMvp4fX3w3TEhDtvZauEGyyTiCOHoiYTd7DvEw+cwH5W2U9SDN3gBX4eIXTCOYH0V9oVI7cCMkCwNl97QrWNqI8aH1xQfRt0eA54y9QqH8GKjMP6+xVfO9npiP4eXn5B2YlJQ6xgQOq9QCtnrF8nmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017069; c=relaxed/simple;
	bh=lBb83VPZWI8E0C/2kPwmOugImkaL7zngFYyO3utEH0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkEdgLaCAcAHVDiKHx6enr2kDfjDclu8YrVeL+NwiTEF1K4ryy94l1mB2NsvhVS24qkvr48L6zgg7d2HWURvsdgfrJd5fqgrNRAMJR8o0+lh55AZHMacvuAhxLdKzu/ysahSV/mzVXIrnMWXKv8mcTilJHsf/SjwFfQfgOTp/rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tl2h3b8y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=czisgvn4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tl2h3b8y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="czisgvn4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 819BA13805E8;
	Tue, 19 Nov 2024 06:51:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 19 Nov 2024 06:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017067;
	 x=1732103467; bh=3LjDM0NcWrWghZ/0pZnXSaXZ8TX7J7O9TnW1Nap6fME=; b=
	Tl2h3b8yGCpENBoYEgYlAUB6q0jZjMxxhxuR5kBcQOJb+AZujC5PlRokzkbEFcbr
	aqpXvLmcOkBn+vUimkKJQPEaxett2qd4jaRLCXVRr6iG24uwbW50kX8Cd393ANQb
	/8gNQujVxvgSvxhHWC1nMbTxjXh/hg+htI8j64VxSy5VrkJhoikIhmGay/KesnFt
	DfdnXtz5rR8VwlNfyr9X5F9P3aZ3qJi/BjKrO4ROPSfljqOPR6UOs5Ch0+XgO0WP
	/9kAxD70uC6of6FT87vYclv7ufmGyPOA1xyAehefB/3YCkVKdSabehJ/jx33ApkF
	sgXqWOsBBzJhjrehlbquZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017067; x=
	1732103467; bh=3LjDM0NcWrWghZ/0pZnXSaXZ8TX7J7O9TnW1Nap6fME=; b=c
	zisgvn4NzpSfy9XC0i1/KsvK3g+YZ7Q6d7uO6gTbLZJ6MbvCsXUv7WnGWR1/+9U8
	IXX3GqcyNSgvkVQ9D0H/xkY2rwf4qUASZXQeTlMqILrr/PulYB4fBZyi61OucSlX
	X66F6im2oXWC0Ju3Nycw/wI9h2Qp0xJXJQf8I+VvFNgZlNrIcf5H29M+ejjNoMhv
	bUnWkV0+ENd5YbkdUYyn9Ndq+YJsidC94mhdpLxs9ShGkpM1FcLVgnGC5ferweo1
	j5h4+vl3gsdGrXTEzxDQvQafwv0iVz67hPKA7QTsWTVwIzBmzJMx18oHQXob7629
	KEWvN6R/Ecs0NFqL4tFUg==
X-ME-Sender: <xms:q3s8Z8n773zaFckFZROVJ3PGhqElewJfS1c6hk61G0NFfHcCha4cJg>
    <xme:q3s8Z73mpoGOlqqSiSQ76DBeumZ0AKKNFQqgE1fLfYeCgbC4YiN5hwXBb1-Hsvm3A
    1K8wDZ9ifqx4QKdnQ>
X-ME-Received: <xmr:q3s8Z6pk-rpaFo5zxaP5E_NSFfFaoS6orfZ0PhIwH1wpw7ze7l292iiGL-E0HYWMuQ_uIuRZ-wncL3qFWWTX8qvYzdtiemrpD7_eQjbi24-_WdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopegthh
    hrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghmshgrhies
    rhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:q3s8Z4kEqRCxgwS29sy2VEzy0by_1qKjpa8a4RGq0T34kCreFkAi_A>
    <xmx:q3s8Z63ImSoqQIlHRwAhemrO7xJV1gVqa6DNsjNUUztbDxyKzi617g>
    <xmx:q3s8Z_t7KNTr-tvm2K3sqYpMzcrq10O9Pw4pBtKPHgo9b13IAtG7Fw>
    <xmx:q3s8Z2XdoRwRhoDSZ8xHJUjHujpZmzpcWC_Ap3QKL5lphgbkj9uYOQ>
    <xmx:q3s8ZzvgZ2PNEW9zE260h93uexyQsKu8E0YkPsnIGKCwk15C2KbSsfAi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41f45968 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:49 +0100
Subject: [PATCH v8 12/23] Makefile: extract script to generate gitweb.js
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-12-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Similar to the preceding commit, also extract the script to generate the
"gitweb.js" file. While the logic itself is trivial, it helps us avoid
duplication of logic across build systems and ensures that the build
systems will remain in sync with each other in case the logic ever needs
to change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitweb/Makefile              |  3 ++-
 gitweb/generate-gitweb-js.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 16a2ef2d1e5664d99f6f1d8ff4224c36769c55fb..d5748e93594eb6181269c2fe272bf7ef980cbe68 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -115,9 +115,10 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 	$(MAK_DIR_GITWEB)generate-gitweb-cgi.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS ./GIT-VERSION-FILE $< $@+ && \
 	mv $@+ $@
 
+$(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	cat $^ >$@+ && \
+	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
 	mv $@+ $@
 
 ### Installation rules
diff --git a/gitweb/generate-gitweb-js.sh b/gitweb/generate-gitweb-js.sh
new file mode 100755
index 0000000000000000000000000000000000000000..bb81220da393ebecae28b675c299b626f0e698fb
--- /dev/null
+++ b/gitweb/generate-gitweb-js.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+if test "$#" -lt 2
+then
+	echo "USAGE: $0 <OUTPUT> <INPUT>..." >&2
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+cat "$@" >"$OUTPUT"

-- 
2.47.0.274.g962d0b743d.dirty

