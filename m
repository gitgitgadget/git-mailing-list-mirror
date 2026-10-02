Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A335C683
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938651; cv=none; b=PiIBz1Mdm4eoBux3TQagb1kllf71bOZkfw89nS8O53BK9Fzfu9fdbvguNya7q9ddybY0FhEID6DnSEiOqx1Rl/R4mg7ObKh5Fq3WaWltxN0YV75rOez9hlDLJkuBBGnZG0RPFEQtg7FEvUfUOKf5xoEgcM+NtjjdRIc3TuVvy/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938651; c=relaxed/simple;
	bh=BWTUJaHKgWEMk07Ej1VijB/0JjJFGAhlR+jyXTkxJyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBJd4T0UFTvlQvksSfMiDxtzPm4E9Xj0a0CIEZdgws2whnzZxoT28IY0PLbqtR33y5wl3Faepx1Vo4NKqsK3IsqRblG8qFDqSRMM/sFDFNTf4b+kMurJT7mXNavrSJ7wOlnCe2zCyPMvktszFWMxx80jaXLeYDkBYWLjR78HLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZiL2OS3q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mxZ31p5I; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZiL2OS3q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mxZ31p5I"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F38DEC00C5
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 06:57:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 02 Oct 2026 06:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790938648;
	 x=1791025048; bh=LV11iMzfMM3a/UVKYv+NRcaW/qu70KgqfI2N73ZE+kE=; b=
	ZiL2OS3qe+DkMgudln8BoFUuXleOwMurSu088qBjxSvSZajNXHjbT2uCWHGZQGgw
	Yf3Mz8/LAC6M0GJzFHoPyQVTf8qLOHnFTCjdpgpQW7hTexkDnXxYib5eV687AGRg
	x+ieCqfdfENyqjjUEXcGO/P5PXPLOBVl2P+BiWMYx+98gzBA9EqPUkUTZReUHCM9
	px3SlEFrzKfwRvpnyNZ24/6mfMmBtzoQFBFoHnupa5vvsocEXicLo9Wjm9nceYdT
	VCHE3KsSED/4EEKF2MclmZUS+sUJ/IYpFME22LxTHOOoWjwz7fOsx5Zia2XKnCBz
	lIxLkIqd749l/EDOsUIuqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790938648; x=
	1791025048; bh=LV11iMzfMM3a/UVKYv+NRcaW/qu70KgqfI2N73ZE+kE=; b=m
	xZ31p5Iw3NPavjNyn8rM+vmOzxWXgwH43oiEDddvzlPzGX5XHFUuJBi8PIyTPY3P
	Lb54lELzoCa/Jt4kNLrSfbzvTYN4Nu1TNX+avmaAaB763YsFOwSQheA5T40qls8C
	NiCZceEjIYzzJfNfBJxchLo0AOuOWLH/3cEtNHZEiFz7jJCtn9vhtsU7fv2bxJRn
	K+CdVr0ftbedRIvYf+EH3xujYOpYR03mEHow+lcFzqk7S8ktnTzRahXEtOLGzlqB
	zkCvxh9bami1DpQNrSci9X67e2x3L0nqag7Rzltu0TnDUPDyVCpDz05xhyAExR3T
	VPydwTfcLY7WR/b6Q88eQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790938648; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HhN3vMb/VMQ8AJf/75gkVvqazNIEqkt61FarD5rwMfFalIr
	c2E6nBwYo6Liyrhk8I3BXMX83c0o3gxw4HI5Fwofjt19Z9n/3IH59a2TQ4H4tSMf
	XeveC4DOraJO7HVY5kXUkrKkzCCQC/UXodRmR3OuCYGQGjH3zO12bTlOv10mwseo
	CAGQ/GICp63lJiecUhxz8A5n6Y/WmdAgf+QGEQ4WEVDMRamm01tOGks6iqYjvlTx
	Lb+8E4R9kZ5y1qiOnZYjZqVMFxd/T08bZmMO1iKFW4szWv5dQakmFPJOGCTfYAlo
	iMSkQEMWZG7f1wC8Prt41kW2bgRbNnMTmWSO/EQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:i48qpyq1zatmSMnMnED2BqSYyhXO4YrO2blfwlR2Duc=:BWTUJaHKgWEMk07Ej1VijB/0JjJFGAhlR+jyXTkxJyg=;
X-ME-Sender: <xms:GI6_atu86SsHre6JP2c_oqbCWC3Y95u7kWYJZVoDv4YUxVYG6nnQVTE>
    <xme:GI6_atfrRBn7T44mRJBwPNGiz3GCpjJ9pxEPc8r2zs7mpGk-6_7ePuXWRnQ4oEpRr
    TXXB5L9AlmZ4poT3trxwjUxiik3AW5wXyxFQsu0aaKyQ8YzkEek3g>
X-ME-Received: <xmr:GI6_alyiWfiE1eg44P5R1A33rG9nc9nhMUO4YoBJia8nmgMUCP6epGY5rMIuecRWlxjxr8W1pESIHyZDiRTssVAjFw6QlftQOuEzeO4>
X-ME-Proxy-Cause: dmFkZTEOuX/4RsZVjlke0qo8Ptp06h9IF9Jj/gAiW4j6/Z1UBHtIYJJioszFZRHZkVsJRC
    6f2/yXA8HNmzA3tbcaiislEhbuKT0wDhf4Qj+QsitbFmGQd5yhY/UYxrpKJ+3aklpeG+rp
    vuJ7DgkPXpmCBjZnMk8QUG7Fzgc1gWILWWu7enyunv8Mttc/2BZcz0af3UZROPhJNlppJ7
    8w21v1vadUycGls/v+5D+r6PYj4V/Axkrc5swu6lLawwIR1J5oO6MpdnziMIesdxemDbT/
    mwRbyt306Gd0jb4t6trBh6PZIWobG0kpLf5Cz/mTjL9TYbyBKJwtAFsT4WCAOyrANw5Vj2
    HzN7ISfxtSMjuVChbtw3xSXXw7ET4+ouiBbD/8imIX8+ZKM0lMvJf+5lXgQcg+ausfKBWC
    jGsbgtJvjjsIYp6hq8VYtecJKHMEFkYVOr3P1rFDdos5ISWUeWMuCj/Na1PC+q6kUUL9GC
    fl1i8l32OimDqQfRU3yuH42vM56QtlSzZgomo9pNa6Yt/kUoPSIOxEmfy6wKVowvbV1mif
    EEi+KCwGeGZLBzpkjclI92pEachRukidULTOXNA3MFyelRMZPuHE5h9mp8JUIKNKVfWD2C
    HtHpTNhGXEb1BL/iYmWPojNCd+vxZvCPrB2vjtW1AI6g/vaBQ84VpeO2CMfg
X-ME-Proxy: <xmx:GI6_ajHX-JPf0J4JJFslARvWxER845LTudwPhkeGnLHYZJM_TXYXPQ>
    <xmx:GI6_apzbth5RQjbbM-7by-CvVZ5i3FLBv61ClWlK-A2XS9LDOSkJ_w>
    <xmx:GI6_akv3j2e3yDSE92AV9fT7jxseBiRNEL48FkkMzW2Sg5UgP8ZX3A>
    <xmx:GI6_am3AiPv-C5on36wOmc78W6XfR6Gj7v-zHrIMOoye3XLHin8zWQ>
    <xmx:GI6_apTToFKb22qQ_Xl0OatGZ5AOp4i3azeHQmV-DThWk-_3fs8E640t>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 06:57:27 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/2] format-patch: simplify get_notes_arg parameters
Date: Fri,  2 Oct 2026 12:56:38 +0200
Message-ID: <V3_simplify_params.d3a@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
In-Reply-To: <V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz> <V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
`rdiff_log_arg` to `struct rev_info`. I changed `get_notes_arg` by
simply replacing the first argument with an access on this struct
member. But the second argument was already `struct rev_info`. So I
should have just simplified to *only* passing that parameter. Let’s do
that now.

Now is also a good time to format this `for_each...` line since it’s
gotten quite long.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (testing):
    just compile tested

 builtin/log.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 350b35c5563..560af00e2fd 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1333,16 +1333,18 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
 	return 0;
 }
 
-static void get_notes_args(struct strvec *arg, struct rev_info *rev)
+static void get_notes_args(struct rev_info *rev)
 {
 	if (!rev->show_notes) {
-		strvec_push(arg, "--no-notes");
+		strvec_push(&rev->rdiff_log_arg, "--no-notes");
 	} else if (rev->notes_opt.use_default_notes > 0 ||
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
-		strvec_push(arg, "--notes");
+		strvec_push(&rev->rdiff_log_arg, "--notes");
 	} else {
-		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+		for_each_string_list(&rev->notes_opt.extra_notes_refs,
+				     get_notes_refs,
+				     &rev->rdiff_log_arg);
 	}
 }
 
@@ -2404,7 +2406,7 @@ int cmd_format_patch(int argc,
 		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
 					     _("Range-diff:"),
 					     _("Range-diff against v%d:"));
-		get_notes_args(&(rev.rdiff_log_arg), &rev);
+		get_notes_args(&rev);
 	}
 
 	/*
-- 
2.55.0.793.gc667de3f2c5

