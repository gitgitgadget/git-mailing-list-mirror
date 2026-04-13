Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF83B6360
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073800; cv=none; b=vAiwIPiv+FuaAG/MptuAeO2szfpOpFP+NxanguedeE7cBddueP+rJ3Z8HJYysCx63vNlb9N4MOjWHVt4IazuDl6c4DLC7oQNKcwTwon8Jv0KK8Pogc0Qfua+Wwy2e582EA9jHk5OUN7BjlhQz8KizYn0PpsBtDoWuFwHWv2632k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073800; c=relaxed/simple;
	bh=gn8auLOrHNxA6H7Q4OVvGp+79aLMJYeInV0mFplNbK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rtdo4fYNR4tslH9uQKE8ho15GH9Xj9iTfKhUpwlNcWv9wrXr5BnFjOWYcZktjgb8i39zrx2CaGh1fz/IWG8tqyfiQyKko70YtplAJdANxb+oTUu0f4nDuC/XgyBDJvTvkC9CHYfmususOj9Qn2qqCECXzSxsVtpmDNnwwWCq4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vMIS79LR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqIwSC/C; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vMIS79LR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqIwSC/C"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 33422EC0436;
	Mon, 13 Apr 2026 05:49:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Apr 2026 05:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073798;
	 x=1776160198; bh=uJ9VTp3qCKqZduVCJ32+7aVSJW9XgXOBEI2GwaDMhhU=; b=
	vMIS79LRuOh4Or9NiG06dwXmwH5+sINSrAynG40qI1k9hohbeBwDAB+8ZF1RufwP
	yeG5pOxXje2+lxKDuB+WtXcZe6IkWHspKaG/1n8Pi/JwOcddDyGpOE5L7pM1m7Do
	JQx56NbMi1mP17KmJ2gK2byFj97mIZaSSG6RxC9ImhvNa8x9HOlIpFTTNIoO0w6I
	68iwUUppPKd8L7rIaeQKDXJ+JM4voVZI8xDaMNXrIVzaGabHl8WqULPNgZHrVrKB
	IKY6WB2Qb6w9PLPf+VIWBmbIJc/IDDFG9SbdHNcetSnPFldlqy9DUAAHkClpJXXE
	oNjmluY2ve2taTYpE9Re4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073798; x=
	1776160198; bh=uJ9VTp3qCKqZduVCJ32+7aVSJW9XgXOBEI2GwaDMhhU=; b=g
	qIwSC/CjgAhZdKxmrtCABONVB1Z0/GDQlRUb7kVbtUFPrXps2rmu7eDkawYP0Mnf
	y/DDpkhQHs81Tt82yaSibwVRJseEdnAlIQhwCz+fDQhNADSHW0diwKCUALXI8EVK
	7prt8ufr+7bW9286G1CyefPAOF+tDJM4bnIe4HJzCcheY/gIWGpbDNaJXYpgRHZf
	85inYb24YdcloIK3W/G0NNvJ0KJ8v1nKtwOw4QngQGgTz2stau+rqMctYmnRxLWs
	nfGbfj8N5HjBqZEaeYNg9Z/FFm4n1PyzKl8qMdboP3Z/jU5YlQ2iMxKmppBGM8Ml
	YzjzllA0BzGIglnVxb/oA==
X-ME-Sender: <xms:RrzcaajlX-nTBRRSu0NUuTJG0qIuymi484E9_OWk5ecziX1V1LV_pg>
    <xme:RrzcaRBYncWpADsrpc3wNzPiEBJUgdw-Dk0dJ6W3SBkLOwzEdEwDMwBA8Gr5SuEiu
    gyXhkCHSlvUAgR4nSQ6jSbtA3hBUQYSkLFn0Lxc03WaQdUHBGdFBPc>
X-ME-Received: <xmr:RrzcafvUJcQ61DQi5YgTmYxVhHTJB1p8yqwlvFpOjahv0vIjf9nWhdGj0sFPlj-VGKQWjZIB91_hyJP6Ft8b4dA-zW0dmHQcsT_rkGLBr8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetje
    ehudetjeehhefhheejteeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:RrzcaeZ5s6rypvxfv1Vo-u1G_28F9QG8gkD8c3rMA5LMwXAL1886gA>
    <xmx:RrzcaaUIvqtnH4iYyWIJQclHZHhSlZbmKxnnc2qJjAuZcrz4KEVlfQ>
    <xmx:Rrzcaa7XYYeZmSD40dBYOu5wAaGs4Gjd_tellYa5DGFRLIa7veTk5Q>
    <xmx:RrzcadjbayB7Hp-GNhkkKUAftBy-Snn0GA7P7BHySb5mGzMYTZBREQ>
    <xmx:Rrzcad7nIOpqYYC-CQCMTHmfP8SBzGu1jK_6ByvapPAX_DsDwqRxuxPr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ea03b6f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:33 +0200
Subject: [PATCH 12/12] t: detect errors outside of test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-12-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

We have recently merged a patch series that had a simple misspelling of
`test_expect_success`. Instead of making our tests fail though, this
typo went completely undetected and all of our tests passed, which is of
course unfortunate. This is a more general issue with our test suite:
all commands that run outside of a specific test case can fail, and if
we don't explicitly check for such failure then this failure will be
silently ignored.

Improve the status quo by enabling the errexit option so that any such
unchecked failures will cause us to abort immediately.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 81380fe978..c493e3c768 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,10 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see https://www.gnu.org/licenses/ .
 
+# Enable the use of errexit so that any unexpected failures will cause us to
+# abort tests, even when outside of a specific test case.
+set -e
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

