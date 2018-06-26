Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12C31F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFZVfM (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:35:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36993 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754128AbeFZVe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:34:58 -0400
Received: by mail-wr0-f194.google.com with SMTP id k6-v6so18639640wrp.4
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mAWE/ANF5kV+FVEAXPkVrB4nGNcaYNf7d4bBJ2XXcYc=;
        b=kCmTt0X48puggLofDMOVZgkVPDLoF79+gcNaMf3gPIVw77PURmOZSmZT1vOewbsnhs
         sRyDLolZ4hdrsAX/zXuUwrFkb91XhC51QurthX9KvSZd7l9Qk/XAcUlqRPppdE3iL/q5
         dbPoxnMiwfgeh1Ra/80WOySqpuOKqoQeUgVyj6SqBGZD84+vGLuJde+qLwxosJEvmpdd
         KgVdgBqFFONDDDmQRm+rOIO5q2MtOvffB695+GmLh4rhHD2wgnppAbwZqL7uIu0Ax0dG
         zx6eKS79x1BGIqu7wBlIOoMxVycJFEdZxL53ET7Z9bywldGiHcEfsrN4d3IzOMkW8g7O
         XaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mAWE/ANF5kV+FVEAXPkVrB4nGNcaYNf7d4bBJ2XXcYc=;
        b=CUTNqcrwORsPk/TlViHXtijPM6ycKrpIKk2v74Wlr99Eul8sZ9fcH0qOz21rWAvGAs
         xTsbRHTVivP5j4lMk6gjNuBis5ZqCq89sPMZQ3tx0PL9dH+iEQrOomO4L7Kl+UZVz4AH
         pqFNZibgiYxr7hU9eobxj542Jqe+EFOClB7GC54Qb31j4xRAS28KGNbnQ+M84fVyYbkR
         T8E1Ftv1e/PreFfYZtmwCcSRW3E8Euwe+3/qUOavUZbgV5dT+xrWCdsZIackPB4XJgP9
         +GZt/UmTp1WNGpJqe/mWtvDJPyt9v25DIE+U+x7OUtXeA5JM/kgQIZWIhtFf/cya78Et
         m3Qg==
X-Gm-Message-State: APt69E3tdvUb3v3DkCHhBiuLhWnAQOBOr1Z5y0JttyeGEHIBc/nCPAkY
        oTCpsXc2quEph+FFIShXE+TiGmiU
X-Google-Smtp-Source: AAOMgpe6aBjg/2QY+VvXjXOtPsas88bKWbKNi+ZE+b2CvY1zYagQkSorMMnyucy6e1rGJLcaTUiIFg==
X-Received: by 2002:adf:9b86:: with SMTP id d6-v6mr2944915wrc.240.1530048897282;
        Tue, 26 Jun 2018 14:34:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s191-v6sm5080246wmd.27.2018.06.26.14.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:34:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 3/8] upload-pack: test negotiation with changing repository
References: <20180625185332.164142-1-bmwill@google.com>
        <20180626205438.110764-1-bmwill@google.com>
        <20180626205438.110764-4-bmwill@google.com>
Date:   Tue, 26 Jun 2018 14:34:56 -0700
In-Reply-To: <20180626205438.110764-4-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Jun 2018 13:54:33 -0700")
Message-ID: <xmqqo9fxi64f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> diff --git a/t/lib-httpd/one-time-sed.sh b/t/lib-httpd/one-time-sed.sh
> new file mode 100644
> index 000000000..8a9a5aca0
> --- /dev/null
> +++ b/t/lib-httpd/one-time-sed.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +# If "one-time-sed" exists in $HTTPD_ROOT_PATH, run sed on the HTTP response,
> +# using the contents of "one-time-sed" as the sed command to be run. If the
> +# response was modified as a result, delete "one-time-sed" so that subsequent
> +# HTTP responses are no longer modified.

;-) clever.

> +# 
> +# This can be used to simulate the effects of the repository changing in
> +# between HTTP request-response pairs.
> +if [ -e one-time-sed ]; then "$GIT_EXEC_PATH/git-http-backend" >out

Style (cf. Documentation/CodingGuidelines).

> +
> +	sed "$(cat one-time-sed)" <out >out_modified
> +
> +	if diff out out_modified >/dev/null; then
> +		cat out
> +	else
> +		cat out_modified
> +		rm one-time-sed
> +	fi
> +else
> +	"$GIT_EXEC_PATH/git-http-backend"
> +fi

OK.  I was worried if the removal-after-use was about _this_ script
(in which case it is a bad hygiene), but this is not a one-time
script, but merely the mechanism to use the one-time sed script.

Perhaps rename this to t/lib-httpd/apply-one-time-sed.sh or something
to avoid confusion?

> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index 0ef182970..a4fe0e7e4 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -150,4 +150,72 @@ test_expect_success 'want-ref with ref we already have commit for' '
>  	check_output
>  '
>  
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +start_httpd
> +
> +REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
> +LOCAL_PRISTINE="$(pwd)/local_pristine"
> +
> +test_expect_success 'setup repos for change-while-negotiating test' '
> +	(
> +		git init "$REPO" &&
> +		cd "$REPO" &&
> +		>.git/git-daemon-export-ok &&
> +		test_commit m1 &&
> +		git tag -d m1 &&
> +
> +		# Local repo with many commits (so that negotiation will take
> +		# more than 1 request/response pair)
> +		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
> +		cd "$LOCAL_PRISTINE" &&
> +		git checkout -b side &&
> +		for i in $(seq 1 33); do test_commit s$i; done &&
> +
> +		# Add novel commits to upstream
> +		git checkout master &&
> +		cd "$REPO" &&
> +		test_commit m2 &&
> +		test_commit m3 &&
> +		git tag -d m2 m3
> +	) &&
> +	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo" &&
> +	git -C "$LOCAL_PRISTINE" config protocol.version 2
> +'
> +
> +inconsistency() {

Style. "inconsistency () {"

> +	# Simulate that the server initially reports $2 as the ref
> +	# corresponding to $1, and after that, $1 as the ref corresponding to
> +	# $1. This corresponds to the real-life situation where the server's
> +	# repository appears to change during negotiation, for example, when
> +	# different servers in a load-balancing arrangement serve (stateless)
> +	# RPCs during a single negotiation.
> +	printf "s/%s/%s/" \
> +	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
> +	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
> +	       >"$HTTPD_ROOT_PATH/one-time-sed"
> +}
> +
> +test_expect_success 'server is initially ahead - no ref in want' '
> +	git -C "$REPO" config uploadpack.allowRefInWant false &&
> +	rm -rf local &&
> +	cp -r "$LOCAL_PRISTINE" local &&
> +	inconsistency master 1234567890123456789012345678901234567890 &&
> +	test_must_fail git -C local fetch 2>err &&
> +	grep "ERR upload-pack: not our ref" err
> +'
> +
> +test_expect_success 'server is initially behind - no ref in want' '
> +	git -C "$REPO" config uploadpack.allowRefInWant false &&
> +	rm -rf local &&
> +	cp -r "$LOCAL_PRISTINE" local &&
> +	inconsistency master "master^" &&
> +	git -C local fetch &&
> +
> +	git -C "$REPO" rev-parse --verify "master^" >expected &&
> +	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
> +	test_cmp expected actual
> +'
> +
> +stop_httpd
> +
>  test_done
