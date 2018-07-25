Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FE7B1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 16:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbeGYRWH (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 13:22:07 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35025 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeGYRWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 13:22:06 -0400
Received: by mail-qk0-f194.google.com with SMTP id u21-v6so5245079qku.2
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=60w8UBCk6ggLkdPFsKz/eHhW0aP3J0XxgrccxjgCjno=;
        b=HTAMaVXjDTsCR2+B2dtQVL2y/3lEnTrihFNJZUoYJzbJvo4NXDZJkHwXB9mHpfiCXG
         cAe30KuWYz6Pp9WWBmWlrmwquF7vwv266Rq/9CPOZvZzVSrg5LV/TvUnojEe+yIiVpm9
         pzVbC9IguN7b2YlfBNja0pfUhicmP2p1snlKWYX1E28JNF5E9M8n95M8f8E6XjYcx79K
         k+8jj1O+qjHk9Uzv5UJNRi4pa3tKhgmdLnpR+Ah/vQE/enjS6pca+IX0oijNshunVJGL
         cjcM902zTh7NCu1OU4qeHC6QVEj2Be3AlJ8z8Nh5Vy7ApA67DtW/FAWVMP93mGCMrLGA
         1iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=60w8UBCk6ggLkdPFsKz/eHhW0aP3J0XxgrccxjgCjno=;
        b=oH6TEg83fFnjKWOpAGyF5eZ3p0w9Gbqpocb0DOnjFrtg/XJ2JBwShuhCkjd4gzFq5T
         4OKDBSx5mTOihjb1Gi3GkxzODW9E/arVcCrw/JJJkxQEJqXXAriuzue8Wn3jh6RYKZPj
         vDUyuOXdQdmjqhxHk9wlN9CJQlkkKdcFufCiXjXqsX4C5N1S0FkuhlSIQDLgf9/gyVzo
         jcT6Jc85nAM6fn1z0XZTL/jXcxdZt6HgKpOly8TL5Bw5H3CBcp/66ClqtE0ogwn6jNRv
         dbPES8SSqqRv+oRqbQPmYTlFE0ER6QBq98xQpcCaC/ZJQZJQfje2GYqyE/lvde6kkbTo
         +O+Q==
X-Gm-Message-State: AOUpUlEZ8aTVvsXpWbYv1iu80EZGT6VyxYezCIhB3JVYvtADeiOyM+v2
        lJT7PK8gT4P8Blm5B1pz0Ik=
X-Google-Smtp-Source: AAOMgpdHxVdSSVaDAQT86REAjfPA/nlnCUjJ+wpVYPJ7iYQOv0ZEyjglrVKiHEFmrfNXBd0/zXmULw==
X-Received: by 2002:a37:1348:: with SMTP id d69-v6mr19226876qkh.253.1532534985172;
        Wed, 25 Jul 2018 09:09:45 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id j86-v6sm14675267qkh.60.2018.07.25.09.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 09:09:44 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724151336.GA1957@duynguyen.home>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <93bf2b44-fd05-cb39-cbf2-16a0736f0561@gmail.com>
Date:   Wed, 25 Jul 2018 12:09:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724151336.GA1957@duynguyen.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/24/2018 11:13 AM, Duy Nguyen wrote:
> On Mon, Jul 23, 2018 at 04:51:38PM -0400, Ben Peart wrote:
>>>>> What's the current state of the index before this checkout?
>>>>
>>>> This was after running "git checkout" multiple times so there was really
>>>> nothing for git to do.
>>>
>>> Hmm.. this means cache-tree is fully valid, unless you have changes in
>>> index. We're quite aggressive in repairing cache-tree since aecf567cbf
>>> (cache-tree: create/update cache-tree on checkout - 2014-07-05). If we
>>> have very good cache-tree records and still spend 33s on
>>> traverse_trees, maybe there's something else.
>>>
>>
>> I'm not at all familiar with the cache-tree and couldn't find any
>> documentation on it other than index-format.txt which says "it helps
>> speed up tree object generation for a new commit."
> 
> I guess you have the starting points you need after Jeff's and Junio's
> explanation (and it would be great if cache-tree could actually be for
> for this two-way merge). But to make it easier for new people in
> future, maybe we should add this?
> 
> This is basically a ripoff of Junio's explanation with starting points
> (write-tree and index-format.txt). I wanted to incorporate some pieces
> from Jeff's too but I think Junio's already covered it well.
> 

I definitely like capturing this in the code or documentation somewhere. 
  Given I checked the header file for any hints on the design, I think 
that is a reasonable place to put it.

> -- 8< --
> Subject: [PATCH] cache-tree.h: more description of what it is and what's it used for
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   cache-tree.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/cache-tree.h b/cache-tree.h
> index cfd5328cc9..d25a800a72 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -5,6 +5,35 @@
>   #include "tree.h"
>   #include "tree-walk.h"
>   
> +/*
> + * cache-tree is an index extension that records tree object names for
> + * subdirectories you see in the index. It is mainly used for
> + * generating trees from the index before you create a new commit (see
> + * builtin/write-tree.c as starting point) but it's also used in "git
> + * diff-index --cached $TREE" as an optimization. See index-format.txt
> + * for on-disk format.
> + *
> + * Every time you write the contents of the index as a tree object, we

I had to read this a couple of times to figure out what was meant by 
"write the contents of the index as a tree object."  Maybe it was just 
me but how about something like:

"Every time you write a new tree object from the index you need to 
collect the object name for each top-level path and write a new 
top-level tree object out and then do the same recursively for any 
subdirectory."

> + * need to collect the object name for each top-level paths and write
> + * a new top-level tree object out, after doing the same recursively
> + * for any modified subdirectory. Whenever you add, remove or modify a
> + * path in the index, the cache-tree entry for enclosing directories
> + * are invalidated, so a cache-tree entry that is still valid means
> + * that all the paths in the index under that directory match the
> + * contents of the tree object that the cache-tree entry holds.
> + *
> + * And that property is used by "diff-index --cached $TREE" that is
> + * run internally.  When we find that the subdirectory "D"'s
> + * cache-tree entry is valid in the index, and the tree object
> + * recorded in the cache-tree for that subdirectory matches the
> + * subtree D in the tree object $TREE, then "diff-index --cached"
> + * ignores the entire subdirectory D (which saves relatively little in
> + * the index as it only needs to scan what is already in the memory
> + * forward, but on the $TREE traversal side, it does not have to even
> + * open a subtree, that can save a lot), and with a well-populated
> + * cache-tree, it can save a significant processing.
> + */
> +
>   struct cache_tree;
>   struct cache_tree_sub {
>   	struct cache_tree *cache_tree;
> 
