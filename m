Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5976CC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF016248CD
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLGSXFVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730960AbgJMPD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJMPD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 11:03:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3DAC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 08:03:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hk7so167737pjb.2
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nGuv4ZhK8Xhd7yRVAbX3WNKcFmGl8jfoNZ+uOjBupU8=;
        b=kLGSXFVpnFei4bnCysp8tqMIBsiCh6o4mr9BpGIBzR6dry+pTtVoD2ZPY8N2JFnX42
         NJRiYc9xG1uQIfOU/VFcnwK21osJM/+8cnMkXttqbCbmDTCjd/pSuLJrae118HigJgVH
         8BVrHoMEuhstgjVH9ViVIoeoUIxwm0Mchl1Qvgv687AQAEHfcILJe/r2RWh5dHObRMEP
         7KVO6160oAiRC3Z2uVfKdzSt0gMBqElEHWlmTOd8DsauafOE28IWAX1DTOB14vkJheN2
         /42CuC0yOVm0/40W6TtQAhxgiwdaJzyDcPVNanim6yPc47K0DazoGdnu4SbEwdOrmlSw
         pOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nGuv4ZhK8Xhd7yRVAbX3WNKcFmGl8jfoNZ+uOjBupU8=;
        b=bSWf4mLhllhXvFBb9xEUjGbOjiUil3bvV1cYqx8RuA+7doO1RZFXrxWGbSOecWq2pK
         2FNDqq/dwyQOce/qNUYqdJYKi9/0k9LeMvx4FsLLl68ma4QAFusq2EHncKAu7BrWVC8f
         hEQTWglwrWpEFxnUdSWfiYTOpZzJ89PWcDItuCh9qDIEbYuZQ6yrFu0G+77/a9JmZ1fQ
         VsmQPEAuMgHSlXaGk6+pl6o28xD/qOlFTWVVDnWNby7FDVBUjPP+IIre2Yc/dwfEhiR9
         kOIzQ3OjdxXnrhVaBu8XvqTvxbUd7zAq+huM7ZWGWuYK9HsGS2xBikKtEK3z3yvTDHPx
         Ctxg==
X-Gm-Message-State: AOAM532f8eomI4saRvxW9TMjJCdkIN72cQwpX1jXwV+gyUc49TS/WzTz
        2evGObMm1XoJFxBfl+YTkhKJFwqxzRT4oMLA/hCvcH7g1sblbnbq
X-Google-Smtp-Source: ABdhPJy6qOVu/XQy35BFT+sS3C7cfPzVni7hU0TQNY4XmbemZ0iwXW5TdTcMVpu6cAP8C6uohb2jf8JeV7ZMtHBau0E=
X-Received: by 2002:a17:90a:430a:: with SMTP id q10mr129476pjg.45.1602601407381;
 Tue, 13 Oct 2020 08:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201012184806.166251-1-smcallis@google.com> <20201012184806.166251-3-smcallis@google.com>
 <nycvar.QRO.7.76.6.2010122126280.50@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2010122126280.50@tvgsbejvaqbjf.bet>
From:   Sean McAllister <smcallis@google.com>
Date:   Tue, 13 Oct 2020 09:03:15 -0600
Message-ID: <CAM4o00fL4oGNG_Z7tF5bL=Kp===683LBo1RhmZ=vZ6Kie=-jzA@mail.gmail.com>
Subject: Re: [PATCH 3/3] http: automatically retry some requests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        peff@peff.net, Masaya Suzuki <masayasuzuki@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >
> > +http.retryLimit::
> > +     Some HTTP error codes (eg: 429,503) can reasonably be retried if
>
> Please have a space after the comma so that it is not being mistaken for a
> 6-digit number. Also, aren't they called "status codes"? Not all of them
> indicate errors, after all.

Done for v2, good point on the nomenclature.

> > diff --git a/http.c b/http.c
> > index b3c1669388..e41d7c5575 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -92,6 +92,9 @@ static const char *http_proxy_ssl_key;
> >  static const char *http_proxy_ssl_ca_info;
> >  static struct credential proxy_cert_auth = CREDENTIAL_INIT;
> >  static int proxy_ssl_cert_password_required;
> > +static int http_retry_limit = 3;
> > +static int http_default_delay = 2;
>
> Should there be a config option for that? Also, it took me some time to
> find the code using this variable in order to find out what unit to use:
> it is seconds (not microseconds, as I had expected). Maybe this can be
> documented in the variable name, or at least in a comment?
>

Junio tossed that out during our private review and I think we decided to just
leave them as non-const so we have that option going forward.  I'm not
sure there's
a strong story for configuring the default delay.

I went through and changed all the _delay variables to be more explicit they're
in seconds.

> > @@ -219,6 +222,51 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
> >       return nmemb;
> >  }
> >
> > +
> > +/* return 1 for a retryable HTTP code, 0 otherwise */
> > +static int retryable_code(int code)
> > +{
> > +     switch(code) {
> > +     case 429: /* fallthrough */
> > +     case 502: /* fallthrough */
> > +     case 503: /* fallthrough */
> > +     case 504: return 1;
> > +     default:  return 0;
> > +     }
> > +}
> > +
> > +size_t http_header_value(
>
> In the part of Git's code with which I am familiar, we avoid trying to
> break the line after an opening parenthesis, instead preferring to break
> after a comma.
>
> Also, shouldn't we make the return type `ssize_t` to allow for a negative
> value to indicate an error/missing header?

I return zero to indicate no header found (or zero-length value), so this should
never return a negative value.  One can check value to see if a string
was allocated
for a zero-length header.

>
> > +     const struct strbuf headers, const char *header, char **value)
> > +{
> > +     size_t len = 0;
> > +     struct strbuf **lines, **line;
> > +     char *colon = NULL;
> > +
> > +     lines = strbuf_split(&headers, '\n');
> > +     for (line = lines; *line; line++) {
> > +             strbuf_trim(*line);
> > +
> > +             /* find colon and null it out to 'split' string */
> > +             colon = strchr((*line)->buf, ':');
> > +             if (colon) {
> > +                     *colon = '\0';
> > +
> > +                     if (!strcasecmp(header, (*line)->buf)) {
>
> If all we want is to find the given header, splitting lines seems to be a
> bit wasteful to me. We could instead search for the header directly:
>
>         const char *p = strcasestr(headers.buf, header), *eol;
>         size_t header_len = strlen(header);
>
>         while (p) {
>                 if ((p != headers.buf && p[-1] != '\n') ||
>                     p[header_len] != ':') {
>                         p = strcasestr(p + header_len, header);
>                         continue;
>                 }
>
>                 p += header_len + 1;
>                 while (isspace(*p) && *p != '\n')
>                         p++;
>                 eol = strchrnul(p, '\n');
>                 len =  eol - p;
>                 *value = xstrndup(p, len);
>                 return len;
>         }
>

I've been writing a lot of python code lately =D  So splitting into
lines was a natural paradigm for me.  You're right, I like yours more.  I've
refactored it to be closer to that.  Little bit of fiddling to deal with header
whitespace properly, but it's pretty close.

I also modified to just return the value pointer directly, then it's clear when
we get a zero-length header or don't find it completely, and it fixes the
leak issue below.

> > @@ -1903,20 +1958,55 @@ static void http_opt_request_remainder(CURL *curl, off_t pos)
> >  #define HTTP_REQUEST_STRBUF  0
> >  #define HTTP_REQUEST_FILE    1
> >
> > +/* check for a retry-after header in the given headers string, if found, then
> > +honor it, otherwise do an exponential backoff up to the max on the current delay
> > +*/
>
> Multi-line comments should be of this form:
>
>         /*
>          * Check for a retry-after header in the given headers string, if
>          * found, then honor it, otherwise do an exponential backoff up to
>          * the maximum on the current delay.
>          */
>
Done.

> > +static int http_retry_after(const struct strbuf headers, int cur_delay) {
>
> For functions, the initial opening curly bracket goes on its own line.
>
Done.

> > +     int len, delay;
> > +     char *end;
> > +     char *value;
>
> Why not declare `char *end, *value;`, just like `len` and `delay` are
> declared on the same line?
>
Done.

> > +
> > +     len = http_header_value(headers, "retry-after", &value);
> > +     if (len) {
> > +             delay = strtol(value, &end, 0);
> > +             if (*value && *end == 0 && delay >= 0) {
>
> Better: `*end == '\0'`
>
> And why `*value` here? We already called `strtol()` on it.
>
Fixed, and I check value per the man page on strtol:
    > In particular, if *nptr is not '\0' but **endptr is '\0' on
return, the entire string is valid.
I wanted to make sure I converted the entire header value, so this
seemed correct?

> > +                     if (delay > http_max_delay) {
> > +                             die(Q_(
>
> Let's not end the line in an opening parenthesis. Instead, use C's string
> continuation like so:
>
>                                 die(Q_("server requested retry after %d second,"
>                                        " which is longer than max allowed\n",
>                                        "server requested retry after %d "
>                                        "seconds, which is longer than max "
>                                        "allowed\n", delay), delay);
>
Done.

> > +                                             "server requested retry after %d second, which is longer than max allowed\n",
> > +                                             "server requested retry after %d seconds, which is longer than max allowed\n", delay), delay);
> > +                     }
> > +                     free(value);
>
> `value` is not actually used after that `strtol()` call above, so let's
> release it right then and there.
>
Good call, done.

> > +                     return delay;
> > +             }
> > +             free(value);
> > +     }
>
> If the header was found, but for some reason had an empty value, we're
> leaking `value` here.
>
I return the pointer directly and check that now, so if it's allocated, we'll
always call free, even if it's an empty string.

> > +
> > +     cur_delay *= 2;
> > +     return cur_delay >= http_max_delay ? http_max_delay : cur_delay;
> > +}
> > +
> >  static int http_request(const char *url,
> >                       void *result, int target,
> >                       const struct http_get_options *options)
> >  {
> >       struct active_request_slot *slot;
> >       struct slot_results results;
> > -     struct curl_slist *headers = http_copy_default_headers();
> > +     struct curl_slist *headers;
> >       struct strbuf buf = STRBUF_INIT;
> > +     struct strbuf result_headers = STRBUF_INIT;
> >       const char *accept_language;
> >       int ret;
> > +     int retry_cnt = 0;
> > +     int retry_delay = http_default_delay;
> > +     int http_code;
> >
> > +retry:
> >       slot = get_active_slot();
> >       curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
> >
> > +     curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, &result_headers);
> > +     curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_buffer);
> > +
> >       if (result == NULL) {
> >               curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
> >       } else {
> > @@ -1936,6 +2026,7 @@ static int http_request(const char *url,
> >
> >       accept_language = get_accept_language();
> >
> > +     headers = http_copy_default_headers();
> >       if (accept_language)
> >               headers = curl_slist_append(headers, accept_language);
> >
> > @@ -1961,7 +2052,31 @@ static int http_request(const char *url,
> >       curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
> >       curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
> >
> > -     ret = run_one_slot(slot, &results);
> > +     http_code = 0;
> > +     ret = run_one_slot(slot, &results, &http_code);
> > +
> > +     if (ret != HTTP_OK) {
> > +             if (retryable_code(http_code) && (retry_cnt < http_retry_limit)) {
>
> The parentheses around the second condition should be dropped.
>
Done.

> > +                     retry_cnt++;
> > +                     retry_delay = http_retry_after(result_headers, retry_delay);
> > +                     fprintf(stderr,
>
> Should this be a `warning()` instead? I see 5 instances in `http.c` that
> use `fprintf(stderr, ...)`, but 12 that use `warning()`, making me believe
> that at least some of those 5 instances should call `warning()` instead,
> too.
>
At your discretion.  I'm not familiar with the logging framework.
Only one of those 5 fprintf
is in my patch, so I changed that one to use warning().

> > +                         Q_("got HTTP response %d, retrying after %d second (%d/%d)\n",
> > +                                "got HTTP response %d, retrying after %d seconds (%d/%d)\n",
> > +                                     retry_delay),
> > +                             http_code, retry_delay, retry_cnt, http_retry_limit);
> > +                     sleep(retry_delay);
> > +
> > +                     // remove header data fields since not all slots will use them
>
> No C++-style comments, please: use /* ... */ instead.
>
Thought I got them all.  Done.

> > +                     curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, NULL);
> > +                     curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, NULL);
> > +
> > +                     goto retry;
> > +             }
> > +     }
> > +
> > +     // remove header data fields since not all slots will use them
>
> No C++-style comments, please.
>
Done.

> > +     curl_easy_setopt(slot->curl, CURLOPT_HEADERDATA, NULL);
> > +     curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, NULL);
>
> Shouldn't we just perform this assignment before the `if (ret != HTTP_OK)`
> condition? I do not see anything inside that block that needs it,
> therefore this could be DRY'd up.
>
Excellent idea, done.

> > +/*
> > + * Query the value of an HTTP header.
> > + *
> > + * If the header is found, then a newly allocate string is returned through
> > + * the value parameter, and the length is returned.
> > + *
> > + * If not found, returns 0
> > + */
> > +size_t http_header_value(
> > +     const struct strbuf headers, const char *header, char **value);
>
> Do we really need to export this function? It could stay file-local, at
> least for now (i.e. be defined `static` inside `http.c`), no?
>
I originally thought I'd need it elsewhere, so a big of a relic there.  I made
it static for now.

> > --- a/t/t5539-fetch-http-shallow.sh
> > +++ b/t/t5539-fetch-http-shallow.sh
> > @@ -30,20 +30,39 @@ test_expect_success 'clone http repository' '
> >       git clone --bare --no-local shallow "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> >       git clone $HTTPD_URL/smart/repo.git clone &&
> >       (
> > -     cd clone &&
> > -     git fsck &&
> > -     git log --format=%s origin/master >actual &&
> > -     cat <<EOF >expect &&
> > -7
> > -6
> > -5
> > -4
> > -3
> > -EOF
> > -     test_cmp expect actual
> > +             cd clone &&
> > +             git fsck &&
> > +             git log --format=%s origin/master >actual &&
> > +             cat <<-\EOF >expect &&
> > +             7
> > +             6
> > +             5
> > +             4
> > +             3
> > +             EOF
> > +             test_cmp expect actual
>
> This just changes the indentation, right?
>
> I _guess_ this is a good change, but it should live in its own patch.
>
This was in combination with my adding a new test, we cleaned up the
whitespace too per Junio rather than copy-and-pasting ill formatted code.

It's OBE now because this change has been removed in v2.

> > +test_expect_success 'clone http repository with flaky http' '
> > +    rm -rf clone &&
>
> Let's consistently use horizontal tab characters for indentation. (There
> are more instances of lines indented by spaces below.)
>
*sigh* thought I got them all, fixed.

> > +     git clone $HTTPD_URL/error_ntime/`gen_nonce`/3/429/1/smart/repo.git clone 2>err &&
>
> Let's use `$(gen_nonce)`. Also: where is the `gen_nonce` defined? I do not
> see the definition in this patch (but it could be 1/3, which for some
> reason did not make it to the mailing list:
> https://lore.kernel.org/git/20201012184806.166251-1-smcallis@google.com/).
>
Done, and it is indeed in 1/3 which got caught by the spam filter
(should be available now).

> Another suggestion: rather than deleting `clone/`, use a separate
> directory to clone into, say, `flaky/`. That will make it easier to debug
> when the entire "trash" directory is tar'ed up in a failed CI build, for
> example.
>
Done.

> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index e40e9ed52f..85d2a0e8b8 100755
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -45,6 +45,7 @@ test_expect_success 'clone http repository' '
> >       EOF
> >       GIT_TRACE_CURL=true GIT_TEST_PROTOCOL_VERSION=0 \
> >               git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
> > +    cd clone && git config pull.rebase false && cd .. &&
>
> Better: test_config -C clone pull.rebase false
>
Done, but also OBE by removing tests.

>
> I wonder whether it is really necessary to add _that_ many test cases. The
> test suite already takes so long to run that we had cases where
> contributors simply did not run it before sending their contributions.
>
> In this instance, I would think that it would be plenty sufficient to have
> a single new test case that exercizes the added code path (and verifies
> that it can see the message).
>
Done, down to a single test (clone) that should exercise everything.

> Thanks,
> Dscho
>
> >
> >  # DO NOT add non-httpd-specific tests here, because the last part of this
> >  # test script is only executed when httpd is available and enabled.
> > --
> > 2.28.0.1011.ga647a8990f-goog
> >
> >
