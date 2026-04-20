Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A1385509
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776670085; cv=none; b=NI/oLKU++2Dkq+SzeFasaq4hDrf78t0vjnfmby0t03HKNI25HJgCZXPh7jyK79E4VI74lv24ENcFaIDILIiG3FPjYafivvJdyeKDs8UPrqRUQ46YgO9LJzi8+b6lGWQsrBagwP5eLny5z+70n7Oh9x/UZMyLIRuQOfX+c+vgQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776670085; c=relaxed/simple;
	bh=BzuqyLeqYqcdu3LZjyb/Q20BHjCN0O7lza7zz/rbWjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rieQ7SUn0mlAZ99ce2EOkMJHueTytfgNnwfqmuUADWsVYalAF8O8vrBqI1PSJsuTsK8O8RcBhPReYWZ0v3JCbtUFzNdZJwIRXklChQ5LWLXteXJkystvCADbTW2F/BQCC8ckorr3W/EhrSm5yZ2r9/MiWA8lChuJM9wC1lwwJMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e3frwWHf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLMUhKKb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e3frwWHf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLMUhKKb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 33B86EC00DB;
	Mon, 20 Apr 2026 03:28:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 03:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776670083;
	 x=1776756483; bh=+4WaQ/IrBp6+eup5gGsqJZQhYQPHlGN5aLf0CbCK6VI=; b=
	e3frwWHf2B+zvwQlvHzwMG4vl7vE2W/for//LPJtpCPtfnPM/tbNOkApRjBsrYPF
	Z63cXLOU3n1mu78c7aTmttPNin7u56RJuE+S8nV3qG0joq+deq4IMWo9mLGZM8fp
	WEKlFc7RsmXPzTWqW0LCRwv74Rdwl9S5cYDQfWeMtp/tnQPEUcKB7JiTVYa0oXtN
	j/eWRKv4GOa/dGmsnvmbW4aij8Og+8+r9T6QFT6VZ/Zp0cV5dvl6NEzdnssaKd+M
	x7Px633UiH6NVB+cjIwKsdLGRPsTRS51Az22ABsqKKrnUsUIq8X5WoBzCCtyV+CA
	lJbwAv3+c5N4VZeCSxXy3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776670083; x=
	1776756483; bh=+4WaQ/IrBp6+eup5gGsqJZQhYQPHlGN5aLf0CbCK6VI=; b=h
	LMUhKKbYU+7fzydUuDyA1d7ACB/9qYQylTDUn7j9yYvTLUY6g1fjEn/CMZs+qwLK
	tSOFY2R0ZQ4kGeQMD2c6IMHWLX6uiaN12unfIZv/lzC9WI1Y0V/A0Uyj6ykXpsKa
	Yt68GQ8aQU/Rhe8lINT8EdSkRE+2kD/19awfVlHj8P0ddP7JulJbAHdNnxyeRpGl
	AN70cWC6spPwTTLVynUXnsd6p/4YMTEvJpriENKWRAH1u6qrzP4jy9THwcebD8Se
	KlxeeGanCUMb0Ndi9S2f7k0JIW5FxkIqT8X2p+lHIEWtJN/Zu9DlhSFbsZukSrUe
	f9Yqy4obUAVB43adATJ8g==
X-ME-Sender: <xms:g9XlaYZXIhho1v2VGikKMc-mtRkpQ9GFocgq5aEmeIglUlqyTIvZYg>
    <xme:g9XlaaZo-GemFDVi-9iVh2tgp9KxkdkgcGhE0R9wlvBwPEYlTwBCSGrRoZLfWnyAW
    GE0qHpGRSwF9ZHxCeNT03n_frpVM5-J5xC0jGR8Oke2qtTwxAXd>
X-ME-Received: <xmr:g9XlaX_Au02fY2j601u3LkDbNF3lxjbaUQsX_Hh4OOde-9BmgigP7yNk3z4WxbbhnU3Crdqc9Ur34AaULPnveY80iNm4F_KhcpkTYG9q8sFJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeegleejtdelfeffleetvdeivdeuuefgheetje
    ehudetjeehhefhheejteeugfffvdenucffohhmrghinhepghhnuhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:g9XlaRgeFzgZ0JTCUeGtFHkSjY77KSzmXS2CILuOPk8F8cJ4f83qGA>
    <xmx:g9XlafeVQuJpBb9cvGNrGaatYG1rJ1ExR9CwrviKNTpY7RcHdxuAiA>
    <xmx:g9XlaQoSYOlRq-ylXYcLPpjE4QivTKnFcc0eY4RRjhtGROAqr1AUuQ>
    <xmx:g9XlacC9P4P7M-KqUmDY-FqMep_PVNFew8fc0IPIUYjBLKQOvLjRzQ>
    <xmx:g9XlaV6lIe2KthAOn8_YrBsmkEALhk6RqpE4cYtPeHUv0aDaLFsEuyol>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:28:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9c2b50c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:28:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 09:27:31 +0200
Subject: [PATCH v5 12/12] t: detect errors outside of test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-b4-pks-tests-with-set-e-v5-12-7d3d68292f6b@pks.im>
References: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
In-Reply-To: <20260420-b4-pks-tests-with-set-e-v5-0-7d3d68292f6b@pks.im>
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
2.54.0.rc2.529.gd9106f7525.dirty

