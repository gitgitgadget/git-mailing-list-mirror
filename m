Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DECC433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4936720759
	for <git@archiver.kernel.org>; Fri, 15 May 2020 13:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StgrDCgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEONQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEONQu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 09:16:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FE4C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 06:16:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 50so3473915wrc.11
        for <git@vger.kernel.org>; Fri, 15 May 2020 06:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3f8c44DzbvZ74ItFb7MkRs5EMnhPCQmPCRkWtfWZ+5g=;
        b=StgrDCgXU+lQkw/JD04u5ubBIGenmTpB/HU2RGXGJNpuf4Mc6yagxf6T7VZFroUWsA
         8wr5HTHNArXrpTEXB67PrxuV0oLm8/8z9XBTK9XapifncS1D249cULFwUFY3Fhg3Qvvg
         gu0guggbghfMArLDjBU5xy3Q69shWti2ZUJ73mM1Hcb4Aoca6AS9JoFbOu5YECU5Ht1i
         J6cKhDvhcM4iQTZbuLO8siAra2ieTTNGkqC44XZ2TcSvj7tJF3aEwUGITNOnJul506u0
         mhlvDcQ1eaccvPYCXDdWuvb5Ak00eXHi64CgQZPEwXxJfc0VXZVrEvIrIx1yKKMan5PS
         f7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3f8c44DzbvZ74ItFb7MkRs5EMnhPCQmPCRkWtfWZ+5g=;
        b=ek5deeoYKlQ7OCJWvn+ZXsX+NhECgzVhSU9gy+32UL7n/ctBL2PMuiCsxWR0lw2k6Q
         puumOsALzOlENGPN0r74VTRDQULmh6o9e/7Njl4f1OJPw80wJ4AbPGUmh4a6kB0/PtVI
         SW6iBkIbj16Pw4q3z2WLmb6EuVC8WPD41yEoMLjBJQsAlu7JRei6umRBhs9OrJ1ftoEz
         fa37WGhBQpEtKNS1luTCfdvP5ZFilDnw7OI3NjuQgb8dibaHH74MTOVZ5ts9pzhgoY0G
         n5nhgdL4Xg+kgfR8iBuNQhsLpXnFfExgedvApXJGySi4tlZGrmcjDhUhucs5h2K0o4z9
         fKdg==
X-Gm-Message-State: AOAM531Gmuiq/NtrUzqmKpu7I9WrHqEs6JF+vDfNhwRnxj3qxX8/lwPH
        R4Z5yS4obosKlCNnMYdDrZU5ta8s
X-Google-Smtp-Source: ABdhPJzO2WjgejhDaWbQDTi4oPNcMmsNyTRpxCxSJa0pXQuz9O+Zy7J306czXHR4q/tC3DKt33xbgg==
X-Received: by 2002:a05:6000:8:: with SMTP id h8mr4466067wrx.372.1589548607896;
        Fri, 15 May 2020 06:16:47 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-314-129.w86-199.abo.wanadoo.fr. [86.199.201.129])
        by smtp.gmail.com with ESMTPSA id o205sm3562427wmo.32.2020.05.15.06.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 06:16:47 -0700 (PDT)
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
 <cover.1586538752.git.congdanhqx@gmail.com>
 <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <5b373748-d986-1aec-670f-7ac1502e7052@gmail.com>
Date:   Fri, 15 May 2020 15:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 10/04/2020 à 19:18, Đoàn Trần Công Danh a écrit :
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When a test fails, it is nice to see where the corresponding code lives
> in the worktree. Sadly, it seems that only Bash allows us to infer this
> information. Let's do it when we detect that we're running in a Bash.
> 
> This will come in handy in the next commit, where we teach the GitHub
> Actions workflow to annotate failed test runs with this information.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  t/test-lib.sh | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0ea1e5a05e..40a00983f7 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -657,6 +657,18 @@ die () {
>  	fi
>  }
>  
> +file_lineno () {
> +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> +	local i
> +	for i in ${!BASH_SOURCE[*]}
> +	do
> +		case $i,"${BASH_SOURCE[$i]##*/}" in
> +		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;;
> +		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: ${1+$1: }"; return;;
> +		esac
> +	done
> +}
> +
>  GIT_EXIT_OK=
>  trap 'die' EXIT
>  # Disable '-x' tracing, because with some shells, notably dash, it
> @@ -702,7 +714,7 @@ test_failure_ () {
>  		write_junit_xml_testcase "$1" "      $junit_insert"
>  	fi
>  	test_failure=$(($test_failure + 1))
> -	say_color error "not ok $test_count - $1"
> +	say_color error "$(file_lineno error)not ok $test_count - $1"
>  	shift
>  	printf '%s\n' "$*" | sed -e 's/^/#	/'
>  	test "$immediate" = "" || { finalize_junit_xml; GIT_EXIT_OK=t; exit 1; }
> 

This violates the TAP specification, it seems.  Without this patch, when
a test fails, `prove' shows clearly which test(s) broke, and how many
failed:

> Test Summary Report
> -------------------
> t0001-init.sh (Wstat: 256 Tests: 45 Failed: 1)
>   Failed test:  2
>   Non-zero exit status: 1

With this patch, it shows this:

> Test Summary Report
> -------------------
> t0001-init.sh (Wstat: 256 Tests: 44 Failed: 0)
>   Non-zero exit status: 1
>   Parse errors: Tests out of sequence.  Found (3) but expected (2)
>                 Tests out of sequence.  Found (4) but expected (3)
>                 Tests out of sequence.  Found (5) but expected (4)
>                 Tests out of sequence.  Found (6) but expected (5)
>                 Tests out of sequence.  Found (7) but expected (6)
> Displayed the first 5 of 44 TAP syntax errors.
> Re-run prove with the -p option to see them all.

Not nice to see clearly which tests failed: we do not see all failed
tests (what if a test failed after the 7th test?), and the counter
displays 0.

This happens on my machine, as well as on github.

Cheers,
Alban

