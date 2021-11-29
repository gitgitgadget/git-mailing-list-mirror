Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5BC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379567AbhK2SyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379609AbhK2SwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:52:11 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C61C043CF2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:10:43 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so25882759otv.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8gooo+C/vrvfH07cGPBha62Bun+WHZZ0HUDrxBpPA7M=;
        b=poEz3sgeOqGmC1jqg5gnWQvWMCuBQnTd1KeYlb9izkjUTZ0G+idHtil3L23Y/2JPwq
         jEI1kkjHla4s4S/1yBPKJ73wIJYbXjcok0RKoLH1a++wZ/R+T9JC3kkMfpxWaU03yNx0
         0KUBx1gxRuCLLAX65VVEWEKFb4Aczu6TnlCfL9v8Oa2rujnUTUMRBw2PH33Lh0plX3tU
         y2NtVl0Lokn8Ya9dJtwnxJESJTsI0zo1Oo0nnq7VFyrbC1nmlQVmdsn1zyqGkOp7U0+P
         j+ewx9i+WUlhMoQhosIFSKsc5Y+7m3vgkR8x6W7pCogemWPxMIKUZCA/RByW/ElGhWEC
         cFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8gooo+C/vrvfH07cGPBha62Bun+WHZZ0HUDrxBpPA7M=;
        b=5JP+gd91QnRR7YjhwFSnsUoJosOyyoZYZDQGXjSHH97yEuYXEj18euJsmmhuIQYajt
         asWJahWvH5kG0AnB7fMeyzssFVq7/G11E9f+Tb+k8+DWEw5Of8S3DCfDZL3DmXob9KCl
         YLSm3AEkFzecv+DvXuqhsnw/XM8xx0ajW76nvq7D4beH2wOQbjMmewZzJyvCbz5sMtgw
         GQfzQ++avO99PoaXIYLB7myu0mwHhwG3iRNABNky2Do6oOLi5hH4ZPbHf0r2a1vZcp4b
         qbnP2TM+G0DvxlJFaSCXjk8sEML9P7wY0F+QnoGGNu0DzzsB0dlItEfwwhVwaOFzRZLq
         5LOg==
X-Gm-Message-State: AOAM5320bxPyggBGkiqWUTpaVqZ74XNn1YtfB9uiQT3hu7LxaK91p5xt
        27UGS7Tkv/Xmbh6CRSESPq8=
X-Google-Smtp-Source: ABdhPJwzZOt+F4VTCMpSDY5PYpMn5lOVuXyfbMmqx/5FofS6IsHCASiENgz+NWlbiiKvkWWiTk3i8Q==
X-Received: by 2002:a05:6830:104f:: with SMTP id b15mr45758586otp.215.1638198641811;
        Mon, 29 Nov 2021 07:10:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id w2sm2265933ooa.26.2021.11.29.07.10.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 07:10:41 -0800 (PST)
Message-ID: <47b3e2ad-4fa1-040a-24c1-6da0445bd1a5@gmail.com>
Date:   Mon, 29 Nov 2021 10:10:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/5] object-file.c: handle undetermined oid in
 write_loose_object()
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
 <20211122033220.32883-3-chiyutianyi@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211122033220.32883-3-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2021 10:32 PM, Han Xin wrote:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
> 
> When streaming a large blob object to "write_loose_object()", we have no
> chance to run "write_object_file_prepare()" to calculate the oid in
> advance. So we need to handle undetermined oid in function
> "write_loose_object()".
> 
> In the original implementation, we know the oid and we can write the
> temporary file in the same directory as the final object, but for an
> object with an undetermined oid, we don't know the exact directory for
> the object, so we have to save the temporary file in ".git/objects/"
> directory instead.

My first reaction is to not write into .git/objects/ directly, but
instead make a .git/objects/tmp/ directory and write within that
directory. The idea is to prevent leaving stale files in the
.git/objects/ directory if the process terminates strangely (say,
a power outage or segfault).

If this was an interesting idea to pursue, it does leave a question:
should we clean up the tmp/ directory when it is empty? That would
require adding a check in finalize_object_file() that is probably
best left unchecked (the lstat() would add a cost per loose object
write that is probably too costly). I would rather leave an empty
tmp/ directory than add that cost per loose object write.

I suppose another way to do it would be to register the check as
an event at the end of the process, so we only check once, and
that only happens if we created a loose object with this streaming
method.

With all of these complications in mind, I think cleaning up the
stale tmp/ directory could (at the very least) be delayed to another
commit or patch series. Hopefully adding the directory is not too
much complication to add here.

> -	loose_object_path(the_repository, &filename, oid);
> +	if (is_null_oid(oid)) {
> +		/* When oid is not determined, save tmp file to odb path. */
> +		strbuf_reset(&filename);
> +		strbuf_addstr(&filename, the_repository->objects->odb->path);
> +		strbuf_addch(&filename, '/');

Here, you could instead of the strbuf_addch() do

	strbuf_add(&filename, "/tmp/", 5);
	if (safe_create_leading_directories(filename.buf)) {
		error(_("failed to create '%s'"));
		strbuf_release(&filename);
		return -1;
	}		

> +	} else {
> +		loose_object_path(the_repository, &filename, oid);
> +	}
>  
>  	fd = create_tmpfile(&tmp_file, filename.buf);
>  	if (fd < 0) {
> @@ -1939,12 +1946,31 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
>  		    ret);
>  	the_hash_algo->final_oid_fn(&parano_oid, &c);
> -	if (!oideq(oid, &parano_oid))
> +	if (!is_null_oid(oid) && !oideq(oid, &parano_oid))
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>  
>  	close_loose_object(fd);
>  
> +	if (is_null_oid(oid)) {
> +		int dirlen;
> +
> +		oidcpy((struct object_id *)oid, &parano_oid);
> +		loose_object_path(the_repository, &filename, oid);
> +
> +		/* We finally know the object path, and create the missing dir. */
> +		dirlen = directory_size(filename.buf);
> +		if (dirlen) {
> +			struct strbuf dir = STRBUF_INIT;
> +			strbuf_add(&dir, filename.buf, dirlen - 1);
> +			if (mkdir(dir.buf, 0777) && errno != EEXIST)
> +				return -1;
> +			if (adjust_shared_perm(dir.buf))
> +				return -1;
> +			strbuf_release(&dir);
> +		}
> +	}
> +

Upon first reading I was asking "where is the file rename?" but
it is part of finalize_object_file() which is called further down.

Thanks,
-Stolee
