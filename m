Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24025C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiIGSUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIGSUf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:20:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259489F8EC
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:20:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b17so8452956wrq.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=31ihJKYqotpiGZUWEMHD1e7J5hK7b4M7wyiAPyoQY/o=;
        b=h9i+tWURPLCLVUZrq4SUBopcDZkmW3XysPtPGY8Ayvrfy+6GcEwFJwRnZhvdNvx2eF
         9ZXogvaUYsd861x9dspo72/RtRnstwUKYczvNSNe7W5k4By9bDIt4o/9k2Pga2brf0/6
         XrpsDWjzQR19jy0KxTj7OF8nI4avysWtDE95NaQzAvsgmxc4JVTAT5ld3UvJDE4a9Y8a
         2Do5A3FzHLyRszffq4ZfojQRRziCsISKiRPvHZ59TTpdRN5BrdFvl9EshXdEkMjpc1nX
         XNBbMhneyhcryZiM4dc14BYjCw5BFWc4lInp8JOl3mYy814rmTg+JPppjCbErpe5W4U8
         +lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=31ihJKYqotpiGZUWEMHD1e7J5hK7b4M7wyiAPyoQY/o=;
        b=vpzZsy1eXVbcMIOZAl2W/Bmc0H15n0iTaKFVkttcWjMP0BhT2SDCBQLUaakY8qqVA/
         ztID0vmCWMbwGyRIWGEjk+fwVVy4DIIkhYJqI6aXUc85cF93Cs96XidOsJNdF2gj0iFd
         OuAHTNx/DabfoHKWSErEkS/4viZu7007cA1UCGir/+60fsm/j5cQeBGD568R43EFnjD9
         FHMK+99x/Hi1T2XVbWsbRtkbgH6cQY6EYgPStm0VguqD25KfZcl6Jpin3DFTKIN3cG2A
         S5RdfcMAXErDtyhMyh4oRY1Nv1lRsO70JsaVXBB+m9IrNEC2HDUOETgQ8VSroeUfyVN3
         no4w==
X-Gm-Message-State: ACgBeo2CrwPfnJugCEi5HALcdF3gcNnlhzmGs0tCRuR/hYzT8hyW4tbi
        GI7VKNfR1ldGQ711e3iEi9WTDAy1Pt71NA==
X-Google-Smtp-Source: AA6agR7H4C+aHPrutk2J2bpHmQ1A5fNqRlgul0+I3F0EG5jkByKBBZWeWlc9MKbgETpiYExC7jNWlA==
X-Received: by 2002:a05:6000:1f1c:b0:228:bea6:f45a with SMTP id bv28-20020a0560001f1c00b00228bea6f45amr3044648wrb.297.1662574832547;
        Wed, 07 Sep 2022 11:20:32 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id m9-20020a05600c4f4900b003a84375d0d1sm29226350wmq.44.2022.09.07.11.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 11:20:32 -0700 (PDT)
Message-ID: <435b2b8b-2577-0af4-6f69-b250f64cbdf8@gmail.com>
Date:   Wed, 7 Sep 2022 19:20:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] patchbreak(), is_scissors_line(): work with a
 buf/len pair
Content-Language: en-US
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, l.s.r@web.de
References: <cover.1662559356.git.matheus.bernardino@usp.br>
 <99012733e440be15afc7fd45272e738c71b3ef27.1662559356.git.matheus.bernardino@usp.br>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <99012733e440be15afc7fd45272e738c71b3ef27.1662559356.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09/2022 15:44, Matheus Tavares wrote:
> From: René Scharfe <l.s.r@web.de>
> 
> The next patch will add calls to these two functions from code that
> works with a char */size_t pair. So let's adapt the functions in
> preparation.

Reading this I wonder if we should add a starts_with_mem() function, 
rather than having to pass pointers to buf and len to skip_prefix_mem().

Best Wishes

Phillip

> ---
>   mailinfo.c | 37 +++++++++++++++++++------------------
>   1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/mailinfo.c b/mailinfo.c
> index 9621ba62a3..f0a690b6e8 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -646,32 +646,30 @@ static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
>   	free(ret);
>   }
>   
> -static inline int patchbreak(const struct strbuf *line)
> +static inline int patchbreak(const char *buf, size_t len)
>   {
> -	size_t i;
> -
>   	/* Beginning of a "diff -" header? */
> -	if (starts_with(line->buf, "diff -"))
> +	if (skip_prefix_mem(buf, len, "diff -", &buf, &len))
>   		return 1;
>   
>   	/* CVS "Index: " line? */
> -	if (starts_with(line->buf, "Index: "))
> +	if (skip_prefix_mem(buf, len, "Index: ", &buf, &len))
>   		return 1;
>   
>   	/*
>   	 * "--- <filename>" starts patches without headers
>   	 * "---<sp>*" is a manual separator
>   	 */
> -	if (line->len < 4)
> +	if (len < 4)
>   		return 0;
>   
> -	if (starts_with(line->buf, "---")) {
> +	if (skip_prefix_mem(buf, len, "---", &buf, &len)) {
>   		/* space followed by a filename? */
> -		if (line->buf[3] == ' ' && !isspace(line->buf[4]))
> +		if (len > 1 && buf[0] == ' ' && !isspace(buf[1]))
>   			return 1;
>   		/* Just whitespace? */
> -		for (i = 3; i < line->len; i++) {
> -			unsigned char c = line->buf[i];
> +		for (; len; buf++, len--) {
> +			unsigned char c = buf[0];
>   			if (c == '\n')
>   				return 1;
>   			if (!isspace(c))
> @@ -682,14 +680,14 @@ static inline int patchbreak(const struct strbuf *line)
>   	return 0;
>   }
>   
> -static int is_scissors_line(const char *line)
> +static int is_scissors_line(const char *line, size_t len)
>   {
>   	const char *c;
>   	int scissors = 0, gap = 0;
>   	const char *first_nonblank = NULL, *last_nonblank = NULL;
>   	int visible, perforation = 0, in_perforation = 0;
>   
> -	for (c = line; *c; c++) {
> +	for (c = line; len; c++, len--) {
>   		if (isspace(*c)) {
>   			if (in_perforation) {
>   				perforation++;
> @@ -705,12 +703,14 @@ static int is_scissors_line(const char *line)
>   			perforation++;
>   			continue;
>   		}
> -		if (starts_with(c, ">8") || starts_with(c, "8<") ||
> -		    starts_with(c, ">%") || starts_with(c, "%<")) {
> +		if (skip_prefix_mem(c, len, ">8", &c, &len) ||
> +		    skip_prefix_mem(c, len, "8<", &c, &len) ||
> +		    skip_prefix_mem(c, len, ">%", &c, &len) ||
> +		    skip_prefix_mem(c, len, "%<", &c, &len)) {
>   			in_perforation = 1;
>   			perforation += 2;
>   			scissors += 2;
> -			c++;
> +			c--, len++;
>   			continue;
>   		}
>   		in_perforation = 0;
> @@ -747,7 +747,8 @@ static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
>   {
>   	if (mi->inbody_header_accum.len &&
>   	    (line->buf[0] == ' ' || line->buf[0] == '\t')) {
> -		if (mi->use_scissors && is_scissors_line(line->buf)) {
> +		if (mi->use_scissors &&
> +		    is_scissors_line(line->buf, line->len)) {
>   			/*
>   			 * This is a scissors line; do not consider this line
>   			 * as a header continuation line.
> @@ -808,7 +809,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>   	if (convert_to_utf8(mi, line, mi->charset.buf))
>   		return 0; /* mi->input_error already set */
>   
> -	if (mi->use_scissors && is_scissors_line(line->buf)) {
> +	if (mi->use_scissors && is_scissors_line(line->buf, line->len)) {
>   		int i;
>   
>   		strbuf_setlen(&mi->log_message, 0);
> @@ -826,7 +827,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
>   		return 0;
>   	}
>   
> -	if (patchbreak(line)) {
> +	if (patchbreak(line->buf, line->len)) {
>   		if (mi->message_id)
>   			strbuf_addf(&mi->log_message,
>   				    "Message-Id: %s\n", mi->message_id);

