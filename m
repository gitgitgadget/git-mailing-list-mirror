Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04CB79E1
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558615; cv=none; b=Hc6TEPtD3XV1HvwEx4jpDrnM0kR21gxvZcRl8ZUYspvPB1VI4x/YEkL7vVlYwOs+FRA7VGHE+gd/Eey3t1Qq5HvE6fegdfMKpxXHUkI2X5sAJH4ou4eR45bcpsPqwSyVMZmLx+EQJsTMbfL9grApwDUuIGu1nenkxs8DNgtFhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558615; c=relaxed/simple;
	bh=miqXDXdVWYIoI+V1CQ15I9hajBSfjNeuZto77en0zd4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZN5fw2MJ5f8lNIhxicX+VvQZMRgWV1FZ9fTbhg8q93CGU+C8gCCUPYwgSOHEkSRlaDkdjoQv+jzgac9Vt+xu9+74v+bNVFdYuS6P1SHnoJDR3n7qNJe6Xey5DnAWwln3mypQNDT/QaO5mNIqkrMWGXYd8zOElDh0Nwlv42cYcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=p2NyY9S2; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p2NyY9S2"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AC0332D677;
	Thu,  5 Sep 2024 13:50:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=miqXDXdVWYIoI+V1CQ15I9hajBSfjNeuZto77e
	n0zd4=; b=p2NyY9S28a0bRBebv6+rd0hH2QU1JtmouNulkiZ2CeafYFEYoCFYOK
	xjuVCPooa0DCU6wToUkE17E7dWCxoOtnUiCdQovtA60Cf9UUAzHhqfCM4Uju3q60
	Za6qnCfvp7NLGra0LWh8VVUlpNtcwIFmWaJ5AhESO0SIPu3yyWjAA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A291D2D676;
	Thu,  5 Sep 2024 13:50:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5A392D675;
	Thu,  5 Sep 2024 13:50:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/3] builtin: remove USE_THE_REPOSITORY_VARIABLE from
 builtin.h
In-Reply-To: <17acc1e054c26b67659df17db828b106c005ffea.1725555468.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Thu, 05 Sep 2024 16:57:46
	+0000")
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
	<17acc1e054c26b67659df17db828b106c005ffea.1725555468.git.gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 10:50:10 -0700
Message-ID: <xmqqcyli2dnx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C8D7F54-6BAF-11EF-89D3-9B0F950A682E-77302942!pb-smtp2.pobox.com

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Instead of including USE_THE_REPOSITORY_VARIABLE by default on every
> builtin, remove it from builtin.h and add it where necessary to
> individual builtins/*. The next step will be to migrate each builtin
> from having to use the_repository.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---

We at least need the following fix-up in order to play nice with
others, specifically Patrick's ps/environ-wo-the-repository, when
the topic is merged to 'seen'.

Thanks.

diff --git i/builtin/init-db.c w/builtin/init-db.c
index b0ac318cc6..cb5fc340a2 100644
--- i/builtin/init-db.c
+++ w/builtin/init-db.c
@@ -3,6 +3,8 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
diff --git i/builtin/mailinfo.c w/builtin/mailinfo.c
index d883ccf459..aed1199710 100644
--- i/builtin/mailinfo.c
+++ w/builtin/mailinfo.c
@@ -2,6 +2,8 @@
  * Another stupid program, this one parsing the headers of an
  * email to figure out authorship and subject
  */
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "abspath.h"
 #include "environment.h"
