Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C2189F42
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321536; cv=none; b=L/BKjfXMiuRcE2PRYsoQXh4wKw6mueUnESTyZAr/y4zv7u2Sx43a8yqbjIXw8hYdqJB212DUeocAFskP+7VnlQh8Cz/3oUssYMTyQo33ZH92JRV61GbW+d7vjKVEDN+9vVPUo+ryorYQC+xqbbLcWFi456r0yzyKIGcRj5OTzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321536; c=relaxed/simple;
	bh=K+4NJTDZLDbxI7Cv/0K3Pzg2hX1EY5xszX+RkxInH9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAgzuYkiFKhljJU+/RUX925msPfw6kRMajd4210QHQnzK3U+t0xWWXXsQfY3nRHxv5VB4VrmgSDBeaL3Vv9li47bqDezu8pMNKwSeDdoltHO9f23slXv5pyeYmX9H3ZsRDh6mSv/QR7bctf3irru4y7Gz0V3Xrk/i1qd9OE2+OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jkRaNcEI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c6Y/sFiU; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jkRaNcEI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c6Y/sFiU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1176613801F5;
	Mon, 11 Nov 2024 05:38:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 05:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321534;
	 x=1731407934; bh=+n0CumCDI+clQ9ReQlJQlO/QyzI5zyp9cGfEqreGZYM=; b=
	jkRaNcEIKfcTjIFpLhHTMzSlATB6aYpsCzb54SX5PbBbramX9bsyxL7qjCR8CW6h
	n8GlW0tBhZyFP6s1NnuOdiF+O8hu98TuS4k0xesJ1bb0Z3VMAbfipsD0Gx5V1QwB
	hzafzx9ASYUXA1TGrU9b0TSV1dekrHw47QMbYCu+37BDQFRE5g3cafM0W6OqZkv5
	aUFfekABMC39LH/qOKIpnwuWVhg8yVEFnj5HGoNcHJgnJl7187ncr+vSWoQz03a4
	BxjwaZ6qugdzH0mk+H+m+bfitFft4LLng/GvKrNgY4LZ7kFjRnayoZk+jviL48ru
	1TCSAgmLXm23sNxmP/7lHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321534; x=
	1731407934; bh=+n0CumCDI+clQ9ReQlJQlO/QyzI5zyp9cGfEqreGZYM=; b=c
	6Y/sFiUY6b5MwYzATJOT82MopLEbn2f3GGOlSIlKHeDbfEAmIB7ng7M8ZhJ6aWop
	a8mJ2/AUKy0Qs9sISPxlZTqbfBb32+iTXIqmajLWZKRcMrII7kONtpM7AId0xLgd
	IpAppvhQ2UM1kPwDAmt3VdHUOH6URQXl7d0SgOdX0JpCshucPNV+STpwJmUvIfW2
	+mxsREaaPd1xSErcE8Gz2ST/3BEVKo0CkfuusVMi73Zi2n1Gpw5yya6agGvYTqiT
	QJzQElD8EbQhLfyLS8CBbaYmHo58a9r6BTIwyTS81JPaUAjgvxapCKyeYLxD32Qc
	W0vR8ybNSOlQ4K9UrUzWA==
X-ME-Sender: <xms:vd4xZ2fLvfInqrx4XYaEQJ_RXq1jZ14iY9Vgt-pgf2Jdy52vnz-dWg>
    <xme:vd4xZwNBePx4bGY1SUNb1SUazbxyY3LAn0x6dkKPe7Aejdubf4Bb-K36mmZQ3Q3-x
    sgliAYf-zr4I-qx-g>
X-ME-Received: <xmr:vd4xZ3i4wAkF6xwom2LhcdiCB1mVq7uLdnQSQ1R2L28V4uIBT2mV0YukhL0L_GDKzLkSsOy7qEasV6opB3FjatcVIvlkBXPgpsInZj1hPvjqu87z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vd4xZz_HTbDJmbYv7AeAbto5e7nuG28m9M8yGZBTyoR5_4w-6R56YQ>
    <xmx:vd4xZys0eH5Mv_8lUFVWeTOpXhWryQGRfoYkNIUe1U9rqprK4VADyg>
    <xmx:vd4xZ6F0l7pMi27nv5MkIBwpZWdAqvtinvvkeG5HENrNDpVicxpsbw>
    <xmx:vd4xZxPgThqxPUcBbJMv3916ffdAWgmT81tqQKD4Ma6ifc-g7KWEnQ>
    <xmx:vt4xZ7575_E967Z07xGA0UWLKTicYOBkQl4I8wrJPa0gReA0WxKZtek->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 64f3d87e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:37 +0100
Subject: [PATCH v2 08/27] line-log: fix leak when rewriting commit parents
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-8-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

In `process_ranges_merge_commit()` we try to figure out which of the
parents can be blamed for the given line changes. When we figure out
that none of the files in the line-log have changed we assign the
complete blame to that commit and rewrite the parents of the current
commit to only use that single parent.

This is done via `commit_list_append()`, which is misleadingly _not_
appending to the list of parents. Instead, we overwrite the parents with
the blamed parent. This makes us lose track of the old pointers,
creating a memory leak.

Fix this issue by freeing the parents before we overwrite them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c          | 1 +
 t/t4211-line-log.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/line-log.c b/line-log.c
index bca9bd804073df9b77b2859063ac5ad4d3b24e0f..bc67b75d10d34edc726c00c887d57016e40f3a00 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1237,6 +1237,7 @@ static int process_ranges_merge_commit(struct rev_info *rev, struct commit *comm
 			 * don't follow any other path in history
 			 */
 			add_line_range(rev, parents[i], cand[i]);
+			free_commit_list(commit->parents);
 			commit_list_append(parents[i], &commit->parents);
 
 			ret = 0;
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 950451cf6a66e6c099aa5303ce19230c34cd1fc4..1d6dd982a2a858e9ca03635eb83b1463c9c9caed 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -4,6 +4,7 @@ test_description='test log -L'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '

-- 
2.47.0.229.g8f8d6eee53.dirty

