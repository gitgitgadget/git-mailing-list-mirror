Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC084AF9D1
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383405; cv=none; b=nHvLsA6clC39TrNGAijtesxsNxWxnJwrb6D/lnHhhYYXr334ef8UtGuG7kuPW60tEQ47UVyOgKVZ5pa5ssKsZXx75n7/1RdHLMUzRMx8GLs6lgbF729QJonTmV9BYot6aAsWHL/tJgTNilNrNiXO1v/9eMyJkRf40IfiXCZAHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383405; c=relaxed/simple;
	bh=Y4+cBhSs5qyXPNERo/Q0zbAj0tRFdal0x5ctksu3VzA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJiuU6dYbonLNa2AgGVALOUIa2Ms4TzN9PbU8yWY6jb7jtsCWHO/5yiZCzvoNzvFiTlTtWNBEl6jSuSnawe0Vs4VQIMx6Y/IIr3+8tv++WD+uwqN2R9DlIz8P2Y9mASyHx4cbFv7mDrLGDkrqGItuD5jiXN12EoFDX5ET8frn1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=aazeDw4I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMcJRClU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="aazeDw4I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMcJRClU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6BCEA7A0266
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 10:29:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 07 Oct 2026 10:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791383398;
	 x=1791469798; bh=aREYjtm68sVufLBXkCHDzsAvvG2UIvcVqDazJWsmE48=; b=
	aazeDw4IqSU7UaPxesfo7Cj2CcVBqeVtMd+5Lrjt4O7aB17vXsincXKiroL/lmWJ
	0tr/M19Zm8wWVoziNfmogA5VSHEqNkcaST9u9+KwsTNJ+hhjZ8TN2tuKP4A2GfLV
	rib7POcJISJoE2S7e629pTZva6FW8AsUSAZNJFniAKSZceMrctUVNOcI3NSF4pQc
	7YIhczvLexkEH2v/JRcqTsBdyE1D07WGBuFp2rWTy7IPC0T8lY3tJt5wzm1pDTr7
	hfkvCwpOpLSPn7PwPQjHF216/daQLPyUGLLKc7eb0IyBurEuj5o/r8GvJAI9G2Xs
	TZXRDtPa2A0MFSmM1Svx3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791383398; x=1791469798; bh=a
	REYjtm68sVufLBXkCHDzsAvvG2UIvcVqDazJWsmE48=; b=vMcJRClU4H0sIeLac
	e2peR6ozifqchdPGvYhHNMrtjVk0zLCgw2yow3S5jRYjdXNGiupCAlv7hljiPToL
	8znQJcO9MjGQ3Yfy1RK3OH99qg2LbQCrcGsaTlccb/QJ4BP9sqEfn+LU2pm8cqSg
	QcuTbfhA9CId7z5JLDbkAcxCHxSDnIPKur+/IRIwS+4I+F1/TXjlLvZLicICiGz3
	PPRKztA+z5BCWzVuGLevI+QGWVaxARP5n+cZq/LtRJ3oCNTJTN7HnthSV34K4tNM
	97sl0e9ESwr2immd9X4Qm9tpX72hyiZ78w1Wq5zPcqsAW9az5ywAfcfegxNmpIz6
	nScLA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=gitbutler.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791383398; d=gitbutler.net;
	mf=PHNjb3R0QGdpdGJ1dGxlci5uZXQ+;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ItPRbUiqLvBeVzTa53EVFWdqh8TaVDrU/QOP6scyjUecYK3
	e0IBaxjfbM/M5T3PgW42otgUO4OBcSZu5X5a/7tvXnHUtrfitoa45Nh3Kz+AjGKw
	DH1vUTftiNisazO0MLDm9Ez3FtagIJpmsVKpkF+CqBzwKyxw+eO8uojfIupUb5AH
	k/j2JiUIocLRv8tXHHtbcKTjOjIF0/jORFm4X0oL8KFhV+QM+CL4N9iRBzpGbUwV
	2MDsqm4gKNM2KFX/gtP4ZATxqIxLMAG6rALVQ75Eyi+OFlQsy2MNgiR/ZG71Vggk
	9AbQAu1Fv7x307ZIjGVjIxiZ1sQ8TuCW2BUb7Mw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:I8dJQCOf4fFw4XJwjIFN0wYbDDs+hpPn4ZmT6XRfIVM=:Y4+cBhSs5qyXPNERo/Q0zbAj0tRFdal0x5ctksu3VzA=;
X-ME-Sender: <xms:ZlfGaqltc-IxjEFDzPjuPP6ZclOXcNtEoBDse1bZhCwEnxke8hFqrQ>
    <xme:ZlfGaoybF2zKR52YgFvLVPQp1RkabEdmgd1yNPuIyDfdyMTT3k6_DduDzSTYMKC7A
    z1xRS9qPXRpwfxYAflb8KjWqJxmjqWBYK0r7sJTsNQqSQKefiuEcIr3>
X-ME-Received: <xmr:ZlfGauRt_4QLe7MuikKPbC3l_FZ6IHFXnywkTvd68akw92wkgLoHcGD3dUGcxHiUI_f3G8cZWL0>
X-ME-Proxy-Cause: dmFkZTFNnrBDlzRf5WRXuhQhnmPwrXIwAOUvqH4oQnKHpiE6TpXYiXxwnMhjdj/BTRrC4D
    uuCYHp2INAGoKxkySOVEgzVOF3MK1fKklhjSKSvSkrBq2YyzzZts/CKL9fnCoFtNK67qdR
    bxqgHoyTCnY1+GwGe4al2NBqAJASiPi3/aFJbO1FdwFU7QBCE9dVikGXpLkIZM6Fw+c7gk
    4NN0wqpiEiAKi/1NMg2B8EzvBBtTqvHcFQ9GahyHNqw0mMrthPBpqnLsNeMF1ELV6xx11H
    5mFMy1lL+yqksv9LIvgsyMWr0oR5ddYbKykPr4sv6KZxz0DcLgN9IE+gqi+D9mNcGLVOPg
    fHZR+0dPgrn9brYHC5NOQemwgAnMDsXXYlI/5em5cPDPR+vOCCUmNrRA51ojVO7uO1jdSX
    YZc+YK9TloYIxk4U5tRsCt2jsIqWjlT/87901tpTh3oHz/hpfq2siXdaIXCP2YVaWkka7h
    nxU3+dOcacJKfawJTQ365CAUnDFZAAMUqlgDiaWFbOfM5GLZZun9R2kDu96w6UgKai0JJG
    jc198qG21KAECpz0oLmLu9OU4/v30s0+6Sd3gLUuInOr6IT3oxBaBRN55A8VSqhtfkCh4/
    fBGlDhjK4UZQyKHsFe6b7WZyt7IGtuB7UqpdXb29OpEI3TBbMHbSNgAz3g5Q
X-ME-Proxy: <xmx:ZlfGajsjIozAaWobMSkKyWkgYAV8X3dML_1Mh2ln7AW0dsbD6UPi2g>
    <xmx:ZlfGaov3uJsK7K2cZkQNqiKT_D7Qi2CC6R7noe8jx3h0DVNgCHP_Pg>
    <xmx:ZlfGahw19_v7zhAchC37wX-zatd0uh7rDE9dM5fw_7D1wfnflOX6uQ>
    <xmx:ZlfGamjOx65rIZk01gCyfwUjivxH4YiGI8gq1c9R_TnFxascQBhmNA>
    <xmx:ZlfGam23oVHZPLnrXGTH0W_f9MHCzaT69_IqTsOLqKOK5Z3GSafjSx7B>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Oct 2026 10:29:57 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [RFC PATCH 1/1] SubmittingPatches: allow responsible AI assistance
Date: Wed,  7 Oct 2026 16:29:54 +0200
Message-ID: <20261007142954.31761-2-scott@gitbutler.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261007142954.31761-1-scott@gitbutler.net>
References: <20261007142954.31761-1-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AI section encourages careful use of AI tools, but also says we
will reject anything that looks AI generated. That leaves contributors
without a clear path for submitting useful, reviewed, understood work and
can discourage disclosure of the assistance they received.

Allow AI-assisted contributions under the usual quality and licensing
requirements. Require human understanding, appropriate testing, and
disclosure of substantial assistance. Retain the DCO without changing
its terms, and require contributors to consider provenance and meet
applicable license obligations. Reviewers can ask for further evidence
or decline work they cannot confidently assess.

Replace the appearance-based rejection rule with these concrete
expectations. AI assistance neither excuses an inadequate submission
nor prevents an otherwise acceptable one from being considered.

As an example, an OpenAI model was used to help me research, compare and
craft the appropriate legal language for this policy change to help us
match the modern, legally reviewed approaches now taken by peer GPL
projects such as the Linux kernel [1].

[1] https://docs.kernel.org/process/coding-assistants.html

Assisted-by: OpenAI GPT-6 Astra
Signed-off-by: Scott Chacon <scott@gitbutler.net>
---
 Documentation/SubmittingPatches | 73 ++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 24 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c60855f706..f703f96667 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -571,30 +571,55 @@ the patches.
 [[ai]]
 === Use of Artificial Intelligence (AI)
 
-The Developer's Certificate of Origin requires contributors to certify
-that they know the origin of their contributions to the project and
-that they have the right to submit it under the project's license.
-It's not yet clear that this can be legally satisfied when submitting
-significant amount of content that has been generated by AI tools.
-
-Another issue with AI generated content is that AIs still often
-hallucinate or just produce bad code, commit messages, documentation
-or output, even when you point out their mistakes.
-
-To avoid these issues, we will reject anything that looks AI
-generated, that sounds overly formal or bloated, that looks like AI
-slop, that looks good on the surface but makes no sense, or that
-senders don’t understand or cannot explain.
-
-We strongly recommend using AI tools carefully and responsibly.
-
-Contributors would often benefit more from AI by using it to guide and
-help them step by step towards producing a solution by themselves
-rather than by asking for a full solution that they would then mostly
-copy-paste. They can also use AI to help with debugging, or with
-checking for obvious mistakes, things that can be improved, things
-that don’t match our style, guidelines or our feedback, before sending
-it to us.
+AI tools may be used to help prepare contributions, including code,
+tests, documentation, and commit messages. AI assistance does not by
+itself disqualify a contribution. The same requirements for correctness,
+maintainability, licensing, and review apply regardless of the tools
+used.
+
+You are responsible for the entire contribution. Before submitting it,
+review and understand the changes, check factual claims, and perform
+the testing appropriate to the change. Be prepared to explain your
+decisions and respond to review comments. Do not pass unreviewed tool
+output on to reviewers, including in commit messages or mailing list
+replies. Keep explanations concise and relevant to the change.
+
+The <<dco,Developer's Certificate of Origin>> applies unchanged. Only a
+human can make that certification; an AI tool cannot sign off on your
+behalf. Consider the origin and licensing of generated material,
+including any third-party material it reproduces, and comply with
+applicable license and attribution requirements. A tool's assurance
+that its output is original or compatible with our license is not a
+substitute for checking those requirements. If you cannot certify the
+DCO for a contribution, do not submit it.
+
+Disclose substantial AI assistance in each affected commit with an
+`Assisted-by:` trailer naming the tool and, when available, its model
+or version. For example:
+
+....
+	Assisted-by: ExampleTool version 1.2
+....
+
+In the accompanying explanation, briefly describe how the tool helped,
+which parts of the contribution it affected, and how you checked the
+result. This can go in the cover letter or below the `---` line in the
+patch email. Disclose substantial assistance with mailing list replies
+in those replies as well. Trivial spelling corrections, formatting,
+and identifier completion do not need disclosure. When in doubt,
+disclose the assistance.
+
+Keep relevant prompts and outputs to help answer questions during
+review. Include short prompts, or a summary of longer sessions, when
+they help explain the change. Do not include credentials or private
+material in these records when sharing them.
+
+Maintainers may request more explanation, testing, or information about
+provenance, and may decline contributions they cannot confidently
+assess. Tool use does not entitle a contribution to review or
+acceptance. Discuss plans for large-scale automated submissions on the
+mailing list before sending them; generating patches faster does not
+increase the project's capacity to review them.
 
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
-- 
2.50.1 (Apple Git-155)

