Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC223CA4E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772151201; cv=none; b=YwRFY0ytZrKQxLX86fTcs7a36XRuquFvzbSZTKVhq86YPsyWnwTN/lo7kZM/pND58DZJOZnDiBygKWmA8Wrio9x+j4VuMtvUg9S1MZ+EHjDJXNsw5dm3Ti7zrHSSCDhHWD/oLxC2EPLPe36PEqkanb8wbgNspxbrYBLkgFmIIuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772151201; c=relaxed/simple;
	bh=ppNR4A/8Q7PimWtJ17yMDKyq+aLdVQd2cyo07/I+5hc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gmowXFglvCiKFyYOJA5gmnpm1e6F5yoCSQMhve5Z6A+txNpUxELCe6fV7/vDMrmvrytlUhC3O9bFHu3C8wTWtgXToRBgrie6mHU4q1merTQt9CCrY3xp9DycvkTqbZuduXwLg3z6msr3FwdVsv/0fVoX/gIsvVK6X4fvUcBhT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EL2zUUWw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wyPc4fMG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EL2zUUWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wyPc4fMG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D50FC1400221;
	Thu, 26 Feb 2026 19:13:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 26 Feb 2026 19:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1772151198; x=1772237598; bh=IY4aF4QZhKkpdd2qlu2vfmUKnzCp4jCq
	lPVvOVYE70E=; b=EL2zUUWw2xvNsZ+fVEPGytfvUa/Uw2Ub1FuJLe/vXB6buZe2
	Hqa6GwWxTgGP3VzSWuxyhin1uS5ui275Q5mQAnmk156ic6HQjtwKS2ocKBjNm/nm
	xWpebQ75ntw3pp7cA8WI8vml9A1T8V4VtQ4GWwrDytsZqQQI91ps7tO0yAwuG6KU
	eaZDtjurkB5H/WIgKB5y3YvhVYRpOD8NVmsjcCy5GrG2JqQuP5rJ8rr0gC6Dzg2a
	f5ACgycnkLMX3OvNvq7h1hy3CmKWpGP/pArx80ejiQWXj+oGhzKJ2S5tgprOhaou
	aYryJbWVkWvqS5ev74j5ZP/TvGJs1pUiUphgjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772151198; x=
	1772237598; bh=IY4aF4QZhKkpdd2qlu2vfmUKnzCp4jCqlPVvOVYE70E=; b=w
	yPc4fMGwG027qDnLvofq6pCLIMnlW4+CeHLoIiGU0Wi5hRAev6qBVKflf3jSr1SD
	vvOprm/Kj+3uuROruBRvMGoUR0e2tPM9oyi4DAQ/b7Y6OQw4m+7BcUVm/tQOfmTm
	nnOZSqERtFnJrxmg4Sqz0KnN/iSk3CnEdTudmTfc6Meot9yfKXDLKCwTyl9TNwr/
	5JOSe06zc0SXjHvYHn12OuirpSyqam0iZtpIQ9IT2NX2sx6YFPy0Ai8UReiMucz0
	ywIZKzR+mJvYxCEi3XpeJOY98Ek5jEuFHg7f0VO3f8yHFvKKDYQUI+gzdvjZF7Yq
	CWDBw2GzwbyIFzj5tbq0A==
X-ME-Sender: <xms:nuGgabtgl2viHvAAfsHzdu1EOvA5XPM4mMYWlU3cnFBK7Wp02LEoqg>
    <xme:nuGgaSfRU_-AbWwcl8Q-xREw5tEGOdmm7xwtOrG_EC-pD51rsCwDYUTqjUuuvGd5a
    k2ThXuf_hufvjymQ5dfakypNysApNzaI_1ksRM8vO-Y4fdOrO505oY>
X-ME-Received: <xmr:nuGgacYN1trfJQyIbXmsDqkdH3HlpQloc4JAwI_Dslyn2drid7xVVq_r96OZiU4Mdl0MxhHkEYJS_SZDg-BVMFQCJPC9cbYCDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepkefhjeefieelhfdtgeeghfejkedufeegue
    fgheekiedtieffuddtheegveegudfgnecuffhomhgrihhnpegtrghtqdhfihhlvgdrtgif
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nuGgaVUK5gttBHviAh4MsaNuR2v7WRt9mWJI3XMlashj7yElef4QsA>
    <xmx:nuGgaehBXeQqiC0EpWQaRaNG8DSrK5XIb173KR-wRZaoVjs3LXLsBg>
    <xmx:nuGgaTVrY5RhFdiQ6QwloSNGR88Iqat-fhGUr7pXC0_f4iNx_7npzw>
    <xmx:nuGgaVP2Fid0G08Kv6sTrH4SS4_-tPhxH88_guFcoyXiGHKxMoqloQ>
    <xmx:nuGgaXFoSswqkPLktrof0581VECcAVJr8nc69rUC3GlxvvWo4lLGnDMO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 19:13:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [Bug] duplicated long-form options go unnoticed
Date: Thu, 26 Feb 2026 16:13:16 -0800
Message-ID: <xmqq5x7jujqb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

If you make this stupid change to builtin/cat-file.c, rebuild your
git and run "git cat-file --batch-check", without anybody helping
you notice that your change to add a duplicated long command to the
options table is a nonsense.  There should be some way to help the
developer.

The most expensive would be a run-time check in parse_options_check(),
which is not very advisable, but it may be OK to have one hidden behind
a conditional debugging option (like exporting GIT_PARSEOPT_PARFNOID
variable).


 builtin/cat-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git i/builtin/cat-file.c w/builtin/cat-file.c
index b6f12f41d6..eaa53b2b29 100644
--- i/builtin/cat-file.c
+++ w/builtin/cat-file.c
@@ -1091,6 +1091,7 @@ int cmd_cat_file(int argc,
 			N_("like --batch, but don't emit <contents>"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			batch_option_callback),
+		OPT_BOOL(0, "batch-check", &batch, N_("batch")),
 		OPT_BOOL_F('z', NULL, &input_nul_terminated, N_("stdin is NUL-terminated"),
 			PARSE_OPT_HIDDEN),
 		OPT_BOOL('Z', NULL, &nul_terminated, N_("stdin and stdout is NUL-terminated")),
