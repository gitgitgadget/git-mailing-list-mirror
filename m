Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A19C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 22:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjBOWPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBOWPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 17:15:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479E5588
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:15:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso3812729pjn.5
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1FqVGIWgWxUgHYPtCT0qEaE+x8RHBR4GsgdWs6uWxw=;
        b=krAr9rvBG/O0r/0+x4FvdvGze7bowP11Z5EN7SHGOmTyDtW4n0Bu/WbZyeTthE6v3S
         8pL2+PBBBtaHaywYFzItEtq+7QJ9k3DQAshv0WrWT5kwI01ZHrzCerTDV6cDxSOieD/w
         kjVsAwVs6bgY9JTrZJKI9htgrZVcwpUwVvFFrQ2zUy2L2jKr6x3EkX6RFuUEqSmN4P6v
         9wj2WMM9RM7Ir+52VLUm3OoSuMTzetr2llJF3Rk1OLBG+kXnpuDdg49ZJ3mLzGL5AIxl
         SiYouefDzpRg+X88wXLzAaWXKsvQwwN001EiEeinIAqy0gPoUKIj2kqbwTzNKNfaY9Nq
         BxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G1FqVGIWgWxUgHYPtCT0qEaE+x8RHBR4GsgdWs6uWxw=;
        b=aPu/08zynM478qbhuvPS2mer99DVGsTotchASWYHPbIfRhrvSWRJC2nmOK7u3/tx/f
         l1OVOMIPFCqDcM+GTtFA7adAu/OTINfTTZWXY9kSHDIHqdHY3xVkRvipSqv8/LC590uj
         NB0tHDsDKmHfIIEXSgk8s1DTHEme6Icfhse0Bcm06S4fW321WTr2hNZnmNUNnujwsBMk
         NZJBGlF9T/r9FqWCUYFT1/u1+xntdpf+W4u9ZN2zD9LaXv5XTzvl43bfoR38C7Ng7JLp
         up9t7FOf1Iz3tzuS9cZbouJK5JyM4lMgRyD+YSqnqz2Nw3pCge2ZI0gl9h2C1tbPhEdh
         PtEw==
X-Gm-Message-State: AO0yUKX6zW6pfrufiDXdPYIxNlFs+Ojxgm7a+gYNnY6b9qcxUxfaiZXX
        OuW2jTS4vdYibfwjG2o97+c=
X-Google-Smtp-Source: AK7set8uZdTpBil/tuoyy9Imh0oH/2EVyXYTmzF9d9+TNLHPumt//1nCO2obNUPyxdzYl/fJ0uUN4g==
X-Received: by 2002:a17:903:124f:b0:194:d9ca:7c56 with SMTP id u15-20020a170903124f00b00194d9ca7c56mr4596531plh.58.1676499308256;
        Wed, 15 Feb 2023 14:15:08 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902710400b00194c90ca320sm12568137pll.204.2023.02.15.14.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:15:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v9 1/3] t5563: add tests for basic and anoymous HTTP access
References: <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
        <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
        <05449ec892b1205c1e1c90d15facd812b5cbbe3c.1676496846.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 14:15:07 -0800
In-Reply-To: <05449ec892b1205c1e1c90d15facd812b5cbbe3c.1676496846.git.gitgitgadget@gmail.com>
        (Matthew John Cheetham via GitGitGadget's message of "Wed, 15 Feb 2023
        21:34:04 +0000")
Message-ID: <xmqqy1oywp78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +if test -n "$HTTP_AUTHORIZATION" && \
> +	grep -qsi "^${HTTP_AUTHORIZATION}\$" "$VALID_CREDS_FILE"

Do we require a regexp match (and worry about metacharacters in
HTTP_AUTHORIZATION variable), or would we want to use "grep -F -x"
here to force match with the entire line?

> +then
> +	# Note that although git-http-backend returns a status line, it
> +	# does so using a CGI 'Status' header. Because this script is an
> +	# No Parsed Headers (NPH) script, we must return a real HTTP
> +	# status line.
> +	# This is only a test script, so we don't bother to check for
> +	# the actual status from git-http-backend and always return 200.
> +	echo 'HTTP/1.1 200 OK'
> +	exec "$GIT_EXEC_PATH"/git-http-backend
> +fi

OK.  That's the successful auth case.  Otherwise ...

> +echo 'HTTP/1.1 401 Authorization Required'
> +if test -f "$CHALLENGE_FILE"
> +then
> +	cat "$CHALLENGE_FILE"
> +fi
> +echo

OK.  We'll just give a challenge.

> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
> new file mode 100755
> index 00000000000..e0682039de7
> --- /dev/null
> +++ b/t/t5563-simple-http-auth.sh
> @@ -0,0 +1,81 @@
> +#!/bin/sh
> +
> +test_description='test http auth header and credential helper interop'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +
> +start_httpd
> +
> +test_expect_success 'setup_credential_helper' '
> +	mkdir "$TRASH_DIRECTORY/bin" &&
> +	PATH=$PATH:"$TRASH_DIRECTORY/bin" &&
> +	export PATH &&
> +
> +	CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
> +	write_script "$CREDENTIAL_HELPER" <<-\EOF
> +	cmd=$1
> +	teefile=$cmd-query.cred
> +	catfile=$cmd-reply.cred
> +	sed -n -e "/^$/q" -e "p" >>$teefile
> +	if test "$cmd" = "get"
> +	then
> +		cat $catfile
> +	fi
> +	EOF
> +'
> +
> +set_credential_reply() {

Style. Have SP before "()" as well as after.

> +	cat >"$TRASH_DIRECTORY/$1-reply.cred"
> +}
> +
> +expect_credential_query() {

Style. Have SP before "()" as well as after.

> +	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
> +	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
> +		 "$TRASH_DIRECTORY/$1-query.cred"
> +}
> +
> +per_test_cleanup () {
> +	rm -f *.cred &&
> +	rm -f "$HTTPD_ROOT_PATH"/custom-auth.*
> +}
> +
> +test_expect_success 'setup repository' '
> +	test_commit foo &&
> +	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
> +'

OK.

> +test_expect_success 'access using basic auth' '
> +	test_when_finished "per_test_cleanup" &&
> +
> +	set_credential_reply get <<-EOF &&
> +	username=alice
> +	password=secret-passwd
> +	EOF
> +
> +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
> +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
> +	EOF

Perhaps we want to note that this matches the "alice:secret-passwd"
we prepared earlier?

> +	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
> +	WWW-Authenticate: Basic realm="example.com"
> +	EOF

OK.

> +	test_config_global credential.helper test-helper &&
> +	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
> +
> +	expect_credential_query get <<-EOF &&
> +	protocol=http
> +	host=$HTTPD_DEST
> +	EOF
> +
> +	expect_credential_query store <<-EOF
> +	protocol=http
> +	host=$HTTPD_DEST
> +	username=alice
> +	password=secret-passwd
> +	EOF
> +'

OK.

> +test_done
