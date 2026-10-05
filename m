Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4A47F3B6
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222053; cv=none; b=Ak1POocfjqpMMVwYDREO/NgdJLQGyqrKDnkUmT7yEk7cbr/xVlFXMUpKhXLAKbO/xuo2nSw6pp2eGXQIuSD+ixBJW37eMHKs/swFgQRtPyS3fdvqno0KpN93YaNTf2YGxxnD6Jdp1ltWfU3BCLzY65YNxa67Tri4I02gL9GaLCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222053; c=relaxed/simple;
	bh=8bH6mtB+CtvkuOwW250HACHDFPXchaNGg0QeUtAfWdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSxTyDuw5JTlOe8xN6wCbBPK57F3vtm6zd+VL+4jh9R/flF9kCRfv8QAQsom5y28y8c/lNXGOK0Oaw54XTk0w7NjlrBOGcjBgV3S3Li1Tl9ApYrsWSGCeVlp3dWyyG+Vq0+W2iX+01ZR5NZv3wjdqmxb6epVzYgS/BbKiepPSdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qZjB+pgm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UD3zCDNx; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qZjB+pgm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UD3zCDNx"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id A39671300922
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 13:40:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 05 Oct 2026 13:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1791222050; x=
	1791225650; bh=KWP1d0CHLAdq3BDE7C4xxl+0UoLZmOcraiZuJrFK1vE=; b=q
	ZjB+pgmOGbA0CCIb8tV2EOFn759YpXdwSgqYjOxO3G1yfdG2K2PUIggQ5O/fhgiS
	eI4nwUitXuAUTUnYOIZGZlFXszdJogAtENhsvbxKhYdQhklXrwArBr6P80sgqIx7
	3/YhDy7MjhOPg7QEVI33VWZ5RWmfbOA00KF2BnxYI4Bd+PeMt+RhZ/lzDxhOK1bD
	5OPcX1aWFSW4t+17C/mh7WirCjXdoG9kq4jJ1Kh3fDZIIhOtbF83lahfHjBnonE5
	eAd4LaoIGw1VullUY/T8Rf630wG+pfQwlUVfBQf+wu79koDggZdNzM628S1gkGsO
	oKK3JV4ShoL2VksujoSUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791222050; x=1791225650; bh=K
	WP1d0CHLAdq3BDE7C4xxl+0UoLZmOcraiZuJrFK1vE=; b=UD3zCDNxNQR2/bS9H
	hmenGhuoP9KQAGOHh8LzSnGF2CqDTloOoIWJBYQ6+Ff+OPmtIxvT1DWOpnzSoiC0
	XzGvGnJo15dwQc0N4TV3J3XSVAc+O+Q3vm9q7g6EwIkKncjpcN0gHr46tN1sliGJ
	+cIDRZzYjk6ZY/uqhC4sfYprxNPKfiEooSjKCtv+VfoEhCpug4i9EOUgmI2v9R1V
	+cE3UST0eoxg7yGz9367zaEtKOiCgGMIR6m3d8OK8BRdaJ+cgwD4ALQSGBD0YBmu
	/TwcxuUoG7IoP7gHihoMwWrje6c7k5tbLiDwAMVoijOLGZNXK6m8sIY+/Sv5WwpI
	rYajg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791222050; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:RtHKaj9MQzahcgtud/qkwE0IwbNFHUDBPIJPZi1hA5u5/ww
	X/4tA+yQ6RoFyYY4OHvoMSTUImTfm6HfXRolIH2vjeD8mibyx3uuORzNAG1AwJM0
	ZZFNCmSQ1kaj7NLrlRvGx36SjB9Inbz1gN6aSutDb4zls/XVGIBpm0EzW/2l9VXh
	ZCiV4bT5VBHWUdelflELuRLwM0YrFkq7jDKd/dOVjtkO+ESXS7YkjR2S6lmpQfsW
	5D6ZOWUYIQ9kkhk4LLWbrq+RC5aIMADH6hDN2olJvsyzQBi0seXnWTEx72wHHA7a
	4l9ratIwRMVKcQk58m15VYQWR/XIW0QRbWj9+9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2vJxtMEXXnI5XlUpKnfayFfmQed+ozchnI5oxZudI3k=:8bH6mtB+CtvkuOwW250HACHDFPXchaNGg0QeUtAfWdM=;
X-ME-Sender: <xms:IuHDagz-U8r-Rqpm_-dzeWVrH5Fc0PEZlX7sUuzcjYezdx3-RZvWoA>
    <xme:IuHDarSzQJoIIYFKoIyaloE0N57rWNB6n7-biVoL9YftqI7XtnrIXB1dZ18RahqRy
    KBbiquMQIbyd5io8RlA2EF1EttONk1-hvK1WKlM3N8NzIWPvQlQJuAe>
X-ME-Received: <xmr:IuHDanVJ2v6pZWaU22tBsRnhswNI0KNzIljp3-DxNJ3O4NOqpZG_VyeIpRxvvr1X9gbuf6zh20BDduSDc_nYa7iOHjx-XZxKDp7Fia0IJ9Rdey4_QDgRRZHSrSKilUAblSHsBB__VpGvX3B4Vzij>
X-ME-Proxy-Cause: dmFkZTFgT4h9e38redA35qat/9rSF0gSQgkcMwuFif5Hw7VNMOKdUVsaaCTz4YT6KWZSK3
    o7iWklL06JhQ4OKagh8dgeRV41kveiThJjXLoRK3ZIi1v3906Z07MsC9Uu6MgFMR92Gv/U
    SY1qHg89Bgqtxh1WoF1IQyReBikb2u47F9egBgEcqFmPghusoLFtUFT7YgGp5m0doMzo5D
    a6nakdGBFV30+fTp3sxERyhzQERXUyN8CNyCZYdcSTnepkQxq3N5/Tfm+3Bq5ziJtEwWD5
    ZtVLrnSRZTqkn11pnzGblTZDr3KD/GGuYcNqaBiPjpnrCa4rRFu5+EDraacCc8w1rXhGIT
    UnGwZalAUajSYUqyAdg7V0EybSaD1kw+9H7eLPDWOsfpMN+z6Zb/T50v+9fAQ66EBX2rk/
    pdn1C9tQ4YKS685F7ckmgL0lBOSgAWj+/TF8+auRYgwaGRy7Uh4cY6L/0J4reMfIBc+QGD
    amcDOmqjp70dLIuTjwxM1sGUBQodiAQ4oJ/k/txggdO12ceR+KEOQkKJYyTmqH6OTNYzmF
    S9ukaOXkrxJ1hbsMhYbxkweWY2FszE8c+6VqZMoJPn08nki0v0Z+7Tg0mvzV4hyAp54VJl
    cAoBCOcSnyf7FHvuSXt64ilRygPQ2E00ir0k5DPKnaSQnueDqSjd3Cf54zgg
X-ME-Proxy: <xmx:IuHDatZy7KfLxSUymmorX2DlZ3mBC-AfzxU7NIjGTj9_w6sQPluomQ>
    <xmx:IuHDat1eYg29a1KQc1Q2cyGz3SJEVYll-yuo2nXmCOsucipUUb4YPg>
    <xmx:IuHDavg_b3ydoqhuV-cCLd5cN6jqzH4ng7eQXjXOgUYT4FfdM6OIEQ>
    <xmx:IuHDahYgYn9geru-8KLVhaSN8WniCse_W4M6vRBq65J9oTr4KWdKZQ>
    <xmx:IuHDahorJN8PEUI8SSVogVbfYZBoMndxXhnX0T2Zy-MU6kXhvSZwsUtM>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 13:40:50 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	ps@pks.im,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v2 0/1] repo: add filtering options to "repo structure" 
Date: Mon,  5 Oct 2026 13:40:43 -0400
Message-ID: <20261005174045.1900391-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924164503.119506-2-markchucarroll@fastmail.com>
References: <20260924164503.119506-2-markchucarroll@fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git repo structure" provides a collection of useful information
about the information stored in a repo. In particular, it's
valuable for diagnosing performance issues caused by large objects
stored in a repo.

The current implementation of "git repo stucture" provides summary
information about everything in the repository - all of the
branches, remotes, tags, stashes, and notes. But sometimes
to properly diagnose a problem, it's useful to be able to
get information about the specific part of the repo that's
exhibiting a problem.

Add the option to specify a set of filters in the form
of a list of include and exclude queries. Each of these
specifies a commit or ref or range. The set of objects processed
will consist of all objects reachable from any of the
includes which are _not_ reached exclusively by paths
including any of the excludes.

Updates since v1: this change has been completely rewritten. The
original version implemented filters the same way as
"git-sizer", by selecting object types to include or exclude.
This version drops he type-based filters in favor of
specifying object traversal roots and exclusions.

Mark C. Chu-Carroll (1):
  repo: add filtering options to "repo structure"

 Documentation/git-repo.adoc | 41 ++++++++++++++++--
 builtin/repo.c              | 16 +++++--
 t/t1901-repo-structure.sh   | 84 +++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+), 8 deletions(-)

-- 
2.53.0

