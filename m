Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB307E1
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332497; cv=none; b=a6uPl/rzqhufn+7vJE8J5sjjQkupJLI0dlM84MqNIEaCh80+NypqEBuGKtp8C3gnXlxUy0x6mt8dU2eROqF3OEQZ7aA2jBBECIxzliJFwrdCRVEEA2fcwLD6GX12KNJgNUoF8BeeIMXm2Ewu+WUE7jRpZA8n1Ry2iqHBWEuNi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332497; c=relaxed/simple;
	bh=0BQgQ3Ew2KPUoyOtkgiwhYbQZAVLAkO6EAjVj0lmbYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KFlTzGdaRyO498KnCyCE8llLLcuSNldA95K7iu5Gd6b7V2RfREZ0IkG0KyemRtPWtLgZpT+nihraj+50TtcZKboEuTHh2oH5l8i0a6+PyYxx+addU5rKiMAreFhadKsETtY5jWti9D1XJw93a5tNJIeeCHVxUN+FhYp0CoGTi/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SxQ0Qun8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B01E8f3x; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SxQ0Qun8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B01E8f3x"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A889513833C3;
	Tue, 18 Mar 2025 17:14:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 18 Mar 2025 17:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742332494; x=1742418894; bh=MFPfUQF3wu
	mbtOdjxOtz/Vin9Q1xa6Kf4bwZpOpGRnw=; b=SxQ0Qun8s/QCeq2LlwEClCJgMn
	iXHS8+VWPML+is5+X4ZpLGjZAwP1NyUowBwvuaQ9FN8boC5rx34xKeQPIyKRPvJJ
	S0/sKCwxma2ZppYb/SUTVGL5SI0XtbwgOir3FIttNA9cZxYOJX0gDsyHk+jZXaK6
	SW2QnPQXue7T7g+xXTtPZBgSpioWbCIJUhwovV1vD/Ib5x/M0doCJ0TqEtvYnBeL
	WmWDSYpOX+Uw7rM5l8HExAmQtYOGDgNZk4XC9xRNttacxPlwEM6jT/uOFed1rmt5
	YzaoNqr71mf8+KZR5uhVstSSxLxTtGZT11CoUbfyogqFlMN5tkE3leIaFasQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742332494; x=1742418894; bh=MFPfUQF3wumbtOdjxOtz/Vin9Q1xa6Kf4bw
	ZpOpGRnw=; b=B01E8f3xdQ4lWSXw2iiJFqrkuAZYSx09XPjUGCDP+rVA+qCi5qQ
	+Wt1xUYOtrdyKZW4+quut1TvAgscuXpJwjqP9RwMQhTxYdFS3didYcJ4ZSsX7jRb
	qcqQ5VgQbXAeYex/Ne+m8tIXG6XItI0pZkwBlISAQ7AfVspYcHPby1BYf+lmAd9f
	vhp1+U1RzEduqGlJOcXGUyy3GVvMJtDsFZEPhVjM5KqUV0VyLgOGWuoGRuHwnPEt
	+6Xl5GQlw5dlq/oNQ4T8r2Y7rpUMZE9LBGvIeh2PrQb80+071HVY0h7JoIPwjKCc
	UfJ73hwMBv/REtYRzR0qWGiR0eHIHmHuhxA==
X-ME-Sender: <xms:TuLZZ6HToz6EXHswCP1e2iWcqBiKpZ2iiRvdQElHQ8g4_6NXZ3yIQA>
    <xme:TuLZZ7XdRdqJ6Jea2n0puVCdunFVMCC19FH9dEsWXtOJgJuR543MTPUWPjVapoHiO
    KhMW0RcWphpRCH_og>
X-ME-Received: <xmr:TuLZZ0JcLAWyHXC3VMBxwlwy4p-S0c8T_y-e0fLSimMcQKOaEOuhEf8odw-_9P9D8ARfeW4bA3V11qjoWn0x-CD3H1lsJU53KHgVKsk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepgfetheeukeejkeffheduhffglefgvdev
    hfelleduudduffejjefgteeltdeiueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhu
    ohesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopehsrghmphhrihihohhguhhinhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TuLZZ0EAgpyl-Napl6be0jfIGeqNf0eVafjWOBcrqE7ssQkeEwZXZQ>
    <xmx:TuLZZwVGxEWUKa5L2L3pbxgiFLefKGaggkef4ZCVT0HtIS35D5atUQ>
    <xmx:TuLZZ3Pq_G4Q7b9VDXqqzIhHmHYYU0CzyNgWgYgLvMaWec4p2uQl8A>
    <xmx:TuLZZ3229MqHIAmLFTuUrrF2ZueuPpy8fFCjeShyCPEKBqrsfIf0KQ>
    <xmx:TuLZZ5NjDGpjSQF5CxQuoaWsA6y6xh2HiDfApQ_boWVU3wv5eCLA0Ofk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 17:14:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Sampriyo Guin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Patrick Steinhardt [ ]" <ps@pks.im>,  "Karthik
 Nayak [ ]" <karthik.188@gmail.com>,  "Jialuo She [ ]"
 <shejialuo@gmail.com>,  "Christian Couder [ ]"
 <christian.couder@gmail.com>,  "Ghanshyam Thakkar [ ]"
 <shyamthakkar001@gmail.com>,  "Eric Sunshine [ ]"
 <sunshine@sunshineco.com>,  Sampriyo Guin <sampriyoguin@gmail.com>
Subject: Re: [PATCH] [GSoC Patch] Modernize Test Path Checking in
 =?utf-8?Q?Git=E2=80=99s?= Test
 Suite
In-Reply-To: <pull.1923.git.git.1742329571265.gitgitgadget@gmail.com>
	(Sampriyo Guin via GitGitGadget's message of "Tue, 18 Mar 2025
	20:26:11 +0000")
References: <pull.1923.git.git.1742329571265.gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 14:14:52 -0700
Message-ID: <xmqq5xk611o3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sampriyo Guin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sampriyo Guin <sampriyoguin@gmail.com>
>
> test -(e|f|d) does not provide a proper error message when hit
> test failures. So test_path_exists, test_path_is_dir,
> test_parh_is_file used.

Correct but ...

> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 2b60317758c..6a8fe69c089 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -156,7 +156,7 @@ test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
>  test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
>  	shellpath=$(git var GIT_SHELL_PATH) &&
>  	case "$shellpath" in
> -	[A-Z]:/*/sh.exe) test -f "$shellpath";;
> +	[A-Z]:/*/sh.exe) test_path_is_file "$shellpath";;
>  	*) return 1;;
>  	esac
>  '

... this one is iffy.  How well does it mesh with the "return 1"
case in the same case/esac?  I do not use Windows, but if
GIT_SHELL_PATH set by that system is not in a form that the platform
expects (i.e. a drive letter and then path to a file "sh.exe"), it
is just as grave a problem worth reporting as the path given is not
a regular file, yet "return 1" case does not give any specific error
message (instead it just lets the test fail), so it feels a bit
uneven to make the "test -f" failure alone louder than it currently
is.

> diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
> index aa7f6ecd813..f76471a3375 100755
> --- a/t/t0601-reffiles-pack-refs.sh
> +++ b/t/t0601-reffiles-pack-refs.sh
> @@ -78,13 +78,13 @@ test_expect_success 'see if a branch still exists after git pack-refs --prune' '
>  test_expect_success 'see if git pack-refs --prune remove ref files' '
>  	git branch f &&
>  	git pack-refs --all --prune &&
> -	! test -f .git/refs/heads/f
> +	! test_path_is_file .git/refs/heads/f
>  '

This conversion is wrong.  We are expecting that the file does *not*
exist, and your complaint and the reason why you are rewriting this
line is that "! test -f" does not give loud message when that file
does exist.  What does "! test_path_is_file foo" do when 'foo'
exists?

You can find the implementation of test_path_is_file with "git grep"
and see for yourself.

    # debugging-friendly alternatives to "test [-f|-d|-e]"
    # The commands test the existence or non-existence of $1
    test_path_is_file () {
            test "$#" -ne 1 && BUG "1 param"
            if ! test -f "$1"
            then
                    echo "File $1 doesn't exist"
                    false
            fi
    }

The test wants to make sure that 'f' is not a file.  So you want to
see a loud complaint when 'f' exists as a file.  Does it do so when
you say

	! test_path_is_file .git/refs/heads/f

in this test?  No, it will not enter the "then" block and silently
succeed, and that return status is negated by that "!", so the test
will notice that the expectation is not met, but you didn't achieve
your goal of making it louder when it fail.  Worse, if the file is
not there, as the test expects when Git is working correctly, your

	! test_path_is_file .git/refs/heads/f

will enter the "then" block, complain that the file does not exist,
returns a failure, and your "!" will turn it into a success.  The
test passes, but the user is given an error message when the test is
run with "-v" option.

>  test_expect_success 'see if git pack-refs --prune removes empty dirs' '
>  	git branch r/s/t &&
>  	git pack-refs --all --prune &&
> -	! test -e .git/refs/heads/r
> +	! test_path_exists .git/refs/heads/r
>  '

Ditto.

I'll stop here.  I think all "! test_path_foo" changes in this patch
are wrong.

Unlike "test_grep" that lets you write "test_grep ! foo bar" to make
sure that file 'bar' has no 'foo' in it (and complains loudly if
'foo' appears in 'bar'), test_path_foo family of helper functions do
not let you write "test_path_exists ! no-such-file" unfortunately.
So my recommendation for a microproject sample is to just drop these
negations from the changes and stop there.

If this were a patch for real, it would make sense to give a
preliminary update to test_path_foo helpers to allow them to take
negated "test_path_exists ! no-such-file" form, and then convert
the negative form as well, but I think that would be a bit more than
what a typical microproject would take.

Thanks.
