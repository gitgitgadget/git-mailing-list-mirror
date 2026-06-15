Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4F3F23C0
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528401; cv=none; b=BvaTYWtK49po0x2EzMnyCj2pBnzBYD3Ap+XYUShOnKi8pnEdzsSk2TQyVEFqu/LqXZHR97aMdkbLQrE1HpUtRkSQR9FTrnL4TI1U0dMujkCBgzNBCG5qvuLenSGavZPVjeR2QPv/eRFkDJmhsTldAxWuJcIIklV7FEtkC97QzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528401; c=relaxed/simple;
	bh=291q+WSSWnirUIELJoxzzlhEG+Konpwk2Ki83H3pbL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZA3cjqt/2wA01ksXtS6ycHUPBjtn3YRE62y+se7vGgjLT+p9fDuK8fII44i8U7iAXHLaaIK4rztYVskvTyywetDGpsN6WE3kInQFCpNzZRyba2PeYEWgkpR4eiRH9uVR+9JWBvDU3jV4Yr5LpGA8wyU7I8L5qRU+9UofIQzRd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZQuYteNo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TBTH74mr; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZQuYteNo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TBTH74mr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 59C23EC0203;
	Mon, 15 Jun 2026 08:59:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 15 Jun 2026 08:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781528398;
	 x=1781614798; bh=yweRGq7/sGTJOqhffMBB/6e6mhvFerMUji31ZVggwRQ=; b=
	ZQuYteNoXTzI+s6sFt7stI7wLWVt9j4kRb0edkIBKguotuEJxxBycBNzMohgIUBg
	rWIeKp1C6xjDfvaHnIsmjJogBllKBPyBvA6mban9UXbX6pzfQYv4gQRsPv3M+TYW
	T4zCIINhvxM6mjxMSqlg+ebweihA/zcDEs+bEcJlOa48pYklKjCLEupoIYCciXXZ
	b0jo1wUIIog8ZitwLaUD9aEMA7YXUw0qGgMvEhRfpN+vvgU70VoqmcFFt2cwCgZz
	dGIJNNhsCKeuBdCSP441YiiM2q/f1iYgcmPXWqUxsonCqIipJ76jnX7poA+uXcAl
	6oqNoU3P4/Mo+TD7MpUqLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781528398; x=
	1781614798; bh=yweRGq7/sGTJOqhffMBB/6e6mhvFerMUji31ZVggwRQ=; b=T
	BTH74mrzmpmxkTbpf3eDMD99dxWFL/tFsMLJ+qcdbYJo2YyNTI8lWP3hPhyuUwxx
	noxLPN9HLPrJao3eE0hlMxS5IS358U5pgHH2Z/K+cdJV4eB86YC302CR49wOby+1
	iuzUBJcdWUTqiZuMvvrrBDYbPEqLdSFcHw+WszreHFKNX247KeZGVKMY5ZlxnUzG
	5NlrpCY8kMeG5biek6qmvGNSgusC9Efv/9bxK41knfk/3N2izEZBdW0iV+IldlcV
	Ic2IMHsVKrgyuf0IBVfIdwJ49n+Ops/PPt4yeEJ2hsmtQ8lZwo1J36L5L/dfO3F5
	RUTpo618Fef8ITVs+IjMA==
X-ME-Sender: <xms:TvcvapcCoCkywdKKgiBCxyjbbn_rEv-gUlp48GKtcEAwtIw7L1gZuQ>
    <xme:TvcvasJ5Nd7LfdwH7Bb-4wvxUReRFi_gxbBVg1KsaL9FdK_fNdQWGBklOC9z654NF
    cz3qs8w6gBV04KGMnlrdi37GjY1yn6FgEIMUkOzOOzZ0JVfgAvSbw>
X-ME-Received: <xmr:TvcvamxTgaQUDMXRwMSJZM3plYZi9VUTdDdfK0vPPL7R7qso-x6uVBXkuWpaHAeoNJquNKI-LNBv-nSIfxz7OTqZekHyX2auRmWiu0Pikw>
X-ME-Proxy-Cause: dmFkZTFaWKqrbGiK/MQLmoMBo0Ls31+NgkSWqalw8WjdwdDnFzohSPXOkrgBQLz0Dxe3sn
    zUDW5PIfL3Qi4Sm4ehgD9SNHbjsj9fBgLLweWlJ16/+P6gWbEbS9qJmU4Rql3hmR3jSmnN
    Ip/vdL3+ANw/YirnR+MH78Gkr6SiBp8zL/g/5E5uawdRgYH8baXf6AJgDO3SiHH4uSdcUR
    sCozLkoGvtbnQhaNd6nP4GBN+FhnhI1JGAPcUft4cepMhdQ/FzqeFTdnipUmFAfcoTmap3
    e25RAUmuJY7/3gQYdEFxJqU9LNhCa7jovVg5PvG2Vf6cZoHOoqKCeEv05MFQTFY8M41wC0
    u8pBCJVHI0LtiH2Nyec9ni+2WF/OorOuGGtll6ARWo5W+pWshIFKmdHouuQVhrS8SiyKw7
    Y9GLXt/1AXk16Ojs0rUGJBdlSU6kDg7hrdtQ10nvKLdcnbcRoNKwzleVaAzRlOqclnvYdS
    PGgn9YE/3djDKRwmv1zPpeICXELqKN4Y0g0RQ8h/eiy8ZQhEEdNxnJxEeY3od4Gafe3eHe
    rhrsMosqkmyE7TJEBybapN3uhtO910iD1yRDu/0x5mBQio68sK3m7yVSCRCEoW7QCPTsBr
    +5hGRx3aWNNNz/aA7AO4ik2024wCKIWybBBYi7lXYopvutR+FZqJZZvuNRbw
X-ME-Proxy: <xmx:TvcvaitDNd2oVPszfk8pjF1k21_On4J5OztdnW8YFlxhSWXkmctLMA>
    <xmx:TvcvapA3sQgvq0SqcA6jT7aJJL62PmKTshCcAdt_-MBRN5exk-nHCw>
    <xmx:TvcvakHv63uYpMZQKGeTeJnRc3RJdjHlpLkTFW6akH-RfbTIukk59A>
    <xmx:TvcvapB9-x2kVVc42RG6yR0Ui_Us6BRbx6yWsElHG4KVhFCpZwDFGA>
    <xmx:TvcvarPILjpg_810cMj64EuRU3f74A09HQviVJXQFehmDyBMHxbGCYKO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:59:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed3a4bed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:59:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 14:59:43 +0200
Subject: [PATCH v4 3/3] b4: introduce configuration for the Git project
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-pks-b4-v4-3-22cfca8f19c5@pks.im>
References: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
In-Reply-To: <20260615-pks-b4-v4-0-22cfca8f19c5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>, 
 Weijie Yuan <wy@wyuan.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

In the preceding commit we have extended our documentation to recommend
b4 for sending patch series to the mailing list. Introduce configuration
so that it knows to honor preferences of the Git project by default. For
now, this configuration does two things:

  - It configures "send-same-thread = shallow", which tells b4 to always
    send subsequent versions of the same patch series as a reply to the
    cover letter of the first version.

  - It configures "prep-cover-template", which tells b4 to use a custom
    template for the cover letter. The most important change compared to
    the default template is that our custom template also includes a
    range-diff.

There's potentially more things that we may want to configure going
forward, like for example auto-configuration of folks to Cc on certain
patches. But these two tweaks feel like a good place to start.

Note that these values only serve as defaults, and users may want to
tweak those defaults based on their own preference. Luckily, users can
do that without having to touch `.b4-config` at all, as b4 allows them
to override values via Git configuration:

    ```
    $ git config set b4.prep-cover-template /does/not/exist
    $ b4 send --dry-run
    ERROR: prep-cover-template says to use x, but it does not exist
    ```

So this gives users an easy way to override our defaults without having
to touch ".b4-config", which would dirty the tree.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .b4-config         |  6 ++++++
 .b4-cover-template | 11 +++++++++++
 2 files changed, 17 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000..fd4fb56b6d
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,6 @@
+# Note that these are default values that you can tweak via the typical
+# git-config(1) machinery. You thus shouldn't ever have to change this file.
+# See also https://b4.docs.kernel.org/en/latest/config.html.
+[b4]
+send-same-thread = shallow
+prep-cover-template = ./.b4-cover-template
diff --git a/.b4-cover-template b/.b4-cover-template
new file mode 100644
index 0000000000..ab864933b5
--- /dev/null
+++ b/.b4-cover-template
@@ -0,0 +1,11 @@
+${cover}
+
+---
+${shortlog}
+
+${diffstat}
+
+${range_diff}
+---
+base-commit: ${base_commit}
+${prerequisites}

-- 
2.55.0.rc0.738.g0c8ab3ebcc.dirty

