Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20CA51F404
	for <e@80x24.org>; Mon, 13 Aug 2018 19:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbeHMWLB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 18:11:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34744 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbeHMWLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 18:11:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so15252689wrt.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YGO8N3ezL0FXGWHVvsA452Qw+shECnzKT2DrPh+lbxU=;
        b=k2x6/bJCWtG0aGkcCoJpRSYfmMF6vuAHdQU0/aQwgRayjQ7Gy1nPtqfYczaFSUAjb9
         9FtYxmIKfVteR+oq5WrD1QanA8WpdPsesYmCCrNo+Du84uS1XAMcq+rJJKg8rbqER2I/
         0vJvVPtvQSxguReDDn8Af2lhXZkJIofQRPMElV9tFRdXI65YNa8MIyyS2hPcqD5l31DR
         AaPMVEUS0V58KHSNvc+1W7sYZ4UsQXDNIYv4enHQEExk6GKBcnDfHlqIJr+J3TXYR+ck
         HLEKaavfH7W6lHI7zir5rDpG4QZloGuh5mXISe22UlCxmyopAJUVQDRVjjACHl5OIYCL
         +qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YGO8N3ezL0FXGWHVvsA452Qw+shECnzKT2DrPh+lbxU=;
        b=pSQVCtHf4fcM8oItBacWzweqaFWsMYeQSwMm9ge3sLaglmoUt1vIaBYTeCejumgzB7
         YKWnLrCKfclL+NA8YxS9DGkpLP+U3klk50n8mFrhu/tJHHxhjlkX4Xg4PWctmislttTi
         lxMkMElSHgOMZnKi4PhsrEAhVPa3ndrhEFdaj/Mxv8oK100kqJvp4eaUcmoS5tsLsG3r
         oUXCAdZq+jDde1hJgGKkzCAAAEa4tYVfbaZeetzXOV8J9hZiBT2kNjXXlcxaRr2kBaw6
         FisTS6l7Tj8HrFFEXvaFUD1R30u1kR5xt1jgypKP70vhxEoYZmMS9QHVO9tuQ0CFvHi3
         4e2A==
X-Gm-Message-State: AOUpUlF1umQm2RpxjnoHMsu7N6ur+17wjIwzLa+CiwMuJ2hYVl/MNltA
        P6GGZeqoEoGJP/Utw0ePueU=
X-Google-Smtp-Source: AA+uWPxiObuvK8bYiKPfaWTIUVBGURBeWLYaY3U7Q+EZyZ58RSTIAVVOhgLfonWyk9A22nPY2RQq0A==
X-Received: by 2002:adf:8bd4:: with SMTP id w20-v6mr11307381wra.110.1534188444350;
        Mon, 13 Aug 2018 12:27:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a6-v6sm9923826wmf.22.2018.08.13.12.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 12:27:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/6] chainlint: match 'quoted' here-doc tags
References: <20180807082135.60913-1-sunshine@sunshineco.com>
        <20180813084739.16134-1-sunshine@sunshineco.com>
        <20180813084739.16134-3-sunshine@sunshineco.com>
Date:   Mon, 13 Aug 2018 12:27:23 -0700
In-Reply-To: <20180813084739.16134-3-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 13 Aug 2018 04:47:35 -0400")
Message-ID: <xmqqwosu3w4k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> A here-doc tag can be quoted ('EOF') or escaped (\EOF) to suppress
> interpolation within the body. Although, chainlint recognizes escaped
> tags, it does not know about quoted tags. For completeness, teach it to
> recognize quoted tags, as well.

Is this step merely completeness and future-proofing, or do we have
existing instances that the linter would be confused without this
patch?  I am primarily wondering what the reason is that <<"EOF" is
not looked for while we are at it (the answer could be that we
have tests that use <<'EOF' but not <<"EOF").

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/chainlint.sed                      | 8 ++++----
>  t/chainlint/here-doc.expect          | 2 ++
>  t/chainlint/here-doc.test            | 7 +++++++
>  t/chainlint/subshell-here-doc.expect | 1 +
>  t/chainlint/subshell-here-doc.test   | 4 ++++
>  5 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/t/chainlint.sed b/t/chainlint.sed
> index 2af1a687f8..2901494e8a 100644
> --- a/t/chainlint.sed
> +++ b/t/chainlint.sed
> @@ -94,8 +94,8 @@
>  
>  # here-doc -- swallow it to avoid false hits within its body (but keep the
>  # command to which it was attached)
> -/<<[ 	]*[-\\]*[A-Za-z0-9_]/ {
> -	s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
> +/<<[ 	]*[-\\']*[A-Za-z0-9_]/ {
> +	s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
>  	s/[ 	]*<<//
>  	:hereslurp
>  	N
> @@ -158,7 +158,7 @@ s/.*\n//
>  	/"[^'"]*'[^'"]*"/!bsqstring
>  }
>  # here-doc -- swallow it
> -/<<[ 	]*[-\\]*[A-Za-z0-9_]/bheredoc
> +/<<[ 	]*[-\\']*[A-Za-z0-9_]/bheredoc
>  # comment or empty line -- discard since final non-comment, non-empty line
>  # before closing ")", "done", "elsif", "else", or "fi" will need to be
>  # re-visited to drop "suspect" marking since final line of those constructs
> @@ -268,7 +268,7 @@ bcheckchain
>  # found here-doc -- swallow it to avoid false hits within its body (but keep
>  # the command to which it was attached)
>  :heredoc
> -s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
> +s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
>  s/[ 	]*<<//
>  :hereslurpsub
>  N
> diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
> index 33bc3cc0b4..aff6568716 100644
> --- a/t/chainlint/here-doc.expect
> +++ b/t/chainlint/here-doc.expect
> @@ -2,4 +2,6 @@ boodle wobba        gorgo snoot        wafta snurb &&
>  
>  cat >foo &&
>  
> +cat >bar &&
> +
>  horticulture
> diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
> index 8986eefe74..f2bb14b693 100644
> --- a/t/chainlint/here-doc.test
> +++ b/t/chainlint/here-doc.test
> @@ -14,6 +14,13 @@ boz
>  woz
>  Arbitrary_Tag_42
>  
> +# LINT: swallow 'quoted' here-doc
> +cat <<'FUMP' >bar &&
> +snoz
> +boz
> +woz
> +FUMP
> +
>  # LINT: swallow here-doc (EOF is last line of test)
>  horticulture <<\EOF
>  gomez
> diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
> index 7c2da63bc7..7663ea7fc4 100644
> --- a/t/chainlint/subshell-here-doc.expect
> +++ b/t/chainlint/subshell-here-doc.expect
> @@ -5,5 +5,6 @@
>  >) &&
>  (
>  	cat >bup &&
> +	cat >bup2 &&
>  	meep
>  >)
> diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
> index 05139af0b5..b6b5a9b33a 100644
> --- a/t/chainlint/subshell-here-doc.test
> +++ b/t/chainlint/subshell-here-doc.test
> @@ -27,5 +27,9 @@
>  	glink
>  	FIZZ
>  	ARBITRARY
> +	cat <<-'ARBITRARY2' >bup2 &&
> +	glink
> +	FIZZ
> +	ARBITRARY2
>  	meep
>  )
