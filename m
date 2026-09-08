Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35CD4B4865
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900518; cv=none; b=lXNsOUlOaf83j4ZEZc1HhQtgPtGwo9fvhqUICTzpI9h1tQ3GQXvVZOMM0NUTf8nZ73V+v7oingZ4lxe2I63FVwmEIrXtAMyGVPCvhb4V1+50gdh5MxxnwuBCSJ7kgKRGHeOM/59M1yBxiZITHhEB7gWiikcnP0IkvyIVMshThe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900518; c=relaxed/simple;
	bh=11LKq91I1F/91vzT3s2gXJf4tG0ebEL4t0wlWd8VpC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ckb5Mj5aNz03NxtO5RB4QprbSQ+iPK/UeNWhDVaTOw1QQm/L416/yTiDovlse5CEul6lyV/Tl/gtOypXdPUQUkNjVmsGPpWVOwm/64rIRt8U095+GCh+f1qDjJY4fFBgoUyLyERpyYo51VuFNG0e12taKaiacDXgMrWA8h2Fy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=smUoliW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tVGUYT9w; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="smUoliW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tVGUYT9w"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E91C2EC01AD;
	Tue,  8 Sep 2026 16:48:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 08 Sep 2026 16:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788900515; x=1788986915; bh=NSTVeqPmYF
	WJaxMnUbV7gwj9HG1BD6hScImSTlRsXUQ=; b=smUoliW2hHndtUfJ9AtabpahD1
	IDZ3ZcmxjVFYu4ob7fXOLGTUz3Oo2BS4BwKti6dNue5g+FGtHIkWxU0AkCECB+6Z
	rmAzSzdquqTdtKleZmtdF/FKnSwOOkSPx0bl2BODUJ3KslauRhjzgdmcwzaa6h2D
	rOgC9dZ7J97DY29ZBYDIz8W1ZEjYHGHbwvDhT7Ded8kBbze0cSqbtR3vM1GVpG7R
	Gh0BBMNu2o8Uxh+xqoAoPazboLjvO8wz/q3w0nhts6+Goe2rkjLOfjyI0w0EZJjh
	KaZ+xa1IhDeijX87ezz/w0bO5Nx8XPhKtMfcQ8jQsoilqwDgKWfy/ZQrjpCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788900515; x=1788986915; bh=NSTVeqPmYFWJaxMnUbV7gwj9HG1BD6hScIm
	STlRsXUQ=; b=tVGUYT9wromJ4Jwyr+ZZ1zV6hTUenSNa2kWhVSckNuGq7wjVLok
	2NsaCI69s6PWViCDBKQUVs1yOuiRG15UDP20iCkRyMKGyt/GtTZYIshdnw/nAxys
	/e8KE6v/Wm+ZY756FY2Q2O+srbgYLHJ2kD+bQJljHnEhx7y5KBmdqtpkehCYEowe
	nerEyAQHkD1Hrwdn66Jx44ZrG/Jm3bbgh4jARU9ZzPKUlw0elBR/RCs+Cs6g8zTO
	AB/UfNQx3+Wutx9nqQ3sRUCweZDb0O9rUhhUITebs2b6DNyv/+y7Ojza+iY0U58B
	cCQbaeoy5Mh268YzveMcdmYdIJhtZ4ef05A==
X-ME-Sender: <xms:o3SgatZzHT6cZBdGBt3xDuLwLV2X0zE2qI-vXgALmJNCgsnICTL72w>
    <xme:o3SgarZWE6mn2N_g_PGQjORFx4vM0zXSzTJDIGBqMKszYqtXC4eKNM-tGIzOyJ3Yl
    CgkImZAZVAUlxHxFowgIzIpkXNzcvYONeygWVW_e07D3gY7izBk4w>
X-ME-Received: <xmr:o3Sgak991Y5r7KBwebxcjL4Zgfr3DF0oIZewAreanYtevPeIzDHfkXIWsL6GHyncyigJhCdN27dkqQkWIGJgzZc9F_7XrGLE5CHR>
X-ME-Proxy-Cause: dmFkZTEVie6+qXjCNb3+tE4Xs+IKltHchcM2e6VE63oowFgmy5sJahza/jxXMkrI4fbLGm
    sivnNpnVNujkP6moP/oRW/XTk3zbp/3k93ta21pwcEg3TBffKAewyzhjiEvyhDB9CSQGJQ
    jDgGosNZdE/Gsr0IS8WGMgJYdd4szAYPE4j3L3qPd/WrrW4K0WoxUAVw9KtOYrFJIb40kw
    cK8LVEflcFbcncFBIuY4J16osQFdX/3dBBjPaqmDoRqFaH2b7XqM4Rszx96QXxOT0/TZxm
    WLxsEoAKXkERoUlzin4dCEjFf1+peKs17fi5j/lMf6RdgsUGfceBQMeUfUfGSP6RhuOJir
    GgrJ2/0OcjdELaN1xlv+EjRsgs19Jaxyy44REHJaWFmwIXW+g/Y4x3lr4WotCDGsEysa44
    igXiIAKVLhJ0RaYndfjDyWXv1vRzJ+bsoTwS8aqAy3rTanCI9EmogLNk1ggpp8EuJMmI2w
    oLR+XC3az+9EWOYkvDJFSkLwbA6ZDXgJqmfjH4Lvl+awelTHUyCpvnJHx/ngtdxW5TJXLF
    G4HUc9eK92fshnOv8u1KRPm7XXxmQhLnNy2+NnXjMtN79uxITywQJv5YZVhcKCbQIHW2vJ
    CfmGwDVNdXNlRdYT/3JXcXKteDA+BbfuJs5hSpTEF/N3Wr9yXSX1F+3DVvZQ
X-ME-Proxy: <xmx:o3Sgaqhib3_WssHm25HWmRKD6oMxy29-Lz17a7Z1St1YmoqNyIXeqQ>
    <xmx:o3SgakcnMaUcMV32sGclknggh8APbIwZHgilcHR4MEZYc2eD8_JIiA>
    <xmx:o3SgahrRQZX-fkpcVDdj4ge3McBTo7uhWCBCQv4q67vLMTcLiFwZEQ>
    <xmx:o3SgapB3xoYcucZbnYY4KqQg-jS9br5ASNbv-jX4G9fgBBSZVwSHlQ>
    <xmx:o3SgakvYGLP1QCQaTnBm98PDXJi_K0cct0o3MnJmRser2OAFdUDDarOy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 16:48:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll via B4 Relay"
 <devnull+markchucarroll.fastmail.com@kernel.org>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH 1/3] Update t4001 to use modern syntax.
In-Reply-To: <20260908-modernize-t4001-v1-1-cab3933a173f@fastmail.com> (Mark
	C. Chu-Carroll via's message of "Tue, 08 Sep 2026 15:44:53 -0400")
References: <20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com>
	<20260908-modernize-t4001-v1-1-cab3933a173f@fastmail.com>
Date: Tue, 08 Sep 2026 13:48:34 -0700
Message-ID: <xmqqpkynv599.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll via B4 Relay"
<devnull+markchucarroll.fastmail.com@kernel.org> writes:

> Subject: Re: [PATCH 1/3] Update t4001 to use modern syntax.

Documentation/SubmittingPatches::[[describe-changes]]
Documentation/SubmittingPatches::[[summary-section]]

> From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
>
> ---

Documentation/SubmittingPatches::[[sign-off]]

>  t/t4001-diff-rename.sh   | 31 ++++++++++++++++---------------
>  t/t4009-diff-rename-4.sh |  8 ++++----
>  2 files changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
> index ad474100af..2aa161c217 100755
> --- a/t/t4001-diff-rename.sh
> +++ b/t/t4001-diff-rename.sh
> @@ -88,28 +88,29 @@ test_expect_success 'setup' '
>  	EOF
>  '

There are a bit more in the differences between this ancient style
and the modern style.  Not just the title appearing on the first line
and the body is opened with a single quote at the end of the first
line, the body is indented with a single tab.

>  
> -test_expect_success \
> -    'update-index --add a file.' \
> -    'git update-index --add path0'
> +test_expect_success 'update-index --add a file.' '
> +    git update-index --add path0
> +'

Also in "modern style", the tests are split at more logical
boundaries.  As the topic of this test is "diff rename", our purpose
of this test script is not to catch a crashing "update-index --add".
We are not interested in finding "update-index --add" to fail and
see "not ok" for such a failure.  This step is merely the first step
of building the tree object to be compared later with a modified
index.

> -test_expect_success \
> -    'write that tree.' \
> -    'tree=$(git write-tree) && echo $tree'
> +test_expect_success 'write that tree.' '
> +    tree=$(git write-tree) && echo $tree
> +'

Likewise, we are not interested to find out what object name the
resulting tree object gets.  "echo" here were placed long ago merely
for debugging purposes.

>  sed -e 's/line/Line/' <path0 >path1
>  rm -f path0

And in "modern style" tests, we strongly frown upon tests doing
anything outside test_expect_success blocks.  This is a preparation
to pretend that path0 was "renamed" to path1, and it is concluded ...

> -test_expect_success \
> -    'renamed and edited the file.' \
> -    'git update-index --add --remove path0 path1'
>  
> -test_expect_success \
> -    'git diff-index -p -M after rename and editing.' \
> -    'git diff-index -p -M $tree >current'
> +test_expect_success 'renamed and edited the file.' '
> +    git update-index --add --remove path0 path1
> +'

... with this step.

> +test_expect_success 'git diff-index -p -M after rename and editing.' '
> +    git diff-index -p -M $tree >current
> +'

And the output is obtained.  Again, it is not like we are happy that
this "diff-index" does not crash, so in "modern style", we do not
split a logically test like this at this point.  We want to see the
command produce, without segfaulting, its output to the file "current",
and we also want to see that the result matches what we expect.

> -test_expect_success \
> -    'validate the output.' \
> -    'compare_diff_patch current expected'
> +test_expect_success 'validate the output.' '
> +    compare_diff_patch current expected
> +'

In addition, in "modern" style, it is more common to name the file
that the actual output goes "actual", and the file that has the
expected contents "expect", and compare "expect" with "actual".
This test has compared contents in two files with wrong names, and
compares them in a wrong order.

Taking all together, it would look more like this, I would imagine.
Of course as "expected" has been renamed to "expect" in the initial
set-up part, the fallouts in the remainder of the test script also
needs to be dealt with, which is left as an exercise to the reader.

 t/t4001-diff-rename.sh | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git c/t/t4001-diff-rename.sh w/t/t4001-diff-rename.sh
index ad474100af..61d651d1db 100755
--- c/t/t4001-diff-rename.sh
+++ w/t/t4001-diff-rename.sh
@@ -26,7 +26,7 @@ test_expect_success 'setup' '
 	Line 14
 	Line 15
 	EOF
-	cat >expected <<-\EOF &&
+	cat >expect <<-\EOF &&
 	diff --git a/path0 b/path1
 	rename from path0
 	rename to path1
@@ -88,28 +88,19 @@ test_expect_success 'setup' '
 	EOF
 '
 
-test_expect_success \
-    'update-index --add a file.' \
-    'git update-index --add path0'
-
-test_expect_success \
-    'write that tree.' \
-    'tree=$(git write-tree) && echo $tree'
+test_expect_success 'path0 renamed to path1 with minor edit' '
+	git update-index --add path0 &&
+	tree=$(git write-tree) &&
 
-sed -e 's/line/Line/' <path0 >path1
-rm -f path0
-test_expect_success \
-    'renamed and edited the file.' \
-    'git update-index --add --remove path0 path1'
+	# edit and rename
+	sed -e 's/line/Line/' <path0 >path1 &&
+	rm -f path0 &&
+	git update-index --add --remove path0 path1 &&
 
-test_expect_success \
-    'git diff-index -p -M after rename and editing.' \
-    'git diff-index -p -M $tree >current'
+	git diff-index -p -M $tree >actual &&
 
-
-test_expect_success \
-    'validate the output.' \
-    'compare_diff_patch current expected'
+	compare_diff_patch expect actual
+'
 
 test_expect_success 'test diff.renames=true' '
 	git -c diff.renames=true diff --cached $tree >current &&
