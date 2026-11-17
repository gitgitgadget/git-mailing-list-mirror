Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.61.206.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938236;
	b=kK1QmGfjC/RlDII5s8DATEfl4unrJu71UJ2RM4UwZyuhweemkGwG5IPtcJLdU4ocQxH3
	 G8GIkhOoWeTbQxMLlG5bZk8K2RuiNfWvvcoegMaJHY2GcOwYGJKnWVb6XCCOOAGxTyhLr
	 cGXpFOiN4lRgL7lQqZWqVRomJOSq8Cnk96XHGxm2eKpx6WvgMgI6RH7fq1syVU4UVODLJ
	 xtsVswlw1jOsfebmgH23F1E/Liuvi2r3vCx6VTSR9yRFcLTxtvam8nzAVUvwNKD0BBv1Q
	 o3UCLbXsqIxglobOWdwZVBWPeF9Qqu6GPr5chApwx5KGzxem/bIRTjSrW7q7+uavFIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938236;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wNYWx0BU8MgrGIiDqQxMGqpNWiVy+30qY6kvBHob1AA=;
	b=qFwoZ3yyT5/16veeMsADZV/CELF7mkdc69vMV2mioaAheHs5qsbPIt7VxFHFfQT/PfE8
	 RPOJXQ3Q4ltjf1Za7vN82bk8kFuZ5g1sTONT+llbjfgRNrESE/FDXEWHMTyiVMeYunrzw
	 7MgUINahHM7rY/KUalAI/rlSDQqXIVwJa105eFxSZFPgJNOxOHEsjF4ycfcgmTKOr6lHz
	 ku1hrwljNTaPUshMG8xr6mxikaJllnb6rxm1jKGIEe2FrlG/QxH80Vj+gNxERWkWWVD6F
	 BagNc9Z35ZAFxcBTzWKI2kzuMR1I8oRkLNZ4/HyDjHIOBAU4LtuWqh/PN7mZyTG/8Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gouders.net;
	spf=pass smtp.mailfrom=gouders.net;
	dkim=pass header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=XljsLOi+;
	arc=none smtp.remote-ip=202.61.206.94
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A3606A331
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 17:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F4A3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.a=rsa-sha256 header.s=gnet header.b=XljsLOi+
Received: from localhost (ip-109-41-49-131.web.vodafone.de [109.41.49.131])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 6AHHv8BA1834880
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 17 Nov 2026 18:57:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gouders.net; s=gnet;
	t=1794938229; bh=wNYWx0BU8MgrGIiDqQxMGqpNWiVy+30qY6kvBHob1AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XljsLOi+mdE3EL9O1JdIjAmu0NuWfW0n4W1TJi8qIYMw+9CawPO6qUtTfFpyuQPye
	 PctiS97JhSPvXgkJuq5R5TspgvV0UE6e6fZGQCac6Td+t8JeIMUz6vG2Fd+IFoVhRR
	 wvn+hLnM17BxsGGEEqTDXwghmleg2hdsn2t4TQHQ=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] utf8: respect bounds in utf8_strnwidth()
In-Reply-To: <xmqqse0zfn2n.fsf@gitster.g>
References: <20261116-master-v1-0-dc2a50ce0aa0@gouders.net>
	<20261116-master-v1-1-dc2a50ce0aa0@gouders.net>
	<xmqqld6siau9.fsf@gitster.g> <xmqqse0zfn2n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 17 Nov 2026 18:57:08 +0100
Message-ID: <ghbj7nmjd7.fsf@gouders.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17 2026, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The problem is well spotted, but isn't the blame slightly misplaced?
>> ...
>> Even if display_mode_esc_sequence_len() were updated to take the
>> remaining number of bytes in string (which I think *is* a good
>> change, by the way), ...
>
> An update to display_mode_esc_sequence_len() to take the length
> limit, including its fallout, is shown below, and it does not look
> too bad.  Not even compile-tested, but it should be sufficient as an
> illustration of the idea.
>
> This does not make your "after display_mode_esc_sequence_len()
> skips, make sure if we still have remaining string to grab one UTF-8
> character" change unnecessary, as I said.

My v2 would have introduced two new functions (see attached) to replace
display_mode_esc_sequence_len():

=E2=80=A2 size_t ansi_sgr_nlen(const char *str, size_t len);
=E2=80=A2 size_t ansi_sgr_nlen_multi(const char *s, size_t len);

The latter one to help (most of all) users who want to eat *all* leading
SGR sequences so that they don't need loops.

But I saw you already posted a patch and that is also fine, of course.

Dirk

diff --git a/utf8.c b/utf8.c
index 96460cc414..1e3887480f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -30,6 +30,44 @@ size_t display_mode_esc_sequence_len(const char *s)
 	return p - s;
 }
=20
+size_t ansi_sgr_nlen(const char *str, size_t len)
+{
+	const char *p =3D str;
+	const char *p_max =3D str + len;
+
+	if (len < 3)
+		return 0;
+
+	if (*p++ !=3D '\033')
+		return 0;
+	if (*p++ !=3D '[')
+		return 0;
+
+	while (p < p_max && (isdigit(*p) || *p =3D=3D ';'))
+		p++;
+
+	if (p =3D=3D p_max || *p !=3D 'm')
+		return 0;
+
+	return p - str;
+}
+
+size_t ansi_sgr_nlen_multi(const char *s, size_t len)
+{
+	size_t sgr_len =3D 0;
+
+	while (sgr_len < len) {
+		size_t count =3D ansi_sgr_nlen(s + sgr_len, len - sgr_len);
+
+		if (!count)
+			break;
+
+		sgr_len +=3D count;
+	}
+
+	return sgr_len;
+}
+
 /* auxiliary function for binary search in interval table */
 static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
 {
