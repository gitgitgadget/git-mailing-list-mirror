Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9531EB5E1
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771799017; cv=none; b=aYRJxqjhbW6O7wlIr11zqruZBpq/jJbXZFtk4H9HDD1yOcMa5/kLkxMkBG2Q7RLfySXJDMpYeZJCHawCaFHPFRfQsNE1pwRlHKPsaHGpu2RFmQ7IsUacTa9HHxZ91pR2Y9cMiDBpPYyWIcI9e8w7Vskx05DbgOC6TL8YesUaI2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771799017; c=relaxed/simple;
	bh=gL+ZyemnqzWk1MeI8ncmzwk9BS8XcB/B5RSnSHp15+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dWg9KXh4d7MUYIF3p60IqY53y8Nh4SO+LCfx75lewGwlvgzv+Ui0KRCQ/EH2nv8ooYxWvMBBTHr4mCCY2/9DvbNVOMZYTfNWnITN35X1Tz6JlNnpKnatXbNwAnkgAlcojHzL5XLaYCrl/8vmFCJSNfA/V1VbevlB1Zc1yvcG+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pFN87oxg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTzvCLrh; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pFN87oxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTzvCLrh"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F20671D000AB;
	Sun, 22 Feb 2026 17:23:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 22 Feb 2026 17:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771799014; x=1771885414; bh=bZOobqZrAu
	WxsFRO6vS5irw0eRyg5T3F0j4zaSyQJHQ=; b=pFN87oxglA7TUfOyhYpr0HtvAk
	H/lrl28Knynbohc+8wyXJtt+Pgbv2wlOGvzJae9RTPe4IIFNpK8KAdiLlGZ5mAHX
	eHFHrOiO/BQ4CdEFL6q0JfZs6teYiqTpX0JvAXk3ofBlpb1wiczC00HBNSI9imBF
	P+FdXyRP9xqkH3FNiLj7n7tvdnCYgntFM5l26L7XBEiKW0T9SRDyxUyyMShkGv4O
	v3HM20MOux6mLiq5cCisjdvvSEkpZymOpCJkUGJXM2f3LykXzKeeb07pE+Igo6uT
	wUZCZqN44hwBMtVmJ79ANa63cLpGeuG+bUNulGk1Qu0A78+iSM9sEYSRp0Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771799014; x=1771885414; bh=bZOobqZrAuWxsFRO6vS5irw0eRyg5T3F0j4
	zaSyQJHQ=; b=jTzvCLrhUtVnFjcIRAZHxmsVbW1SUwf60dHopAoCf6cT6YiSTbj
	Vte0Z5kVWS7bcb169m1hTWmt9zOVas2tQ35mzgCbXlW0x6YtNO62goXGT7b6IZgk
	WN+flA+LtUL/tvoRBqOzl11alXQEY8ehMos+btPQla6MNjAxvTukIs5jPxf4Q5E+
	Xn47liJe8I+M4oe9ilCX0rwYtoNzHh5+0/Jd4v28/B1yuu4dkzuUbk3QNeHzW5PV
	Fu+6J/2t8MKqmWidi4ANbZlNBsUXMN6ucOOfOfwPxRIQgmTEHQuTgpo35ieuum1P
	JM0zg5it2fTKq5TSDN902mWMy0kpHwdkJ3A==
X-ME-Sender: <xms:5oGbaRk4kgzMGnD77t6eeJnoS_n7nAHaATilSPEEL1zIgrhFcSHV6g>
    <xme:5oGbaURQhs-0eOqen1wOSypKOB1u3iJlEWDxRnpCYIsg-PxtyLBRxXOzez-e9eb76
    3ONEs5q4MveTnrgywNsBeJkBkxvJdbub4OLlwofRXO_GxfdA7Pe>
X-ME-Received: <xmr:5oGbaVBNezNN9UCFFLy58LVzSTtg2mDtjfK6O7SzX_7gEaBL2sToYCcOl1acSyEFD32yW9gg-Sa6ephfY0wZfS9y56mL0YAeBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5oGbabROgEE6bIKPFNb5vGBy_rC6mKV6vi3DknegT8HYzPRsJnA7_w>
    <xmx:5oGbaTq2qDqqqNrkerJX-46aL9WXffKYadTxplltCBHzOsMbQomNJg>
    <xmx:5oGbadwzl-HCcblegocCKcECSTFyIWSJ9xCsfLGVzl3AeoyBQBgIaQ>
    <xmx:5oGbaYLGm-quEorON8ppgUpeSi1Ehtvdn2ArjhJvkCEu90vcLZbUVA>
    <xmx:5oGbaYR33WfvpPOlwhWYcT05JubuBMII1vidQQfb3UOrt2VDC3yo9g2b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 17:23:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
In-Reply-To: <20260222102928.377519-1-a3205153416@gmail.com> (Tian Yuchen's
	message of "Sun, 22 Feb 2026 18:29:28 +0800")
References: <20260221083001.220061-1-a3205153416@gmail.com>
	<20260222102928.377519-1-a3205153416@gmail.com>
Date: Sun, 22 Feb 2026 14:23:32 -0800
Message-ID: <xmqq4in8quxn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> 'read_gitfile_gently()' treats any non-regular file as
> 'READ_GITFILE_ERR_NOT_A_FILE' and fails to discern between 'ENOENT'
> and other stat failures. This flawed error reporting is noted by two
> 'NEEDSWORK' comments.
>
> Address these comments by introducing two new error codes:
> 'READ_GITFILE_ERR_STAT_ENOENT' and 'READ_GITFILE_ERR_IS_A_DIR'.
>
> To preserve the original intent of the setup process:
> 1. Update 'read_gitfile_error_die()' to treat 'IS_A_DIR' as a no-op
>    (like 'ENOENT'), while still calling 'die()' on true 'NOT_A_FILE'
>    errors.
> 2. Unconditionally pass '&error_code' to 'read_gitfile_gently()'. This
>    eliminates an uninitialized variable hazard that occurred when
>    'die_on_error' was true and 'NULL' was passed.
> 3. Only invoke 'is_git_directory()' when we explicitly receive
>    'READ_GITFILE_ERR_IS_A_DIR', avoiding redundant filesystem checks.
> 4. Correctly return 'GIT_DIR_INVALID_GITFILE' on unrecognized errors
>    when 'die_on_error' is false.
>
> Additionally, audit external callers of 'read_gitfile_gently()' in
> 'submodule.c' and 'worktree.c' to accommodate the refined error codes.
>
> Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
> ---
>  setup.c                       | 42 ++++++++++++++------
>  setup.h                       |  2 +
>  submodule.c                   |  2 +-
>  t/meson.build                 |  1 +
>  t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
>  worktree.c                    |  6 ++-
>  6 files changed, 110 insertions(+), 15 deletions(-)
>  create mode 100755 t/t0009-git-dir-validation.sh

We'd probably need to treat ENOTDIR the same way as ENOENT to deal
with cases where we expect a directory "sm1" to be the root of a
submodule working tree, and we have a modification that removes the
submodule directory and replace it with a regular file "sm1".  In
the code path touched by this patch in submodule.c, we would ask "is
sm1/.git a git directory?" and the stat(2) call on that path in
read_gitfile_gently() used to say "Ah, a failure, that means we
cannot positively say that 'sm1/.git' is a git directory or a gitdir
file."  Now we inspect the error code in an attempt to tell if it is
a system failure (e.g., a corrupt filesystem), but catching only
ENOENT is probably a bit too tight.  In the above scenario, asking
about 'sm1/.git' when 'sm1' is a regular file will not result in
ENOENT but in ENOTDIR (i.e., "the leading 'sm1' is not a directory so
it makes no sense to ask about 'sm1/.git'").

Is it always sensible to treat ENOTDIR and ENOENT as two equivalent
errors for the purpose of read_gitfile_gently()?  I have no clear
answer offhand myself.  This is part of what we need to think about
and resolve while addressing the original "NEEDSWORK:" comment.

