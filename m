Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575433C870E
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956592; cv=none; b=GxmiIA6AA9W4Ob8WTCQV8ddcb/fClKajwSYLx5v4cjayAGfH0GbHs7+G6mG/iA8uWoe0AYrJ8LiJZBQWTu63797mNT7ouUMHhjuZ7zH5RbXHC1hpunWq2CjMCvCZhP0WcGHPslYm5fIjAjT+4+VU+4UCOQaW3BwEpGYkqk8jxug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956592; c=relaxed/simple;
	bh=DpF5Rt+puuh5s4DWM6M0Uei3TNoz95HxOmTFgtnTnGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMX68qOi1/K1veihsezimSmewZEti4PYRv9PglqdhY7PRADdsABxd1jOicjKqLN/z/s2Ppa2FK0pLBv8YTWQlyXjIm5kOtSzHeNYFDQqbVDmTxn7KXb+5k1lETaxdKJbwheHnNFQcVm2QFbx7bxGwGDFjki7o2KhF3OCwVqn7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TOl4QbPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d9yEdyfp; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TOl4QbPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d9yEdyfp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BF35F7A0070;
	Wed,  5 Aug 2026 15:03:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 15:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785956583;
	 x=1786042983; bh=+3Fxi57/BOvGfH7oHcPc6HSgB3QW+yOBNZ71YMg9TRU=; b=
	TOl4QbPJQ5tcqWMCTWkmhELjaJXsyi0CyHMGfwYfQeJA9XQHv7WUkRLaVHoFACmY
	Bn/Ca544r1WrJD1jtUJcZFPCTtI+q5Ip4S1a0UojAdqNxlxA94fSZPll9cm+FFWG
	rNct1fgxeD7HLUA7ZUVw8Yo9PGopUf5Tyvjq/9zbQOy5ohpNoKmMYQqmrsIhuQ3/
	jtCNhD8YB0J/QwUDuQxcz1jGGV10mc33h6rxfeRm6Ux0EKBKtHIWYCagkIvvJ9wu
	DPWxjmsjVHqremphPE/AMKXaFHlFBjCD9P+BJkC6FMUZquuLONZEKMPpSrBc1gN5
	tOtDiI2DPj/Oc34n4d70ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785956583; x=
	1786042983; bh=+3Fxi57/BOvGfH7oHcPc6HSgB3QW+yOBNZ71YMg9TRU=; b=d
	9yEdyfpHlJEwo6JHU0snGzOCOcZkElKeEyW7LyQPcltl3dM4CZ7MG7XV+6dVaBxB
	MwTwpAWAEZ0vUWJ2Yq3Ji2NvLuhKe/dXBBbDct/4dtmmIQRg84yrzWF+R94hK5an
	D4neKpUcj194U0pRCcnlLHZYtfzYAV89Eo+44ry3IAEmK9mAdTzgPL9aqNixo4dV
	i1kEvDWUoBNzi7iQW1A+PK+dcOhAtz3kIHNNJkrMPpOueMq441E45YCn4MbD5vxU
	9bHj4uwBGfA52F3n77bKmzDwv4fgUd2FDY1EHoA+d2/Z03W6L1tSrmlsXBJ1zUaf
	04h+xQhwd84RrK4SEZdxw==
X-ME-Sender: <xms:54hzajTFlULZgUNy3pzIGrj3rzb_YeEsUUC6aYKSUrRmNxosH39UJWg>
    <xme:54hzarxvEDDBCdlxHi_kEK-f2grDbOOVSXBDmoYwaRjQyBbUmVTTgxu2OL3do1rqp
    CfAOdQo4XkkTtQtXHCW28tY8rOttMgmQWE2VznCHYnBaWzZY2FlSA>
X-ME-Received: <xmr:54hzat2InLK4yIckhSf1XugVCxCvctmLjg-ub79bptwMAW973yFrCiCWHoNNJducujHjBdhGF36OB0wh7FaFJJv4GEGESlhpWukZlQR3B6Q0c8xFoCDUEpU>
X-ME-Proxy-Cause: dmFkZTEfKT0/5nMtnr3adXnNklPXuVJO7ce/t1tFIYe8pOFluyLFYpzIsUqrEwhY5UdHN4
    5e8mzJrZTAsPwMn+WF/CxVZ+PcQjp30SfxZ1DMh8uNPnPNe8IbF7M5J+z/MasUdpcFtzwc
    liUop4yDgGRzzTkUoJAJeCVTA74mdzZ+ZtiVeBT/zzRKu4A+zLPObRzYMkFaK3y2BgDInr
    A0oW5vPVuQ9Qg37cNI+3GFCydzjYEFV5sl+x2QLJ0wDTgK/9HuyLHOoRGooQ4Sq68a5bdt
    BvsqbfhLVP1/jevMONXMkCpdZLSziUpzr2q55zfBz2qVPuwpiwQrE2GxK1bDO2sJeoLfXM
    viQ+EhaeumKGe288rfZ891fpCnUEmV5ErtZCpiISTZHqi6V0xvyZ6MOvtEdK560kWNUpod
    wNcoek8aWAcwaN1gLzu9oiBSfQQO97MUnyGCRDwQnBkuNBfipezgDkTWYRkOgHxUmk0oyb
    3aGTvIPV0ETWHWGzdVqITddVOK/g2ZAKpPNccmvWj9rYb0pH56EVZ5W95ubEnKJoPeiYoh
    5ztoOCHnSAm1jNE/1m+drvE6GAXQNs/nDFPq3e0RwrV8FvzGT1JmJULAttAo23rnkPAum+
    Dm/kB2WG1ctbbSZrNlMDyON/b7+GrMN2UB5yLAmrmkuTrhgIOwsx8WHiFgrw
X-ME-Proxy: <xmx:54hzah7ieFqcgt3_VyoIOpyboR6qBRE0rKg9szcr_qY6HPrceyeUug>
    <xmx:54hzaoVwiEVPfFU9gTRA0f8kIlnnUqDxOwzu_D5yEXth_pOZd-SjaQ>
    <xmx:54hzaoC0YY9t4Ip_mXXOlLGoDG435FEkQmaHB0dFG6cz-3CprBNZRg>
    <xmx:54hzav7tr8KcOZ1NqHgENLBsdIzEKxjzmSwGBYPcvCoaBZUZKljoHQ>
    <xmx:54hzalWF8w044jL03lc5ngiliDXCDNwU0QW4KmSRtStk6wr1NYOHwl8n>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 15:03:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] doc: refs: put ref migration warning under the command
Date: Wed,  5 Aug 2026 21:02:34 +0200
Message-ID: <V2_CV_git_ref_migration_warning.b20@msgid.xyz>
X-Mailer: git-send-email 2.54.0.22.g9e26862b904
In-Reply-To: <CV_git_ref_migration_warning.b09@msgid.xyz>
References: <CV_git_ref_migration_warning.b09@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): doc-refs-migrate-limitations

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

§ Changes in v2

• Patch 1/2: Use Warning admonition instead of Caution
• Patch 2/2: Add Ack

§ Link to v1

https://lore.kernel.org/git/CV_git_ref_migration_warning.b09@msgid.xyz/

[1/2] doc: refs: put ref migration warning under the command
[2/2] doc: refs: linkgit to git-maintenance(1)

 Documentation/git-refs.adoc | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 1ec26be0b4f..9063892651e 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -36,7 +36,7 @@ COMMANDS
 `migrate`::
 	Migrate ref store between different formats.
 +
-[CAUTION]
+[WARNING]
 --
 The ref format migration has several known limitations in its current form:
 
Range-diff against v1:
1:  cc4d9ca5006 ! 1:  8a6415e2d9b doc: refs: put ref migration warning under the command
    @@ Commit message
         `migrate` description in order to see the “known limitations” for
         it. This is important information since the text says that concurrent
         writes can lead to an inconsistent migrated state. Let’s move that text
    -    up to the command description and put it inside a Caution admonition.
    +    up to the command description and put it inside a Warning admonition.
     
         This section made sense when it was added in 25a0023f (builtin/refs:
         new command to migrate ref storage formats, 2024-06-06); `migrate` was
    @@ Documentation/git-refs.adoc: COMMANDS
      `migrate`::
      	Migrate ref store between different formats.
     ++
    -+[CAUTION]
    ++[WARNING]
     +--
     +The ref format migration has several known limitations in its current form:
     +
2:  7265de45c9d ! 2:  801a3d7f539 doc: refs: linkgit to git-maintenance(1)
    @@ Metadata
      ## Commit message ##
         doc: refs: linkgit to git-maintenance(1)
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-refs.adoc ##

base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
-- 
2.54.0.22.g9e26862b904

