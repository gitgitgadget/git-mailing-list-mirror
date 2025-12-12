Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D843C38
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543026; cv=none; b=Gjx8GpHsmVFXBQF2Z4C0ffLItQxgiwt125dHlgyM13wIAGCctIf/8/wH7ZHLB9VeQOCbUZ9FdLnvONzaF7JkatQbAQyFL/zinSbgyUdxdMcw8wI/bc1zaiKoK1Jl7eZRnBv09VKkiUiJ/dp9ri0O5zKPURRoJAiuXPKb1urWMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543026; c=relaxed/simple;
	bh=3wcqqt9hs20xln+M7cjiKVZh8DdmG5XMDfFZyqLuf/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRY/M+blFrBjEUzv14PppSx44h3mqdXTN1WABVZXyHEgaZCIoFxG8mpqE8DL2QzDTrUjSYIjf2BtgCEtRVclTS+1nEFVgwqNYYFtydZOo/HfRzSrVMocqZlm5mXdIBnnDuKTBXRThGkPX0/sSGmpi/lTTq8CYqpjYEGmInwvMck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=TWO5EbJC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="TWO5EbJC"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5958232f806so1318413e87.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 04:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1765543022; x=1766147822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZWYKLAZ+1oXjTdohoeP+xDGdlLbR2geaWPkPGpeHss=;
        b=TWO5EbJCPqznkeEslni6YF03WvTXvdxNhxZ0thFcPisKOGNPI4XURsdXWvZl0s5rTB
         w0NnqBjV/ZjlSC+FRKgrIeGaNOX3EGH5gbluKongO6QEcu+/XGZ3OUqQjajSaOa41nbP
         +tQ1hh362bMuP8NGmMPaZaPoIAUXU6QJZuTAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765543022; x=1766147822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SZWYKLAZ+1oXjTdohoeP+xDGdlLbR2geaWPkPGpeHss=;
        b=pSbcaz3Rr9Es+mEy7vNDzc6Hyj8YPKQi+ruU15DVhLicSmmqO5iK21aCJ32FZNC2Hn
         gfFd8KCJH31ppgPNpqmBFUc961HtqoVF4aQl7hqAJJbm0KQ3S8zYhtOhcz1+wIS1Qa4k
         UntYQIXYSMQ8607tGEdRyi5iwmFj3cpFi6UEPF5qiHDkHOqNxRMw7v4ChDI6XRx2wufY
         82/f3OdoAftZSKOobOJB+KYCyrHhrd8dskFrjnJznYwFGqy0UlAHkpk6QfpmRfoVM8Xj
         P6X9tlxILiIUifYNu9rpdYSisIe/727lmotUsiTe/s2d3/XWIRaeqV7ca38m58GMP+l5
         8PQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWSQZesQ+rdKyMsA5K2f35p0EYthJIsWThxXrVFg6zWBJe9/pXk4IiahAbLQuZd4DTamA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGb/aADTLiNVzUjtvBI3HbTazspYHc5N92QM0gXsePsDCRcBX
	M3QkJc52KZU9OqZrNSUG3nwZ5LOVA4Qp5cAG2sKBeI4kymbkorp2h0UWf+yXF9k73x9SW8gTPKj
	Cr4L/SaP5PC6fiRTjAzDS9J5tAgqilkrXGOtWI1hxyA==
X-Gm-Gg: AY/fxX5rSzXlCIbIl6sbA4kqOePa6jsKqRc3AZkSq4Esllp+wBiwMOVjttKdi+fpIZP
	HNOA2AUJ1Gc55Kbc6dm2ABe6f3xXsMFkJYGA2TeXJL58A7SaE/YkZcpbSNjisXhkYQcGKKQSVhY
	2uFh1UfpEarSnCBCR9THZYrn+morYJVxoXZOL0eF+FkJoE9EDFdDRH7bPF7xb/o42mdaA/Yrx5w
	ugGFFVysLAXhQ5lxyIbxEabS4ZdMBH0bDjrhOigx/NWPKd0H+8KbciCcTP5eh7NnwCxcnIWmN4O
	8g==
X-Google-Smtp-Source: AGHT+IE2GPQ47YVUY8iOy2VUSLJU7s9NW0/o8Qtgel3rZlrnHr/nU4tfG5yDtxbd+ToqNU/Qk5lSQm8wiqULgtO/YIo=
X-Received: by 2002:a05:6512:31ce:b0:595:7f64:fb7b with SMTP id
 2adb3069b0e04-598faa075bdmr714635e87.16.1765543020563; Fri, 12 Dec 2025
 04:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2008.git.1764160227.gitgitgadget@gmail.com>
 <ae0087cd1c7fbb6b748d6767b476c1bd1a19996f.1764160227.git.gitgitgadget@gmail.com>
 <aTitfzeb7J8TUTYQ@nand.local>
In-Reply-To: <aTitfzeb7J8TUTYQ@nand.local>
From: Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Date: Fri, 12 Dec 2025 14:36:49 +0200
X-Gm-Features: AQt7F2qczJHNdDkmsKldbc2iXuIGnjeTSmxAt15m7uT_xticMfsE2mWuVNU6jFg
Message-ID: <CAGjQmDOCeYMvvuct2ZkOJKhzpuSH6qqnWMDCbZ2OwcxQ_2DfpQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] http: add support for HTTP 429 rate limit retries
To: Taylor Blau <me@ttaylorr.com>
Cc: Vaidas Pilkauskas via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 1:15=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
> > +/*
> > + * Sleep for the specified number of seconds before retrying.
> > + */
> > +static void sleep_for_retry(long retry_after)
> > +{
> > +     if (retry_after > 0) {
> > +             unsigned int remaining;
> > +             warning(_("rate limited, waiting %ld seconds before retry=
"), retry_after);
> > +             remaining =3D sleep(retry_after);
>
> What should we do if there are other active request slots? It has been a
> couple of years since I have looked at Git's HTTP code, but I imagine
> that we should be able to continue processing other requests while
> waiting for the retry-after period to elapse here.

This is a very good catch - I'll rewrite this to a non-blocking wait.

Thanks for the review, Taylor, I'll work to address this and other
comments in the next version of the patch.

On Wed, Dec 10, 2025 at 1:15=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Nov 26, 2025 at 12:30:25PM +0000, Vaidas Pilkauskas via GitGitGad=
get wrote:
> > Retry behavior is controlled by three new configuration options:
> >
> >   * http.maxRetries: Maximum number of retry attempts (default: 0,
> >     meaning retries are disabled by default). Users must explicitly
> >     opt-in to retry behavior.
> >
> >   * http.retryAfter: Default delay in seconds when the server doesn't
> >     provide a Retry-After header (default: -1, meaning fail if no
> >     header is provided). This serves as a fallback mechanism.
> >
> >   * http.maxRetryTime: Maximum delay in seconds for a single retry
> >     (default: 300). If the server requests a delay exceeding this
> >     limit, Git fails immediately rather than waiting. This prevents
> >     indefinite blocking on unreasonable server requests.
> >
> > All three options can be overridden via environment variables:
> > GIT_HTTP_MAX_RETRIES, GIT_HTTP_RETRY_AFTER, and
> > GIT_HTTP_MAX_RETRY_TIME.
>
> This is great information, and I am glad that it is written down in
> http.adoc so that it shows up in git-config(1). I think that it's fine
> to omit this level of detail from the commit message, since it
> duplicates information from the authoritative source on configuration
> knobs.
>
> It might be reasonable to say something like:
>
>     Retry behavior is controlled by three new configuration options
>     (http.maxRetries, http.retryAfter, and http.maxRetryTime) which are
>     documented in git-config(1).
>
> or something.
>
> > diff --git a/http-push.c b/http-push.c
> > index d86ce77119..a602a302ec 100644
> > --- a/http-push.c
> > +++ b/http-push.c
> > @@ -716,6 +716,10 @@ static int fetch_indices(void)
> >       case HTTP_MISSING_TARGET:
> >               ret =3D 0;
> >               break;
> > +     case HTTP_RATE_LIMITED:
> > +             error("rate limited by '%s', please try again later", rep=
o->url);
> > +             ret =3D -1;
>
> Other strings in this file aren't marked for translation, but I think
> we can/should mark this one like so:
>
>     error(_("rate limited by %s ..."), repo->url);
>
> > diff --git a/http.c b/http.c
> > index 41f850db16..212805cad5 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -22,6 +22,7 @@
> >  #include "object-file.h"
> >  #include "odb.h"
> >  #include "tempfile.h"
> > +#include "date.h"
> >
> >  static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
> >  static int trace_curl_data =3D 1;
> > @@ -149,6 +150,14 @@ static char *cached_accept_language;
> >  static char *http_ssl_backend;
> >
> >  static int http_schannel_check_revoke =3D 1;
> > +
> > +/* Retry configuration */
> > +static long http_retry_after =3D -1; /* Default retry-after in seconds=
 when header is missing (-1 means not set, exit with 128) */
> > +static long http_max_retries =3D 0; /* Maximum number of retry attempt=
s (0 means retries are disabled) */
> > +static long http_max_retry_time =3D 300; /* Maximum time to wait for a=
 single retry (default 5 minutes) */
>
> These comments should be OK to drop, the variables indicate what Git
> configuration they correspond to (e.g., http_retry_after ->
> http.retryAfter), so git-config(1) is the authoritative source for
> documentation here.
>
> > @@ -257,6 +267,47 @@ static size_t fwrite_wwwauth(char *ptr, size_t elt=
size, size_t nmemb, void *p UN
> >               goto exit;
> >       }
> >
> > +     /* Parse Retry-After header for rate limiting */
> > +     if (skip_iprefix_mem(ptr, size, "retry-after:", &val, &val_len)) =
{
>
> Makes sense, though I wonder if we should rename this function, since
> fwrite_wwwauth is now doing more than just handling WWW-Authenticate
> headers.
>
> Perhaps we should have a single top-level function that is registered as
> our CURLOPT_HEADERFUNCTION that dispatches calls to header-specific
> functions? Otherwise the actual parsing of the Retry-After header looks
> good to me.
>
> > @@ -1422,6 +1488,10 @@ void http_init(struct remote *remote, const char=
 *url, int proactive_auth)
> >       set_long_from_env(&curl_tcp_keepintvl, "GIT_TCP_KEEPINTVL");
> >       set_long_from_env(&curl_tcp_keepcnt, "GIT_TCP_KEEPCNT");
> >
> > +     set_long_from_env(&http_retry_after, "GIT_HTTP_RETRY_AFTER");
> > +     set_long_from_env(&http_max_retries, "GIT_HTTP_MAX_RETRIES");
> > +     set_long_from_env(&http_max_retry_time, "GIT_HTTP_MAX_RETRY_TIME"=
);
> > +
>
> The configuration handling and overrides look good to me.
>
> > @@ -2253,19 +2330,36 @@ static int update_url_from_redirect(struct strb=
uf *base,
> >       return 1;
> >  }
> >
> > +/*
> > + * Sleep for the specified number of seconds before retrying.
> > + */
> > +static void sleep_for_retry(long retry_after)
> > +{
> > +     if (retry_after > 0) {
> > +             unsigned int remaining;
> > +             warning(_("rate limited, waiting %ld seconds before retry=
"), retry_after);
> > +             remaining =3D sleep(retry_after);
>
> What should we do if there are other active request slots? It has been a
> couple of years since I have looked at Git's HTTP code, but I imagine
> that we should be able to continue processing other requests while
> waiting for the retry-after period to elapse here.
>
> > @@ -2302,7 +2396,54 @@ static int http_request_reauth(const char *url,
> >                       BUG("Unknown http_request target");
> >               }
> >
> > -             credential_fill(the_repository, &http_auth, 1);
> > +             if (ret =3D=3D HTTP_RATE_LIMITED) {
>
> Should handling the retry behavior be moved into a separate function? I
> think that http_request_reauth() might be clearer if it read:
>
>     if (ret =3D=3D HTTP_RATE_LIMITED)
>       apply_rate_limit(...); /* presumably with a better name */
>     else
>       credential_fill(...);
>
> , and likewise, should we rename this function as it is no longer just
> re-authenticating HTTP requests?
>
> > diff --git a/t/t5584-http-429-retry.sh b/t/t5584-http-429-retry.sh
> > new file mode 100755
> > index 0000000000..8bcc382763
> > --- /dev/null
> > +++ b/t/t5584-http-429-retry.sh
> > @@ -0,0 +1,429 @@
> > +#!/bin/sh
> > +
> > +test_description=3D'test HTTP 429 Too Many Requests retry logic'
> > +
> > +. ./test-lib.sh
> > +
> > +. "$TEST_DIRECTORY"/lib-httpd.sh
> > +
> > +start_httpd
> > +
> > +test_expect_success 'setup test repository' '
> > +     test_commit initial &&
> > +     git clone --bare . "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> > +     git --git-dir=3D"$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config http.=
receivepack true
> > +'
> > +
> > +test_expect_success 'HTTP 429 with retries disabled (maxRetries=3D0) f=
ails immediately' '
> > +     write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
> > +     printf "Status: 429 Too Many Requests\r\n"
> > +     printf "Retry-After: 1\r\n"
> > +     printf "Content-Type: text/plain\r\n"
> > +     printf "\r\n"
> > +     printf "Rate limited\n"
> > +     cat "$1" >/dev/null
> > +     EOF
>
> To avoid having to write this script multiple write, you can write it as
> a separate script in t/lib-httpd and then make sure to list it in
> prepare_httpd() (from t/lib-httpd.sh).
>
> You can then list it in the apache.conf in the same directory and invoke
> it however you like. If you need to take in arguments to the script
> (e.g., to change the Retry-After value), you can use a ScriptAliasMatch
> instead of a normal ScriptAlias to pass in extra parameters from the URL.
>
> The one-time-script mechanism here will cause the test harness to delete
> the script after its first (and only) use, which can be useful for some
> cases but I suspect is not necessary for all of these tests.
> > +
> > +     # Set maxRetries to 0 (disabled)
> > +     test_config http.maxRetries 0 &&
> > +     test_config http.retryAfter 1 &&
> > +
> > +     # Should fail immediately without any retry attempt
> > +     test_must_fail git ls-remote "$HTTPD_URL/one_time_script/repo.git=
" 2>err &&
> > +
> > +     # Verify no retry happened (no "waiting" message in stderr)
> > +     ! grep -i "waiting.*retry" err &&
>
> test_grep can be helpful when reading the output of test failures, since
> it dumps the contents of the file it was searching. Just make sure to
> write "test_grep !" instead of "! test_grep" (there are a few such
> instances of the latter that I just wrote patches to clean up).
>
> "! test_grep" isn't *wrong* per-se, but it will pollute the test output
> with "couldn't find xyz in abc".
>
> I skimmed through the the remainder of the tests since I imagine that
> they will change substantially after writing the script out explicitly
> instead of using one-time-script, so I'll hold off on reviewing that
> portion in more detail until then.
>
> Thanks,
> Taylor
