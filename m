Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3722820C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 20:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdFLUzW (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 16:55:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35637 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbdFLUzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 16:55:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id f127so15355151pgc.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lHxsxPKXrHJLPFkqiKEdOSApcDm3O56IrsYA4Y80PEs=;
        b=isB7KxNUj9DY3Xxp+cm6eHPWMBfAUFmBVVRRJgWtgK4CzGUjm7ouL0WrrfGamiWg9u
         88eBnSCmDNY7MjhRwfJDip/NPDnmVBzqBqOR5IWU8RT62skyLxIoGxuNyCcFIIQ8kreQ
         R9g0H4iqk1n0xtCPRBluY51tbXAAvBshOMF/3/LsezDx6XbsyI4AEOnHz67i8NItacte
         T/E+7Hs58eYHNau5vb5g0d6y26IkcvilX54FwLGOfvLq9M24fh/QLdXdT1uZNeNk5Hnm
         GrLlQ0JagCNlmRS67kw+4LUsvPS6wS1lIr1t/RNjV4PdptKp7Qn/h93NeUzkHTjTOKIe
         BXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lHxsxPKXrHJLPFkqiKEdOSApcDm3O56IrsYA4Y80PEs=;
        b=gj067JmSrMw3UAW0MI0ZsOIzWsfUDxTgoetabVOcnLi3+71uMGw02yu6z/VO0vlk25
         zQs9hlhx+HwVKGDUV2zhUq3OqvLyve2QNrgPiKLBMrE7jyy7NiEG+xTmWOCLwdhptQWJ
         xXAuxqYlC85GcjU7zmxvzUpoUK9RL+iIUgJR00svYgVNDSgA5ypoJ1bSQE/GrfqowQ+h
         XpLC2rorlupsv3SLfewB4/e0m0GZgSkZVqsoJJpvv0/wGpW9V26jdXr+d4Rufr/6sl4F
         e3YCImZ93YbJ05m6WWcaTWpiZQJ1a4YjnfVKu4ydFAvVkLkI08p95i8YUmJlXhCBiTy3
         exHQ==
X-Gm-Message-State: AODbwcAa/3i0j31Vymw6Aq1IIa/MCxYLjtBK//krU3xPVb+vUS6aP7gV
        SMJ3FPu2EKKfag==
X-Received: by 10.84.208.102 with SMTP id f35mr56053175plh.53.1497300920293;
        Mon, 12 Jun 2017 13:55:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id t20sm21275600pgo.29.2017.06.12.13.55.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 13:55:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] sha1_file: teach packed_object_info about typename
References: <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <e7a79c114b7131ba286bf3f76789b2efaeeb1cf1.1497035376.git.jonathantanmy@google.com>
Date:   Mon, 12 Jun 2017 13:55:18 -0700
In-Reply-To: <e7a79c114b7131ba286bf3f76789b2efaeeb1cf1.1497035376.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 9 Jun 2017 12:23:23 -0700")
Message-ID: <xmqqwp8hlydl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In commit 46f0344 ("sha1_file: support reading from a loose object of
> unknown type", 2015-05-06), "struct object_info" gained a "typename"
> field that could represent a type name from a loose object file, whether
> valid or invalid, as opposed to the existing "typep" which could only
> represent valid types. Some relatively complex manipulations were added
> to avoid breaking packed_object_info() without modifying it, but it is
> much easier to just teach packed_object_info() about the new field.
> Therefore, teach packed_object_info() as described above.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  sha1_file.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 59a4ed2ed..a52b27541 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2277,9 +2277,18 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
>  		*oi->disk_sizep = revidx[1].offset - obj_offset;
>  	}
>  
> -	if (oi->typep) {
> -		*oi->typep = packed_to_object_type(p, obj_offset, type, &w_curs, curpos);
> -		if (*oi->typep < 0) {
> +	if (oi->typep || oi->typename) {
> +		enum object_type ptot;
> +		ptot = packed_to_object_type(p, obj_offset, type, &w_curs,
> +					     curpos);
> +		if (oi->typep)
> +			*oi->typep = ptot;
> +		if (oi->typename) {
> +			const char *tn = typename(ptot);
> +			if (tn)
> +				strbuf_addstr(oi->typename, tn);
> +		}
> +		if (ptot < 0) {
>  			type = OBJ_BAD;
>  			goto out;
>  		}

OK.  When the caller wants to learn typename, we need to do this
type-to-string conversion somewhere anyway, and I agree that it is
better to do it here, instead of in the caller.





> @@ -2960,7 +2969,6 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  	struct cached_object *co;
>  	struct pack_entry e;
>  	int rtype;
> -	enum object_type real_type;
>  	const unsigned char *real = lookup_replace_object_extended(sha1, flags);
>  
>  	co = find_cached_object(real);
> @@ -2992,18 +3000,9 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  			return -1;
>  	}
>  
> -	/*
> -	 * packed_object_info() does not follow the delta chain to
> -	 * find out the real type, unless it is given oi->typep.
> -	 */
> -	if (oi->typename && !oi->typep)
> -		oi->typep = &real_type;
> -
>  	rtype = packed_object_info(e.p, e.offset, oi);
>  	if (rtype < 0) {
>  		mark_bad_packed_object(e.p, real);
> -		if (oi->typep == &real_type)
> -			oi->typep = NULL;
>  		return sha1_object_info_extended(real, oi, 0);
>  	} else if (in_delta_base_cache(e.p, e.offset)) {
>  		oi->whence = OI_DBCACHED;
> @@ -3014,10 +3013,6 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
>  					 rtype == OBJ_OFS_DELTA);
>  	}
> -	if (oi->typename)
> -		strbuf_addstr(oi->typename, typename(*oi->typep));
> -	if (oi->typep == &real_type)
> -		oi->typep = NULL;
>  
>  	return 0;
>  }
