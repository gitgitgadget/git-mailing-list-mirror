Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9FF25A63F
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913359; cv=none; b=d1n6/FaelKs8vsV8YE9M1lnywSHJYZSsEYyTtglK4jDrHY8UvZWj1J1uO33v2CwjrstCHG6mF1BCZWIhG3JZLMSVeoZWZITmK8N+1BtJS+zwhap4HbPROJyXywim+6ongtimzVWR9gFqjTPrBQdwHizGloqqHYB1XlMGCY0sKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913359; c=relaxed/simple;
	bh=XHXNeJH1WpEMIJkW6LAazdjX5VMhK6LFH7/QF+HobZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmaXV22rVxCIJ2POWqGv8qNEyUusVNTdXJgZGbEdnWIh8/xBwDLlSpUwCkrlXNsfTcinLd102W44BpG2GpKVrksB/RpAzEgIzJkP6xb9D4p4O4+vbbeIzwfTDu9UzgAgM4lqlTuC/Nc2+p/GGiPyHKxt5vbnogQDpOYHXz4o+BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVpOQAFQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVpOQAFQ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4632961f8f.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742913356; x=1743518156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pFeOa+oWeMdnvyqhEj4FmELUpMq3yUf3P1PKCOIbWdE=;
        b=gVpOQAFQNaEi1t00Yz3KwynyqE7StvjywcZjIu3evwNhwfcRK/NaBPqJqcstuhyngF
         9TFmTMw+RC6iE/QokAJa8j6Be4kmn6GHyWI2/3K1LWEFzScpoTG1cKJkJxTwOnf4U6WC
         7Mt/hxszjVtGRyufGFxPVY1xC2MFcNDmURcbm6HxcZ/E201mNUl6Z6Fv9ib7qxFRGCpi
         eNM2ju72euMHoHBxeGs8V0DpKDo3hsNrh39qt619th7C5QIsvYIvfvZa6WEXr7D45hbn
         FBEhSc3gMjSocrxZShKsqr1qavbkbfUhP8D+OtuHQut/2lIwDlINHSCZOXuWYnGpFKsw
         nglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913356; x=1743518156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFeOa+oWeMdnvyqhEj4FmELUpMq3yUf3P1PKCOIbWdE=;
        b=pVKjWxKLVUX86YQftCBkUQXbdiH0EFDKAWBInrapt12n03p9SbwDnZG01u6fvopWp8
         eaIA0Fl+0mtwRKeXNODiQvYqihFTqx3giaVJKRi0nmBNkC1tvPAtf864iOlCSW0OPPLf
         AByFYe5O74xQOYzjJGS6SPnQmNz1xW+pa282yEt8WOLm10mXlDXJ7slGcH7lombQILPs
         n1oqdN3KC5Zo50ZnA6ejcD4NL4QuF37EF7lJ6OF3k4MMqGgimq41fMEHgKCo+TlQkg/8
         onJbkAHU2z8hDtnr1cajX49CqNsr0662DuXtXqs5d3qMQiA0ChnFtOjUSSpf1dDD1CG8
         dt2g==
X-Forwarded-Encrypted: i=1; AJvYcCVqoIAaupdoXCUJNitfdmlrmDJcE8bHCbTskKwytJRlg/yLHd4o/ysIPHB4DsmfHEryfpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH78eGR+elu0kUe2+L+JFqOnkdq2X/YJWtV45Eq1YxOS1IqK6X
	IUcJtmkzcVaK04vCyE1D8h0WtimsUo2FLbm/p2Q4QAWvS/TYG6RR
X-Gm-Gg: ASbGnctdK6nEtjfcDcYocnhOmkedLlnmUMlz9bh23VVXINaV5FqL4GgwbKQiO49PAsD
	D0fxboisNVdLAFKKlNrR5I+gbunSakgOTJLB6eK3192SvMdSkDiPLs7lJ7ujYLyhXHM+umwnSLe
	97KxIn6bFxPjYMUJkk1lxM4Ioffb0n3OwSjuScVP/q3i4mvWrH7XAUov7d9FL9/8oqwKJ0+U+kN
	Y0pvhSPzLOY9UVx65niR8eBEGxG5Na0eLfelEChv7PKxY+CT0DOvftvtsYY9ZIwtX0KMrlPpKYF
	wugMSLrDRtkypuyDSshNCMEMJOwo7+qfBv0X53mENoTDn26OKoO7pHC2y+JTJLAlkUyWDbDw+zH
	zL7u/xmvLFcE7rD6+9bRu
X-Google-Smtp-Source: AGHT+IHShrRr9oJAxxwnJU3DOc0xeUcYOkNt96JS+PfNw9kYY8DtNsfcX/+VjvbZ4M64N6Me7Yqrgw==
X-Received: by 2002:a5d:47a2:0:b0:391:47d8:de25 with SMTP id ffacd0b85a97d-3997f937634mr16595218f8f.41.1742913355496;
        Tue, 25 Mar 2025 07:35:55 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6450sm13995551f8f.70.2025.03.25.07.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:35:55 -0700 (PDT)
Message-ID: <198d1d40-ea1f-4362-821c-2cc621892e4e@gmail.com>
Date: Tue, 25 Mar 2025 14:35:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 11/20] t: refactor tests depending on Perl substitution
 operator
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
 <20250325-b4-pks-t-perlless-v2-11-4b87b8072670@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-11-4b87b8072670@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 25/03/2025 13:14, Patrick Steinhardt wrote:
>   broken_c_unquote () {
> -	"$PERL_PATH" -pe 's/^"//; s/\\//; s/"$//; tr/\n/\0/' "$@"
> +	sed -e 's/^"//' -e 's/\\//' -e 's/"$//' "$1" | tr '\n' '\0'
>   }
>   
>   broken_c_unquote_verbose () {
> -	"$PERL_PATH" -pe 's/	"/	/; s/\\//; s/"$//; tr/:\t\n/\0/' "$@"
> +	sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' "$1" | tr ':\t\n' '\000'
>   }

Thanks for removing the redirection here, unfortunately there are still 
a whole bunch of needless input redirections below.

Best Wishes

Phillip

>   stderr_contains () {
> diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
> index a92a42990b1..db75998e35f 100755
> --- a/t/t4029-diff-trailing-space.sh
> +++ b/t/t4029-diff-trailing-space.sh
> @@ -18,7 +18,7 @@ index 5f6a263..8cb8bae 100644
>   EOF
>   exit 1
>   
> -test_expect_success PERL_TEST_HELPERS "$test_description" '
> +test_expect_success "$test_description" '
>   	printf "\nx\n" > f &&
>   	before=$(git hash-object f) &&
>   	before=$(git rev-parse --short $before) &&
> @@ -31,7 +31,8 @@ test_expect_success PERL_TEST_HELPERS "$test_description" '
>   	git config --bool diff.suppressBlankEmpty true &&
>   	git diff f > actual &&
>   	test_cmp exp actual &&
> -	perl -i.bak -p -e "s/^\$/ /" exp &&
> +	sed "s/^\$/ /" <exp >exp.munged &&

> +	mv exp.munged exp &&
>   	git config --bool diff.suppressBlankEmpty false &&
>   	git diff f > actual &&
>   	test_cmp exp actual &&
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 7fcca9ddad5..bacb93d014f 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -27,12 +27,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
>   . ./test-lib.sh
>   
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all='skipping rerere tests; Perl not available'
> -	test_done
> -fi
> -
>   test_expect_success 'setup' '
>   	cat >a1 <<-\EOF &&
>   	Some title
> @@ -87,7 +81,7 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
>   	test_might_fail git config --unset rerere.enabled &&
>   	test_must_fail git merge first &&
>   
> -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
> +	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
>   	rr=.git/rr-cache/$sha1 &&
>   	grep "^=======\$" $rr/preimage &&
>   	! test -f $rr/postimage &&
> @@ -100,7 +94,7 @@ test_expect_success 'rerere.enabled works, too' '
>   	git reset --hard &&
>   	test_must_fail git merge first &&
>   
> -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
> +	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
>   	rr=.git/rr-cache/$sha1 &&
>   	grep ^=======$ $rr/preimage
>   '
> @@ -110,7 +104,7 @@ test_expect_success 'set up rr-cache' '
>   	git config rerere.enabled true &&
>   	git reset --hard &&
>   	test_must_fail git merge first &&
> -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
> +	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
>   	rr=.git/rr-cache/$sha1
>   '
>   
> diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
> index ac5e370e1e4..07382797bbb 100755
> --- a/t/t5303-pack-corruption-resilience.sh
> +++ b/t/t5303-pack-corruption-resilience.sh
> @@ -99,11 +99,12 @@ test_expect_success '... and loose copy of first delta allows for partial recove
>   	git cat-file blob $blob_3 > /dev/null
>   '
>   
> -test_expect_success PERL_TEST_HELPERS 'create corruption in data of first object' '
> +test_expect_success 'create corruption in data of first object' '
>   	create_new_pack &&
>   	git prune-packed &&
>   	chmod +w ${pack}.pack &&
> -	perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
> +	sed "s/ base /abcdef/" <${pack}.pack >${pack}.pack.munged &&
> +	mv ${pack}.pack.munged ${pack}.pack &&
>   	test_must_fail git cat-file blob $blob_1 > /dev/null &&
>   	test_must_fail git cat-file blob $blob_2 > /dev/null &&
>   	test_must_fail git cat-file blob $blob_3 > /dev/null
> @@ -156,11 +157,12 @@ test_expect_success '... and then a repack "clears" the corruption' '
>   	git cat-file blob $blob_3 > /dev/null
>   '
>   
> -test_expect_success PERL_TEST_HELPERS 'create corruption in data of first delta' '
> +test_expect_success 'create corruption in data of first delta' '
>   	create_new_pack &&
>   	git prune-packed &&
>   	chmod +w ${pack}.pack &&
> -	perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
> +	sed "s/ delta1 /abcdefgh/" <${pack}.pack >${pack}.pack.munged &&
> +	mv ${pack}.pack.munged ${pack}.pack &&
>   	git cat-file blob $blob_1 > /dev/null &&
>   	test_must_fail git cat-file blob $blob_2 > /dev/null &&
>   	test_must_fail git cat-file blob $blob_3 > /dev/null
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 81987296235..9033d72b8c7 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -395,7 +395,7 @@ test_bitmap_cases () {
>   		)
>   	'
>   
> -	test_expect_success PERL_TEST_HELPERS 'pack.preferBitmapTips' '
> +	test_expect_success 'pack.preferBitmapTips' '
>   		git init repo &&
>   		test_when_finished "rm -fr repo" &&
>   		(
> @@ -421,7 +421,7 @@ test_bitmap_cases () {
>   
>   			# mark the commits which did not receive bitmaps as preferred,
>   			# and generate the bitmap again
> -			perl -pe "s{^}{create refs/tags/include/$. }" <before |
> +			sed "s|\(.*\)|create refs/tags/include/\1 \1|" <before |
>   				git update-ref --stdin &&
>   			git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
>   
> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 342d0423c92..d5c0d00114e 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -177,7 +177,7 @@ test_expect_success GPGSSH 'ssh signed push sends push certificate' '
>   	test_cmp expect dst/push-cert-status
>   '
>   
> -test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent push options in signed push not allowed' '
> +test_expect_success GPG 'inconsistent push options in signed push not allowed' '
>   	# First, invoke receive-pack with dummy input to obtain its preamble.
>   	prepare_dst &&
>   	git -C dst config receive.certnonceseed sekrit &&
> @@ -205,7 +205,7 @@ test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent push options in signed p
>   	# Tweak the push output to make the push option outside the cert
>   	# different, then replay it on a fresh dst, checking that ff is not
>   	# deleted.
> -	perl -pe "s/([^ ])bar/\$1baz/" push >push.tweak &&
> +	sed "s/\([^ ]\)bar/\1baz/" <push >push.tweak &&
>   	prepare_dst &&
>   	git -C dst config receive.certnonceseed sekrit &&
>   	git -C dst config receive.advertisepushoptions 1 &&
> diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
> index 6131c361094..12329aab388 100755
> --- a/t/t6011-rev-list-with-bad-commit.sh
> +++ b/t/t6011-rev-list-with-bad-commit.sh
> @@ -4,12 +4,6 @@ test_description='git rev-list should notice bad commits'
>   
>   . ./test-lib.sh
>   
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all='skipping rev-list with bad commit tests; Perl not available'
> -	test_done
> -fi
> -
>   # Note:
>   # - compression level is set to zero to make "corruptions" easier to perform
>   # - reflog is disabled to avoid extra references which would twart the test
> @@ -41,11 +35,15 @@ test_expect_success 'verify number of revisions' \
>      first_commit=$(git rev-parse HEAD~3)
>      '
>   
> -test_expect_success 'corrupt second commit object' \
> -   '
> -   perl -i.bak -pe "s/second commit/socond commit/" .git/objects/pack/*.pack &&
> -   test_must_fail git fsck --full
> -   '
> +test_expect_success 'corrupt second commit object' '
> +	for p in .git/objects/pack/*.pack
> +	do
> +		sed "s/second commit/socond commit/" <"$p" >"$p.munged" &&
> +		mv "$p.munged" "$p" ||
> +		return 1
> +	done &&
> +	test_must_fail git fsck --full
> +'
>   
>   test_expect_success 'rev-list should fail' '
>   	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git -c core.commitGraph=false rev-list --all > /dev/null
> diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
> index 14069600a2f..00b81d349b9 100755
> --- a/t/t7416-submodule-dash-url.sh
> +++ b/t/t7416-submodule-dash-url.sh
> @@ -4,12 +4,6 @@ test_description='check handling of disallowed .gitmodule urls'
>   
>   . ./test-lib.sh
>   
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all='skipping submodule dash URL tests; Perl not available'
> -	test_done
> -fi
> -
>   test_expect_success 'setup' '
>   	git config --global protocol.file.allow always
>   '
> @@ -39,7 +33,8 @@ test_expect_success 'fsck accepts protected dash' '
>   '
>   
>   test_expect_success 'remove ./ protection from .gitmodules url' '
> -	perl -i -pe "s{\./}{}" .gitmodules &&
> +	sed "s|\./||" <.gitmodules >.gitmodules.munged &&
> +	mv .gitmodules.munged .gitmodules &&
>   	git commit -am "drop protection"
>   '
>   
> diff --git a/t/t7508-status.sh b/t/t7508-status.sh
> index 14c41b2cb7c..cdc1d6fcc78 100755
> --- a/t/t7508-status.sh
> +++ b/t/t7508-status.sh
> @@ -1064,9 +1064,9 @@ test_expect_success 'status -s submodule summary (clean submodule)' '
>   	test_cmp expect output
>   '
>   
> -test_expect_success PERL_TEST_HELPERS 'status -z implies porcelain' '
> +test_expect_success 'status -z implies porcelain' '
>   	git status --porcelain |
> -	perl -pe "s/\012/\000/g" >expect &&
> +	tr "\012" "\000" >expect &&
>   	git status -z >output &&
>   	test_cmp expect output
>   '
> diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
> index 5cb16872081..810dac18f56 100755
> --- a/t/t8006-blame-textconv.sh
> +++ b/t/t8006-blame-textconv.sh
> @@ -4,12 +4,6 @@ test_description='git blame textconv support'
>   
>   . ./test-lib.sh
>   
> -if ! test_have_prereq PERL_TEST_HELPERS
> -then
> -	skip_all='skipping blame textconv tests; Perl not available'
> -	test_done
> -fi
> -
>   find_blame() {
>   	sed -e 's/^[^(]*//'
>   }
> @@ -17,7 +11,7 @@ find_blame() {
>   cat >helper <<'EOF'
>   #!/bin/sh
>   grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
> -"$PERL_PATH" -p -e 's/^bin: /converted: /' "$1"
> +sed 's/^bin: /converted: /' <"$1"
>   EOF
>   chmod +x helper
>   
> diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
> index a9d38be997c..9afdb45b1cc 100755
> --- a/t/t9137-git-svn-dcommit-clobber-series.sh
> +++ b/t/t9137-git-svn-dcommit-clobber-series.sh
> @@ -15,13 +15,13 @@ test_expect_success 'initialize repo' '
>   	test -e file
>   	'
>   
> -test_expect_success PERL_TEST_HELPERS '(supposedly) non-conflicting change from SVN' '
> +test_expect_success '(supposedly) non-conflicting change from SVN' '
>   	test x"$(sed -n -e 58p < file)" = x58 &&
>   	test x"$(sed -n -e 61p < file)" = x61 &&
>   	svn_cmd co "$svnrepo" tmp &&
>   	(cd tmp &&
> -		perl -i.bak -p -e "s/^58$/5588/" file &&
> -		perl -i.bak -p -e "s/^61$/6611/" file &&
> +		sed -e "s/^58$/5588/" -e "s/^61$/6611/" <file >file.munged &&
> +		mv file.munged file &&
>   		poke file &&
>   		test x"$(sed -n -e 58p < file)" = x5588 &&
>   		test x"$(sed -n -e 61p < file)" = x6611 &&
> @@ -37,11 +37,13 @@ test_expect_success 'some unrelated changes to git' "
>   	git commit -m bye-life life
>   	"
>   
> -test_expect_success PERL_TEST_HELPERS 'change file but in unrelated area' "
> +test_expect_success 'change file but in unrelated area' "
>   	test x\"\$(sed -n -e 4p < file)\" = x4 &&
>   	test x\"\$(sed -n -e 7p < file)\" = x7 &&
> -	perl -i.bak -p -e 's/^4\$/4444/' file &&
> -	perl -i.bak -p -e 's/^7\$/7777/' file &&
> +	sed -e 's/^4\$/4444/' \
> +	    -e 's/^7\$/7777/' \
> +		<file >file.munged &&
> +	mv file.munged file &&
>   	test x\"\$(sed -n -e 4p < file)\" = x4444 &&
>   	test x\"\$(sed -n -e 7p < file)\" = x7777 &&
>   	git commit -m '4 => 4444, 7 => 7777' file &&
> 

