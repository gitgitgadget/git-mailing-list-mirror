Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA24171096
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863913; cv=none; b=kratzGTnqqc3AVkh1IWClzKFQqfX3lDqtt1DPlJyBLoAAfQD+dYYhApqnKG+hCKQht87tSIXTqmcKLw9xmgloRbPEgagbDaKjtTXc0Ob44yJSSsH6suJampNRTQgMSAzuunnC9UA/K9t4QNbCY8dfJFBnXzXDemZxR/8S0I6pUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863913; c=relaxed/simple;
	bh=qxywq5x+uHNH1x9T8wcQm4W9BfSzxVwF0aUrmx9P7ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pwb/eDJ+efMQHzcFgVhWK4uP0eRnJbsN1YtvRtk4bj5O+Rb8QaNlozHZkRcuMaZKQlpxn6UnGnYWoMvxjfjDkCxTbkoLIFRaphO+ZpVTh+OuYTcOudZ+v/geUcP0dQjShUibQGTkSbqxYaFGOvfmxPzUGTfuBkXKJQ/swfcOnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2VbAK0p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2VbAK0p"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1faad2f1967so33594095ad.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863910; x=1720468710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ob8NQf37Z74n5eDm7x/8NJNtMhfzBzvr09vSqG7TIk=;
        b=c2VbAK0ppnKSqyAfuiVU//S5c/KTSa1kB1ceb4W2SC2ec4i04qAed1JbMJcRVdqDUE
         2DuMz3Ctc/maZ+eII75vvZNoSf6ojBZ+WkEyGqraK43VTKuMOQZoTYfWKckodWSP7XGt
         LSKVBneUhuAnMXZ+sTZh4sNy2qoPJ1oP9igqMeLFmJU84x/aqiSMWF/WW/LXamUXMwTj
         hrNSaJNOCiTcN6sG60IqLCiPoYx6ZV8g90+VMkdhREkHBh+Nty5f+HkiZqIaf34e6xx1
         kApXlPC5f8OB1umY6/D/OPdm0xbVdKhXxn0b+K8X6suoNoBPevMBxNr+cYKPqDLYl7r9
         ibWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863910; x=1720468710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ob8NQf37Z74n5eDm7x/8NJNtMhfzBzvr09vSqG7TIk=;
        b=Bx3yyiaChMePrHLwsyNIuPHeKJ26DusYMkikUDoT21KOUJ94/y5k+gQu5RAAvqBNKA
         3MnnilSXtXY4BgHF9FpgYI17UpPmATtw3K+yt4tLSQFcXeIt8sUnmdX9DPupPMMzNlW5
         FaxtUA1GRqwV7lMhi7vpOHpezY3A3CUDB+SE2Rs5jDLY6ZZBqohWTIwikVSzjnzc3yU0
         x2LCpLWzMzzefTzfCTI/MHFDz//zwpDMuz64IOPpXRTK8hq5Qn8Mv0v3ZEQP48AnP8Gb
         6JQw3lg0GGV21pXG/odYYbBMXUYFtPqk2YTxNR0oIEQ+DG5RNzcfQxzpq5VZyUVoRksQ
         wqdg==
X-Gm-Message-State: AOJu0Yy4zo0e0cejrAIL2v5bQ5PsG8oszrEiD/Vc8CRzdllVuTcgLgf5
	C7bfQ4OGSVDi+O/GHvOgI0Zjh58sSq0W+FfIYXGau1uMlVxSCU7JYEp8QEvP6w==
X-Google-Smtp-Source: AGHT+IHxZ1W9dI/0sGlcbwYcqMa0Mra+t/pFY4lWqjJ6MAR1UnfMNWlC5P3Hc3v8f9RkZK56zR8ArA==
X-Received: by 2002:a17:902:da89:b0:1f9:c52f:d9a6 with SMTP id d9443c01a7336-1fac7e27ea6mr168666205ad.2.1719863909694;
        Mon, 01 Jul 2024 12:58:29 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e464:1819:7745:be03])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3fb9sm69059585ad.96.2024.07.01.12.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:58:28 -0700 (PDT)
Date: Mon, 1 Jul 2024 12:58:24 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
Message-ID: <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Git List <git@vger.kernel.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>

On 2024.06.29 17:47, René Scharfe wrote:
> The macro TEST takes a single expression.  If a test requires multiple
> statements then they need to be placed in a function that's called in
> the TEST expression.  The functions setup() and setup_populated() here
> are used for that purpose and take another function as an argument,
> making the control flow hard to follow.
> 
> Remove the overhead of these functions by using TEST_RUN instead.  Move
> their duplicate post-condition checks into a new helper, t_release(),
> and let t_addch() and t_addstr() accept properly typed input parameters
> instead of void pointers.
> 
> Use the fully checking t_addstr() for adding initial values instead of
> only doing only a length comparison -- there's no need for skipping the
> other checks.
> 
> This results in test cases that look much more like strbuf usage in
> production code, only with checked strbuf functions replaced by checking
> wrappers.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  t/unit-tests/t-strbuf.c | 79 +++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 38 deletions(-)
> 
> diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
> index 6027dafef7..c8e39ddda7 100644
> --- a/t/unit-tests/t-strbuf.c
> +++ b/t/unit-tests/t-strbuf.c
> @@ -1,32 +1,6 @@
>  #include "test-lib.h"
>  #include "strbuf.h"
> 
> -/* wrapper that supplies tests with an empty, initialized strbuf */
> -static void setup(void (*f)(struct strbuf*, const void*),
> -		  const void *data)
> -{
> -	struct strbuf buf = STRBUF_INIT;
> -
> -	f(&buf, data);
> -	strbuf_release(&buf);
> -	check_uint(buf.len, ==, 0);
> -	check_uint(buf.alloc, ==, 0);
> -}
> -
> -/* wrapper that supplies tests with a populated, initialized strbuf */
> -static void setup_populated(void (*f)(struct strbuf*, const void*),
> -			    const char *init_str, const void *data)
> -{
> -	struct strbuf buf = STRBUF_INIT;
> -
> -	strbuf_addstr(&buf, init_str);
> -	check_uint(buf.len, ==, strlen(init_str));
> -	f(&buf, data);
> -	strbuf_release(&buf);
> -	check_uint(buf.len, ==, 0);
> -	check_uint(buf.alloc, ==, 0);
> -}
> -
>  static int assert_sane_strbuf(struct strbuf *buf)
>  {
>  	/* Initialized strbufs should always have a non-NULL buffer */
> @@ -66,10 +40,8 @@ static void t_dynamic_init(void)
>  	strbuf_release(&buf);
>  }
> 
> -static void t_addch(struct strbuf *buf, const void *data)
> +static void t_addch(struct strbuf *buf, int ch)
>  {
> -	const char *p_ch = data;
> -	const char ch = *p_ch;
>  	size_t orig_alloc = buf->alloc;
>  	size_t orig_len = buf->len;
> 
> @@ -85,9 +57,8 @@ static void t_addch(struct strbuf *buf, const void *data)
>  	check_char(buf->buf[buf->len], ==, '\0');
>  }
> 
> -static void t_addstr(struct strbuf *buf, const void *data)
> +static void t_addstr(struct strbuf *buf, const char *text)
>  {
> -	const char *text = data;
>  	size_t len = strlen(text);
>  	size_t orig_alloc = buf->alloc;
>  	size_t orig_len = buf->len;
> @@ -105,18 +76,50 @@ static void t_addstr(struct strbuf *buf, const void *data)
>  	check_str(buf->buf + orig_len, text);
>  }
> 
> +static void t_release(struct strbuf *sb)
> +{
> +	strbuf_release(sb);
> +	check_uint(sb->len, ==, 0);
> +	check_uint(sb->alloc, ==, 0);
> +}
> +
>  int cmd_main(int argc, const char **argv)
>  {
>  	if (!TEST(t_static_init(), "static initialization works"))
>  		test_skip_all("STRBUF_INIT is broken");
>  	TEST(t_dynamic_init(), "dynamic initialization works");

IIUC you're leaving t_static_init() as-is so that we can determine
whether or not to skip the rest of the tests, but is there a reason you
didn't convert t_dynamic_init() here?

> -	TEST(setup(t_addch, "a"), "strbuf_addch adds char");
> -	TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
> -	TEST(setup_populated(t_addch, "initial value", "a"),
> -	     "strbuf_addch appends to initial value");
> -	TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds string");
> -	TEST(setup_populated(t_addstr, "initial value", "hello there"),
> -	     "strbuf_addstr appends string to initial value");
> +
> +	if (TEST_RUN("strbuf_addch adds char")) {
> +		struct strbuf sb = STRBUF_INIT;
> +		t_addch(&sb, 'a');
> +		t_release(&sb);
> +	}
> +
> +	if (TEST_RUN("strbuf_addch adds NUL char")) {
> +		struct strbuf sb = STRBUF_INIT;
> +		t_addch(&sb, '\0');
> +		t_release(&sb);
> +	}
> +
> +	if (TEST_RUN("strbuf_addch appends to initial value")) {
> +		struct strbuf sb = STRBUF_INIT;
> +		t_addstr(&sb, "initial value");
> +		t_addch(&sb, 'a');
> +		t_release(&sb);
> +	}
> +
> +	if (TEST_RUN("strbuf_addstr adds string")) {
> +		struct strbuf sb = STRBUF_INIT;
> +		t_addstr(&sb, "hello there");
> +		t_release(&sb);
> +	}
> +
> +	if (TEST_RUN("strbuf_addstr appends string to initial value")) {
> +		struct strbuf sb = STRBUF_INIT;
> +		t_addstr(&sb, "initial value");
> +		t_addstr(&sb, "hello there");
> +		t_release(&sb);
> +	}
> 
>  	return test_done();
>  }
> --
> 2.45.2

I think this commit in particular shows how TEST_RUN() is more
convenient than TEST(). (Although, arguably we shouldn't have allowed
the setup() + callback situation to start with.)
