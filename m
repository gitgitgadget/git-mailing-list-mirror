Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05B9C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLNXRZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiLNXRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:17:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E471396D4
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:17:13 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 17so5089890pll.0
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxWAuu+Zyem9GlPX1D2XcwCf5ee/B14G0tKI0u6dytg=;
        b=M4UUI2OE58fdcCs322Wims44ntyXgcPpMRgWXEW44euk993How8EH0/9zHcEE7NxdL
         NB8hzo3ALNsKJR6p0cN5aWI8q+cZ0BR7pzGyxa3D6pVPVJJWeBYbfffGK+88MtZGYfs7
         5tjbQfvcRHLaj07uWtpthq8ktkn6i6v/g7FDpQHy6I4j3I0umHM1AOnGJ+AqUKAc2/Pk
         m3jzIwQ99GoP/BEx5X0jQJIlU9tMFxMZxWPf/eI8VKlr6P6HWX6Q9eroO39AidylNPXL
         s5xG5h0QcHbY4Xe1rLRSqOTA9tX1+iJsmutYpuGOywyxD11qUQEui6R02VmgJ/6/sZK2
         CSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nxWAuu+Zyem9GlPX1D2XcwCf5ee/B14G0tKI0u6dytg=;
        b=0Yd1Hq0i+P2R/apYis1ka2yBnajc041fhKgz20jlIECSqZB9eMVyGOUqrE1BrR8Lpo
         q6CHhApvtm2q5ZoGQr+UJ+ADqTyilvuTaUsT/uLU9FyfktpsxOfyI4C5cCS/H4YBPqCy
         SUnhIxyTu+WVoeEIF2v+Onss4m8P0OMTvLUnNZwT3Wp6TecFhy6R4DVzHKvNN+5UOFzq
         sFGUJ6W1m5AOjavoyzIIAZxuvfI4MMHnPGdYmazT3onm1j6zJCeYprOyi529Z3BoJ6M/
         UCWru5z0w+BSv9FGYayaY6FgjNUZlrbbMdoATyFxKQCYURQaOjxmpbk1sf7e1E4vtNWR
         2plw==
X-Gm-Message-State: ANoB5pmD4SuDFEZkXOyCff5oxVR3ZU45tRc57BZPJFg7BB1lL82vUrjA
        9d+9CPGd9rs/941gSAlHb8TB
X-Google-Smtp-Source: AA0mqf668B0chOBDjLUOaPGiQ55yY8hCx/bN2rbhnzOZ0ec9lyDiWdA4SOg0IG0oIaBmF2jv7SF2Aw==
X-Received: by 2002:a17:90a:bb15:b0:20d:bd61:b531 with SMTP id u21-20020a17090abb1500b0020dbd61b531mr26207438pjr.37.1671059832708;
        Wed, 14 Dec 2022 15:17:12 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id gx13-20020a17090b124d00b00219e38b42f5sm1905612pjb.26.2022.12.14.15.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:17:12 -0800 (PST)
Message-ID: <7b7d1059-cecf-744d-6927-b41963b9e5a8@github.com>
Date:   Wed, 14 Dec 2022 15:17:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 4/8] test-http-server: add HTTP error response function
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <98dd286db7c95b6401167c4a9b5e2336843d2629.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <98dd286db7c95b6401167c4a9b5e2336843d2629.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> +static enum worker_result send_http_error(
> +	int fd,
> +	int http_code, const char *http_code_name,
> +	int retry_after_seconds, struct string_list *response_headers,
> +	enum worker_result wr_in)
> +{
> +	struct strbuf response_header = STRBUF_INIT;
> +	struct strbuf response_content = STRBUF_INIT;
> +	struct string_list_item *h;
> +	enum worker_result wr;
> +
> +	strbuf_addf(&response_content, "Error: %d %s\r\n",
> +		    http_code, http_code_name);
> +	if (retry_after_seconds > 0)
> +		strbuf_addf(&response_content, "Retry-After: %d\r\n",
> +			    retry_after_seconds);
> +
> +	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
> +	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
> +	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
> +	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
> +	if (retry_after_seconds > 0)
> +		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
> +	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
> +	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
> +	if (response_headers)
> +		for_each_string_list_item(h, response_headers)
> +			strbuf_addf(&response_header, "%s\r\n", h->string);
> +	strbuf_addstr(&response_header, "\r\n");
> +
> +	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
> +		logerror("unable to write response header");
> +		wr = WR_IO_ERROR;
> +		goto done;
> +	}
> +
> +	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
> +		logerror("unable to write response content body");
> +		wr = WR_IO_ERROR;
> +		goto done;
> +	}
> +
> +	wr = wr_in;

By setting this here, if there's a 'goto done' added sometime in the future
that doesn't explicitly set 'wr' first, it'll trigger a compiler error.
That's good for a case like this, where we don't want to assume a "default"
for 'wr' before handling it.

> +
> +done:
> +	strbuf_release(&response_header);
> +	strbuf_release(&response_content);
> +
> +	return wr;
> +}
> +
>  static enum worker_result worker(void)
>  {
> -	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
>  	char *client_addr = getenv("REMOTE_ADDR");
>  	char *client_port = getenv("REMOTE_PORT");
>  	enum worker_result wr = WR_OK;
> @@ -110,11 +160,8 @@ static enum worker_result worker(void)
>  	set_keep_alive(0);
>  
>  	while (1) {
> -		if (write_in_full(1, response, strlen(response)) < 0) {
> -			logerror("unable to write response");
> -			wr = WR_IO_ERROR;
> -		}
> -
> +		wr = send_http_error(1, 501, "Not Implemented", -1, NULL,
> +			WR_OK | WR_HANGUP);

This is a nice incremental improvement on the original hardcoded response.

>  		if (wr & WR_STOP_THE_MUSIC)
>  			break;
>  	}

