Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FCBEB64DC
	for <git@archiver.kernel.org>; Tue, 11 Jul 2023 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGKVYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jul 2023 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGKVYl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2023 17:24:41 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE811B
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 14:24:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89b75dc1cso395795ad.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2023 14:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1689110679; x=1691702679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NSEIwVxjEjaRXQ5iDz+ITCyxMUMWvWRiHFWYZM2CoUg=;
        b=iA7u/8lyJMeO9o+dg6CwO3y9oosPzD0WS8GcIgn4cgrf0cr3tSVQrb1zMOdkpaATQw
         1kyvY1nCq2NT/zHA+SLzUDEPzGe4bIh6nHzSRzYSByr+GqPsb/imkFx4HHi8f0A4TDqj
         hwADL850NN+8/s8dNEtDv6VLbTsRGFhw0UsxdmyGC+eZ2igVorsPZ31fvH1YBoKCso/0
         RMkjG3vH/hgCuGy1v9OKybOqFkF8SE+uWkDfl3XZzfmQKUf87paldGOuhHBkTgeOUrUM
         Mbwjisk+A1eYM76AE89U/23f1Cu1rPH5nbx2DueUb0yP08rtiVXekWIBa6XCa7k85dJs
         97rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689110679; x=1691702679;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSEIwVxjEjaRXQ5iDz+ITCyxMUMWvWRiHFWYZM2CoUg=;
        b=jRx5wHgtod3VKqbj28OQh3Gk/ls3J5hCWlUpdOafOWrcL4tWbeR1actceJmYdk7sJ3
         2XR209U7VAgfAycsjzThSw9wXbVL0XhCSxqMrM3W4W39t/XAJeH+5b+m/1Y5qrRnWRpA
         4yLMKW+NNeB6d98toZt2E1UXENKBkIiwb1AqBm1BtisGOM4MkavoZpOhp3IQAv02gO4D
         /lXXR2L/Bmh65v9OV9vRW24tiHqUd6ERa5T4PoCJszMHkn5V8seWS6xMmlNl2MPopaEx
         SGkewlfPgK7Njz5Suz7ch5bcOhWqyv48yoZWZ95tAh7zxgZ05sVAeLVZLF0zRp4E6fFu
         CHKw==
X-Gm-Message-State: ABy/qLaHXFQdGi4y2sq3FMzSLGy2Vnyze7ZUyn56DUO4dR5qlNemwkkq
        bSBPtJDCZzhVWTjCkFbu4xFI0S4hRagz1wSRQA==
X-Google-Smtp-Source: APBJJlGhOnkSxZnlvT0pNUED3eoWUnvyUojb7QkEA64CJVrUPdOu8OuZFLh/f5aXZInOyglBEFEg7A==
X-Received: by 2002:a17:902:e884:b0:1b8:948b:41b6 with SMTP id w4-20020a170902e88400b001b8948b41b6mr35077plg.10.1689110679257;
        Tue, 11 Jul 2023 14:24:39 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id y24-20020a1709029b9800b001ac5896e96esm2362000plp.207.2023.07.11.14.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 14:24:38 -0700 (PDT)
Message-ID: <e4a77d0f-cf1d-ef76-fe26-ad5e58372a02@github.com>
Date:   Tue, 11 Jul 2023 14:24:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] attr.c: read attributes in a sparse directory
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230707151839.504494-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-1-cheskaqiqi@gmail.com>
 <20230711133035.16916-2-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230711133035.16916-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> 'git check-attr' cannot currently find attributes of a file within a
> sparse directory. This is due to .gitattributes files are irrelevant in
> sparse-checkout cone mode, as the file is considered sparse only if all
> paths within its parent directory are also sparse. 

If .gitattributes files are irrelevant in sparse-checkout cone mode, then
why are we changing the behavior? If you're challenging that assertion,
please state so clearly.

> In addition,> searching for a .gitattributes file causes expansion of the sparse
> index, which is avoided to prevent potential performance degradation.

This isn't an unchangeable fact (as your implementation below shows).
Expanding the index is just the most straightforward approach, but the
performance cost of that is (AFAICT) a reason used to justify why we didn't
read sparse directory attributes in the past.

> 
> However, this behavior can lead to missing attributes for files inside
> sparse directories, causing inconsistencies in file handling.
> 
> To resolve this, revise 'git check-attr' to allow attribute reading for
> files in sparse directories from the corresponding .gitattributes files:
> 
> 1.Utilize path_in_cone_mode_sparse_checkout() and index_name_pos_sparse
> to check if a path falls within a sparse directory.
> 
> 2.If path is inside a sparse directory, employ the value of
> index_name_pos_sparse() to find the sparse directory containing path and
> path relative to sparse directory. Proceed to read attributes from the
> tree OID of the sparse directory using read_attr_from_blob().
> 
> 3.If path is not inside a sparse directory，ensure that attributes are
> fetched from the index blob with read_blob_data_from_index().

Makes sense to me.

> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  attr.c | 47 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 7d39ac4a29..be06747b0d 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -808,35 +808,44 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
>  static struct attr_stack *read_attr_from_index(struct index_state *istate,
>  					       const char *path, unsigned flags)
>  {
> +	struct attr_stack *stack = NULL;
>  	char *buf;
>  	unsigned long size;
> +	int pos;
>  
>  	if (!istate)
>  		return NULL;
>  
>  	/*
> -	 * The .gitattributes file only applies to files within its
> -	 * parent directory. In the case of cone-mode sparse-checkout,
> -	 * the .gitattributes file is sparse if and only if all paths
> -	 * within that directory are also sparse. Thus, don't load the
> -	 * .gitattributes file since it will not matter.
> -	 *
> -	 * In the case of a sparse index, it is critical that we don't go
> -	 * looking for a .gitattributes file, as doing so would cause the
> -	 * index to expand.
> +	 * If the pos value is negative, it means the path is not in the index. 
> +	 * However, the absolute value of pos minus 1 gives us the position where the path 
> +	 * would be inserted in lexicographic order. By subtracting another 1 from this 
> +	 * value (pos = -pos - 2), we find the position of the last index entry 
> +	 * which is lexicographically smaller than the provided path. This would be 
> +	 * the sparse directory containing the path.

This is a good explanation of what '-pos - 2' represents, but it doesn't
explain why we'd want that value. Could you add a bit of detail around why
1) we care whether 'pos' identifies a value that exists in the index or not,
and 2) why we're looking for the sparse directory containing the path?

>  	 */
> -	if (!path_in_cone_mode_sparse_checkout(path, istate))
> -		return NULL;
> +	pos = index_name_pos_sparse(istate, path, strlen(path));
> +	pos = - pos - 2;

nit: don't add the space between '-' and 'pos'. This should be:

	pos = -pos - 2;

>  
> -	buf = read_blob_data_from_index(istate, path, &size);
> -	if (!buf)
> -		return NULL;
> -	if (size >= ATTR_MAX_FILE_SIZE) {
> -		warning(_("ignoring overly large gitattributes blob '%s'"), path);
> -		return NULL;
> -	}
> +	if (!path_in_cone_mode_sparse_checkout(path, istate) && 0 <= pos) {

Typically, we try to put the less expensive operation first in a condition
like this (if the first part of the condition is 'false', the second part
won't be evaluated). 'path_in_cone_mode_sparse_checkout()' is more expensive
than a simple numerical check, so this should probably be:

	if (pos >= 0 && !path_in_cone_mode_sparse_checkout(path, istate)) {

But on a more general note, why check 'path_in_cone_mode_sparse_checkout()'
at all? The goal is to determine whether 'path' is inside a sparse
directory, so first you search the index to find where that directory would
be, then - if 'path' isn't in the sparse-checkout cone - check whether the
index entry you found is a sparse directory. But sparse directories can't
exist within the sparse-checkout cone in the first place, so the
'path_in_cone_mode_sparse_checkout()' is redundant. 

Instead, 'path_in_cone_mode_sparse_checkout()' (and probably
'istate->sparse_index', since sparse directories can't exist if the index
isn't sparse) could be used to avoid calculating 'index_name_pos_sparse()'
in the first place; the index search operation is generally more expensive
than 'path_in_cone_mode_sparse_checkout()', especially when sparse-checkout
is disabled entirely.

> +		if (!S_ISSPARSEDIR(istate->cache[pos]->ce_mode))
> +			return NULL;
>  
> -	return read_attr_from_buf(buf, path, flags);
> +		if (strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos])) == 0) {

All of these nested conditions could be simplified/collapsed into a single,
top-level condition:

	if (pos >= 0 && !path_in_cone_mode_sparse_checkout(path, istate) &&
	    S_ISSPARSEDIR(istate->cache[pos]->ce_mode) &&
	    !strncmp(istate->cache[pos]->name, path, ce_namelen(istate->cache[pos]))) {

IMO, this also more clearly reflects _why_ you'd want to enter this
condition and read from the index directly:

* If the path is not in the sparse-checkout cone
* AND the index entry preceding 'path' is a sparse directory
* AND the sparse directory is the prefix of 'path' (i.e., 'path' is in the
  directory) 
    -> Read from the sparse directory's tree

One other quick sanity check - for the sparse directory prefixing check to
work, 'path' needs to be a normalized path relative to the root of the repo.
Is that guaranteed to be the case here?

> +			const char *relative_path = path + ce_namelen(istate->cache[pos]);  

Here, you get the relative path within the sparse directory by skipping past
the sparse directory name in 'path'. If 'path' is normalized (see above),
this works. Nice!

> +			stack = read_attr_from_blob(istate, &istate->cache[pos]->oid, relative_path, flags);
> +		}
> +	} else {
> +		buf = read_blob_data_from_index(istate, path, &size);
> +		if (!buf)
> +			return NULL;
> +		if (size >= ATTR_MAX_FILE_SIZE) {
> +			warning(_("ignoring overly large gitattributes blob '%s'"), path);
> +			return NULL;
> +		}
> +		stack = read_attr_from_buf(buf, path, flags);
> +	}
> +	return stack;
>  }
>  
>  static struct attr_stack *read_attr(struct index_state *istate,

