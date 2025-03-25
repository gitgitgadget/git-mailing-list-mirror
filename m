Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4729267F48
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908471; cv=none; b=GJf9F83zh8u+QiAuHz2IAAjLIbvW4CJZ3G3YjRyLMdBrT3d1U3bC1JVx8wNKH+hnK+o770gIn1sRK/U8LBK7lMhG33ZsQMyYVJnq9KUmDmgDHXlfP4RWSL3jCikr7CQcRfQEIMaGrVjdjmTNa3zN6OF4yYaSsRrjfCNZJ3Vv2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908471; c=relaxed/simple;
	bh=QjgKs2zBlmqc+C10EXoziYvrwPFdIEO6RN7X/4TjnLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mUla0bUsYwjddZgfErV+1XR02pltXyS9EauYScfX1vMzElCLih/UIAhhBmhu6tPNyoOD1F5Erqk2FUr3hXujX5KBlJVCq5FagbWJGc6Iw8NLgzLNuK7IMWXHe6+sRfmwcBcztQneLx9IbqnwohE3ATGx+Zlp9E9KU2szB8Ik3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q76C3Wa2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J2lTrB+J; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q76C3Wa2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J2lTrB+J"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AA86B13838F0;
	Tue, 25 Mar 2025 09:14:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908467;
	 x=1742994867; bh=FVRzN5probz2tBNOBHZiwqoUS1ZTExFewoPw5q+Mbg4=; b=
	q76C3Wa2/OWbiEocbNnIxQpVXEf48pTFLUzNf0mceBk7Od/z4Lx+UvXIKiPf1DBx
	F2V+DhL4ye/eae6zXed2/o9d2ONFh8igq9ltWiE++zB8A+5JpQgcvzi7EVJYFL03
	jYzsbgxAvT4Pyqa+POVSFikCLpXxAJJ1LlyvbUvsvcOq7CJ4iCaaiB7uXbG2EOE/
	D9v50IaWjb5z4OvimAvZFlfQwdr6hti+8Oo9ZfZY9KNKLU9mDDAKLNHcIrxb/nBE
	f46wvosrk5c8Arj6Gx0XZPYT5/WRUfISlcIpAItNQNJgXEFm+CDzqCBJLw8ulgae
	NQMrmLa23ypv7KAj4veiQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908467; x=
	1742994867; bh=FVRzN5probz2tBNOBHZiwqoUS1ZTExFewoPw5q+Mbg4=; b=J
	2lTrB+JtXXa52Nq+SO8/ZCdt/6U1u0VRF3pi8mvvkJr1tIOb9JSXlJ6jX8fcfiXq
	ClxBSSeFsp3yr0BAwDitQA/o8BxB9hy+IMd8uDb2Dlh9ovZrA8GObTtosNk7OM/2
	56rFt+F3sxUzATZNtKxdVYsH+WWexOV3/y9SQhAlrD1casqp/84Z3m71vTul0//J
	vW8yQNnk2x9kmK5EN8I8/uwGGBd+37H92WmwvQ25l4GuJ5SrUjVgWuBFXu5zcrBE
	3iiw4KZLgjDbVVoSC4DdpHguZdgxx6o5r3lhdeUnL03CrfYr8EDqbmo9a/KCfhit
	IDUXRSeg4Iefo8nn+MZ9g==
X-ME-Sender: <xms:M6ziZxDbYJPjOFuQ2XBtTN4rD15F6qhWEnVnKY0jSC7ozaneyEYU7Q>
    <xme:M6ziZ_jBw99EDWXPDnz3kYpAaz1DNR2cKHdLw2ecDlMZRb9QhpVoANbkxHrhQis_4
    8WeclCDUijaPYcglg>
X-ME-Received: <xmr:M6ziZ8m-nv5whk08akGTc9GLf6xd9TiDYu33LYErDXZ8JyWZxQi8kHXWLqJmk7WimlF2l_oXb6JaZqijdmdSoHfqtypXMLZUeXgT5sALEmGq8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:M6ziZ7w9L31d5KGBJKY5M92Qe1VgIMbY93nZpfSoAe9TBHvFtzSOsQ>
    <xmx:M6ziZ2T1J-wUyX-4k-qzxsxAfu3mitYTW0ZnaqQz7FvLVhge4gdMeQ>
    <xmx:M6ziZ-bvkeSr7cojA9-zyIrnC-xQ32Li2vlIUFX35dkIqvt5dcRKCA>
    <xmx:M6ziZ3RaUX7i5Al2kxWzw8H4peLBPsa7y_s9iPQSOm2WxRRLoMAjeQ>
    <xmx:M6ziZzIC6_KB9MfsalMcieN0YLTBlqQ4ZTF3AgPNXsGY8wp0AcDnyz4C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a6cd06d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:22 +0100
Subject: [PATCH v2 04/20] t: adapt `test_copy_bytes()` to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-4-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `test_copy_bytes()` helper function copies up to N bytes from stdin
to stdout. This is implemented using Perl, but it can be trivially
adapted to instead use dd(1).

Refactor the helper accordingly, which allows a bunch of tests to pass
when Perl is not available.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 377f08a1428..c4b4d3a4c7f 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1640,17 +1640,7 @@ test_match_signal () {
 
 # Read up to "$1" bytes (or to EOF) from stdin and write them to stdout.
 test_copy_bytes () {
-	perl -e '
-		my $len = $ARGV[1];
-		while ($len > 0) {
-			my $s;
-			my $nread = sysread(STDIN, $s, $len);
-			die "cannot read: $!" unless defined($nread);
-			last unless $nread;
-			print $s;
-			$len -= $nread;
-		}
-	' - "$1"
+	dd ibs=1 count="$1" 2>/dev/null
 }
 
 # run "$@" inside a non-git directory

-- 
2.49.0.472.ge94155a9ec.dirty

