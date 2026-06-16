Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F172F12AE
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781642140; cv=none; b=U4ImKLBH+pErodf8QJUd+SOHEWgTb/2XMldEIedC1IWr5v2Pf8el8MnYsMrwk6k9+lehVrgTgyDisc6/7yMW5jvFrTyRFQe20FP+RtssSEQ083EjyohF5Inc76i4cvz3CptUIqsBFw6cZzJ5iElRbqz+pn9o8RRBBHIkywpFOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781642140; c=relaxed/simple;
	bh=xCU35Iv7HCgc42NrtZU23TQ/m9+cshg03+HRxnL7SdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gV59d9bpqs6fuk/ZDo5PRrFkZn1RD2vN19dqa7e6aW1w3oU3rq+WVTxZoFbauOF9Tv76Gw8fnjCj/eWmtjuDZXOGglLqByeLyUiAkxnH8XkgBr2pub6zVl2aPHABi3Ag0OJXkiOkLlbCW9lid5H0ciSDLDaAU8HYvOTDEtbx9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G6najCzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X6OOGuEb; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G6najCzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X6OOGuEb"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3037814000EE;
	Tue, 16 Jun 2026 16:35:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 16 Jun 2026 16:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781642138; x=1781728538; bh=PTxtDVxXfC
	WrSg6IKb9xwxlksviIgSKSU7QhXeTlNLo=; b=G6najCzYvt/gLZzcwOCUH+Jmqj
	jCA+uzbh5pXIF1b0dV767xVeVv8FiKvf+wtvXQ5adglpbm13bPwokkDE7tbI2j4q
	TXCrWpzDNFSf5RWPN87Y9+UK7Zv3RKXQ2ueewm8Rsbr7Q+iuIo2mJCTNa/uRYNic
	/Ru67nmlTS1TZB+Y80LGkIb82CbU9jUltnC0kohskuzox7hyS/BkRZSKmfy4LiAJ
	41R2gdTdxilWvTYKQkvaYgVaeGh4SR/N2Q+XXPYQMmdrtX4UpoX5ZroTdk7OqzQS
	y5d3p0PVlxlii1UljTwW0B1i+T511MmWk0Dl77pCYp1gUmhHsIp+3MHyvDLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781642138; x=1781728538; bh=PTxtDVxXfCWrSg6IKb9xwxlksviIgSKSU7Q
	hXeTlNLo=; b=X6OOGuEbL71dgyfdqJaEhHSIwU+Y1/xgzPOJzETwiTuZBP26HFn
	cYBeR7EqHXW5+EWEuIBZS2zFDwMjZCznkaQ3uWDS7Ev4PXcq1tB82YXoASi4JYqf
	0NeWH1rzGOrKl7OjX60EXvZRA7S4HWooHLRUoq4qpifb6auKd1IXUJyQkEPZsDSf
	BeCj7JFddZY/1mSXeiIgOl6LCWHNdrv3UMYy8AKxhzgC4AeBWq1MxjurLgIkZEeF
	fTpJ5lp0Lx1BQid9A7GVwPqmv6d00MoTy09yb7tyGM/XlRPCigpDYlMWW+xAHYmk
	mbrTifr0bYKx7ascS0X+L8uLR/j8EWwJxcg==
X-ME-Sender: <xms:mbMxarO0TEyTU0m4OCapzcMLksdcBhPh_UefKa8h-9fBhZNrGg2qRg>
    <xme:mbMxaoiiuWiFMssoBuFYomViD5gf22rRWG1aF28Dtc-MskRrRB1Qs-j3NXsR_0aCX
    YrX0Eql4OKuhK9G-NQAvC_08zh-ZJJxVrh0bVcvFvpkS_xrBEGT>
X-ME-Received: <xmr:mbMxat44jquMg8bEn4zzLchuEeDyO4Y7tqz_R-l9Sow8rdiUti4sR8kh6NbVK7Cy1BmZM6eoR0SP9aVijRrbqM-nFTXmmrojSzsV>
X-ME-Proxy-Cause: dmFkZTFnmMvQagxMIqVfZupByohSrIjCi9tLoZa21k+v0KfHoVjgklnpuHitjA7ltHM0Ul
    0Z1NOmUKGkTs1U8RS1GQp1VNCdjro+BvUdoIzrtpaondP5ngBqlyOXsgrx5S9kiJLWChqv
    G6vQfPFmnqwNU6BMh1XnO7FFcPdXC4xdOI17lCH6bAFBvH5XLcCBYsqUInNOc6+jSpBb92
    8+WXeVyHO4nzNzDzw6ANQO8yTy7XfGg4sni0ULT+wYvTEjI3+hJhDwtD8qLsKAgclO54lT
    8WQ607ncKM6Q5Kn8Oy8a0quIBVGzTjAAt6HbA0TisjeDWQjctHro8wL8siaBIqBBjGAIXU
    QcYrwpDm1KkIwm8yLm8yEewEbA+IVeqd1hsWr54iWBTX1jy5GipbRLNsOGdAfr/SDbKpWk
    hQjY+R6RinFJmhZQLe4/NliSRQFUy77ufaFVawmVnFYYYOVHixT/GtoX4q9EvIOgLd9zE5
    Bgzml1yAiE9f6VmgYeJHX+UN3/FeCplM8h2SE5+kgLGfVIybjSat7mTM8rNZOPcz3PfUVa
    l0nUV+LPPY/ng/GVaxJzQ1Uo0vM7K7k3I+PU4dvV5Y6fW/26tntCa6rIpu+OdlK2Ay+heX
    mI0Pj/heSP+gCrHql5eM2VxXj1ldXbQr7nzQrorufRhF0w+jau7dF5A0dXRw
X-ME-Proxy: <xmx:mbMxav1f2tB1Tj3C_Twy_lElvO5cNrreC7N1_-PcPJAliJnqsBP-vg>
    <xmx:mbMxaotc9IOFtBqUVh-Q1sgfeiYTVChNCcPg3eI638Vo9FPujMiI9Q>
    <xmx:mbMxal7_9aWMT5nIkW29_pOxPZqh4WEa_y-zzikInXiYtcb377KfGg>
    <xmx:mbMxakcr22RjWODLwrNR9ShSVGCfOi-dFOByd7LA7SHnNLyy9OZgCQ>
    <xmx:mrMxapDktf5DWMbjghXvuk3Yv5PYsVEErt5AgHMRTbNy3gp6sCxhZOM4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 16:35:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: eric.peijian@gmail.com,
  chriscool@tuxfamily.org,
  git@vger.kernel.org,
  jltobler@gmail.com,
  karthik.188@gmail.com,
  toon@iotcl.com,  chandrapratap3519@gmail.com
Subject: Re: [PATCH GSoC RFC v12 09/12] transport: add client support for
 object-info
In-Reply-To: <20260608-ps-eric-work-rebase-v12-9-5338b766e658@gmail.com>
	(Pablo Sabater's message of "Mon, 8 Jun 2026 12:14:32 +0200")
References: <20250221190451.12536-1-eric.peijian@gmail.com>
	<20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
	<20260608-ps-eric-work-rebase-v12-9-5338b766e658@gmail.com>
Date: Tue, 16 Jun 2026 13:35:35 -0700
Message-ID: <xmqq1pe62pgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

[jc: removed recipients from Cc: list whose addresses bounce]

> From: Calvin Wan <calvinwan@google.com>
>
> Sometimes, it is beneficial to retrieve information about an object
> without downloading it entirely. The server-side logic for this
> functionality was implemented in commit "a2ba162cda (object-info:
> ...
> diff --git a/fetch-object-info.c b/fetch-object-info.c
> ...
> +int fetch_object_info(const enum protocol_version version, struct object_info_args *args,
> +		      struct packet_reader *reader, struct object_info *object_info_data,
> +		      const int stateless_rpc, const int fd_out)
> +{
> ...
> +	for (size_t i = 0; packet_reader_read(reader) == PACKET_READ_NORMAL && i < args->oids->nr; i++) {
> +		struct string_list object_info_values = STRING_LIST_INIT_DUP;
> +
> +		string_list_split(&object_info_values, reader->line, " ", -1);
> +		if (0 <= size_index) {
> +			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
> +				die("object-info: server does not recognize object %s",
> +				    object_info_values.items[0].string);
> +
> +			if (strtoul_ul(object_info_values.items[1 + size_index].string, 10, object_info_data[i].sizep))


Overly long lines need to be fixed, by using a shorter and crisper
variable name in such a short scope, and line wrapping if needed.

More importantly, on this line (wrapped):

			if (strtoul_ul(object_info_values.items[1 + size_index].string,
				       10, object_info_data[i].sizep))

we notice object_info_data[i] is of type "struct object_info", which
is 

    struct object_info {
            /* Request */
            enum object_type *typep;
            size_t *sizep;
            off_t *disk_sizep;
	    ...

but the last parameter strtoul_ul() takes is unsurprisingly a
pointer to "unsigned long", not a pointer to "size_t".

Which will break on 32-bit boxes where size_t is "unsigned int"
that is 32-bit and different from "unsigned long".

Perhaps something along this line?


diff --git a/fetch-object-info.c b/fetch-object-info.c
index 425929a269..5210e7d954 100644
--- a/fetch-object-info.c
+++ b/fetch-object-info.c
@@ -75,14 +75,17 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
 
 		string_list_split(&object_info_values, reader->line, " ", -1);
 		if (0 <= size_index) {
+			unsigned long sz;
 			if (!strcmp(object_info_values.items[1 + size_index].string, ""))
 				die("object-info: server does not recognize object %s",
 				    object_info_values.items[0].string);
 
-			if (strtoul_ul(object_info_values.items[1 + size_index].string, 10, object_info_data[i].sizep))
+			if (strtoul_ul(object_info_values.items[1 + size_index].string,
+				       10, &sz))
 				die("object-info: ref %s has invalid size %s",
 				    object_info_values.items[0].string,
 				    object_info_values.items[1 + size_index].string);
+			*object_info_data[i].sizep = sz;
 		}
 
 		string_list_clear(&object_info_values, 0);
