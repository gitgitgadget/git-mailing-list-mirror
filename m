Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C61E5213
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038741; cv=none; b=sHojPmc8a0zzVQ2KnNjqCQorrZLOcKoCeem0VQ7tqUCmoZv2PP7TSRLSRmw4MLBYIalBJH2AAItb4jW4xNpWfsGxSSJ5mYIAJPfKrSUdAXyCfmSxMer3U8AhhaM/WgrO7JWXD4unmch4mWKA+vtk1taK3XhQAZME4UVOfqagZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038741; c=relaxed/simple;
	bh=frIH188rDw8HhxA/m4d44uMcaJtk6Qg4tpWt20oTKFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nz5Yn7PAc1b7zM/UwIEsDsks/alu938xetHYu6aQzbquhxFgECMilH6imSTYjGlwDN+tuTPPcNGCgE/2Al7uSTzyQaJ97Ex55mE+n2m4Cd+8MhwWlb2OqYaR21DnvQTDs7P4jROlqT10TUEGDgL9PcxEHdaHnMpCBVoEbVW/xgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pwrv2n5x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DkY/AMkm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pwrv2n5x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DkY/AMkm"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DB0CA11401CF;
	Mon,  3 Mar 2025 16:52:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 16:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741038737; x=1741125137; bh=YnskFRB4BW
	4D0Rs0VbtNb6KlHcEmAhfS+d3tnCJcDdM=; b=Pwrv2n5xW9pRxnQw5TTqrZfAgC
	8HtxFHFwIQh3kLoz5IwO2l+YCSspZJ2lWICI+8yH3tdU+/NT+UByaHhqYA8NHkr1
	HjOXgqHcOnUsEyNxq7TOVVLuBtUYLlirOQ2RmTFTUzQP+VpwlvOvBrqtOoccvpM2
	wq3kmP6Ln8fnalVXlRS8GLSuiFL35VJ2PEn4vyqe4qFSs8Ffb90wz40R3ii/XkXV
	cIoJug4KzHFILYT7v8tYEqxqFGTc7FDAd52i5BbR0DmqhJ1fFXKOsKJZKXFb8uXX
	cWDmuoI3G8ppu1/I6o2yvpJTOePPoK6nQrGrY+MvbkLK/SOHPSvh975lUc/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741038737; x=1741125137; bh=YnskFRB4BW4D0Rs0VbtNb6KlHcEmAhfS+d3
	tnCJcDdM=; b=DkY/AMkm7v1aU0pEbGmhM9TIkH8xojXXgmospM/ChG7nxwDd+ZE
	YFOwyi+pIPLzKORvEt8tuj+ff/NfOUDEY/ubWbj1/21JcXagRhAod4GJYRV7Ny9x
	xGbGiWllTuI/2nSHUVJsldR1ZuqOowcd8i/CYUnS0TwV1TKqyVRXIQQdrhhIPckQ
	nQm6KngkK+SGmpXGR0LC1TxVlUZFSy8FWF1CiKI9VrBLZhEY9MTE19ewc2H8C9+u
	2W2frRO2C1odAL8P+L0mtywFsETzLYODAKe+ev/hu98San8f3cKQixefpUnasQ/U
	PwKs5isRqI8V9iOBK2CUgaMPJjPusSJt/mw==
X-ME-Sender: <xms:kSTGZ8OgBbKu943CxyqxGf-7PwojiWiQXNm9yN4t3mB6rGfeMbGmaQ>
    <xme:kSTGZy_BjnDuZzFstJCTXRBnGEgWY9nvJFEMyYpoUzC3jb-_1kfcZ4xB3XLn4VFba
    fEUQW69VKpgiE8_Rw>
X-ME-Received: <xmr:kSTGZzTTDP-R2d3htwnepLpMRDP4pojccbPaBXE5chJQQkvI40ClbxwliJVapTRZkTfHLVW5YmSIouOevRpWXGnxHyTbqPM59nuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:kSTGZ0sRCi8sTolrQt4WdZZ3gMUjhrN--x_FHrq7UEQLiSgiNfm1sA>
    <xmx:kSTGZ0eDOkoSAs5fRLFetyNClBr2jbBotbQPn8FHIDFDIdg0uTihwg>
    <xmx:kSTGZ41LNkV3OzPF16Fay7uPEqqQ_sZM22h4PL6F8wVfVspTqrws_Q>
    <xmx:kSTGZ49qmJ7W4h185Fex66_KoOSagQgjn8MaEnHG_wAFaUAJ0zCS5w>
    <xmx:kSTGZz4ccagjJXe7vHP1kEQF2qw4q8hSORQA6hgQj2VudLjbKfIcG_cD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 16:52:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/34] t0450: *.txt -> *.adoc fixes
In-Reply-To: <20250303204443.360595-2-tmz@pobox.com> (Todd Zullinger's message
	of "Mon, 3 Mar 2025 15:43:59 -0500")
References: <20250303204443.360595-1-tmz@pobox.com>
	<20250303204443.360595-2-tmz@pobox.com>
Date: Mon, 03 Mar 2025 13:52:15 -0800
Message-ID: <xmqqo6yhvl2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> After 1f010d6bdf (doc: use .adoc extension for AsciiDoc files,
> 2025-01-20), we no longer matched any files in this test.  The result is
> that we did not test for mismatches in the documentation and --help
> output.
>
> Adjust the test to look at the renamed *.adoc files.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  t/t0450-txt-doc-vs-help.sh                    | 50 +++++++++----------
>  ...t-help-mismatches => adoc-help-mismatches} |  0
>  2 files changed, 25 insertions(+), 25 deletions(-)
>  rename t/t0450/{txt-help-mismatches => adoc-help-mismatches} (100%)

Wow, good find.  This is especially bad and I am glad we caught it
before -rc1 (the hope was that all of these should have been caught
while the topic was in 'next', which was the whole point of cooking
it longer in 'next' than usual, but that plan did not really work).

> diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
> index 853101b86e..2f7504ae7e 100755
> --- a/t/t0450-txt-doc-vs-help.sh
> +++ b/t/t0450-txt-doc-vs-help.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -test_description='assert (unbuilt) Documentation/*.txt and -h output
> +test_description='assert (unbuilt) Documentation/*.adoc and -h output
>  
>  Run this with --debug to see a summary of where we still fail to make
>  the two versions consistent with one another.'
> @@ -11,11 +11,11 @@ test_expect_success 'setup: list of builtins' '
>  	git --list-cmds=builtins >builtins
>  '
>  
> -test_expect_success 'list of txt and help mismatches is sorted' '
> -	sort -u "$TEST_DIRECTORY"/t0450/txt-help-mismatches >expect &&
> -	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/txt-help-mismatches
> +test_expect_success 'list of adoc and help mismatches is sorted' '
> +	sort -u "$TEST_DIRECTORY"/t0450/adoc-help-mismatches >expect &&
> +	if ! test_cmp expect "$TEST_DIRECTORY"/t0450/adoc-help-mismatches
>  	then
> -		BUG "please keep the list of txt and help mismatches sorted"
> +		BUG "please keep the list of adoc and help mismatches sorted"
>  	fi
>  '
>  
> @@ -40,20 +40,20 @@ help_to_synopsis () {
>  	echo "$out"
>  }
>  
> -builtin_to_txt () {
> -       echo "$GIT_BUILD_DIR/Documentation/git-$1.txt"
> +builtin_to_adoc () {
> +       echo "$GIT_BUILD_DIR/Documentation/git-$1.adoc"
>  }
>  
> -txt_to_synopsis () {
> +adoc_to_synopsis () {
>  	builtin="$1" &&
>  	out_dir="out/$builtin" &&
> -	out="$out_dir/txt.synopsis" &&
> +	out="$out_dir/adoc.synopsis" &&
>  	if test -f "$out"
>  	then
>  		echo "$out" &&
>  		return 0
>  	fi &&
> -	b2t="$(builtin_to_txt "$builtin")" &&
> +	b2t="$(builtin_to_adoc "$builtin")" &&
>  	sed -n \
>  		-E '/^\[(verse|synopsis)\]$/,/^$/ {
>  			/^$/d;
> @@ -109,29 +109,29 @@ do
>  		fi
>  	'
>  
> -	txt="$(builtin_to_txt "$builtin")" &&
> -	preq="$(echo BUILTIN_TXT_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
> +	adoc="$(builtin_to_adoc "$builtin")" &&
> +	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
>  
> -	if test -f "$txt"
> +	if test -f "$adoc"
>  	then
>  		test_set_prereq "$preq"
>  	fi &&
>  
> -	# *.txt output assertions
> -	test_expect_success "$preq" "$builtin *.txt SYNOPSIS has dashed labels" '
> -		check_dashed_labels "$(txt_to_synopsis "$builtin")"
> +	# *.adoc output assertions
> +	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
> +		check_dashed_labels "$(adoc_to_synopsis "$builtin")"
>  	'
>  
> -	# *.txt output consistency assertions
> +	# *.adoc output consistency assertions
>  	result=
> -	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/txt-help-mismatches
> +	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-help-mismatches
>  	then
>  		result=failure
>  	else
>  		result=success
>  	fi &&
>  	test_expect_$result "$preq" "$builtin -h output and SYNOPSIS agree" '
> -		t2s="$(txt_to_synopsis "$builtin")" &&
> +		t2s="$(adoc_to_synopsis "$builtin")" &&
>  		if test "$builtin" = "merge-tree"
>  		then
>  			test_when_finished "rm -f t2s.new" &&
> @@ -140,17 +140,17 @@ do
>  		fi &&
>  		h2s="$(help_to_synopsis "$builtin")" &&
>  
> -		# The *.txt and -h use different spacing for the
> +		# The *.adoc and -h use different spacing for the
>  		# alignment of continued usage output, normalize it.
> -		align_after_nl "$builtin" <"$t2s" >txt &&
> +		align_after_nl "$builtin" <"$t2s" >adoc &&
>  		align_after_nl "$builtin" <"$h2s" >help &&
> -		test_cmp txt help
> +		test_cmp adoc help
>  	'
>  
> -	if test_have_prereq "$preq" && test -e txt && test -e help
> +	if test_have_prereq "$preq" && test -e adoc && test -e help
>  	then
>  		test_debug '
> -			if test_cmp txt help >cmp 2>/dev/null
> +			if test_cmp adoc help >cmp 2>/dev/null
>  			then
>  				echo "=== DONE: $builtin ==="
>  			else
> @@ -161,7 +161,7 @@ do
>  
>  		# Not in test_expect_success in case --run is being
>  		# used with --debug
> -		rm -f txt help tmp 2>/dev/null
> +		rm -f adoc help tmp 2>/dev/null
>  	fi
>  done <builtins
>  
> diff --git a/t/t0450/txt-help-mismatches b/t/t0450/adoc-help-mismatches
> similarity index 100%
> rename from t/t0450/txt-help-mismatches
> rename to t/t0450/adoc-help-mismatches
