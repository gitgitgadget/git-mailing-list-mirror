Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC99D1F8723
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 01:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761441907; cv=none; b=st59uonBo077qi9m9dOZdBPAli6X4jar3E2vr1zKiMyYkwXJ4bCMlpmFLvchiA/xPx7saCdMTaw5/MPlMnqW7Y4cmBIw6LgAfBaGd0TJxHNfO5G5bNKTS/K38iJ9Pca7+uDjLwD0URTAd9/n4phKoFQwuGKa0tnwiikrW8vL5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761441907; c=relaxed/simple;
	bh=Bleapx7rWhN6147+NHzCF/LVwPmijvc1QiUW44LgLPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cnkc2DNzP3uso0BHopTS/tNIJzXCTBeHfs6kKxc/YY50+GKQoX0+MrHYgWck5k+FcztXbJV4FYHS0JHxw4Qkdqh4f0TNO8BmmdiqfcKfxTA5D8d6tkPri9fX5X+IcyACsuLoEOd+udzJYSaUWfPd7IJiHvBOJxUV2xGD9GYCKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OGa6kbFK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tdJx+/YE; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OGa6kbFK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdJx+/YE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id BDCFAEC0324;
	Sat, 25 Oct 2025 21:25:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 25 Oct 2025 21:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761441903; x=1761528303; bh=MWXfzQ6n15
	LiY+Ef+55NAW4PGJ0aygWvaIq7nfdl33Q=; b=OGa6kbFK4dIPhWEV2WB8dmd7cu
	XqtQlnX7U8FYYmt98bOe3rQm1rrUAevKBWxFXt3ojVk4te394FYg+rdZMIHx6Tyh
	uqHLNUwmaDUpnTkJrUO6aHecpdrcwjJ1NaoVn6KWc1GU0GQ3m/xHTu9NOQzN7CSx
	j1CimMKFHBJX3Di3DWU4ypytAvvYFBJ/DY4pOLUblTLjzL+quy8jV5mcZNuU0r1r
	A7FT+lh8PzUJcCVy+UO8saqZxdrbHwetot0OdS31ACqF4uYtKN8DHXeoqrOJFAjy
	6dhbTSfrEdsb9sfPmtt+UQcta2TeV6c+Wk+L11/24yEbfoxZSWmUDQ11BWsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761441903; x=1761528303; bh=MWXfzQ6n15LiY+Ef+55NAW4PGJ0aygWvaIq
	7nfdl33Q=; b=tdJx+/YEiqLLOWGzguNm09rHhaRnPN4kPzjuptsLm+XT22xpOE6
	eDSHRFrQTQsrrWVs425la+MvuwnY2O9TMoBMbhfplzacApsiDItLup3rwT8fJkBk
	3qM9eGJ0Kmsr62XYUyB0EEEzwp2jXqaWX+mXkYoDX2gynsAaMDg49X6HddczallK
	sYI9vZlld3k/89jMW5NgPjhWxEUlmHeBON2njiCgzizNe2yuRXTMRmOJr27sYgma
	ByhWCbv8PSZXnSLf9t/D6Y/kFXm9pCVxrD9A4/ZHD8zVHVWhT5P6Zw+5lzTsjtIA
	hCxK5iEOcM9VFcqa4iwiXZt2YOxrZCO1PWA==
X-ME-Sender: <xms:b3j9aIrGSlNtIEOnQ7EDG8OP_YJD7vv7dp43p1hw2AwLMd0TcTND1w>
    <xme:b3j9aCXG3098s5I7VyOilEK2yBzUygoANHPoTirRZOjzoc-eLdWKcmbU9JZ2xF1uh
    p4mpS1GV-LfrXk1BN5UlXZABKVrbI4dqhwlyetISd5RwwlAujHGHw>
X-ME-Received: <xmr:b3j9aHD2KxdSgFP8l4ysfumzMPyUdzPoUeSkLAIMk-1vQukdUH-Bs2g4kIFZBlaoN08fQ3sh0TxO-8sIJbm6650UP71rEq3NHWOi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmh
    iisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehfihhvvgdvfedutddtfeesghhmrghilhdrtghomhdprhgtph
    htthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:b3j9aG39TZCzTQ7DOe1jhN7IDk8JlzkgrrHmRh-qWf3Xgqt-Da2wtA>
    <xmx:b3j9aJ2k1g842AJJKxUQnN_dAQws1khxwQaXl-VoF_j0veP_I87oDA>
    <xmx:b3j9aLBDNQwJb1OeAChiQp7ZZH1-dGLKB0RP_kx5XpWLLhWDSGGm-Q>
    <xmx:b3j9aI5oxiHbSv-JmrissZQOqUjtZ6RXFaEobjf3myh9cuyBC-3_Zg>
    <xmx:b3j9aBuBZyRpQQndrz_HW8K1_zKMl8HLPEm7wJw9JhoySX8TozG0UCCZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Oct 2025 21:25:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,
  Kousik Sanagavarapu <five231003@gmail.com>,
  "Eric W . Biederman" <ebiederm@xmission.com>,
  brian m. carlson <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
In-Reply-To: <Z8HVkqqD054QGPIE@teonanacatl.net> (Todd Zullinger's message of
	"Fri, 28 Feb 2025 10:26:10 -0500")
References: <20240703153738.916469-1-tmz@pobox.com>
	<ZoV8b2RvYxLOotSJ@teonanacatl.net> <Z8HVkqqD054QGPIE@teonanacatl.net>
Date: Sat, 25 Oct 2025 18:25:01 -0700
Message-ID: <xmqqbjlump3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> I've intended to dig into it further over the past few
> months but have not managed to spend enough time to work out
> the root of the problem.
>
> I hope that someone more familiar with these tests (or
> perhaps someone with fresh eyes) will spot the problem.
>> 
>> A number of these fail, e.g.:
>> 
>> https://github.com/tmzullinger/git/actions/runs/9780387020/job/27001952643#step:4:1871
>> 
>>     Error: failed: t1016.173 Verify commit signedcommit4's sha1 oid
>>     failure: t1016.173 Verify commit signedcommit4's sha1 oid 
>> 	    git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
>> 	    test_cmp ${name}_sha1 ${name}_sha1_expected
>>       
>>       + git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 5d70155cc40e4c16515c89ad0b11d8c691436fc4a4d3ca246669a4c21f07e454
>>       + test_cmp signedcommit4_sha1 signedcommit4_sha1_expected
>>       + test 2 -ne 2
>>       + eval diff -u "$@"
>>       + diff -u signedcommit4_sha1 signedcommit4_sha1_expected
>>       --- signedcommit4_sha1	2024-07-03 15:11:05.597537579 +0000
>>       +++ signedcommit4_sha1_expected	2024-07-03 15:11:05.553537766 +0000
>>       @@ -1 +1 @@
>>       -9179ccc5b15588bc3a45c5cc75bdec380f8ccb86
>>       +c6c46f92bc2cfda57ad6bf7981fa654825376b24
>>       error: last command exited with $?=1
>>       not ok 173 - Verify commit signedcommit4's sha1 oid
>>       #	
>>       #		git --git-dir=repo-sha256/.git rev-parse --output-object-format=sha1 ${sha256_oid} > ${name}_sha1 &&
>>       #		test_cmp ${name}_sha1 ${name}_sha1_expected
>>       #	
>> 
>> This seems like it's just exposing a pre-existing failure,
>> as I can't imagine how creating GNUPGHOME would cause the
>> actual and expected SHA's to differ. :)
>> 
>> Perhaps the intended gpg wrapper script which sets
>> `--faked-system-time` isn't being used?
>> 
>> I'm not sure why that would differ in the Github actions
>> from my local builds, but I don't know what else differs in
>> the Ubuntu images and/or environment used by the actions.
>
> I have run a good number of builds with the patches applied
> and t1016-compatObjectFormat regularly fails for all of the
> tests which use the GPG2 prereq.  A recent Github CI run is
> here:
>
>     https://github.com/tmzullinger/git/actions/runs/13570544425
>
> I think this test flakiness should be fixed so that we can
> apply the patch to fix the GPG2 prereq.  As it is, we're
> skipping _all_ of the tests which require GPG2.

Any progress or responses?  All of these tests, that nobody seemed
to have caught breakage of because they weren't being run anyway,
seem to be flakey with the new GNUPGHOME set-up.

I am tempted to do this in the meantime, but I'd really prefer not
to have to do so, assuming that these tests, when fixed, would be
materially contributing to the health of our codebase.

Thanks.

 t/t1016-compatObjectFormat.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t1016-compatObjectFormat.sh b/t/t1016-compatObjectFormat.sh
index be3206a16f..0968962f1d 100755
--- a/t/t1016-compatObjectFormat.sh
+++ b/t/t1016-compatObjectFormat.sh
@@ -261,21 +261,21 @@ compare_oids () {
 compare_oids 'blob' hello "$hello_sha1_oid" "$hello_sha256_oid"
 compare_oids 'tree' tree "$tree_sha1_oid" "$tree_sha256_oid"
 compare_oids 'commit' commit "$commit_sha1_oid" "$commit_sha256_oid"
-compare_oids GPG2 'commit' signedcommit "$signedcommit_sha1_oid" "$signedcommit_sha256_oid"
+compare_oids GPG2,FLAKEY 'commit' signedcommit "$signedcommit_sha1_oid" "$signedcommit_sha256_oid"
 compare_oids 'tag' hellotag "$hellotag_sha1_oid" "$hellotag_sha256_oid"
 compare_oids 'tag' treetag "$treetag_sha1_oid" "$treetag_sha256_oid"
 compare_oids 'tag' committag "$committag_sha1_oid" "$committag_sha256_oid"
-compare_oids GPG2 'tag' signedtag "$signedtag_sha1_oid" "$signedtag_sha256_oid"
+compare_oids GPG2,FLAKEY 'tag' signedtag "$signedtag_sha1_oid" "$signedtag_sha256_oid"
 
 compare_oids 'blob' more "$more_sha1_oid" "$more_sha256_oid"
 compare_oids 'blob' another "$another_sha1_oid" "$another_sha256_oid"
 compare_oids 'tree' tree2 "$tree2_sha1_oid" "$tree2_sha256_oid"
 compare_oids 'commit' commit2 "$commit2_sha1_oid" "$commit2_sha256_oid"
-compare_oids GPG2 'tag' signedtag2 "$signedtag2_sha1_oid" "$signedtag2_sha256_oid"
-compare_oids GPG2 'commit' signedcommit2 "$signedcommit2_sha1_oid" "$signedcommit2_sha256_oid"
-compare_oids GPG2 'commit' signedcommit3 "$signedcommit3_sha1_oid" "$signedcommit3_sha256_oid"
-compare_oids GPG2 'commit' signedcommit4 "$signedcommit4_sha1_oid" "$signedcommit4_sha256_oid"
-compare_oids GPG2 'tag' signedtag3 "$signedtag3_sha1_oid" "$signedtag3_sha256_oid"
-compare_oids GPG2 'tag' signedtag4 "$signedtag4_sha1_oid" "$signedtag4_sha256_oid"
+compare_oids GPG2,FLAKEY 'tag' signedtag2 "$signedtag2_sha1_oid" "$signedtag2_sha256_oid"
+compare_oids GPG2,FLAKEY 'commit' signedcommit2 "$signedcommit2_sha1_oid" "$signedcommit2_sha256_oid"
+compare_oids GPG2,FLAKEY 'commit' signedcommit3 "$signedcommit3_sha1_oid" "$signedcommit3_sha256_oid"
+compare_oids GPG2,FLAKEY 'commit' signedcommit4 "$signedcommit4_sha1_oid" "$signedcommit4_sha256_oid"
+compare_oids GPG2,FLAKEY 'tag' signedtag3 "$signedtag3_sha1_oid" "$signedtag3_sha256_oid"
+compare_oids GPG2,FLAKEY 'tag' signedtag4 "$signedtag4_sha1_oid" "$signedtag4_sha256_oid"
 
 test_done
-- 
2.51.1-691-gd530f589c3


