Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8833C1BD
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582546; cv=none; b=phhFUQLhRXBTwOhZE7+5J6yjrgsZccnveWjAlHa/VgVlkRwjEGYAjfS6WdoyZkpCFQ59F7tEg06QzNoqb67Oi9WfdtBi1/ESIcY6C70ttWeWQe97IxEYHxeR7hBfGiRoQkBFuT7hxLSpgUnAPCq5zV1e7OY6MCBzNR8M0JJJJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582546; c=relaxed/simple;
	bh=zgIfXPk1lEjEVuA/O1qtRpru7O53TuJbxFAJKysRYVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igOT38PKpG80LSGgEmYe2JMNzgJEI3B8GaBvRXf2k6fCH7JQILFuPesO7aJpZKE9yRC3a1nwXoSBaKTtqohWVgolAfZtiYx92C9GmSTDMgHYWFjY2KRMrqbR8SHsXCuGI91VU01rtIcDkRtKmhN4/csj/OoMHc7Lt2HMFiFyLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KglLnGz1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j6FJQFiJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KglLnGz1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j6FJQFiJ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C06A1D001C7;
	Fri, 20 Feb 2026 05:15:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 20 Feb 2026 05:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771582544;
	 x=1771668944; bh=E30e6EaQVG0ElGOqUjx4PiPxljZdsJZoOoLos8CgGxo=; b=
	KglLnGz1NVqB4kkPdxeF8EMQjxfNtHSRZkqO28jVvuHK4pgVVq5s4T1xqL5ixVXt
	rKsb8kDjuMiIeHo5t2ABl+R27d+KBOFQW72vI3zpxDpFUSQzh7nxSApLe2PaFDXQ
	CscB7Vov8hDnVzQfVNSMulFKu+BLkGG+rJDYiej7dV8U1IrFMxDUJoeCbNAKwqF3
	z2sVAZbcS2riReIlMk5jhhxPlrmnuNuqWiXi8tgS1AMGz6+84GxjWsWSKCMSYXfF
	kPaKbF/l00zLoiOOTPy8Llk9XjiTNcjopeWaV5RayMpbSxJwnimd2HnuJAZceBNJ
	YvgQuBw4cJtRV/WkRzlQaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771582544; x=
	1771668944; bh=E30e6EaQVG0ElGOqUjx4PiPxljZdsJZoOoLos8CgGxo=; b=j
	6FJQFiJf8S8+7z42oh3z33Z+cdfQ6Tsl1uvh2+zQPHQHPWma9Pj7/DIIUerGTHha
	iVr4qtOZIvKH3o1i4HzsERBQDdW7Q/SkBztRgIAmZmWGRnRmnkhVYzh6+VXDIcp5
	lPSG4o6HBF3/38yJP6HLfwsEd1vZWUjdIWiLvA8RHJR/bfnd0RMP60+TNb5hIHHj
	e7i0S9eGrEJpds1teOGbqzNGCfQZqq80OWm283GC7tO8/UVUX33Bexep3cJ/43Ah
	3/CS8Ku460UkZk8ec09AkgAekyuYsbtlsVd4hJ9vxA2YYTycu5rj+DtKB9lv8xD5
	dDVAYu5xz9wl66fgITksw==
X-ME-Sender: <xms:UDSYaZJOxe1kCp948h-TUcjmM9Vyea8V8_c7iwvJXzXg0l3bqeob2A>
    <xme:UDSYacmXAz5xE9He3EqtpoWjMVKkBmEiz3jQ26lto8X3Se3n4pMyHBKTckytqtAQe
    fw_Ta6dI6DUoa8oZW8qGnVk7LEqPYG3q0Z0a7p3lttFQxWfIc8_mq0>
X-ME-Received: <xmr:UDSYafE-sBHGV3uBgYnfM1XMtByclegdBmM9jn2jCRjihLMLlZHoCY8287E_KNj-gVByxWDihMUNBtO7I_On7sbdtjmxBVrGJYsK2qWLGdJi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UDSYaUHWjc3ezaxETeWoxfFszadfO75jKSpGA5Zd6CQuSO1W7GZMlg>
    <xmx:UDSYaUMbMEAhLq2xyUZoT-EA40fCVkp7rppUvoR56ziEnkTppRgjOA>
    <xmx:UDSYabFOT9MPERHoYOktyoYJhdKbCEhM2VvR48BLxSLoBdoreZeAxQ>
    <xmx:UDSYaTORdrCCAlSytX5hic2ODb6xRSriygiopSl_4mjnxJuF5T-Rrw>
    <xmx:UDSYaUAfdQzmhWoRdXYV1cP2IsWp-YRrlSQuHAljFs9lTHroJi39I-3v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4601653f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 11:15:12 +0100
Subject: [PATCH 8/8] builtin/maintenance: use "geometric" strategy by
 default
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-8-faeb321ad13b@pks.im>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
In-Reply-To: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

The git-gc(1) command has been introduced in the early days of Git in
30f610b7b0 (Create 'git gc' to perform common maintenance operations.,
2006-12-27) as the main repository maintenance utility. And while the
tool has of course evolved since then to cover new parts, the basic
strategy it uses has never really changed much.

It is safe to say that since 2006 the Git ecosystem has changed quite a
bit. Repositories tend to be much larger nowadays than they have been
almost 20 years ago, and large parts of the industry went crazy for
monorepos (for various wildly different definitions of "monorepo"). So
the maintenance strategy we used back then may not be the best fit
nowadays anymore.

Arguably, most of the maintenance tasks that git-gc(1) does are still
perfectly fine today: repacking references, expiring various data
structures and things like tend to not cause huge problems. But the big
exception is the way we repack objects.

git-gc(1) by default uses a split strategy: it performs incremental
repacks by default, and then whenever we have too many packs we perform
a large all-into-one repack. This all-into-one repack is what is causing
problems nowadays, as it is an operation that is quite expensive. While
it is wasteful in small- and medium-sized repositories, in large repos
it may even be prohibitively expensive.

We have eventually introduced git-maintenance(1) that was slated as a
replacement for git-gc(1). In contrast to git-gc(1), it was much more
flexible as it is structured around configurable tasks and strategies.
And while it knows about the "incremental" strategy that we may use for
scheduled maintenance when configured via Scalar, its default still is
to use git-gc(1) in the background.

The "incremental" strategy isn't really a full replacement for git-gc(1)
though, as it doesn't know to expire unused data structures. In Git 2.52
we have thus introduced a new "geometric" strategy that is a proper
replacement for the old git-gc(1).

In contrast to the incremental/all-into-one split used by git-gc(1), the
new "geometric" strategy maintains a geometric progression of packfiles,
which significantly reduces the number of all-into-one repacks that we
have to perform in large repositories. It is thus a much better fit for
large repositories than git-gc(1).

Note that the "geometric" strategy isn't perfect though: while we
perform way less all-into-one repacks compared to git-gc(1), we still
have to perform them eventually. But for the largest repositories out
there this may not be an option, as client machines might not be
powerful enough to perform such a repack in the first place. These cases
would thus still be covered by Scalar's "incremental" strategy.

Switch the default strategy away from "gc" to "geometric", but retain
the "incremental" strategy configured by Scalar.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4390eee6ec..fb329c2cff 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1980,7 +1980,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strategy = none_strategy;
 		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
-		strategy = gc_strategy;
+		strategy = geometric_strategy;
 		type = MAINTENANCE_TYPE_MANUAL;
 	}
 

-- 
2.53.0.414.gf7e9f6c205.dirty

