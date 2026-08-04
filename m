Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76D4756B2
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 17:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865623; cv=none; b=VKZScWO9Tr5crdor1wXdY9m1/CndScWd56XZirw335f9ljv68h2Qx61BHVHgA7eRY0zmSuHGvqeDzErow0LGHO4Dw26tHVuic7u7hU5S8e3IKglpR+0l3TQQ9b8n8FtEt0/7+VHS+9qaZZOD+TGhDJA9ZURwQB0p6OXMuUDbisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865623; c=relaxed/simple;
	bh=fedjTGj9f77xdsxAO92M2fa2jekz9Rf2QY3/snPpH8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYXFYrQTjJGBayP24hWC3bX9c7wxw8or3u61Mh+5froMYTIr+7h0HtK3Jzw9MabjaQFA2Y/pbwV4RbNuSLbcBW3uvmaE+JSdnJaQhjFp9yGoMAgEtUk5//KvtGDoatLBnUym3tX5NbtseLI/hne4LPrQqvOhrWKxuIOUleQd7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6SUqgK6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6SUqgK6"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ebd88be784so104078a34.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785865620; x=1786470420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ln9Cy7mURAYJmXB2FOiGB8hoOMFGiIhTWZTCCGkblto=;
        b=f6SUqgK6dBgEgvvCfcsuRrMD4cJTZ72h5aOkBR0uMfBp/Sc93/M8qf8iwrWqVMMFv0
         1+3HnE1tGSSXGcvT+/9LfK6PO1UqNj+z3kDJEfP9/0dOzYcHdkw5QWekgFghb8GbMSxC
         xaNRQjiszcame16o4/D6TxOT9ZC1MFxF8DO6WfzgwGKMZ6ipUYHYsUTMq66VW+us9dSd
         OS5Ngzp3lf6BO4VKHP7zG3xrEfOxfjAg6d5RYmuTx8QZ7jvfuyZrYAlTAQrPvxZ5I4kC
         XZPBVpHGbGOFdKgAOkeIfUNiqhqeOQoYlAKr7Et3pIjGTadnOEobgOfu3IqYmgh0H9lJ
         4wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785865620; x=1786470420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ln9Cy7mURAYJmXB2FOiGB8hoOMFGiIhTWZTCCGkblto=;
        b=geOM+DdpmpGRXpaU9VxvSBo478t0dHC3EqplvxXlsVSPGj6ePcuPVuEOfmtEObyOc2
         Z9b8rlPwBisFuSmnmfLJBSo6gGQ7WtRTcglZikj7atgdAQwvhVIfPc6i3yxzfeBcNunB
         n67GfEV1tuveVe3/o7uZ2+oJAxC1lRbdKTtZoQfTkwwz/1SF0GkqlS0radvLdV0d9Pyl
         pagnYpgM9fkwcIz9c9YLwhu8ddEkhCpbU+fbyuOS6jgM8b+B0nueKkfnLiOCUG7XTXJJ
         ojcJRMDYyjwjIz1myZwiRpWbzi5S/QhEcAvPwlWuisedswcQOCBJkdwP7lKLljYD1lYE
         zcsA==
X-Gm-Message-State: AOJu0YwtObAxEDMRKl8VYNhlQDX6sNkysDWTZFDW46BavFbtInC9ZC5M
	Bpf/0GbDbB8YzQdBQwO5+fcTmBMerV5ivkcL+LInr0uPPFDguHRYE+GEYWyxtQ==
X-Gm-Gg: AR+sD12RmnXEa4XYzoEkBtifHuNqoTWKs8UCI9Hl7AMYtigyRWfmmrerpI02Pm2IKiM
	6Ngv8ELwSZRQwr9VvoAqFjN2AqKoo4hl52Tu402lK5CZPN9IeokzJuTSrTwOkiiEL7rue0CtbDV
	l4enJVcbu7JZkYN+qCm80/gwTOB0sayG52MnJ+IkyIj6XOVTxov4+loeWziwOOpTKOYmF+QivAP
	Pk11sd0YGNTUhhjmCcI+3gPUNpfOOqOO2aGpgCNVUVgCf/U4oLM0xfoy4TvoVWFk3DSq0YhgycI
	Ebd+XPGdlBpKsSHIpW2o1tWmWcQtxNSe4k/RJVLM1IW/YspJ9chupT7RhTls4rPwG1byGe266c4
	b7zbiEqqcL4AOwzr15Z3bhMoYotq43Bn3JjoWoxsANkRxsiEmMysCUWSGoO6VUWIpGcxq+A3OVB
	ZH90pH/0+ElHUDmkfja7p/Mfa6fzWR6ve1ZbEDMldZ9k6C9bZd2qjV8Q==
X-Received: by 2002:a05:6830:3741:b0:7ee:41ca:e7b0 with SMTP id 46e09a7af769-7f1e5ea078fmr585913a34.14.1785865620434;
        Tue, 04 Aug 2026 10:47:00 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df345ed1sm1319101a34.8.2026.08.04.10.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:46:59 -0700 (PDT)
Date: Tue, 4 Aug 2026 12:46:56 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] odb/streaming: drop `is_finished` field
Message-ID: <anIXut41fFzRcyOI@denethor>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-2-86d70e82345e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-pks-odb-stream-unification-v1-2-86d70e82345e@pks.im>

On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> The `is_finished` field is used to track whether a write stream is done
> writing all of its data. Tracking this field as part of the stream
> itself shouldn't be required though: callers will already know when the
> stream is done when the stream's read function returns zero bytes, same
> as when reading from a file descriptor.
> 
> There is one exception where it gets a bit more complicated: when
> consuming data in "builtin/unpack-objects.c" it may happen that we don't
> yield any new bytes after reading from the pipe. This is addressed by
> looping until we have produced at least a single byte of output.

Addressing this one outlier sounds reasonable.

> Drop the field from `struct odb_write_stream`. Again, same as in the
> preceding commit, this brings the structure a bit closer to its sibling
> `struct odb_read_stream`.

This also makes the overal interface a bit simpler. Callers can trust
that when `odb_write_stream_read()` returns zero, it is actually
finished without having to inspect further.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/unpack-objects.c      | 15 ++++++++-------
>  object-file.c                 | 13 ++++++++-----
>  odb/source-inmemory.c         |  9 ++++++++-
>  odb/source-loose.c            | 12 ++++++++----
>  odb/streaming.c               |  5 +----
>  odb/streaming.h               |  1 -
>  t/unit-tests/u-odb-inmemory.c |  5 +++--
>  7 files changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index f3e0b504f4..b7c486ea94 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -368,20 +368,20 @@ static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
>  {
>  	struct input_zstream_data *data = in_stream->data;
>  	git_zstream *zstream = data->zstream;
> -	void *in = fill(1);
>  
> -	if (in_stream->is_finished)
> +	if (data->status != Z_OK)
>  		return 0;
>  
>  	zstream->next_out = buf;
>  	zstream->avail_out = buf_len;
> -	zstream->next_in = in;
> -	zstream->avail_in = len;
>  
> -	data->status = git_inflate(zstream, 0);
> +	while (data->status == Z_OK && zstream->avail_out == buf_len) {
> +		zstream->next_in = fill(1);
> +		zstream->avail_in = len;
> +		data->status = git_inflate(zstream, 0);
> +		use(len - zstream->avail_in);
> +	}

Ok, now we call `git_inflate()` in a loop until there is an error or we
get some data back. This makes it so we can trust that returning zero
does mean that the stream is finished. Previously, it was the callers
responsibility to check the `is_finished` stream field to be certain.

I was curious if we needed to update any code documentation with this
change, but it looks like the comments for `odb_write_stream_read()`
already made it sound like this was the current behavior.

[snip]
> diff --git a/odb/streaming.h b/odb/streaming.h
> index 4d7d31b5aa..5e8e6e532e 100644
> --- a/odb/streaming.h
> +++ b/odb/streaming.h
> @@ -56,7 +56,6 @@ struct odb_write_stream {
>  	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
>  	void *data;
>  	size_t size;
> -	int is_finished;

The field is dropped. Nice.

The rest of this patch looks good.

-Justin
