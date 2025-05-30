Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6662356DE
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617731; cv=none; b=b+k8qygq0dmf+7ku++B9jj8LlVLr4RSSB5XzcdEMfB6fR+cl4v9yqdTxiN6WR3j7CZU1GRdvUyQsWY5yiTJ/LbbK4k9KBIbT7DrYkhXzc6She633QZn9XTptGGNiyjaE4z6jqwyxewPTls056jmktpRDrn5v65qJ1em5i4f+8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617731; c=relaxed/simple;
	bh=gW3AFrMYjlQfAo5/rgSphkSpw68u8B8Rpgklg+4o5tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=djhb4PZBssBUCQc1LWLx1DS0YnScblqCscWw8Krr8BiEzj//QlNUltwZ9qyTc4F3UCmsNT18KnnB9KFxNHM9kFt/KDz+Kso4me9dVGiGMAmHOHnQ2WHnVwTGBat7vI7x0v3re9OAHEp8VDRV2NymmFz39dLk6RgNc7rvILYsbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QQ+Vym/9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YnMUggSj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QQ+Vym/9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YnMUggSj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84F051140165;
	Fri, 30 May 2025 11:08:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 30 May 2025 11:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617728;
	 x=1748704128; bh=B9KQR2b67ClfR7MRPW8esvrM1/ZM2tmIYNhQvxkYmQU=; b=
	QQ+Vym/9qEFCJ7Fsfqb8A4JpfGPxy2xD5GGuMQvKxlZP1ZPUQcmJQZsiVfsCHYIM
	DrhccGMv1WFXigvjgFsQcew0J0H+04FeSCum2do2JuqozHnbofbZinpNcwY+G+NW
	+h3E84XUb8VuwTEOmdqwg0fqtS5b35lsgEi+WNg7U63kMQ6xFeX8Iq24SH1wa1T/
	m+w1sG86EiXRkQWRDZtQmg1cjlwv8sk83KN05Af153FBQHU/jyHv/cySTs1rTZZm
	o2jg7br3U0JwkEEH9DBIeu7Edy8YXTBByh7o9QrOrfdZJPu40dhHtUA6GbqrKtko
	JwW0mIM61RQvHYGmIJ+cMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617728; x=
	1748704128; bh=B9KQR2b67ClfR7MRPW8esvrM1/ZM2tmIYNhQvxkYmQU=; b=Y
	nMUggSjtDsGxo1XepQnp/VAwNegeZ8ir0aSJ+iOSdoKxOxc2k5UAZpnx7YCFRcfY
	HzyQmfeyf9ZPbwXXybRzSmW1XilbtbOh6lcwrDbxY/7R82O8rNPwPGv/c9p6Uy26
	owWfJa8zzqCNsnLlXNZOeneUrXV2QHaOjqGtS64p/M9gGTZKg1Pn8Xj2X4HXD7+o
	0IoVa/nWRxeG23NgJfPKYP+6TMBrUJuypAz5G0Bt8VHfogkvqTrUksY3uRjHQ6gu
	xybs0q0WmQ9j45sxoZxGQ0pkXIAEFhuSYNYZ7Uc/mIdjIfoKm5g9Y90OuA3ZpVue
	alj2hZaPHL/73U7k4Ul8A==
X-ME-Sender: <xms:AMo5aJpdaptiznQHmZ-mgeRkSZTnsz3ifGwChZAAfZ0tW8ovhbl-Ww>
    <xme:AMo5aLpSUNpflXAvhqDtdznw3rcJ_P76rlu2WNKp0IDqnLF9WooimpUaTD4BtPpzX
    VPgsA5zqw_nzqcsdg>
X-ME-Received: <xmr:AMo5aGOtXqVCTZw6jlmszrTLN6UN2X_ZP2yr-HcbKj_DY0dERzeytub60sEXhzJcyzhKtb1rlvqML-q4gBV0DT0GT951ezfIhjQ8w_j7Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgv
    shdrphhluhhsrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvth
    ifohhrkhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AMo5aE4xPm_paVvxBHX6SU26btvWjXfXDEo3dO5DFCCYYeUIDZaFYw>
    <xmx:AMo5aI7W8pEIzdJFYupPr9BxttNpn794ja7IrbXiFxlLrvGfDBTqkg>
    <xmx:AMo5aMiK98DePp3NGf0FfVhEdeSNxbrox7l0G-1qpPgWphBemilGTA>
    <xmx:AMo5aK5YE2OoUxGxzmO5wnqhUdGSSObRtQPEr9r0_QennmLW97xTVg>
    <xmx:AMo5aCuJHxwKO7ENiOajs5qwMTG8BYMiiBILXEWLoyq8kSUVXwqdNzsZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f2f4db82 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:35 +0200
Subject: [PATCH v2 09/12] builtin/maintenance: fix locking race when
 packing refs and reflogs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-9-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

As explained in the preceding commit, git-gc(1) knows to detach only
after it has already packed references and reflogs. This is done to
avoid racing around their respective lockfiles.

Adapt git-maintenance(1) accordingly and run the "pack-refs" and
"reflog-expire" tasks before detaching. Note that the "gc" task has the
same issue, but the fix is a bit more involved there and will thus be
done in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f64bae0a825..e92015887a7 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1577,12 +1577,12 @@ static const struct maintenance_task tasks[] = {
 	},
 	[TASK_PACK_REFS] = {
 		.name = "pack-refs",
-		.after_detach = maintenance_task_pack_refs,
+		.before_detach = maintenance_task_pack_refs,
 		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
 		.name = "reflog-expire",
-		.after_detach = maintenance_task_reflog_expire,
+		.before_detach = maintenance_task_reflog_expire,
 		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty

