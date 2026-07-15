Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73CD1FECCD
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 04:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090481; cv=none; b=VKXkcrfoKatq7StjP8XIZ4PNaS0MqZHhRoY7gIfAgTJ5MSE5LbxacEeOSzCl57fCKzwd3FgGpJOQ2FwDgOW34MUoLpr2oLq2xU7J33fAiYcsLsPACSTTcyNGy20TQYoOYfcVXrd8LjUfHOhNhxftO0Y9wX7m30UJdV8bgyNdZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090481; c=relaxed/simple;
	bh=4VOvwlzqdMC3tEmzGMI2X2VcKFRrrqDHHbrQv0bAYvQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=B3+hnXiv7Nr4OMGXYCbpqdsAQGaXhEou5yAJBRK2dBVWq3tIzB/B1F3dvlwXe61NVNYgDxGD2a/0hlv6s58ew6bkQFX5cs9ZjhetYPsDByuYXqxrVQ5zkOt5tpXwuZyxSnaWyLujnwY8P/PLh8aH1rAif/x/62XQaBJYWTRBYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Zrgso/og; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Zrgso/og"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784090477; x=1784695277; i=l.s.r@web.de;
	bh=zq4ELezxDfgUFD35QE6l9NaU84qxfTTB1zhJd7Lx6Zg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zrgso/oguirhaB729A6NjO7+tqm0I44HBmVABAJPwJSTjUR/5bwd+01QuYHBxYzV
	 5Oe/B6SxT7x39sfPQP88W4xUGJUM9h4vM8oiiPHKJ+tUhW09SdgDWS5ynITsS51h/
	 BE+Ye4ItfGLRmO2qkuAmPHBojHQtEI1luvAPgN3Sb1Yu1jLewOW+kNpkbz7mvqXgl
	 LXFfbDynqq0HtBxElSO/i7s569MWp+WeH5DwPaTB7GfKQSXkOH6MVnxfee8BUqV0r
	 ogTolOQWvBQFTAYgR+qCgJARGccCID5RysjUAjbaWyva6DbIS0GL65MpYfy5M/kBi
	 solgmAz70V28BaxP2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0ZsE-1wwBBp2NMq-00vKuk for
 <git@vger.kernel.org>; Wed, 15 Jul 2026 06:41:17 +0200
Message-ID: <935883f3-3be4-4c51-9711-5208b9ef9ca1@web.de>
Date: Wed, 15 Jul 2026 06:41:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git List <git@vger.kernel.org>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] remote-curl: simplify passing of push specs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rAydQDc40AgWG8AecJhvW0mzskdOdmz4ak4Hx8ykqJjbm6TRYZ3
 r0dKbAQKiYbMW8qxhwtBJSkGywmVBfYjUHz1/acmZFsA00WXcfWIEcHDRmvs0tOn3jl8+Vj
 hXhaIAtkt6LWZBaV6CfQYZmPP1Vf/Nh9lZaScjnnyotSuWeug9WOSAJSeQhTc5DVa454N8A
 7O8k0Y9WVTELvfcskxXnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZJQdtw9T16g=;6EzI1u1g21H52loQo/CGhQ2SFdf
 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
 5DSfIUfcc=

The push specs are kept in a strvec, whose array is NULL-terminated.
Pass only that to the protocol handlers, which avoids dealing with item
counts and their conversions from size_t to int, slightly simplifying
the code.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 remote-curl.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 9e614c5567..2c35dd5240 100644
=2D-- a/remote-curl.c
+++ b/remote-curl.c
@@ -1340,10 +1340,9 @@ static void parse_get(const char *arg)
 	fflush(stdout);
 }
=20
-static int push_dav(int nr_spec, const char **specs)
+static int push_dav(const char **specs)
 {
 	struct child_process child =3D CHILD_PROCESS_INIT;
-	size_t i;
=20
 	child.git_cmd =3D 1;
 	strvec_push(&child.args, "http-push");
@@ -1353,15 +1352,14 @@ static int push_dav(int nr_spec, const char **spec=
s)
 	if (options.verbosity > 1)
 		strvec_push(&child.args, "--verbose");
 	strvec_push(&child.args, url.buf);
-	for (i =3D 0; i < nr_spec; i++)
-		strvec_push(&child.args, specs[i]);
+	strvec_pushv(&child.args, specs);
=20
 	if (run_command(&child))
 		die(_("git-http-push failed"));
 	return 0;
 }
=20
-static int push_git(struct discovery *heads, int nr_spec, const char **sp=
ecs)
+static int push_git(struct discovery *heads, const char **specs)
 {
 	struct rpc_state rpc =3D RPC_STATE_INIT;
 	int i, err;
@@ -1400,8 +1398,8 @@ static int push_git(struct discovery *heads, int nr_=
spec, const char **specs)
 		strvec_push(&args, "--force-if-includes");
=20
 	strvec_push(&args, "--stdin");
-	for (i =3D 0; i < nr_spec; i++)
-		packet_buf_write(&preamble, "%s\n", specs[i]);
+	for (; *specs; specs++)
+		packet_buf_write(&preamble, "%s\n", *specs);
 	packet_buf_flush(&preamble);
=20
 	memset(&rpc, 0, sizeof(rpc));
@@ -1416,15 +1414,15 @@ static int push_git(struct discovery *heads, int n=
r_spec, const char **specs)
 	return err;
 }
=20
-static int push(int nr_spec, const char **specs)
+static int push(const char **specs)
 {
 	struct discovery *heads =3D discover_refs("git-receive-pack", 1);
 	int ret;
=20
 	if (heads->proto_git)
-		ret =3D push_git(heads, nr_spec, specs);
+		ret =3D push_git(heads, specs);
 	else
-		ret =3D push_dav(nr_spec, specs);
+		ret =3D push_dav(specs);
 	free_discovery(heads);
 	return ret;
 }
@@ -1448,7 +1446,7 @@ static void parse_push(struct strbuf *buf)
 			break;
 	} while (1);
=20
-	ret =3D push(specs.nr, specs.v);
+	ret =3D push(specs.v);
 	printf("\n");
 	fflush(stdout);
=20
=2D-=20
2.55.0
