Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0A41F405
	for <e@80x24.org>; Fri, 10 Aug 2018 00:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeHJCve (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 22:51:34 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:56366 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeHJCve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 22:51:34 -0400
Received: by mail-it0-f73.google.com with SMTP id g4-v6so366190itf.6
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 17:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=S0qqKzjpV9vDcbiGw9zAwGYAGtP7XG4WWxQ0edBS9IY=;
        b=sZfDF3u2BEG0VjjV6YDz1SzkA3cU75q7+Er0APCXLfeZ90yYCReSXaaYbQXrBBcnDX
         6IfFvyGi8v3X1HEYZIclo3d843yshm3zFf6USDCO7/7zYKJ6gJ8BO30iXSmjCTLLvcA1
         nlYNIO2koe0yH56VCabIdozMDQIfjv/N+Y1X6X+K3G3uw5W8bHXxR9DVRmZ63tItXCK/
         cCDNzsBNxEx0FW8KCM8a1Vi9V6Z7EF+43hUwy+/pTH5/Ru3o630dePmjlphnKTyTf8wz
         yyK34lGcoLwV3xV8xRbsVvBxmvI5CkLsCmIteEvM1BeoB0X5FssDkG7RclqWvG3wWyS9
         foOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S0qqKzjpV9vDcbiGw9zAwGYAGtP7XG4WWxQ0edBS9IY=;
        b=nPpPtAWu4YWGAhiWNP/MUAAuo1RI663kvbQ/NW3C0sopG98SY19WfYajPlmPROCBaL
         WSQginxX7joOo5+ztKgrMb+bMFkA/Eppq2WOar2B/B43TxqPXnnQZ0sZLzHMTS54mvha
         Qj+aiAgMRM+pCC/lb+zdOI/DvpOSTkomxAiuPvzOiU1fA96XJVshb/kz58g23P7lwR2p
         K7jRPmCk199EDgVB2mu4LdKegH8Si9tCuorCNR3TJueBhuDqFJ0H67fO1IyGzTDew0Fj
         JRcWoXgRn4hX47ZFahzD5r6FF2KT9xZ0cBYHEdtERIp6+wSr6Hc/KPVBTd7IcfuZMSzD
         UN4Q==
X-Gm-Message-State: AOUpUlFhPaRnGpm0NDYhZu2LGdwnY5Cxd4Nyd+8+KXtxXMEYdGavJdef
        jck0H6/j3lxYLjJanyaL6ofezzdaCFUcUYg8+8tt
X-Google-Smtp-Source: AA+uWPzF69I0f2/0GuciW5f9shueVAcBqG8BGQ5sPjj0TA2JyBHrYpeZ3GEdgiynokJHpvlWQ116Uu4uayLQ61xrAnRL
X-Received: by 2002:a6b:ee0e:: with SMTP id i14-v6mr1800601ioh.112.1533860654602;
 Thu, 09 Aug 2018 17:24:14 -0700 (PDT)
Date:   Thu,  9 Aug 2018 17:24:11 -0700
In-Reply-To: <54d827e7c0dc757451fa10f5bd0752e1e3356281.1533854545.git.matvore@google.com>
Message-Id: <20180810002411.13447-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <54d827e7c0dc757451fa10f5bd0752e1e3356281.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: Re: [PATCH 5/5] rev-list: handle missing tree objects properly
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -209,7 +210,8 @@ static inline void finish_object__ma(struct object *obj)
>  	 */
>  	switch (arg_missing_action) {
>  	case MA_ERROR:
> -		die("missing blob object '%s'", oid_to_hex(&obj->oid));
> +		die("missing %s object '%s'",
> +		    type_name(obj->type), oid_to_hex(&obj->oid));
>  		return;
>  
>  	case MA_ALLOW_ANY:
> @@ -222,8 +224,8 @@ static inline void finish_object__ma(struct object *obj)
>  	case MA_ALLOW_PROMISOR:
>  		if (is_promisor_object(&obj->oid))
>  			return;
> -		die("unexpected missing blob object '%s'",
> -		    oid_to_hex(&obj->oid));
> +		die("unexpected missing %s object '%s'",
> +		    type_name(obj->type), oid_to_hex(&obj->oid));
>  		return;

Once again, I'll do a fuller review tomorrow.

These are fine (obj->type is populated), because the types of objects
are known during traversal.

> -	if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
> +	if (!has_object_file(&obj->oid)) {
>  		finish_object__ma(obj);
>  		return 1;

And this is also fine, because finish_object__ma can now handle any
object type.

> +	revs.show_missing_trees = 1;

(and elsewhere)

Could we just show missing trees all the time? We do that for blobs and
already rely on the caller (eventually, show_object() in
builtin/rev-list.c) to determine whether the object actually exists or
not; we could do the same for trees. This allows us to not include this
extra knob.

> -	if (parse_tree_gently(tree, gently) < 0) {
> +	parse_result = parse_tree_gently(tree, gently);
> +	if (parse_result < 0 && !revs->show_missing_trees) {
>  		if (revs->ignore_missing_links)
>  			return;
>  
> @@ -182,7 +185,8 @@ static void process_tree(struct traversal_context *ctx,
>  	if (base->len)
>  		strbuf_addch(base, '/');
>  
> -	process_tree_contents(ctx, tree, base);
> +	if (parse_result >= 0)
> +		process_tree_contents(ctx, tree, base);
>  
>  	if ((obj->flags & NOT_USER_GIVEN) && ctx->filter_fn) {
>  		r = ctx->filter_fn(LOFS_END_TREE, obj,

Is it possible to call the appropriate callbacks and then return
immediately, instead of going through the whole function checking
parse_result when necessary? When doing the latter, the reader needs to
keep on checking if each function still works if the tree is
unparseable.
