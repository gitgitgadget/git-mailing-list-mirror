Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971C2C9A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 03:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754020260; cv=none; b=ILGoVX+Mi8Vqk4N/ow97nuekEWR8pqOR1Ko213NNTDT9RCl0LUQnhSkqew2CJsGSnPGJIj3YxDDVz00RfbcBhjLTY4Zk2O9zg9ojnNmlSrAo5IWL4sBrO4anCIHIShIifDldzZDYWkKFVzM0L8XsYpfJN+TW03pavSBMlbdhQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754020260; c=relaxed/simple;
	bh=YBGmtCpd+rqCq7WrwqdDXO2jMelLrhGvwuR6ZAugzCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tH9MdkQHmsV5q7QjLp3WywPQP2gmNby98jfvBE0XF4rqDlnSKWARscSLz1tphKod6fsA2fsEFT1N0Y1oCwOLDdon1ZOtOq3ToBp+EIgYJeRDXklQC4qUGiaqNxgKiVBwALoOHeX3shxO4HBnSB+FB58qNChnXeGp3dp7lJAw86w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NwWgQL54; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UINe1MLa; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NwWgQL54";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UINe1MLa"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6C5427A0AE8;
	Thu, 31 Jul 2025 23:50:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 31 Jul 2025 23:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754020257; x=1754106657; bh=SanF/dUPJj
	6KAG5BRY9/UjLacCkGuDf1apFsQtV/eYk=; b=NwWgQL54xKZrqYoOJ1TItR4Ykh
	v+HLDCFPemRXZT1UZgeMh3DxlxHIzqPbOeNEIwIZogz6bzAIxfrXjcgAPtlNcnfV
	d8ZlFw7XoW7gSXbU9Ec45I+Sj1em01vksp1fjpHBZx/dlHa7w6tI0gUtkBXu9IvV
	FDE20/Y6Ee66zEoQkyb/m0vGYS36SpBTd2C4Jtj24y3RjIq8xeUA5gD7NqU5FWeV
	Z2yczmZA36B6dARQ1eNizO2IvX2pzw2rpF0P2n1uj9C7UrY3kjziiwEiQQw2C3UN
	fUqOv0+kqXYAP6is+Rvbuk37psTXO+1rr+c2YrWTnLyp3IOTmaI7XtUGWOqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754020257; x=1754106657; bh=SanF/dUPJj6KAG5BRY9/UjLacCkGuDf1apF
	sQtV/eYk=; b=UINe1MLa0FfRjgaC925W/lRD5aKKHlPpbN/GhiQFHWLBcds8Znv
	VPoqB2Vs05ILnminFSc+jRz3YXEx3vOIVCZkVN4U7+uXKESF8jZTVwf6E+Q2SfY4
	7DsQAx0X17qrorgGjbq/6S1rJcIit+SbeTNu84xqswp32m+tcMkIZ92KdcHUiRHM
	Kwwe7zIfarO1EEoEoPdVLB5sdt2QTBToRUvDuXnGVqSXYQqYgua2Le7ZkT//9ZMR
	4SIbWlkAngLmdSWc6256ZAWONhLdv2omPDLhvoZFVK/0f548F6vjuAlKBUzalfjq
	KcI0P/G3hhark3AQtrnJh4yyc0WW7Si4zNQ==
X-ME-Sender: <xms:oTmMaHpcXvW-SExQhOGT_T3X1XO1w_z2IIo3GvgLRdg6VoYNdMwuDQ>
    <xme:oTmMaPPX_jczC4Zzl0QJz-uL0mQPqnw92CMoBGUFEAjbq2UvJigRmOEa-VzI6uC6P
    vc6UFwucGivaNZqRQ>
X-ME-Received: <xmr:oTmMaKqyOSown2TjWcqmCNXSYWfqFNtOuNq7FG_H6sr1p1onN41a5dAdc5LvKNyGJRYCKfTWs6NZAdnGEs4VC5B1WWqJfHSLulmnlQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefgjedtffejkeekueelveduuedvheeiudffkeejtdekfeeivdegtedvgefg
    hfeinecuffhomhgrihhnpegvnhhvihhrohhnmhgvnhhtrdgttgenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohig
    rdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrhihurdgthhgrnh
    guvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggv
    nhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oTmMaMeigjkcG8ZBY7UVZ-0FnDGZEmdsUO1MG18jfem3XSrQaNVz9A>
    <xmx:oTmMaIR4n87ZlKyeMbMIQNWDonn-IQDS8JDfK5EQ-sf2bqaYYFpcGA>
    <xmx:oTmMaNZDt0VpayzgrTpHJ6sacPNDoufPISyeMMHUrvQT45PeaULByQ>
    <xmx:oTmMaDchqwGs80fPIpa6_MoTvvPgZNya4miw59n_Sp_fciyfKr4czg>
    <xmx:oTmMaGWqScIAUrLHb9y_FL3qDdZ5SvdPVFL-vOdWBIEpHGRrbTIA5vQa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 23:50:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/3] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <cover.1753975294.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Thu, 31 Jul 2025 16:21:52 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1753975294.git.phillip.wood@dunelm.org.uk>
Date: Thu, 31 Jul 2025 20:50:55 -0700
Message-ID: <xmqq7bznog2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Changes since V1:
>  - Rebased onto a merge of 'ps/config-wo-the-repository' and 'master'

OK.  I needed the following merge-fix to make this merge work.

diff --git w/environment.c c/environment.c
index ae1427bb9e..a0ac5934b3 100644
--- w/environment.c
+++ c/environment.c
@@ -461,9 +461,11 @@ static int git_default_core_config(const char *var, const char *value,
 	    !strcmp(var, "core.commentstring")) {
 		if (!value)
 			return config_error_nonbool(var);
-		else if (!strcasecmp(value, "auto"))
+		else if (!strcasecmp(value, "auto")) {
 			auto_comment_line_char = 1;
-		else if (value[0]) {
+			FREE_AND_NULL(comment_line_str_to_free);
+			comment_line_str = "#";
+		} else if (value[0]) {
 			if (strchr(value, '\n'))
 				return error(_("%s cannot contain newline"), var);
 			comment_line_str = value;

I guess I used to carry an equivalent as a recurrent merge-fix for
your topic branch, but rolling it into the base of the series is
certainly safer (i.e. we have to do a merge and resolve conflicts
just once, and after that we won't even touch it---as opposed to
keep recreating the same conflict and resolving every time we merge
your topic via rerere & merge-fix mechanism).

Thanks.
