Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239E21DF75B
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488838; cv=none; b=U5yeBQZPUAiQwZY0qBdZt1rJBqc+myI0iM1zgi6NOmlu4uHJK9zMAPzSBGFk+w0Ouf2e/KYD+YwpevZnsQaJqwqNFHde7xqvJzT5/X5jnD3gZg/fk7xP2UPJqdEN3EE6Ql+fZH6fW71YtF730tb6vkc+breyEh57AnK3U4tMTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488838; c=relaxed/simple;
	bh=XVdiPKz8YEhLF1lq62Shor49vYlv8JAWf8i6UvwV/Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gDmWmozUvB0jsJBKI7n5s3oo5szONi1jjOnZWeaOjJF6Wh4xrFWBEbDTV6dGwV5QnfV7zkRd8ZlVZCPNnyb5cPtroOHNnHcvVr3G4RYsoKAZH/6zfuNcP+D6+YbmPHPscgqNsNK6UhOxRTbESyD26oGeLnHncDR0vrAAICJHHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=L1uEz/JO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pFxNYJZm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="L1uEz/JO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pFxNYJZm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 43E58EC0176;
	Fri, 31 Jul 2026 05:07:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 31 Jul 2026 05:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1785488835; x=1785575235; bh=jL
	zzrZ9Csp3SCCAGYV8Uhb8Oa9/g+auNQCYyPV0mMUM=; b=L1uEz/JOWhyrfPfQIY
	+tRaocq5/Ww+XV4PQ/nFOFI78Ds1VjarFBhcWDp2ynEvT/E9wDW9L560AAxTJX22
	NJFwueOGoyyazdUGi9GMcteC3dkL/4PeFqqZKyZQWR3aDJzY1oN8jjiNpT/ahDO4
	Ys9NmKtCiY0Ek2g5fs2QaqfqWUkUz9SL4UJPOS697JMLNJffS6U5WxT40oW1E5AW
	WgGiF0SwwFGPzExWFyG6nAGiTBoSkfF6bhfXRv8Jd9peiOArEGrEwEEa0havA2wG
	EBh9fbBr8XoW81qQfAnjwleLb03WvOnuRTXlDzgDi897G2puUIyILzJQXzBImr88
	xyDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1785488835; x=1785575235; bh=jLzzrZ9Csp3SCCAGYV8Uhb8Oa9/g
	+auNQCYyPV0mMUM=; b=pFxNYJZmEo5UKbUQG3Z9yPTAFBrFMr1V/3OMVJ2MoTL3
	j7ZT9ISz4oa5Y5ipngA5/yFmFqFyse4QcJosaYo8RCuHoK/zFIQY84NfoUOYlhf2
	6fz8iifzfCg/sheD3EMJ5vxY806xEMoB0wQs3IGAWTiN+jNg1rqSNODbL4TFRgV/
	vslG0b0PM6aQU43ukx57VmZ1tOXLOZeHXS2GqBvs5NKMdtZDJXD3EpBY/C63gX6l
	EGVaYQV9Uiboaq6L4KrN1BwnEH5YF31Rcd3nQx/ozQnhfyJ7EMp4HdWtc7UrqhGf
	+e6AJ1bPhbsjDJ10lnATyG/BGHRAlBq8CxjDdhdPPw==
X-ME-Sender: <xms:wmVsaoGmelU_1uRegwbJ6EcMMe20VTkxhI9HZcqMonv9RKCMU4mSV_4>
    <xme:wmVsaoWL61bqpqZH8GNvvrGWdVAJJL4BcpDArwqse25O_51VSWXdIoSvy4LiZqXRy
    sujbO09wGI50nLaZCXMF5ZE12XmxCjPw1gHVMbGZdyRiTLVNxWd5Q>
X-ME-Received: <xmr:wmVsanLzKQTHIwo8jaDbh4y77jLKSQfUEA_tcV0k10BkUQEbDLKo5BbQ_jGBaNLLym1w0lbdz_ycYT1ZxJDg2Z56PZqgGFPZOP65C3xXYtmL_v6XagJHC5w>
X-ME-Proxy-Cause: dmFkZTEtiNSnNgkGsPwXJbuGW/BJTgy6kIXoNc+0sEV2ez3CAiFa+rsIbSLuS8kq2TSsd2
    FgFoLoT9jpRKrv8yUi7SgzgatpOclhm1NSICIWJhuSejveTLkWWjga9PnHXtiNT8laOhAj
    GpllkrYjufnuK6xFImdlqWdiA1zqHu0nWY4bB9DHiZ8gMX2webxuIwijIxzxDq11U+7zea
    38UE6X/aJCdHakC9JE1FZXt9nR7caDFcl9H4Fvx/tS3VzF/KHPeb0m//lZ+pZEvTEcLlDe
    1MEIOURznZX4JrUhXM1F0Pfb+L4N/A5AgHeA/iutWzbEJSJtmTu7SOVokGRjsbLyaE9Us+
    jDJFuAc4dSlfboe/WxMQG9RGCsZyf8uoVct/qVa3t4Cuwk+RM7e6Uvjl/F3Se/YfSBsdZR
    nREthOJ13W2B9eFQZMQpxGKJ+MYyYGxlGlQXRSW4WNkfS5PnFkN1hK3ALrufqx3FqB0wmy
    fW6kYn885P+VXSIwCQad1s0fM3yV5VvlS+fX3igB1NvcWefwf6TkBHb85vObKnrR/+hPUe
    pTivzRwn+Y29iMaDvZwOLQToEIG9x8XWYObSzRsuYJDvGuVND2hBsriH66NLW7CZrOom5y
    i+YJpahlF2MIJFSVn2yw72BYD1qM1XExUEiEAbnccpbE7zhcFDfBX6MLJ5PA
X-ME-Proxy: <xmx:wmVsao8hzZgBook9tJZB5CiNHiQObCCJvsTMfRmMW0iLpLzK_3rICA>
    <xmx:wmVsaqL5kvp47nqIi4-7qqc4nkYD-RYAityJSTAyBfGDjzGq41dw8A>
    <xmx:wmVsatkjyqhoOpHppjhNYVBBfLuOyUeCwxBJnR5MH3KQ-dYNN_AKPg>
    <xmx:wmVsauNMPTxtzz8r7aqqWdPV4UNEiE1sBeX25FIH1OFy6H2717loQQ>
    <xmx:w2Vsaiocw7yc4UCbPnxVgFL2J8MC4Qvq_yxmbJq_yUwhhHmFqL7-ebb9>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 05:07:13 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] doc: refs: put ref migration warning under the command
Date: Fri, 31 Jul 2026 11:07:01 +0200
Message-ID: <CV_git_ref_migration_warning.b09@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: doc-refs-migrate-limitations

Topic summary: Put ref migration warning as an admonition under the command
so that it is visible.

That’s the first patch. The second patch adds a missing `linkgit` since it
touches that same warning text.

I have two other patches that are not included here. They are unrelated
cleanups that I will post later. Here are the commit subjects and the first
paragraph so that you can see what they are about:

• doc: refs: wrap standalone placeholders in underscores

  This is a synopsis manpage which means that standalone placeholders[1]
  are supposed to use underscores (_), not backticks (`).[2]
• doc: refs: use inline-verbatim throughout

  Use inline-verbatim backticks (`) for literal commands, options, and
  subcommands listed under the “Commands” section.

§ Cc list

The two people that I have the impression that have worked most on
this command.

[1/2] doc: refs: put ref migration warning under the command
[2/2] doc: refs: linkgit to git-maintenance(1)

 Documentation/git-refs.adoc | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)


base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
-- 
2.54.0.22.g9e26862b904

