Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7D5C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 03:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLPDgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 22:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiLPDgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 22:36:20 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7520F60
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 19:36:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso1153841pjh.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 19:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NW+RuuE4i41pMNSs0Q3JLlFzD3PRpadeGB+AfmHYtb8=;
        b=dHRYM/jwe6nrb4kb3MQ9lAXRMlRNJQ4E0rnqQwyBUvb+UoonhYHtatNTFsHz4aPuQR
         4m0xWyDaaMwkI9xyoZg8031qDZnoJ0EHCx0gt7ci6y587Rjko6o88MByiRBs9zvs55lG
         1b39L0lpi44aV+r8hBgDiJSLs4urozH0H0GeFPhr3FjJo2uZ7yoqZUiOoM1jTzITbK52
         iXrvV2kAgjTqiCC5LuNYFq61SnZBRHE0FYZHH4Qv+FbxNdMV90tM5DRnz1MeVOodpkvg
         vXkR56LJMLK276fwK9nZgQsPHzFOdYaRQoF7F1/4QFGXYuE8OrZAyyFaFglMWxOcUW5T
         0zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NW+RuuE4i41pMNSs0Q3JLlFzD3PRpadeGB+AfmHYtb8=;
        b=QThuUPDpMcsFm+iMEmXB16kCfrpFob+l9Na5/FrfuvMZ6Oloivl+RXFW+7UsMzksNH
         FI9U76Hm4zqAzVjozS/w0x3xBtZYSPVDAqqhi1Fh1xRdF8gUbe8+kbPiZ8YkPeq7d8Xg
         ampSk0b1irjgh9OvQCpmIQU8/2BvNY1/djrk1VRnla9GnJn0FJchB+kNNYNXffZM62Lu
         ypGKwdwMQKsxOPCwWZUPrN9Uh/zFNTQnVjzaVtqFDy6yxRYb/ZQpXBeYv7oX7JUITbok
         UU1SEmJE9rOzM2GO+5nGYFtkCSQcBlc9ZpKgTx28+Z1ZhJtfVo+HIlLuUZfiqshqOEeH
         UHRQ==
X-Gm-Message-State: ANoB5pklog1qhpIgikufqL0SCOJF2BJwVSMqJFn/qbnIPb+tcs4q5Ibu
        0h43tAvXmb1FP7t4hz6c/QCRTUJBFXw3ew==
X-Google-Smtp-Source: AA0mqf58oyn9kZ0NTsbKbbfdyJDeBIsDuY/D493ZtAvSOGOkTD1cbTqzf0gD+bPMfa1Vxh819Ocxzw==
X-Received: by 2002:a17:90a:a00f:b0:220:bad8:b4e7 with SMTP id q15-20020a17090aa00f00b00220bad8b4e7mr24714823pjp.7.1671161778363;
        Thu, 15 Dec 2022 19:36:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l32-20020a635b60000000b004351358f056sm428943pgm.85.2022.12.15.19.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 19:36:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] git: edit variable types to match what is assigned to them
References: <pull.1399.git.git.1671157765711.gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 12:36:17 +0900
In-Reply-To: <pull.1399.git.git.1671157765711.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Fri, 16 Dec 2022 02:29:25 +0000")
Message-ID: <xmqqa63onhou.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/add-interactive.c b/add-interactive.c
> index ae1839c04a7..59ac88f8b5a 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -469,7 +469,7 @@ static void collect_changes_cb(struct diff_queue_struct *q,
>  
>  	for (i = 0; i < stat.nr; i++) {
>  		const char *name = stat.files[i]->name;
> -		int hash = strhash(name);
> +		unsigned int hash = strhash(name);
>  		struct pathname_entry *entry;
>  		struct file_item *file_item;
>  		struct adddel *adddel, *other_adddel;

This is unquestionably correct.  strhash() returns unsigned, and
hash is passed to hashmap functions that expect unsigned.

> diff --git a/apply.c b/apply.c
> index bc338143134..ee5dcdb9133 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -443,7 +443,7 @@ static int name_terminate(int c, int terminate)
>  /* remove double slashes to make --index work with such filenames */
>  static char *squash_slash(char *name)
>  {
> -	int i = 0, j = 0;
> +	size_t i = 0, j = 0;
>  
>  	if (!name)
>  		return NULL;

These pointers are used to iterate over the same array from the
beginning to the end, so size_t is very much appropriate.

> @@ -654,7 +654,7 @@ static char *find_name_common(struct strbuf *root,
>  			      const char *end,
>  			      int terminate)
>  {
> -	int len;
> +	size_t len;
>  	const char *start = NULL;
>  
>  	if (p_value == 0)
> @@ -685,13 +685,13 @@ static char *find_name_common(struct strbuf *root,
>  	 * or "file~").
>  	 */
>  	if (def) {
> -		int deflen = strlen(def);
> +		size_t deflen = strlen(def);
>  		if (deflen < len && !strncmp(start, def, deflen))
>  			return squash_slash(xstrdup(def));
>  	}

The above look sensible as these two variables are to hold the
result from strlen().

>  	if (root->len) {
> -		char *ret = xstrfmt("%s%.*s", root->buf, len, start);
> +		char *ret = xstrfmt("%s%.*s", root->buf, (int)len, start);

This rewrite is correct, but having to do this makes the careful use
of (potentially larger) size_t more or less a moot point.  If the
length does not fit in "int", the returned pathname would not have
the correct contents.

> @@ -790,7 +790,7 @@ static int has_epoch_timestamp(const char *nameline)
>  	const char *timestamp = NULL, *cp, *colon;
>  	static regex_t *stamp;
>  	regmatch_t m[10];
> -	int zoneoffset, epoch_hour, hour, minute;
> +	long zoneoffset, epoch_hour, hour, minute;
>  	int status;

This are not wrong per-se, but is not necessary.

We use strtol() at the beginning of a string to read into hour, but
we clamp the source digit string with regexp that begins with
"^[0-2][0-9]:([0-5][0-9]):00(\\.0+)?" so unless your int is so small
that it cannot hold 29, the code should be safe.  The same holds for
the minute.  The latter part of the same regexp clamps the zone
offset in a similar fashion and we won't feed a string longer than 4
decimal digits to strtol() to read the zone offset.

> @@ -1083,7 +1083,7 @@ static int gitdiff_index(struct gitdiff_data *state,
>  	 * and optional space with octal mode.
>  	 */
>  	const char *ptr, *eol;
> -	int len;
> +	size_t len;
>  	const unsigned hexsz = the_hash_algo->hexsz;

Absolutely correct.  The variable is used to hold a ptrdiff and is
used to count number of bytes memcpy() should copy.

> @@ -2172,9 +2172,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
>  				"Files ",
>  				NULL,
>  			};
> -			int i;
> +			size_t i;
>  			for (i = 0; binhdr[i]; i++) {
> -				int len = strlen(binhdr[i]);
> +				size_t len = strlen(binhdr[i]);
>  				if (len < size - hd &&
>  				    !memcmp(binhdr[i], buffer + hd, len)) {
>  					state->linenr++;

OK.  But I think there are bigger fish in the same function to fry
around hdrsize and find_header(), both of which may want to become
size_t (I didn't look too carefully, though).

> diff --git a/base85.c b/base85.c
> index 5ca601ee14f..ad32ba1411a 100644
> --- a/base85.c
> +++ b/base85.c
> @@ -37,14 +37,15 @@ static void prep_base85(void)
>  	}
>  }
>  
> -int decode_85(char *dst, const char *buffer, int len)
> +int decode_85(char *dst, const char *buffer, size_t len)
>  {
>  	prep_base85();
>  
> -	say2("decode 85 <%.*s>", len / 4 * 5, buffer);
> +	say2("decode 85 <%.*s>", (int)(len / 4 * 5), buffer);
>  	while (len) {
>  		unsigned acc = 0;
> -		int de, cnt = 4;
> +		int de;
> +		size_t cnt = 4;
>  		unsigned char ch;
>  		do {
>  			ch = *buffer++;

Correct.  The debug-only bits around say2() spoils the careful
debugging the same way as the "len" in find_name_common() we saw
earlier, though

I'd stop here for now.

Thanks.
