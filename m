Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDFF1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934529AbeF0SJP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:09:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37572 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932159AbeF0SJN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:09:13 -0400
Received: by mail-pf0-f194.google.com with SMTP id y5-v6so1338339pfn.4
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=115usMVwKBea847hQoIQDzvCCGCwTMjGZgMHQEc+1J8=;
        b=btlnsdNZ+qyfAPbs8V8rmv4PQTtSbo2hLVNXHi7wIJ/OiGuL61E1/4lyHR9jvMl1lr
         aZ2/z5qrFy6BwdjHDHaAzLljtURvKPhRRa+ogjVRt5N7mNXleIUi6JBuzLsyw9vG31WL
         aBFAibMbAac+K9LTxAiGXaAbj4MjSl50bMfldDqeNJxJlH3qIw3w1sJN8vBmQaahCXmn
         tHapQ43fBS8hxs8aec2mJSyXze/A9mU2a8DXsB0tkwEw5ee+4NimS2HuO6xQkZjtW8xy
         kx38dfseBqQQc9ur05nJkN0JD1SH7i5VmBTKB+kkskQNTNNMeGVQB/DcT8ChuaTv4Qlf
         7kpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=115usMVwKBea847hQoIQDzvCCGCwTMjGZgMHQEc+1J8=;
        b=YBGgzmzq1rK1FBLodikdfHH2J9o4mj8zMJacnIATrXW2sKIpMbutN4NZ5dFPPTCQ5v
         QD1LzKgqtHwOlxWP/LS7btjiNRDvH7GEB/4nx15I6juzKVWnurNo414X1L862If3YGwZ
         z2674ozEuaNt9/d/aCVyE9dH4G9iRAWznv7n35t7e3CU/rL2MVSO3z7aIExVjrbAIqvD
         oY4i59f5utpsMx2ixZ25UyjTh4jQN7SQu+UuYttojd0TFrAHIw7u17wyihKdb7DGnEsf
         Y1RgGadAXyO6PUwY1LW/F+0LGCT4eWkor/HrHssFHggxFCtmqVVKQ5covsWCfvgxV+og
         gaIQ==
X-Gm-Message-State: APt69E1/0wEFLw+tyP9BVTj6o0NlptWR9tTF26+HiHlmMbUAUahYbCA0
        35xaskLVsWo27Pgl3E38NOVmNg==
X-Google-Smtp-Source: AAOMgpeEK+L9K5/15EWUmRy8hbN6e5mOTUjJh45ghuQ5I2Mbr/tTtWZyfaxtk+MXIg3uUO0yW0lUDA==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr6164008pgt.164.1530122953070;
        Wed, 27 Jun 2018 11:09:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id y22-v6sm15041617pfi.166.2018.06.27.11.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:09:11 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:09:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 3/8] upload-pack: test negotiation with changing
 repository
Message-ID: <20180627180910.GH19910@google.com>
References: <20180625185332.164142-1-bmwill@google.com>
 <20180626205438.110764-1-bmwill@google.com>
 <20180626205438.110764-4-bmwill@google.com>
 <xmqqo9fxi64f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9fxi64f.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/26, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > diff --git a/t/lib-httpd/one-time-sed.sh b/t/lib-httpd/one-time-sed.sh
> > new file mode 100644
> > index 000000000..8a9a5aca0
> > --- /dev/null
> > +++ b/t/lib-httpd/one-time-sed.sh
> > @@ -0,0 +1,22 @@
> > +#!/bin/sh
> > +
> > +# If "one-time-sed" exists in $HTTPD_ROOT_PATH, run sed on the HTTP response,
> > +# using the contents of "one-time-sed" as the sed command to be run. If the
> > +# response was modified as a result, delete "one-time-sed" so that subsequent
> > +# HTTP responses are no longer modified.
> 
> ;-) clever.
> 
> > +# 
> > +# This can be used to simulate the effects of the repository changing in
> > +# between HTTP request-response pairs.
> > +if [ -e one-time-sed ]; then "$GIT_EXEC_PATH/git-http-backend" >out
> 
> Style (cf. Documentation/CodingGuidelines).
> 
> > +
> > +	sed "$(cat one-time-sed)" <out >out_modified
> > +
> > +	if diff out out_modified >/dev/null; then
> > +		cat out
> > +	else
> > +		cat out_modified
> > +		rm one-time-sed
> > +	fi
> > +else
> > +	"$GIT_EXEC_PATH/git-http-backend"
> > +fi
> 
> OK.  I was worried if the removal-after-use was about _this_ script
> (in which case it is a bad hygiene), but this is not a one-time
> script, but merely the mechanism to use the one-time sed script.
> 
> Perhaps rename this to t/lib-httpd/apply-one-time-sed.sh or something
> to avoid confusion?

Sure, I'll go ahead and rename it to that.

> 
> > diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> > index 0ef182970..a4fe0e7e4 100755
> > --- a/t/t5703-upload-pack-ref-in-want.sh
> > +++ b/t/t5703-upload-pack-ref-in-want.sh
> > @@ -150,4 +150,72 @@ test_expect_success 'want-ref with ref we already have commit for' '
> >  	check_output
> >  '
> >  
> > +. "$TEST_DIRECTORY"/lib-httpd.sh
> > +start_httpd
> > +
> > +REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
> > +LOCAL_PRISTINE="$(pwd)/local_pristine"
> > +
> > +test_expect_success 'setup repos for change-while-negotiating test' '
> > +	(
> > +		git init "$REPO" &&
> > +		cd "$REPO" &&
> > +		>.git/git-daemon-export-ok &&
> > +		test_commit m1 &&
> > +		git tag -d m1 &&
> > +
> > +		# Local repo with many commits (so that negotiation will take
> > +		# more than 1 request/response pair)
> > +		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
> > +		cd "$LOCAL_PRISTINE" &&
> > +		git checkout -b side &&
> > +		for i in $(seq 1 33); do test_commit s$i; done &&
> > +
> > +		# Add novel commits to upstream
> > +		git checkout master &&
> > +		cd "$REPO" &&
> > +		test_commit m2 &&
> > +		test_commit m3 &&
> > +		git tag -d m2 m3
> > +	) &&
> > +	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo" &&
> > +	git -C "$LOCAL_PRISTINE" config protocol.version 2
> > +'
> > +
> > +inconsistency() {
> 
> Style. "inconsistency () {"
> 
> > +	# Simulate that the server initially reports $2 as the ref
> > +	# corresponding to $1, and after that, $1 as the ref corresponding to
> > +	# $1. This corresponds to the real-life situation where the server's
> > +	# repository appears to change during negotiation, for example, when
> > +	# different servers in a load-balancing arrangement serve (stateless)
> > +	# RPCs during a single negotiation.
> > +	printf "s/%s/%s/" \
> > +	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
> > +	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
> > +	       >"$HTTPD_ROOT_PATH/one-time-sed"
> > +}
> > +
> > +test_expect_success 'server is initially ahead - no ref in want' '
> > +	git -C "$REPO" config uploadpack.allowRefInWant false &&
> > +	rm -rf local &&
> > +	cp -r "$LOCAL_PRISTINE" local &&
> > +	inconsistency master 1234567890123456789012345678901234567890 &&
> > +	test_must_fail git -C local fetch 2>err &&
> > +	grep "ERR upload-pack: not our ref" err
> > +'
> > +
> > +test_expect_success 'server is initially behind - no ref in want' '
> > +	git -C "$REPO" config uploadpack.allowRefInWant false &&
> > +	rm -rf local &&
> > +	cp -r "$LOCAL_PRISTINE" local &&
> > +	inconsistency master "master^" &&
> > +	git -C local fetch &&
> > +
> > +	git -C "$REPO" rev-parse --verify "master^" >expected &&
> > +	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
> > +	test_cmp expected actual
> > +'
> > +
> > +stop_httpd
> > +
> >  test_done

-- 
Brandon Williams
