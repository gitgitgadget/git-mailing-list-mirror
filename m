Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2FFF20281
	for <e@80x24.org>; Fri, 15 Sep 2017 18:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdIOSn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 14:43:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36846 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdIOSn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 14:43:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id f84so1595675pfj.3
        for <git@vger.kernel.org>; Fri, 15 Sep 2017 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t05XsgIW0vd/v1hYoM8qNe9pkUEtSRPQqUSImM4YOVc=;
        b=SSdmgmcNUB2TxCBL06yCIDxNkG6HEDt4J7KVRRifdGfVe5EPl0AB18uiqjA+hPgmoD
         n3+WuwCdAJUaEV8472jbAjcWtXhITZMH+MWWogyoz51r1M13hOtrzwindRwp4htpzNcN
         08vknDgLaspIDeVqdHK5kHpme3py+glXEkJSmDgllis/qCCtnAyVzEX4t1qhXQYXX6rb
         IOl5I2of7DCudwEJfCr22l6wfd28y+ktmih5P5w5ObJ6fG5GMnt2Oqtg2PCp+0Vzzg81
         qextEe0DoeEcAWoH8GC4SYkDb1yd3pfIFFdTOALmWJXMDEqmdfhGUjxMQxypLFgMu0OZ
         ktMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t05XsgIW0vd/v1hYoM8qNe9pkUEtSRPQqUSImM4YOVc=;
        b=XXjokBC+5iuRJoJZujbiGQ5l0EHWq8xIWCq+9RCiCykeAGmZ5jJGKY7z/3FCkMZuFB
         EzPefSJY3z6WRa5EUwaaZWc3M7bgRF010PIVHl4Ftjc3cNEp3HTl7Wg59WIXiTEV53lo
         Gu6JALhu61l6QFjEsoameStpnRiuMifSbb6L5Rk+qOO7CzH5uwjk9WXSksMQLtDAE0LN
         Hjdrj8S+OLyWplqL/qXgPXeymicl87fkZAcl5yYtGhJ94mVVN+LQCnHnkhYEIZP4oLdZ
         e6Ufl9ePFgWCxICvF+lJ8zJC6yGxCNsGlG6ZSjUTTZsVQwtS4CYW6qSu98VAuyZQsMek
         M71w==
X-Gm-Message-State: AHPjjUhSZdq8x7fOsPucMYV1oMK+8IGPadMiZLk2h4qUkDopgCFa/V7u
        HgTBAs//ITTk2Q==
X-Google-Smtp-Source: ADKCNb5UY96mnyFlhNVldDc215I3SjZU0Wfeq8E6sSY5rNmbLT+o7o47f34FGUK1HDtptydwvEUc1w==
X-Received: by 10.99.95.145 with SMTP id t139mr25156462pgb.153.1505501005707;
        Fri, 15 Sep 2017 11:43:25 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:40d3:83c7:2f82:80ea])
        by smtp.gmail.com with ESMTPSA id y128sm3142630pfy.125.2017.09.15.11.43.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 15 Sep 2017 11:43:25 -0700 (PDT)
Date:   Fri, 15 Sep 2017 11:43:23 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty
 list
Message-ID: <20170915184323.GU27425@aiede.mtv.corp.google.com>
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Michael Haggerty wrote:

> If you pass a newly-initialized or newly-cleared `string_list` to
> `for_each_string_list_item()`, then the latter does
>
>     for (
>             item = (list)->items; /* note, this is NULL */
>             item < (list)->items + (list)->nr; /* note: NULL + 0 */
>             ++item)
>
> Even though this probably works almost everywhere, it is undefined
> behavior, and it could plausibly cause highly-optimizing compilers to
> misbehave.

Wait, NULL + 0 is undefined behavior?

*checks the standard*  C99 section 6.5.6.8 says

	"If both the pointer operand and the result point to elements
	of the same array object, or one past the last element of the
	array object, the evaluation shall not produce an overflow;
	otherwise, the behavior is undefined."

C99 section 7.17.3 says

	"NULL

	which expands to an implementation-defined null pointer constant"

6.3.2.3.3 says

	"An integer constant expression with the value 0, or such an
	expression cast to type void *, is called a null pointer
	constant.  If a null pointer constant is converted to a
	pointer type, the resulting pointer, called a null pointer, is
	guaranteed to compare unequal to a pointer to any object or
	function."

NULL doesn't point to anything so it looks like adding 0 to a null
pointer is indeed undefined.  (As a piece of trivia, strictly speaking
NULL + 0 would be undefined on some implementations and defined on
others, since an implementation is permitted to #define NULL to 0.)

So Coverity is not just warning because it is not able to guarantee
that list->nr is 0.  Huh.

> It would be a pain to have to change the signature of this macro, and
> we'd prefer not to add overhead to each iteration of the loop. So
> instead, whenever `list->items` is NULL, initialize `item` to point at
> a dummy `string_list_item` created for the purpose.

What signature change do you mean?  I don't understand what this
paragraph is alluding to.

> This problem was noticed by Coverity.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
[...]
>  string-list.c | 2 ++
>  string-list.h | 7 +++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Does the following alternate fix work?  I think I prefer it because
it doesn't require introducing a new global.

Thanks,
Jonathan

diff --git i/string-list.h w/string-list.h
index 29bfb7ae45..dae33fbb89 100644
--- i/string-list.h
+++ w/string-list.h
@@ -33,7 +33,9 @@ typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 int for_each_string_list(struct string_list *list,
 			 string_list_each_func_t, void *cb_data);
 #define for_each_string_list_item(item,list) \
-	for (item = (list)->items; item < (list)->items + (list)->nr; ++item)
+	for (item = (list)->items; \
+	     (list)->items && item < (list)->items + (list)->nr; \
+	     ++item)
 
 /*
  * Apply want to each item in list, retaining only the ones for which
