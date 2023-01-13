Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A37C61DB3
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjAMK2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbjAMK14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:27:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EA048CEA
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:27:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t5so16208856wrq.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubKTqwa17C/cqIQGNRLyUlfoWAQs3vUdw+y6e7tU114=;
        b=L+hhaB8K7Cm51kMV3z8fpX8w2ToYkx/JpiT6hWklpGHrV2t/OLQf8MMEmleFpoe5lJ
         MoTpp67X5FknQvkQQOHgn3SSjgy9EQEFWKyh/RT3RC7jGjby198ub3d0kJaoW8USo9Jw
         3wThXeBixnh0IV9gosveMByZzsA5mIihoytl4NkEPevg9UWCa8cnIUTereq6LxvJgDCN
         LryH2BVuCvJwlgvhzPvkDtbIoJmgqpH1o3NRVLXY2DDEqKY3GGF3ITCPQkx69vk/QZdL
         NVmhCgwXP2o5LhnuxwiM9ellJ0ZZ+bgSedZ+kLKvy7X/fw8nHrdKirpBKJYh08Z8hzo8
         /ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubKTqwa17C/cqIQGNRLyUlfoWAQs3vUdw+y6e7tU114=;
        b=VKfU8tE7z5o92bpCgWfhDsa1DPPbbCYPvXX/PUGiaD9pI+0WmVZNzhuJZG6EpeF33u
         PplyXHSRsY+2jtr94miYQxqye3wyDak7q+2pcyXms2oNCQc6Tt4k9+kCQ1Iws3nTBMYr
         z4u+uOYBoRaxUSFLKcysCrtOYBS+QgOJHkw01qSxgeHZb2KjU5LaoSt4hLVXXKZUZrfF
         5qZwllcxUJyQOPyIy1GysAgmQIj58uj8DmG9RLkHYC+rF6aCDzpE3o4icTZ3koxChxVQ
         HwFIPAlQj7nt6K5k6++QMP75QHnPOC/dWIHypFgRd1qmlfZV0iPn1KV27j5VU+Gpo1O9
         wucA==
X-Gm-Message-State: AFqh2kqUfEMkbcZKTVKRjM2tNI22bEcdb99eyaBlQ2yyyC2pF8baiGTw
        JXdqbHF/6VrkUeGVNeAlNj//UM/DSzc=
X-Google-Smtp-Source: AMrXdXtVeBb+DbVmFbP5fv4mHqdlVp7MFpzzONeeM/PbqZDjxvOnA5TgDoX74BYKAeyaZRLMz/5iEg==
X-Received: by 2002:a5d:5049:0:b0:2bd:15c6:a88a with SMTP id h9-20020a5d5049000000b002bd15c6a88amr9420553wrt.54.1673605667235;
        Fri, 13 Jan 2023 02:27:47 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm18756516wrj.2.2023.01.13.02.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:27:46 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <43f8cc69-1069-f8f9-d0b4-c7d5c330e3c8@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 10:27:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 0/2] check-attr: add support to work with tree-ish
Content-Language: en-US
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc:     sunshine@sunshineco.com
References: <https://lore.kernel.org/git/cover.1671793109.git.karthik.188@gmail.com/>
 <cover.1673521102.git.karthik.188@gmail.com>
In-Reply-To: <cover.1673521102.git.karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Karthik

On 12/01/2023 11:00, Karthik Nayak wrote:
> v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
> v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t
> v3: https://lore.kernel.org/git/20221216093552.3171319-1-karthik.188@gmail.com/
> v4: https://lore.kernel.org/git/cover.1671630304.git.karthik.188@gmail.com
> v5: https://lore.kernel.org/git/cover.1671793109.git.karthik.188@gmail.com/
> 
> Given a pathname, git-check-attr(1) will list the attributes which apply to that
> pathname by reading all relevant gitattributes files. Currently there is no way
> to specify a tree-ish to read the gitattributes from.
> 
> This is specifically useful in bare repositories wherein the gitattributes are
> only present in the git working tree but not available directly on the
> filesystem.
> 
> This series aims to add a new flag `--source` to git-check-attr(1) which
> allows us to read gitattributes from the specified tree-ish.
> 
> Changes since v5:
> - Changed the documentation and helper code to say 'tree-ish' instead of 'tree'
> - Fixed broken tests because of missing `&&`
> 
> Range-diff against v5:
> 
> 1:  6224754179 = 1:  6224754179 t0003: move setup for `--all` into new block
> 2:  d835d989ad ! 2:  57f5957127 attr: add flag `--source` to work with tree-ish
>      @@ Documentation/git-check-attr.txt: git-check-attr - Display gitattributes informa
>        [verse]
>       -'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
>       -'git check-attr' --stdin [-z] [-a | --all | <attr>...]
>      -+'git check-attr' [--source <tree>] [-a | --all | <attr>...] [--] <pathname>...
>      -+'git check-attr' --stdin [-z] [--source <tree>] [-a | --all | <attr>...]
>      ++'git check-attr' [--source <tree-ish>] [-a | --all | <attr>...] [--] <pathname>...
>      ++'git check-attr' --stdin [-z] [--source <tree-ish>] [-a | --all | <attr>...]
>        
>        DESCRIPTION
>        -----------
>      @@ Documentation/git-check-attr.txt: OPTIONS
>        	If `--stdin` is also given, input paths are separated
>        	with a NUL character instead of a linefeed character.
>        
>      -+--source=<tree>::
>      -+	Check attributes against the specified tree-ish. Paths provided as part
>      -+	of the revision will be treated as the root directory. It is common to
>      ++--source=<tree-ish>::
>      ++	Check attributes against the specified tree-ish. It is common to
>       +	specify the source tree by naming a commit, branch or tag associated
>       +	with it.
>       +
>      @@ attr.c: void git_check_attr(struct index_state *istate,
>        		const char *name = check->all_attrs[i].attr->name;
>       
>        ## attr.h ##
>      +@@
>      + #ifndef ATTR_H
>      + #define ATTR_H
>      +
>      ++#include "hash.h"
>      ++
>      + /**
>      +  * gitattributes mechanism gives a uniform way to associate various attributes
>      +  * to set of paths.
>       @@ attr.h: void attr_check_free(struct attr_check *check);
>        const char *git_attr_name(const struct git_attr *);
>        
>      @@ builtin/check-attr.c
>        static const char * const check_attr_usage[] = {
>       -N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
>       -N_("git check-attr --stdin [-z] [-a | --all | <attr>...]"),
>      -+N_("git check-attr [--source <tree>] [-a | --all | <attr>...] [--] <pathname>..."),
>      -+N_("git check-attr --stdin [-z] [--source <tree>] [-a | --all | <attr>...]"),
>      ++N_("git check-attr [--source <tree-ish>] [-a | --all | <attr>...] [--] <pathname>..."),
>      ++N_("git check-attr --stdin [-z] [--source <tree-ish>] [-a | --all | <attr>...]"),
>        NULL
>        };
>        
>      @@ t/t0003-attributes.sh: attr_check_quote () {
>        
>       +	git $git_opts check-attr --source $source test -- "$path" >actual 2>err &&
>       +	echo "$path: test: $expect" >expect &&
>      -+	test_cmp expect actual
>      ++	test_cmp expect actual &&
>       +	test_must_be_empty err
>        }
>        
>      @@ t/t0003-attributes.sh: test_expect_success 'setup' '
>        
>       +test_expect_success 'setup branches' '
>       +	mkdir -p foo/bar &&
>      -+	test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
>      ++	test_commit --printf "add .gitattributes" foo/bar/.gitattributes \
>       +		"f test=f\na/i test=n\n" tag-1 &&
>      -+
>      -+	mkdir -p foo/bar &&
>      -+	test_commit --printf "add .gitattributes" foo/bar/.gitattribute \
>      -+		"g test=g\na/i test=m\n" tag-2
>      ++	test_commit --printf "add .gitattributes" foo/bar/.gitattributes \
>      ++		"g test=g\na/i test=m\n" tag-2 &&
>      ++	rm foo/bar/.gitattributes
>       +'
>       +
>        test_expect_success 'command line checks' '

The changes in the range-diff look good - this version addresses all of 
my previous comments - thanks.

Best Wishes

Phillip

> Karthik Nayak (2):
>    t0003: move setup for `--all` into new block
>    attr: add flag `--source` to work with tree-ish
> 
>   Documentation/git-check-attr.txt |  9 ++-
>   archive.c                        |  2 +-
>   attr.c                           | 97 +++++++++++++++++++++++---------
>   attr.h                           |  7 ++-
>   builtin/check-attr.c             | 35 +++++++-----
>   builtin/pack-objects.c           |  2 +-
>   convert.c                        |  2 +-
>   ll-merge.c                       |  4 +-
>   pathspec.c                       |  2 +-
>   t/t0003-attributes.sh            | 48 +++++++++++++++-
>   userdiff.c                       |  2 +-
>   ws.c                             |  2 +-
>   12 files changed, 157 insertions(+), 55 deletions(-)
> 
