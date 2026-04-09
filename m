Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6D3C1416
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775734169; cv=none; b=Z4dOd3GogMMJO3WqbZP3CC3WD3fFPHl8y9JFr1CR70D+2fHGpH+ZebDgGq07g3qNrTfhkmgwmeNDV7Ln1Ilo9a2S8j6a8GhS774xcgjWY9ql85xXFwuLaDmcLOsQu1gUAB5d9Pp5F4+Gv9R3kDf4j6NE1B3c5dRdc5rvCU1Sw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775734169; c=relaxed/simple;
	bh=IHc0Q9/cWXeKXgOhodzcWEuFMT5Cuub4MuyAn4JJvy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqtqPYDPHbBLdmLPQ/pPIm0cY2PiXeSJnM/HGQRptOp2XZrxr7302jMtVE1R3A5Cu8fZ5JRsmQZolVii7ZapSnQJph2jWVfXXGkU3OeW88WWTkU4JqkXxKe5qgPyongn3oeQjwjyEv/oM/GqAMRxPuWzQivZVXxI+5/wMyo9eN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yuQ/q6E0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MSi3urS0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yuQ/q6E0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSi3urS0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED8CB1400288;
	Thu,  9 Apr 2026 07:29:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 07:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775734166; x=1775820566; bh=D04Y20X9ML
	g1NYffsZsluCMlAcVhO1R6Y1uNdtB2v+U=; b=yuQ/q6E0+g8cuNhKTzxE65eEUU
	gD0dkQgzqINDrYvTe4L7/3nDXOTAxzRWMimthrwPk7zR+l05rJmiT4sQ78KcEX/9
	QHtXzXY6fgwTvXTt7bzUabx82dbKB54fXd0yzrj7AVoYpkIljvNla6AlJ5oxOoM3
	Bp8B81yvlMTqRNeQfi2vsZJp1LCV1jg57BYusk8UifsqSRYbNXz69CLjhbevKjeE
	UbOShOZJOLdDcinODdKQDWAiN2JfhSXW3kzHU57Tz4VaED+bSu+6vXQWRAkoyCZ8
	Db5AAL4q5Yngj5P+Wv1lkl1tt6b8NcnEFX1bpX/zd0MfLndmilshqLeatvyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775734166; x=1775820566; bh=D04Y20X9MLg1NYffsZsluCMlAcVhO1R6Y1u
	NdtB2v+U=; b=MSi3urS0PZhcW5XKZafI3zvco8Bsi13DhvfUFq0AHscEegDCdRl
	F354Zja7PshaVJOxSKA50LK8x7iB64o8Z6s5CrmSWpiGB4hxBnD9k3NfNduCXMOk
	nPgnrt4uMjCx2W9m3LPZWPmiGNvbHqFCcWTh0WiUsz7CUNCKtVWWFmkFzaXKdShX
	rP2NHStmMGntWyOLYxBNnmm/YVbTBfbGuxoL7N+jYf5Ladhkc6H65/gZwNMlnC/O
	P3emPIbwQbXUL5Gu2Rvy/gJPXJzqg//w05nqnlT9umqocEwfyd+WUC46chM7Lv3Q
	651Xiu0lgBhWUQTp6sq11CmY9yZj0q3zuzg==
X-ME-Sender: <xms:lo3XaV5rhpUPW6DPieu5u-YsWJreV0mUPsCf98NZN6U8nBHXoQJFLQ>
    <xme:lo3XacOaR9FDJL7JiSPlRsuQgmxz764_IoyPizd4e5G9cJptkYz-7jwSHfE37S3G_
    PxDs_rbu2JoZn3RUY0GCNmnQPflJq9PiFD8VflEVYPrwLizcRULFA>
X-ME-Received: <xmr:lo3XaTvmwZwnr41SnY8O4wZGSGMUWBt89TNAa7rR7h4vEL10lSA5rG44EI40hWCP1N3Shu_6CDHleRfoXPX_q-gxxGt5H4Mg9k2pBaWIhTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgv
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:lo3XafYn_OpyfZdhXCuCwJDz6EMvJLK3oTri5yOkDL7DpjaJykgraQ>
    <xmx:lo3XaVx-FNICkVCnMFYOFSAToP5Ie2MBrPDxq1fJLy7RgxHJEPoxRg>
    <xmx:lo3XaXh53h9w1l0cw9w_XW6iWh5OeT4WI-XvW3jUQ0Biu-S4D1csKg>
    <xmx:lo3XaRlkv2gxlSMQz5gRcV0ZHzAOxqrDNFPFAyxzKvjTmJes-qCnJg>
    <xmx:lo3Xadww2WH_M5TBCVlztlVWvyJy_8SmAVt6xBD28F21qjv93YH2aboO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 07:29:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dea81f6e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 11:29:23 +0000 (UTC)
Date: Thu, 9 Apr 2026 13:29:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Message-ID: <adeNjEBSlXd7ykEx@pks.im>
References: <20260408173949.GB2850002@coredump.intra.peff.net>
 <xmqq4illz5g9.fsf@gitster.g>
 <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>
 <xmqqqzopxkxa.fsf@gitster.g>
 <016b01dcc79e$87472860$95d57920$@nexbridge.com>
 <xmqqcy09xh53.fsf@gitster.g>
 <20260408223233.GB2873736@coredump.intra.peff.net>
 <adbwyvQ-R2Ag1vox@fruit.crustytoothpaste.net>
 <addgkjiB80pgKw69@pks.im>
 <90c6112d-6447-45e0-8d15-a0a3f1f25013@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c6112d-6447-45e0-8d15-a0a3f1f25013@gmail.com>

On Thu, Apr 09, 2026 at 10:48:02AM +0100, Phillip Wood wrote:
> On 09/04/2026 09:17, Patrick Steinhardt wrote:
> > 
> > One question to Randall though: does MAX_IO_SIZE apply to the overall
> > size of the iovec or to the individual iovec entries?
> 
> In <014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com> Randall says
> 
>     Specifying  the sum of the iov_len values in the iov array greater
>     than the OSS I/O size limit for that open causes the  writev()
>     function  to return  -1  and  set errno to [EINVAL].
> 
> So it is the overall size which fits with POSIX limiting to overall size to
> SSIZE_MAX.

Ah, thanks for the pointer. I've adapted the patch a bit to the below
one. Again, I've tested it with `#define MAX_IO_SIZE 100` to verify that
it works as expected.

I guess I'll send a polished version to the mailing list in a bit.

Patrick

diff --git a/wrapper.c b/wrapper.c
index be8fa575e6..d989c78b4b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -323,21 +323,60 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
+{
+	ssize_t bytes_written;
+	size_t total_length;
+	int i;
+
+	/*
+	 * We need to make sure that writev(3p) call does not write more than
+	 * `MAX_IO_SIZE` many bytes. If we do exceed that limit, we only pass
+	 * those iovecs to writev(3p) that sum up to less than the limit.
+	 *
+	 * If on the other hand the first iovec entry already exceeds this
+	 * limit we'll instead use xwrite() to write it, which knows to handle
+	 * `MAX_IO_SIZE` for us.
+	 */
+	for (i = 0, total_length = 0; i < iovcnt; i++) {
+		if (unsigned_add_overflows(total_length, iov[i].iov_len))
+			break;
+
+		total_length += iov[i].iov_len;
+		if (total_length > MAX_IO_SIZE)
+			break;
+	}
+
+	if (i < iovcnt) {
+		/*
+		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
+		 * xwrite, which knows to handle this case.
+		 */
+		if (!i)
+			return xwrite(fd, iov->iov_base, iov->iov_len);
+		iovcnt = i;
+	}
+
+	bytes_written = writev(fd, iov, iovcnt);
+	if (!bytes_written) {
+		errno = ENOSPC;
+		return -1;
+	}
+
+	return bytes_written;
+}
+
 ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
 {
 	ssize_t total_written = 0;
 
 	while (iovcnt) {
-		ssize_t bytes_written = writev(fd, iov, iovcnt);
-		if (bytes_written < 0) {
+		ssize_t bytes_written = xwritev(fd, iov, iovcnt);
+		if (bytes_written <= 0) {
 			if (errno == EINTR || errno == EAGAIN)
 				continue;
 			return -1;
 		}
-		if (!bytes_written) {
-			errno = ENOSPC;
-			return -1;
-		}
 
 		total_written += bytes_written;
 
diff --git a/wrapper.h b/wrapper.h
index 27519b32d1..a6287d7f4d 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -16,6 +16,7 @@ void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_
 int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
 ssize_t xwrite(int fd, const void *buf, size_t len);
+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt);
 ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 int xdup(int fd);
 FILE *xfopen(const char *path, const char *mode);
