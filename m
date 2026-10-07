Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3C4915A6
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383410; cv=none; b=Aueu+AIA2jhMhxjR2cusOw7H1K5rw1jlrrZJAWYGBfA+mVRjdTVxBmcRSG7hAOE9eE7ez1dKnWab61N5FTwTP4/E/VVg1AG+yq5Uv2+JD/pDliajKOMrRCPrX/+2FJYP++50fScRqJNq/D4GPFAGUWeCUw+rAMrbOfZFBLn0REo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383410; c=relaxed/simple;
	bh=6rpYVA5bmXzfyVI5B6MRvvDl3JYHB6EErD6T2/Dx/oY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hbPB9xc8921GvxFB5QLwtSgiluP6qr23lDefHroukTmdq/61DtEpHoWdknnqqcjeZ19ppt1JKTWhZ/fr3CIqAwHt1C5xkx/EsPtT1Qw6twucVnrkeK16SbbS/GKPdtU+IR4si8RdQePIXSO7nQHNc69RXtImvbpe/dCl4b5ZzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=hBhpW2IG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L2LkaRBw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="hBhpW2IG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L2LkaRBw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C0027A01DC
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 10:29:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 07 Oct 2026 10:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1791383397; x=1791469797; bh=hcmg/ULQq4bKLWwgUIttj
	teQOeS+82+iCj4anLHdxv0=; b=hBhpW2IGBIviBVbw1oVPxyChPC4OsZbNObrCE
	bhDKvioml+h6kSRJrz0BwF0oKUWOLmdXhbe9E1LOoU1KvvGUxA6jayQE2DKRBtjE
	ldWvZdoxt1NfMd3sRZNHYSRHsRmeZh5fxnsEveJvv2cIXhIsFMnlc7e+/niWaKmB
	Y7esGfpDu3V9hCPg/tByVfj0/WDfWNV7tkyD7rvjAcJZU5A1Iai6DRfSSiwyYwy5
	RKlMUYSeDpfZz+gFOxAbQHVxNBc8KHDG9anOgRsAz+1QXumBGIAP3pGp09AF3myR
	QL4xgkH7hkU2f9ZTyjGHzw3iSR5C4TvuPyFC0o29jVKY1kA9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791383397; x=1791469797; bh=hcmg/ULQq4bKLWwgUIttjteQOeS+82+iCj4
	anLHdxv0=; b=L2LkaRBwi7FRUVrVogwJzbfGoczJKurI1uHpIpWQ0/nLLpe6dKC
	4aMAzpPehIZDluqUAybI4QW7vJypf+6daYrikKzlcYDXevXF+6tzlWVhgeRte+/3
	uyHvlVl5HX5Qdxc9iA+H+FDeWYIKI/tOJc9uePh6zbG+Bc5CJiUCmkrlR9xwRGUj
	xeM1ZVnN/OKFdfRJfVOO+jaVo32PYiRq7130ikjBSQvysBeBJLkXCnPoLCHBOMtH
	Q25Kru9MPAjZUQGxWAt4oirlhFCqu1d1AsQSe9aGfAJq5c5fdxINt5AvM1gJ7VJc
	4hREHBWrqwzfn7HTQWRTk8w1EJSlfvbyonQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=gitbutler.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791383397; d=gitbutler.net;
	mf=PHNjb3R0QGdpdGJ1dGxlci5uZXQ+;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:awaq9ieO0mA0fYusVhCki2CtXDeWX+CLn9comfIf92Ltpht
	EH0yh+va6rosJ7QbPOYnJJ0f2O49o9lUCPxz50f68KEzM4wSO0SFJwcPz+7TbdXn
	/Zva5RTcF/S0B99LDuCUP7MtqZYSDHcbmTq8rnAypnEwJEZIvcniwrnehzrv8G6e
	aKjTLZVAFWpduJ9iH+uBgsFetNmuwNZSI6uV36Cm2h5wz+Pka7ums2n7hyKhqr8j
	8wmkC3Qa8nFaIN8Qi9hDNqdC6kE+AJodEM/Otx+IfAkS6+d22W6dbf/ykPx94z6w
	h9vw+CHb13Tgxvs3Fg3OI9JL7x+ktpYfRCGmj0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=8;
	hn=content-transfer-encoding,date,feedback-id,from,message-id,
	mime-version,subject,to;
Message-Instance: m=1; h=sha256:SMEIFzaCVekXXzkmkO8HNwft2HblRN9Zs8WJEtlRvPI=:6rpYVA5bmXzfyVI5B6MRvvDl3JYHB6EErD6T2/Dx/oY=;
X-ME-Sender: <xms:ZVfGajfo7VzFo0n7brkAakob20LB5r3lIUvCDKnqXJjjcQZqQdkD_A>
    <xme:ZVfGagJeQbvtgBttO2HIy7i9j7xWJ1fxF7rjKQ88gG5U-XCl1ysOmAewyOqa71nkv
    8vxofposD-zR8lvyzrRWJZAiVUg8ER2YZ42JoV3kgo6Q9nlhCWFLj_s>
X-ME-Received: <xmr:ZVfGaiI-RVeN1LQj2n4PwTueubwpB_pFAO5O6m1HyAizRrbKWX3jjWJae2LFg8WfBCQp8FeuWOQ>
X-ME-Proxy-Cause: dmFkZTE6TM5EpjuI6rLbyzBsHcKkEuksi0s093IkovXGePHKrqxMFYSxJqmI7FjHlwWFRq
    1JNKZysERvMmflIJJ4GmtOLMvdb/aQygbVN3wqowlZ5k2M/IADRmQhfMRGgfw+zzgmbRFM
    uvC9kQ5wznRM1uX3GQ4PD+2iFz/Lln05HNK4gyamPbH/mQ7qlFLyPplTNQb/vvWMLhS7Ts
    v+iXnnStkmUEKxYgsEi9T5b0IN+LMZgbmcEz8ecNvCUDwlneZqjGJP8QMGfMg0jdWVTuhV
    t4HER+fDoMc7u5CHO2RiakosQWqb1dFvZqmRLuGnkpLDSuRKEspQ6ITAJsFUGCP58caaPJ
    MDPf3Mg6WF3111g1p6JlkEocVXlQmCGhoZpG7KBrcjD126nKzjlyO9bxnBMjSqVedp01HQ
    ZgouYLgRwRYQ8CN+VJcDBX6xMJI9heZEDfj2p30tXS9oFIK5PKz+MtViSeeEcnzrAfHXTB
    EpTCHhS1wCElyW4iMLjPlCjpHdmtVG0T8vU93wTcG/2eXBm/a/RycaAV79+sqCktgnpPfc
    w6JlOlsumEXtgnJ1Vp40Zy7Lzmoumls8LLoShrmsPQ15EGNZ69xi02dEJ3EG6QySC71Hhh
    OllR/K32HjfT4PYuaAbRvmmneufMiX1VKkn5ggcn2FI2c4AtSb9iyMBZGPPw
X-ME-Proxy: <xmx:ZVfGaqGBG4rkH8qCk4SabUqbHbtzpaxm9kljJizDuVkLTDdEro7pvA>
    <xmx:ZVfGavnMvUPGFo7OQn7Hpsxfrjs0ku8ILi7mSvVqxzYwK9xBio7o1Q>
    <xmx:ZVfGavLoLgPp4NmZ3HZAk3wdphVDj2usf9OufTX9haVot1KdXPOjIw>
    <xmx:ZVfGaoakWSp1-kgVMYfYt38JTmyKNoO2lL_2ZY79tyyC7mVi3fS6ZA>
    <xmx:ZVfGalN758ZnIz9oDADs5Md0kTUfrj_dbioYCmzNfYxe25I_6n7OMyxl>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Oct 2026 10:29:56 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [RFC PATCH 0/1] SubmittingPatches: allow responsible AI assistance
Date: Wed,  7 Oct 2026 16:29:53 +0200
Message-ID: <20261007142954.31761-1-scott@gitbutler.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the AI discussion at the contributors' summit [1], I'd like to submit
a concrete alternative for allowing AI generated work responsibly. This moves
us closer to Linux's approach: use the tools you find helpful, but take 
responsibility for what you send.

Our current policy encourages careful use of AI, then says we'll reject
anything that looks AI generated. That leaves someone with a useful,
reviewed patch wondering whether telling us how they made it will get it
rejected. I believe that it would be better to allow valuable, reviewed
series and simply include disclosure (again, how Linux does it).

SFC's legal advice came up at the summit. The original policy credits
Rick Sanders [2] of the SFC and there was some talk of the policy being sound
because it had legal review. However, the SFC's public guidance has changed
since then. They date a change in strategy to November 2025 (1 month after
reviewing the Git policy), when they concluded that relying only on bans was
no longer a good approach [3].  

Their June 2026 recommendations describe how to use these tools responsibly:
review the output, disclose the assistance, and keep records [4]. The change
proposed with this patch is in line with their current recommendations.

There are also several other prominant example projects:

* Linux accepts tool-generated contributions under the existing DCO,
  asks for disclosure, and leaves maintainers free to request more
  testing or reject a patch [5][6].
* Xen is another GPLv2 project using human sign-off and an Assisted-by
  trailer [7][8]. Its documentation change explicitly followed Linux
  [9].
* Debian now allows responsible AI use too, though disclosure is
  optional there [10].

They all agree that we don't need to change the DCO to do this. Clause (a)
already covers work created "in whole or in part" by the contributor, and (b)
covers changes to appropriately licensed existing work [11]. Both still
require the right to submit the contribution. Neither requires the
submitter to have personally written every line [12].

So this updated version of the submission guidelines asks contributors sending
AI assisted patches (code included) to:

* Review and understand the whole submission, test it appropriately, and
  answer review comments.
* Meet the existing DCO and license requirements.
* Add an Assisted-by trailer for substantial assistance and briefly
  explain what the tool did and how they checked it.

I'd like us to give people a clear way to submit good work with these
tools, while keeping the expectations that make patches worth reviewing.

[1] Git Contributors' Summit 2026, AI contribution policy discussion:
    https://lore.kernel.org/git/summit-2026.94e33e9ddf234334.06@ttaylorr.com/
[2] Original Git policy commit:
    https://github.com/git/git/commit/7b0c37953d2e9198309ca6b6faf10bb5deeb4837
[3] SFC's account of its November 2025 strategic reassessment:
    https://sfconservancy.org/llm-gen-ai/
[4] SFC's recommendations, particularly points 4-8 and 11:
    https://sfconservancy.org/llm-gen-ai/llm-backed-generative-ai-recommendations.html
[5] Linux tool-generated content guidelines:
    https://docs.kernel.org/process/generated-content.html
[6] Linux AI coding assistant requirements:
    https://docs.kernel.org/process/coding-assistants.html
[7] Xen contribution guidance, Assisted-by and Signed-off-by:
    https://xenbits.xen.org/docs/unstable/process/sending-patches.html#assisted-by
[8] Xen licensing:
    https://github.com/xen-project/xen/blob/master/COPYING
[9] Xen's Linux-inspired documentation patch, 2026-06-15:
    https://lists.xenproject.org/archives/html/xen-devel/2026-06/msg00882.html
[10] Debian GR 2026/002, winning option 5:
     https://www.debian.org/vote/2026/vote_002
[11] Developer Certificate of Origin 1.1:
     https://developercertificate.org/
[12] Red Hat's DCO analysis, 2025-10-15:
     https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues

Scott Chacon (1):
  SubmittingPatches: allow responsible AI assistance

 Documentation/SubmittingPatches | 73 ++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 24 deletions(-)


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.50.1 (Apple Git-155)

