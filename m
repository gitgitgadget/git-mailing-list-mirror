Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355937F756
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556976; cv=none; b=Eer1jT+JKRE+51f9Nr3BCJiAe+2Ziwmt8FbuAHz1hh8NZEcs27fSXNHdZwFHHpZ5GpobhLw6jQ6+R8Tyee215Ar8MPTiQq9Uxgr0/VYDkt5vnkWvWyaOmE7WI5JRE/wuo6ZT5jCaFhLM6axG9niw9P1AlYH9HDszRzMCKWGkRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556976; c=relaxed/simple;
	bh=oJiLyI/na901+YtZ+uPN51hHYALzPZc7VMZlXPZMZLE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=shmE/awjxe7gffioJQLgej8er/PsG2hufZSnvHtyFV5jxCnr8+SA+TbmjskPxfXuE+nKqcl0aeYpNGES/7jrUQPanVc3iUjZK18x5YdXPXFPo1BSdSQMOPNDNyFDTWLyLI0O3J75JVlHKv/43Xn5hmRz5mb+CLakfuvtkIhb1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BABNMOSG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GjkaMsTo; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BABNMOSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GjkaMsTo"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 61DF3EC0139;
	Thu, 26 Mar 2026 16:29:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 16:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774556973; x=1774643373; bh=HrZO1gog6M
	lord1O0xqq1bDBL2Rw4jefmTVBS1K52yg=; b=BABNMOSGRNdOtzskcm8tfTTucw
	jODxsu0XqlnZAlNBNyRhjvwBaieZSHfiLA4k0Q7Egu1iRRZv17Jgu7gHCZsumarU
	XEChimeIb6r/RegBY8VIxVFP903yum09nQTqwWxAlqddJ+oUvivqvyqr3FwiHV+m
	kIhqM46+8j0Vw19T3zHXxECu6QPMJRrtbAU2L0zoTq/Mk/SQ8CvzB2eBPm6TvgKz
	jTwm1MY4UmHLlxTA78Z6zDogm0zNN5xmf1LCAeRN1hnVSD33f5Wto+JYE67EsnZu
	mFgtyzgJA0aHi/JU9WOfA8k6LEA1iKQDbUOC6oaDwfmQF6OfbtDkMbRuQrjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774556973; x=1774643373; bh=HrZO1gog6Mlord1O0xqq1bDBL2Rw4jefmTV
	BS1K52yg=; b=GjkaMsTogmZQEWszJWdrP5OGEZrqpilgMPjsKjKzzSFNzBU5fGB
	2BhXsT1eWCIg2e1ix8gvePKeAPRBjVbJLYXxS8Av4pcxdBLsnG0vb9WFFsOUDTJ0
	LlxpiYwvNCCBt87ElqNw0ELMoUy1ST11GQIAV9r5yithRVt1BbJ46/CiQnMPOuIU
	JIpJZCmwmvi/FFAGeTdfB/lDsGgRimkqfLNnbiXdEseFV1mq1Ql7oFLBDgHFxfjm
	8t3ujV8usCw9+Iwb2FJPtdsElHx+VhwojWCXD9zqtxeJ5j8aLd+lF7G0NE3tDikC
	N70fa7xIROyUAxTWUBFzkJZzkDlQ0urafqw==
X-ME-Sender: <xms:LZfFaQwd77bdYqzx_48diIa7tWxPrU2dGx3O3JMp9BuRlip4dstJNA>
    <xme:LZfFaTUhYXUwqn-Hvr3UtxiP_Iu-bxxyqljLqPmImsarPBoi60Z3lF-BW8hgDGB-9
    RGapWK9GeWDHyKaslkaksJ7l1W9LX4DMtoiqd0BBpsUSK4uzJfG2Rc>
X-ME-Received: <xmr:LZfFaYh_mWTgOofGbIH1zH4wc8sekPFbzJdrLAwTM2STGahR3268hmxhA7e2ItEfw9TmsecdBog5FWH1Omuz6F31jjEM8KouYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepiigrkhgrrhhihigrhhgrlhhiuddttdesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    gthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgr
    fedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:LZfFabCaOLT5kUY4Nid8s9GmUfxHGVazXBcajXPoPMFNKw0w_I2oEg>
    <xmx:LZfFaWuLkvlhKpNUZZRmfwI3tDmGKijy2BuemRXrAnNT4khAOI_8iQ>
    <xmx:LZfFaXd8Ax6NjiI1I-CbajMuZnokVibUV4mp5fVdnBQSSKxGheddug>
    <xmx:LZfFaT85xluEbfPG3LJ3gb4MSxILvwk0cWIj3PrRx8V4To686JGG6A>
    <xmx:LZfFaXyEa_vfxlK9mAw1m8EGAxGeAK0o15mV3lZfWNuJEW-UmKwLPBk9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 16:29:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Zakariyah Ali <zakariyahali100@gmail.com>
Cc: git@vger.kernel.org,  ayu.chandekar@gmail.com,
  christian.couder@gmail.com,  jltobler@gmail.com,  karthik.188@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [GSoC PATCH v2] t2000: modernize path checks with
 test_path_is_* helpers
In-Reply-To: <20260326192603.23961-1-zakariyahali100@gmail.com> (Zakariyah
	Ali's message of "Thu, 26 Mar 2026 20:26:03 +0100")
References: <CAPAKoce5BeXMPtok+dni+WDTkokCAq0o4uMHGg1KZto9-UniXQ@mail.gmail.com>
	<20260326192603.23961-1-zakariyahali100@gmail.com>
Date: Thu, 26 Mar 2026 13:29:31 -0700
Message-ID: <xmqqzf3unxlg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zakariyah Ali <zakariyahali100@gmail.com> writes:

> Replace bare 'test -f/-d' and 'test ! -h' assertions with dedicated
> helpers. These helpers report loudly what expectation wasn't met,
> therefore making debugging easier.
>
> Signed-off-by: Zakariyah Ali <zakariyahali100@gmail.com>
> ---
>  t/t2000-conflict-when-checking-files-out.sh | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

There is nothing in the patch text or in the proposed log message
that is wrong per-se, but looking at the entire test script, it
needs a major clean-up to match the modern testing standard.

On top of the patch we see here, we may want to do a follow-up patch
series to clean them.

Here is how such a patch may start out.  I think the remainder of
the file needs to be cleaned up similarly with about the same amount
of work.

---- >8 ----
Subject: t2000: modernise overall structure

This test script that dates back to 2005 certainly shows its age and
both its style and the way the tests are laid out do not match the
modern standard.

 * Executables that prepare the data used to test the command
   should be inside the test_expect_success block in modern tests.

 * In modern tests, running a command that is being tested, making
   sure it succeeds, and inspecting other side effects that are
   expected, are all done in a single test_expect_success block.

 * A test_expect_success block in modern tests are laid out as

	test_expect_success 'title of the test' '
		body of the test &&
		...
		body of the test
	'

   not as

	test_expect_success \
		'title of the test' \
                'body of the test &&
		...
		body of the test'

   which is in a prehistoric style.

 * In modern tests, each &&-chained statement in the body of the
   test_expect_success block are indented with a horizontal tab,
   unlike prehistoric style that used 4-space indent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2000-conflict-when-checking-files-out.sh | 43 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git c/t/t2000-conflict-when-checking-files-out.sh w/t/t2000-conflict-when-checking-files-out.sh
index 96bae6c53d..39c80e80ea 100755
--- c/t/t2000-conflict-when-checking-files-out.sh
+++ w/t/t2000-conflict-when-checking-files-out.sh
@@ -35,32 +35,31 @@ show_files() {
 	sed -e 's/^\([0-9]*\)	[^ ]*	[0-9a-f]*	/tr: \1 /'
 }
 
-date >path0
-mkdir path1
-date >path1/file1
+test_expect_success 'prepare files path0 and path1/file1' '
+	date >path0 &&
+	mkdir path1 &&
+	date >path1/file1 &&
 
-test_expect_success \
-    'git update-index --add various paths.' \
-    'git update-index --add path0 path1/file1'
-
-rm -fr path0 path1
-mkdir path0
-date >path0/file0
-date >path1
+	git update-index --add path0 path1/file1
+'
 
-test_expect_success \
-    'git checkout-index without -f should fail on conflicting work tree.' \
-    'test_must_fail git checkout-index -a'
+test_expect_success 'prepare working tree files with D/F conflicts' '
+	rm -fr path0 path1 &&
+	mkdir path0 &&
+	date >path0/file0 &&
+	date >path1
+'
 
-test_expect_success \
-    'git checkout-index with -f should succeed.' \
-    'git checkout-index -f -a'
+test_expect_success 'git checkout-index without -f should fail on conflicting work tree.' '
+	test_must_fail git checkout-index -a
+'
 
-test_expect_success \
-    'git checkout-index conflicting paths.' \
-    'test_path_is_file path0 &&
-     test_path_is_dir path1 &&
-     test_path_is_file path1/file1'
+test_expect_success 'git checkout-index with -f should succeed.' '
+	git checkout-index -f -a &&
+	test_path_is_file path0 &&
+	test_path_is_dir path1 &&
+	test_path_is_file path1/file1
+'
 
 test_expect_success SYMLINKS 'checkout-index -f twice with --prefix' '
 	mkdir -p tar/get &&

