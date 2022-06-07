Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58728C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 03:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiFHD0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 23:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiFHDZF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 23:25:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA538BED
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 12:53:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso21791534pjl.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+nyE53ZhG+rMiBIIMTh0y6iSgKl+jgsnFYxYeWeuFr4=;
        b=gDolq+5Yw3H3jfvLYHkNMc/oycWoG/ruHWhQcAWkd+/bR0NKbE73asAxEw5bbXpjrg
         lDU81HYcapnIzKLv4Q8OgWD1MO3nbwIjJ49ewquGQbFdSm4Q6o3o4e44s9eVWwPTSnLT
         AkgAbxCbmwk7n8RfX565oqb7cCFw0rDrqweVXAx/txO0OIsom61jR4qySuEwohMzkQ5J
         cLaWjohT+lnSINmFb8busMfAhF/ZDVtrUJsPFQzwbchPSGd6k158Qe0raBGBN5DvmEbV
         n6VO7e9kIKN1EJjJh9iuAkirSq3BhFrkf1O+0CdAQj3XQvyRe545wh8evPHX7JipQL0Z
         dcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+nyE53ZhG+rMiBIIMTh0y6iSgKl+jgsnFYxYeWeuFr4=;
        b=UMbr0zdaUxj6epBiIfMgYtgpbuHiByezfYdkTnU7Wf5cXZ1o1zT1RZGpBDjbzKfebj
         NjIOoweB6fs+eAHlYsYL7RQ4p5n95Q4G1YFbwaKOSfwVwEuO07rqKZPw1LxOvjtyRBM4
         iS3wfVpRFDSi/8Quzlf3rizReqEQlCTr8F6uFiUzwFRG5c7U214Fq4dJ3H9EITSUH5ku
         GTXmU2OgcHi/apJwu2rBKkhm+5JXurjzIro2AQT5ECVl9QCs/vglBZz8GziGBgSYdTWU
         9VCuaUxjN/NCXHKgYl9trlyLyUOeB4Lv3S37MHD0uM/bDR9dlewNrqqCRq9jmm6mWvVJ
         Lrqw==
X-Gm-Message-State: AOAM5301zrwLWBKCXF/P0nsa7R6IigWHCnSdy051eurUwtR9YsTQ2sHb
        YKLCL6InHqWfBGVRJExXSZo=
X-Google-Smtp-Source: ABdhPJxwjgF6QBPiwZEHbT4GFGahl3S9ccyUksr6749D2CE9Kje+ZzQPuM0k6xh2yt3u9wYVg6FmLQ==
X-Received: by 2002:a17:902:7202:b0:167:79d1:f with SMTP id ba2-20020a170902720200b0016779d1000fmr12633937plb.3.1654631613910;
        Tue, 07 Jun 2022 12:53:33 -0700 (PDT)
Received: from [192.168.1.164] (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0016362da9a03sm12981637pla.245.2022.06.07.12.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 12:53:33 -0700 (PDT)
Message-ID: <7ba4858a-d1cc-a4eb-b6d6-4c04a5dd6ce7@gmail.com>
Date:   Tue, 7 Jun 2022 12:53:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v13 5/7] object-file.c: add "stream_loose_object()" to
 handle large object
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
 <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
 <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
In-Reply-To: <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2022 3:10 AM, Ævar Arnfjörð Bjarmason wrote:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
> 
> If we want unpack and write a loose object using "write_loose_object",
> we have to feed it with a buffer with the same size of the object, which
> will consume lots of memory and may cause OOM. This can be improved by
> feeding data to "stream_loose_object()" in a stream.
> 
> Add a new function "stream_loose_object()", which is a stream version of
> "write_loose_object()" but with a low memory footprint. We will use this
> function to unpack large blob object in later commit.
> 
> Another difference with "write_loose_object()" is that we have no chance
> to run "write_object_file_prepare()" to calculate the oid in advance.
> In "write_loose_object()", we know the oid and we can write the
> temporary file in the same directory as the final object, but for an
> object with an undetermined oid, we don't know the exact directory for
> the object.
> 
> Still, we need to save the temporary file we're preparing
> somewhere. We'll do that in the top-level ".git/objects/"
> directory (or whatever "GIT_OBJECT_DIRECTORY" is set to). Once we've
> streamed it we'll know the OID, and will move it to its canonical
> path.
> 

I think this new logic doesn't play well with batched-fsync. Even 
through we don't know the final OID, we should still call 
prepare_loose_object_bulk_checkin to potentially create the bulk checkin 
objdir.


> diff --git a/object-file.c b/object-file.c
> index 7946fa5e088..9fd449693c4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2119,6 +2119,106 @@ static int freshen_packed_object(const struct object_id *oid)
>   	return 1;
>   }
>   
> +int stream_loose_object(struct input_stream *in_stream, size_t len,
> +			struct object_id *oid)
> +{
> +	int fd, ret, err = 0, flush = 0;
> +	unsigned char compressed[4096];
> +	git_zstream stream;
> +	git_hash_ctx c;
> +	struct strbuf tmp_file = STRBUF_INIT;
> +	struct strbuf filename = STRBUF_INIT;
> +	int dirlen;
> +	char hdr[MAX_HEADER_LEN];
> +	int hdrlen;
> +
> +	/* Since oid is not determined, save tmp file to odb path. */
> +	strbuf_addf(&filename, "%s/", get_object_directory());
> +	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
> +
> +	/*
> +	 * Common steps for write_loose_object and stream_loose_object to
> +	 * start writing loose objects:
> +	 *
> +	 *  - Create tmpfile for the loose object.
> +	 *  - Setup zlib stream for compression.
> +	 *  - Start to feed header to zlib stream.
> +	 */
> +	fd = start_loose_object_common(&tmp_file, filename.buf, 0,
> +				       &stream, compressed, sizeof(compressed),
> +				       &c, hdr, hdrlen);
> +	if (fd < 0) {
> +		err = -1;
> +		goto cleanup;
> +	}
> +
> +	/* Then the data itself.. */
> +	do {
> +		unsigned char *in0 = stream.next_in;
> +
> +		if (!stream.avail_in && !in_stream->is_finished) {
> +			const void *in = in_stream->read(in_stream, &stream.avail_in);
> +			stream.next_in = (void *)in;
> +			in0 = (unsigned char *)in;
> +			/* All data has been read. */
> +			if (in_stream->is_finished)
> +				flush = 1;
> +		}
> +		ret = write_loose_object_common(&c, &stream, flush, in0, fd,
> +						compressed, sizeof(compressed));
> +		/*
> +		 * Unlike write_loose_object(), we do not have the entire
> +		 * buffer. If we get Z_BUF_ERROR due to too few input bytes,
> +		 * then we'll replenish them in the next input_stream->read()
> +		 * call when we loop.
> +		 */
> +	} while (ret == Z_OK || ret == Z_BUF_ERROR);
> +
> +	if (stream.total_in != len + hdrlen)
> +		die(_("write stream object %ld != %"PRIuMAX), stream.total_in,
> +		    (uintmax_t)len + hdrlen);
> +
> +	/* Common steps for write_loose_object and stream_loose_object to
> +	 * end writing loose oject:
> +	 *
> +	 *  - End the compression of zlib stream.
> +	 *  - Get the calculated oid.
> +	 */
> +	if (ret != Z_STREAM_END)
> +		die(_("unable to stream deflate new object (%d)"), ret);
> +	ret = end_loose_object_common(&c, &stream, oid);
> +	if (ret != Z_OK)
> +		die(_("deflateEnd on stream object failed (%d)"), ret);
> +	close_loose_object(fd, tmp_file.buf);
> +

If batch fsync is enabled, the close_loose_object call will refrain from 
syncing the tmp file.

> +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
> +		unlink_or_warn(tmp_file.buf);
> +		goto cleanup;
> +	}
> +
> +	loose_object_path(the_repository, &filename, oid);
> +

We expect this loose_object_path call to return a path in the bulk fsync 
object directory. It might not do so if we don't call 
prepare_loose_object_bulk_checkin.

In the new test case introduced in (7/7), we seem to be getting lucky
in that there are some small objects (commits) earlier in the packfile,
so we go through write_loose_object first.

Thanks for including me on the review!

-Neeraj
