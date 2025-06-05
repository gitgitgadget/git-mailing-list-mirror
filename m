Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D15223DF1
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157005; cv=none; b=ejVi/7f2YWa6jFpS5DERQ6y3tjgCiISZihkDmr9Kz2c5VgEPJ2yOOk8ibFxRS8n1P+hEidXauFfTiPUYpcj9dQ+Z5+eHVxFgvcOkp8LywFTTO0oxRcP+ahfIPjw9r+B5DvE06CrMK4aIIThjl+SStQj7IGAHWC38kUSr9bg4JSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157005; c=relaxed/simple;
	bh=3AO6R4zzT7XQyxydj5fMeMvvbNgz+FWt6aGLxGm2ukk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XLQow2ZarwjW9RAml35iamYIMhesdyWzi93wbHi9n3nQBLnkxqsKoVYwsM/9321RkzqWodDdnHqtsbgTWPKPtMyRqppsdXlBDMBEgCoM8xziO64o6Ezk+ToVhRnoYVwv9Ewsn0UkyPihvlP6821UwdWokUtAFdW0URz5BzyZNP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FJtrRo5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P1bn7vo1; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FJtrRo5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P1bn7vo1"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 761C0254010B;
	Thu,  5 Jun 2025 16:56:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 05 Jun 2025 16:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749157002; x=1749243402; bh=6JM74digNX
	FcxQVAMkJRbjPF4KvtXhgSmR3YuRA0Q7g=; b=FJtrRo5buIGnim0FcucwaNQ64H
	EUVXo1u3zsZm8apmfLMbv3be6QcYWU23lsSrMFENIgk68njNgr4J26JWFG7O8zG1
	N0lUdWfcC7yhtFPykV+vewd0fDlWpjp2/EBOPsgFTy7mnhAFq9Rd3u7yMsGk3iiN
	sxEJIJvXAvFh1lAkstni0OV/ZjSBIWXU5IC5YQ35a6MNTSTBLh1UiySOddNfii37
	XwvemZm6ovrGxH4t2G2wOPl8utree1HENIia0m2AXj6z/t9hdh4u1RApb+6OWWL0
	y4py9fBJegnYDswyiOMX/qw+b6Nd0B0GM5GL1Af6kQinqhNkFHyX/RwbO7kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749157002; x=1749243402; bh=6JM74digNXFcxQVAMkJRbjPF4KvtXhgSmR3
	YuRA0Q7g=; b=P1bn7vo1J6Tx2F2fxzK4BmOxMj6ORPP9NUQ8sZG6uPFhUWimDWj
	H7Z8B/7j0zbFJK3XlLXYfAc6CJJQGvOvFZBhAYMGYlF7DDViRJQy4XhltgbclOip
	xwyFnGlhNzehYg+rSUksBDKlX7US9hglkURAFwavaLkNsaX+M6KzAdGlgS/vDoTM
	eBf/BvsXibqXYraeJaxfYvIjMTTJJdEjLZ9KGJw9mGeDNzY4OyhYVxMzQsJKgZvb
	9Sc90yRfgaAIXwhEU967nbwjbTf6K31Qh4pBXLdbzUvavGA3oJ0Hw+EFIKYxifZu
	zzDMvo8DSnWYteNEuB7i3OFo3BgBESql17g==
X-ME-Sender: <xms:iARCaAs1h0wFIQeISV7G5LBvDrOyHUOtoqjftyC1yHXCWz_rO9u42Q>
    <xme:iARCaNeTU8fTiH7Uc7Msoq_KIhJX90Rw8RDK2HGchIIHOjuO6I60VnXne1wEGpP_E
    o_fZbvrDvlloptHYg>
X-ME-Received: <xmr:iARCaLx0_ag5nDFtQCRUbrL6cqAUZYbKtAGFJRMknmHWO-LM-ifj7rBAnva16qTn3CeRLmcyTRZaROQ8X5OuA1xUq3tu9nju1Ucb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephedtvddtvd
    egfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:iARCaDMI_5RzvY2QgljEFE7W0NHFGNWCjIazl889lvFE41qx8KA5oQ>
    <xmx:iARCaA8UPJeuXFcsat62YLo-rDnzNX0o0uq6WE3UksJnrbdhzqqyIg>
    <xmx:iARCaLWgVF9BPSHM8ZLxz6Hp9TxvpOyLSzWe9q_hQepqOURpoV0pdA>
    <xmx:iARCaJec5C7ZbTQXIsI4A8TATlXWtiPeBgKAY-ZmokTvPiND-mXEPQ>
    <xmx:igRCaA008FayHJkO4zkgsUBOL0f7RpUCH4NLvuKzs5YTD4VNSMQ_FAWm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 16:56:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] revision: fix memory leak in prepare_show_merge()
In-Reply-To: <aD_6T0lUOsqrb5sH@pks.im> (Patrick Steinhardt's message of "Wed,
	4 Jun 2025 09:48:31 +0200")
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
	<aD_6T0lUOsqrb5sH@pks.im>
Date: Thu, 05 Jun 2025 13:56:38 -0700
Message-ID: <xmqqmsal7vqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jun 04, 2025 at 03:08:56AM +0000, Lidong Yan via GitGitGadget wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>> 
>> In revision.c:prepare_show_merge(), we allocated an array in prune
>> but forget to free it. Since parse_pathspec is not responsible to
>> free prune, we should add `free(prune)` in the end of prepare_show_merge().
>
> That is a rather obvious memory leak indeed. Do you know why we never
> detected the leak in our CI? Is this code path not exercised at all by
> our tests?

I think we have no "show --merge" test.  Something like this may be
minimally sufficient.

 t/t7007-show.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git c/t/t7007-show.sh w/t/t7007-show.sh
index d6cc69e0f2..99f4d0b963 100755
--- c/t/t7007-show.sh
+++ w/t/t7007-show.sh
@@ -167,4 +167,19 @@ test_expect_success 'show --graph is forbidden' '
   test_must_fail git show --graph HEAD
 '
 
+test_expect_success 'unmerged index' '
+	git reset --hard &&
+	git commit --allow-empty -m initial &&
+	git rev-parse HEAD >.git/MERGE_HEAD &&
+	blob1=$(echo hello | git hash-object -w --stdin) &&
+	blob2=$(echo goodbye | git hash-object -w --stdin) &&
+	blob3=$(echo world | git hash-object -w --stdin) &&
+	git update-index --add --index-info <<-EOF &&
+	100644 $blob1 1	conflicting
+	100644 $blob2 2	conflicting
+	100755 $blob3 3	conflicting
+	EOF
+	git show --merge HEAD
+'
+
 test_done
