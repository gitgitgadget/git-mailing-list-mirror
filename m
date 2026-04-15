Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E07390C88
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258433; cv=none; b=cwz2tvemNdiDh4rmwDSttlTfCCRhKFRdpOjf0Ar+Sdm4z3Vrek1WBaTxcss4yNbRaFjx95QbQwECIpmKiXrA/cuPH/6tcNFob9SGVoIaI3c2VxQl2hoAG0+YUbybwBYpCpJDXmExQZMWuDJTwKEpOtHGEMgw+KzWbmJppOURiGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258433; c=relaxed/simple;
	bh=Gjo6EkohCkszc++BkHfJk5tbfB1+QhwvKaUy3wFbnlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N0wsexyHHZnW3c6S1I6eyjGw8seNkiqYmF3f/DzF3j69Rm6ijD14T3pNXV8r63iUDXvDuu+uL6DwSfSIpRJR83UnlmKFLZdoOUuqo0ai5YC9kjmBNgf0U3bitHh7qK9idZGJ6236IvRaE4rA5XX89OHKTAfulJS5NdXl6RKvqVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ncGtIj53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mjr/xw5/; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ncGtIj53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mjr/xw5/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C06E81400062;
	Wed, 15 Apr 2026 09:07:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 15 Apr 2026 09:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258429;
	 x=1776344829; bh=oY0FuX8rBaWizgUElbZF1xzMfiAbOpq3ImEuYV5Zrhk=; b=
	ncGtIj53tKQVJD56y4opnxDko9cWvXBIhfIq66k6M1pC6dMUrjmgZmwbPV9by76X
	NDTysDAcOXX1I97kfx6v757mpJvgpH521P0ceB3jGLLTksiEVUqtW/ScUcqn5Q2h
	bTc5a6MvKVe+UAbbjr4V86AnNSJo8yfvJRNXn8dNYwjpxZpxqPHSNZdrC0SsSXpL
	jNmRkBgMQu1B1DGSL4oRoUyUfIJeaUf4nvqrWSYLotS2S9XIGN1jx/sFuaieOE7m
	xS7m32nk46HEisS3pWfKcMyVMJdt02Zna1tEeilk93ax7mFMxHGSDcho1R/neOYJ
	r02dqTHC+aeG7f/KWMS6Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258429; x=
	1776344829; bh=oY0FuX8rBaWizgUElbZF1xzMfiAbOpq3ImEuYV5Zrhk=; b=M
	jr/xw5/xruGvd2JqJtIU4N4IHfYGyFUwUL2DLlxo+0ngRv0jzyrfE0TxWK8LXSos
	CKJLGt16/v0dHSv5rl69GamqZh/EDvQMb6xiXCgVNqP6SRcBVAX5PFDhrcv4zjNU
	cXDOGRcX9BbDBcpmQeIcqi1Z8+Aqrs5Du4rRD1N9y4pLOgAFaK9+e9qSNvsXfrpm
	5PwXdnbG0wX8MGIHmYSrC4IrdKxhRE3ydSXyZUtuKfwS+6e7QMFlkhf9uDbCO2qO
	8c/g7vVxX0RKobDRRkaqZWnAA9n8YrzyKDKUrqNdvctsl+fARQ93b/B1I8DYXCVU
	+Q9GBzPkKzJs4nQuJhqNw==
X-ME-Sender: <xms:fY3faVk0s9ouYU7okPKVfJYFOjq1QvfJenTRbKaVDr9TuKW7QeeWlg>
    <xme:fY3faYQ3M0FmV6kfKqbUKML8_5ZODfgwErQ4RqNTwQXqgOj5MUm-mPfqwkc4VMqVC
    l82a8xCLYBGJBkb3wstPuHsZMF_piY309Mc21ELMG8CEKlLlGYcTg>
X-ME-Received: <xmr:fY3faZBD3aCquuq7iAlgYcxgjWL_vwQlut3-e-MX46emUHNl_5ryAJXHR9QookagEV_t9C8-wZ7XFxQJaVQSWaYD8XPr8XJN8JJ_yS9U0pE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetje
    ehudetjeehhefhheejteeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fY3fafSnc1qYzgv7Q3KY6f__E520Ad85w1cq_pFuSlCJpN6TNX67PA>
    <xmx:fY3faXo2dUNf4Q81hufq937XcyOX6w8IzIfRZHTREkgMGv5oVPJcbA>
    <xmx:fY3faRxP4xY2TpjYXelPE0OSZbukfcp4KT5WO3-wGhfDvz8Q23K0Bw>
    <xmx:fY3facLgfpuedLUqSmQqRO_NAAFzPc9oDQDeWo6mBGKsIcnNSserJQ>
    <xmx:fY3faVA2NuRW3_-PKprB--irCddu4qE7V7T1YULiDIaqaCf9Ql4kVdUc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:07:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b46c2f65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:07:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:45 +0200
Subject: [PATCH v2 12/12] t: detect errors outside of test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-12-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
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
 t/test-lib.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

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

