Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85929222570
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734717741; cv=none; b=dLgQXGyBISvt+xNmDmdRHxVbnwdTxa7oLkNr/QB5DcT9ipQxD7V8EZVVJ+7YxI7q7TCEL7Byc42XSGGkOSs6Jp/35QPATBBZ8hReRD3+vpx8NQU43QEK2RvPAjDR05LO4y55lCCrk9Qenjgdn/de4ToGcXSnDj7D0ARc9yfpQ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734717741; c=relaxed/simple;
	bh=tBriLOuVjR1osW9Mx+d+2/7nmSGBXHokG7jij7v+UdY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DL0MdEbBuQMUiqbyGv7cY9iJvxAFUA8ATSJHb4v7WnezgcTpoJd3v+Snc2bUAgPwPyvW2or4MRkLiCHstoj0w2U6li8mUmtVgf9c320SnotGfICZ7Veo8O3e/897X7vtAOwNOOAAkf1Y20P2cX2lrTZht7a0gbkbLyM57TURenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bT4bZwC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3QMZKMl; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bT4bZwC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3QMZKMl"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E54C254012C;
	Fri, 20 Dec 2024 13:02:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 20 Dec 2024 13:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1734717737; x=1734804137; bh=947QTuSGF0J7eBf4Umef/ZtwCTA1k3Ci
	EFc/Z96jepA=; b=bT4bZwC2n9CmptG0GSL9Zv1ED2HkNP9bj/x58VqHW0EwF/r0
	Nh9gN4952enUnBAtna+dJpMh1Y9U9AdRIlxMi6lwhDq1qcwTCpQ0+Z43oENvV9k6
	EKFeqwL/LaSIlL2pVWQ4tBwS9g/84I7tXFkh7krEzuUFdvcm6tzipKpYaaaNm31k
	o3b5K093K3OF+eW2lwoHN6xbsAxCOIVuewwHSXwkPHJIYj9ze8U/MvmdrLuDFIQ3
	KaZu8ASkLS4AeZZHEvEE+UD62ysNJVtjWSXrwu05kZvGjOdVgumrNL6VWLf/EqwT
	5mjuhcoAxUBDNv0unp3Zl0K2yO6lU+cbYapvfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734717737; x=
	1734804137; bh=947QTuSGF0J7eBf4Umef/ZtwCTA1k3CiEFc/Z96jepA=; b=q
	3QMZKMlxpE/bBtNSCpmSuHeVbF8SrrgUC5Tb8Dd8IyZ/MNoROFt7lzc1AWNL/2X8
	QmWL2IDXrbRKDq0oI4wxo1J6jbNkfT4nPdFqbMZy6fuf7j6M5vtXeQMotnOJSH9+
	KXzT1wRsQd96liIbq16/RV3xQuesyXvzoK73lvKAOuNL1f7MVk1Wg9UMt6zeZ2pQ
	5lb7hB5Iba5CyZP02KzQXxtERLBV1oBun7y7fvA32DqkJtBwXVkJf7p69fwWCSSr
	v0OCzSiiUCA8PZwB5STmBwocryqolIDlIWJPUvAjIRabghtaDTfgNhKT3ysT1w7H
	erQhGr3mXSmKI/HBISAHw==
X-ME-Sender: <xms:KbFlZwl59itUu33yHBUQ4HZogrUEONzfytPY_FnZcV4UISksuU2NFg>
    <xme:KbFlZ_268dJbRcxYaR3u1FOCEtXK7D6UT94459R5jHY6yseKb2x0_FE9OS1pXrgdV
    JMcoHjGr4O81b7BGA>
X-ME-Received: <xmr:KbFlZ-pDiL1nbNjZW8V_rTXhg3_GSqCfgJri-CSVxc_TV1S8IKDAnZ-ZV9cAP72Xwz2ekIujDmk-LB-m4rRS23uD9wu0k1ZzCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcu
    oehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetledvhe
    ejtdefuedvveejudeujeetheeftedtudekjeefledvkeeukeeiteegvdenucffohhmrghi
    nhepshhhohifqdhinhguvgigrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:KbFlZ8mSpOzibCa12rzdjUDLNmaCSzznmrHamcds80YZMy6-eV1rLQ>
    <xmx:KbFlZ-3ZgnkHYt4_5OBb9WwKgpFFyohNYa7ndBls33KylQMziHnuAg>
    <xmx:KbFlZztU5DlIgMf1jEf3WtDbdU3m6hMwJnDFjjRarrUxCPFI87YDVA>
    <xmx:KbFlZ6Vw5gwZdf29ijxggRGrfa2sU6O_djieYHHz8leZw9-ITZyHTQ>
    <xmx:KbFlZ8BXRF56XFQQKpt2STRfZ6X5-AD7Djhr1d83Kx9azB_tpGaHcK-0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 13:02:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] show-index: the short help should say the command reads
 from its input
Date: Fri, 20 Dec 2024 10:02:15 -0800
Message-ID: <xmqqfrmidyhk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The short help text given by "git show-index -h" says

    $ git show-index -h
    usage: git show-index [--object-format=<hash-algorithm>]

        --[no-]object-format <hash-algorithm>
                              specify the hash algorithm to use


The command takes a pack .idx file from its standard input.  The
user has to _know_ this, as there is no indication from this output.

Give a hint that the data to work on is fed from its standard input.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I also found the option description somewhat funny in that

   (1) it makes it look like "--no-object-format sha256" is
   accepted, which is not a case, and

   (2) "git show-index --no-object-format" already is a curious
   thing to say; the command certainly needs to work in _some_
   format.

   But (2) is common to all the usual command line options to allow
   defeating another instance of the same option that is given
   positively previously on the command line (i.e. "git show-index
   --object-format=sha256 --no-object-format" should behave as if no
   object-format option was given), and (1) is shared by all the
   other options that allow such override.  So I'll let it pass, but
   if we really wanted to improve it, the fix should go into how the
   parse-options subsystem works.

 builtin/show-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/show-index.c w/builtin/show-index.c
index f164c01bbe..8678b741a4 100644
--- c/builtin/show-index.c
+++ w/builtin/show-index.c
@@ -7,7 +7,7 @@
 #include "parse-options.h"
 
 static const char *const show_index_usage[] = {
-	"git show-index [--object-format=<hash-algorithm>]",
+	"git show-index [--object-format=<hash-algorithm>] < <pack-idx-file>",
 	NULL
 };
 




