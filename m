Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A717A2EA
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338414; cv=none; b=JYaavTLy/St3YKwVn1tzYJIdsrFOj/dasue5X0eMyi9FWeL0VXBe5ojL5TmAFzR7OBQ1NrXoaItLLT/66FyqbfK/D8lwJkrD8EM2QcR3erYReoAXW+JVoz1PDkULmzzKg9gCIO/7bcLV9ixNCNxkeLKgaEBgpce+xfEsj9skOO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338414; c=relaxed/simple;
	bh=Dqxy33CX5R4Qaf9T3rk663knoZQ08rKY6d5Y3c2puPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdB1/RL9RCVVcUTkzVo2v9z/aywSpDNVhvTYv+aeQklMZSHseNKAJSXpMY3EhPYyEqUxoBWhSTZ2uasXg0dnjHDK+YMNaxXZbXFl/llXHVmbg6A/AfeCDd/09bMeZGftk0VR6h9A2ytkJiNIKMJ1vtJPr/bAJYb2K9QF5DK6KA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pRtSlY1A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Itgqn8AH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pRtSlY1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Itgqn8AH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2B927A0200;
	Thu, 16 Apr 2026 07:20:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 07:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338412;
	 x=1776424812; bh=Xj0s+aZBRxfUtEbxTEJcL8CLA+UUNpkqoqAxDq/3Y7c=; b=
	pRtSlY1AkaqZ2VN6lFod6XHeTncENdS5RLCmnse9I0mOYFaHHQ8t3nFEU0hxubGt
	bqu5+1u13VGD03Bt5/lvCwyMrr6ILLOacVFTWLLEI8OCto9f71EJ99TCHFuGZAPS
	7lMp5+oafvWdqkeny/FLFlY3riYU3E5MLZOv8HoHQkP7fjOo+cJNwaZrCZKDr9zI
	MiazWDX+0Qe7lkqbS9xa8HksP7SvX0/d0E6aQ4Z8+Ky40qOf+TngYTiIk9zhUEB9
	14rraLi/0fwDqhC6ZRT74DJbn8DuBJSKBXmDPM1tAgvMMQDIOnB+JFoRBfC9Enkn
	By6gtCSJFi6/7+NsDmG0hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338412; x=
	1776424812; bh=Xj0s+aZBRxfUtEbxTEJcL8CLA+UUNpkqoqAxDq/3Y7c=; b=I
	tgqn8AHuSOOuldagYcAzhyZweDDHcwKprDJ91ClyqmlDWGL3sB4R+dWKNafFsyzs
	k8IqITi2IOSKk2lfCp8/crq+A9fKxnckZ3iPEomfinSXRquK+JMAnOarZSTYRt4x
	LxymN8L7Sar6nz+2qWSevmfr0J9y/kJDtJMucyBb1NvB8jJmYdAz9A2icnOHN7ij
	1/3unZr0jyj1XifEpYCBAAsxFUucN0b/euijxbK/Kjh38sUzHDoLZAjWqffvB7sT
	ZTyvL+DAoAw/q4hO4u3Do6q9Hy7ciDh3juUsRPJHMITWujaIk8vBqzuGTvXPw5G/
	+SSmc6m1jEPhNz7S9xuaA==
X-ME-Sender: <xms:7MXgaQrGnOSODaf4sqRuIlTZSBIf11iLk9f5ZCX6tqKowTEoyFzZ6A>
    <xme:7MXgaeFFtx_woGKAf-BpTTMKz3T3lBzFmSk_AIV5nJTQL_zhg-rddVVgNcCQMfQXN
    MeWI6QdkBO_CVeeOnhRwA6Ag-pCc-_luUUqT3jJMNdqNWTmx54arQ>
X-ME-Received: <xmr:7MXgaSnvuufAG6FSUsmwCFSZaCxXxMdfShVDlqlOPiHjViXifhv5LkNUgFP57JonxRE3D46a1ER-jMD9-N0Ek3z9gnx2su4mOIN6siFI5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetje
    ehudetjeehhefhheejteeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:7MXgaRkuDY6RRcisU-ZCXNpSvjrZ-HwdJUc5VzdBgffIgJaFYpV2Kw>
    <xmx:7MXgaTuSdOonp5Pi-TBjQzwHhgkCc7jNTKY6n6UB_rsrOZQBHI8yTw>
    <xmx:7MXgaUnG-JHp91GeIGtn-TIRaeB7CFVfw3yPQm6g8yQttnkSBok6kg>
    <xmx:7MXgaesMMTAJwBPRoeIZ_e8tVYmZ9xBdWh-xzsBj98bMVJ88vEqCCg>
    <xmx:7MXgac0VZEx9PkFqKqxe_JE7IwK94SAaQfkws5qccVUfpcCCx7BwJE-1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:20:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a61374b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:20:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:29 +0200
Subject: [PATCH v3 12/12] t: detect errors outside of test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-12-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
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

