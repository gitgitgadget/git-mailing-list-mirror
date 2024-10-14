Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18071AAE27
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910963; cv=none; b=fAjLZDVa8Ys1LisUOisS+Nl0QauRcKs5LXxVeT/iTE27TubYSySk5nsWcxaDZTa4t+DLgbBBNINpAHgW92jpqv+0KssZjiowrh6Of1XLsktCfJdr5WayYT3ZXEQs+IyF+2s1YhPrfZw472K836DWQXmHCelfHAHIecRoqlRHFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910963; c=relaxed/simple;
	bh=jJ7wKMWhn/cbe3mGH6jVc9x65MzJO6SSCf7suizBgxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjhG3pHNExevmFJ298hkmg1SSHOSKCwPXFYJ0d3Xc67kJZEE9XkkEX4eclHCxPop8O/oBoA2IN+v1oqcWkBxKbWbU/1ehDhCL5dGQ5kT/enmdl6syNmKQnz9GdPplKDtPlQYxDQrYfYUs/qbOTmN4Fdc12h26b8292MagpFLCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GzpEDKin; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZYR4nqq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GzpEDKin";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZYR4nqq"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id DBACD138034A;
	Mon, 14 Oct 2024 09:02:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 14 Oct 2024 09:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910960; x=1728997360; bh=ABdmqwpmgo
	uAElw/ia2YQyNjmI2rQlEBuZTFZdafW1A=; b=GzpEDKinrnAuq8+u7wmV1mt/cL
	LRVcKns9pKzLPToq70Pz8KmyLNk0Hi6rPSTEu0MGELK5MGC/LABzWxPvvJWfAvaY
	MmvZ6d5Lb9Ih+gjFzvjCjPqsU7wmk+Xu4dCny8Xu1IT12PbiSHjnZl+Qe1basW9Y
	iWrySCMLZthpzaBc15hnmVdfLBxdKqGw+TE0S438SVXmHBH3EqV5BlXEC6ShREQD
	IqAh6NsQmFYVnzmsFx49vPkdSXpH7DDhOVYuad9N3jcf+Rf1yLTCWS+Bhvt+BF/Q
	n0X9ejESQSw5U+8jr+sSA8+JEjAy/ECJ8IxsrOWtyMUJh+5aA2xbFoSbRGqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910960; x=1728997360; bh=ABdmqwpmgouAElw/ia2YQyNjmI2r
	QlEBuZTFZdafW1A=; b=lZYR4nqqkoZgj/FwZcsaIrPm0iKlaG81wYZakVVas6iY
	ziEZeiqCRuTDqtZJBQ6OWtsIZH2cimifKlRkQojp+wDlK3JS6ti4s9V+VefjgM2R
	Xpvwt4a7V15E5lPczAuNgUe78rVc35rqrrtTNEWhHX2zFsivklecx9gbD0DC9f6N
	xVapCEfg/m1P7W39IQzCIu6bt9OOlnMUYqZrxH2KusmbFo62D/aXt6QuGYs4nF+4
	Z5BgcBoKRtWKhdxUqnml6letsODD3hjv2ogSG7CVMDsDcbJAdDxTpOWBwgh1i+Zk
	Po7XDshm1ZQO/V0pGVpfWPt6YdNQjyxHc6QM91FafQ==
X-ME-Sender: <xms:cBYNZ-LOer_l7yR3rs4mbnJF5zfVa1k2m2NdZcKOWYrca6iVH4pZGg>
    <xme:cBYNZ2I-d9mlLcrhBlo8QacIsx-wo9Ikhqz2FN1_RdSqIpFwlHrLUM0t_QqUJKlia
    T1o4PzSN7-AIh7_Jg>
X-ME-Received: <xmr:cBYNZ-vziS9jOQkJqyZRk7YhbA5FRk0CjiR-w7B4jiQ-b8D4zIhYeeXj69ByGm3KRcCPAmGqebyO-gRYkOhE8Y1pua2dBkIB3NnJ-rNZttjHOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:cBYNZzZpaRphoAHYkzzqyeMMxzXQAmqBHSYgdWqq026xn5rlczit5w>
    <xmx:cBYNZ1YUdAHXYrkPrsJMP1DGVxTh7Xh_ZYXJf5a-kEWBpQ95HZs_PQ>
    <xmx:cBYNZ_CI4LzPPZoIij9fY5nCXmaIyp-j3Xt9qLTE7ZNdn3_z5JAodw>
    <xmx:cBYNZ7Z_f_aF2oJYIXTrCoPhBFifPz7Y_6RLdyPAUIjuyTEx9Esbrg>
    <xmx:cBYNZ5EcV45u0Znowwq5Upuahcr67iYtGL2q9oddP4BXYXkmVC0lqr3K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 82b75d6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:26 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 07/10] reftable/stack: adapt `format_name()` to handle
 allocation failures
Message-ID: <1f08163009b87596188165863b89b62c5f521e00.1728910727.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

The `format_name()` function cannot pass any errors to the caller as it
has a `void` return type. Adapt it and its callers such that we can
handle errors and start handling allocation failures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 6ba48ddce5d..e94eb3c4685 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -623,14 +623,14 @@ int reftable_stack_add(struct reftable_stack *st,
 	return 0;
 }
 
-static void format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
+static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
 	uint32_t rnd = (uint32_t)git_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
-	reftable_buf_addstr(dest, buf);
+	return reftable_buf_addstr(dest, buf);
 }
 
 struct reftable_addition {
@@ -846,7 +846,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	int tab_fd;
 
 	reftable_buf_reset(&next_name);
-	format_name(&next_name, add->next_update_index, add->next_update_index);
+
+	err = format_name(&next_name, add->next_update_index, add->next_update_index);
+	if (err < 0)
+		goto done;
 
 	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
 	reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
@@ -893,7 +896,9 @@ int reftable_addition_add(struct reftable_addition *add,
 		goto done;
 	}
 
-	format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	err = format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	if (err < 0)
+		goto done;
 	reftable_buf_addstr(&next_name, ".ref");
 	stack_filename(&tab_file_name, add->stack, next_name.buf);
 
@@ -944,9 +949,11 @@ static int stack_compact_locked(struct reftable_stack *st,
 	struct tempfile *tab_file;
 	int tab_fd, err = 0;
 
-	format_name(&next_name,
-		    reftable_reader_min_update_index(st->readers[first]),
-		    reftable_reader_max_update_index(st->readers[last]));
+	err = format_name(&next_name, reftable_reader_min_update_index(st->readers[first]),
+			  reftable_reader_max_update_index(st->readers[last]));
+	if (err < 0)
+		goto done;
+
 	stack_filename(&tab_file_path, st, next_name.buf);
 	reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
 
@@ -1370,8 +1377,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * it into place now.
 	 */
 	if (!is_empty_table) {
-		format_name(&new_table_name, st->readers[first]->min_update_index,
-			    st->readers[last]->max_update_index);
+		err = format_name(&new_table_name, st->readers[first]->min_update_index,
+				  st->readers[last]->max_update_index);
+		if (err < 0)
+			goto done;
+
 		reftable_buf_addstr(&new_table_name, ".ref");
 		stack_filename(&new_table_path, st, new_table_name.buf);
 
-- 
2.47.0.dirty

