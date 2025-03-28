Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AC1A5BAE
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743157802; cv=none; b=fFraruPjqYTfZmlA//izJ7nNMc6p3RL0G7zg5JRZLcaRSgZ7B/q9gV4APyPCDjKZKeX3g7zNQXQYCCr9n4Pxnopsnci8HlvqfGjbpF2jKd22HzvFF4pzy6UJYkPk1MFH1Si9hnMUI3s7N7Xi6qMwE0mrWiff4CY0FAnZV40wGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743157802; c=relaxed/simple;
	bh=MsZ7imwA11GOAWgY129M+zbc0aebOUn1eobJhbT2Dn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fR88je0DQbKh6ch0ROZgaB1UAO6znrkNcqfVpkErJGAbqhQ9AkzjirjxJ+OP+PTN1daUTvKZw3fkNnILWGOvR04l18QNpfdVcBYqe4K4lX4n7e5cYnH3bRDjoottyxX7IjeX3yqbF6wlwNnFnspXn77Hg6TOJU82ahToLhusIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGyXOaD5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGyXOaD5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39149bccb69so1684249f8f.2
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743157798; x=1743762598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LopKx/TyxESkTh3vDQx4QRumiutbqYp+1BcTInb5QyM=;
        b=jGyXOaD5j1djmjR2NHlvXqJ1s4dre3EXhPC1Z0RVNGppcS1LM/oFcECjNt01QEkvYz
         Ml+MFPteWdh+mku+iFgYSCeCm/UMF+Ax/8OD++2Fj7LzJp9JZ9WXcIULdEws/VUb0216
         WSF9oNvNksvitdx9BfuUUDCCDQ7pZGFeNNcHlUKy/499XzaAb6tN+YZiaOq7h85wmgzZ
         MLRpf6uoPSB7giiskxB0P9EWCXaEg8maoFvEIQMipoFrr0f60cQCaRjQmbtkV32jH/CO
         +wLoIN7BEfR6VSXcaQGqT6weviCqOpzhT5jIecRxPTNxl2sjwfHLIN+5+YJiUdARNXeM
         sc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743157798; x=1743762598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LopKx/TyxESkTh3vDQx4QRumiutbqYp+1BcTInb5QyM=;
        b=vu2/lrfrs83vk/zDbNbsB60ICrbPwGk8K9I8crLPc0cPczPwpkJ8Up6/Rv4O8b/3PF
         vmA5UOHWp9+PJJ/K32veHMHTVzUTPWKTS+LoO+quiDmue1ijEPeY4ms+QMupyJjYsTm/
         YVHWmQ2dGMA6SzbOCcPVLbVZ6ha/3mqc4aLZa/VoDZw6CBvQwuswh/zwkBggcIEuuKM8
         Uonn1gNmTD18kWhMqdOgrYXsBdQFBKfMlUWFvdBLyezia3ZhO4LsJF78E7ocxaOE0cd8
         2vr2LMP8bnQtbPFraYmf++z/0pTVvz+q3mLPwdWkqv5obXjrBF0qHb9WfCG2+jZ0Zrdd
         9nVg==
X-Forwarded-Encrypted: i=1; AJvYcCX73bZqIMlpirYAmq3Omz3uQrhgCYwRMBD+/Wu8/BX/RwEqX2+5CA+t7FfuZJHhcN70SvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDsNn5BMu7NCadpiCjvlxyZRw/PrrrhE6j9MrZQovjclhQK7e
	XyHwxuTrrTIOhxmvrCpgJJ6Iqj8tzEV3FcbMHzBAE0FH+gRYYfcu
X-Gm-Gg: ASbGnctakRBsIyScpNKBxLHoz6fna42p3LL3hoyRcqGoC3FBTw8DqcWpvc9ptnnSGpJ
	YysVCrM4/KsGpW5oyBm3c1wJghWjZdUjPYtoIfEKykF2F53s07OkoWFjZEaAfrnc8vjKg8tG9Mv
	LbRjmajbNLuslamN9IaVGb2/fDt+wd8b/k9siOoKDt8URx3TCSWOOcerIXzYAdIXGZUJG6LtLN2
	pVjl607Bd4CwpCaAyGzdRGG3hRZz0JK+42ZrYz9MyvmjYg4YJDVqR3eevdVeQhyHHgranhO8HNG
	M4MdldGlpF8liOfNo/AImh6NEhOfvUGrU7md6GxoGyWLIE3kObp3DYOUTOvWp8x6eqIXbCfoI20
	97UFDV6Flud06MEfwmOSw
X-Google-Smtp-Source: AGHT+IFnm7NlQGway5vxN08lLN1ZySWeRLQHd0uhv391q4/0nmQ6FZdEwpiA1pIP4eORDCNd1rQlTQ==
X-Received: by 2002:a05:6000:2ae:b0:399:79a7:95ac with SMTP id ffacd0b85a97d-39ad17606e0mr6368094f8f.41.1743157798200;
        Fri, 28 Mar 2025 03:29:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8ff02f91sm22674765e9.29.2025.03.28.03.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Mar 2025 03:29:56 -0700 (PDT)
Message-ID: <dfb0a47e-075d-4288-8d18-03a60bb04737@gmail.com>
Date: Fri, 28 Mar 2025 10:29:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 00/20] t: drop Perl as a mandatory prerequisite
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/03/2025 10:36, Patrick Steinhardt wrote:
> 
> Changes in v3:
>    - Remove more useless indirections for sed(1).

Thanks for removing these, the range-diff below looks good

Best Wishes

Phillip

> Range-diff versus v2:
> 
>   1:  8c98b24fe4c =  1:  f2fe08ef0ff t: skip chain lint when PERL_PATH is unset
>   2:  f140153954c =  2:  9dd2edd0a1a t: refactor environment sanitization to not use Perl
>   3:  94b5591f666 =  3:  c77424e6907 t: adapt character translation helpers to not use Perl
>   4:  a5880fdb8ef =  4:  476d1b15932 t: adapt `test_copy_bytes()` to not use Perl
>   5:  3b64c99c061 =  5:  14badee2551 t: adapt `test_readlink()` to not use Perl
>   6:  a3536260e4c =  6:  9a88a46bd10 t: introduce PERL_TEST_HELPERS prerequisite
>   7:  98961b0e065 =  7:  e7413bf28ae t: adapt existing PERL prerequisites
>   8:  bbdd1fe6c7c =  8:  581a9bedd22 meson: stop requiring Perl when tests are enabled
>   9:  bda7e7922ce =  9:  cfe1797ae74 Makefile: stop requiring Perl when running tests
> 10:  d95d50c4b73 = 10:  99e678b83a6 t: refactor tests depending on Perl transliteration operator
> 11:  f5b30cc3f8f ! 11:  93a98d3e3cf t: refactor tests depending on Perl substitution operator
>      @@ t/t4029-diff-trailing-space.sh: test_expect_success PERL_TEST_HELPERS "$test_des
>        	git diff f > actual &&
>        	test_cmp exp actual &&
>       -	perl -i.bak -p -e "s/^\$/ /" exp &&
>      -+	sed "s/^\$/ /" <exp >exp.munged &&
>      ++	sed "s/^\$/ /" exp >exp.munged &&
>       +	mv exp.munged exp &&
>        	git config --bool diff.suppressBlankEmpty false &&
>        	git diff f > actual &&
>      @@ t/t4200-rerere.sh: test_expect_success 'activate rerere, old style (conflicting
>        	test_must_fail git merge first &&
>        
>       -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
>      -+	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
>      ++	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
>        	rr=.git/rr-cache/$sha1 &&
>        	grep "^=======\$" $rr/preimage &&
>        	! test -f $rr/postimage &&
>      @@ t/t4200-rerere.sh: test_expect_success 'rerere.enabled works, too' '
>        	test_must_fail git merge first &&
>        
>       -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
>      -+	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
>      ++	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
>        	rr=.git/rr-cache/$sha1 &&
>        	grep ^=======$ $rr/preimage
>        '
>      @@ t/t4200-rerere.sh: test_expect_success 'set up rr-cache' '
>        	git reset --hard &&
>        	test_must_fail git merge first &&
>       -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
>      -+	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
>      ++	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
>        	rr=.git/rr-cache/$sha1
>        '
>        
>      @@ t/t5303-pack-corruption-resilience.sh: test_expect_success '... and loose copy o
>        	git prune-packed &&
>        	chmod +w ${pack}.pack &&
>       -	perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
>      -+	sed "s/ base /abcdef/" <${pack}.pack >${pack}.pack.munged &&
>      ++	sed "s/ base /abcdef/" ${pack}.pack >${pack}.pack.munged &&
>       +	mv ${pack}.pack.munged ${pack}.pack &&
>        	test_must_fail git cat-file blob $blob_1 > /dev/null &&
>        	test_must_fail git cat-file blob $blob_2 > /dev/null &&
>      @@ t/t5303-pack-corruption-resilience.sh: test_expect_success '... and then a repac
>        	git prune-packed &&
>        	chmod +w ${pack}.pack &&
>       -	perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
>      -+	sed "s/ delta1 /abcdefgh/" <${pack}.pack >${pack}.pack.munged &&
>      ++	sed "s/ delta1 /abcdefgh/" ${pack}.pack >${pack}.pack.munged &&
>       +	mv ${pack}.pack.munged ${pack}.pack &&
>        	git cat-file blob $blob_1 > /dev/null &&
>        	test_must_fail git cat-file blob $blob_2 > /dev/null &&
>      @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
>        			# mark the commits which did not receive bitmaps as preferred,
>        			# and generate the bitmap again
>       -			perl -pe "s{^}{create refs/tags/include/$. }" <before |
>      -+			sed "s|\(.*\)|create refs/tags/include/\1 \1|" <before |
>      ++			sed "s|\(.*\)|create refs/tags/include/\1 \1|" before |
>        				git update-ref --stdin &&
>        			git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
>        
>      @@ t/t5534-push-signed.sh: test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent
>        	# different, then replay it on a fresh dst, checking that ff is not
>        	# deleted.
>       -	perl -pe "s/([^ ])bar/\$1baz/" push >push.tweak &&
>      -+	sed "s/\([^ ]\)bar/\1baz/" <push >push.tweak &&
>      ++	sed "s/\([^ ]\)bar/\1baz/" push >push.tweak &&
>        	prepare_dst &&
>        	git -C dst config receive.certnonceseed sekrit &&
>        	git -C dst config receive.advertisepushoptions 1 &&
>      @@ t/t6011-rev-list-with-bad-commit.sh: test_expect_success 'verify number of revis
>       +test_expect_success 'corrupt second commit object' '
>       +	for p in .git/objects/pack/*.pack
>       +	do
>      -+		sed "s/second commit/socond commit/" <"$p" >"$p.munged" &&
>      ++		sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
>       +		mv "$p.munged" "$p" ||
>       +		return 1
>       +	done &&
>      @@ t/t7416-submodule-dash-url.sh: test_expect_success 'fsck accepts protected dash'
>        
>        test_expect_success 'remove ./ protection from .gitmodules url' '
>       -	perl -i -pe "s{\./}{}" .gitmodules &&
>      -+	sed "s|\./||" <.gitmodules >.gitmodules.munged &&
>      ++	sed "s|\./||" .gitmodules >.gitmodules.munged &&
>       +	mv .gitmodules.munged .gitmodules &&
>        	git commit -am "drop protection"
>        '
>      @@ t/t8006-blame-textconv.sh: find_blame() {
>        #!/bin/sh
>        grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
>       -"$PERL_PATH" -p -e 's/^bin: /converted: /' "$1"
>      -+sed 's/^bin: /converted: /' <"$1"
>      ++sed 's/^bin: /converted: /' "$1"
>        EOF
>        chmod +x helper
>        
>      @@ t/t9137-git-svn-dcommit-clobber-series.sh: test_expect_success 'initialize repo'
>        	(cd tmp &&
>       -		perl -i.bak -p -e "s/^58$/5588/" file &&
>       -		perl -i.bak -p -e "s/^61$/6611/" file &&
>      -+		sed -e "s/^58$/5588/" -e "s/^61$/6611/" <file >file.munged &&
>      ++		sed -e "s/^58$/5588/" -e "s/^61$/6611/" file >file.munged &&
>       +		mv file.munged file &&
>        		poke file &&
>        		test x"$(sed -n -e 58p < file)" = x5588 &&
>      @@ t/t9137-git-svn-dcommit-clobber-series.sh: test_expect_success 'some unrelated c
>       -	perl -i.bak -p -e 's/^7\$/7777/' file &&
>       +	sed -e 's/^4\$/4444/' \
>       +	    -e 's/^7\$/7777/' \
>      -+		<file >file.munged &&
>      ++		file >file.munged &&
>       +	mv file.munged file &&
>        	test x\"\$(sed -n -e 4p < file)\" = x4444 &&
>        	test x\"\$(sed -n -e 7p < file)\" = x7777 &&
> 12:  e978d8ecfde ! 12:  17f862eaba3 t: refactor tests depending on Perl to print data
>      @@ t/t5300-pack-object.sh: test_expect_success 'pack-object <stdin parsing: --stdin
>        # e.g.: check_deltas stderr -gt 0
>        check_deltas() {
>       -	deltas=$(perl -lne '/delta (\d+)/ and print $1' "$1") &&
>      -+	deltas=$(sed -n 's/Total [0-9][0-9]* (delta \([0-9][0-9]*\)).*/\1/p' <"$1") &&
>      ++	deltas=$(sed -n 's/Total [0-9][0-9]* (delta \([0-9][0-9]*\)).*/\1/p' "$1") &&
>        	shift &&
>        	if ! test "$deltas" "$@"
>        	then
>      @@ t/t5326-multi-pack-bitmaps.sh: test_midx_bitmap_cases () {
>        
>       -			perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
>       -				<before | git update-ref --stdin &&
>      -+			sed "s|\(.*\)|create refs/tags/include/\1 \1|" <before |
>      ++			sed "s|\(.*\)|create refs/tags/include/\1 \1|" before |
>       +			git update-ref --stdin &&
>        
>        			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
>      @@ t/t5333-pseudo-merge-bitmaps.sh: test_pseudo_merges_reused () {
>       -	perl -lne '
>       -		print "create refs/tags/" . $. . " " . $1 if /([0-9a-f]+)/
>       -	' <in | git update-ref --stdin
>      -+	sed 's|\(.*\)|create refs/tags/\1 \1|' <in |
>      ++	sed 's|\(.*\)|create refs/tags/\1 \1|' in |
>       +	git update-ref --stdin
>        }
>        
>      @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge pattern with
>        			git rev-list HEAD~16.. >in &&
>       -
>       -			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
>      -+			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" <in |
>      ++			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
>        			git update-ref --stdin || return 1
>        		done &&
>        
>      @@ t/t8002-blame.sh: test_expect_success 'set up abbrev tests' '
>        		echo $sha1 | cut -c 1-$expect >expect &&
>        		git blame "$@" abbrev.t >actual &&
>       -		perl -lne "/[0-9a-f]+/ and print \$&" <actual >actual.sha &&
>      -+		sed -n "s/^[\^]\{0,1\}\([0-9a-f][0-9a-f]*\).*/\1/p" <actual >actual.sha &&
>      ++		sed -n "s/^[\^]\{0,1\}\([0-9a-f][0-9a-f]*\).*/\1/p" actual >actual.sha &&
>        		test_cmp expect actual.sha
>        	}
>        '
> 13:  905c25c9fb2 = 13:  7b03d096ccd t: refactor tests depending on Perl for textconv scripts
> 14:  1fe67bba30f = 14:  195c0bf2445 t/lib-gpg: refactor `sanitize_pgp()` to not depend on Perl
> 15:  9e572c3ba67 = 15:  e92d178b96b t/lib-t6000: refactor `name_from_description()` to not depend on Perl
> 16:  24abcffe96e ! 16:  0f2c9ad276b t/lib-httpd: refactor "one-time-perl" CGI script to not depend on Perl
>      @@ t/t5537-fetch-shallow.sh: test_expect_success PERL_TEST_HELPERS 'shallow fetches
>       -	       "$(git -C "$REPO" rev-parse HEAD^)" \
>       -	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
>       +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
>      -+	sed "$(printf "$(test_oid perl)" "$(git -C "$REPO" rev-parse HEAD)" "$(git -C "$REPO" rev-parse HEAD^)")" <"\$1"
>      ++	sed "$(printf "$(test_oid perl)" "$(git -C "$REPO" rev-parse HEAD)" "$(git -C "$REPO" rev-parse HEAD^)")" "\$1"
>       +	EOF
>        	test_must_fail env GIT_TEST_SIDEBAND_ALL=0 git -C client \
>       -		fetch --depth=1 "$HTTPD_URL/one_time_perl/repo" \
>      @@ t/t5616-partial-clone.sh: intersperse () {
>       +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF
>       +	if grep packfile "\$1" >/dev/null
>       +	then
>      -+		sed '/packfile/q' <"\$1" &&
>      ++		sed '/packfile/q' "\$1" &&
>       +		# The protocol requires that the packfile be sent in sideband
>       +		# 1, hence the extra \001 byte at the beginning.
>       +		printf "%04x\001" \$((\$(wc -c <"$PWD/one-time-pack") + 5)) &&
>      @@ t/t5702-protocol-v2.sh: test_expect_success PERL_TEST_HELPERS 'when server sends
>       -	printf "\$ready = 1 if /ready/; \$ready && s/0001/0000/" \
>       -		>"$HTTPD_ROOT_PATH/one-time-perl" &&
>       +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
>      -+	sed "/ready/{n;s/0001/0000/;}" <"$1"
>      ++	sed "/ready/{n;s/0001/0000/;}" "$1"
>       +	EOF
>        
>        	test_must_fail git -C http_child -c protocol.version=2 \
>      @@ t/t5702-protocol-v2.sh: test_expect_success PERL_TEST_HELPERS 'when server does
>       -	printf "\$ack = 1 if /acknowledgments/; \$ack && s/0000/0001/" \
>       -		>"$HTTPD_ROOT_PATH/one-time-perl" &&
>       +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
>      -+	sed "/acknowledgments/,//{s/0000/0001/;}" <"$1"
>      ++	sed "/acknowledgments/,//{s/0000/0001/;}" "$1"
>       +	EOF
>        
>        	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
>      @@ t/t5702-protocol-v2.sh: test_expect_success 'http:// --negotiate-only' '
>       -	echo "s/ wait-for-done/ xxxx-xxx-xxxx/" \
>       -		>"$HTTPD_ROOT_PATH/one-time-perl" &&
>       +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
>      -+	sed "s/ wait-for-done/ xxxx-xxx-xxxx/" <"$1"
>      ++	sed "s/ wait-for-done/ xxxx-xxx-xxxx/" "$1"
>       +	EOF
>        
>        	test_must_fail git -c protocol.version=2 -C client fetch \
>      @@ t/t5703-upload-pack-ref-in-want.sh: inconsistency () {
>        	oid2=$(git -C "$REPO" rev-parse $2) &&
>       -	echo "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-perl"
>       +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF
>      -+	sed "s/$oid1/$oid2/" <"\$1"
>      ++	sed "s/$oid1/$oid2/" "\$1"
>       +	EOF
>        }
>        
>      @@ t/t5703-upload-pack-ref-in-want.sh: test_expect_success 'server loses a ref - re
>        	cp -r "$LOCAL_PRISTINE" local &&
>       -	echo "s/main/rain/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
>       +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
>      -+	sed "s/main/rain/" <"$1"
>      ++	sed "s/main/rain/" "$1"
>       +	EOF
>        	test_must_fail git -C local fetch 2>err &&
>        
> 17:  ce5adbd4818 = 17:  9857b461ed6 t0021: refactor `generate_random_characters()` to not depend on Perl
> 18:  e183c397da9 = 18:  7924b5bd9bf t0210: refactor trace2 scrubbing to not use Perl
> 19:  156bdc4d62d = 19:  5d6996a1412 t5316: refactor `max_chain()` to not depend on Perl
> 20:  3b181d0a203 = 20:  0c3afb70128 t5703: refactor test to not depend on Perl
> 
> ---
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> change-id: 20250317-b4-pks-t-perlless-138cf94696b8
> 
> 
