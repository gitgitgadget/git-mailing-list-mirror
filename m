Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F676265296
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575456; cv=none; b=XUUElFhSZJTw1RW0FnCgc6zcsAXw23e5RUDpq4nNRSu2CKXLve8hZRG89xxDcyp4BRfXCae09qoHZt/ABkIvuQt4L18rpF+kyadLyscR1dzs09wxZkQrPZxyNDMo0g8RsqD1r3NokrYmj6JfQGgPYzbKjpukIukl8iRQliy2dbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575456; c=relaxed/simple;
	bh=kBdMwUW3/8u3zgTG5U9T/yX4KfDEK8/P2nmQPFqNTb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8A3+es0hphUP9WxNSQD8P0fqKhlyilwTMacPsB19JgEgGhguEikjQsw1bVqNq+3VZeDot04xaIOF8Nhk17craKSS76DV7L5TqI7nCFU/VMNIGSFOv67O3e6+2k1qDpDGf0sCKvWpJaGHVJKWi8S+YqelzKMamYyjzxTXHL2NbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CvbTiyfJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Od8ZFGDH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CvbTiyfJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Od8ZFGDH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 220321D0000B;
	Mon, 22 Sep 2025 17:10:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 22 Sep 2025 17:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758575452;
	 x=1758661852; bh=w6/Ab63Dnhuq59pe9R++BEQI5lQP8nLraAshu4mwf3Y=; b=
	CvbTiyfJhdGQXxmOaiW/YsQW0RMx5BeO1JofZ4BREvkGHxcsBWbxQdCno81saoyt
	zlsQ3octj0U+3Hhl68t41duB1FqjDIG/MVjPkwfAT7kRPUNr6C15AzwW09IYb+2B
	UEuA+wdszg+9ySlGN9x5lMQjpoyNsNpdD7BKgnN1P3ZDV7pWJELGj4mllFihzio9
	2bWNnbstvF+4emMB1xHx/KpwW5fVnXsxLGNb9nrEZ9LEIIY1AyeWi85hFS62uT22
	ItTt3wjnBgDGGfxFG7IS887LcnAFzuDsM7OWGozr6z/D5Mbf/YunuYkH0r4lPk2E
	YkvKamsIamqOoF7BuoXzcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758575452; x=
	1758661852; bh=w6/Ab63Dnhuq59pe9R++BEQI5lQP8nLraAshu4mwf3Y=; b=O
	d8ZFGDHJy+SLok7rn0//vRx0p5D15fVVbW3QSnjkBZO29vavr/6Q9W9/e5tigpdK
	/kP6LQkg3DEBVCkZV97617GZJFZHYvKVqVpHT3myxkG1ORO1zm9i4tGDlTc0xG/A
	uhVHstqmoMH7YOMqt9pXqO8UbU20i1enCKgLHFqwBEdUKznC02hjNmGtsPMYFUi/
	cwI2ynVQTbt1fCGX7i1r9LhYYyG1HytQ9f+KTL1YrxNZLwLddNTAribsE8KyYT+3
	250MAIAaSJom9d4yvPFNlqvqYHc4KO64WF0ytHzVFmC44i719oor5bJGToXo/vPK
	oAD3JmIUkCVNQBypeI73w==
X-ME-Sender: <xms:XLvRaHfWGlH0g8_SZ1yTeB6I82Y5LM_dtZprpE_r-FLd0H8s6713_aM>
    <xme:XLvRaDPaY2Whg_E89OLx30OZcI91I1QRQEokFxNqsSPOkLimQ39-GP6QPvWuYAEec
    tVdNnrLDb6NPO9yuvBfhJAOFAevRnK423yV9UN6--piKp_wYL0>
X-ME-Received: <xmr:XLvRaOKv2nYpRcIUEs3C3SVQnVY0nHSmF90YLCqmsQ1UZ6vKPgMRWYnm0iqoow5I5kx6Tz80gGXkfpRDMJEaQDVVczoAFDJvY1BnQIdoQw_lC7sUyXfQ6LaTHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeigtd
    ertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhenucggtffrrghtthgvrhhnpeejffffjeegjedttdevfefgheetvdeije
    dukeduhfeufeekveevhfeugeelieetkeenucffohhmrghinhepughifhhfohhpthdrnhho
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgv
X-ME-Proxy: <xmx:XLvRaEE4VF2Z94xhnHvO0AI-PCRBq5CVuXQe4mAKZhFVTrXbfoaIqg>
    <xmx:XLvRaGTXGIssS8I0Hd8M5qwjoLpWzv_s7oPNPhtNSgMlrDFYJJRbwg>
    <xmx:XLvRaAF533As6zs1YeFmGgRcD3t1Xz8YwPa1jckJbiiZ7xVcNL5JrQ>
    <xmx:XLvRaC8eXhwkSY_JRYJWG1s8PBcWPAXNbySaHrhd0YKAVVhXoaYg4w>
    <xmx:XLvRaC1sxw_KxlF1k1G0wC7HpFoKiBvr5rLjIbdK5AiZIFdN5VjZqgCY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 17:10:51 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/2] revision: add rdiff_other_arg to rev_info
Date: Mon, 22 Sep 2025 23:10:22 +0200
Message-ID: <bb065767336.1758574974.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.270.gdb73cbc1bc1
In-Reply-To: <cover.1758574974.git.code@khaugsbakk.name>
References: <cover.1758574974.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-format-patch(1) needs to pass `--[no-]notes` options on to the
range-diff subprocess in `range-diff.c`.  This is handled in `builtin/
log.c` by the local variable `other_arg` in the case of multiple
commits, but not in the single commit case where there is no cover
letter and the range-diff is on that single resulting patch; the
range-diff is then made in `log-tree.c`, whither `other_arg` has not
been propagated.

git-format-patch(1) is supposed to treat Git notes the same between
notes output beneath the commit message and the notes output for the
range-diff.  But this lack of notes handling in `log-tree.c` breaks
that expected behavior; range-diff notes handling for a single patch
acts like a normal git-range-diff(1) invocation with regards to notes.
You can, for example, end up with a patch where the note beneath the
commit message has the correct notes namespace, but the range-diff has
all the notes that are configured to be displayed by git-log(1).[1]

We need to fix this.  But first lay the groundwork by converting
`other_arg` to a struct member; next we can simply use that member
in `log-tree.c` without having to thread it from `builtin/log.c`.

No functional changes.

† 1: See the configuration variable `format.notes` for git-format-
     patch(1); c.f. `notes.displayRef` for git-log(1).  These two
     have nothing to do with each other.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    There is also `other_arg` in `builtin/range-diff.c` but `rev_info` does
    not seem to be involved.

 builtin/log.c | 7 +++----
 revision.h    | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5f552d14c0f..56dd9fbc057 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1400,13 +1400,12 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		 * can be added later if deemed desirable.
 		 */
 		struct diff_options opts;
-		struct strvec other_arg = STRVEC_INIT;
 		struct range_diff_options range_diff_opts = {
 			.creation_factor = rev->creation_factor,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
 			.diffopt = &opts,
-			.other_arg = &other_arg
+			.other_arg = &rev->rdiff_other_arg
 		};
 
 		repo_diff_setup(the_repository, &opts);
@@ -1414,9 +1413,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		opts.use_color = rev->diffopt.use_color;
 		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
-		get_notes_args(&other_arg, rev);
 		show_range_diff(rev->rdiff1, rev->rdiff2, &range_diff_opts);
-		strvec_clear(&other_arg);
 	}
 }
 
@@ -2328,6 +2325,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
+		get_notes_args(&(rev.rdiff_other_arg), &rev);
 	}
 
 	/*
@@ -2487,6 +2485,7 @@ int cmd_format_patch(int argc,
 	rev.diffopt.no_free = 0;
 	release_revisions(&rev);
 	format_config_release(&cfg);
+	strvec_clear(&rev.rdiff_other_arg);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 21e288c5baa..26c18a0934b 100644
--- a/revision.h
+++ b/revision.h
@@ -334,6 +334,7 @@ struct rev_info {
 	/* range-diff */
 	const char *rdiff1;
 	const char *rdiff2;
+	struct strvec rdiff_other_arg;
 	int creation_factor;
 	const char *rdiff_title;
 
-- 
2.51.0.270.gdb73cbc1bc1

