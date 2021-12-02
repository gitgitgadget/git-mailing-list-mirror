Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA42C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 15:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359090AbhLBPjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbhLBPjk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 10:39:40 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B02C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 07:36:18 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id u16so25286425qvk.4
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 07:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cBNzXf+B+O1saQ8foFV9Cf5kU912hyH4BRXtphB49RU=;
        b=eGA+WpT0ljAc66C9U0f2vYEfPFfJ+zxGv3fLiwzYizl8O5MeSdvJLVfTMpdwKa1txh
         juCp6JJfw1qOvH0FPdTzXf4md3lAURfaotsEn8H6un8GPptG7VKhq6bSXlRCL/24tJy9
         PUmhm1orMpcN+UuTJ/vTWVDbrQzaCOcNTLrGl52xgSmNfPiolgtaBat/x7YiRGj9MWif
         uEdejWb8PmXnZo7kHnF6qK/Z8FJJBrQunfVqp29My75gnFeI0IWwPpwCR6HkvlihKQbU
         HNGoX/mLHhmWC25eApdCXNlVOB+TWzZB0QdQHUAW8mdhNuS3gosff4T3y84MQgy7JIJ0
         93jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cBNzXf+B+O1saQ8foFV9Cf5kU912hyH4BRXtphB49RU=;
        b=CWyWJxw+z4MkM8k8LvNBi9DvYPF+7H35juUWOskhTi3c4DbNy+tecgnc95AfoqU015
         OCuQlTxofZ40rjSM2/1oQbyJJSK2lfqmNQVUHMGmmRKpxGbmSPj4O54EBVUnyLU3i+C3
         9xL6v4gmqqiS4x6Y84qbC54HdpskEZE5SrmeGf4X7m+Q6g3M7f2LGKvpfJ8OaPZKRC7K
         6PvQytBxZJypmAgfFo8SAzxShk5ICxENUPz4/bsj++nSBhkL9ZDhONE25nzBkPm8uLFJ
         KslK4HIB1GIWlNNkdCz3pqE/ZRj9/JJIEr5+0Lsu3ILJtX1854dVg7nrSq7GEsgkgd9d
         r9bg==
X-Gm-Message-State: AOAM532/tHjHb8zbH2BDJ5aptxpBTwo0yqm1KbP5Yg+qgjhGV2xhGJk1
        1wSxMz4/Adnkvqmq6Ae93aE=
X-Google-Smtp-Source: ABdhPJx7ftk9rxunJ2lUP6xykGzcHxAKaBh1AXNtY9bZUC3eNxwqE0HnUC+qL1zXT8ASDOuBnbYVXg==
X-Received: by 2002:a05:6214:27ee:: with SMTP id jt14mr13623668qvb.5.1638459377306;
        Thu, 02 Dec 2021 07:36:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a483:be4f:55c1:3cc8? ([2600:1700:e72:80a0:a483:be4f:55c1:3cc8])
        by smtp.gmail.com with ESMTPSA id l1sm85658qkp.125.2021.12.02.07.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 07:36:16 -0800 (PST)
Message-ID: <2a26da15-8d4f-92b9-d727-debf8b969899@gmail.com>
Date:   Thu, 2 Dec 2021 10:36:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 05/17] pack-mtimes: support writing pack .mtimes files
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <deece9eb70e9750bb8350946679b521e59139fe2.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <deece9eb70e9750bb8350946679b521e59139fe2.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:> @@ -168,6 +168,9 @@ struct packing_data {
>  	/* delta islands */
>  	unsigned int *tree_depth;
>  	unsigned char *layer;
> +
> +	/* cruft packs */
> +	uint32_t *cruft_mtime;

This comment is a bit terse. Perhaps...

	/* Used when writing cruft packs. */

> +static inline uint32_t oe_cruft_mtime(struct packing_data *pack,
> +				      struct object_entry *e)
> +{
> +	if (!pack->cruft_mtime)
> +		return 0;
> +	return pack->cruft_mtime[e - pack->objects];
> +}

When writing a pack, it appears that the cruft_mtime array
maps to objects in pack-order, not idx-order, correct? That
might be worth mentioning in the struct definition because
it differs from the .mtimes file.

> +static void write_mtimes_objects(struct hashfile *f,
> +				 struct packing_data *to_pack,
> +				 struct pack_idx_entry **objects,
> +				 uint32_t nr_objects)
> +{
> +	uint32_t i;
> +	for (i = 0; i < nr_objects; i++) {
> +		struct object_entry *e = (struct object_entry*)objects[i];
> +		hashwrite_be32(f, oe_cruft_mtime(to_pack, e));
> +	}

The name "objects" here confused me at first, thinking it
corresponded to the objects member of 'struct packing_data', but
that is being handled by the fact that 'objects' is actually a
lex-sorted list of pack_idx_entry pointers (and they happen to
also point to 'struct object_entry' values because the 'struct
pack_idx_entry' is the first member.

So this is (very densely) handling the translation from pack-order
to lex-order through the double pointer 'objects'. I'm not sure if
there is a way to make it more clear or if every reader will need
to do the same mental gymnastics I had to do.

> +}
> +
> +static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
> +{
> +	hashwrite(f, hash, the_hash_algo->rawsz);
> +}
> +
> +static const char *write_mtimes_file(const char *mtimes_name,
> +				     struct packing_data *to_pack,
> +				     struct pack_idx_entry **objects,
> +				     uint32_t nr_objects,
> +				     const unsigned char *hash)
> +{
> +	struct hashfile *f;
> +	int fd;
> +
> +	if (!to_pack)
> +		BUG("cannot call write_mtimes_file with NULL packing_data");
> +
> +	if (!mtimes_name) {
> +		struct strbuf tmp_file = STRBUF_INIT;
> +		fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
> +		mtimes_name = strbuf_detach(&tmp_file, NULL);
> +	} else {
> +		unlink(mtimes_name);
> +		fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
> +	}
> +	f = hashfd(fd, mtimes_name);
> +
> +	write_mtimes_header(f);
> +	write_mtimes_objects(f, to_pack, objects, nr_objects);
> +	write_mtimes_trailer(f, hash);
> +
> +	if (mtimes_name && adjust_shared_perm(mtimes_name) < 0)
> +		die(_("failed to make %s readable"), mtimes_name);

What could cause 'mtimes_name' to be NULL here? It seems that it would
be initialized in the "if (!mtimes_name)" block above.

> +
> +	finalize_hashfile(f, NULL,
> +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE | CSUM_FSYNC);
> +
> +	return mtimes_name;

Note that you return the name here...

> +	if (pack_idx_opts->flags & WRITE_MTIMES) {
> +		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
> +						    nr_written,
> +						    hash);
> +		if (adjust_shared_perm(mtimes_tmp_name))
> +			die_errno("unable to make temporary mtimes file readable");

...and then adjust the perms again. I think that this adjustment is
redundant, because it already happened within the write_mtimes_file()
method.

> +	}
> +
>  	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
>  	if (rev_tmp_name)
>  		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
> +	if (mtimes_tmp_name)
> +		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");

And then it is finally renamed here, if it had a temporary name to
start.

Thanks,
-Stolee
