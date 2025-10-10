Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6862F6569
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760130845; cv=none; b=sXtVfc9RHdLrfFbMAXtHj1YV+J5debF48GGp9bmitwxmZwTH1xvhUjGL62Azj6mTBKolzSaKu7YxtepI3kp7fislFVYy1q4wZ+04vpVESxGgei6ERy9V9DL0Iqu4c+ftc61djOIno0ANekrQ8Rg5donmFVkX71Gd5adB5w/jgxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760130845; c=relaxed/simple;
	bh=blT61OFUpIcnw44WpDbRtOItlCAlKVdhjt6h5sgfpMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EpCLO58Ds5eEcmMBYmhImWNVR9L+blTDKDgNgwdQuAZpbp7S1kj8tHL2I359lN1Y5/B1La/nLabVJdcrXV/YAXWseriRRUB2gq2OLkMP2tVspxU4JY7KphNf2eSkwt7vugTfn/rysVkvSoJcBK1WWp7KH5twhSJsSHfQ1b6wCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UqEfsYxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RNbmtV3b; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UqEfsYxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNbmtV3b"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 8299A1D000A1;
	Fri, 10 Oct 2025 17:14:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 17:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1760130842; x=1760217242; bh=78leJJFePHsgImvwegmcgmQPKeY73V6P
	vkhc/R7Y9Ag=; b=UqEfsYxSI9oPSoouXBqedpiE3i9phQIO7RwYwUBAXvM/5Y3S
	I4B0neE210PFG32Wq7uh/BYiLNbvk4Lf5w7qi136eC/xYUuJEwdpBe9KTzVOJcC5
	NgfLtlyjdbfcOkKkHeDpKPQMuPO1yHiiHwMj1mpYYC6ix6o1luLqOdP9QSluYwZA
	qZJ02dmqqX/fPv5nHfa4Q0Pv8EhHdOLPwKXn/dE6MLUdbw+A2COvR0KoQzpi/mOr
	gnFhPn/vygR0BTREvqK7Sax+YA1iebNY9T8lq8NjlEdcvy+KtDRgV4V13V13D05o
	ACLgFXiUwPw9xLcdnSY+9hBZAM7hadUaeWoOlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760130842; x=
	1760217242; bh=78leJJFePHsgImvwegmcgmQPKeY73V6Pvkhc/R7Y9Ag=; b=R
	NbmtV3b7HFZNPqFetJ7smrOObnUpqoSmVuwGg5e0dMwVIZlT7ve60zb3jOuw30rG
	Neofr4ZOWPRZ9LjNiej6lvmGxy3JmQRXAG2b31w2Kf0r7GeaVKH3fpEgyv++5IFs
	Wf7jQsYa+qgyKD2S4qF3lnpKyVO/FDF7i+LxuaxA44PTgJVD5uDvfNQz1R82Ag/G
	/qIz+XO/ZdYoKz0wHHMRyVYi73Z6tHU18IF9erU99jfJYLRcyzlb8Qs6Far/BShy
	/3eYP8jjMO419ceJ0MkhkPyKOdJJMF6ysBZ+1S9ZRy3OSvc1521w7R6sV9KQ9ba4
	OCnJEEv5ql8dY9zhrFVXg==
X-ME-Sender: <xms:GnfpaB1hGBa2nNCZpy407meu0GZ_HAlxU0T93OLMfRteTHScvLEPqg>
    <xme:GnfpaO9Nihdi_2mWRnVrHCQ0_e7lRCxTZOyBuAaTB78hn0bBU-fkBMzW2m5IYVnCx
    aZMhZUAw1O0jnMgOQJIFC19yKXIq_YC0FbQE6fEwW75wG3F8ptPF7A>
X-ME-Received: <xmr:GnfpaKN7TgUlRCm7fI9QLS5OTKVW7z3BmNASgp39ZANVnw1idEXagx_4jzjJHZlc9ArivRHx9sc0RMCU_hd6fy0NzPbmVQvoGKE1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejhffgfedvkeeftdfhjeegffeiveeiie
    efgeeuiefhjeelueefffejteekffffjeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprh
    gtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlghhonhgvlhhlsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopeht
    mhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:GnfpaKdAZJ-zhlu4m025yEivoBP7OYH-vFhSvrPEHISfKkmNOO61BA>
    <xmx:GnfpaBVOz5DnpiLDVAX3bJ8StZ1Qe26YFmeYLakH9KJQECBRYUwxzw>
    <xmx:GnfpaKh2wx0AElWHl6TkYUrP4EDH1qJFqtSFKLnKw64uie6vsdb2Wg>
    <xmx:GnfpaI-97bEnsHemOSx8VHA6Ia7YbkSUiWsReijwoHw2Ob84goHnvw>
    <xmx:GnfpaI1O6Z-Eq2cVLByNAtmqeDJ5UQiya1-N4fj-rB91kda-5JYwVN3i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 17:14:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] t1016: make sure to use specified GPG
Date: Fri, 10 Oct 2025 14:14:00 -0700
Message-ID: <xmqqsefq7947.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

c348192a (t1016: clean up style, 2024-10-22) fixed a coding style
violation that has an extra space between redirection operator ">"
and the redirection target, but at the same time, replaced the use
of "git config" to set a configuration variable to be used by the
remainder of tests with "test_config".  The pattern employed here is
that the first set-up test prepares the environment to be used by
subsequent tests, which then use the settings left by this set-up
test to perform their tasks.  Using test_config in the first set-up
test means the config setting made by the set-up test is reverted at
the end of the first set-up test, which totally misses the point.

Go back to use "git config" to fix this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The commit in question was from October last year, and I didn't
   notice it until I looked at how the test script evolved.  It is a
   bit embarrassing that we didn't catch it during review.

 t/t1016-compatObjectFormat.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index 8341a2fe83..cb6d308f1d 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -116,7 +116,7 @@ do
 		git config core.repositoryformatversion 1 &&
 		git config extensions.objectformat $hash &&
 		git config extensions.compatobjectformat $(compat_hash $hash) &&
-		test_config gpg.program $TEST_DIRECTORY/t1016/gpg &&
+		git config gpg.program $TEST_DIRECTORY/t1016/gpg &&
 		echo "Hello World!" >hello &&
 		eval hello_${hash}_oid=$(git hash-object hello) &&
 		git update-index --add hello &&
-- 
2.51.0-616-gc7d8d4fd8b

