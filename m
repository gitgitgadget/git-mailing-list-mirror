Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3D25A650
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737079520; cv=none; b=bSHye+OhfXuNNWrZLcAF1nnRDgY1xWFHkO1kl3K/PUgNCuasu5Zw5r78ApwaQExg5QpoxhTF4fcKZbiWfO0WfuRUTzm2s5HgvmKpD1nfaBrYcfUiQML3SY7hziq6UddW94ttM2m1epy85UNZ5svOGmGNhszIwUO7E+T39t4qMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737079520; c=relaxed/simple;
	bh=CPU6NvuyX0N22Fb5dBc58DQbQ/B2Ot4Qgj/fzcrMBdE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2p4L+q/Jh1ailCNEykRpmkdnvEQ5TVntb2ygtY3q0cjVFprD+FSat5oYM3UTX43j2q5Umt6nVEgrhyEfsjCIwlLLQMMEyXzgSl/et7eBtAVQHtCyGorgR6V3YKR7qZbkvet7ROxHTf6ySP8ZzJvSnGUhLIo2u4STfCvkdE+qvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zmmdc2rD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pZBfgXWC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zmmdc2rD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pZBfgXWC"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B01D13801BD;
	Thu, 16 Jan 2025 21:05:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 16 Jan 2025 21:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1737079516; x=1737165916; bh=fCjPmO4dKL
	pieMG9C4b2cyUW3iHHIXlw5mucAqCi5ko=; b=Zmmdc2rDnzaLwxqSYHAlDHR3L8
	YJO91Marfu/mn91NqwIRpZ13eiFBweegZG4h2UDPeiLquFTfNdi8aGQc+braGH0z
	2++6pBCbqSp+xr1oSZ0rBCmSXoCq+a2zCaE/xPU2oepTWTq3xDKDJMf+cXmA7UVx
	a8cu4WleQdwsX8jVOhHZEMRKNya5XTI0VDl4EtsdFXffE+E0LQ4huKRwVANpczzf
	gDYOCwFNvHYYHpfuyEWtUNFgLqMn2BjDfrXkLwa7nArkJuL1D5FZY6XcflahVSH0
	nXt7JIsNl7J63Rd7eFzc1+6qLfz20R4fXBnUwsz+LyOEB6d4PnrSZ/JLaVUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737079516; x=1737165916; bh=fCjPmO4dKLpieMG9C4b2cyUW3iHHIXlw5mu
	cAqCi5ko=; b=pZBfgXWCMhprsl4vaZy0Q715/HI/hqGKAMGSteAuk7R8tBwe4eS
	W1iUJqUUemKolkoRPsPNmlCOlqnlLHI4Z+TOxoAcmFC+Y8UcsyPdO0UEzgEhfiuI
	O515nGkkFal1cgkFhfSioFpn+I3f+22eVr/mO7drPx/bZoM9INiA5LeYJXRECLUz
	aIgbUjT7HR4DHC3ATj6VEEG8GU9jRXRgDgEfAqP8gFD+YzxT8tVIdY7cTHgCHflb
	KrP0qMRGFTsMxZOeEEmEPSrW4shlK847pn2cni2H0dYn8cL0DITzImiQiSceUJIv
	7SFClcI+h0t+H9+39x8Dfiu7fu0Bpow6oGw==
X-ME-Sender: <xms:27qJZw2uty8Rnxoc8FcsVT8FLFqTN1IA4tGPkV8y9wIx4z4OJtLnmQ>
    <xme:27qJZ7Hlhll0gGIvm3IhiLBnNWBaI_Kv7C1vHPIX49pOsGbPpBlt4ow60vMWmod_N
    f72J-LKUa38jJWg7w>
X-ME-Received: <xmr:27qJZ44qWYWVJAHEbPLZRS8O4vOy-y0C10M4zT_GiRREplF2Cy3IFO4DLwnok56DV62G-fzeHwdmDl-BEC3cw-b53kwRJSQ0AfgJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffujg
    hffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepheevke
    dvveeuteduheeljedvueevkeegieegueelieelgfegueeljefggfekueeunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:27qJZ50e_oZ3PFrHPX_j2C9LbzlIVaMEV4_zsp6rvD-PYBAbhfEnWQ>
    <xmx:27qJZzHbs2QMzYZaqhVdfbfE0-CtyZBtmUFdGs1NfH3d-kWMiJ6nTQ>
    <xmx:27qJZy_2lIcgbK-qm5sQRI-yxvfmVEmYqDNIlaIMwKr8dyba77kr0g>
    <xmx:27qJZ4mdjLdBZttyX2qZPurt7N465aKg-x4kUzlL0BsHHg1vTBIlgg>
    <xmx:3LqJZ4S9Moqf1olz0JlAtfotlHTmn6A-PF_Mxdgc7r2achh13astR3aQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 21:05:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] gitcli: document that command line trumps config and env
In-Reply-To: <xmqqfrlinuys.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	16 Jan 2025 16:29:47 -0800")
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
	<xmqqy0zanzdw.fsf@gitster.g> <xmqqfrlinuys.fsf@gitster.g>
Date: Thu, 16 Jan 2025 18:05:13 -0800
Message-ID: <xmqqzfjqmbza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

We centrally explain that "--no-whatever" is the way to countermand
the "--whatever" option.  Explain that a configured default and the
value specified by an environment variable can be overridden by the
corresponding command line option, too.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * If we are adding a section to the document, let's make it a bit
   more complete by mentioning another source of tweak, i.e., the
   environment variable.

 Documentation/gitcli.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 7c709324ba..00b71bc462 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -152,6 +152,23 @@ can use `--no-track` to override that behaviour. The same goes for `--color`
 and `--no-color`.
 
 
+Options trump configuration and environment
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+When there is a configuration variable or an environment variable
+that tweak the behaviour of an aspect of a Git command, and also a
+command line option that tweaks the same, the command line option
+overrides what the configuration and/or environment variable say.
+
+For example, the `user.name` configuration variable is used to
+specify the human-readable name used by the `git commit` command to
+record the author and the committer name in a newly created commit.
+The `GIT_AUTHOR_NAME` environment variable, if set, takes precedence
+when deciding what author name to record.  The `--author=<author>`
+command line option of the `git commit` command, when given, takes
+precedence over these two sources of information.
+
+
 Aggregating short options
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 Commands that support the enhanced option parser allow you to aggregate short
-- 
2.48.1-210-gaa1682cadd

