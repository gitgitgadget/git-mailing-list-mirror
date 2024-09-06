Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBA11C7B8E
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613629; cv=none; b=q1wghJpCj+EYAkkvD3JquherUcIgJCkgU8j6XtTyAwisJrF8Jyt/5BYIwrdSM81G3hBlQuzWIMMUMJJzrV93wAB8v+1AUYv9CxwvDS642S33kNDG+nxWB89V7e6Q8wiqT7crCnaeuXgpP0JwhRPLMQpMbYUEc2pZ/fKlsY0ONiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613629; c=relaxed/simple;
	bh=R6CnV+MzKF27qjMgEIhBoB2EoqPpFlIlTF6Ewh4Atuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L9P+2i49zNmy3R6p8XExIxuO079SlU+kqqTTYn65iXzWC20vfwTJC3tMJTX84y6nld8XHM02uUe2Aim2vx60kbE8DYcRFe+JXUQS94zcSd0mg+FBpbkM4ye+UZKHWSu0I0y7vd/4d4zTxlO+dwh8rJ9eQhUYUW1jrJE2tNt2zpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kegbS8a+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kegbS8a+"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a869f6ce2b9so230576466b.2
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725613626; x=1726218426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oyuNmn+CRAKXE0tRvTcglQen5M2OqS6q5wTmXIxul7o=;
        b=kegbS8a+Hgxsz6UcOVGZfIUNsK1mCt9I15UaUBm6ZzxhevARxPFzXIQlbihPZtKNnZ
         xAIXZXy4WjeaSZ6ApkD+fRA56N5HcZRGz1zf9RemkOYK9zfBFQBKNtHClyqn54y4eiOM
         c3P/t7CTmmbHmJNeLju59BuqBzjaa+vFtrgKnj9NXp2/hEMQLY1+ssrrd/RNWNY8WDcd
         ZLN1VM8MzcqIOP0LldyGi3v5c1sAqMwcHTjku60hqUnntym7Lm+Zy7j0HhAEie58ZiRY
         EyMTgimE4i4MVuvieUm6Lb8IxoPHpfeENP+BT9KrgnXI/Y9V66Bk2F1pNFJzmUcO6V9l
         Hzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613626; x=1726218426;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyuNmn+CRAKXE0tRvTcglQen5M2OqS6q5wTmXIxul7o=;
        b=unV4+aV0GyimNQ+Xq09ri5zYpI0N7h2oFaeXqUmPdi27mD7ImvV6v0sTksFiZXUc7o
         3VMH+DTGRTC1pmJSdfakAGIKSGOezqxX/0oB9km8bj9UJbptl9Jqnp2ZY7+qw1TfERdl
         OcOn4fnwoPlDUAc+2a+Bv2V3WqfS3QuIQ+gAMDsXFOYZUbrp5LNFIAWhO+FK9KsSE8Nr
         B7xTttjZ4sd5opBnQ846d9pC8aHZImaTKrcjcrLo5+5yzW9R1LXK/GRbrWhQbpHaT94V
         +rbS8OlqsH4S6psba0uD8/eYw9pqlXHDN/2iFm/zbDDRU0UYwWljmfi3ngA+0moXLoRs
         jFng==
X-Forwarded-Encrypted: i=1; AJvYcCVuWRBTJZe+fo4YOEIxgd4zFqAS1sx8OHzHtyltfKjegdaJeejaRjML0L06Lm8+FXlQNOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkDWIhDiYWM9mME0wq9UwYMS9btL/u91D25qxqNYerpuEef6D
	LOTCI/hY0EB/5YfB5/dV96B6UGmzGQ+qGQJGJOmIsqScHRsZk0Kt
X-Google-Smtp-Source: AGHT+IFsipqkXr5Rl0a2wdHwjdaSULJ6ajIquhWXal7FkhyiMEtm3N1PKeTJMh5x79IEKcWMzUuU/w==
X-Received: by 2002:a17:907:3a96:b0:a8b:154b:7649 with SMTP id a640c23a62f3a-a8b154b790dmr33856366b.15.1725613624766;
        Fri, 06 Sep 2024 02:07:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a70ebd7c9sm190306766b.55.2024.09.06.02.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 02:07:04 -0700 (PDT)
Message-ID: <fab48d5b-4808-439e-9384-ca4861b95edc@gmail.com>
Date: Fri, 6 Sep 2024 10:07:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] interpret-trailers: handle message without trailing
 newline
To: Brian Lyles <brianmlyles@gmail.com>, git@vger.kernel.org
References: <20240905173445.1677704-1-brianmlyles@gmail.com>
 <20240906041326.1684570-1-brianmlyles@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240906041326.1684570-1-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

On 06/09/2024 05:08, Brian Lyles wrote:
> When git-interpret-trailers is used to add a trailer to a message that
> does not end in a trailing newline, the new trailer is added on the line
> immediately following the message instead of as a trailer block
> separated from the message by a blank line.
> 
> For example, if a message's text was exactly "The subject" with no
> trailing newline present, `git interpret-trailers --trailer
> my-trailer=true` will result in the following malformed commit message:
> 
>      The subject
>      my-trailer: true
> 
> While it is generally expected that a commit message should end with a
> newline character, git-interpret-trailers should not be returning an
> invalid message in this case.
> 
> Detect when a message exists but does not end with a newline character,
> and add an extra newline before appending the new trailer.

Thanks for the comprehensive commit message. If the problem only affects
"git interpret-trailers" I wonder if it would be simpler to do

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 1d969494cf..e6f22459f1 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -132,6 +132,7 @@ static void read_input_file(struct strbuf *sb, const char *file)
                  if (strbuf_read(sb, fileno(stdin), 0) < 0)
                          die_errno(_("could not read from stdin"));
          }
+        strbuf_complete_line(sb);
  }
  
  static void interpret_trailers(const struct process_trailer_options *opts,

So that we feed the trailer machinery a message with a trailing new line.
Thanks for adding some tests, I've left one small comment below.

> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> index 1d969494cf..9d8f94341d 100644
> --- a/builtin/interpret-trailers.c
> +++ b/builtin/interpret-trailers.c
> @@ -153,13 +153,15 @@ static void interpret_trailers(const struct process_trailer_options *opts,
> 
>   	info = parse_trailers(opts, sb.buf, &head);
> 
> -	/* Print the lines before the trailers */
> -	if (!opts->only_trailers)
> +	if (!opts->only_trailers) {
> +		/* Print the lines before the trailers */
>   		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
> 
> -	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
> -		fprintf(outfile, "\n");
> -
> +		if (message_without_trailing_newline_before_trailer_block(info))
> +			fprintf(outfile, "\n\n");
> +		else if (!blank_line_before_trailer_block(info))
> +			fprintf(outfile, "\n");
> +	}
> 
>   	if (!opts->only_input) {
>   		LIST_HEAD(config_head);
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 3d3e13ccf8..d5303c3f74 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -175,6 +175,46 @@ test_expect_success 'with only a title in the message' '
>   	test_cmp expected actual
>   '
> 
> +test_expect_success 'with a bodiless message that lacks a trailing newline after the subject' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change" | \

There is no need to add a backslash after the pipe here or in the other tests.

Best Wishes

Phillip

> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
> +		--trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'with a bodied message that lacks a trailing newline after the body' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		details about the change.
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change\n\ndetails about the change." | \
> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
> +		--trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'with a message that lacks a trailing newline after the trailers' '
> +	cat >expected <<-\EOF &&
> +		area: change
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "area: change\n\nReviewed-by: Peff" | \
> +	git interpret-trailers --trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
>   test_expect_success 'with multiline title in the message' '
>   	cat >expected <<-\EOF &&
>   		place of
> diff --git a/trailer.c b/trailer.c
> index 72e5136c73..178adae6ad 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -18,6 +18,12 @@ struct trailer_info {
>   	 */
>   	int blank_line_before_trailer;
> 
> +	/*
> +	 * True if there is a message before the trailer block and it does not
> +	 * end with a trailing newline character.
> +	 */
> +	int message_without_trailing_newline_before_trailer;
> +
>   	/*
>   	 * Offsets to the trailer block start and end positions in the input
>   	 * string. If no trailer block is found, these are both set to the
> @@ -946,6 +952,11 @@ static int ends_with_blank_line(const char *buf, size_t len)
>   	return is_blank_line(buf + ll);
>   }
> 
> +static int has_message_without_trailing_newline_char(const char *buf, size_t len)
> +{
> +	return len > 0 && buf[len - 1] != '\n';
> +}
> +
>   static void unfold_value(struct strbuf *val)
>   {
>   	struct strbuf out = STRBUF_INIT;
> @@ -1017,6 +1028,8 @@ static struct trailer_info *trailer_info_get(const struct process_trailer_option
> 
>   	info->blank_line_before_trailer = ends_with_blank_line(str,
>   							       trailer_block_start);
> +	info->message_without_trailing_newline_before_trailer
> +		= has_message_without_trailing_newline_char(str, trailer_block_start);
>   	info->trailer_block_start = trailer_block_start;
>   	info->trailer_block_end = end_of_log_message;
>   	info->trailers = trailer_strings;
> @@ -1090,6 +1103,11 @@ int blank_line_before_trailer_block(struct trailer_info *info)
>   	return info->blank_line_before_trailer;
>   }
> 
> +int message_without_trailing_newline_before_trailer_block(struct trailer_info *info)
> +{
> +	return info->message_without_trailing_newline_before_trailer;
> +}
> +
>   void trailer_info_release(struct trailer_info *info)
>   {
>   	size_t i;
> diff --git a/trailer.h b/trailer.h
> index 6eb53df155..81449151c7 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -125,6 +125,12 @@ size_t trailer_block_end(struct trailer_info *);
>    */
>   int blank_line_before_trailer_block(struct trailer_info *);
> 
> +/*
> + * Return true if there is a message before the trailer block and it does not
> + * end with a trailing newline character.
> + */
> +int message_without_trailing_newline_before_trailer_block(struct trailer_info *);
> +
>   /*
>    * Free trailer_info struct.
>    */
> --
> 2.45.2
> 
