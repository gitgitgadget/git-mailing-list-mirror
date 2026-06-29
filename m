Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FF537CD5A
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747036; cv=none; b=uWCXZw76xBc1U8MTeMb/JLKwbHd1x7qFeVgmd4yacF5rlHmZZ9SLCj5sHpzw8O5lvcAaDKosVw5FqX3weKxRPmKqJ/TD9Ol4tOlmkYaeyXpJ3s6dXdrXfrg9X0EMGqMyY9/N9zv6xpeZKZpv4aRsuZL6jJDy6jBJ8mZUma719wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747036; c=relaxed/simple;
	bh=M2j/zWMJKenRhcxZh9/RJ52JVAgJjv7s3KQ7T26Ct8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spIXgElNXQG/CeHIbY2sRsERohywpCpoIWvDLhKB7I2eRtojMFahYu7xRkQh9/xHA9HjVKTSqH52t5QO1f9VRhb6e6JhNKvLce3SCs9U37lxUgX/zcSUrvag1HLQoXo8jueF2MVRZiJhRulTaptTAAFw8COfjYJ7FhGCPe7d2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zz/mT/75; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ieVMkO7S; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zz/mT/75";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ieVMkO7S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF7A21400101;
	Mon, 29 Jun 2026 11:30:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 29 Jun 2026 11:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782747033; x=1782833433; bh=TieEEVaw5Y
	uuz7FV702FvAUg548dp+IZAAxsbuI+blU=; b=Zz/mT/75LX0JoWmYOBOXJ/p4V4
	hPtzoBmk6BX9Lfn/NyVxRn5mJrh0TvdqOx838nf5cS2kpT6+XT5C0aAQ75mclADZ
	B1CuFtoXjSZMfIoESTKSUZtL+kxN1dVSKGhFu74hS12tSiSgFlzJeEfHfta2hUtM
	stDyyJhivFLdQ4Zyr40xjOX6TBlRFkBtczQcYxavcGnZSUNRVPUgSbTxkX3ZFIl2
	SHPpOpGeuu4uAKVM8Yi1sGWrelofPMWwJvI69JiSeqr2kVIpKHdoiaXjlnSBC3qj
	5RF8iTpTbbBttBjJblVmyMnAykU8TR0ye9/h5TRBXiSj+tfbb+l0G1VGAJVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782747033; x=1782833433; bh=TieEEVaw5Yuuz7FV702FvAUg548dp+IZAAx
	sbuI+blU=; b=ieVMkO7SKbP8Zs9jr1sF3YptujSffISu+IqL5Vi/Jw1MDUaoDVk
	agAjZZi5f1ZJuqNa24HYYxPyVT2Bq6NKAvwsKUdi+B+K9jcKGixZRDgpotKvQWQ+
	ANAAtGy1gctfT94iQTUFQ+7or47KY9olPOOcWSgS0MJZvL4i82G96/KFb2W7d0Mn
	meG/4R2z3CZXLWdmvfpgO58+aM+ZNat6OkZvMWNBAxi8vTY3xTL9XhtmTsI5IUS9
	TwlhF2Rt4urcin21a4hQUSlVOefLHugyXbwSGwSJeF7nDNgx6K4Iin1HK7HbJX3+
	N5n9guB0ncUYD1AxsnP5x1xW8PPOc6e2AwA==
X-ME-Sender: <xms:mY9CauKJH9HlVJnePLL3IW7aj86Cj-rLP3M7gsZPOPOWyWcEs3uRmQ>
    <xme:mY9CasJgOlH5ZweVpPSMRJWgukPzLePKDYyd92QZuV-T4ctgJcaUkRIwn_IRg2Qel
    zT3phLgURfmyIrHkE5Scz_Ik7HS-qjZ21g9DHYazOVlKCJQNjEJ7kA>
X-ME-Received: <xmr:mY9CasV06qulm4PY_ltFgYCL-cUwWzqdi5ZYtlJjdOuWuSvAnMfpoMQMj5rhEkDTCCt7eNr4ZdHgPl9l-Cg4kCnYJPkVpUbbehuNaQ-qFR1I>
X-ME-Proxy-Cause: dmFkZTFQvPCPOJV0h3jvW+N70DqVuqIrSqJPyebGBpNRtxGLAMi3y7ll0Yo5+hcsSp0mpt
    q2/hBzFnxIb2h+oZo20cqTOdQR6jB05tpwYSML8wUVBUj56gMHtlx+brH90SHY0L/EDHGh
    mXVdksgXmny0eFxopBoUFnuU9RJonzc8pz7f2ouJgcRJegdFkvIfN2EdASY0RhLds+SzCF
    9ZKkNV+F2JEtQ/o2J3YWPZVE7MAQMOczFLXTVlzkFOnmLtsRWA5o3bf39wdfZsK7pGfzL3
    CFJFhnDy+2/4KH++NZVdQF96+ZlX3jPm2fIFVupOuvbSN29IVTCT6mXWfCfLRmUAFOYrc8
    97v8IPhfIt514mscRvsqJhb6WZllLOidDPwpbjRHNS0CIwOiTrtS6u1ch1TzTNtU/q5lXV
    fqgHPUqf+4pn4Td4fzvsl4vgdOEYdwPsKojA1JIT0C7DohL1tZEn4xu1h9no4ung07B7Gk
    Y4+cRdwe0yuEELaGTmyobSlR5gzsnd3dNQkgNQMpAepd5Qbse0bonvZNCbiDO+Yx4kQmPP
    gMLIhBCsQSaZGKH5X/mo2+812dffD6vGihOauBUx8xSi/q+uF7fS7Ovkvw+4b9rDyAig8U
    MbyChGafhE9b6IXuiP9VbiFklqsG4PfpT10oiA1+0imu4MKXzYFhJllD+9hw
X-ME-Proxy: <xmx:mY9Cauj-Mns_UcpPAT_dzaTqE0g72KCZ-9biqFgrcnOP_oMLoHdjaA>
    <xmx:mY9Can92YV1HqPRBWXcY1nZmPbUcWxhbMfXp4UDsAbF1QQwXQ-oWkA>
    <xmx:mY9CaoB5oU-txx9hm9u96tkXB-lV7TLD0jJx95Y_oVnyBXZH9fnYeg>
    <xmx:mY9CakJuftihML4fFDseRr6kT4OlxoVPHJWY0ldhaVZyc-L-uGyzzA>
    <xmx:mY9Cav7SpIURaLKMAqtow6sFSELd_DpfHAFDxz9_OA5fKtS1FWyUYhge>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:30:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd786d88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 15:30:29 +0000 (UTC)
Date: Mon, 29 Jun 2026 17:30:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Wei Hu <weihu.math@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: receive-pack hangs on zero-object push into promisor-shaped
 repository
Message-ID: <akKPjjfabiRkTbtt@pks.im>
References: <CACLXMtCSzW9BY7idqB1yGa87MeG0Y2FN5Ho2hRXuPJ_qswE27Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACLXMtCSzW9BY7idqB1yGa87MeG0Y2FN5Ho2hRXuPJ_qswE27Q@mail.gmail.com>

On Mon, Jun 29, 2026 at 03:10:42PM +0800, Wei Hu wrote:
> Hello,
> 
> I found a reproducible hang in `git receive-pack` when pushing a ref update
> that sends zero objects into a repository that has promisor remote
> configuration and `.promisor` pack sidecar files.
> 
> The same zero-object ref update returns normally when the receiving
> repository is a normal non-bare repository or a bare repository. It
> also returns normally if I remove either the promisor remote config or
> the `.promisor` sidecar files from the receiving repository.
> 
> Check the attached script to reproduce the bug.

Thanks for your report! I was able to reduce your test case to the
following minimal reproducer:

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 1c2805acca..2850e78e49 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -723,6 +723,28 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+test_expect_success 'zero-object push does not hang' '
+	rm -rf src dst &&
+
+	git init src &&
+	test_commit -C src initial &&
+
+	git init --bare dst &&
+	git -C src push "$(pwd)/dst" main &&
+	git -C dst config set remote.origin.promisor true &&
+	git -C dst maintenance run &&
+	for pack in dst/objects/pack/*.pack
+	do
+		>"${pack%.pack}.promisor" || return 1
+	done &&
+
+	# Push the already-existing commit with a new branch name, which
+	# results in zero objects being written. This used to hang in the past.
+	git -C src push "$(pwd)/dst" main:topic &&
+	git -C src rev-parse main >expect &&
+	git -C dst rev-parse topic >actual &&
+	test_cmp expect actual
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

As it turns out, the bug itself was fixed already via d9982e8290
(connected: close err_fd in promisor fast-path, 2026-05-15), and that
fix is going to be part of Git 2.55 (which is due today).

That commit didn't add a test for this scenario though, even though the
commit message points out that there's been multiple regressions in this
area already. It's probably worth it to add the above test to our test
suite. Is this something you'd like to do? Otherwise I'm happy to send a
patch.

Thanks!

Patrick
