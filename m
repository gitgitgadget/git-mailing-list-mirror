Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8535245A2AE
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766526; cv=none; b=CrDzAEJ4BHTPvr/n7LVi8A4cMtHgMLW3W3kuoGLU1mrunO2Stm7fThWG4cpppr1g5yUr69zm6R1tOlKCnigLj6rPJuvA06awzVTRlg/U2borAVT6UsdqhmXSOm94zvEq3kG6ZhI4lsmrvgtzmthvcc+VPRA7ddvqltTk4ReYvOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766526; c=relaxed/simple;
	bh=HvwfX9v5ilByCmWE/ehPxeI2Q24f80yeI6s2UlY+owY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PUS6Eoq7Edq7Zu3gwTL7EZby2ejrAgzSDukwBjkgqrylLN3qMWRTMXptFQIChPsi/MAyj1DY37Cg/4rfkv3MqaAuNIlDXnEf0cmenfAwkwjizBt4VFLeDkl9HfXEkvOjlZsODFq8r6pN73G97HWo3e1B4tXMXoNo+/6nJ+JYBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F22tzjhK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QN2GHlsp; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F22tzjhK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QN2GHlsp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 076AA1D0009D;
	Wed, 26 Aug 2026 13:48:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 26 Aug 2026 13:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787766510; x=1787852910; bh=WJIjoBIk4E
	6MEZ2BA5afgVD3XozrzvIULX+ysR7eRhc=; b=F22tzjhK5HyRVh7LmdKifSkTl5
	UlvobP+WtGUPij332qo40/NOzkAYZ1V2A1nE4/L4Ez89O3PZ5VJ4uv2Kna7gHo2E
	EDoBZgMqviAntlLi0qM0XjeA2DjTGFSr2f9UFYikfEygwiuMvfvxJb/Lq2AXwJGI
	Azvim3eRJWQDj7r9pnJjr0AdNlkH7zS/lA3udGUmn+DbUUzk1Plq3ZZa8+jMWzrl
	3F1Sq+S+QbR4mbAJwNsrOyd5ZKXuHp5Q8KWnxqdHuNWNVriqsB9E99y23JDWx6K/
	UNoNIoCd2GU5yZAEAEeyyojZWOgtupmiTka/4+6tCFtw9+tmDydTd3ZXB48g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787766510; x=1787852910; bh=WJIjoBIk4E6MEZ2BA5afgVD3XozrzvIULX+
	ysR7eRhc=; b=QN2GHlspMFk6DCiw19sM7yzSSUCrohpKfk0E6kt3Bim0Rz8IY2Z
	FIV4/trZ8RBNKBZR+Dwxlc6dzJlOdmxeNAJnodSgeMOW8eLN6XXDTIm4TmZKY8lG
	hnmrG8aGF/jnZXN6VEvR8IYXCZfqV16xlvCc6fKknJ4vacsUgVfo3zKGUuqN+anO
	2rmBC2zz4nlboLpWERJgW93n9c7vj8HgYhVaEFXtgKR+6dz4MfnNLD91fCfCECMm
	SIVHGzdLtDsbPAWLuoR7RVNzKFWnh2B0aKCG2UuCm1c1TYFO7SFf8wl5ckG8UWHS
	VDl5PKm269SwS4Liro8q4MzrJlFOJmrl0EQ==
X-ME-Sender: <xms:7iaPaoyjfHIIcPX2wYFVOubSLJ6mKjbsrg2gSKlzprmPQcvDehs7Qw>
    <xme:7iaPaiQKpb-yo627Po4VfFs3-hwzkfa1kvrHIOmXyAAW4paxZjozx6LzCGbhmAOI2
    x6lHBUT7FCi1s-1qo5HXP0ks0D0gzecl795RmfOIc_QTEMlzxn7aw>
X-ME-Received: <xmr:7iaPan-f2qU42KHLxQedxSfnpnFXOJ9uxCNnBP5HateYc3FNir_CuY4bZeQvmWM9VBPLljwo8SuVW80r0KZPG8t4jTrPq8dy_A>
X-ME-Proxy-Cause: dmFkZTEplDaeLZeoaImNJAL7F2Mu5QPa7qQQbkzIzRLrnssNfQ1yuQRj8IN8fXgDbKtvh7
    KLHNuZWO2c3foh2+x67MN5Op/eH52xCCv6zIULWEaS/dRX/ZXzMEKWXuRusSyBhTc09/9G
    FGoU+yVcy8v8vVGZUOcLjsENol1AZJHjvGJbwsv01ct1Wi0D9VS/REJ3VXfK5IxSTLpe+Y
    7+XVAmwCjCG7S17og8IDHEWTtbUVdOZzb7rpW20ExcvhJuTqwuWVvscoUGouUT9Vr+aCcq
    nR5mMMEKs60bLAa8parS0wuJbX+fw3CAZPa74gVEY6Su1tCkYY61buba39jqkOzU1cRAq6
    q8TEVMTYr39yHFkb8Q8z2ch80xbwJc5u0Nh4rc9Lskd2AReaedASTHD72qMwIBJKFtLwX4
    ooZTv7rJ5kgvScB3x85b3g9vGPcveFCMtCLvCnzQGHn8VXYh+WQGQ+Y6Iohjfblt8BSVaH
    /Ue0QCXsNu1a3gd7q/np7ViXTLzdlbweYcr579inKiyyaFj2cF3AT0UmmUeWlxk1RpC08p
    8Dj3LcKwYDv6/ZHdsuqVdYIYt0tPMLJIChtN+8xOPLl8l00bbcuU7HZFNAtuUfKU8lZUo3
    FwTEUPjzSy7VccM7gZiSbGjjSLgFMxKXw9umB2tfwJ88SWGJRzh230i/SMPg
X-ME-Proxy: <xmx:7iaPahpMUFyye4m7FFPTaxxKUISM1uecvOTOYBtcWLzn1Gu_X3Tp3A>
    <xmx:7iaPaslAThCsosFMygfIH8rzJU0UkvXgCdiRvV17xwLocew9SjFcBQ>
    <xmx:7iaPagIXauRAbvvg41jd2tow7wDcyH7f0mXF3o6U51bEnKHNerCr7A>
    <xmx:7iaPapxKRF9wuKNikpKAG5P4toxBqwq1M8RDjcWxvvF0XmlQAuEuVA>
    <xmx:7iaPasJnhvTAWFXpFdnxOp7Cj76sBZQC5Oh2WeIbH2O3iUQ-edRgbsT4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 13:48:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2] you_still_use_that(): reword the instructions
In-Reply-To: <xmqqo6epj6is.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Aug 2026 07:33:31 -0700")
References: <xmqqo6epj6is.fsf@gitster.g>
Date: Wed, 26 Aug 2026 10:48:29 -0700
Message-ID: <xmqqjypchixe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The message is overly long and may mislead readers into thinking
there is recourse other than adopting the new workflow.  Clarify
that the message is there merely to help them find a replacement
workflow, and is not offering to reconsider a decision that has
already taken effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 usage.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git c/usage.c w/usage.c
index 3f0118ab2a..365c0bcb90 100644
--- c/usage.c
+++ w/usage.c
@@ -386,21 +386,19 @@ NORETURN void you_still_use_that(const char *command_name, const char *hint)
 				 STRBUF_ENCODE_SLASH);
 
 	fprintf(stderr,
-		_("'%s' is nominated for removal.\n"), command_name);
+		_("'%s' will be removed soon.\n"), command_name);
 
 	if (hint)
 		fputs(hint, stderr);
 
 	fprintf(stderr,
-		_("If you still use this command, here's what you can do:\n"
+		_("If you need a replacement:\n"
 		  "\n"
-		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
-		  "- check if anyone has discussed this on the mailing\n"
-		  "  list and if they came up with something that can\n"
-		  "  help you: https://lore.kernel.org/git/?q=%s\n"
-		  "- send an email to <git@vger.kernel.org> to let us\n"
-		  "  know that you still use this command and were unable\n"
-		  "  to determine a suitable replacement\n"
+		  "- Read https://git-scm.com/docs/BreakingChanges.html.\n\n"
+		  "- Check what others on the mailing suggest as a replacement:\n"
+		  "  https://lore.kernel.org/git/?q=%s\n\n"
+		  "- Send an email to <git@vger.kernel.org> asking for help, only if\n"
+		  "  suggestions by others do not work for you.\n"
 		  "\n"),
 		percent_encoded.buf);
 	strbuf_release(&percent_encoded);
