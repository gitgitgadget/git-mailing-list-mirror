Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184A22139B1
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380828; cv=none; b=NZu3JjdGJqRGj3VTnsZK7XPH1s1un0acYNEgzE4d0KCH2u0Xkst7U/aY+Q2iV0B7c6utEaeTs1BXUDfWAgUeAmow1khS8TL7MRLfNQ1gC+j2ZlpJz0mJn2UoQxq+OJusouu+2Yp4uuJ/i5vkWoxrHz24tWyKvbWWjJmcUrgBQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380828; c=relaxed/simple;
	bh=5IM3WLPF2qGWXEsQfWq5UPrAotQAAjL5z/ucMhDf2w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEEdIvXeP15CY53Szs08Qz9hfXlEia/Yiigh+HJVsNSBhtxRIkCSC+TSIPWSK6gW93yeWlEh30ALtJU7fumvfnggYBE168+IJ2tK2FynmD608jMwrgmYpLAOQBSdp2MYv2fyuJBHMWn/TLnva2Mjul+xPeHMwjbgJOKzmm26mdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TxzS3dx+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gTiC90+U; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TxzS3dx+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gTiC90+U"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1C45D254016F;
	Tue, 27 May 2025 17:20:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 17:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380825;
	 x=1748467225; bh=+nvJ8OQPZb7Qi4+74+KXuGDmvGhFNmEXEy6XDffgPag=; b=
	TxzS3dx+/IKcTV6NkNFv02zCJd+Q1LvRFP9P1MY8h/dTHEytPKreChaozYTFZUzp
	94ZbRPidAeU1UpktLce/KyXTeXcUkdPo6ryQkxuP0PKUTpQnxMEOHmi3Fac8KuNq
	N6z+C1OAUvjNpdm3h9uELLZ3JwkafGt0tLbhLaBkMX7ZoEMGkHTOgfvu5jL8/7vR
	fBH6uZMpO8KD373zcJ84zl2j8G8Umpp9vo8UHXJBgvhbS7bJBrzEyeSkz7wFsoYQ
	qzk8ZPq8dYgftdanhM5BNbgeEcFC7u2CPkJv27u3bVvq/UFRjtHIqCX4Kb1SIIZN
	YRj+ziq99UpRv5olDjqFXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380825; x=
	1748467225; bh=+nvJ8OQPZb7Qi4+74+KXuGDmvGhFNmEXEy6XDffgPag=; b=g
	TiC90+UcJPH0cdYVxQzxlqozdGepWDNDk4IcvA7bq5vFGtBguk01zVfjhP2iCzYa
	imY87JjZsLLUQHaeLpnNHMOxbOWndHCs8ISRkTIpixa7zREc2I6/Seaab5JA7QXm
	alNVjg8ISPckdx5nRZU5uAzOPxCdaP7Aa6HtHlpqIwT2wrBCDd9ZFLNfBU8mU54g
	sgnjz4lGG9uZaSWeVymJx8Vi+s/54nTjhoq4jtCCCqKT8UZlYuzNwttJ6dkG1/RY
	NvmT/UYTwugwb5palrRzk3+0V9WRoEkwwNW8s/pLzq8G4RgEPTYmVh7wvmupRW5+
	9rh6iACUdyCNSF94Q4/TQ==
X-ME-Sender: <xms:mSw2aGMcbKUqpwkFP5pC6c_0PqfFeFv84DNUJkgXhyCYwWJTnAJIMfU>
    <xme:mSw2aE8kw90fX01-6EpcvOKu0KS1nPDj6gXA9Y4vn7fwTNpo5OqoIpsF_VhG5841d
    g3jnWA86ZL36axECg>
X-ME-Received: <xmr:mSw2aNTH6bAIN_7JCK-hgC8ggOni2sq-FLYVxFTHL_H-VI0i0Lxa0VGKlN-iZQlIeb6gFX-2CXsBp0MJ3KTxXF8Wo8jSUwvj0WrT8C42YspIlEADNk3oGMQBRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeu
    teekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mSw2aGv5ZbFUY2LE7WLWv_FBwvVww89AloqghMkSAuGPyp2clcEK-A>
    <xmx:mSw2aOcYaRti5o98tveEDefG87n7nfXN8dUjHjoXA7fynLVxZR2Vdg>
    <xmx:mSw2aK3A-d9_V2TAGPXc-CaJOGNtTstmYz_vsnFhq9nmJkc2Z4gBmA>
    <xmx:mSw2aC8JjNjxrkQXwbjrge5IeL6tgol5Q4srElHJCy8EVemsG7MzcA>
    <xmx:mSw2aAo2yweN1Cv-OnqHK0Ny2J6BVOnC-mAe5H_EQe3OgmEbTkjyMWSI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:20:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 8/9] doc: notes: treat --stdin equally between copy/remove
Date: Tue, 27 May 2025 23:19:37 +0200
Message-ID: <530dd953170e14ff02dfb6c84b1188745a8b1501.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748380390.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name> <cover.1748380390.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

46538012d94 (notes remove: --stdin reads from the standard input,
2011-05-18) added `--stdin` for the `remove` subcommand, documenting it
in the “Options” section.  But `copy --stdin` was added before that, in
160baa0d9cb (notes: implement 'git notes copy --stdin', 2010-03-12).

Treat this option equally between the two subcommands:

• remove: mention `--stdin` on the subcommand as well, like for `copy`
• copy: mention it as well under the option documentation

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • Rephrase to “Only valid for”
    
      Link: https://lore.kernel.org/git/xmqqecwfvwdu.fsf@gitster.g/
    v2:
    • On --stdin: just refer to the respective subcommands and stop there.
      As suggested.
    
      Link: https://lore.kernel.org/git/xmqq34czhyz8.fsf@gitster.g/

 Documentation/git-notes.adoc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 9ce71ec3455..397f6caa92a 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -127,6 +127,10 @@ When done, the user can either finalize the merge with
 	giving zero or one object from the command line, this is
 	equivalent to specifying an empty note message to
 	the `edit` subcommand.
++
+In `--stdin` mode, also remove the object names given on standard
+input. In other words, `--stdin` can be combined with object names from
+the command line.
 
 `prune`::
 	Remove all notes for non-existing/unreachable objects.
@@ -208,9 +212,7 @@ future.
 	object that does not have notes attached to it.
 
 `--stdin`::
-	Also read the object names to remove notes from the standard
-	input (there is no reason you cannot combine this with object
-	names from the command line).
+	Only valid for `remove` and `copy`. See the respective subcommands.
 
 `-n`::
 `--dry-run`::
-- 
2.49.0.780.g892193c3f50

