Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D91586FE
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053688; cv=none; b=FC60n1LwM+lZmKwwH5OI0RlLTf8pzbemmDxXeSY+UyekWPfKQxgdMNUeJP6yhGfjYX2jpOxJqbPpBP+4OUo5tZzZ+f3S1qS4N0+ZNYZgxOMOPDkZaiWLj8LgpUue/f0H1TxnIYGdsk8RW6+FzmFFp1PyoUmOul+CYGkI4ZTAgcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053688; c=relaxed/simple;
	bh=Y3zh4INfgRD7AaEHM5q2krUJLVPuIgUSbWYA4kV2PAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFjoduDdB/uD7wXgEBa5bnm2y9LDHeVjgn+sVjsU/Pufx084Zd61IrooUnj3fVOdmtoZMEMZTW+fazihjdm8reywSgeMs+XsByeK/LDh9exJ0hwx1VdOSdmFTCooIkOylJYnD3Ex1FcL/3zRMPyFfJzgEe5sQQMBjtEhUM/9lss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bl+b7dwi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HB1pkw37; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bl+b7dwi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HB1pkw37"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CD9E6114EA13;
	Mon, 19 Aug 2024 03:48:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Aug 2024 03:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724053685; x=1724140085; bh=3lTmmucJap
	XvslgIbw0siAZSJ3YNihy/MgWWBJ7hJy8=; b=bl+b7dwiaMoyO/4qplGfzbH20I
	3tXmxTGmqehgm0qDWYLT9un7w0YautbJRVirYf48UgeIL5bi/znLqywJc5Tt79o3
	9v6t7hZm55ZkT484v/5gKH6iSSRjTympexuWJaS5IWZj57jB8gJPugWcapbv3aBN
	I6V2Uf/kBnp9EoCmHKTZHNq6EX9PZykBWCjC2qCLxM81sz8tl1X9FvAJWS8nemOi
	m8p14pqxmKmNxJ00JvV34WPLoCtwWH+evksGQEiZfuOBv7745NttYArx0RzpWc3N
	Aamv66czDgZkMhwcXgtdgYKHkJszCxFvOYKhKkyNOO/vM+Cogdj50ZJCwGpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724053685; x=1724140085; bh=3lTmmucJapXvslgIbw0siAZSJ3YN
	ihy/MgWWBJ7hJy8=; b=HB1pkw377XGkiHV6sqBOxre2fEn/Ui5OCCo3LbO/Im/e
	s4xn9uzvT3NHPrVqOJqFhx2CWySioYiUdZPeDSFp3FZ4dKNTFfa2XP7QnC1uKU/d
	7423LXMiewmjy8tdowfMHka/nzHLECWe1hC1rTmIKrJnb0eQWpj00ERvK291qIr+
	pcdowiY1xHr3bcGVJinqAYzZPsZcUHaI4pC1AUY7OFuAIThSqQ0p4KmD5sQY+dz9
	3TRfebxWdNQkUJp2UcjgSizTLlV/+yU3Nh7htN8pPELRIltT5j7VyJnHrcQeLV2C
	JkMOEkRrsUYcXaq1T6ctGPiAWBejAvcDarjmylOFSA==
X-ME-Sender: <xms:tfjCZgSYXNLVoGdZdEBIOLGUtiPVcA7s0Up1zlFGX5mteWe3Tx68sw>
    <xme:tfjCZtxtpqVl1HuyTwS6bw-Qj5ozo9X9A4HQS27CYvpjoQNtLu8U2l5FefBT9Snj0
    t4GNiTHCe3t8geBaw>
X-ME-Received: <xmr:tfjCZt3GwBRzSIH0zJZHIKzuN1X4s8NsxPuavdklLREbu8XBo10bhsw52AJIEsy6keevzqRAJN_7RMiURbd4MO72Or4zsjjyk7cTVHgGi3OGCj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tfjCZkCmXkdRwk9D3UjU6NJg2dqsAlf8sw_Adetl30TFjPT8XDAx0A>
    <xmx:tfjCZpgN7mtC7TkWwNu_Xz2_umoceMosjycENMXb8C8q8qyaL8uWug>
    <xmx:tfjCZgr2mK00FDyHf8BOYcvuSrnX8VsljksXT4yNF45BjtM5ub_Ysw>
    <xmx:tfjCZshPA0fcG7HjqNMOORpo2CSybN5uQo42RmSlb1bMUok2nctVtQ>
    <xmx:tfjCZkUG8C-LoArHWummacl-f3BFSgmQ0s3p0zVzSbwm4GeS_64CKJ41>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 03:48:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09323586 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 07:47:34 +0000 (UTC)
Date: Mon, 19 Aug 2024 09:48:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] t7900: exercise detaching via trace2 regions
Message-ID: <9712aae82bcb51dd94fdc10f4156e9c78e4b6d8c.1724053639.git.ps@pks.im>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
 <cover.1724053639.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724053639.git.ps@pks.im>

In t7900, we exercise the `--detach` logic by checking whether the
command ended up writing anything to its output or not. This supposedly
works because we close stdin, stdout and stderr when daemonizing. But
one, it breaks on platforms where daemonize is a no-op, like Windows.
And second, that git-maintenance(1) outputs anything at all in these
tests is a bug in the first place that we'll fix in a subsequent commit.

Introduce a new trace2 region around the detach which allows us to more
explicitly check whether the detaching logic was executed. This is a
much more direct way to exercise the logic, provides a potentially
useful signal to tracing logs and also works alright on platforms which
do not have the ability to daemonize.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  5 ++++-
 t/t7900-maintenance.sh | 11 ++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bafee330a2..13bc0572a3 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1428,8 +1428,11 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	free(lock_path);
 
 	/* Failure to daemonize is ok, we'll continue in foreground. */
-	if (opts->detach > 0)
+	if (opts->detach > 0) {
+		trace2_region_enter("maintenance", "detach", the_repository);
 		daemonize();
+		trace2_region_leave("maintenance", "detach", the_repository);
+	}
 
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected_order >= 0;
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 074eadcd1c..46a61d66fb 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -950,8 +950,9 @@ test_expect_success '--no-detach causes maintenance to not run in background' '
 		# We have no better way to check whether or not the task ran in
 		# the background than to verify whether it output anything. The
 		# next testcase checks the reverse, making this somewhat safer.
-		git maintenance run --no-detach >out 2>&1 &&
-		test_line_count = 1 out
+		GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git maintenance run --no-detach >out 2>&1 &&
+		! test_region maintenance detach trace.txt
 	)
 '
 
@@ -971,9 +972,9 @@ test_expect_success '--detach causes maintenance to run in background' '
 		# process, and by reading stdout we thus essentially wait for
 		# that descriptor to get closed, which indicates that the child
 		# is done, too.
-		output=$(git maintenance run --detach 2>&1 9>&1) &&
-		printf "%s" "$output" >output &&
-		test_must_be_empty output
+		does_not_matter=$(GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+			git maintenance run --detach 9>&1) &&
+		test_region maintenance detach trace.txt
 	)
 '
 
-- 
2.46.0.164.g477ce5ccd6.dirty

