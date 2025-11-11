Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5823730EC
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880144; cv=none; b=TLieZ6E3jFi8J2O5a68x0EKS4+FBsEqtIvwqAmO6appdoSdxYy/kRpD50bZ8WRyNBNlVTsv29agFMaxar7PXJxY7BX9uJnwH151RY4dm1jGkVTBdw6jfwl2x9FbVrmE/IFm2gF/92Em+T1HYaYb22Wr8u2dTXYAMAoeCv3ABV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880144; c=relaxed/simple;
	bh=UshGKa5jQpTgZZBSFuqyxGcvIP/JcYWNZKWYr/mnK1k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=dFtmPTfezH2hT1gzbRQm7f9SgnE4ZlPlef8q+91oErLjnalwdO3+Cs4ZFbfyeFdsfElY9LVHcrjlX9h87Drsjx1wBym0NInhFTbPrkf1+NDS7pKY0uUlAOD7CX9s9iP6UvQatosYW4jZj2DcKvXk4XYgaGrgvooEgSevbFNWkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVu+hkH8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVu+hkH8"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so667273f8f.1
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 08:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762880140; x=1763484940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eZ08KKH1wKH03qwLL1yFb85i1CMh6qE7vmXWJjJPgc=;
        b=EVu+hkH8Xav49JGTlfw0+JhIwi9E0Y1od/Pq4dLE35Va7fTVu62f7WSnxJAJV7rdv2
         htOJZdAgxFE+zt4X2RMKLREpphhLDsKMMyCb/Qtf4JahaQ3N1X6zkWLkEMgyD3tHbIBw
         /2w/Igc9QrD1uNkIVZfGb/7cVzzRvDcp/nMSRXIB4YuqmEGNXZ3/ztjCtukqmneIhovW
         c4R2GcbU3Z4mMoQ9M8doBaFHVAVNSFEiLxNr/XZIYS36ROg6S2InUPIO2xy56BawAQIT
         fxCf7D37hRxfR8roaNK2oL68PVgndM78Pzx3dIJ5BNmv2QzlQNCsdf/fM65xv5ls5YD1
         XqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880140; x=1763484940;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eZ08KKH1wKH03qwLL1yFb85i1CMh6qE7vmXWJjJPgc=;
        b=Bm8SrWZshVJUGB/nuCh//DewD1ny7Rx085tjJQ+A6pq7TP45CfbvmZyQVAFRUOLoNS
         om7tSH02wrmB7M/y8vfdUBvkhU8NhDGbVxHDW77U8GXknkZ3EtgLH++4kRzc9NGYI5CG
         GZXAUfHJz9u/IesJ81aizZT20UnC4RS1/26OCAMS/x8zR+tKH4cMx8FajgvXNrYGCZeZ
         wn0RV7985em4LLwYLy1rAUHvI1iXRViUyztlreJqMS1+bIBnAiim59MBTScnBNxBNV7b
         RV4EoNXJXDxjxnmVRMbU2qYx0COGFRpOrGIjf6LWBeMH03iskKpRa5sseEHvAGWLgTDL
         3mXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrjGZ6Gvb/bs1im++ew/3F+O9w/6uac0Fs27uAZ/gjfsfOtQ+QkyAYq2sXtXTjgpR8f74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vYdQnSSt+lQdLze84fDUYfbizhwhIHq7XiWGF5GlTdU7ll9b
	11s+ROClNTbU1KJ7dXB5Wpt1OqMzTrQPUlhcfZtwPP61NAUVYQxaeMVbtgTYSg==
X-Gm-Gg: ASbGncvoZFkaPdvxC8NG3EjVwT9Uv7r5qJHTlllvHLuH9wRP0uDrsRPpR0OQsKkvjsy
	9MetAl9qPBWLbhNUvb4gLjWHm5CY7ZyM7GN4ETteSbtD6A3eIbO+26USj7zz1p13jB24qVfP32+
	t/fV12RexZ95UPQOW/DSXcXTN6OMjx0Jw5eqZq0WTnfzbes1nPFnvxdyRdvkdfvwHM4lQAJzpoB
	bQTEzrZtFPErxaL7wtcpbbLtjKenUO9HpqKUnFXNTC+tETqmX060ln5q9uhRtEwJ7STAXh61FFn
	Ujd4Wq1AIfPoBC7mIuW6Yj4kP6Tf7D+u/xRxXDwpYcTWt8H1jiUHKoj/QmsWzVH20Jv/gZVtUWq
	kXKUF0JdpxzHmJSxUmH6g7lH7l51ll9ZIQrO3QykWRc6qKfUDdxcC6i0ZpII9qzSHekg+M0JqZE
	PkqJRXv6LAf5vb2SShIfPCLpnIG5AYk9OV4uatPejKbHaaClFDeHC7RQA3bNBEXSk=
X-Google-Smtp-Source: AGHT+IHTm4oMBv9lj2Eg0b1G+i+/5wT+3cJNpoTklvS7QS8IyMcEpMPYRplHqjxLCORR6p28yAcoJA==
X-Received: by 2002:a05:6000:2dc8:b0:429:c6ba:d94c with SMTP id ffacd0b85a97d-42b432b1e35mr4025649f8f.10.1762880139685;
        Tue, 11 Nov 2025 08:55:39 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b29e4b9bdsm25573033f8f.32.2025.11.11.08.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:55:39 -0800 (PST)
Message-ID: <e13be93f-9d10-4baf-b333-d293c5f46fb5@gmail.com>
Date: Tue, 11 Nov 2025 16:55:38 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 3/4] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20251105142944.73061-1-me@linux.beauty>
 <20251105142944.73061-4-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20251105142944.73061-4-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 05/11/2025 14:29, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> diff --git a/trailer.c b/trailer.c
> index b735ec8a53..f5838f5699 100644
> --- a/trailer.c
> +++ b/trailer.c
> 
> @@ -1224,18 +1226,66 @@ void trailer_iterator_release(struct trailer_iterator *iter)
>   	strbuf_release(&iter->key);
>   }
>   
> -int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
> +static int amend_strbuf_with_trailers(struct strbuf *buf,
> +				      const struct strvec *trailer_args)

While reviewing patch 4 I've just realized that this function can never 
fail so should return "void" rather than "int". I've not quite finished 
with patch 4 yet, hopefully I'll post a review tomorrow.

Thanks

Phillip

>   {
> -	struct child_process run_trailer = CHILD_PROCESS_INIT;
> -
> -	run_trailer.git_cmd = 1;
> -	strvec_pushl(&run_trailer.args, "interpret-trailers",
> -		     "--in-place", "--no-divider",
> -		     path, NULL);
> -	strvec_pushv(&run_trailer.args, trailer_args->v);
> -	return run_command(&run_trailer);
> +	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
> +	LIST_HEAD(new_trailer_head);
> +	struct strbuf out = STRBUF_INIT;
> +	size_t i;
> +
> +	opts.no_divider = 1;
> +
> +	for (i = 0; i < trailer_args->nr; i++) {
> +		const char *text = trailer_args->v[i];
> +		struct new_trailer_item *item;
> +
> +		if (!*text)
> +			continue;
> +		item = xcalloc(1, sizeof(*item));
> +		INIT_LIST_HEAD(&item->list);
> +		item->text = text;
> +		list_add_tail(&item->list, &new_trailer_head);
> +	}
> +
> +	process_trailers(&opts, &new_trailer_head, buf, &out);
> +
> +	strbuf_swap(buf, &out);
> +	strbuf_release(&out);
> +	while (!list_empty(&new_trailer_head)) {
> +		struct new_trailer_item *item =
> +			list_first_entry(&new_trailer_head, struct new_trailer_item, list);
> +		list_del(&item->list);
> +		free(item);
> +	}
> +	return 0;
>   }
>   
> +int amend_file_with_trailers(const char *path,
> +			     const struct strvec *trailer_args)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!trailer_args || !trailer_args->nr)
> +		return 0;
> +
> +	if (strbuf_read_file(&buf, path, 0) < 0)
> +		return error_errno("could not read '%s'", path);
> +
> +	if (amend_strbuf_with_trailers(&buf, trailer_args)) {
> +		strbuf_release(&buf);
> +		return error("failed to append trailers");
> +	}
> +
> +	if (write_file_buf_gently(path, buf.buf, buf.len)) {
> +		strbuf_release(&buf);
> +		return -1;
> +	}
> +
> +	strbuf_release(&buf);
> +	return 0;
> + }
> +
>   void process_trailers(const struct process_trailer_options *opts,
>   		      struct list_head *new_trailer_head,
>   		      struct strbuf *sb, struct strbuf *out)
> diff --git a/trailer.h b/trailer.h
> index 44d406b763..daea46ca5d 100644
> --- a/trailer.h
> +++ b/trailer.h
> @@ -196,9 +196,8 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
>   void trailer_iterator_release(struct trailer_iterator *iter);
>   
>   /*
> - * Augment a file to add trailers to it by running git-interpret-trailers.
> - * This calls run_command() and its return value is the same (i.e. 0 for
> - * success, various non-zero for other errors). See run-command.h.
> + * Augment a file to add trailers to it (similar to 'git interpret-trailers').
> + * Returns 0 on success or a non-zero error code on failure.
>    */
>   int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
>   
> diff --git a/wrapper.c b/wrapper.c
> index 3d507d4204..1f12dbb2fa 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -688,6 +688,22 @@ void write_file_buf(const char *path, const char *buf, size_t len)
>   		die_errno(_("could not close '%s'"), path);
>   }
>   
> +int write_file_buf_gently(const char *path, const char *buf, size_t len)
> +{
> +	int fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
> +
> +	if (fd < 0)
> +		return error_errno(_("could not open '%s'"), path);
> +	if (write_in_full(fd, buf, len) < 0) {
> +		int ret = error_errno(_("could not write to '%s'"), path);
> +		close(fd);
> +		return ret;
> +	}
> +	if (close(fd))
> +		return error_errno(_("could not close '%s'"), path);
> +	return 0;
> +}
> +
>   void write_file(const char *path, const char *fmt, ...)
>   {
>   	va_list params;
> diff --git a/wrapper.h b/wrapper.h
> index 44a8597ac3..e5f867b200 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -56,6 +56,12 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
>    */
>   void write_file_buf(const char *path, const char *buf, size_t len);
>   
> +/**
> + * Like write_file_buf(), but report errors instead of exiting. Returns 0 on
> + * success or a negative value on error after emitting a message.
> + */
> +int write_file_buf_gently(const char *path, const char *buf, size_t len);
> +
>   /**
>    * Like write_file_buf(), but format the contents into a buffer first.
>    * Additionally, write_file() will append a newline if one is not already

