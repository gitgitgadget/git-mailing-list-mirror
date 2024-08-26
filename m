Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DEE12E1E0
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656901; cv=none; b=LJKikqd+B+dlk6RboZeQ5oSAAauF50y/TuKBd94nj+xqAXeX9kIGKPwS5QdNoT61QUZh4e6Xcy2EHU7+QaDzuHW/Z+YXh4b6pdoiLKCJnrgOhiufhR+i4M+ifmQFpHeGpeuHXWRVyOdUHyMFZA6z12seFW2Ee7Fet/0LRIcJzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656901; c=relaxed/simple;
	bh=ACsl82fpSgb/i6QfY1fU/8WZMzOp/vIRuQ54AqoXEpw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI90ui9DFjhxDXZIRw7VQQHKVN8MhwTNIlJe0W6f1pzPt0dNNiqOKHgRe4SwuGvest7tWdnTN7U2w+MM0KSEWSQuBlOAfOxAih5q6qSAkP025lp0kbLSIm5TlhOw/4sjUhS7+cTUM5tYEOHPM3L5hW0tE+EM8g0QH24G1WI0dd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S4C8Hg8y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iGpEhayN; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S4C8Hg8y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGpEhayN"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6761D138FD0D
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 03:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656899; x=1724743299; bh=bGUrGH+76w
	XanVHFwc/ySrhQX4TSKi8W0J8KIGPt3FQ=; b=S4C8Hg8y/erDbD7oRffwhiLie2
	4cBsS/jUBQMYgFt8HGYRDWcScyaoLbMWZNsQORn9v66g0v4G3wfMJUzfhX+ckVHu
	DP/aZQLZvSi9p9dqPkU81Y7CUQn+bIvdmCg5DIRCyOglcjbkVdv29ikOS/eeUuzx
	CoyHKH9iv+y1qYEC0g7qwkuykYiZclFymRZzxl+8Tx+o4+PEXX869OAMT8qT1zZr
	3HqW7O6Ata5GrQv15yeJ+1y5DyI79L0XXIvk2GKEsOdmLeJEtlNBTimBrKXf/M+i
	/yPHu111qQkXnJWFvjFxnJJhm5+mFtOfFA91SglTrtOZ75ssup7Hz8zBcWwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656899; x=1724743299; bh=bGUrGH+76wXanVHFwc/ySrhQX4TS
	Ki8W0J8KIGPt3FQ=; b=iGpEhayN4pfWzYip37/yOPL8vVSQ5U2wsTwa7OjXHffT
	mXu0dNIRYHBegDod81tf1tqUh2PRjyahOdjguumts2gZPW4vEhXLioKTPnMEavEw
	ezNnw4qddWAhCQLgz2Zka9TzXAK5gsp+CsNXsrHWt2Wn9tMLF+ehSdMxdCFYBADp
	H6giQHkOR+IAzXC30qrjPauF1OpkJjY8Uu3yMEo8135814PeJyalX9ZAWRsE5BQM
	/rCriLH1JFRgyTsIouR1k8bv6i3P92r7JEDxyMoPCkWfM5x5ZgvLy7APKC+2/RtD
	P2JyNtDs3XSwveRoy0Fe7YRBGdxCmIceATedvGiAIw==
X-ME-Sender: <xms:Ay3MZrtIOpYej8z7BKe7VieYFTsuR0MMI4WDYIti4bzQEnMjltlj9A>
    <xme:Ay3MZscVg9LCfP1poz6NWMEoQvew1xUKPGWDOEZjPAhN_hLhRaFcjJhaNMkKL7jB-
    6ZkQepvQdxNw4vJ6w>
X-ME-Received: <xmr:Ay3MZuxnNQQNRoW9lZ76D53RlfTL2XWsPLYVXxAxNf07jhDp_RCWXd3q-P0L4eOWuN6s149jSxEDilChU7pPzE40XCy9p_RLENdAlRLBKgHUsyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ay3MZqOzjoBhaVHI1ioclJSoDZiEqy3hi_dKji1R7pFSRqUPYXkZYQ>
    <xmx:Ay3MZr-yriJwnjYHLk7DR2a3fYqp524BU8N-SbcMe0fP21aLl86cUg>
    <xmx:Ay3MZqVR9KNt3WXdQ9Kj95cihgjgBQmUn7NXBD1SR4lg7BJ8aOfjgQ>
    <xmx:Ay3MZseSGh38SfZK0maLAfbzHBWvOb6U5suEjpcKXXE1ikDIKt-9iA>
    <xmx:Ay3MZllw3YJvj2U3XBlnf7_hPcy_c9RPMyp1Kve36hSpO5cqWD_7B0Zy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb4001e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:36 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/22] fetch-pack: fix memory leaks on fetch negotiation
Message-ID: <33bc728a3450ea087ca786e9077c67a4cac0596a.1724656120.git.ps@pks.im>
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

We leak both the `nt_object_array` and `negotiator` structures in
`negotiate_using_fetch()`. Plug both of these leaks.

These leaks were exposed by t5516, but fixing them is not sufficient to
make the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 58b4581ad80..0ed82feda14 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2227,7 +2227,10 @@ void negotiate_using_fetch(const struct oid_array *negotiation_tips,
 	trace2_region_leave("fetch-pack", "negotiate_using_fetch", the_repository);
 	trace2_data_intmax("negotiate_using_fetch", the_repository,
 			   "total_rounds", negotiation_round);
+
 	clear_common_flag(acked_commits);
+	object_array_clear(&nt_object_array);
+	negotiator.release(&negotiator);
 	strbuf_release(&req_buf);
 }
 
-- 
2.46.0.164.g477ce5ccd6.dirty

