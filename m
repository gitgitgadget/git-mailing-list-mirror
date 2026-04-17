Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F13BB9F1
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423092; cv=none; b=X0/KWEhuOep0lkBMRJezHJ8gBEiokuPdadem0wVj7zBFgn5eUUwMAnkg6guxCuBbsdLW0HfVWz+A0zOf3nwXPsARPtu1ZE/X0Fcic/5YaQumj+gLVdDJNJWHWSseGP+iIlPmWuB2N2+ErAx5IMbNh0OxufWc9KujzXYNObDsjL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423092; c=relaxed/simple;
	bh=Dqxy33CX5R4Qaf9T3rk663knoZQ08rKY6d5Y3c2puPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KqAFFD4pDvTeX+YLDOOwWwSk9ALsYosf0TJuQEDnk1N53xZYogAbFuPFDEtmQWodyn7ZwBK3vfOzJ8n9R18JTr+PnyBycw2/awy/ifdPpZXK3WBzMukbuFeD/XouLdEyeTX1VB2/VSlgOal+nxbUs98sQy9Q/1b99FbvXdglMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ee22tU+S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNdRWjOL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ee22tU+S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNdRWjOL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2993A1400087;
	Fri, 17 Apr 2026 06:51:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 17 Apr 2026 06:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423089;
	 x=1776509489; bh=Xj0s+aZBRxfUtEbxTEJcL8CLA+UUNpkqoqAxDq/3Y7c=; b=
	Ee22tU+SvP5ToXrjqG9RYhQa39+njbQoTgNRqz26/30IGBULMvSQ+RpELRb6skeM
	oIFhnXKewD4fIWUQTpAJ+xxlapI5mGNf6df9RvW6jGAfa3GOavho7E62Z+zfy+1v
	JVjwERXxp6Lr7jlbovrzt/jFgIdQe/GgvLgsjVvcOMbnpVFPpYYLykseK3Ejn2Rp
	ba2h4EYaQGWY7xp8GaxLwDCm55YJL28uPxuumyAJ3wh/642VbQ5lHm2v4Rvtdmdt
	WS7fCnKqlXYHTbJVJvhDd+6cKN+DVTJ26/IN/zHde3mYeXsxb8qgyTxz8cBrn+da
	V3if6BmqiIVnZHvyDYwxEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423089; x=
	1776509489; bh=Xj0s+aZBRxfUtEbxTEJcL8CLA+UUNpkqoqAxDq/3Y7c=; b=T
	NdRWjOLi0vRJf0F0FrpepNWWBbqbmY1iJ9Gfrh4RvzKRQEAylU474VsGQ5795xdf
	7C2be8aYpYJtSXIIMMms4sfbt1PLG+XTrZQKQgNkHd/7sdkRR49KKQFYH36/mojb
	0GI8UrkDjF8Ukg9r38EbkwmEDBok9zL/338T/cuqpZno4bk0Ha2c37BVnOleqgDM
	vq+r1sbMgEWIZfUbABWzINAJPTtowFqcR5bwscrxlnW5ev5GS2bicinwWSPQbhdL
	aDZHTYYWiVK5rTB813iOptfyXFSz5sORB5zasU/vLyYv7mIo/DSAY6PddUIVXSEA
	Xse5H2aJoSO7HnAkWAfgg==
X-ME-Sender: <xms:sRDiaZXqGIbmOL-YpHm0sbhbjkG6qqdCOwvj3Ccy7p-SkoHwl7X0tg>
    <xme:sRDiaQmA6FUCVovShRw8X6WgNlFTQItsKHXEfCrySTBIu9uaF3y7Fn2gFX7oyA1Dk
    oVllJGa-nSUh3b6jQHAcG3yCg4uNcEmkbd4eVAKh0RbhIj1wsGzHg>
X-ME-Received: <xmr:sRDiaaanPLu1ws59H6ERXy4zalNr0mIBq8_ckKPQUO84OykALw8zPbpXm64hEC326a_cKKc5R04JdPA7cn8qJLfPnDaq7GOMmUlYj29qFUL1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetje
    ehudetjeehhefhheejteeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sRDiabOTmpEEi_Z6ZuxxflfOnIkPeJfSRyU06aBe19tFXKqob9zcKQ>
    <xmx:sRDiafbqyO8I3HC4wF3URCJ3nSJ25NmDsFvsmt0JYVlVh0HUF2tn1w>
    <xmx:sRDiaZ1cA9nQD_OvRyc7GETjOKTn7rVEoOnoXgL3seGB0hjiRsA9xw>
    <xmx:sRDiaVeQSnpzxTa7HwPDKtpX78axN4tHDxFtDSETfG-Bkuo2PP3CwQ>
    <xmx:sRDiaSWZYt0Wi2gnLpDM-ogmWr_vEhR0j9IVC5qvWEXxELhHBza3OxJs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a153634 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:58 +0200
Subject: [PATCH v4 12/12] t: detect errors outside of test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-12-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
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

Note that for now, we only enable this option for Bash 5 and newer. This
is because other shells have wildly different behaviour, and older
versions of Bash (especially on macOS) are buggy. The list of enabled
shells may be extended going forward.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 5 +++++
 t/test-lib.sh             | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 28cfe730ee..f0a3597184 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -15,6 +15,11 @@ fedora-breaking-changes-musl|linux-breaking-changes)
 	MESONFLAGS="$MESONFLAGS -Drust=enabled"
 	;;
 linux-TEST-vars)
+	# Ubuntu uses Dash by default, but we only enable use of `set -e`
+	# when using Bash 5+. Ensure that we have at least one CI job that uses
+	# it.
+	export TEST_SHELL_PATH=/usr/bin/bash
+
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
diff --git a/t/test-lib.sh b/t/test-lib.sh
index de7d9e7b92..1f7868c537 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,15 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see https://www.gnu.org/licenses/ .
 
+# Enable the use of errexit so that any unexpected failures will cause us to
+# abort tests, even when outside of a specific test case. Note that we only
+# enable this on Bash 5 and newer, as `set -e` has wildly different behaviour
+# across shells. The list of allowed shells may be extended going forward.
+if test "${BASH_VERSINFO:=0}" -ge 5
+then
+	set -e
+fi
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"

-- 
2.54.0.rc2.529.gd9106f7525.dirty

