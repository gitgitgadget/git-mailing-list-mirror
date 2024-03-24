Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A00A1756A
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711298405; cv=none; b=swBaEH+8jB+5zA3USQidfi80EMGZWHCpBkIY9CzGfTwecIJYcD4VP1ZY1VnXWjqr7VmiDrux0RkrnrczSyefRk/XMfZhoGmXEp5DSCv4gLYIlOiKg6tpj6KjIp/5iF9PKgI32qFwyBzH4/izqCJuwKZI3B2iwA/GwKEQfVV09kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711298405; c=relaxed/simple;
	bh=tO083GObKAGWv2QWqq6oPEZKjfQWq/oSdHWmO8dMH6M=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bJ9TlAuLtEcw/czr0NDy7adn7G8+9v7fgkYWEEN0dL7lB+6jLHU+CrKx+sUdqQbddU8/fqFrY0hU0q9CHjB4FaiSpHsG3M+dsPmvYw0Y6DiH9fL6TTaXyly0RJGUnA4eRd9IbfiKL/81Yb9/iUHOVeTqBgbOUTMld3UYX1nL7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=j4DC06Dd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="j4DC06Dd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1711298401; x=1711903201; i=l.s.r@web.de;
	bh=UQ/n0hyuSUYHrt8AwN1dbnZU/EBUQbNc59TL5AJLx9I=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=j4DC06Dd8RW5WT5JGInNH7dRObytpO+ptX+8kqdvdvdqkoVpDKX2VxM+zlS2ox7T
	 /gQyGaFm9WLBxk3c3SB3hX+gd+ww93nvFqKHptPq97S2HwNsUMtjPfZaz/YMWa3oL
	 GT0HTPv1jsRe+aL2p/Vok4h82ymJQRpWX23p2givYpSO8NPwSHqYqV6WQBBstBwpf
	 NqOx6YcfWUfM5oRbSa+QwwXZbocdlk1JJCFsLXWNgeJ6AAit7D269JKXw2+EdAvzg
	 wtppQt4xbdbXw438Uiim0YBs7JCPB470idZ6lfUd21D2WSeVh2qu6/jZRT6wvArYQ
	 TF9y/XrBwVZxK8iT9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.19.211]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2PdU-1rsHi23cR4-003usY for
 <git@vger.kernel.org>; Sun, 24 Mar 2024 17:40:00 +0100
Message-ID: <9483038c-9529-4243-9b9a-97254fac29c1@web.de>
Date: Sun, 24 Mar 2024 17:40:00 +0100
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
Subject: [PATCH] midx: use strvec_pushf() for pack-objects base name
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dBNq5kRzLGNycs1PRuy1L368SaT+2GXTo04dpvvAo5OBr+x+iY3
 2aoQEn1nuoTrkeErpDm9dcqzM6qmsFDYcrTy43pHkfMxYWHIktFfZBK4UhM9wl7b9QOPMlJ
 2UPmAT0UyfibrlMt1TEM37ey+WCCPTLpknCKkWxzQ/+HF4FbPCC6TBWMPN/loV9OS0pqf/Z
 JHFpvcFD+uG5zfowYGglg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iB9D54slgI0=;soMtPXGzsD3rgqt1nuesax6wNVQ
 kaJTrXeztGZ6nTTHNQc4vbXzpxQ+NBemw5d3gYm4h/OzkF3074jfyefAwUBw8F4qHJ/55zpf3
 9WW4hhjXpkmHJUP9gQpVSJL8Qu+YS3NCezdIAV3hoinebcGsplHKXBTgAtiz5SfzpEn++OV9o
 BbjnNLNHfT4mqtWFaEYmv2pD5refBUiFnvtoT9/3pWgybc2KjGZJTKf9jmvHufSREBOQjw6zl
 XXJAlG+ol4HkC8whc+/eb2LAjuQqgbWb5WLXIvLHGJ1xev31iKDbFT52LSilSevqKRrUDFpHQ
 xUL/towOAy3xsp7jYMflqKaavklUI/dxk2mM8/4bEomSCZDFTdHqA06sDM0mO6pzccxicoQJA
 DwhDH0/LaE5Q/f1Evw3IjgONBtKWyJQE7bP4gLB+hrjnuTeQArO87VyA0dsTn5LcMhP1GXNGG
 T2nxqcfHA043ykKSXMmmo3Hu3JEJLf1QY3adgu8N3cbzttTEcKkTZ+T6ZHCspudfuJywmLA7K
 O3jtL1uT/TpUkvQcCkhc8+K3HKJnxnaBU6SoUZx7JED1dlxOHF7FR2dnbRNj5DVYpL+3mHSuG
 E7gFLxQi6F3y02K3hJCw1RVHZiB6YvQH6BCoBmvs4oiCKeW4p8fsTrJWV8dmFoy8/pZFWFeUY
 fURYV/vjbjR7Wila4lqBwplG+9b/sKVmVwAM1YKlZKtitIAgP4QYSsxMjR+61jLdXlDyFX8/Q
 /8+teOjZsVVAZXYabM5oyVT8hzo9EljA5DzZMQPKn8a3FcT6gpJ/YbbH5G13p+u87RdkOR6CT
 /mWixmGXDKLnX1GkR7EjP0HrYSEiB+vbg5E1B0IGbpOEY=

Build the pack base name argument directly using strvec_pushf() instead
of with an intermediate strbuf.  This is shorter, simpler and avoids the
need for explicit cleanup.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 midx.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/midx.c b/midx.c
index 85e1c2cd12..41521e019c 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -2163,7 +2163,6 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,
 	unsigned char *include_pack;
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
 	FILE *cmd_in;
-	struct strbuf base_name =3D STRBUF_INIT;
 	struct multi_pack_index *m =3D lookup_multi_pack_index(r, object_dir);

 	/*
@@ -2190,9 +2189,7 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,

 	strvec_push(&cmd.args, "pack-objects");

-	strbuf_addstr(&base_name, object_dir);
-	strbuf_addstr(&base_name, "/pack/pack");
-	strvec_push(&cmd.args, base_name.buf);
+	strvec_pushf(&cmd.args, "%s/pack/pack", object_dir);

 	if (delta_base_offset)
 		strvec_push(&cmd.args, "--delta-base-offset");
@@ -2204,8 +2201,6 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,
 	else
 		strvec_push(&cmd.args, "-q");

-	strbuf_release(&base_name);
-
 	cmd.git_cmd =3D 1;
 	cmd.in =3D cmd.out =3D -1;

=2D-
2.44.0
