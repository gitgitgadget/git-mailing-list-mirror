Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696123BD09
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749591847; cv=none; b=IFu3BrF9xsY1/Lcjxmj1DKdY8Ldbl7pGio3TU1z/XrRe3k5zK6Rl55UW9KC8lr0FgPQG16gtECJhnl8/u9bh2TTW+OBrCTMVd+edmW13l1L3dXZYB9aTMPSR7cmVxkPg5zt1vvUcjxd0vvKUCuixkiCA+YHqEkHisCLldXN0Vu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749591847; c=relaxed/simple;
	bh=ofcXV2z1hSyFDwol9mjgVzdklMw8WmwVx3V04o0P5WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FHGpsn4CXDXOjAQ6PkzFceJSEkwzViIztJJ4g8yH8Ny8/9yjZHTVIRqfp1q17ZDSecPvlYNo1dhwbLQFQda/IWQzmXT39VZg2IqyOh8JWPaCAjjVY6mvSI0/Ej8CllVBVkH6BY7t6NCvO75dhrpDQ3F7vY31k8UrIPD61ZE8L+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RrNjf+Li; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByKuz0UR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RrNjf+Li";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByKuz0UR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BB170138035C;
	Tue, 10 Jun 2025 17:44:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 10 Jun 2025 17:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749591844; x=1749678244; bh=/MlrYi5xjD
	e9KWsfMcnW+x7NsL182zfY1ff+lbcPG50=; b=RrNjf+Liuv9UQmc5nTxnfc2mlS
	vQY6TDHAUv2Ccau8lrKevf+ycD4969SzGYO2itbkLxC+YPfwq21h8a3NC8fLYbDe
	2nTyQlDvDD17Z2HXnAcZzQmYsAcm9qT1P228mvSE3cVFPzkHzF/tkM16z6G2NJf+
	JoZNtvsrBNl6/x/i/oJw6N7Y0DnUg5kn3p/5RWS90zVxYayBpafgOU8h7yYfJ0ci
	0roh9VNzEXzvBwlLpBEWOGDm114WUSRgTNg09W73VO93BcbcaL5s2X63IrFNahe1
	Nr3e3heAxvLquZtOY4gD27iPilpvbeAj6eWZ+dp4UmNO/nksFtZo+fqg1KJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749591844; x=1749678244; bh=/MlrYi5xjDe9KWsfMcnW+x7NsL182zfY1ff
	+lbcPG50=; b=ByKuz0URx9Bz97ojYKs0RntB8fF59pUO/SvK0u2T0MQJtfmuumf
	J9Vgt97CI91gHxhkkwVWYslfMF+U6onLmbsniw+pqm8IJTkhQTjw7jqadgowkJ4u
	iAIDXxNsbQ36wKBbULjyZu+CKj59lStT/VDCSuuz1ItsGxWkGc1/MjzWiC2jTjCt
	ixAmi4saxYPg0x5BMjpP3gT4jhM1IaMObHCMvkbCNFBUWqohwPjjoh7o7V4/Hevf
	rYOPilygPkkfLPrmkjV06fE3xede5r3nXxcXpdZ1q3vMF65KAiIgLICvxpdVpAFw
	eYLIEPzONtXPEh/1QtNg05Vw7JAZ9yT4FkQ==
X-ME-Sender: <xms:JKdIaF6coi-TbDq7v1MtQYdascFCEmQ_7a8UfPkjKT6NiZ7g05PKlA>
    <xme:JKdIaC4kV1MoTu5-13zqc65fFzsMMKtlnBmcdwez1GTYi2nyD8LB6zcUmWDXl3dkM
    AOQ65a6_U-ZYEuG9g>
X-ME-Received: <xmr:JKdIaMcTZPybp9yPx7ita5LViJPVpZRrjoDfEngyAVIW4dAu5qMNFDhyRPUCXeuhNBLObPt_Qv_RWpaFop6BejCSP5FgVQnemtaj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnh
    gvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehsuhhnshhhihhn
    vgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JKdIaOKhuHLsTv4jIT7x5NP6NtnsjgTfEXwMjC-WGuNgCc-CBR0oBw>
    <xmx:JKdIaJK9qS4lcpzw0ITfluBWcn7PHvL7d3_mN7oNZ6GoJC4ygG9tdA>
    <xmx:JKdIaHx_FT4uPLF9CLC7Ly2XthxzyaRzjGI6jLxlKtrlxxKISaZfyA>
    <xmx:JKdIaFJBnkCiZemVe9y3PHL86mX-IJhsEVm9qTH5hRdJYt6MhNp29A>
    <xmx:JKdIaCKdN6BMkKz4cXl3KEsM-Ai7CGF-Ar_5y5o42aBx6A8hJzf7ZuGb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 17:44:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Eric Sunshine <sunshine@sunshineco.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 12/20] t: refactor tests depending on Perl to print data
In-Reply-To: <aEiNBwUkjbo2QlFY@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Tue,
	10 Jun 2025 21:52:39 +0200")
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
	<20250403-b4-pks-t-perlless-v4-12-be20ac3db39a@pks.im>
	<aEiNBwUkjbo2QlFY@szeder.dev>
Date: Tue, 10 Jun 2025 14:44:02 -0700
Message-ID: <xmqqy0tzl1b1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


---
 * I hear Patrick is ooo and this breakage might not be grave enough
   for a hotfix.  But just in case...

 t/t4150-am.sh                   | 2 +-
 t/t5333-pseudo-merge-bitmaps.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git c/t/t4150-am.sh w/t/t4150-am.sh
index 2ae93d3c96..699a81ab5c 100755
--- c/t/t4150-am.sh
+++ w/t/t4150-am.sh
@@ -1086,7 +1086,7 @@ test_expect_success 'am works with multi-line in-body headers' '
 	# bump from, date, and subject down to in-body header
 	awk "
 		/^From:/{
-			print \"From: x <x\@example.com>\";
+			print \"From: x <x@example.com>\";
 			print \"Date: Sat, 1 Jan 2000 00:00:00 +0000\";
 			print \"Subject: x\n\";
 		}; 1
diff --git c/t/t5333-pseudo-merge-bitmaps.sh w/t/t5333-pseudo-merge-bitmaps.sh
index 56674db562..de0dc7c412 100755
--- c/t/t5333-pseudo-merge-bitmaps.sh
+++ w/t/t5333-pseudo-merge-bitmaps.sh
@@ -221,7 +221,7 @@ test_expect_success 'out of order thresholds are rejected' '
 	test_cmp expect err
 '
 
-test_expect_success 'pseudo-merge pattern with capture groups' '
+test_expect_success PERL_TEST_HELPERS 'pseudo-merge pattern with capture groups' '
 	git init pseudo-merge-captures &&
 	(
 		cd pseudo-merge-captures &&
@@ -234,7 +234,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
 			test_commit_bulk 16 &&
 
 			git rev-list HEAD~16.. >in &&
-			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
+			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
 			git update-ref --stdin || return 1
 		done &&
 
@@ -250,7 +250,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
 		do
 			test_pseudo_merge_commits $m >oids &&
 			grep -f oids refs |
-			sed -n "s|refs/remotes/\([0-9][0-9]*\)/|\1|p" &&
+			perl -lne "print \$1 if /refs\/remotes\/([0-9]+)/" |
 			sort -u || return 1
 		done >remotes &&
 
