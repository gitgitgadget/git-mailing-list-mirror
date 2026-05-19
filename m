Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415723C512
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153744; cv=none; b=K8fQBnVPe5nJBjAgqgnkhB1gMAviiO4TQ5VVO+tbFaOedgPiybAxRX9Qzq0xCwe01kY3aW1ubfWDTVhCyIKNByWngs0r3g0kRI8soWlbnRePrYCzpXHhvHg70SdbE9U+dYupCFfmxCFwooKTFeArQvDmvLqUIf8WjS9swYKRCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153744; c=relaxed/simple;
	bh=5c0tN1V3n8FYlU6cCCIik+mZCpiF5tx/6AhOTBAaSuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LkGuR9nQ3TzE/QkLDvQY4fdkELxQ1lU3f2ODu5kBJc/LPqIwOXIr9DbFVmA6SYkVZbEauEp3/ptC7Qrrk8a8BemwC+5coVET+JH7CiIDDWCNIeqe8/TCIjZb+0Tg5EDDiPNyziHwVtoWSvts4J7NuGx9+kj2IFvXCP5kYkT8wN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rQGhXwmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UQWIZshz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rQGhXwmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UQWIZshz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 49732EC00EA;
	Mon, 18 May 2026 21:22:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 21:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779153742; x=1779240142; bh=1ay3458FMo
	lI3CR0IjM5HcXot3LwMqaZSplTZSRkm1E=; b=rQGhXwmQ9BO0UW/5+wFZ+8SPCB
	RFjDJIDkAnCrJfjU3AHdY2N3gvLy9eZOlQWQ/XTdItpRLZYQhee1HqbAbvqRmNOK
	XTstsxNQS27g4VzPSfBjjgNb31xmCnCHgbut3j2qNKVLEtOT7GMvP8//k4SzurXc
	ty1y1la56iXci4//m4cDeKjCXZAYdyGQTLwaMR9rcbBSQWIq/iubnMoGRp3KrHJb
	ltkgGPGj8Jglcl5vocsLFrK0vM7XnSH19+GTcGela0XQffvLbMflydqBx6XbG8Kr
	1Dbf2jxh/7Tk4aFJnne/ikZtJoL/hwd9l3J7YZAoACSYXKq4DQtUFnlxMGJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779153742; x=1779240142; bh=1ay3458FMolI3CR0IjM5HcXot3LwMqaZSpl
	TZSRkm1E=; b=UQWIZshz3cRMJBPGwbZU8Zkiyral9gkS3lBT83f9vL2jj9jffQh
	ui3eyL1/R7hQRrHBMVaXkaqwPnCfaDlG//Ft2TgduqX8lELwXHk3yAa8g/L66SOG
	YUQuj2BH5xGRqqzJnPL0AeJTw3mYhIs9N2Gcyvd9hMMEahMZaa5QAv4rP9zawmpz
	+SqToSBLD8BtnvyazHrZD/e2OsiMdGcdLX/jdTVQkU/R+e1S8lseRiCmJMA9y0zC
	CgRRfwbXMldmTd3z9SULtPqaRaFXhQKZSH00x33A1B/IQyP0b1OY64C2nuqzS9Gz
	NV8gMETCLYiLWnMg0eh1Rm3+lPCeRVg1Vjw==
X-ME-Sender: <xms:TrsLakKqET_EYmzeYPMspcrGYrLRXVvugb62QXOHubrwEpgoIgVWeA>
    <xme:TrsLan0LxuFJBZJ75-0nvBlRsOCMFxSCr69YfVc8cYLq8oOMXZjgDCoR3mWa4LXnu
    q4hBtYrlDB-qUQ5zwmidI2mfmStMTv-QCTszxmR4wni2txaljdsuw>
X-ME-Received: <xmr:TrsLauiMpFV4jBLOGQDGmocYgrKg4Wti7ANG_8IUY6jQ9Diz7YHQcuaJCMae3dDugldY4Kr-wGuBYkx3hxZPkGTW37cMF-RiwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedtgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepheeigfekjeejvdeivefhheffveeikefgvdfggeffkeeihefhgefgudeuueeu
    ffejnecuffhomhgrihhnpehsvghtuhhprdgttgenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TrsLaoXedUccJpl3Is1M9Wyb2hTFTXqdVvnrzsYI_Rpm2oEoICxjbg>
    <xmx:TrsLatULLTJaBDNToSgU61D_5SvfXSW3sCFb6mbsYn7FJcRePVkHsw>
    <xmx:TrsLaoiGWwOLQgPJFGUyMuRKziLNNyw1AtXRzVIb8kZHs7EWGj7Lbw>
    <xmx:TrsLaobuPqxzQMYuKiwDH6J5NlvF-f3d3L4pRayrQwdtOgui5gf-NA>
    <xmx:TrsLaiXWF-NBSK8spiIaFyiB9XBcxjQBJOngRKUD6JWNYTVKov6_swJx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 21:22:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
In-Reply-To: <agrD4p1AIPtwa5gW@pks.im> (Patrick Steinhardt's message of "Mon,
	18 May 2026 09:46:42 +0200")
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
	<20260420-pks-setup-wo-the-repository-v1-2-f4a81c4988e8@pks.im>
	<4d9604e2-036b-485e-aa93-53c35d539bed@malon.dev>
	<xmqqa4txd2p5.fsf@gitster.g> <agrD4p1AIPtwa5gW@pks.im>
Date: Tue, 19 May 2026 10:22:20 +0900
Message-ID: <xmqqqzn89os3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I do not offhand know if other code paths that are called from this
>> function are thread-safe, but yeah, this use of file-scope static is
>> not a safe thing to do.
>
> In the current status quo this is a safe conversion to do, as we still
> have the assumption ingrained that this only works for a single repo.
> We were using static variables before, and we're still using static
> variables now.
>
> That being said, I wouldn't mind dropping the static variable if this is
> something we'd rather want to get rid of. It's a smell that I'm not
> particularly happy about myself.
>
> I'll send a revised version in a bit, thanks!

OK.  In the v2 (perhaps v3?) series, I can see the removal of two
static strbuf based "optimizations" is the only change since the
previous round (after merging the previous one to the base of the
new iteration and comparing the result with the new iteration).

Looking very good.  Shall we mark the topic for 'next' now?

Thanks.

diff --git w/setup.c c/setup.c
index 1847111616..6aee839d8c 100644
--- w/setup.c
+++ c/setup.c
@@ -471,17 +471,26 @@ int is_nonbare_repository_dir(struct strbuf *path)
 
 int is_inside_git_dir(struct repository *repo)
 {
-	static struct strbuf buf = STRBUF_INIT;
-	return is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
+	struct strbuf buf = STRBUF_INIT;
+	int ret = is_inside_dir(strbuf_realpath(&buf, repo_get_git_dir(repo), 1));
+	strbuf_release(&buf);
+	return ret;
 }
 
 int is_inside_work_tree(struct repository *repo)
 {
-	static struct strbuf buf = STRBUF_INIT;
-	const char *worktree = repo_get_work_tree(repo);
+	struct strbuf buf = STRBUF_INIT;
+	const char *worktree;
+	int ret;
+
+	worktree = repo_get_work_tree(repo);
 	if (!worktree)
 		return 0;
-	return is_inside_dir(strbuf_realpath(&buf, worktree, 1));
+
+	ret = is_inside_dir(strbuf_realpath(&buf, worktree, 1));
+
+	strbuf_release(&buf);
+	return ret;
 }
 
 void setup_work_tree(struct repository *repo)
