Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D334D3AE
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 22:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294285; cv=none; b=l+4JUy3AaZA4BOaKmlIHbeFnFatiTJ0oLQvnqniqz1TaTwFNCoL3UQc6vBEG6kNjUT4sFCgX2c62UMWfVpvMOR3FJaLIzb3Nf8BRQSTH07AA+Qrb+nMDrzJTm7ZgdL2rrUOPEUucRDUvyV8lVn34bqcgb0LaLJeURQ7MDXCiNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294285; c=relaxed/simple;
	bh=OCtBJ/4Q61olGKGdzkiv3mTXpqVuY57sB090d7rqjnw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hp/2tl0y2Noipw+4fjDnVlp7iYb7ilPv544bvl9PXRqwdX1jBPdo8PcCbdrJYhKgPkSmU8YvgHlXrJUiLmZvw/81R1bwXR8eKyke2uWi+ZoWRieRpyeN8hTPljA6/Xk8Ogww4U6LMIuDUIH3t7Q1GRPQWWc+QxHl4TiR8iI9Kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JTKSfI0o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=21ooJgkJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JTKSfI0o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="21ooJgkJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1143114000B7;
	Tue,  4 Nov 2025 17:11:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 04 Nov 2025 17:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762294282;
	 x=1762380682; bh=b+X0TiWATTOjlBu2/A90HfyBW7ZJ3FUmjV4CC/sZ2A0=; b=
	JTKSfI0o2fcrpHWEGKzBml5goVoDWdy1QlxuxRD5v1ZFDtmUerzfeCnhZ70wX+lY
	MF8cb005YSyF83OmWgGLDSnTkwGQbaaxp75xjue8fRKcvprmCpTbC89C26jebPxi
	5kFbbO6WgYf+kR44wpc4RoXoQOWKRoZ1mW8GLq10+aqvj0FEa50bBiP5SMHdv0zB
	/wuQRZBamx47oAKBmtzy51qDFCqzLSJK2WE2VVg5KbUmbzPjKGwgfF/6O5jrTT2E
	mABD4x/w28skykanpL+J4zPjtah1a5mrxZziRuJ+eTZwMeh+iwA0fb2zb586I2kZ
	EeN5gjM+mB9tzCqx6No8FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762294282; x=
	1762380682; bh=b+X0TiWATTOjlBu2/A90HfyBW7ZJ3FUmjV4CC/sZ2A0=; b=2
	1ooJgkJtvS0ItadudyKcgkvNfDb637z9VkJYkxGeW+zTGopX0TgGoYw/bw7OXT7H
	M4Lb8Ko7rISvdUcZnNoIgFOuEVzT8Rs9lg/lUe64eD91K2eNRsKDIYsX81SFp3HJ
	RaKnUe1fTPqgh7SqYQwOHkOol8ntSpg0D3UCO3p/2g+mM7kltZ+9T3IrsicyigMv
	qHSjKxzG+nR1TsKt/txeYQfy9Dd25bRyPOH0B0hNlWzOa5EER/CVqbb530zl5YRv
	lxHkkqJm+zXNxs18G7f4i640FSEOn0aQtdp7+EnRiFEpmzQxfSkmBfnpDgCrXGlB
	u6yML/BGxN+R2W1sUpCag==
X-ME-Sender: <xms:CXoKac9r6hAY55isVq0dwlOJCl-2gndW7bChWARIMew8Oi_xRJ3crQ>
    <xme:CXoKacLYUWcHTLO950cvimJky5py8v1tcKcO4yRxEpIAfr236eqeDyHVm1_YD20ki
    FwLi8T97LqdCbkJuppO6OpDxZqG5skWuExuqnV0KmdoKFkZd5FoUQ>
X-ME-Received: <xmr:CXoKafae7clualEvkee9PsLBsbkPfLsCyqKEbo4MxH-yXDxQ04H1k3upn3f3emEBgPlNFa7gk7ScHO6JSx3FyXImOBGTjlRC0lXC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgvnhgv
    rdhrrghhnhesphhfihiivghrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CXoKaWI2kD7f55BAmdyzP68kcFuGI5ZJ3ithYVpbmf60eYfzZ5e6kg>
    <xmx:CXoKaVCv_Lx4f-iXSs3FmPVBmYsF_Xnr5e6Wccl8fM3_HML2GD-auA>
    <xmx:CXoKaToGaoWgvoSWBFkZQghaMO_zkWTSoqvO6nijiDNxdxMrPg4c2g>
    <xmx:CXoKaYjMB4c_TUqgS5I4SOvbZly4e5mKNoOgMdzRthbkNqfw1x1aWQ>
    <xmx:CnoKaet9YJV0Altvqv2D_kGiPWV44ks4barYnxmQfq9CYVFeuOWi4rCn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 17:11:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rahn=2C_Ren=C3=A9?= <Rene.Rahn@pfizer.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-add ignores exclude markers for ignored files
In-Reply-To: <MN0PR01MB761143093D1A4D226E8883A380C4A@MN0PR01MB7611.prod.exchangelabs.com>
	("Rahn, =?utf-8?Q?Ren=C3=A9=22's?= message of "Tue, 4 Nov 2025 15:59:41
 +0000")
References: <MN0PR01MB761143093D1A4D226E8883A380C4A@MN0PR01MB7611.prod.exchangelabs.com>
Date: Tue, 04 Nov 2025 14:11:20 -0800
Message-ID: <xmqqtsz9o3cn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Rahn, René" <Rene.Rahn@pfizer.com> writes:

> Steps to reproduce:
>
> mkdir git-add-test
> cd git-add-test
> git init
> touch .gitignore
> echo “ignored.txt” >>.gitignore
> touch ignored.txt
> git add --“:(exclude)ignored.txt”
> 
> Expected behavior:
> 
> The git add command recognizes that the file ignored.txt is
> already excluded despite of it being ignored by some gitignore and
> thus does not check if it is ignored or not. It simply will not be
> added.  Note forcing git-add will do the trick, but this could
> also have side effects for some files that are ignored but not
> present in the list of excluded files.  Hence, this can’t be the
> right solution.

It is not quite clear what you want to see.  The command would not
add ignored.text even if you give ":(exclude)ignored.txt" from the
command line, would it?

This may be an ancient regression when e1b8c7bd (dir: remove struct
path_simplify, 2017-01-04) was rewritten exclude_matches_pathspec()
function, which was written in 29209cbe (dir: fix COLLECT_IGNORED on
excluded prefixes, 2010-03-11), back in the days before ":(exclude)"
and other pathspec magic was even invented.

Perhaps try this patch?

I have no idea what the ramifications of the change is, though.
There may be unintended fallouts in some distant corner, even though
it does not seem to break any existing tests.

----- >8 -----
Subject: dir.c: do not be fooled by :(exclude) pathspec elements

When exclude_matches_pathspec() tries to determine if an otherwise
excluded item matches the pathspec given, it goes through each
pathspec element and declares a hit, without checking if the element
is a negative ":(exclude)" element.  Fix it be applying the usual "a
path matches if it matches any one of positive pathspec element, and
if it matches none of negative pathspec elements" rule in the
function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
diff --git a/dir.c b/dir.c
index 5b2181e589..5b1258a09d 100644
--- a/dir.c
+++ b/dir.c
@@ -2219,6 +2219,8 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 				    const struct pathspec *pathspec)
 {
 	int i;
+	int matches_exclude_magic = 0;
+	int matches_pathspec_elem = 0;
 
 	if (!pathspec || !pathspec->nr)
 		return 0;
@@ -2235,15 +2237,23 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
 	for (i = 0; i < pathspec->nr; i++) {
 		const struct pathspec_item *item = &pathspec->items[i];
 		int len = item->nowildcard_len;
+		int *matches;
+
+		if (item->magic & PATHSPEC_EXCLUDE)
+			matches = &matches_exclude_magic;
+		else
+			matches = &matches_pathspec_elem;
 
 		if (len == pathlen &&
 		    !ps_strncmp(item, item->match, path, pathlen))
-			return 1;
+			*matches = 1;
 		if (len > pathlen &&
 		    item->match[pathlen] == '/' &&
 		    !ps_strncmp(item, item->match, path, pathlen))
-			return 1;
+			*matches = 1;
 	}
+	if (matches_pathspec_elem && !matches_exclude_magic)
+		return 1;
 	return 0;
 }
 
diff --git a/t/t2204-add-ignored.sh b/t/t2204-add-ignored.sh
index 31eb233df5..aa55b219ab 100755
--- a/t/t2204-add-ignored.sh
+++ b/t/t2204-add-ignored.sh
@@ -89,4 +89,21 @@ do
 	'
 done
 
+test_expect_success "exclude magic would not interfere with .gitignore" '
+	test_write_lines dir file sub ign err out "*.o" >.gitignore &&
+	>foo.o &&
+	>foo.c &&
+	test_must_fail git add foo.o 2>err &&
+	test_grep "are ignored by one" err &&
+	test_grep "hint: Use -f" err &&
+
+	git add ":(exclude)foo.o" &&
+	git ls-files >actual &&
+	cat >expect <<-\EOF &&
+	.gitignore
+	foo.c
+	EOF
+	test_cmp expect actual
+'
+
 test_done
