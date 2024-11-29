Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245F19D8A3
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 13:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886031; cv=none; b=WRdg29rqWClBwga2f3d5e9UGZuc2G5TvvoT3AZFXdzJS+7RRxZGD66TISnyyw04wNHntj4y1h8fQ17TQcbV27hxlYLBYyu9MDk+OqnVRcipm41tLXA5x8lDqSqCYUCqYVyXVD/4zNThoKmEQ9uj0X1hy6l0LZutk5xahZMKqFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886031; c=relaxed/simple;
	bh=+GAZHQwsNXOz5X6RBqCMGSS0jJ6zg/37nifc597U8/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rS+L7zxhyuVi8WtEvhk4/dJaPmFRMhudXfAlJEZF7Lelv9JF9OOVszFuv4IMD/Vu1HVTUBMR4HIuuNbbE/vNYjZQGeYKWNhobwss55cHnV6necloJOOTq7MDd+OcBKq2A/J/rnv5RI7OHn6SrmGfaIeACkSOdhq0DzBNR7zYL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MI/M4uuJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jU+r6JH8; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MI/M4uuJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jU+r6JH8"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id D81761D40663
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 29 Nov 2024 08:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732886027;
	 x=1732893227; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=
	MI/M4uuJrXwi7VhrDQ39GWhLjhxnBBmeaR+cn65hZ1c5TtXoH8LUPDXHJCcciKId
	BfsF0ZjXdQ3GW1HfX+90k525lJu9eJktgTSjPu+FUX10vpy2vP9OIfDxygl8z4hV
	bc9VknAt1MxieE/Y3KQj3BElcJZnZjEaN7GpNSwYuT8JKsR8CTcLgf1M2c7WUbFg
	lqrT5bHLEkYBV3Oob2K2VZCNQEZnzgpasJI5ZqJCNFIYZGDq1tMKocNMYEspxbjw
	Pu7Vra877UW3nyEj96eWFWwmJXm9reJ5m/2D/+YSANAFMX61zGvl4uK/dWBX5iYo
	9HFGRGBY9XDfV39OeAphFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732886027; x=
	1732893227; bh=b6ho0wcLsh01aSmlNVS0ZfrjkuOVmB9vVz4X/lCsbbs=; b=j
	U+r6JH8qGac+3tTk37v9V2UlrDFszUgmkvKiOPHBFTVqQObnyGWEZg5+BH49V3y0
	s6I3l34eeiWCGCk/zeE9NzW/74bv46BgMwuao3Gs6CjNwF0AOQYYk0PlF+7sYYL9
	JwxZnIRJ6V27Vm2ZzjcApwYykhL8jksbIeRReC/3CXsEXQgo7inHOIjbSv6kUrMT
	/y/QuOOk4x4ZOdKb3q7d+sGfoGeA1xjJHF6x2pvE2k+8NzHuBB1xPNB2yFh4PuWU
	LC4zdALqTSD4GHUrOb81I8v2E+7hk7wJmNy/rcRk2dUS/fQp/7G1jeSnME4VSTWu
	Rf/blU9uhp19viRSF+7mQ==
X-ME-Sender: <xms:C75JZyD3_cH6I6xYH-RZprF0vYP69dVB9gOnbRwVEYI5_QFwJtcQlw>
    <xme:C75JZ8gUn55EL1_DcuYGZng6EHnYBJO6qWIz6q_rcy8nyMDAAyUy7_57KnLIrGiQ6
    K_w5Urf8umQD4RnyQ>
X-ME-Received: <xmr:C75JZ1nhJwZ8zvN648JIxOTxLheAJKY1eLD0EZ_j5K6ibPTK8vjdkgA7xIFSCKGvKjvlEPomum3Pr_far9F2yF6fxQcMdG5Ms8l8LitdW2vtWgJLXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuphgrmhgfrhhlucdlfe
    dttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhm
    pefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtf
    frrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetjeehudetjeehhefhheej
    teeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucfuphgrmhgfrhhlpehhthhtph
    emsddsfiiffidrghhnuhdrohhrghdslhhitggvnhhsvghsnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtg
    hpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C75JZwxVYKRML5TNmB-76IMzycWx2kuF9-IVppR8L6S8aMeMLyWvLQ>
    <xmx:C75JZ3TCwJSvXbnCoge9QZbdkieaT5zXGwCS9GdvuDhghXJ_atJruw>
    <xmx:C75JZ7afneCR-H_-vsitBf4S3sCgq72fDClnErl-QP5ff9Who7m1tw>
    <xmx:C75JZwQWAMMh2rpJHJhPIjWvIs3PdLmLf45RHvpSndDBTdYXoyx0wQ>
    <xmx:C75JZ-clKuI9hWkUFOT15RSdkLv-1FpsmyJQn-mOevz73XNFTXVe5EJf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 29 Nov 2024 08:13:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9907ad20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 29 Nov 2024 13:12:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 29 Nov 2024 14:13:23 +0100
Subject: [PATCH 02/10] compat/regex: explicitly ignore "-Wsign-compare"
 warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-pks-sign-compare-v1-2-fc406b984bc9@pks.im>
References: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
In-Reply-To: <20241129-pks-sign-compare-v1-0-fc406b984bc9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Explicitly ignore "-Wsign-compare" warnings in our bundled copy of the
regcomp implementation. We don't use the macro introduced in the
preceding commit because this code does not include "git-compat-util.h"
in the first place.

Note that we already directly use "#pragma GCC diagnostic ignored" in
"regcomp.c", so it shouldn't be an issue to use it directly in the new
spot, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/regex/regex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index e6f4a5d177bb7d44345fcc25fabca1e62b0eebc4..4b09cc4e1457dc362b2c974e82a6f9739b499a83 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -17,6 +17,8 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#pragma GCC diagnostic ignored "-Wsign-compare"
+
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif

-- 
2.47.0.366.g5daf58cba8.dirty

