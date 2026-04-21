Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC2837C0EB
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756891; cv=none; b=Vv7NJXk1oCRSYnjha5EPMyLkkMuJtkeQJDhmSqDtTQL8yQxr/ig22OwIO2yxjYpQjD8LqZ+r6QwNwVk0Z+jqqhLgxygr3tiHS5rU5FIl9ltRKdiGoPI6K8CA7vlT7FyNxBZlj4MsqtiiZFp/XGX+ifrqTR3h9TN8zzofzkAXhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756891; c=relaxed/simple;
	bh=9fm4hZjXO64e8Wo1VN5fsdae4Ix9ewdyBrRcVRXaojI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gL/QGzF8oR6J5lCCH/EirwvwwoUpZqpJn7BFFUWmNHl+itJa6mMrK6RrrZsCiXBBsXvHNTYANXFONLyuZ/4b4wWdnI5IWryQiyrUbv2GWUeKkaWE/blo5gRK00h1KmoEARfcP9zl5MVDydu65zo0F3jdUnqkTzBZjZR5/P7+3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z7+FHO+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wzw49aK1; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z7+FHO+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wzw49aK1"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C48014000E7;
	Tue, 21 Apr 2026 03:34:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 21 Apr 2026 03:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756890;
	 x=1776843290; bh=6jhwzi3OmMtA91wf78/ElL7ukt2F1XrcsNrCC0KV9Yk=; b=
	Z7+FHO+KNfonJ9siRM27I00P8ujzwoXNBsc2gXoULcuZBSXZp2xOOasoAcAuKndf
	MIUps0OcR5DzCedmm0Rqo/ZVb7GZRTR0HIQCW0MKkmRQ1AqhvItvbkof/GHQYSFl
	WI4ELWzhEpERCz8env0DakFGES/SCNnd8/kGuRtT//BpWOkPMwvYWx33Hpv3gZo1
	l5f5QxXj51qzNYZE+TXfCRzagWwNen/Obx1vCgjCBXArvNuOscCCJlTipw7IVnxS
	upxsHNb7KZIBAJzOo+Y4LVBaJbEzCKWxX8TKTj7boGlqZ0a4UbmvKUk/JFCKh6kq
	qnDln00XlaVN2bUNsIXWPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756890; x=
	1776843290; bh=6jhwzi3OmMtA91wf78/ElL7ukt2F1XrcsNrCC0KV9Yk=; b=W
	zw49aK1KZ1pFfpE1pUhLImqy5Q3IDIrTyIMEhvBtR7fM2dS4YqwcD7+2JMK3x2cT
	WssTu55x7PHim4L/J72PUTQ8RTGgGRRE8ynzZpzBPqqIPoBNAYhXAJQbKT9su6G9
	BT01yw/s5eboMsctIdrdfjPot38ve6X7arInQ/PNmv9NE2B4BaeyA8FC/hphBfDY
	tKl0bm4ug21tJ1jwUjYSv/LHU5oPjyDHZy61+xvXbgROoqytdLD0n35OwKgPaOsD
	jTOKrErl6TXaPlz8F2jZcZPVCRnu72Go/4qxqknHeR+YRaJlYSwCaDj2XXlIP2oj
	Hsjqjp/g7YFg/+hQNHesg==
X-ME-Sender: <xms:mSjnaV39OG49ocob7aWh77F4iBfcr-knv1jemtckQCVnaWVyftIT7g>
    <xme:mSjnaTEv0Lz5T7qHL0td5OT43u4pkbbNV44cAhE-tHRV_5YwRi0CqIDM4Mz-h7xXg
    s3B9WXEaiBE2fd-RZU1gYHeu9sx6pvS4eVKwrTXqx80D3ANjY7UZg>
X-ME-Received: <xmr:mSjnaa4rINyhqtm0_0w8Zj1uSXWT7ge5XpehDlV5wkSuiWlr2cj22Jc0uge2f-nqXuu2NNOKxy9ZkVe-PeQl3Aja37MlEGZ8D7jBIVFtPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetje
    ehudetjeehhefhheejteeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mSjnaRv7eKJ-c7Mfe9g-5KGmwo2KEIDYTtOhv8GZGb7H0VuZ-8pLmw>
    <xmx:mSjnaT5iQnPh_Gu5kdJYgJ00ejeCi6s_wx2yISEwseQ-gSXisVCyiQ>
    <xmx:mSjnaUXWRVuw3XhIiSDqmfnfGjvw8BbtPaqtdJMccYvNBXc_lnWjuQ>
    <xmx:mSjnad9MxYBwiMGeaA1qs_3uKbkSf74J8H_NhBjjzRQ-HpY7RSi1zQ>
    <xmx:mijnaS0wEyR9ZQwbLT4TFtOb8QI0aMdIGy5wAl78ZG-MP9eCEJL-Trpq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 79d94521 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:25 +0200
Subject: [PATCH v6 12/12] t: detect errors outside of test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-12-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

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

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh |  6 ++++++
 t/test-lib.sh             | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 28cfe730ee..de08a08d59 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -7,6 +7,12 @@
 
 export TEST_CONTRIB_TOO=yes
 
+case "$jobname" in
+almalinux-*|debian-*|fedora-*|linux-*)
+	export GIT_TEST_USE_SET_E=yes
+	;;
+esac
+
 case "$jobname" in
 fedora-breaking-changes-musl|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
diff --git a/t/test-lib.sh b/t/test-lib.sh
index de7d9e7b92..cded7bd693 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -15,6 +15,31 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see https://www.gnu.org/licenses/ .
 
+# Enable the use of errexit so that any unexpected failures will cause us to
+# abort tests, even when outside of a specific test case.
+#
+# Note that we only enable this on Bash 5 and newer, or when explicitly
+# requested by the user via `GIT_TEST_USE_SET_E=true`. This ib secause `set -e`
+# has wildly different behaviour across shells. The list of default-enabled
+# shells may be extended going forward.
+if test -z "$GIT_TEST_USE_SET_E" && test "${BASH_VERSINFO:=0}" -ge 5
+then
+	GIT_TEST_USE_SET_E=true
+fi
+
+# We cannot use `test-tool env-helper` here, as it's not yet available.
+case "${GIT_TEST_USE_SET_E:-false}" in
+1|on|true|yes)
+	set -e
+	;;
+0|off|false|no)
+	;;
+*)
+	echo "GIT_TEST_USE_SET_E requires a boolean" >&2
+	exit 1
+	;;
+esac
+
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
 if test -z "$TEST_DIRECTORY"

-- 
2.54.0.545.g6539524ca2.dirty

