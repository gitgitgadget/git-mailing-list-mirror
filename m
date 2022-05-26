Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B96C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbiEZTVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiEZTVv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 15:21:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD25DFF6B
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:21:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so5237302pju.1
        for <git@vger.kernel.org>; Thu, 26 May 2022 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=puGnolQGgKfgDGv0yqNypz2hUITZVWY+agpwdhUTwQ0=;
        b=TowzicKuSG3FMONfmS0gT+BWF/AKqMlYv6O4ksHkpqTtzMR8JTzNs3s8bkkiG6O3rZ
         cb8Z2ZIC/g9B/p99sCFx8SMGQUNkXEsNyPgJ9atESZjYA0YONHVsDTBbxyM0jFJN0ozS
         RbDMyrEbcXc9cQ+tE8fXuTAL6B35jRbPbQvGRhMoWf+H5l05cTGhg+dx5U8UDMK788O/
         pYeXXquOV21T9grolXESC4YSaWoqMkzvU1RZ0vxdCYZnEmmiUMeT0hCp++EsMMgng0bs
         eGWVSBd7LUM0oyh6fsZ37FxsX6dz3r+7t3gqonMtShPIjK/hoAsaaJ2HxsoA8DYT9NMZ
         vm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=puGnolQGgKfgDGv0yqNypz2hUITZVWY+agpwdhUTwQ0=;
        b=K8nBkfP+WhlweoRG3f+YijvgD2h0vVZRohzDcuOaGmO0v0nrYQWQcThR10MZHgxZ1l
         rqVRpYQHImVxihdwvXs5i+H3fhj8N9pBD3giZn6y6XW7H2EoX6ZtLLhXyqyTB8PQlbVV
         Gc6A4sFUAeRwzZENQJ/uD4cR2P4yZWZyz9PikbqA/J9NEI6TaxuJWKbj46BbaVReBkmx
         kIrzPD5k0uVt9V91iY4eVWKetnTVAJ2pWVHo8YF4UJ8fkKCZfvkQVjWMDtuyd241/AAY
         GnO6w8Or/Q7fQE0n+4fbojaLp3BPsbmtjXvuA9ymzl92+HiGoliidnloR51GIii6RsnK
         rZAQ==
X-Gm-Message-State: AOAM5315RIuqPkEX2S4b9VQCbqFO/hKSlP9F5zkSHZwmdmvgr8km5bc6
        nz3+NE0AwP/dwwuqBPmscbDr
X-Google-Smtp-Source: ABdhPJzYQACZ+Sq7S5M9gaxbDSj/cJW35SlaiU6WkCny8IfGBaOj6oOPCBUm8ybtXk9vzD98hKEsFQ==
X-Received: by 2002:a17:902:b698:b0:158:faee:442f with SMTP id c24-20020a170902b69800b00158faee442fmr40261080pls.75.1653592910003;
        Thu, 26 May 2022 12:21:50 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b0050dc7628146sm1855084pfl.32.2022.05.26.12.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 12:21:49 -0700 (PDT)
Message-ID: <f8509b71-1951-58fe-c12d-3ced30e4ed79@github.com>
Date:   Thu, 26 May 2022 12:21:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/4] builtin/pack-objects.c: ensure included
 `--stdin-packs` exist
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <cdc3265ec27f04accc433d9e4e54ac0edc3b3746.1653418457.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> A subsequent patch will teach `want_object_in_pack()` to set its
> `*found_pack` and `*found_offset` poitners to NULL when the provided

s/poitners/pointers

> pack does not pass the `is_pack_valid()` check.
> 
> The `--stdin-packs` mode of `pack-objects` is not quite prepared to
> handle this. To prepare it for this change, do the following two things:
> 
>   - Ensure provided packs pass the `is_pack_valid()` check when
>     collecting the caller-provided packs into the "included" and
>     "excluded" lists.
> 

Is the 'is_pack_valid()' check happening for the "excluded" packs? It looks
like you only added it for the packs in the "included" list in this patch.

>   - Gracefully handle any _invalid_ packs being passed to
>     `want_object_in_pack()`.
> 
> Calling `is_pack_valid()` early on makes it substantially less likely
> that we will have to deal with a pack going away, since we'll have an
> open file descriptor on its contents much earlier.
> 
> But even packs with open descriptors can become invalid in the future if
> we (a) hit our open descriptor limit, forcing us to close some open
> packs, and (b) one of those just-closed packs has gone away in the
> meantime.
> 
> `add_object_entry_from_pack()` depends on having a non-NULL
> `*found_pack`, since it passes that pointer to `packed_object_info()`,
> meaning that we would SEGV if the pointer became NULL (like we propose
> to do in `want_object_in_pack()` in the following patch).
> 
> But avoiding calling `packed_object_info()` entirely is OK, too, since
> its only purpose is to identify which objects in the included packs are
> commits, so that they can form the tips of the advisory traversal used
> to discover the object namehashes.
> 
> Failing to do this means that at worst we will produce lower-quality
> deltas, but it does not prevent us from generating the pack as long as
> we can find a copy of each object from the disappearing pack in some
> other part of the repository.
> 

The rest of this makes sense and (as far as I can tell) lines up with the
implementation below.

> Co-authored-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ec3193fd95..ffeaecd1d8 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3201,10 +3201,8 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  				      uint32_t pos,
>  				      void *_data)
>  {
> -	struct rev_info *revs = _data;
> -	struct object_info oi = OBJECT_INFO_INIT;
>  	off_t ofs;
> -	enum object_type type;
> +	enum object_type type = OBJ_NONE;
>  
>  	display_progress(progress_state, ++nr_seen);
>  
> @@ -3215,20 +3213,25 @@ static int add_object_entry_from_pack(const struct object_id *oid,
>  	if (!want_object_in_pack(oid, 0, &p, &ofs))
>  		return 0;
>  
> -	oi.typep = &type;
> -	if (packed_object_info(the_repository, p, ofs, &oi) < 0)
> -		die(_("could not get type of object %s in pack %s"),
> -		    oid_to_hex(oid), p->pack_name);
> -	else if (type == OBJ_COMMIT) {
> -		/*
> -		 * commits in included packs are used as starting points for the
> -		 * subsequent revision walk
> -		 */
> -		add_pending_oid(revs, NULL, oid, 0);
> +	if (p) {
> +		struct rev_info *revs = _data;
> +		struct object_info oi = OBJECT_INFO_INIT;
> +
> +		oi.typep = &type;
> +		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
> +			die(_("could not get type of object %s in pack %s"),
> +			    oid_to_hex(oid), p->pack_name);
> +		} else if (type == OBJ_COMMIT) {
> +			/*
> +			 * commits in included packs are used as starting points for the
> +			 * subsequent revision walk
> +			 */
> +			add_pending_oid(revs, NULL, oid, 0);
> +		}
> +
> +		stdin_packs_found_nr++;
>  	}
>  
> -	stdin_packs_found_nr++;
> -
>  	create_object_entry(oid, type, 0, 0, 0, p, ofs);
>  
>  	return 0;
> @@ -3346,6 +3349,8 @@ static void read_packs_list_from_stdin(void)
>  		struct packed_git *p = item->util;
>  		if (!p)
>  			die(_("could not find pack '%s'"), item->string);
> +		if (!is_pack_valid(p))
> +			die(_("packfile %s cannot be accessed"), p->pack_name);
>  	}
>  
>  	/*

