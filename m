Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15441C695
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782544139; cv=none; b=D077xiLBewpKF/fJQ+ebbfvaQgkTNwZLSxWDW4yrtudTkQW6HmPDvI+fiNQzd03F/fZiauN6OcO/Klz/ibUMOGPD481RkjcsMupOaUW2NCpEFvK8icMo0BscD0/yIxmn2tXE8kAhr/LDnRridpvaifvrInFRcQ4OPdG9sL/MKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782544139; c=relaxed/simple;
	bh=t08Nng27ejpDGvW5MjDpSHW9PMR6M1mQ+8GQuJ34ljo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCBuYOjj8kFyHuoR/BMVKSeLvp4oWFeH6Zkm4/Xro/IhxC6arCIbwgqlt/8JIlXcy+2HWpalmogq0puVy1PS4zOdvVGGTAT2nloWNrpdMWGI5G1iG6sftdhSyJssbs+XAcHgZ744uOydAGoss5FXcOqXUoShT5gMdNSfEodmspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QznAOeRg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QznAOeRg"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46cf972f281so904402f8f.2
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 00:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782544136; x=1783148936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ynGJPaCdqhf8Fmbrpb+TDQkm2Z1s5ZGdRp1Jnsyz/nY=;
        b=QznAOeRgzytRU5xQHNwHP63c+eIZNcvlPpARaFWOHgY0S47eiYlF6/yOOvvjitbJqo
         E0MpzEzjpdw+xS6k6h5pIoBHCuO1BkGMB76dYeK74v/j4AkXHO1ePIRLEBJ+HkAApesp
         FK22RAKazEKmNsdQmPV1RIgw71BoIvlZgifqb2gjDg5hZrUYvMm1IbXACTurp/gZAZVj
         l4jDUfNXvtQScuTGizn4J1q2hzxaQmidHx2cqBcDn+0LjhBBxFbx+Owft4tN2ERBmcan
         xQYEiWxill7Y2ejrtUJQJPkHhNHFX8B+Vdb4WmuJS0t6gYOkxwgirhxAX9U3WQQKaYCd
         /eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782544136; x=1783148936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynGJPaCdqhf8Fmbrpb+TDQkm2Z1s5ZGdRp1Jnsyz/nY=;
        b=Fl1VQ7RjhXoFoKzIn2QUTIynwlZsfM96pDVt6CG13d4UowHuXebr98jHJAMQRj3GG8
         WTI7+grRL7Iqcu/sCUbbNhwlrOC3VECxIeNVEU3vkLrmQ7TVtgWWW5OxIMSwfmR+YTzL
         bLn6yLpqXgt3b/5n1/7WAxKCP2cceZ5OcJUwA3p/MV8cIBskLaxHgwCnJomns029NIrW
         dU0nwsVX8xbzBDXbEA1oROzAV/rtkkb2ByyhItFs9d7gKNE/mjVZD0nDmVp9OSbPsH09
         U+UsYLeGvlqEKqthWWtMOGDotTIQVNfZqXUQS1+Et41XvwtKcU7qwzc3/pK1LkcB0jmO
         OL0A==
X-Gm-Message-State: AOJu0Yys/4/we5N29j8I5CV4rPN1Vlzu7fEbB/0mmccuvbCsLY2t4gSy
	AgqFZLkaPJ2as/w6VrbC5Xq88MBdAURMaEHOuEQiFyAr9g+29d1V66ce
X-Gm-Gg: AfdE7ckfDPD7+DwCbSQMfkQbzTAVIqLXyGBN2Oxdr2bPvxmbRr0ex1T4ZoRJLpWWoIy
	e5e3eRYRq1pe2VG7fXcuhJhOjpyC6/suBCeP0V9DJRMttFGsrt1LFQRBQZ6q1OKt3D2WbRHPYtK
	espqYgSJ2Ht2LURHyYBou6efDYkEeHkIgv241nlFjRD3HW3Jd63f4QLtMZ+/BN8EYIpTNWYLIYC
	QpsY/PAUS1sNJ/6gIelViz1OheK679Nj4mCHNv0Z8b931MeUqWkoR7gnQ3ur6snIp4K3uE/DndE
	cu3RqFX7SDYPFsvrM/UX6mMpxhfyd0Rv2CJJoooXzdTrGW7q7/OGX3XnH+OXj44MReP618w4J0T
	S9iO9ELk97y2P6HGYYuvGVgDJA2gt16SIk/AD0bsOCareKTjz7fRKM54J3+9ryi6uMiNULtgbB1
	N7bhlqfGFqGRhvoCV2RW3HQMPNEWBT42OS3GBEGP16UpVQHRX4SU9Y64txIWf9rwYXzL2CYj3/0
	A==
X-Received: by 2002:a05:6000:719:b0:466:6d18:ae93 with SMTP id ffacd0b85a97d-46dc0efe55amr14965666f8f.21.1782544135200;
        Sat, 27 Jun 2026 00:08:55 -0700 (PDT)
Received: from localhost (20014C4D24E33B0043387749135D9649.dsl.pool.telekom.hu. [2001:4c4d:24e3:3b00:4338:7749:135d:9649])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-471490336d5sm1853580f8f.35.2026.06.27.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 00:08:54 -0700 (PDT)
Date: Sat, 27 Jun 2026 09:08:52 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 5/6] t: convert grep assertions to test_grep
Message-ID: <aj93BE8MYatQAjoy@szeder.dev>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
 <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
 <3a589ef7386303075413f388e61c203c4e325d44.1781323575.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a589ef7386303075413f388e61c203c4e325d44.1781323575.git.gitgitgadget@gmail.com>

On Sat, Jun 13, 2026 at 04:06:14AM +0000, Michael Montalbo via GitGitGadget wrote:
> From: Michael Montalbo <mmontalbo@gmail.com>
> 
> Replace bare grep with test_grep in test assertions across the
> suite, including sourced test helpers (lib-*.sh, *-tests.sh).
> test_grep prints the contents of the file being searched on
> failure, making debugging easier than a bare grep which fails
> silently.
> 
> Only assertion-style greps are converted: grep used as a filter
> in pipelines, command substitutions, conditionals, or with
> redirected I/O is left as-is with a "# lint-ok" annotation.
> Existing '! test_grep' calls are rewritten to 'test_grep !' so
> that the diagnostic output is preserved on failure.

Thanks for taking the effort for cleaning up all those negated '!
grep' and '! test_grep' callsites and turning them into 'test_grep !'.

> The conversion was generated using a grep-assertion linter
> (greplint.pl, added in the following commit) to identify bare
> grep calls at command position.  To reproduce:
> 
>     # Step 1: mark bare greps that should not be converted
>     sed -i '/! grep "$m" \.git\/packed-refs/s/$/ # lint-ok: file may not exist (reftable)/' \
>         t/t1400-update-ref.sh
>     sed -i '/! grep dirty file3 &&/{/lint-ok/!s/$/ # lint-ok: file may not exist after --quit/}' \
>         t/t3420-rebase-autostash.sh

I think in this case checking the file3's contents is wrong, because
at this point file3 should not exist in the first place.  I've sent a
patch to fix this long ago, but apparently didn't manage to follow
through back then.

  https://lore.kernel.org/git/20211010172809.1472914-1-szeder.dev@gmail.com/


> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index f0bbc476ff..f6cb3dd72e 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -141,8 +141,8 @@ testrebase () {
>  		git checkout -b rebased-feature-branch feature-branch &&
>  		echo dirty >>file3 &&
>  		git rebase$type unrelated-onto-branch >actual 2>&1 &&
> -		grep unrelated file4 &&
> -		grep dirty file3 &&
> +		test_grep unrelated file4 &&
> +		test_grep dirty file3 &&
>  		git checkout feature-branch
>  	'
>  
> @@ -165,8 +165,8 @@ testrebase () {
>  		echo dirty >>file3 &&
>  		git add file3 &&
>  		git rebase$type unrelated-onto-branch &&
> -		grep unrelated file4 &&
> -		grep dirty file3 &&
> +		test_grep unrelated file4 &&
> +		test_grep dirty file3 &&
>  		git checkout feature-branch
>  	'
>  
> @@ -197,7 +197,7 @@ testrebase () {
>  		git add file2 &&
>  		git rebase --continue &&
>  		test_path_is_missing $dotest/autostash &&
> -		grep dirty file3 &&
> +		test_grep dirty file3 &&
>  		git checkout feature-branch
>  	'
>  
> @@ -212,7 +212,7 @@ testrebase () {
>  		test_path_is_missing file3 &&
>  		git rebase --skip &&
>  		test_path_is_missing $dotest/autostash &&
> -		grep dirty file3 &&
> +		test_grep dirty file3 &&
>  		git checkout feature-branch
>  	'
>  
> @@ -227,7 +227,7 @@ testrebase () {
>  		test_path_is_missing file3 &&
>  		git rebase --abort &&
>  		test_path_is_missing $dotest/autostash &&
> -		grep dirty file3 &&
> +		test_grep dirty file3 &&
>  		git checkout feature-branch
>  	'
>  
> @@ -244,7 +244,7 @@ testrebase () {
>  		git rebase --quit &&
>  		test_when_finished git stash drop &&
>  		test_path_is_missing $dotest/autostash &&
> -		! grep dirty file3 &&
> +		! grep dirty file3 && # lint-ok: file may not exist after --quit
>  		git stash show -p >actual &&
>  		test_cmp expect actual &&
>  		git reset --hard &&
> @@ -260,11 +260,11 @@ testrebase () {
>  		git rebase$type unrelated-onto-branch >actual 2>&1 &&
>  		test_path_is_missing $dotest &&
>  		git reset --hard &&
> -		grep unrelated file4 &&
> -		! grep dirty file4 &&
> +		test_grep unrelated file4 &&
> +		test_grep ! dirty file4 &&
>  		git checkout feature-branch &&
>  		git stash pop &&
> -		grep dirty file4
> +		test_grep dirty file4
>  	'
>  
>  	test_expect_success "rebase$type: check output with conflicting stash" '
> @@ -286,7 +286,7 @@ test_expect_success "rebase: fast-forward rebase" '
>  	test_when_finished git branch -D behind-feature-branch &&
>  	echo dirty >>file1 &&
>  	git rebase feature-branch &&
> -	grep dirty file1 &&
> +	test_grep dirty file1 &&
>  	git checkout feature-branch
>  '
>  
> @@ -297,7 +297,7 @@ test_expect_success "rebase: noop rebase" '
>  	test_when_finished git branch -D same-feature-branch &&
>  	echo dirty >>file1 &&
>  	git rebase feature-branch &&
> -	grep dirty file1 &&
> +	test_grep dirty file1 &&
>  	git checkout feature-branch
>  '
>  
