Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF430C54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiISQdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiISQdm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:33:42 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D7031366
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:33:41 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s18so17995251qtx.6
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=DTqjBhhqRAnGO+wk7ysr9C3Zb1S1/+rtNqwQqECx7Rw=;
        b=eOTKytyeqdsaqY8Y47XzBMChAwiBUG2wArQDlFz8WvdCk++mNW4A7lR48tNK1RNIO7
         ZvdP+koMw8ebQLLAZ7k70n2DXsBgZDifE+RZWsNIJF11ru+ncvRq04U02TXBK6McvLEQ
         q5T0dqxiiIvF7B2yeSrg5gsLT6XbfGYBLw/79cvPiKvoVCqsaaXZd99rnp/q7ytJyfFn
         rH1NkddvOGkRksW7dUWWY/eePCWvofQlztKce7ehxR4+IrMBFrxYunNVih/nFIg0IG4B
         cb2n41uZyFsDnHecelfOBDqWltibh/tJGhMbq4v1K3HyOSJYqR4nMTxAbcHKlC3JKZL5
         ie7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=DTqjBhhqRAnGO+wk7ysr9C3Zb1S1/+rtNqwQqECx7Rw=;
        b=cE2FbvJq931mrF9xgyikThj8gbMBaoqI20BkDi2bsN52JJ2RcIA19qlRJO6UGeV4Gr
         2WexrzY6YtG6U7y9heJuNPfDCiAU5Rd++O01aRkAnTIpYaMPBlSqn1qJ429Z5QtW8Njt
         o7WOmdhZ2KVEPFb+NQ1BZ363uC1FwgHko9vvPJmZt535N7QA1wVlylSriklqcKKH5xo9
         i1UuPdpdgjoJRP7qmjb54RQgmCWd14vKU1aImkfk1LxXgpYdHxYdafp9z3GNjKcrDMAo
         Fmwd5MpPAzVAC1AoCXEf+IpD4GalM9WMa/LbIX0iep6aXriW/IdAjEOtsIxI0IxLxNet
         8odw==
X-Gm-Message-State: ACrzQf0rTIw6o99jsb2l6esXf8IDXEmyA/g/rX/zP4F7afHfNGVYkPyV
        U5P7Oa9zbRtoJiloLbItSuhv
X-Google-Smtp-Source: AMsMyM7A+F2oIlCYb2hhHUcQt3xj9CIrOT/qKPI6E+KmLv6Ye9QJNhSFHDOkFr1Oksayo90SKyOWUQ==
X-Received: by 2002:a05:622a:24e:b0:35b:b34b:2aa with SMTP id c14-20020a05622a024e00b0035bb34b02aamr15403453qtx.411.1663605220186;
        Mon, 19 Sep 2022 09:33:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:fd97:43ff:6c00:2cf8? ([2600:1700:e72:80a0:fd97:43ff:6c00:2cf8])
        by smtp.gmail.com with ESMTPSA id bm29-20020a05620a199d00b006bb11f9a859sm13716802qkb.122.2022.09.19.09.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:33:39 -0700 (PDT)
Message-ID: <69cbe403-48a2-ac5c-5743-5b7cae5ae523@github.com>
Date:   Mon, 19 Sep 2022 12:33:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 5/8] credential: add WWW-Authenticate header to cred
 requests
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <936545004b8b46cbe24d8069cfd95ae5b5f98593.1663097156.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <936545004b8b46cbe24d8069cfd95ae5b5f98593.1663097156.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>

> In this case we send multiple `wwwauth[n]` properties where `n` is a
> zero-indexed number, reflecting the order the WWW-Authenticate headers
> appeared in the HTTP response.
> @@ -151,6 +151,15 @@ Git understands the following attributes:
>  	were read (e.g., `url=https://example.com` would behave as if
>  	`protocol=https` and `host=example.com` had been provided). This
>  	can help callers avoid parsing URLs themselves.
> +
> +`wwwauth[n]`::
> +
> +	When an HTTP response is received that includes one or more
> +	'WWW-Authenticate' authentication headers, these can be passed to Git
> +	(and subsequent credential helpers) with these attributes.
> +	Each 'WWW-Authenticate' header value should be passed as a separate
> +	attribute 'wwwauth[n]' where 'n' is the zero-indexed order the headers
> +	appear in the HTTP response.
>  +
>  Note that specifying a protocol is mandatory and if the URL
>  doesn't specify a hostname (e.g., "cert:///path/to/file") the

This "+" means that this paragraph should be connected to the previous
one, so it seems that you've inserted your new value in the middle of
the `url` key. You'll want to move yours to be after those two connected
paragraphs. Your diff hunk should look like this:

--- >8 ---

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index f18673017f..127ae29be3 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -160,6 +160,15 @@ empty string.
 Components which are missing from the URL (e.g., there is no
 username in the example above) will be left unset.
 
+`wwwauth[n]`::
+
+	When an HTTP response is received that includes one or more
+	'WWW-Authenticate' authentication headers, these can be passed to Git
+	(and subsequent credential helpers) with these attributes.
+	Each 'WWW-Authenticate' header value should be passed as a separate
+	attribute 'wwwauth[n]' where 'n' is the zero-indexed order the headers
+	appear in the HTTP response.
+
 GIT
 ---
 Part of the linkgit:git[1] suite


--- >8 ---

> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 497b9b9d927..fe118d76f98 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -235,6 +235,19 @@ SSLEngine On
>  	Require valid-user
>  </LocationMatch>
>  
> +# Advertise two additional auth methods above "Basic".
> +# Neither of them actually work but serve test cases showing these
> +# additional auth headers are consumed correctly.
> +<Location /auth-wwwauth/>
> +	AuthType Basic
> +	AuthName "git-auth"
> +	AuthUserFile passwd
> +	Require valid-user
> +	SetEnvIf Authorization "^\S+" authz
> +	Header always add WWW-Authenticate "Bearer authority=https://login.example.com" env=!authz
> +	Header always add WWW-Authenticate "FooAuth foo=bar baz=1" env=!authz
> +</Location>
> +

This is cool that you've figured out how to make our Apache tests
add these headers! Maybe we won't need that extra test helper like
I thought (unless we want to confirm the second request sends the
right information).

> +test_expect_success 'http auth sends www-auth headers to credential helper' '
> +	write_script git-credential-tee <<-\EOF &&
> +		cmd=$1
> +		teefile=credential-$cmd
> +		if [ -f "$teefile" ]; then

I think we prefer using "test" over the braces (and linebreak
before then) like this:

		if test -n "$teefile"
		then

> +			rm $teefile
> +		fi

Alternatively, you could always run "rm -f $teefile" for
simplicity.

> +		(
> +			while read line;
> +			do
> +				if [ -z "$line" ]; then
> +					exit 0
> +				fi
> +				echo "$line" >> $teefile
> +				echo $line
> +			done
> +		) | git credential-store $cmd

Since I'm not sure, I'll ask the question: do we need the sub-shell
here, or could we pipe directly off of the "done"? Like this:

		while read line;
		do
			if [ -z "$line" ]; then
				exit 0
			fi
			echo "$line" >> $teefile
			echo $line
		done | git credential-store $cmd

> +	EOF


> +	cat >expected-get <<-EOF &&
> +	protocol=http
> +	host=127.0.0.1:5551
> +	wwwauth[0]=Bearer authority=https://login.example.com
> +	wwwauth[1]=FooAuth foo=bar baz=1
> +	wwwauth[2]=Basic realm="git-auth"
> +	EOF
> +
> +	cat >expected-store <<-EOF &&
> +	protocol=http
> +	host=127.0.0.1:5551
> +	username=user@host
> +	password=pass@host
> +	EOF
> +
> +	rm -f .git-credentials &&
> +	test_config credential.helper tee &&
> +	set_askpass user@host pass@host &&
> +	(
> +		PATH="$PWD:$PATH" &&
> +		git ls-remote "$HTTPD_URL/auth-wwwauth/smart/repo.git"
> +	) &&
> +	expect_askpass both user@host &&
> +	test_cmp expected-get credential-get &&
> +	test_cmp expected-store credential-store

Elegant check for both calls.

Thanks,
-Stolee
