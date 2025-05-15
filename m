Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F64321C160
	for <git@vger.kernel.org>; Thu, 15 May 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326009; cv=none; b=KSMR+Cw0S4Vn0Edc8PqMt14t6QGBlSaiDSzyBPcstxtJWvlB5iUVXUvL11kxGOp+wnnFLoNJ2GU+a+/X0vfriUSNbsw0SSMFkSqi7GlED7q2bUfcHgW1Gbv1ffAlteSuIKpvWwR8Sw4Hc/BKsEYbOeJLDaJ0SatAdD3ROBvvmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326009; c=relaxed/simple;
	bh=pi03BhGJIIfJ48TGlT4wPT3TTlJz3OSxQFXYeHlzFSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwQXtIDtC7kAeeqYdJRxpOywxATxZAZatZ9Ei04EcPKUPMCPu+icmhEhAl5UE632OjIdyezgsXD5E0SQ9K/+KcqTQar5W1bqHMSgeIK4L4AT/pXqibxpoGUaFa8TtZUu+6BCOPAMRHocyY78+aIqP7sCwk9vF7O6M7/2owoLWuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=daku8Rd9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aOqHfMmr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="daku8Rd9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aOqHfMmr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3F8C0254014C;
	Thu, 15 May 2025 12:20:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 15 May 2025 12:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747326006; x=1747412406; bh=5CasUqXMve
	T5vC4UPspWft576LYiOxTH4xIJFgwKP70=; b=daku8Rd9GcQJFZMtViR5xvnTqB
	ek4yQa9AKE+TzWMmMYqfO+DX7Ud07dl+MaeRKi/aOxn3TwEHvqvSqYFZPaiW7nOO
	/VXUHbxsRylBfQjSrOD12i3gQYf55UEvs2nj3tn0o/Mk1+2vYKuVfe0Ip35IF1/Z
	J+gSsyIqQOX/tkeJakfbY/SbISuIOB365TrBV9KExmhP+NHAZQ7RmK8J0WzMhupf
	p1K3uh5HUiuoFVZWJIgeq8fBmrLxrI0JAe4PYkChv3btFybc3WRRa6NmiahTfyY3
	cLI64ORVT+iWxNkHm80bVQVB5n4s83LzVr/INPOyy0tsu/gnkuCdQlhYORLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747326006; x=1747412406; bh=5CasUqXMveT5vC4UPspWft576LYiOxTH4xI
	JFgwKP70=; b=aOqHfMmrg+Vt6bJe8fhKCTKZ/eRQHjwzMtglX4JQZARmJPBRh9W
	k/T4QJmJ6PG4UeLsWJyjI9F1/hSi4MharNk+UVjVt6jvbQvVgLY030+vhVKlsefO
	GgzFBxa2TPqUXrLfx9/RyIquuDHGeHsoGJ+9TtmB4CGR1YnoI6B73WYYcpkTmn22
	ysqgGCQVwhgdkNgbvYUleq7xeutl9g1BN/seq4r26DNWgXsJF8WUnaz+rfztk1T7
	AOZjmxu82vzW4xJtSjk4pu4PlIh3bzB5fWcDLkff/6+3VnWVSRkkPLfxJR1kznd3
	m0IM+vZhuRPtRCYGpznmC0iRMX1awJV7mGg==
X-ME-Sender: <xms:NBQmaAjtUict6sVxsxwi0zSZ_Cj4kabZKSFhnFJ9H0QgwLD10h-MmA>
    <xme:NBQmaJA4mvqD2PTIdm1nY4fID4TC-oSBwdQ_CC0LeplsZkKxsgZLDXKzYucyaSFS5
    1vQkLkAGZbR_4sOZw>
X-ME-Received: <xmr:NBQmaIHNmz6RnNpp0Vzz8-17VYKInPiIVPuHeEZ3PgPJv4euiS9OF_aAmqOToasE3XV-NGtdbcf14OptoVlhwbtz9Cb5ws60BvuQNJk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephefhkeefkeeiveelveekveekkeelgedv
    vdelgfeuhffhgffgieffjedviedvgfegnecuffhomhgrihhnpehsvghquhgvnhgtvghrrd
    gtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeeh
    tddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NBQmaBTSxzhfEVMagQMsIp0SmR_Vqi-SNrQoNKg1_ILObiTsKfFKhg>
    <xmx:NBQmaNwuhvJ0H0lYGuUy_T7dKNg_ivQTmEzc8F6QdpKtrLs93m6hCA>
    <xmx:NBQmaP438kyDUZFINK8r4tbDrc5k7-wl1CVIa12IesIZYUe6pzE3JQ>
    <xmx:NBQmaKycNbYHPJ_Q7dbKGc3M3kHtIp6MxJABl7bZ_UdpuQZCgptArQ>
    <xmx:NhQmaF4HwMhDlfLVCBebclMHaS3xt_E5QbRZzztIzOD8DfKxXB7R1dge>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 12:20:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] sequencer: fix memory leak if
 `update_squash_messages()` failed
In-Reply-To: <935822b9-33e5-457e-95a7-64058777b52a@gmail.com> (Phillip Wood's
	message of "Thu, 15 May 2025 11:08:36 +0100")
References: <pull.1964.git.git.1747226641249.gitgitgadget@gmail.com>
	<935822b9-33e5-457e-95a7-64058777b52a@gmail.com>
Date: Thu, 15 May 2025 09:20:00 -0700
Message-ID: <xmqqldqx3ky7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Looking at the code, if we reaching that call to error() is a
> programming error as we should only call update_squash_messages() if
> command is TODO_FIXUP or TODO_SQUASH so I think we'd be better to
> replace error(...) with BUG(...) which calls abort() which means we
> don't care if there is a leak or not.

It is a valid way to "fix" a leak, certainly ;-).

I am curious if Lidong's tool would notice an unreachable code if
only the first hunk of the attached patch is applied.  The "else"
clause in the second hunk would become unreachable.


diff --git c/sequencer.c w/sequencer.c
index b5c4043757..269637d427 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -2071,6 +2071,9 @@ static int update_squash_messages(struct repository *r,
 	const char *message, *body;
 	const char *encoding = get_commit_output_encoding();
 
+	if (!(command == TODO_FIXUP || command == TODO_SQUASH))
+		BUG("update_squash_messages with command %d", command);
+
 	if (ctx->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
 		char *eol;
@@ -2138,8 +2141,6 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_str);
-	} else
-		return error(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
 
 	if (!res)
