Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFE320468E
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567099; cv=none; b=Hs8w1bWmwZWe3HFpiCF/Cnp2j0wKYhaN971f6ZTH8uMBJbqUZIDi8PNSuIFQf54VuUbArJAzFIKyUBzVsYM1Ub0a3iA+rbALWlrDdCrQav+J3kRNu5EVTJ3s8BLLGQ3Rg0EHJYjPMGwZXpK/PaZxKvMVjNQE45vZ+0/8HPTUfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567099; c=relaxed/simple;
	bh=x62msxo3SSdPs9pnRaeK/SY9U7k8cxE21PosnT6OHfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pgsBrOcALMloncD4pL/+dM5UcoVwIRsru9mMKVc0LKF73tOZlihglFY1lUdxO3uvbcrCCc8ITeP89eQWQ71qJd2pFBFfpPc3eytVGsixVOMaWh0U98iiWcXTwULYbcbFAYWlSwqDaG5PE+EKVhxJXFdZzIfPGjDoKpgIGY3XvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hIYad4+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A4Lc40KU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hIYad4+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A4Lc40KU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D57EF138026B;
	Tue, 10 Jun 2025 10:51:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 10 Jun 2025 10:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749567094; x=1749653494; bh=jjdieBemHE
	GqtrEp2p7YaAUotZIqgRHryTdoFHzd3XI=; b=hIYad4+pxGYmZv9+DKIh7yhpbg
	+7mtUIuyCDWeKRvR23ZpOUPGvhC881R9jmDIP4M7yxHgGG5qJhD2go72bD3x1vlr
	kIFBt15GHmZCTn2Nz++NolM2WAEFq9rCvKynogerqTLWqqgnrk6vGToMQSi9keNW
	ZtnrAmhqtlpl+rtW0UILwDEe94kFJtJ1lDqHwBMCN+AgfMOneypewYejX7T8GzP/
	zaBuWJp+AhERmlyOSPDhk+nTA/b5nG5yREMwuR2Nj+xrEzuJOvwLbcIAERjWXaAE
	ntS86hD1X6fA26T6AGy/84r5ahOJ7Nq7nonk64jhIo6c9ylEIsmLgK7EhWOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749567094; x=1749653494; bh=jjdieBemHEGqtrEp2p7YaAUotZIqgRHryTd
	oFHzd3XI=; b=A4Lc40KU5vTPvdtRV61+52x9s3xH8d7fXpOKPzxM1/JrUThOiQI
	xJ9JV/H0/zmdHp0OqsXLeeqHCbHmglWEqn7FHAj7FxTK/uLDX2QLVWh8lmVPoZ9o
	J/gO1MHIDQ3OZAs+XXXpqa2vHLUYS+zDiX9vUZTLuLNNi1ULIrWR4OW3vKAmTXSz
	CzuuwpimDsmahMESIO+mA9Wxl5FBrH/p3CTwfvHeBigQpAg9bk8scCPW0m45jx81
	jpEyCjlJgNead68m2CAb56pAtgYsrTUmbsJe7Jw6vsezmCVDVZj9JVpVDSgoUpXp
	ojXUw6WSpLPTd7x5FRZIb7Jqz9IcD1jgPCw==
X-ME-Sender: <xms:dkZIaKhRfu-05SLa_dn3-Ss0ICbXnu1yt6z95snBKvjTSFkUaG09OQ>
    <xme:dkZIaLDQ-7RIRzRhshuaKtwBqdJDnKa3Y0Q0bNS36lvcJi6Ll--Siexh3meQlNZXo
    G_APhndXx9_rRxPIw>
X-ME-Received: <xmr:dkZIaCFTVkYOG1KqgkGP4V9XCCYtbmcBu_45byfw7waSFuct9Joa7yDpmrtsyBU-bN04Xcql8ITOSt0OXu8k5_RgFrigwqLrhAks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeegleevkefhieeileekvddvfefffeelhfef
    veduffelgfeuhedvvdeihfevtdefhfenucffohhmrghinhepthgrghdrtgifnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dkZIaDR3wAazX01Pm6aR7iSlz-DZm9AU72M5ROt7mu_FxnD6TPxj7w>
    <xmx:dkZIaHw9PwO8m2o5SPEkhY48ig59OyT6QmpPFEwafkM-i6E4pOkpGg>
    <xmx:dkZIaB4yYeqO-08wtyIJ-elqnSeOk-TJO25K2Uhml9ok6uZW8POGNQ>
    <xmx:dkZIaEzcrsjkoluWrZw1PKp1oAa98agbkPt7dK44yf5gLCD0oJoGWg>
    <xmx:dkZIaGv4wDbA4xrQxI7vcft-HD-1j3jqfTXyeW61z_eBGQ-vBmJe6cxq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 10:51:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
In-Reply-To: <CAGJzqskj803dUcEuV+P-yuWdT0tiaidb7h3YxQSCgYHWgBfaWA@mail.gmail.com>
	(M. Hickford's message of "Tue, 10 Jun 2025 08:00:00 +0100")
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
	<xmqqcybcrc2u.fsf@gitster.g>
	<CAGJzqskj803dUcEuV+P-yuWdT0tiaidb7h3YxQSCgYHWgBfaWA@mail.gmail.com>
Date: Tue, 10 Jun 2025 07:51:33 -0700
Message-ID: <xmqqzfefodje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

>> Besides, in the above examples, is d4e6038a something the user
>> immediately recognises as the same as v1.9.5 or the object existing
>> v1.9.5 tag points at?  I somehow doubt it.  So after getting the
>> error, there needs some digging to figure out how v1.9.5 and
>> existing hello are related to each other _anyway_, I would think.
>
> Good point. How about just changing the second error message?
>
>>git tag hello v1.9.5
>
>>git tag hello v1.9.5
> fatal: tag 'hello' already exists
>
>>git tag hello v2.0.0
> fatal: tag 'hello' already exists but points at a different commit

Or simply something like this.  I am not convinced (yet) that this
is a good idea; I merely is showing that the implementation would
look like this.

----- >8 -----
Subject: tag: allow idempotent "git tag" without "--force"

When "git tag T O" is told to create a tag pointing at an object O
without the "--force" option, it refuses with "tag T already exists",
even when T points at O (which makes it a no-op).

Let's allow this "idempotent" case by special casing.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/tag.c  |  2 +-
 t/t7004-tag.sh | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git c/builtin/tag.c w/builtin/tag.c
index 4742b27d16..5380a46494 100644
--- c/builtin/tag.c
+++ w/builtin/tag.c
@@ -660,7 +660,7 @@ int cmd_tag(int argc,
 
 	if (refs_read_ref(get_main_ref_store(the_repository), ref.buf, &prev))
 		oidclr(&prev, the_repository->hash_algo);
-	else if (!force)
+	else if (!force && (create_tag_object || !oideq(&object, &prev)))
 		die(_("tag '%s' already exists"), tag);
 
 	opt.message_given = msg.given || msgfile;
diff --git c/t/t7004-tag.sh w/t/t7004-tag.sh
index 10835631ca..9a253a44a8 100755
--- c/t/t7004-tag.sh
+++ w/t/t7004-tag.sh
@@ -126,7 +126,7 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 '
 
 test_expect_success '--create-reflog does not create reflog on failure' '
-	test_must_fail git tag --create-reflog mytag &&
+	test_must_fail git tag --create-reflog mytag no-such-object &&
 	test_must_fail git reflog exists refs/tags/mytag
 '
 
@@ -183,8 +183,14 @@ test_expect_success 'listing tags using a non-matching pattern should output not
 
 # special cases for creating tags:
 
-test_expect_success 'trying to create a tag with the name of one existing should fail' '
-	test_must_fail git tag mytag
+test_expect_success 'recreating a tag without --force' '
+	# light-weight tag pointing at the same thing
+	# now succeeds
+	git tag mytag HEAD &&
+	# light-weight tag pointing at a different thing
+	test_must_fail git tag mytag HEAD: &&
+	# creating annotated tag, pointing at the same object.
+	test_must_fail git tag -a -m anno mytag $taggedobject
 '
 
 test_expect_success 'trying to create a tag with a non-valid name should fail' '
