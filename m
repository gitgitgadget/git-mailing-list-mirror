Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF6D47DD59
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862097; cv=none; b=ZHLWvGqO1KeaohLJ8TT9xmPaXETAEnVygKv3lgIdQdnsY/VOA9hkGGL9zbTELusZH7IAcjOhHU58kHghi/dVuZqrRtriQkHbZwaXwZyTHXIRkTkIrQZupAtagnzDz4xv0p8R3GNsgGQSu2Nzn64uBDFH7Fc4WC3phh3odzqHKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862097; c=relaxed/simple;
	bh=t3QfpPKrCCyccT/hdHONpZPnmST3n3ddTTrwjGyUWAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rck4iYjc5FkAsdTuZ5Mo6J2wyAYasK1chzCfPtpR0z/G5FsIguybO7KPXv1BtkxPVJ29B22x2qPZ2QhzVkiiokXQevgR/UMW3T0LfvfOq2aXXBZfoGsu81CLdnGoB1lsHCexXmtenUNto0ahA9pljcMYu0TV7XkUnYGXBVSj0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sAeM2mKs; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAeM2mKs"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4513435cdd2so2019945fac.2
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785862072; x=1786466872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iZr/DdFoUXW/AU17bJZV1YVFYPJbuPQ+LKhMi1uucUI=;
        b=sAeM2mKstvGY0p9c5Jk/RQ826hhSieCPs7Bxq3/EnbwCBfPJer1WtN1x1iTxO4PPTn
         tzTwd3Hnz9zBVsAmt0rqsH2+8i+IKylD9Y4BNvh7JL5wfweriKN0UsQtayjpxdkjY/z7
         uIAlWXIHI5FRgCkVVJ+7vd9igxOt1DI8UJ7wi5ZM72bLgeBwXard3hpwkY6xGFxYua2e
         MZIJ1RcF3LHvWLsJOpko/PZImA5ieiQE3ZRcBGKibr+4gzwwJvMNVY4LBSh5QrSq/1xN
         FSbtOvUfnYhXS66VWaeioxxQ5+4/QOA53g+H3L082p6vrDVlPELv9mclZj5yhhekrejQ
         xCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862072; x=1786466872;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZr/DdFoUXW/AU17bJZV1YVFYPJbuPQ+LKhMi1uucUI=;
        b=XDkIfgyAWLRSwDdcwuhMT3VQLsgblIAShakrrc8BnXkjOjO8DdRapw++kTw/6Cbfim
         1TcFDFh/w3woUppOy5TjzHZ4UAlPyO5pRIyFACaB+n8ehEPLqZlgO7CeW8kvTY0q4bHN
         eok0jFPit9QVxHnoXm0pXhqqzKBQzmOxR2gJV+eNs/wVMQab8KovNcJ+xKvzK8IRqiXp
         er8Uz3vaVgtR+hsGhW1vWQ1WGHucpaAjqi7QAelX0LDlZzeIEqRAeoZC21vJkpSBi3nc
         E+KVJEL0XFhrHWAvkwxW0yPQeUtlJOmriwdeT90yRQ6mLuzfGyP9+xgjRD4qeQdRn56u
         uc0Q==
X-Gm-Message-State: AOJu0YxUTfh8a0Xp88f0GhTXzexsWmMTzUZyF+ciXNjHqGEJ4U+UlqSt
	Bl/p+0pQod87MiAehsFRsoNnk6iM3bX96FpTARkSFmGABMC33a5vBeMR
X-Gm-Gg: AR+sD13w1g3HJfZImGbOGYBwj9AT5uaJ6u1LohNXsyzThFpR2geSdRR+wjPjSKV+4se
	jCpTN58WNzVbtB+jkbsqoA/Dk9aNjoAegP67h2RfUfvs7e5CP9MO03Ci9+MphdIQSlyKOphwosd
	vMBktauIy89l3GVsjkOKOLNyYAQ8CQFnhyGqttqNRH5Gh+tTMxXS4YvX9NYJLMSZoI/Gq2u6wnu
	egzbVkrMBJ51diPCziZATFabFP6SPICFgYUWnSYqkH9TNsZHmmAvGYbtX+YuKBtVB4FNC7ABPt3
	Ki2LyP5C6iQndUZiI8FQXo5UGS+2Xh2T4Q8+dLW0zl0YWSp3CtFPNnTBWypEwVUhHPKdCWEuCU6
	nKyKc4QSQH35E7N9zznVMGYuR7gi7ANd9EXXYHVoq+gtqO33PY+fsYhPI37JehpEW3rcA7Q7+Tz
	iTC2mDfcij4Plwr+zwGnus5eSHtI2Uwq7AmQlfFGzLllfjloc2hdFSOw==
X-Received: by 2002:a05:6820:1c89:b0:6a3:92f8:96ab with SMTP id 006d021491bc7-6ae96c17c48mr211463eaf.1.1785862072247;
        Tue, 04 Aug 2026 09:47:52 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93cbf7a9sm466050eaf.2.2026.08.04.09.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:47:51 -0700 (PDT)
Date: Tue, 4 Aug 2026 11:47:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] odb/streaming: track write stream size in the
 structure
Message-ID: <anIWUKV8iBFkT7g9@denethor>
References: <20260804-pks-odb-stream-unification-v1-0-86d70e82345e@pks.im>
 <20260804-pks-odb-stream-unification-v1-1-86d70e82345e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-pks-odb-stream-unification-v1-1-86d70e82345e@pks.im>

On 26/08/04 09:25AM, Patrick Steinhardt wrote:
> When passing around a `struct odb_write_stream` we typically also have
> to pass the number of bytes that the stream will yield. This is required
> because the object header itself contains that size, and consequently we
> cannot write the header without that information.
> 
> Move this information into the stream itself so that it becomes self-
> describing. In addition to that, this also brings the `struct
> odb_write_stream` a bit closer to the `struct odb_read_stream` so that
> we can eventually merge both stream types.

Storing the object size in the stream directly makes complete sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/unpack-objects.c      |  3 ++-
>  object-file.c                 | 25 +++++++++++--------------
>  odb.c                         |  4 ++--
>  odb.h                         |  2 +-
>  odb/source-files.c            |  3 +--
>  odb/source-inmemory.c         | 11 +++++------
>  odb/source-loose.c            |  7 +++----
>  odb/source-packed.c           |  1 -
>  odb/source.h                  |  5 ++---
>  odb/streaming.c               |  1 +
>  odb/streaming.h               |  1 +
>  odb/transaction.c             |  4 ++--
>  odb/transaction.h             |  4 ++--
>  t/unit-tests/u-odb-inmemory.c | 11 +++++------
>  14 files changed, 38 insertions(+), 44 deletions(-)
> 
[snip]
> diff --git a/odb/streaming.h b/odb/streaming.h
> index c023671780..4d7d31b5aa 100644
> --- a/odb/streaming.h
> +++ b/odb/streaming.h
> @@ -55,6 +55,7 @@ ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t l
>  struct odb_write_stream {
>  	ssize_t (*read)(struct odb_write_stream *, unsigned char *, size_t);
>  	void *data;
> +	size_t size;
>  	int is_finished;
>  };

The size is now stored directly in the stream, the rest of this patch is
adjusting callers to use the embedded size information instead of
passing it. Looks good.

-Justin
