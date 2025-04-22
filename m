Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FAD2980CB
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347998; cv=none; b=XOAtFBbJNxO6Cn+fDqt7SornbGKHgT3vDy1wuT+x8fnpOD+CQ5J86WkIDbIfE9ddGtaqD3sidpvQNjmNfy6oCgiHUgMB70xChqMJI0E2c8jTHVSyBel4EABKLbkZxpejNiFMUQlk6RPTBetdcjBYElZ14jQtmfxICKm9qCH4I+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347998; c=relaxed/simple;
	bh=kE+jwEP71fguLt1KbSyRizI79lJlaPuBeSAkYA7Yjjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=diLI0LQlsKtqEGIHo5vUGjhc7nngn3SejJIWIisfnzzbwwbA3nP9v/kdQWX2wr50fW5RJNGehQ2oL4N7SHK4YOjSzJkAr3k+40r02V5u4nm8aK0BSlLdr3H554rQUe/uviFjzwnO8wx/MwS9LY1EQjdqpNdRu4+ao2wIUdPjy4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MNdr06RD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5qk45gw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MNdr06RD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5qk45gw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 007F825401A2;
	Tue, 22 Apr 2025 14:53:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 14:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745347992; x=1745434392; bh=GUpsasMyEW
	yOfTYT1StDcjdPCzQexTMNYJHdqqM57Ss=; b=MNdr06RD8em26E6YqiMMr/cmPN
	rcvm8uBAl7sUq70XIXlfXSJIcwGjW+e1cNejyov3qhs4r+2bZVRbIYyinOHSocch
	g3aWL7NdkwO7kdq64oALEFnnk2Zw5oJKX/vXVTevz67GqdRUg3SZt8jy4GfqQ/j+
	+HLqDuNwbS3ndHgB4+Sma88vrPTn4V2rr/9/kK58umsjcOLFPXWQrhVUSg9D4mAH
	X2NmHidV5iNVOW/R7Vac/LKXZKkc7Qu2YY1jEFauDMIYmdT84FSALO5VbsIuCy6z
	YEypXUc9ULEH43DFRTxUHjn1ZCHWXM5P9RI0mSvs21WTp+jks6AlshW0t+tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745347992; x=1745434392; bh=GUpsasMyEWyOfTYT1StDcjdPCzQexTMNYJH
	dqqM57Ss=; b=q5qk45gw9Ufy/h/NqsRQAS/gfSUWeK2fXftzpzh4twLTgtRIXzb
	Np4+8PcwepRkxfhbZUtUFz2Pfbf/SwXfHfl+5WBzoNPxfCOgAyXWx7nh8HPCa1ue
	uL+wJ+C7PGr2RIa4N0QnUGb7qBtF3yHZ53q4xerxYH31grzHBBLG1yOir8CUSEtV
	ONy0jsi3iI6zcE9DHC40kkn6lDejGOreiCOG6F3iw+NA8zd7cs2BGihtKGYbgfeT
	P9nqVx8G6MjQ93/wZa6G1tGY/65YREcqIUhCjitkgcsFpUlvjP706dy9S+GPmRyK
	2LfJzvkNPROK+BihzYNke9FaeQ6GmVk/A7w==
X-ME-Sender: <xms:mOUHaJErbWaNUzyRGLs6w06bw6GPHwawpdhSCK8oTxpZSM7cZ-ZfPQ>
    <xme:mOUHaOXuQeFwKXaBOALgB0ZYufoQGrU4Gyxbfh79vZdN--D58j8LF7DXwthG-Yhy0
    Qblq8PpaFN07xx-vA>
X-ME-Received: <xmr:mOUHaLLNMO4zXSHPzmELcQVeZzyWvgrc9Kjg_ojmGYz2EHiVizoWaEtiVdnp9Ip3kDGAvok8g5HREuZ-uWjgs8t-fUrk2NvrK8uO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvg
    gvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutggrshhsvghikh
    hiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvthdprhgtphhtthhopehpihhothhrshhiuhhprgesghhmrghilhdrtghomhdprhgtph
    htthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mOUHaPHskIQaPh6o4c89ihkY-GHuOKch_tzACSQ_N4QCl5KPctw1ig>
    <xmx:mOUHaPUsBU8i1Y0qzW5fPl-1RLfEnKM-SqR5LpNNnsJkxyzbpQgq9A>
    <xmx:mOUHaKPeWrTXOn5HSkYD_hVxfq7QngFZp0q09ZWB-UcTS3G91qDCTQ>
    <xmx:mOUHaO3OmHlFVNWIkK1ckXhpfIthsGrA50JjAXUopVh0dFyNXAUqCg>
    <xmx:mOUHaCpJN-Kb_V13x11r_Vn0ZMK8bBSbBdG6_IcYxtLMnSvsPTQYYnKA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 14:53:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  lucasseikioshiro@gmail.com,  peff@peff.net,
  piotrsiupa@gmail.com,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] Dir: Fix and test wildcard pathspec handling
In-Reply-To: <20250422160547.577524-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Tue, 22 Apr 2025 21:35:47 +0530")
References: <20250422160547.577524-1-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 22 Apr 2025 11:53:10 -0700
Message-ID: <xmqqecxk3u5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Subject: Re: [PATCH v2] Dir: Fix and test wildcard pathspec handling

Subject: dir.c: literal match with wildcard in pathspec should still glob

or something?  "Fix" implies something may have been broken and the
change was an attempt to correct it, but otherwise it does not say
anything about what was wrong and how it was improved.




> Ensure wildcards expand, even with literal file match.
> Fixes 'git add f*' skipping files like 'foo' if 'f*' exists.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the codebase to "become like so".

in this order.  In the above, a clear problem description, an
observation on how the current behaviour is not what you want to
see, is missing.

    With a path with wildcard characters, e.g. 'f*o', exists in the
    working tree, "git add -- 'f*o'" stops after happily finding
    that there is 'f*o' and adding it to the index, without
    realizing there may be other paths, e.g. 'foooo', that may match
    the given pathspec.

    This is because dir.c:do_match_pathspec() disables further
    matches with pathspec when it finds an exact match.

or something.  The first paragraph gives end-user visible behaviour
(so that readers can try it at home if they wanted to), and then you
add a bit of explanation of the reason why it happens in the current
code.

Then it would be rather obvious how to correct it, so you probably
do not have to repeat what you did in the code in the log message in
this case.

> Use 'f\*' to add the literal.

The proposed log message is not a place to give an introductory
shell syntax lesson to your readers.

Remember, what you _did_ in the patch can be read by readers.  What
they may need help reading your patch is _why_ you did them, which
may not be obvious at times.  For example,

> Tests added for add and commit where dir.c logic applies.

your readers can see you only covered "add" and "commit" in the new
tests, but they cannot read your mind to find out why you did not
add tests for, say, "git rm f\*".  If you want to say this line, it
should explain how add and commit are affected by the code (and
possibly, how other commands are not affected, but that is
optional).

> Skips windows specific test.

Again, from the code we can read the test runs only on platforms
that can do FUNNYNAMES (not necessarily Windows-specific).  If you
want to say this line, it should explain why.

    As some file systems are incapable of holding files with
    wildcard letters in their names, guard the whole test script
    with FUNNYNAMES prerequisite.

or something.

To those who have been intimately following the discussion, it often
is understandable without some of the above, but we are not writing
for those who review the patches.  We are primarily writing for future
readers of "git log" who are not aware of the review discussion we
have on list, so we should give something to prepare them by setting
the stage and stating the objective first, before going into how the
patch solved it.

> reported-by: piotrsiupa <piotrsiupa@gmail.com>
> Mentored-by: Jeff King <peff@peff.net>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>

Unless this is part of a project done as some mentorship program
like GSoC and Outreachy, Helped-by: would be more appropriate.  It
is not like Peff is assigned as your mentor for working on this
particular "fix wildcard" project, is it?

> -		if (seen && seen[i] == MATCHED_EXACTLY)
> +		if (seen && seen[i] == MATCHED_EXACTLY &&
> +			ps->items[i].nowildcard_len == ps->items[i].len)
>  			continue;

We usually align the first letter of this second line with the first
letter of the same expression (i.e. "seen"), so this looks a bit
unconventionally indented, but the logic is correct, it seems.  If
the entire pathspec is without wildcard, then there is no reason to
spend more cycles to look for more matches, but otherwise, we may
find other paths that may match, so we do not continue and perform
the rest of the loop.

OK.

> diff --git a/t/t6137-pathspec-wildcards-literal.sh b/t/t6137-pathspec-wildcards-literal.sh
> new file mode 100755
> index 0000000000..abf837bf6c
> --- /dev/null
> +++ b/t/t6137-pathspec-wildcards-literal.sh
> @@ -0,0 +1,282 @@
> +#!/bin/sh
> +
> +test_description='test wildcards and literals with various git commands'
> +
> +. ./test-lib.sh
> +
> +test_have_prereq FUNNYNAMES || {
> +    skip_all='skipping: needs FUNNYNAMES (non-Windows only)'
> +    test_done
> +}

Do not do 4-space indentation.  We indent with HT (tab).

cf. Documentation/CodingGuidelines

> +reset_git_repo () {
> +    rm -rf .git &&
> +    git init &&
> +    rm -rf "actual_files" "expected_files"

If you have the habit of using "-r" unnecessarily, lose it.

	rm -f actual_files expected_files

Also it is easier to readers if you leave these "obviously literal"
names without quoted.

> +}
> +
> +end_test_properly() {

Style.


> +    cd .. &&
> +    rm -rf "testdir"
> +}
> +
> +
> +test_expect_success 'setup' '
> +    mkdir testdir &&
> +    cd testdir &&
> +    touch "*" "?" "[abc]" "f*" "f?z" "a" &&
> +    touch "**" "foo*bar" "hello?world" "f**" "hello_world" &&
> +    git init
> +'

This is a bad pattern.  What happens if any of the statements failed
before or after you did "cd testdir"?  The next and subsequent test
may or may not run inside "testdir".  The call to end_test at the end
would then go one level up (usually leading you to the t/ directory)
and try to clean things up there, which is not what you want.

> +test_expect_success 'check * wildcard in git add' '
> +    git init &&

In the previous you did "init".  What is the reason why you do
another in the same directory?

Rather, do things perhaps like this?

	git init test-add-asterisk &&
	(
		cd test-add-asterisk &&
                prepare_test_files &&
		git add \* &&
		cat >expect <<-\EOF &&
		*
		**
		?
		...
		EOF
		git ls-files >actual &&
		test_cmp expect actual
	)

That way, each test will be more independent from other tests.

Also unless you have to test with large quantity of data and want to
remove them from the disk as soon as you are done, do not sprinkle
your test with unnecessary "remove the repository and test data"
code.  It is easier when tests do break if you leave them be.

Also notice the use of "-" prefix to cause the leading tabs stripped
from the HERE-DOC lines, and quoting of EOF (here I used \EOF for
brevity and because it is customary to do so but you could use "EOF"
or 'EOF') that causes the HERE-DOC text to taken literally.  They
are both conventions used in this project to make the here-doc text
easier to read.

The prepare_test_files helper may do

	prepare_test_files () {
		for f in "*" "?" "[abc]" "f*" ...
		do
			>"$f" || return
		done
	}	

I'll stop here.

Thanks.
