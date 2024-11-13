Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA21FA256
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497074; cv=none; b=cNKJd8HiXe4UnpyhhBf3DCfgIfuXvksxbN2+aSlM+wbK2u5tgYN/4yQOqzDY6d3b5uoc23BfctasCj8/LHdg5T9L2z2GDVOgJDR9G6fAymLz7q78JGY66D5qi8PLrPv+pdW/qsLWwyQVwFOqOBKQfizFgnKwE7DN6UjB1HRudWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497074; c=relaxed/simple;
	bh=yxmlmPxgR3jfH/0ej7hpOm07/jpuxP/V9gnHoGx7VS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t/pe6PWUjEDEKrrTMRPQTRPbh85Sec4lotfpncAqhW6yX3OKMm++4cTN34iMRxPww/zBeggtIOZCRbxebMehUodI5EaDwU6v3NAINbABPYAZzOox+J9sZYPo+YTMxVCg2XmhCvwKYU4V7KurjJqH3gSl6WHoggYBBasxqwPLScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ih/skZYz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STYhv6JV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ih/skZYz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STYhv6JV"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AAC6F1140173;
	Wed, 13 Nov 2024 06:24:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 13 Nov 2024 06:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731497071;
	 x=1731583471; bh=roFsHEKMeqbQSZwSkJMmbyfTvq3XUgJ3HoeJLgCJkAg=; b=
	Ih/skZYz0LQQUh4EtM0WtmGPE8kJkEunKNNHrLFBeGJt5/8FEhPF0wOq7SFIT1qY
	hsQISrE1sfQQzEoLHOZgJ7TJmPpk+eTjYloZLzUm6jX9LLSU+bFFTPXttpSfxjzo
	mQ/PHZ4a5/glJOgxiqSFZYIGi1GR2GC5jVaRNSn8CiqE9QBgsGi9sxnHxiUOITV4
	kYxsHAdv95RJvzVO55kBopc0IrsWNA/CvDctOLNSgCJxiUrIlWMR+RikiiPe3nEp
	kSh+fjgIExQgxfSHxl5PKdeWYJGvRo+u2Tx7TkHPEMnonhuOzBwSYGbNgev0uqqA
	Tau0NZe00PsoRux70MJrLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731497071; x=
	1731583471; bh=roFsHEKMeqbQSZwSkJMmbyfTvq3XUgJ3HoeJLgCJkAg=; b=S
	TYhv6JVgfqEX1msDxSR7oUpuWCRTllosuVgX+u+Z3m2hED0R8DxPShrlKwafFkJr
	5AfOFQWOQD/X4XYc7Pjd7Ev9gj0Nhct+Za9U5YAGuV1inQEX/tgaNzaW0zd7KBXV
	wCHN3Jj2/kAOwGnp94r+rrsIloAOcCyNGjkNMkyLVcQMrruVi5dR5A9GT8nZFbYE
	hIFgYYNT2sJqIT5X04jsgx1Z8eatRLEc6yiiLwNS0jlejlPNYa4q4lf5II7XfSIR
	C5vMLmrLvt2q+D8MoY52R3Q8ptTXd0iGg6EU/xqkd9hNyf5kV2zIQ7ovEuf8RN5j
	3YfDln6KHm8HMrGtuzF3A==
X-ME-Sender: <xms:b4w0ZwB58ZdNs3pmyNgu00o05yi2_uzd6cWhaw6snTM_yWIhrEUalw>
    <xme:b4w0ZyihfHifood_SSUYH_HdeE-5f4TWHzL83h9TnDAPvvseP_HWPzg3R1xemBEtx
    q4_xLCnC6KzVF7OPg>
X-ME-Received: <xmr:b4w0ZznmGn5k-ujhEcIklahRjuGDp8EmglgHK-QLMT6ogIFGSMHAHlgIZRMZDxC6hZI5zrRNYo127zNnU3hxd_sfrGtAFgrQ_fq8W8paKSRA6nw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiihhhihiho
    uhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:b4w0Z2youssjPYrtFxj0MAK0nYN3sLS3Gp1zbdRiFzwcqbhCd1jc1A>
    <xmx:b4w0Z1SCnpk0WKPFT3IXbEIMHskpxmDZW6N_5iJCQgNgStiiQRHObQ>
    <xmx:b4w0ZxaS608G8AlJ40oabyg0I9fipeUcbHlHv2IvfAkx-_-ewT8DpA>
    <xmx:b4w0Z-SIct9HfydMqSaYopedmnEpp4sVX2lXRX0jE_n9YBZ7uZveJg>
    <xmx:b4w0ZwcGUP999QwqVDV3KUqeXOS7jwZh9iRLEM4tD6wXiFlzlGlNqU96>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 06:24:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e27f438e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Nov 2024 11:23:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 Nov 2024 12:24:17 +0100
Subject: [PATCH 2/2] transport: don't ignore git-receive-pack(1) exit code
 on atomic push
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-pks-push-atomic-respect-exit-code-v1-2-7965f01e7f4e@pks.im>
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
In-Reply-To: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
X-Mailer: b4 0.14.2

When executing git-push(1) with the "--porcelain" flag, then we will
print updated references in a machine-readable format that looks like
this:

    To destination
    =	refs/heads/noop:refs/heads/noop	[up to date]
    !	refs/heads/rejected:refs/heads/rejected	[rejected] (atomic push failed)
    !	refs/heads/noff:refs/heads/(off (non-fast-forward)
    Done

The final "Done" stanza was introduced via 77555854be (git-push: make
git push --porcelain print "Done", 2010-02-26), where it was printed
"unless any errors have occurred". This behaviour was later changed via
7dcbeaa0df (send-pack: fix inconsistent porcelain output, 2020-04-17)
such that the stanza will also be printed when there was an error with
atomic pushes, which was previously inconsistent with non-atomic pushes.

The fixup commit has introduced a new issue though. During atomic pushes
it is expected that git-receive-pack(1) may exit early, and that causes
us to receive an error on the client-side. We (seemingly) still want to
print the "Done" stanza, but given that we only do so when the push has
been successful we started to ignore the error code by the child process
completely when doing an atomic push.

We'd typically notice this case because the refs would have their error
message set. But there is an edge case when pushing refs succeeds, but
git-receive-pack(1) exits with a non-zero exit code at a later point in
time due to another error. An atomic git-push(1) would ignore that error
code, and consequently it would return successfully and not print any
error message at all.

Now it is somewhat unclear what the correct fix is in this case, mostly
because the exact format of the porcelain output of git-push(1) is not
specified to its full extent. What is clear though is that ignoring the
error code is definitely not the correct thing to do.

Adapt the code such that we honor the error code and unconditionally
print the "Done" stanza even when pushing refs has failed. This ensures
that git-push(1) notices the error condition and exits with an error,
but slightly changes the output format.

This requires a change to t5504, where we previously didn't print "Done"
at the end of the push. As said, it is hard to say what the correct
behaviour is in this case. But two test cases further up we have another
test that fails in a similar way, and that test expects a final "Done"
stanza. So if nothing else this at least seems to make the behaviour
more consistent with other error cases.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 send-pack.c                     |  2 +-
 t/t5504-fetch-receive-strict.sh |  1 +
 t/t5543-atomic-push.sh          | 30 ++++++++++++++++++++++++++++++
 transport.c                     |  9 ++-------
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6677c44e8acd19f16706ad2d78f72fee889daa55..815c1f206c09da8fb1ffe9be11beb9c5fa29d0c5 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -630,7 +630,7 @@ int send_pack(struct send_pack_args *args,
 				reject_atomic_push(remote_refs, args->send_mirror);
 				error("atomic push failed for ref %s. status: %d",
 				      ref->name, ref->status);
-				ret = args->porcelain ? 0 : -1;
+				ret = -1;
 				goto out;
 			}
 			/* else fallthrough */
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 0a3883043baf5c4c0fc43b52e8c5fc375f10a56a..b3774e56e0f45a91d574a15f0d6b5c50c4da70d4 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -105,6 +105,7 @@ test_expect_success 'push with receive.fsckobjects' '
 	cat >exp <<-EOF &&
 	To dst
 	!	refs/heads/main:refs/heads/test	[remote rejected] (unpacker error)
+	Done
 	EOF
 	test_must_fail git push --porcelain dst main:refs/heads/test >act &&
 	test_cmp exp act
diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index 479d103469527e6b923877cd480825b59e7094d4..1d8f088a004cf6743ade8e55536f04ac04000cf7 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -281,4 +281,34 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'atomic push reports exit code failure' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict 2>err &&
+	cat >expect <<-EOF &&
+	To ../upstream
+	 * [new branch]      HEAD -> no-conflict
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
+test_expect_success 'atomic push reports exit code failure with porcelain' '
+	write_script receive-pack-wrapper <<-\EOF &&
+	git-receive-pack "$@"
+	exit 1
+	EOF
+	test_must_fail git -C workbench push --atomic --porcelain \
+		--receive-pack="${SQ}$(pwd)${SQ}/receive-pack-wrapper" \
+		up HEAD:refs/heads/no-conflict-porcelain 2>err &&
+	cat >expect <<-EOF &&
+	error: failed to push some refs to ${SQ}../upstream${SQ}
+	EOF
+	test_cmp expect err
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 47fda6a7732f4b8cdcb6e750f36b896a988ffd0b..76b0645a25fe936190ca52d595b5f02eedc27d23 100644
--- a/transport.c
+++ b/transport.c
@@ -921,12 +921,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	close(data->fd[1]);
 	close(data->fd[0]);
-	/*
-	 * Atomic push may abort the connection early and close the pipe,
-	 * which may cause an error for `finish_connect()`. Ignore this error
-	 * for atomic git-push.
-	 */
-	if (ret || args.atomic)
+	if (ret)
 		finish_connect(data->conn);
 	else
 		ret = finish_connect(data->conn);
@@ -1503,7 +1498,7 @@ int transport_push(struct repository *r,
 			transport_update_tracking_ref(transport->remote, ref, verbose);
 	}
 
-	if (porcelain && !push_ret)
+	if (porcelain)
 		puts("Done");
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
 		/* stable plumbing output; do not modify or localize */

-- 
2.47.0.251.gb31fb630c0.dirty

