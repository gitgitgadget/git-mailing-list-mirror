Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA33EA76
	for <git@vger.kernel.org>; Sat,  4 May 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714836838; cv=none; b=XGKerMR/EUgbe0UC31PGxXwctEEvsWg4Dd/quj7fiYCRmxN4HLutF/ovvjSCJNX13sjUIm6E/BeZJvg0GcANTTqAkGzZWfI4350X+rccjyGl7g4vaMMBFbPHEVgzanFDkeEcnFO7l2wa20MZKCzQMxNZp26rADlchOkqLtlIrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714836838; c=relaxed/simple;
	bh=/BUE9HEJ//d40653jPXj7wzpE5fT4jwbZ6E+05gf6wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Te+r6uZkItN5GPb1PuIQAMvsp8WtajloIyNXzqxiiNSSIsqSNJqihJLl8OKb3YeCbnumv8Fx5Q3pP/LRPxBK/vG2/sSESybesxp45ao4Yiq7yOWNJwFMBtH5wKJuZPqv+ps52RF39zC5zvn5WnIVBUIl/hNTHK8kI5OxcA4WDs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIic+Prk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIic+Prk"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b79451128so4578005e9.0
        for <git@vger.kernel.org>; Sat, 04 May 2024 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714836835; x=1715441635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f2lsOmKJK2oLYlTXx9B0aaXHCl0s9lZbfMX1bOjVOyw=;
        b=UIic+PrkNSqY34IknOOTMrw8Bgcp5166HboR6UWEQ+mCeNv5vHR8oe2zVcX6nIwR37
         JNEEzKhCoYi4EAWiJr5/o8v0US8Ke3YsnktRCuECxA7EHI2AwPW66HpOE67DmGRjtvXp
         eIDJGPM1D10FtUalWAEvVKX4uBAuROLVOrfsBGJT3eSEivrGEjKYIiA99yQWUtV/5ZxW
         vK70sWMVqIXIzsdUOCYbcWmSOi0YGjpqI15MS4VGq0KABfuhO+Mf83YDPZCX63lFz2cD
         Hb6m5X3kH5kLEFDsiWvHl2VbqF/E9XBIt8AtLsVWzIUJYL1WIepSos9+KTYCzQBaDY01
         uMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714836835; x=1715441635;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2lsOmKJK2oLYlTXx9B0aaXHCl0s9lZbfMX1bOjVOyw=;
        b=AFaEKofB8b/HpEuKy2bo8ZHps2QtjERri/yHFU4cGpk23vsRuDoKmTT/uHItL7rw0z
         j2ml7wXP2uW8XNDDm560VIW2f66xQnX1UNjj4ZHyCICANPdg5BNbuBkXeAo0THn25PQa
         yx6RuKKWHTKO/36QpwWGLUuwmb/Z94FEgrG27oeQt2eEIy1TClAs4srih6LuCj/d6Zjr
         aVlV569Zf5gNdZxUc+QN1pND7n0pWXJ1n/MUeF+j9gnEuT5bcdc/H+qzOQ32b8kvd1LC
         5X3krqOhtP6MFvji35a1dikVtZcvBoElNOMK55qKcasO+cwFPPUzQm53H44LxoBR82rw
         y/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4ltQmWzuFULne4+JlO6CwknELM6Qd0qKBA5jQeS4rYl6nhcxdIpTxjF7eRN4nW3A6cs+5U9/zm4iAylVY2v3xZVOD
X-Gm-Message-State: AOJu0Yxr/Kfdur1as4uc/GgBUhvqxMpx8VLuVql/sXqrA9b+lVNbTkyb
	aapO/9QbOBERwZuHpDIJwrNXFALlRZ1KvP9jRit4LRz08eWOUCTG
X-Google-Smtp-Source: AGHT+IEF0JT/t66NizgL1BNpL3EyL13uxVFZ+bQ8KMth6wACp3M2k9NtLpXKD+wtpcAZBkKcIuyzUQ==
X-Received: by 2002:a05:600c:45cd:b0:418:f826:58c3 with SMTP id s13-20020a05600c45cd00b00418f82658c3mr4690091wmo.15.1714836834473;
        Sat, 04 May 2024 08:33:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id n15-20020adff08f000000b00343eac2acc4sm6449681wro.111.2024.05.04.08.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:33:54 -0700 (PDT)
Message-ID: <18343148-80d1-4558-b834-caaf8322467a@gmail.com>
Date: Sat, 4 May 2024 16:33:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 03/10] trailer: teach iterator about non-trailer lines
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
 Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>,
 Josh Steadmon <steadmon@google.com>,
 "Randall S. Becker" <rsbecker@nexbridge.com>,
 Christian Couder <christian.couder@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linus@ucla.edu>,
 Linus Arver <linusa@google.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
 <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
 <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <4aeb48050b14e44ec65cfa651a4d98587a6cd860.1714625668.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus

Sorry I'm late to the party here I've left a couple of thoughts below 
but I don't want to derail this series if everyone else is happy.

On 02/05/2024 05:54, Linus Arver via GitGitGadget wrote:
> From: Linus Arver <linus@ucla.edu>
> 
> Previously the iterator did not iterate over non-trailer lines. This was
> somewhat unfortunate, because trailer blocks could have non-trailer
> lines in them since 146245063e (trailer: allow non-trailers in trailer
> block, 2016-10-21), which was before the iterator was created in
> f0939a0eb1 (trailer: add interface for iterating over commit trailers,
> 2020-09-27).
> 
> So if trailer API users wanted to iterate over all lines in a trailer
> block (including non-trailer lines), they could not use the iterator and
> were forced to use the lower-level trailer_info struct directly (which
> provides a raw string array that includes all lines in the trailer
> block).
> 
> Change the iterator's behavior so that we also iterate over non-trailer
> lines, instead of skipping over them. The new "raw" member of the
> iterator allows API users to access previously inaccessible non-trailer
> lines. Reword the variable "trailer" to just "line" because this
> variable can now hold both trailer lines _and_ non-trailer lines.
> 
> The new "raw" member is important because anyone currently not using the
> iterator is using trailer_info's raw string array directly to access
> lines to check what the combined key + value looks like. If we didn't
> provide a "raw" member here, iterator users would have to re-construct
> the unparsed line by concatenating the key and value back together again
> --- which places an undue burden for iterator users.

Comparing the raw line is error prone as it ignores custom separators 
and variations in the amount of space between the key and the value. 
Therefore I'd argue that the sequencer should in fact be comparing the 
trailer key and value separately rather than comparing the whole line. 
There is an issue that we want to add a new Signed-off-by: trailer for 
"C.O. Mitter" when the trailers look like

	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>
	non-trailer-line

but not when they look like

	Signed-off-by: C.O. Mitter <c.o.mitter@example.com>

so we still need some way of indicating that there was a non-trailer 
line after the last trailer though.

> The next commit demonstrates the use of the iterator in sequencer.c as an
> example of where "raw" will be useful, so that it can start using the
> iterator.
> 
> For the existing use of the iterator in builtin/shortlog.c, we don't
> have to change the code there because that code does

An interface that lets the caller pass a flag if they want to know about 
non-trailer lines might be easier to use for the callers that don't want 
to worry about such lines and wouldn't need a justification as to why it 
was safe for existing callers.

Best Wishes

Phillip

>      trailer_iterator_init(&iter, body);
>      while (trailer_iterator_advance(&iter)) {
>          const char *value = iter.val.buf;
> 
>          if (!string_list_has_string(&log->trailers, iter.key.buf))
>              continue;
> 
>          ...
> 
> and the
> 
>          if (!string_list_has_string(&log->trailers, iter.key.buf))
> 
> condition already skips over non-trailer lines (iter.key.buf is empty
> for non-trailer lines, making the comparison still work even with this
> commit).
> 
> Rename "num_expected_trailers" to "num_expected" in
> t/unit-tests/t-trailer.c because the items we iterate over now include
> non-trailer lines.
> 
> Signed-off-by: Linus Arver <linus@ucla.edu>
> ---
>   t/unit-tests/t-trailer.c | 16 +++++++++++-----
>   trailer.c                | 12 +++++-------
>   trailer.h                |  7 +++++++
>   3 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
> index c1f897235c7..4f640d2a4b8 100644
> --- a/t/unit-tests/t-trailer.c
> +++ b/t/unit-tests/t-trailer.c
> @@ -1,7 +1,7 @@
>   #include "test-lib.h"
>   #include "trailer.h"
>   
> -static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
> +static void t_trailer_iterator(const char *msg, size_t num_expected)
>   {
>   	struct trailer_iterator iter;
>   	size_t i = 0;
> @@ -11,7 +11,7 @@ static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
>   		i++;
>   	trailer_iterator_release(&iter);
>   
> -	check_uint(i, ==, num_expected_trailers);
> +	check_uint(i, ==, num_expected);
>   }
>   
>   static void run_t_trailer_iterator(void)
> @@ -19,7 +19,7 @@ static void run_t_trailer_iterator(void)
>   	static struct test_cases {
>   		const char *name;
>   		const char *msg;
> -		size_t num_expected_trailers;
> +		size_t num_expected;
>   	} tc[] = {
>   		{
>   			"empty input",
> @@ -119,7 +119,13 @@ static void run_t_trailer_iterator(void)
>   			"not a trailer line\n"
>   			"not a trailer line\n"
>   			"Signed-off-by: x\n",
> -			1
> +			/*
> +			 * Even though there is only really 1 real "trailer"
> +			 * (Signed-off-by), we still have 4 trailer objects
> +			 * because we still want to iterate through the entire
> +			 * block.
> +			 */
> +			4
>   		},
>   		{
>   			"with non-trailer lines (one too many) in trailer block",
> @@ -162,7 +168,7 @@ static void run_t_trailer_iterator(void)
>   
>   	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
>   		TEST(t_trailer_iterator(tc[i].msg,
> -					tc[i].num_expected_trailers),
> +					tc[i].num_expected),
>   		     "%s", tc[i].name);
>   	}
>   }
> diff --git a/trailer.c b/trailer.c
> index 3e4dab9c065..4700c441442 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -1146,17 +1146,15 @@ void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
>   
>   int trailer_iterator_advance(struct trailer_iterator *iter)
>   {
> -	while (iter->internal.cur < iter->internal.info.trailer_nr) {
> -		char *trailer = iter->internal.info.trailers[iter->internal.cur++];
> -		int separator_pos = find_separator(trailer, separators);
> -
> -		if (separator_pos < 1)
> -			continue; /* not a real trailer */
> +	if (iter->internal.cur < iter->internal.info.trailer_nr) {
> +		char *line = iter->internal.info.trailers[iter->internal.cur++];
> +		int separator_pos = find_separator(line, separators);
>   
> +		iter->raw = line;
>   		strbuf_reset(&iter->key);
>   		strbuf_reset(&iter->val);
>   		parse_trailer(&iter->key, &iter->val, NULL,
> -			      trailer, separator_pos);
> +			      line, separator_pos);
>   		/* Always unfold values during iteration. */
>   		unfold_value(&iter->val);
>   		return 1;
> diff --git a/trailer.h b/trailer.h
> index 9f42aa75994..7e36da7d13c 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -125,6 +125,13 @@ void format_trailers_from_commit(const struct process_trailer_options *,
>    *   trailer_iterator_release(&iter);
>    */
>   struct trailer_iterator {
> +	/*
> +	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
> +	 * key/val pair as part of a trailer block (as the "key" and "val"
> +	 * fields below). If a line fails to parse as a trailer, then the "key"
> +	 * will be the entire line and "val" will be the empty string.
> +	 */
> +	const char *raw;
>   	struct strbuf key;
>   	struct strbuf val;
>   
