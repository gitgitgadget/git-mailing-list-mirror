Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84B725179A
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468902; cv=none; b=DEQCrKfLtloIocTadrmaDr9iYPXqYsI9vG8pJblwlnsWBjnshrlmTFDJYkUKzDbKHxdqkqssKEQ8KQCsXDM4jx+xcPFVUGxc9kjO2Y6lmWSuZMQD7IRljuBF9TZkzhKLkDxCuODcs7T1eD/Hc2WrUQ9TyQpEYOwX3ssa5ohM22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468902; c=relaxed/simple;
	bh=4uuRHw1nrjcXHkSN6edBk+KpQs0xeiQYBdxbPZuArMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=QgwhLHdz4J5uJaw30MpXYzzFQQToYS3B0AqSdJTO8BIDupH53KPZvEHYyk4ebGSXrTLR4J2cagep8DRjbU4S2tH3+ZSQGS6qrUDxU3mlI9JOFKQVjiu7sWkOukQkSdwcxMqmWHD1tv7vqhUzNHFzYccU3RgKL3EJNf8Ee+9XKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Q0Ehc/1Q; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Q0Ehc/1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753468886; x=1754073686; i=l.s.r@web.de;
	bh=c9TEUt4ca3WBK0GHS1ceYNKk3LBXexY12UHQwvGjY9c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Q0Ehc/1QtNFivLit4srhZhQLgDft+DVsfVSq1yFPVzsw/0NkP7S5EVLOHyXhkEQT
	 3o0hdaojI/6s0pmEKUxD+YmnjlsIwAX2JGfbl+mBo0U587GFoAqgyG5aM2o0/o232
	 zM1UDTtSTbrSJApEhcfR2+ueKeFSPWbkuhRZYppW4Agf8wn7dwknlGnKu9BVqgYvc
	 cNySLob4l6hFTcjgFd/xi7u5Uy1OOxwA/LWV/GZPitwz+FjT1Vy8XfWQtwp/VVohQ
	 OwfCvLEe/lkHiBtip/DJxTT9QIF6aFBpYTTpRVlQLp/IQncwgVk63L/r0ncWP5o3D
	 WapETMX1cBXSdEczgA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.28.103]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1uURg22kc3-018E3x; Fri, 25
 Jul 2025 20:41:25 +0200
Message-ID: <a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
Date: Fri, 25 Jul 2025 20:41:24 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] git: show alias info only with lone -h
To: Kevin Brodsky <kevin.brodsky@arm.com>, git@vger.kernel.org
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
Content-Language: en-US
Cc: Jeff King <peff@peff.net>, Rasmus Villemoes <ravi@prevas.dk>,
 Junio C Hamano <gitster@pobox.com>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XjlgZAhea4y8+pP1jDudsABO4pMCIlDnQbolz2Z4tFAlLcmIKNE
 vUhwdohW/p/MxELT6sub1ou+dvxsnQg57nf9jfCOsFGmmmPbyi1ROrUa66OtlSqSdlKiQms
 bjIdQiY2eIYIsmGtuYI2QnWRUiGd8ExQCIZUpSF1YfOWkTje1Rfjst3jtN0tQPjSM6sbH/u
 dPH7Bad/slv25E8RC1PfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KCawsz7idfc=;XHy1T6VIf/0BSrukl4m5fY9q3qt
 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
 A4tjiwleThw==

Builtin commands show usage information on stdout if called with -h as
their only option, usage.c::show_usage_if_asked() makes sure of that.

Aliases show alias information on stderr if called with -h as the first
option since a9a60b94cc (git.c: handle_alias: prepend alias info when
first argument is -h, 2018-10-09).  This is surprising when using
aliases for commands that take -h as a normal argument among others,
like git grep.

Tighten the condition and show the alias information only if -h is the
only option given, to be consistent with builtins.

It's probably still is a good idea to write to stderr, as an alias
command doesn't have to be a builtin and could instead produce output
with just -h that might be spoiled by an extra alias info line.

Reported-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 07a5fe39fb..83eac0aeab 100644
=2D-- a/git.c
+++ b/git.c
@@ -371,7 +371,7 @@ static int handle_alias(struct strvec *args)
 	alias_command =3D args->v[0];
 	alias_string =3D alias_lookup(alias_command);
 	if (alias_string) {
-		if (args->nr > 1 && !strcmp(args->v[1], "-h"))
+		if (args->nr =3D=3D 2 && !strcmp(args->v[1], "-h"))
 			fprintf_ln(stderr, _("'%s' is aliased to '%s'"),
 				   alias_command, alias_string);
 		if (alias_string[0] =3D=3D '!') {
=2D-=20
2.50.1
