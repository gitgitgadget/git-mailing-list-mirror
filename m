Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DFC20966A
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088507; cv=none; b=HCGG9eibz/Np/BjOJQVaZvySzwgIGN2NNfiXsYogef94KCT0i9MWG6siagB631bi13NoE4Q5DBudAATc52wOQiKp+lqT9y2gZrr48qttn4aDNzEN0uWMwj9lfdFHbJnO202rPnRFUShHTCIvVqvyRKkt8p0Mr2IZn3I3OMQR+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088507; c=relaxed/simple;
	bh=QyLxh9+HLCDv1dOZiyI3fsA7uow5pkRLgml+yq010Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oEy2o69C9NFpT6NRZvKxkNIZbegDqYkCR4TkZtqSKVRni+cRVk/Poq4Ry8KmBPyOR1ZHnCgupQ8Tg30XXn+ZhDWJfSznl4HnmLIb8JSE1x6mUlsdrrtj+7pF3RpHtyJx7uvPHM2EOzwGANkVAwoUk/zJts1BP69zKdJk2oxjWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=COJH0pRL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C92PCWqc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="COJH0pRL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C92PCWqc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 06FA613801AB;
	Wed, 16 Oct 2024 10:21:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 16 Oct 2024 10:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1729088504; x=1729174904; bh=WFWu2vkBZYx/tyKfVpyMxJ6Lbq4LQRJ7
	B56H/AjKZ9k=; b=COJH0pRLBTzKdnRtSv+PW+yI+t2uTUybCYxONF8Wpmg9iEIZ
	k2fjAlDX1MZXm0JbFpm1t+1Z51my0lFFWbSYzw5pQ9IgPBxhaC5UN3C7/xaonHX+
	SMrLRqqdZBQIY379gKGIWp3jD7fCOkJvnJHXYP7jE12wLXOHDp7LU4RVY9KfEOj+
	xVayaTio+HJ5XvXnyUoSkTo8U7UF4c2ZioazTGiXU2gJxdTMRqeOh+vGocKBthiR
	PJmfCUPNab2rJaqy6z14upc5jX3FIpSONIFbqM7a9LDe54vms3p2djMm0gS2OIyB
	jJNr2oi/nzkJYmtjcIHy03zHXi415kSKvrdS3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1729088504; x=1729174904; bh=WFWu2vkBZYx/tyKfVpyMxJ6Lbq4LQRJ7B56
	H/AjKZ9k=; b=C92PCWqciZ4XA8ToYBouAeFPThCIIGWCnxtXBWXO9dccIQ/8ETf
	bUbnaLn6Kvmd6Opsrq6CbjdSzQmpOgbP2d36xAcEg0asz5/8R9XJ3SnTRxg3o5fS
	zMSjCSzkPKWOJ+wCBI3DIpKihCfow38EMuGI56zubDm3x93nZeiMpAL58Ye3S5bW
	66XcI4jdMq57BKSZFUVpBS77koVZ2QaJ0h71FyDzUAMyhQ+69diajjm78fV89VsB
	vxoVE0FV5LAY+kYcLCavMoVMX4MvIQdaMHfb9iUtr0EhQ7QOYQ1dsaHA8NpOsvzi
	uv1UOaohfZsYxaushkPqzHGosjlxlj0bZbg==
X-ME-Sender: <xms:98sPZ0P1nBTWCfLXPx59oy1nU8gBnZiGI3NStaSmfhqLX0uiatfyyA>
    <xme:98sPZ6-76EboyAhASCJ3gu7_YBsdJPrMZAxkFJpQWpeIH1WA5804lPeKlmhYe1ydr
    6eWF5yyz0sbBGQrMw>
X-ME-Received: <xmr:98sPZ7R7awgIcf4sAp5mkN-Cju-K17zDX8wxr5_wDlQv2wxcsdGqhSd2hxg3TsvYIvHa1yb2VcCT-8iqIcQDgDpxS3QibnxCJESit9RkWg4LJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepjeeggfekffeuffevkedvgeelkedufeehtdeijeefgfffffdu
    iedvveeuueethfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegruggrmhesughinhifohhoughivgdrohhrgh
X-ME-Proxy: <xmx:98sPZ8vPuo1yiXNws1He6rc4fU2vh0PBivHwrq83TBWmIn1uJZKSVg>
    <xmx:98sPZ8efogR7UVHVBbzoQWRmKn8FRuO6ZpA-FfNcpXvgE6W1o7iibw>
    <xmx:98sPZw1uJXNb3bwIcMD5bCby3AAdpBKsnthkYFumfOgOMLSrED3afg>
    <xmx:98sPZw8badTZW2oh6heD00_EgeueGvbigMOPxJYx9Er3s_LgcuZ9xw>
    <xmx:98sPZ06otve1noA8LHWbwVn-MDZd3qpOSrQk6AQ1S9ukVHeL9pJU2IOb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 10:21:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe6579c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 14:20:21 +0000 (UTC)
Date: Wed, 16 Oct 2024 16:21:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>
Subject: [PATCH] builtin/credential-cache--daemon: fix error when "exit"ing
 on Cygwin
Message-ID: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Clients can signal the git-credential-cache(1) daemon that it is
supposed to exit by sending it an "exit" command. The details around
how exactly the daemon exits seem to be rather intricate as spelt out by
a comment surrounding our call to exit(3p), as we need to be mindful
around closing the client streams before we signal the client.

The logic is broken on Cygwin though: when a client asks the daemon to
exit, they won't see the EOF and will instead get an error message:

  fatal: read error from cache daemon: Software caused connection abort

This issue is known in Cygwin, see for example [1], but the exact root
cause is not known.

As it turns out, we can avoid the issue by explicitly closing the client
streams via fclose(3p). I'm not sure at all where the claimed atexit(3p)
handler mentioned in the comment is supposed to live, but from all I can
see we do not have any installed that would close the sockets for us. So
this leaves me with a bit of a sour taste overall.

That being said, I couldn't spot anything obviously wrong with closing
the streams ourselves, and it does fix the issue on Cygwin without any
regressions on other platforms as far as I can see. So let's go for this
fix, even though I cannot properly explain it.

[1]: https://github.com/cygporter/git/issues/51

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

I've Cc'd Adam, who is the maintainer of the Git package in Cygwin, as
well as Peff, who is the original author of the below comment. I'd be
really happy if one of you could enlighten me here :)

Patrick

 builtin/credential-cache--daemon.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index bc22f5c6d24..5a09df5c167 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -156,13 +156,11 @@ static void serve_one_client(FILE *in, FILE *out)
 	}
 	else if (!strcmp(action.buf, "exit")) {
 		/*
-		 * It's important that we clean up our socket first, and then
-		 * signal the client only once we have finished the cleanup.
-		 * Calling exit() directly does this, because we clean up in
-		 * our atexit() handler, and then signal the client when our
-		 * process actually ends, which closes the socket and gives
-		 * them EOF.
+		 * We must close our file handles before we exit such that the
+		 * client will receive an EOF.
 		 */
+		fclose(in);
+		fclose(out);
 		exit(0);
 	}
 	else if (!strcmp(action.buf, "erase"))
-- 
2.47.0.72.gef8ce8f3d4.dirty

