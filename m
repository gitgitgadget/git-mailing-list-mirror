Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FED1D540
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971061; cv=none; b=i/aliZgUpAeNh8+HgJS+MIXKzi0nydMcSQdNRcc1a2T3vAknpya0Ylme3tAtpo26QihhD2VHG6yk9qnVEkRyzQcBXmqlFB4+nGEI7cu1UJwZGlIiqgV/p2OOG+NBefaOmY4+i05mmwY/u1sGH/ZV5MZeqiguX+91euW4UVHM3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971061; c=relaxed/simple;
	bh=olOY0Z5QkNtmRV4cILEBJ7peLlSId5HQGHI/9OdAiQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i/bS5zkkg/yFcQlj4qsvo9kM7ZQLUGwozLuNiFIYid4Nuxd6cufOCFrZ4E5yRFUzhqZHLXpWnmcuH9O3B13CGEhGEIXnNojBRuTX7Kmn94vKPLLoCQZ451LIxUO/Mf9kwUCvQC2wDNiQr2ke90AFSTkZbRlPrEeDNIUoAVOxa78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AHXorCiR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eba66ywf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AHXorCiR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eba66ywf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB4BE25401A1;
	Mon, 27 Jan 2025 04:44:17 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 04:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1737971057; x=1738057457; bh=lczi33a0PBbTZwHYGLUUMRGDkLKKTA4Z
	QTxnQ4Beikk=; b=AHXorCiRnkzVUNlH91DPQq7vh29J39QNK+JfHbU4D3eOvnKr
	37I6NVE/H3SmqxFCAA/dBANLOM+MjSyfH8S9LR2vlcEEhiyvjkjiGBhBjITzXqhs
	X2eE+KgTKs18ViEFWu0mUT4xxMzsojvi9Lp2l6k21VPACXt6DUDeS37yipwMEP3Z
	Fp+Po0QdDQ1DrvPdSr2VG7SblAPOmmgZYJIUJl0huSbCKSDShmRpE7WQlxNDiO5x
	h1VPmGi6R8Orh0i0azZ/uc2aODevTnyxFtjEYBkk1/qP7fGlIePCu4n+GWgp9+PQ
	TemwaVK60gb4u+vdg5JGGkF/Xn29PPY4OUaN1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737971057; x=
	1738057457; bh=lczi33a0PBbTZwHYGLUUMRGDkLKKTA4ZQTxnQ4Beikk=; b=E
	ba66ywfaxtknXHjLAixieK43LyNCthuNHUXNsBHmqgMw7iNK3BYVw57qrDjTVH+L
	n1aFl7AqilI/poqgKtoAk24Wq+dbagE/7mDT2hvEOqioih5WiSD49mXQeQRdYpKs
	m1RUGDkRRmPIEnp21mDLOG3lHg6O+Rc7CbcRjd7+osl+gxrxrLeVJj4aX2ohaoLg
	3rTXAQPFoap0jzeMfhSTs0FGZoESQ2Wgx5Lpppm2LP6G0BAEusLFsy3wQgnJMpy3
	av5GgsXrBEqogsPzOkkPdci/P6FrAMqk8n3cr+XnvMcPJ0nLyBwe/aLXLF/g1SCz
	K4Mda41t17QOGHkrWlf9g==
X-ME-Sender: <xms:cVWXZ5VUKzBa-ZQTMXWVjNnDNADhjsru9bweTPygX_ZoHRC7W3tdyg>
    <xme:cVWXZ5n9wuc0aCHoScUeDz_8hvDv6dduA1k2-EEgCFmAkkyKqPzTIVKood2tvs-P8
    kZ3vGKMlIMkuERNRA>
X-ME-Received: <xmr:cVWXZ1bISUyOwWU4Y5xQQqMZyZslLxTj7ImOxxcIz3gX_exhG81bp1tfJjb9DsmDsim2TIjYkKbaBItufNxVVEDTuJ4SHlGEYPVUmVAY2_yG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiuedvhfette
    elgffhhedtvdehlefhtdffhffhgfeljeefvdetfeevledtueeivdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvth
X-ME-Proxy: <xmx:cVWXZ8X8kk0AUGVJvOYtqUvEnCVPFCIloTBncV1u38dzY15RMh0Izw>
    <xmx:cVWXZzliji5g2j55JarrUcwTpVDB1hnR3jqlpb2ksErLhRzsnFaPUg>
    <xmx:cVWXZ5ekUTqimIVvCXT_XAbR2Z1zrgVPCgCosAuMloKhHLBY4tYO0g>
    <xmx:cVWXZ9FPdE6dCktCGCjR8YSTNiTpavDPL2z5HRwiPF-wBRoUKHP61w>
    <xmx:cVWXZ8Cntwe00A-8iZWkDpaAe6vOirMT7VehsXtt5TrFvVFIpArUHXao>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 04:44:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bad4abd0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 09:44:12 +0000 (UTC)
Date: Mon, 27 Jan 2025 10:44:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
	sandals@crustytoothpaste.net
Subject: [PATCH v4] refs/reftable: fix uninitialized memory access of
 `max_index`
Message-ID: <b7e3dd3cc870024f0e80dad26c5a7a96483c6cf4.1737970803.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Karthik Nayak <karthik.188@gmail.com>

When migrating reflogs between reference backends, maintaining the
original order of the reflog entries is crucial. To achieve this, an
`index` field is stored within the `ref_update` struct that encodes the
relative order of reflog entries. This field is used by the reftable
backend as update index for the respective reflog entries to maintain
that ordering.

These update indices must be respected when writing table headers, which
encode the minimum and maximum update index of contained records in the
header and footer. This logic was added in commit bc67b4ab5f (reftable:
write correct max_update_index to header, 2025-01-15), which started to
use `reftable_writer_set_limits()` to propagate the mininum and maximum
update index of all records contained in a ref transaction.

However, we only set the maximum update index for the first transaction
argument, even though there can be multiple such arguments. This is the
case when we write to multiple stacks in a single transaction, e.g. when
updating references in two different worktrees at once. Consequently,
the update index for all but the first argument remain uninitialized,
which may cause undefined behaviour.

Fix this by moving the assignment of the maximum update index in
`reftable_be_transaction_finish()` inside the loop, which ensures that
all elements of the array are correctly initialized.

Furthermore, initialize the `max_index` field to 0 when queueing a new
transaction argument. This is not strictly necessary, as all elements of
`write_transaction_table_arg.max_index` are now assigned correctly.
However, this initialization is added for consistency and to safeguard
against potential future changes that might inadvertently introduce
uninitialized memory access.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

Hi,

Karthik is out of office this week, so I'm taking over this series for
him to ensure that it lands soonish. The only change compared to v3 is
an adapted commit message based on my own feedback.

Thanks!

Patrick

 refs/reftable-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 289496058e..d39a14c5a4 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1020,6 +1020,7 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		arg->updates_nr = 0;
 		arg->updates_alloc = 0;
 		arg->updates_expected = 0;
+		arg->max_index = 0;
 	}
 
 	arg->updates_expected++;
@@ -1628,10 +1629,9 @@ static int reftable_be_transaction_finish(struct ref_store *ref_store UNUSED,
 	struct reftable_transaction_data *tx_data = transaction->backend_data;
 	int ret = 0;
 
-	if (tx_data->args)
-		tx_data->args->max_index = transaction->max_index;
-
 	for (size_t i = 0; i < tx_data->args_nr; i++) {
+		tx_data->args[i].max_index = transaction->max_index;
+
 		ret = reftable_addition_add(tx_data->args[i].addition,
 					    write_transaction_table, &tx_data->args[i]);
 		if (ret < 0)

Range-diff against v3:
1:  614274cede ! 1:  b7e3dd3cc8 refs: fix uninitialized memory access of `max_index`
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    refs: fix uninitialized memory access of `max_index`
    +    refs/reftable: fix uninitialized memory access of `max_index`
     
         When migrating reflogs between reference backends, maintaining the
         original order of the reflog entries is crucial. To achieve this, an
    -    `index` field is stored within the `ref_update` struct.
    +    `index` field is stored within the `ref_update` struct that encodes the
    +    relative order of reflog entries. This field is used by the reftable
    +    backend as update index for the respective reflog entries to maintain
    +    that ordering.
     
    -    In the reftable backend, before writing any references, the writer must
    -    be configured with the minimum and maximum update index values. The
    -    `max_update_index` is derived from the maximum `ref_update.index` value
    -    in a transaction . The commit bc67b4ab5f (reftable: write correct
    -    max_update_index to header, 2025-01-15) addressed this by propagating the
    -    `max_update_index` value from the transaction to
    -    `write_transaction_table_arg` and, ultimately, to
    -    `reftable_writer_set_limits()`, which sets the min and max index for the
    -    reftable writer.
    +    These update indices must be respected when writing table headers, which
    +    encode the minimum and maximum update index of contained records in the
    +    header and footer. This logic was added in commit bc67b4ab5f (reftable:
    +    write correct max_update_index to header, 2025-01-15), which started to
    +    use `reftable_writer_set_limits()` to propagate the mininum and maximum
    +    update index of all records contained in a ref transaction.
     
    -    However, that commit introduced an issue:
    +    However, we only set the maximum update index for the first transaction
    +    argument, even though there can be multiple such arguments. This is the
    +    case when we write to multiple stacks in a single transaction, e.g. when
    +    updating references in two different worktrees at once. Consequently,
    +    the update index for all but the first argument remain uninitialized,
    +    which may cause undefined behaviour.
     
    -      - In `reftable_transaction_data`, which contains an array of
    -      `write_transaction_table_arg`, only the first element was assigned the
    -      `max_index` value.
    +    Fix this by moving the assignment of the maximum update index in
    +    `reftable_be_transaction_finish()` inside the loop, which ensures that
    +    all elements of the array are correctly initialized.
     
    -    As a result, any elements beyond the first in the array contained
    -    uninitialized `max_index`. The writer contains multiple elements of
    -    `write_transaction_table_arg` to correspond to different worktrees being
    -    written. This uninitialized value was later used to set the
    -    `max_update_index` for the writer, potentially causing overflow or
    -    undefined behavior.
    -
    -    Fix this by:
    -
    -      - Initializing the `max_index` field to 0.
    -      - Moving the assignment of `max_index` in
    -      `reftable_be_transaction_finish()` inside the loop, ensuring all
    -      elements of the array are correctly initialized.
    -
    -    Initializing `max_index` to `0` is not strictly necessary, as all
    -    elements of `write_transaction_table_arg.max_index` are now assigned
    -    correctly. However, this initialization is added for consistency and to
    -    safeguard against potential future changes that might inadvertently
    -    introduce uninitialized memory access.
    +    Furthermore, initialize the `max_index` field to 0 when queueing a new
    +    transaction argument. This is not strictly necessary, as all elements of
    +    `write_transaction_table_arg.max_index` are now assigned correctly.
    +    However, this initialization is added for consistency and to safeguard
    +    against potential future changes that might inadvertently introduce
    +    uninitialized memory access.
     
         Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int prepare_transaction_update(struct write_transaction_table_arg **out,
-- 
2.48.1.362.g079036d154.dirty

