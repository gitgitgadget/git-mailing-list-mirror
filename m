Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C73502A5
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419692; cv=none; b=Ky6Uz01P/1sfi4ik3kQsM+hkVleF1dBTnJraxt7IYbELuGeul5rTQo+E8mPp7qtGNQjPupckTimnR8biuN6vMoYsd7GhOsBQzRCAFk5hZG1SDNd0Ai6U2I1AUPaZ2alcCpNo0BgQU21eC8XjZi350vwUCe4Rj6nQ1e/HkvimrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419692; c=relaxed/simple;
	bh=q71Rwr0MF9KJxkw3rzB/WO6uOFij9fOn6Cj8o9Sjf1w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+EpN8wu6OhsA3ud2lxTTzNKMj4OzLoxlEOCyHdNjKGfbmLchgI3NB3MG9ICRv+h7Rc36mbB+5u1Te2YY7HLRyn7IM3aBcOCoxaT46LJbSCKj6aFEKqrA8JDTOR2DkC4O3rAzABKJf6nA9hvjp1ediT/yChl8ERTkJDEy6AXvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iIIw22Vk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rcgl4EkI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iIIw22Vk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rcgl4EkI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 740951D001BD;
	Wed, 25 Mar 2026 02:21:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 25 Mar 2026 02:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774419690; x=
	1774506090; bh=3F1ezi+gG7jWkwfj35UorLBMxWvVPpMveEY+dgO9wlE=; b=i
	IIw22VkW1bhJa0HDMPNX1JC9OVipFfleaS9QxtoCZ823Kn6jwc5DUjRLfWD+lO0n
	/BjSms8o4ODX8DE/sh21quZh8Jvk4v653sF8HOgB2q/D2RXwPyX+xpMt7UUFr+Ew
	4SX0hF6Q9IgQg6AcqiQY6+qYEhdW/KlW7FYcnSlQiiO7jtRp8V63xsqaEVA1Rbcd
	i7HFnFdc59I/qu5JzP2/u6FmOVDAJNg8cIbsbHqzsJ/0oZGXR8VQmySVcc+Nf5PP
	pheamMeHN/gisTD1ByepF74q6DuZJPW9TXB5AbtKH1FWPHHqJFjHaRk1LFixwQfk
	5MG5M/yqHDqX/2Ng9HG4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774419690; x=1774506090; bh=3F1ezi+gG7jWkwfj35UorLBMxWvV
	PpMveEY+dgO9wlE=; b=rcgl4EkIbFwdr5iS8dXFzQ9ffkxJTTLc5GoAOUFSwyUe
	QKjEdlWbXTrxy2SPQmkts5PJbtT+GJcs0NFAD+n1+PdV9MpMVdvrFlnNcQFOiQhC
	FK/hT5+qpC/aIhkQm+bDuoTkG1iuisRVdmcNotTZgrYicwTLYBR91cyNelmGUG9F
	vNbghnQEt1M6BCU6s5eiEvohpQ874DhI85yB3kb6ZprzrCaTRKKiOFfsG0mdZ+nW
	vIZJiGRggixoSpIShy9wdTV/TttNzjYPR7oviG0fBebkA7fyJYsfe597pEArrWKz
	yXi87Xueer48D4OLJHO8XPdt74GyNOQ0vwqkeCNezw==
X-ME-Sender: <xms:6n7DaQ5UonsMdY0YXTsu-VZKhghpPm8SKEONOmlvA6O3PvhkocjtXg>
    <xme:6n7DaX79HfWcOa9oorKuhiezlnprR8avYszR-J2JLUL_MizWdSbxFYsDJe9_0_AEQ
    YgJBWjr1xzYUE7CaoY0zrhVo0CgI4lqY2VQZyrkR5aGR7pocwn5X_c>
X-ME-Received: <xmr:6n7DadEY9XdGs2eMgMKjalK6cALjMD3a88NO9SNLz25qs3MJujZ3KnlKwZkh1facAeshsAbbwBjF_OpINrDHZ2cGv-mqsnqnXQ>
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
X-ME-Proxy: <xmx:6n7DaQSgLY78aezXHqbNjqLNHIdAT3odbQdi1R8aw4N66wgeSBIwpg>
    <xmx:6n7DaWs3p2yA0W4VyOGb2EjuwxpT6J_ULuyGpbpdzF-jjf1Ua9_O_A>
    <xmx:6n7DafylOP2TnA0E-TBOrWw1rAZdPj8gC55K8IUAKSWxEOhQRR4vSg>
    <xmx:6n7DaQ7HIx5dGI_cGvpUBIaRRQ-gsKRBseFhl4w7GQbmRHDea2W5WA>
    <xmx:6n7DaUSBqH5NribmK026jjy69oTsgKOaSAFJHRIiuP8lEQnkPw3kEcNJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 02:21:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 08/11] t9200: make test "set -e" clean
Date: Tue, 24 Mar 2026 23:21:11 -0700
Message-ID: <20260325062114.2067946-9-gitster@pobox.com>
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

This test uses the usual pattern, where it

	cmd ...
	if test $? ...

expects cmd to be allowed to fail freely and we can act on its exit
status, which is not possible under "set -e".  Rewrite it using the
common pattern:

	status=0; cmd ... || status=$?
	if test $status ...

which means the same thing but does not fail under "set -e".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9200-git-cvsexportcommit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index 14cbe96527..65ef1d7c82 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -11,8 +11,8 @@ if ! test_have_prereq PERL; then
 	test_done
 fi
 
-cvs >/dev/null 2>&1
-if test $? -ne 1
+status=0; cvs >/dev/null 2>&1 || status=$?
+if test $status -ne 1
 then
     skip_all='skipping git cvsexportcommit tests, cvs not found'
     test_done
-- 
2.53.0-886-g529cbd14ff

