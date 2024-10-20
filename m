Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C317591
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451728; cv=none; b=YIHl/o+GeYClELqtMdROqaleShdq682FZJHcAD3HjI1mDKshq9yilT8Em6vczybzCyr6B5aTpJphSU/KHDo/SeC02x1yx65qmY+fycJ7foBNocyNwrPVvEr/rKbTJaYn4HkrThPaQ+blcQzbkzu0n6JCPa/kE5hsaqfurhXqbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451728; c=relaxed/simple;
	bh=W0HRXv75Olog3VcXT5uniHF+hbeL7hD+14dbXjuZhPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJTGriJaRWEd4zDeEtLexNvJEWKxLCZnQ47GQka5cXqp7gpR/Ck3GGjJePm5HPeuAj7sAvTdMG3IP9Yw22dLuAVNfs3ICuWNLLLzfVmIR8fyTF8z1HBtR4S+Z8BIZYljvkwv7nEub9eMzgIL2+KTQrG2CGAE0OD+DRCusR9SbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mK69vg2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LsNFvR6t; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mK69vg2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LsNFvR6t"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id A77691380044;
	Sun, 20 Oct 2024 15:15:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 20 Oct 2024 15:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729451725;
	 x=1729538125; bh=BCivB4Ny1UqIOLClQxgJJ5Kno0E0mrZTkUeFe5tQRc8=; b=
	mK69vg2aC+HzIp7a+2j4HlcC4FqW8DDZUv7nECQ60V46c9wC7fXA9U2UJlAAoaf2
	YTkzUPIgPdn5+2Lly83lRCCMstDOAxfV//anBc3ZRtBCrb7Y0zZYxazt0E6p+/xD
	w0433tza/4wJDP8sEUDAzr2sLa3rccTR1n5HkVP9mYZ1jUMKfaRzSDgBGzVEPsbG
	YIqjr7wn6+DJjpx4pp/sE+ppUB1wxKMFyhO+1BvbSRipknGUZQqJDc9DMJ3INU06
	hz9nGtWYHw2T1Y+bgxRxsuS6Y9og5rQGCGmlwWsHnwHZyR4w41zfqtlTTG1pFT0F
	X2OfbbF6yfWku606442Ujg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729451725; x=
	1729538125; bh=BCivB4Ny1UqIOLClQxgJJ5Kno0E0mrZTkUeFe5tQRc8=; b=L
	sNFvR6t3HP473RbVkouf7IYzlIaD6DQhaCbgdOO4L9src69Fl6LFqkp36mihA7Cw
	MabefIMTXyCVWQspkIQ9Hx5dvw3qvwqky2qgUJIk9Ore/jfbsVAHugNSpq6kQg6n
	GN49mxp93u76SHWFhghqBT/AvSrAqKlUA1DKjW+F1qi6gmt+lHo11WJRouvHGudw
	5A+SxSzyWH6TSmOok3z+PiJ5i3YJj/bQgcgQIspRKl5ldSgXJp5VC8FqgWZZM9Ln
	uPKcn1TSCgSF69hg6uGYN8ubwQGe/GukVZntOe0QcERFqsInrOI1cqnjYvEOpNgP
	gGjfvx+Y7su5OmZxwyCEg==
X-ME-Sender: <xms:zVYVZ_bCZznpfaGqqWSscZBlMafPfm8kAt1mFp8IV1M_9mgpO9MfKKU>
    <xme:zVYVZ-YiFQEefqSmEl4RlDKndXzFDJ63UyER1bBIzt13mJUIN3P8yQYunxPLHZb2i
    4G2ZEAR28S0mHV6fQ>
X-ME-Received: <xmr:zVYVZx_YwgqEqyp1Xz6vsiC0wnepmgswi05IvDP6ysoXeFKGXnPtw1KafQ81cK6IWicf5do7kRUBqv6zZ4CEU0gh30BmBP1zwNOco1Dcdsf0S9KW9SA3Vy5z8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zVYVZ1pLmQbnzioINCyrDDD_TGkcZOf23VCdDv6Rtsmm-sAJhw0AuQ>
    <xmx:zVYVZ6q1M0hsbvpRlhScmX6lWlMroW0YG7flnd42jTJ6Hbww9PtlWQ>
    <xmx:zVYVZ7Sx2ZiIAlZng1XUrA3AxFCLF4f3MHyRA6n_scBdg5NfNLZurQ>
    <xmx:zVYVZyrz5QYm_q7UFzIViXZtJ-nitkOAQqyRnfBdWZdWPkpebZzOvg>
    <xmx:zVYVZ9UZG0pIcgw036tuYuU6TuzTkpYgECzh8DOZscYixfR0Z21HYmaB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 20 Oct 2024 15:15:24 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: [PATCH 1/4] Documentation/git-bundle.txt: mention --all in Synopsis
Date: Sun, 20 Oct 2024 21:14:59 +0200
Message-ID: <39bdc5941c7b53c432966984fa79b81fde978e86.1729451376.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729451376.git.code@khaugsbakk.name>
References: <cover.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 39bdc5941c7b53c432966984fa79b81fde978e86
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

`--all` is convenient for bundling all refs.  But it is only mentioned
once, halfway through the doc, under the demure section “Object
prerequisites”.  It deserves to be mentioned as an alternative to
`<git-rev-list-args>`.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Long line in bundle.c now?

 Documentation/git-bundle.txt | 2 +-
 builtin/bundle.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3ab42a19cae..7579dd309ac 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git bundle' create [-q | --quiet | --progress]
-		    [--version=<version>] <file> <git-rev-list-args>
+		    [--version=<version>] <file> (<git-rev-list-args> | --all)
 'git bundle' verify [-q | --quiet] <file>
 'git bundle' list-heads <file> [<refname>...]
 'git bundle' unbundle [--progress] <file> [<refname>...]
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 127518c2a8d..6d610253575 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -17,7 +17,7 @@
 
 #define BUILTIN_BUNDLE_CREATE_USAGE \
 	N_("git bundle create [-q | --quiet | --progress]\n" \
-	   "                  [--version=<version>] <file> <git-rev-list-args>")
+	   "                  [--version=<version>] <file> (<git-rev-list-args> | --all)")
 #define BUILTIN_BUNDLE_VERIFY_USAGE \
 	N_("git bundle verify [-q | --quiet] <file>")
 #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
-- 
2.46.1.641.g54e7913fcb6

