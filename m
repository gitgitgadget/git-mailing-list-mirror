Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5B13EC2EF
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316863; cv=none; b=HevH7VbTaVnJmHiJH+vPEwMRHxv8zyD7XOBW+DT+ncUGLZSXss68Ezyv8TMb85QJKu7+LP8Bij7+oleKlx/C+CQ6ZWj+SGwwwc3fn9aV328aFMC70Z39vxYAuLMFjE7dHKIZ/WXwjw48Lk2stAF0GugU3mQ8Q5weh4vSC6m8Qe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316863; c=relaxed/simple;
	bh=yG1FUsV7LrNj3ESDxhix+sC/myl7LSTwsaTDTGSWgqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZJk44tF+h5TWuefVh+LXqCSPfk1Ix+a60baw0GKBuN2ohUcWnreA+4dRvNZscVRlqHQE6AbWU3+VJ3H21qr2LaXj2HzbiaOURT+PEQU5xysqWhLQY+CDSGEMVW2ZnuPEa0F66RpHrlNLONPPQgke+jLxWa2de79iE6SWMwM/ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EtYSYWPt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=soLJBXcr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EtYSYWPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="soLJBXcr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A607EEC1835;
	Mon, 27 Apr 2026 15:07:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 15:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1777316861; x=
	1777403261; bh=AzbGCUm3YFq1wq38o61VKT3Tb9C0tpMWN3YVNE23p+8=; b=E
	tYSYWPtXEtZUPctgjOBZXt9aiwWntNRg1aj4C5tcUgPeRrvRMLzl4M4A57e5xVzg
	FwdD80rlrGk/BMapkXRHXql8yRVqo5SRnHh2Tx97NT8Ws4ii4Ddlv++ANXGmnI2J
	2Un12EuZn7+R2cNaG2t8yXbUsP4+Vo4Bu4u4vUwkFyto5H3rf0iR20p3p/XRgoEC
	IZbFUWf2RSUzWeDt9wpXNuHmMt8UbDWlt8wzl/Tm8S46pqf88XUWVz5szAP0SlNG
	yKOwHvj0fzUc4x9YABKxEG0RskNlL2ZK6bINcxB7VXhEcsz0RrjWkphS0yzraleN
	ERiBOER4jwJVfOBq13ulw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777316861; x=1777403261; bh=A
	zbGCUm3YFq1wq38o61VKT3Tb9C0tpMWN3YVNE23p+8=; b=soLJBXcraaWBks/U1
	gDunkT4kYkQ1pyVBlnHAF36bbOOk64kF0FJM3gd7RgzKEaUyUamThUb6F6plv5Zy
	nIAHX6VvWDhkAdhl/Qrsh5wYgtyB7BsExlRdYLQtNrRBm9H4lObGXxMRCoYD0HSu
	kHgsB8/YR2xjsYgEeJxgrPhruVwnuiFTLmGdrlwejcrBUC9OF05SovuB5XttvHYa
	GBeo0Vq0/63Tu+/RTqOYp+Z/FkoyHvQvvzM7Fa9Kj+YpqTkumnkb/yxFsiLuJgxH
	M072e8ejgrx5RzIRN3cX7U8S8OrCt7aJrmTcSLHf2z1gW+23yA4+GQV2dZGkaSiX
	DNRMQ==
X-ME-Sender: <xms:_bPvaa3dc4o4d-9F7WuQJomrF3XBGUEg19pSYIWuZrpX9MMn8Al3K5c>
    <xme:_bPvaUjIzB8l0BrfQqVhiQ4nuPdnzBawxGsl9I6HPOprwM9w045jRlH5pQD0TH2YE
    vPhKWC-3coBGYX_Y_z7XSAMGtfysauYlFJRVJBZGcRwuIvuSvgR>
X-ME-Received: <xmr:_bPvaQT__8w3CxH52SUN_YPBe-gtLIgzkxyfOjiXdv4Vpsid1BkhIbeThmKejbCYp6gojtQzTmO_nqynsulnyjWWxOVlz_0Z1s_0I75i0Wf-9q1-U_-1Lms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejleeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdev
    hefhveffuefftdehiedtfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrh
    gvvgdrfhhr
X-ME-Proxy: <xmx:_bPvaViwl8Ci6h8_SAY2VGjRITvKmDgPXS3yzgmq_3JACVswv3CBLw>
    <xmx:_bPvaQ6hhpS0K8LUEghhAZTAG-mrppYTO0kdbLSlKG6hDu8zTbSjOQ>
    <xmx:_bPvaSCoftm371RBo66V_W1xJSWc-dmLlbi2PpZ3UlDCMO2njQ5A7Q>
    <xmx:_bPvaXZfTZGNDcClt7jJkuidB07XpPy8utrDkpySYasD5iG_9QzvyQ>
    <xmx:_bPvaaK_AHdlfUme7u4VegBDRqcN_h1XEYnnwXImFw5JnGsHvABjJcKM>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 15:07:40 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 2/2] doc: log: use the same delimiter in description list
Date: Mon, 27 Apr 2026 21:06:50 +0200
Message-ID: <do_not_nest_description_list.628@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_log_--decorate_list.626@msgid.xyz>
References: <CV_doc_log_--decorate_list.626@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

We must use the same delimiter since this is a meant to be a flat
list. Introducing a new legal delimiter like `::` makes an inner
description list:

    ...
    full
    the full ref name ...

        auto
        if the output ...

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-log.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-log.adoc b/Documentation/git-log.adoc
index 1c95499060d..fb3ac112839 100644
--- a/Documentation/git-log.adoc
+++ b/Documentation/git-log.adoc
@@ -40,7 +40,7 @@ OPTIONS
 `short`;; the ref name prefixes `refs/heads/`, `refs/tags/` and
 	`refs/remotes/` are not printed.
 `full`;; the full ref name (including prefix) is printed.
-`auto`:: if the output is going to a terminal, the ref names
+`auto`;; if the output is going to a terminal, the ref names
 	are shown as if `short` were given, otherwise no ref names are
 	shown.
 --
-- 
2.54.0.13.g9c7419e39f8

