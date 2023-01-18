Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E1C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 11:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjARL6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 06:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjARL62 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 06:58:28 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702570C66
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:14:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bk15so24865268ejb.9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EImMrqWs+hM/QdYadoZm8Qc1+AsYdJg95wgGZKYodjA=;
        b=D+YvslS2Mpm/V7WH++IdOiVSqhoRHYVLYRpEZOKeS4RV+lMCF9Cvw525356w1Q3r3h
         qul8OM/CfRw0EV73tP8NwKmMZijTHt95tnhkjdUyDVAN44TFttjUq3/fAONcYYh2zFPm
         aSTzytj+pgYIrtw5DKAO4WY5120nCf46y4itZVxNfZ4Miw2MQ0S0w3UdQraRZbIQrSm1
         l18F5dHRES3z5ooHPfSnob7/wtLLVmgxkIjiP8eohy2+pLt4eSd36HghihXOdxnFn7OL
         GSxei3Xs2jfKbhOaV7D86bOeObpuiLfhxx3PLrup3EazCYb5KrtJuIviIa3ni24+sCgK
         CXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EImMrqWs+hM/QdYadoZm8Qc1+AsYdJg95wgGZKYodjA=;
        b=52JtRVE0epekn3V8za97Rff5xoQul9iyIATURY9f2Je9WXL281v1KhnsY2zqiJUbaa
         hEHm4Uzt3vG17EybzAgdU6QsdYhTrorI9O/8XXJ54X2tCAmGRxzHUtZGRpqOessgN+9T
         g/k2G9IdYKzWSCGmyWdPH6FAbQ3E4IRp6YauWcTgOu2+6HsRj3szE+aqppF6Slb7WGiA
         Ma2/4dX75vndOGIynFDw18IreNPxnZog15shjymcBBDOgqyTgSZ792W/wgfot3pzH3L1
         C9uGEyKhRiLTZXkbuBj7PJpgXhswADQbxENk/4mlnJlhsMJsZzSPqEMTqPIt62H0lbXh
         slEQ==
X-Gm-Message-State: AFqh2ko51Tt3Eo96y1RevRcukA3kJYE6aoy9LfQ7WpxtSAryDq1fAgPl
        MTvkOVAxtZABe3QcPfPTJyzEHS83nfhXBQ==
X-Google-Smtp-Source: AMrXdXv8NH1UtlMC63IawYQjiJbjpmDL9kEzYGZ80/sMfgRyVQD/BEwdspY0vPEMkAJ7bSQRglqKFw==
X-Received: by 2002:a17:906:94d0:b0:7c4:f0b5:fedc with SMTP id d16-20020a17090694d000b007c4f0b5fedcmr6832848ejy.65.1674040485189;
        Wed, 18 Jan 2023 03:14:45 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090630c300b007c0f90a9cc5sm14522170ejb.105.2023.01.18.03.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:14:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI6Ox-002nvo-0I;
        Wed, 18 Jan 2023 12:14:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v6 05/12] test-http-server: add HTTP error response
 function
Date:   Wed, 18 Jan 2023 12:07:52 +0100
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <79805f042b984bb8ca7c9aaf6a15f8101037c375.1674012618.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <79805f042b984bb8ca7c9aaf6a15f8101037c375.1674012618.git.gitgitgadget@gmail.com>
Message-ID: <230118.86fsc8xffg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Introduce a function to the test-http-server test helper to write more
> full and valid HTTP error responses, including all the standard response
> headers like `Server` and `Date`.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  t/helper/test-http-server.c | 58 +++++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 5 deletions(-)
>
> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
> index 11071b1dd89..6cdac223a55 100644
> --- a/t/helper/test-http-server.c
> +++ b/t/helper/test-http-server.c
> @@ -83,9 +83,59 @@ enum worker_result {
>  	WR_HANGUP   = 1<<1,
>  };

...okey, this is the commit that makes use of WR_HANGUP. Whatever else
we do, let's then squash that addition into this change.

> +static enum worker_result send_http_error(
> +	int fd,
> +	int http_code, const char *http_code_name,
> +	int retry_after_seconds, struct string_list *response_headers,
> +	enum worker_result wr_in)

In general in this series you are mis-indenting argument lists. Our
usual style is to wrap at 79 characters, then to align (with tabs and
spaces) with the "(".

So in this case:

static enum worker_result send_http_error(int fd, int http_code,
					  const char *http_code_name,
					  int retry_after_seconds,
					  struct string_list *response_headers,
					  enum worker_result wr_in)

> +{
> +	struct strbuf response_header = STRBUF_INIT;
> +	struct strbuf response_content = STRBUF_INIT;
> +	struct string_list_item *h;
> +	enum worker_result wr;
> +
> +	strbuf_addf(&response_content, "Error: %d %s\r\n",
> +		    http_code, http_code_name);


Ditto here, where "http_code" should go on the preceding line...

> +	if (retry_after_seconds > 0)
> +		strbuf_addf(&response_content, "Retry-After: %d\r\n",
> +			    retry_after_seconds);
> +
> +	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);

...and here there's a lack of such wrapping...

> +	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
> +	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
> +	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
> +	if (retry_after_seconds > 0)
> +		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
> +	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
> +	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));

...here you're adding strange whitespace at the start of an argument list...

> +	if (response_headers)
> +		for_each_string_list_item(h, response_headers)
> +			strbuf_addf(&response_header, "%s\r\n", h->string);
> +	strbuf_addstr(&response_header, "\r\n");

To comment on the code a bit, this whole thing would be more readable
IMO if your own headers were also a "struct string_list". Yes we'd waste
a bit more memory, but in this case that's fine..

I.e. don't add the "\r\n" every time, just:

	string_list_append(&headers, "Cache-Control: private");

etc.

Then at the end you'd do e.g.:

	add_headers(&buf, &headers);
	if (response_headers)
		add_headers(&buf, response_headers);

Where the add_headers() is a trivial "static" helper which does that
for_each_string_list_item() loop above.

>  	while (1) {
> -		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
> -			logerror("unable to write response");
> -			wr = WR_IO_ERROR;
> -		}
> +		wr = send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1,
> +				     NULL, WR_OK | WR_HANGUP);

This *does* use correct wrapping & indenation for a continuing argument
list.
