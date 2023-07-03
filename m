Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB63DC3063F
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGCR7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGCR7e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:59:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43231E7E
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:59:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6686708c986so3895305b3a.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1688407162; x=1690999162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rY8I03D8gk2UxOvAJSbZDxkrnMNwXQMed5QMcdlm9oE=;
        b=HRH0MNT0V6ugifRLjs3j14qs67W1Z/Sa2AQCXZJIzg1pkU3vK2wQs+vlY0Xuo+5hv8
         90dn/Opeba6RHdWTfUL3BtZ+LldIQJLzJoMbjbN8r+asoJPbPyYJlOIpZ4Jt2BkUXeQV
         Bo5MfG1u/PYHm38upF28h0Mf+wp6xVDODTIdlleOtWAKfuFX1j8jHrXhklfU4eFSSebo
         SP+2Vp7yFs5657TA2i/gAxfjPSMYe39nQZ9TH+vU7dAqVaCEP1DBKXmgXMK1rj2F3wQl
         2jmPJkui8Aajk13/4tOApfWG2ASfYZ1rUrlUpDhZ5LRU+bbOR8WuGGXRQblkcZlxl6jk
         kCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407162; x=1690999162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY8I03D8gk2UxOvAJSbZDxkrnMNwXQMed5QMcdlm9oE=;
        b=EtJrjyTvI6/QbI+9xTV+bRBpRu4h77ZJNLujJvDmnlMfMUNi4jjo4CbGSHRxgt37Hw
         0XoBy/a1KJ6DsFEVbxK0sqAVyoRv0d9FTvVlBxLCGWBx2SUP8JK2/0Iez2wgUiyh2+66
         LKA1BQ4EOYBuiq2abI72fRYzP8C+xRNNr1gwctcpnRNF48amR1u5LAC8quvtcAdl6L71
         dWr318Kojf48k/0n/drGGdEBXXrC0tJ//E2PInTklMyVUTXSKrPcN0fSehjfNsAQuqys
         EhhnCXRC2fvixdco+fKB0ituPjVX2mKOnGJ69+wvJIRIKBBOudphcK2w6ACGRfAMwFL5
         CWog==
X-Gm-Message-State: ABy/qLZfdYmjMpwqRChN2tx07DU2o0FC/wueddMJODUMfrd3ICTHvLVC
        pd+EaOfFgW+JX7Tgi1T2QSuCcuq4PGatnShodw==
X-Google-Smtp-Source: APBJJlEc9+cQuNwHD51su2XMde0Cklrwm8UOi9qpK5G3P6LUF/7m+I3lSHMe4Zd9qKxoLQKVx4S9kA==
X-Received: by 2002:a05:6a00:2389:b0:67e:6269:6ea8 with SMTP id f9-20020a056a00238900b0067e62696ea8mr17296632pfc.22.1688407161659;
        Mon, 03 Jul 2023 10:59:21 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id r2-20020a62e402000000b00672401787c6sm13056260pfh.109.2023.07.03.10.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 10:59:21 -0700 (PDT)
Message-ID: <d1e8af2e-f03c-9fad-7a6f-256545f56f9a@github.com>
Date:   Mon, 3 Jul 2023 10:59:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/3] attr.c: read attributes in a sparse directory
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20230701064843.147496-1-cheskaqiqi@gmail.com>
 <20230701064843.147496-2-cheskaqiqi@gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230701064843.147496-2-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Before this patch,`git check-attr` can't find the attributes of a file
> within a sparse directory. In order to read attributes from
> '.gitattributes' files that may be in a sparse directory:
> 
> When path is in cone mode of sparse checkout:
> 
> 1.If path is a sparse directory, read the tree OIDs from the sparse

s/path is a sparse directory/path is in a sparse directory(?)

> directory.
> 
> 2.If path is a regular files, read the attributes directly from the blob

s/files/file

> data stored in the cache.
> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  attr.c | 64 +++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/attr.c b/attr.c
> index 7d39ac4a29..b0d26da102 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -808,35 +808,57 @@ static struct attr_stack *read_attr_from_blob(struct index_state *istate,
>  static struct attr_stack *read_attr_from_index(struct index_state *istate,
>  					       const char *path, unsigned flags)
>  {

nit: there are a few instances below of spacing inconsistent with project
styling: 'if(' instead of 'if (', 'x&&y' instead of 'x && y', etc. Please
adjust your  to match in your next re-roll (using CodingGuidelines and/or
surrounding code for reference).

> +	struct attr_stack *stack = NULL;
> +	int i;
> +	struct strbuf path1 = STRBUF_INIT;
> +	struct strbuf path2 = STRBUF_INIT;
> +	char *first_slash = NULL;
>  	char *buf;
>  	unsigned long size;
>  
>  	if (!istate)
>  		return NULL;
>  
> -	/*
> -	 * The .gitattributes file only applies to files within its
> -	 * parent directory. In the case of cone-mode sparse-checkout,
> -	 * the .gitattributes file is sparse if and only if all paths
> -	 * within that directory are also sparse. Thus, don't load the
> -	 * .gitattributes file since it will not matter.
> -	 *
> -	 * In the case of a sparse index, it is critical that we don't go
> -	 * looking for a .gitattributes file, as doing so would cause the
> -	 * index to expand.
> -	 */
> -	if (!path_in_cone_mode_sparse_checkout(path, istate))
> -		return NULL;

Could you add some details to your commit message explaining why the
reasoning in this comment no longer applies? I agree with your approach, but
the extra context will make it easier for reviewers and future readers to
evaluate whether _they_ agree with it, as well as determine whether your
implementation aligns with your stated goal.

As for this review, I'll assume that we now _always_ want to read
.gitattributes, regardless of 'SKIP_WORKTREE' or whether .gitattributes is
contained within a sparse directory. Please correct me if that
interpretation is incorrect!

> -
> -	buf = read_blob_data_from_index(istate, path, &size);
> -	if (!buf)
> -		return NULL;
> -	if (size >= ATTR_MAX_FILE_SIZE) {
> -		warning(_("ignoring overly large gitattributes blob '%s'"), path);
> -		return NULL;
> +	first_slash = strchr(path, '/');
> +	if (first_slash) {
> +		strbuf_add(&path1, path, first_slash - path + 1);
> +		strbuf_addstr(&path2, first_slash + 1);
>  	}

At this point, 'path1' is the first component of a given path, and 'path2'
is "everything else". If 'path' is 'path/to/my/.gitattributes', 'path1' is
"path" and 'path2' is "to/my/.gitattributes". Looks good.

>  
> -	return read_attr_from_buf(buf, path, flags);
> +	if(!path_in_cone_mode_sparse_checkout(path, istate)){> +		for (i = 0; i < istate->cache_nr; i++) {
> +			struct cache_entry *ce = istate->cache[i];
> +			if ( !strcmp(istate->cache[i]->name, path1.buf)&&S_ISSPARSEDIR(ce->ce_mode)) {
> +				stack = read_attr_from_blob(istate, &ce->oid, path2.buf, flags);

Here, you use 'read_attr_from_blob()' to read from the sparse directory's
tree directly _without_ needing to expand the index. Nice!

> +			}else if(S_ISREG(ce->ce_mode) && !strcmp(istate->cache[i]->name, path)){
> +				unsigned long sz;
> +				enum object_type type;
> +				void *data;
> +
> +				data = repo_read_object_file(the_repository, &istate->cache[i]->oid,
> +							&type, &sz);
> +				if (!data || type != OBJ_BLOB) {
> +					free(data);
> +					strbuf_release(&path1);
> +					strbuf_release(&path2);
> +					return NULL;
> +				}
> +				stack = read_attr_from_buf(data, path, flags);
> +			}
> +		}


On the whole, this patch updates the the treatment of a 'path' outside the
sparse-checkout patterns to first iterate through the index and at each
entry:

1. If the entry is a sparse directory _and_ the first component of 'path'
   matches the sparse directory name, read the .gitattributes with
   'read_attr_from_blob()'. 'read_attr_from_blob()' reads from the tree
   pointed to by the sparse directory using only the part of 'path' that is
   inside that sparse directory.
2. If the entry is _not_ a sparse directory _and_ its name matches the full
   'path', we read the blob by OID into a buffer, then
   'read_attr_from_buffer()'.

The general idea behind this makes sense (if .gitattributes is in a sparse
directory, read from the sparse directory tree; if not, directly read the
index), but the implementation as it is now has a few gaps/inefficiencies:

- If the sparse directory is not top-level (e.g., a sparse directory at
  'folder1/foo/'), the .gitattributes will be ignored completely.
- The iteration through the index continues even after we've read from the
  correct .gitattributes entry.
- The "else if" case above shouldn't functionally be any different from the
  "else" case below (both read the .gitattributes blob directly from the
  index) but their implementations are different.

To avoid those issues, you could adjust the structure of the code to more
explicitly match what you described in your commit message:

	if (*path is inside sparse directory*)
		stack = read_attr_from_blob(istate, 
					    *sparse directory containing path*, 
					    *path relative to sparse directory*, 
					    flags);
	else
		stack = *read .gitattributes from index blob*

Then fill in the pseudocode bits with concrete details:

- "read .gitattributes from index blob" is the most straightforward; it's
  what you have in the "else" block below.
- "path is inside sparse directory" can be determined using a combination of
  'path_in_cone_mode_sparse_checkout()' & 'index_name_pos_sparse()'. An
  example of similar logic can be found in 'entry_is_new_sparse_dir()' in
  'unpack-trees.c'.
- "sparse directory containing path" and "path relative to sparse directory"
  can be determined from the results of 'index_name_pos_sparse()'.

> +	}else{
> +		buf = read_blob_data_from_index(istate, path, &size);
> +		if (!buf)
> +			return NULL;
> +		if (size >= ATTR_MAX_FILE_SIZE) {
> +			warning(_("ignoring overly large gitattributes blob '%s'"), path);
> +			return NULL;
> +		}
> +		 stack = read_attr_from_buf(buf, path, flags);
> +	}
> +	strbuf_release(&path1);
> +	strbuf_release(&path2);
> +	return stack;

These changes should affect the behavior sparse index-integrated commands
that read attributes (e.g. 'git merge'). Would it be possible to test that?
E.g. take the 't1092' test 'merge with conflict outside cone', but add
smudge/clean filters in .gitattributes files inside the affected sparse
directories.

>  }
>  
>  static struct attr_stack *read_attr(struct index_state *istate,

