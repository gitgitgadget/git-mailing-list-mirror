Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5E3C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F37221EB
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwEW7J5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgJNQ45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 12:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbgJNQ45 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 12:56:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107E0C061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 09:56:57 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so134564pfp.13
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9A5Pk/4JM4XTx/nAfUcEuaaogwP/TDmnYPl5XBxV4A=;
        b=DwEW7J5VGHY4fN0RxDtsjPqK0279HS42U5aeekrECIaZ8n+U+EmaCx8c8XiKeOjHZd
         hJf8xCERk/U6zvEYyzx79xTajZAMAr9LDdXfx0fjDWrrwx44dwZO/Y96tbkt7P4mXwCB
         A3/8WU89iTyoI4O0W1IookhMJlJcJpEuVmURCEj4lza2FOG1kGFHtW/b/Ag98szJ0lax
         JysAmcWorH78zhBuF5pAScN7EWKPj/8LKEcLc2q7utjUuaj3xWOfaiYwroKM6CYAvvxG
         J/Qq71i/Hagb01g782LLXkoBlQXWxTiurOFTcd3g0EUKjWlXDefF9Xh3ojKMBLqyjTCY
         nhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9A5Pk/4JM4XTx/nAfUcEuaaogwP/TDmnYPl5XBxV4A=;
        b=ryQzfc4wzAuJOcqp5YpCOtvBM8KzjPeZQ3nyW8RW6ph2M1olqS1bWPvUIUcgWcnrEa
         Bhp8nR3q/WWW8btoJOlFL6P+q/BWWRq9FFg6hGCH6xz/cJctOruhNqSH3EZklnhBON3M
         ttKjNDiAud4KijslTRgtWGjvsYy86tZQLSIz89T4r04+/ZatV7QYu1cmJXw3IOHax+i2
         samCxw4YrFu6pwLGslGt3A82ysN3Q4rlZmmNlLB6qIkBruAT9Q7nNLl7IDswlS4HnawG
         FjWApSHv73R2vRQGXsfC4xql9F524V4pMtGTXiBgZGMdT7RSldFLnv/lpgMJNQqWpmhK
         XwTg==
X-Gm-Message-State: AOAM533xQ87sH5291V/CFpH3g429mY4Ep6+kp7wbago1PsyM7Kk1+1Vi
        85QEhleEDSUsGfCCgcg6NgbqWYA2sYxR33TpYRnwrQ==
X-Google-Smtp-Source: ABdhPJxbq+nX6ws14RJSLfk0dnmu1tY4fIjIij6Pm/W2RwXDogdYuAt43URWaFfJaRBFkmh7QC5GejJl+irWHiqnpgU=
X-Received: by 2002:a63:dc4f:: with SMTP id f15mr4604813pgj.332.1602694616303;
 Wed, 14 Oct 2020 09:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <xmqqblh5kggd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblh5kggd.fsf@gitster.c.googlers.com>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 10:56:39 -0600
Message-ID: <CAM4o00es=6bksufcu7UvLfPxSS-9NndD2ALe74PRvQjBdHci5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] remote-curl: add testing for intelligent retry for HTTP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Masaya Suzuki <masayasuzuki@google.com>, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sean McAllister <smcallis@google.com> writes:
>
> > +# generate a process unique one-up value
> > +global_counter_for_nonce=0
> > +gen_nonce () {
> > +     global_counter_for_nonce=$((global_counter_for_nonce + 1)) &&
> > +     echo "$global_counter_for_nonce"
> > +}
>
> This must not be called in a subprocess if the caller truly wants
> uniqueness.  May want to be described in a comment.
>
Done.

> > diff --git a/t/lib-httpd/error-ntime.sh b/t/lib-httpd/error-ntime.sh
> > new file mode 100755
> > index 0000000000..64dc878746
> > --- /dev/null
> > +++ b/t/lib-httpd/error-ntime.sh
> > @@ -0,0 +1,80 @@
> > +#!/bin/sh
> > +
> > +# Script to simulate a transient error code with Retry-After header set.
> > +#
> > +# PATH_INFO must be of the form /<nonce>/<times>/<retcode>/<retry-after>/<path>
> > +#   (eg: /dc724af1/3/429/10/some/url)
> > +#
> > +# The <nonce> value uniquely identifies the URL, since we're simulating
> > +# a stateful operation using a stateless protocol, we need a way to "namespace"
> > +# URLs so that they don't step on each other.
> > +#
> > +# The first <times> times this endpoint is called, it will return the given
> > +# <retcode>, and if the <retry-after> is non-negative, it will set the
> > +# Retry-After head to that value.
> > +#
> > +# Subsequent calls will return a 302 redirect to <path>.
> > +#
> > +# Supported error codes are 429,502,503, and 504
> > +
>
> I thought "error codes" were rephrased after the first round's
> review to some other term (which I do not recall--was it status?)?
>
Yes you're right, fixed to reflect that and adjust formatting.

> > +print_status() {
> > +     if [ "$1" -eq "302" ]; then
> > +             printf "Status: 302 Found\n"
> > +     elif [ "$1" -eq "429" ]; then
> > +             printf "Status: 429 Too Many Requests\n"
> > +     elif [ "$1" -eq "502" ]; then
> > +             printf "Status: 502 Bad Gateway\n"
> > +     elif [ "$1" -eq "503" ]; then
> > +             printf "Status: 503 Service Unavailable\n"
> > +     elif [ "$1" -eq "504" ]; then
> > +             printf "Status: 504 Gateway Timeout\n"
> > +     else
> > +             printf "Status: 500 Internal Server Error\n"
> > +     fi
> > +     printf "Content-Type: text/plain\n"
> > +}
>
> Style (Documentation/CodingGuidelines).
>
>         print_status () {
>                 if test "$1" = "302"
>                 then
>                         printf "...";
>                 ...
>         }
>
> but in this particular case, I do not see why we want if/else
> cascade.  Perhaps
>
>         print_status () {
>                 case "$1" in
>                 302)    printf "Status: 302 Found\n" ;;
>                 429)    ... ;;
>                 ...
>                 *)      printf "Status: 500 Internal Server Error\n" ;;
>                 esac
>                 printf "Content-Type: text/plain\n";
>         }
>
> would be more standard?
>
> Also I am not sure why we want "printf ...\n" not "echo" here.  If
> we want to talk HTTP ourselves strictly, I would understand avoiding
> "echo" and doing "printf ...\r\n", though.  If we fear DOS line
> endings coming out of localized "echo", and ensure we use LF line
> ending even on Windows and Cygwin, it is sort of understandable but
> if that is what is going on, that does not explain a lone "echo"
> at the end of the caller.
>
> Puzzled.
>
I modified it to use echo as the standard, it turns out apache handles
properly terminating lines for you
with CRLF.  As for the lone echo, a double CRLF signals the end of the response
header and the start of the body.  Curl doesn't behave properly without it.


>   +oIFS="$IFS"
> > +IFS='/'
> > +set -f
> > +set -- $PATH_INFO
> > +set +f
>   +IFS="$oIFS"
> > +
> > +# pull out first four path components
> > +shift
> > +nonce=$1
> > +times=$2
> > +code=$3
> > +retry=$4
> > +shift 4
> > +
> > +# glue the rest back together as redirect path
> > +path=""
> > +while [ "$#" -gt "0" ]; do
> > +     path="${path}/$1"
> > +     shift
> > +done
>
> Hmph.  Would this work better, I wonder?
>
>         path=${PATH_INFO#*/}    ;# discard leading '/'
>         nonce=${path%%/*}       path=${path#*/}
>         times=${path%%/*}       path=${path#*/}
>         code=${path%%/*}        path=${path#*/}
>         retry=${path%%/*}       path=${path#*/}
>
> At least it is shorter and easier to read.
>
I agree it's better. changed.


> > +# leave a cookie for this request/retry count
> > +state_file="request_${REMOTE_ADDR}_${nonce}_${times}_${code}_${retry}"
> > +
> > +if [ ! -f "$state_file" ]; then
> > +     echo 0 > "$state_file"
> > +fi
>
> Style (Documentation/CodingGuidelines, look for "For shell scripts
> specifically").
>
>  - use "test" not "[]";
>
>  - don't write ";then" on the same line (rule of thumb. you should
>    be able to write your shell scripts without semicolon except for
>    double-semicolons in case/esac statements)
>
>  - don't leave SP between redirection operator '>' and its target
>    file, i.e. write 'echo 0 >"$state_file"'.
>
Done.  I went back over the guidelines and tried to follow everything.

> > +read -r cnt < "$state_file"
> > +if [ "$cnt" -lt "$times" ]; then
> > +     echo $((cnt+1)) > "$state_file"
> > +
> > +     # return error
> > +     print_status "$code"
> > +     if [ "$retry" -ge "0" ]; then
> > +             printf "Retry-After: %s\n" "$retry"
> > +     fi
> > +else
> > +     # redirect
> > +     print_status 302
> > +     printf "Location: %s?%s\n" "$path" "${QUERY_STRING}"
> > +fi
> > +
> > +echo
>
> This "echo" to the client also puzzles me further, after seeing
> puzzling use of "printf ...\n" earlier.
>
See earlier comment, we need a second CRLF to end the HTTP header.
Before I added this, curl was very unhappy.

> > diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> > index 7df3c5373a..72aaed5a93 100755
> > --- a/t/t5601-clone.sh
> > +++ b/t/t5601-clone.sh
> > @@ -756,6 +756,15 @@ test_expect_success 'partial clone using HTTP' '
> >       partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/smart/server"
> >  '
> >
> > +test_expect_success 'partial clone using HTTP with redirect' '
> > +     _NONCE=`gen_nonce` && export _NONCE &&
> > +     curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
> > +     curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
> > +     curl "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server" &&
>
> Why do we need to test "curl" here?  Is this remnant of debugging of
> the server side?
>
At this point in the patch set the retry logic isn't implemented yet.
So this triggers the first error status manually
and then clones the repo using the same URL to verify that clone still
works when returning a 302 redirect status.
I've modified it in v3 so that it only has to do the manual call once though.

> > +     partial_clone "$HTTPD_DOCUMENT_ROOT_PATH/server" "$HTTPD_URL/error_ntime/${_NONCE}/3/502/10/smart/server"
> > +'
> > +
> > +
> >  # DO NOT add non-httpd-specific tests here, because the last part of this
> >  # test script is only executed when httpd is available and enabled.
