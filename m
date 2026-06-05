Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF630ACFB
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667798; cv=none; b=cNGlHORBFIZaWvaEZOHY8en+2Y6u1tl4yYIhyAgDxizaHRGkbPVjdZNWD2M+wZZGn53lkBndM/Akb3hXHr2PleVSFRrjwEQqSZOTg+Yl4aL6rY0kgzn/xZYGOyvxCPgtbAUyJwRnXUtH9CnbCewKuyvWCfQKUDYe2eykx/G4HA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667798; c=relaxed/simple;
	bh=BkFGkKez8iHb/MusuO2AS4l4fIbjfWlhJnpTTSbUZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imJx9MSEQRSylDkLbA8e4DGzs7wWZCKuWaET4Xc8RxGkop2JgvXNYvvxmUfz8vHc5nm7FR0+no7ZQwlHRP93DVwNxF48ydYo5sYN0Qdx7TyAK/Ug8GvH6iKaeqP4kNyuD+9V6LPDpVzKFuxSjs50vblmpdsPNbEWsnI96EvG6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=uy7d4Aw+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a478yqac; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="uy7d4Aw+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a478yqac"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id DAB31EC00F8;
	Fri,  5 Jun 2026 09:56:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1780667796; x=
	1780754196; bh=dqVTUHuM5NqzzXEhARYRIZwN7L3IqYN17j6YGL07Cx0=; b=u
	y7d4Aw+MnpupsncFkmwHzXYcBwM4BaUh8CtF5ewfy3oK1pHrYlJ/RRwFlPdVVfa+
	lGdzIGu3Co5JnoEw6ZX5O2zgCDNkNi1ZASrlpcIU00XhBcozN5QBHrml05nQQdw5
	5HuE5h526YhYdQ6BXKmjqMnZ0JK5uOZUyLSl08xxcZ9V4ml3vp1ar3msbs3jXcMp
	hLmzZbE0F6TmatxaBvkkdrE7muNeNgmKSv9d8lx8apKejRT/+DYJT28Y4wpNyiQB
	B9Kgkhe3EcTJNJ5tpHPUF0x393hv6jyIPmvkrb8ynkQlEO1ut0eXaai3M5fj3GKw
	II1OXyOSuCCUyHmZv1NnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1780667796; x=1780754196; bh=d
	qVTUHuM5NqzzXEhARYRIZwN7L3IqYN17j6YGL07Cx0=; b=a478yqac3Cze2t93G
	YrHY8IwjGG/xiiR7rrlLD23pFmA7/KDiCpTyPpmQ2A4KrLVTFWPqqZWDgL67Klqs
	4buI1axUhyWMsWOgakq6hC79ZAHN9xvZokMpzF6vQK4oq4cfjDIFNiZ1wbWbnht+
	r1N3/YAWhTU+CG3mDWZX5yDn1TkRtk3KyQLZCPct4c+3qnNuqe1s8y9e6bQpHdvP
	3rqCTCOgNvYWBtssbdQ9uuU4u47+F88VALqdFSK009HNkLb28BXQRG14mcFJS1ks
	xnOFpbEzW0hNl2wGqn304pQE8y00pDQyKI8xqGM/WpCcZ/u8BnNHmRFov6O82VcP
	4W8rA==
X-ME-Sender: <xms:lNUialNtXzhpp-UYweIYU-jb_q7Q-DGk5oAn_ma0m-HpxXE1H_Qpdjg>
    <xme:lNUiau0Ei5pJi0ep8jPafy7_GoRtRmY1X-vWtnck2ZgGFgNcxAmmqXhuApq8Lrio4
    XpiLocGbHh5sGq_HZF3uuaESY5XOaJRfrHoh0G1q6sf-9NslfCWZw>
X-ME-Received: <xmr:lNUiasmZLGeYeE3RcrMb9cHVQFZUKPoZ5GU8DXEG31JA3fh-mmHIKrWISa9IschIYVBj9rBMfelzw5G-HjKeY54yqxGjZEmuzXsT_1U>
X-ME-Proxy-Cause: dmFkZTFaAX42+CwgTGdQyWJUlAGYNA5nNNGiothCr8zKzfL1IUpN+CxxTCiFA40QR+lFor
    YR+xChpYKjACobTHtEYrbx51cWQdQEXYyW7Uo4H0AmGK4eZC3qEdGBCtR5jsIvt0CzDRP0
    0jpphMUq/89eifafL+0khl2LKN4np8/Uc9zNzsVvPwtZNZ8O3uDS6oULblfjjGFFvmpOXn
    iypraTvF35/wbwWvU+vLa/OUdmnyd4+G/MicYci6ywaW6RyxbnukC/VDdpWL3W+vfAY1Z4
    bKI6wfD90lvAnIO45BwuVjofjLio2iU8q+d//FfmjwA3d0LwY5Nif4nNThCB7uw32VEiNV
    FHI/AgakdmnSAKh/6f0NJ9x9qDfj0PHJQXpaRzP8t/YWWNSQGM1hySfy0entg3ll2xliye
    95vkCA5BgCX6sc6xbLEU5M2AyhaJZc/hw5DOS6tgG01ChIE49vrztglTi+gjoZK7NN/Wnu
    rBZPzrmY94hhqdhI6EBE3AA/GxVlCYThWHPnj0bBsXnoSVZddrnT7Af7iZnRfH8CLa9EYG
    GNUZD5G0XyJRctEzqA9w4dqtA0xzrFiba9hjz+OiG4ySucauDOKzxiGNhght/8egJAmSf8
    9SRIrLGABgFW9zlpaxKzqvD09AjuZbuG8N2xxxbxXryZRBRZ7UMOP1pF12MA
X-ME-Proxy: <xmx:lNUiatU6FZnec-PUv24g-Wc73Ww-kT34aUVXCxUq9bTbEjs9Xrwz4g>
    <xmx:lNUiaqsnV2jGa_NDVOFnRRYaNQUZzQXzksZc0F_QP83thxSG5VvETQ>
    <xmx:lNUiaobfX5o7uUq6d821DpJZnxb0JfgugJQ-SQ5MVV3x3oD0GNONSg>
    <xmx:lNUiahXYZXcAB6eDzjAo4o17uGvpdcfsD5s3B1m7jLdCb6V2eRmH_A>
    <xmx:lNUiakmZBAP0LzmtsxhVZzZRCoU9YKrf_ZyQ_iDZs_EJT67hD6t0QxCq>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 09:56:35 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 1/4] doc: link to config for git-replay(1)
Date: Fri,  5 Jun 2026 15:55:59 +0200
Message-ID: <V3_doc_replay_link_config.781@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <V3_CV_doc_replay_config.780@msgid.xyz>
References: <V2_CV_doc_replay_config.767@msgid.xyz> <V3_CV_doc_replay_config.780@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This config doc was added in 336ac90c (replay: add replay.refAction
config option, 2025-11-06) but never included anywhere. Include it in
git-replay(1) and git-config(1).

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/config.adoc     | 2 ++
 Documentation/git-replay.adoc | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index 62eebe7c545..51fabecb9b0 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -511,6 +511,8 @@ include::config/remotes.adoc[]
 
 include::config/repack.adoc[]
 
+include::config/replay.adoc[]
+
 include::config/rerere.adoc[]
 
 include::config/revert.adoc[]
diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index a32f72aead3..f9ca2db2833 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -209,6 +209,10 @@ This replays the range `aabbcc..ddeeff` onto commit `112233` and updates
 `refs/heads/mybranch` to point at the result. This can be useful when you want
 to use bare commit IDs instead of branch names.
 
+CONFIGURATION
+-------------
+include::config/replay.adoc[]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.54.0.22.g9e26862b904

