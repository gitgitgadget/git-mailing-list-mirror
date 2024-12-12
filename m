Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F91862BB
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986061; cv=none; b=FXARNd0Oj+Le+bd4I7DcldzPnQw0BimbfAOFK3gyi9BQtIbe3yvhOe3mgPbJ+E60OOJx8Hu4Hf1iqYgCscqK/pewUNICYgj+f+80K+xecGRwrkc2zAyKwlIkzY1KP1yRZ2pUtSHKeScl3QEsdP+J3A9ZwROXdi7y7D3itaaifuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986061; c=relaxed/simple;
	bh=6u3jNIEou4E7E8+mlNXJvRTj7OuT7PNb9E7b14MmqMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXxmTgTJb3LQmSURGBDIkLIILRFd70bhqKdnYOWY5qn0h0fgn47GT3ZQKeOvN1qA0y+HLba1yweksFywjDTPV2gHl/QUNcIri4S/oO0wiFLX0blzjkhWjVaCJ8UXAsdLAqKDhQDXEhwKQjX90nPnB6/14eG+wphp3FrU1jab0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZO++WCry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FlUhfGMj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZO++WCry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FlUhfGMj"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C7DD1383F78;
	Thu, 12 Dec 2024 01:47:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 01:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733986058;
	 x=1734072458; bh=ttMliZIlbe1cViJbN6Y2nApJ/42o8hTTGc7BcrOhtjI=; b=
	ZO++WCrytbnHc1Fib73tCGS8QU71Cg6qZT24PmjMJJI0GDM27JI2dMycA2+9Nwdo
	7tyYIr7VPuK+7+oua0W0dd45ZlWdBK/mdXed0bxtMGYyJ0cFiJhr8CZI5qjol9WC
	Zp9ESJqqzi5+ENTFFOCj7W7bsu5cDk0h8aLMuSOkCbmS3fuQwWR2IGYg8rn0rnpS
	SwSS9pn67y2GyE21E2lPN5x0jmebfMspaZmhTQwgX84JJqg6niOCXKntxyRgtkYH
	Ca30DaaIhaOp6GydWLs6s/MNwc2eDly38rLquCW2H1FBrjxUM7kthPMv0Nfg1joo
	A4XGV+hM4tYyIMp3rD6xag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733986058; x=
	1734072458; bh=ttMliZIlbe1cViJbN6Y2nApJ/42o8hTTGc7BcrOhtjI=; b=F
	lUhfGMjU+5uMaWvS24XqiUaZI6jp2hEMvW3rvauFYV1t9g5PLQUZDiFckfT2CREy
	LkltKbGEqwDgrDA4eL3GusiZuMLzLjrhEybLu1DI5EJG4SqLQxQUZNzS4zDE1nZ3
	i6Ss6CC/tHOdFnaMCDglukhsQS9NY/F0bhDhDT2fjWK+0aXXXsxd24QQyw5e3zGm
	qv0Lx61j97no3Mxy03icLUOC4WceJANGrmUNYUaD50fAVn4TKCuZi17P5QIb8DrZ
	Rt4DU5L0TLVRoAjWfKqIeBmLFQbiaI/hv0YH+Q7RcRsI95ZXQt4tUkqyqvHxycpw
	G5J40wsb+Z/5FtFqbex8w==
X-ME-Sender: <xms:CYdaZ9GHbpFlfk-x6RVjLNCShKuKsXqsn8ofLu3saFBiFL9uZBAdPw>
    <xme:CYdaZyW2t_SHGadvpFCgRTxmFdMU1IUf7ENBjNXvlk6JqG-X3_opjkkyOmVjNpJ9S
    1UtJKSu-hKTzdGYhw>
X-ME-Received: <xmr:CYdaZ_IjWjcqNMfQbMPAAeGVw78rQ0T7x6qX1Btucg-hmbcOOdtlRKpnh9EV9ql5XNrG9tlHIukdERBp4v-ue5CRcSxG6zZyv3wIvLAIpy85tU5K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnh
    hhrghgvghnsehgmhigrdguvg
X-ME-Proxy: <xmx:CYdaZzEmqNGZjrNf6Q9wlQK8H9CwySOCtkp7xcCQmz-O95Lwhkck2g>
    <xmx:CYdaZzUNWEb6M1uTd-GjF9ZPQloTvImBf52m-4yknh_zNeUsxJX-8w>
    <xmx:CYdaZ-PZHbMHmTrNHFxb7GLy3g9nso0apadexK0dhwnnjkGRUYiDYg>
    <xmx:CYdaZy1JWT9wQzklCSoiSOb2dyp9jtWNTzS6xqm3LWQay7vGqw4BNw>
    <xmx:CodaZ5zwZ3rnIaELQzDjYzBsETMjqwPs3qt0mOPtOi6eInZGgS2Z6vGP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 01:47:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1addd625 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Dec 2024 06:45:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Dec 2024 07:47:16 +0100
Subject: [PATCH v3 3/4] ci/lib: do not interpret escape sequences in `group
 ()` arguments
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pks-ci-section-fixes-v3-3-d9fe6baee21e@pks.im>
References: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
In-Reply-To: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

We use printf to set up sections with GitLab CI, which requires us to
print a bunch of escape sequences via printf. The group name is
controlled by the user and is expanded directly into the formatting
string, which may cause problems in case the argument contains escape
sequences or formatting directives.

Fix this potential issue by using formatting directives to pass variable
data.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index a54601be923bf475ba1a9cafd98bb1cb71a10255..d403ada911722af554df6255e5cd3fa01b56fd22 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -18,7 +18,8 @@ elif test true = "$GITLAB_CI"
 then
 	begin_group () {
 		need_to_end_group=t
-		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
+		printf '\e[0Ksection_start:%s:%s[collapsed=true]\r\e[0K%s\n' \
+			"$(date +%s)" "$(echo "$1" | tr ' ' _)" "$1"
 		trap "end_group '$1'" EXIT
 		set -x
 	}
@@ -27,7 +28,8 @@ then
 		test -n "$need_to_end_group" || return 0
 		set +x
 		need_to_end_group=
-		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
+		printf '\e[0Ksection_end:%s:%s\r\e[0K\n' \
+			"$(date +%s)" "$(echo "$1" | tr ' ' _)"
 		trap - EXIT
 	}
 else

-- 
2.47.1.447.ga7e8429e30.dirty

