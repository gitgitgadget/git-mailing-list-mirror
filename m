Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C71FBE81
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483436; cv=none; b=rt+ByqOG3405SunPiPbIv8Q6iv0UQtaDwN+8bkaHZzaBRjh96r9nf4vWv5YWUN68Kq+7uWhfoD10LKSkwVfaL0QoUE8vdsqXq0wkOFTklEWUqrBXnIhQNbGB6lCCyCcaXBLdtuQrwJyn4Iq7zA1JQLTspg3FgtNoMaxYweXbxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483436; c=relaxed/simple;
	bh=xOz4TPj2VAUUAYCTbR0O1VBTrvxWRFfZSGNxD+4kgO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puvnBIy8UZuSmS3/Q8no/lYcBOvNuk72rpaJuDHR22ZJm7u3yXijtA6CKjR4Cb2y2M/PpzGqT+FZElJ5YlcCI8uUU0CyWALzTnxUQcWyqh8kJvBFUU1mi/5RmyJEyj6ql/BbO65qTQ5ZP+ATwO8UTxKYR2q1MzGNFDmloanOp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fm+rGNId; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RFtCBi5D; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fm+rGNId";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RFtCBi5D"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A035114017F
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 06:10:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 06:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733483434;
	 x=1733569834; bh=79axibpEIRKEXTiPgxddDCbHXya6JocK3lJMEs+H8FQ=; b=
	Fm+rGNIdmSac5MUuDWpR8wDP83+PQsdpXfx/XjDdqJPL54Xf82Nt3IiIzlXCxc7z
	uu2dkRieVdTvx7m2xp2naH/sFFGiUp16LfKLUlUiB0GKypOvZtch15Cy5j90rW9m
	Hs+I6fzxcTvCY3NfG6LUpMKifSb+8k8bRtpXDrW4EDQnfSmnxpjei3duX1/urhyL
	c0aDsmzeEZYm4v5Dp2Un8sZDQk+HrKE0LXTB4iTQZjTADQMk51r7k+lIoC1ngGlF
	lEaJJGOHRcxk9DgT8XcScFod2zOjo9juhhvE901gd8c/XmLY73fTVh4ER1PNy+mw
	eogcRxcl6iSfKIgttxSpqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733483434; x=
	1733569834; bh=79axibpEIRKEXTiPgxddDCbHXya6JocK3lJMEs+H8FQ=; b=R
	FtCBi5DMr+V0QQSzGj/hYQErQH4/UGr9fIW8JSAp5OuV6WGcFKmbcF+ceO+kbCay
	CN4/vxAfj6UcqPAbD8ws8590SFDPAEEppaVRtUIrtpbKNfal+FiUKXTTzPAXwkWr
	uh71g0OjYU0hLAO65xe/RXbCqPZMhiNosjwmIUd2VH5uFG81S8GFBDz7RbkYb8UI
	qOwZ3ARyyrEsIDUHgbnQ62D/OYfyhENsVbH0qCQgWLHH0gUJyqQd6BD5m5irImgh
	9eQMcZpE8WxiPTr6GMqOwOpgE1XnXFab38IncIqopTVIjWITrCv8wIgm1oK2lgjj
	WRfXPVsv9wdK7VMf8dY9g==
X-ME-Sender: <xms:qdtSZ7YpDvuSvBHdGemTZSpw7-WoKNBc51Imnedx2r3mLeNWkjX1bA>
    <xme:qdtSZ6ZiPy46T8vpAKSjDmrfDPTPTBMsbG4q9uoLK7L1D4hxtwrkwVB-Iqt1r7CnW
    gRrWTOmC9wNZczgXQ>
X-ME-Received: <xmr:qdtSZ998BoBgdoU32dha-ZmZjiuw49GySqyvQiwB2O0sk-FK6ej4ryJJx8QaWNUKyCpTrqIteQKkCmgatsXU2LJ3vHeZtsxyX7lMil-688lnWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qttSZxrxahs8QnqrApOSzQQLSHYTnL7xCH-2lQZeIZj81QlOeNkuqg>
    <xmx:qttSZ2rIYc3Ft8tcsXXcO-wuU6pDwAMXymwPZH67RmoQWPW-3Fm23A>
    <xmx:qttSZ3QtUHvc5L9_seG9AR75HkZ037t4ZfoMt7L9xxsv_bAvEc8jjQ>
    <xmx:qttSZ-ojh3uu7-Vg-kebRTFergLhnlPCF0KDm9ONzhrVrwf064xJjQ>
    <xmx:qttSZ7BFoQ5hGQAFjxTsBkzzuKNBn-31unqG0vEal0vhS7iAwzBWM42L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 6 Dec 2024 06:10:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb96c8cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 6 Dec 2024 11:09:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 12:10:15 +0100
Subject: [PATCH 3/4] ci/lib: use echo instead of printf to set up sections
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-ci-section-fixes-v1-3-7ab1b69e3648@pks.im>
References: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
In-Reply-To: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We use printf to set up sections with GitLab CI even though we could
trivially use echo. This may cause problems in case the argument passed
to `begin_group ()` or `end_group ()` contains formatting directives as
we use them as part of the formatting string.

Simplify the code to instead use echo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index a54601be923bf475ba1a9cafd98bb1cb71a10255..ba8f4da39caf29db5edaffde160bc81a7c58c329 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -18,7 +18,7 @@ elif test true = "$GITLAB_CI"
 then
 	begin_group () {
 		need_to_end_group=t
-		printf "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1\n"
+		echo "\e[0Ksection_start:$(date +%s):$(echo "$1" | tr ' ' _)[collapsed=true]\r\e[0K$1"
 		trap "end_group '$1'" EXIT
 		set -x
 	}
@@ -27,7 +27,7 @@ then
 		test -n "$need_to_end_group" || return 0
 		set +x
 		need_to_end_group=
-		printf "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K\n"
+		echo "\e[0Ksection_end:$(date +%s):$(echo "$1" | tr ' ' _)\r\e[0K"
 		trap - EXIT
 	}
 else

-- 
2.47.0.366.g5daf58cba8.dirty

