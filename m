Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FC351C09
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419695; cv=none; b=XKxurr30M1Xe5uqUcuzYNvc1IY4kNSjzCgt0FfdzPDDiwwI/qioQz4pjjq5Du70Q8OXznyw5/sLzDV2Yl5ZvIWoe2412vWFRVD0ZZPkBZFr8rzLJONFARFIn9bNATCBP5BeJbqtt6AeafdK24mSG7CLHlCyw+QnxtN2t90i2RtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419695; c=relaxed/simple;
	bh=WpRecNlimS4+WE1Q8iCv0Q+UBEhwPklivNFloyoUD9c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTa3kBNpbKS9M50fV9ru2heieNnImcL+Tvqqhr+DLn+y1vhEE22OFeHzLdbRcAc+unip2znYQq2eOa4vInmtKG1d7+QpAz97lNstLj1eQK8o+3838NdVVfEqw8C5Qvjo+sN3ioGvF/Sm8DXOQRViMiIc45abyDTaN7cgVS2xLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rio608CU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yx5mGmi5; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rio608CU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yx5mGmi5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C72361D00053;
	Wed, 25 Mar 2026 02:21:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 25 Mar 2026 02:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419693; x=
	1774506093; bh=drgUXl6QZr08b1QE+AKWLRDTDGV3j2DEnxUNbv9W3No=; b=R
	io608CU7F6Suc8Sh76VgRHb5YYAWxxf0JZ0jKupyCfk9LE+molAxwoQ6LWBuG9/e
	THwL01RBE9TRFrk3pCIpPU2dE1x0PgA7gGO3wD+90vJ/VFUENtBaDSxSk2E2Q4Ew
	xvjxVfI1AXMtMX2Uy2HV2gvd64aGZJTKeu52uEzGqg7CrpPhfmczatolaET985zs
	t/FZo9P3ol+PatVDa+MDFNz68gQFUpKxwvh6F9kl4l1H8t8qkA3HzmwAcftSVsDY
	gW3xsAHXsmvj/l31OGa/YLYI63AZEt2Ev7DZzwU/xa1YvKb/CqShUZIFk6Ml07MR
	EKm5QaVT4Z00Dise1/TEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419693; x=1774506093; bh=drgUXl6QZr08b1QE+AKWLRDTDGV3
	j2DEnxUNbv9W3No=; b=yx5mGmi5ioqtR492YB8tHfN+qv8ccVR7hZBLxf/pQtJP
	S5CIFOstQ+NeanY5nZQWEOmws8Lp9iOzCFeWbPdoi9K/jcVWe36RuQa2j09tJKln
	4tDMh7I7aLOBh3XLQrkS+CRJugEfFB4TKuN0HxjxydXqGyJwIpDZamMwKMdtO8YR
	56XHpJwyJlmU/vb2PKp+hAWQ4Ah69cTsPmHlRp/lfazqI7ed5zSgYypQlXHht2rT
	2rx0nAnZpGoWj3b7ApGKRGYFF2DmSuFJ+kP9OmdgWJ0lD/f2BJtCEe72WfLb1aUQ
	Ug4p09pYltjx+BPpjWMR+KjMOByHjELThRm4tBmOyg==
X-ME-Sender: <xms:7X7Dadeyq-LWyRc5o1Ns7KlPWLF_uYlkqHOt0tycFoMfTT6xXNn1fA>
    <xme:7X7DaRPvj-4DDbenJavj_sCz9885aF_NKt5rzDvHm1dqzpZ1eSoxbb7lo23LwC6gd
    MBG9e3N36QpivsI6kWh811CRafZFS61JptwSzWlskrwBTK5q49xyw>
X-ME-Received: <xmr:7X7DaULT4PcrVEVNHyI0TLdgoqTQPApsPYjSV7hhb0LYJzO7rQ5M5tR28NCCYlekwmO1Pm7LZNxEelr8CKSrsy9OnAe8CaP4Dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:7X7DaSGIOa00uTZL8EHY4-DLNuj3Zww9rSAXVqagqi-0cmhDcOfnMw>
    <xmx:7X7DacQZ_3fAYch8bBs910C1No8EDEmO_ev30BTQAeGAP5D-rMwgUQ>
    <xmx:7X7DaeH7C5-KWMoxFYuelJrD9TKulVQgkjqzJ2Z-oVjaOSDrT1LTEA>
    <xmx:7X7DaY8XZ6npWYQFCiN1BLlG-1Xc1ZtSPiTJuwe-2N68O3wD1xnHIw>
    <xmx:7X7DaY343X-qRLMiYgMz9LYzQo6hcfY_NawM_7R-N8W4jHbvMPwwiOxt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 10/11] t5570: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:13 -0700
Message-ID: <20260325062114.2067946-11-gitster@pobox.com>
X-Mailer: git-send-email 2.53.0-886-g529cbd14ff
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

Among a few scripts that use lib-git-daemon.sh, t5570 starts and
stops git-daemon process multiple times.  Make stop_git_daemon
function "set -e" clean.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-git-daemon.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index e62569222b..6850f08c1d 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -86,13 +86,13 @@ stop_git_daemon() {
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
+	ret=0
+	wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
 	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }
-- 
2.53.0-886-g529cbd14ff

