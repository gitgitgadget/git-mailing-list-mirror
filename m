Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C6AC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 18:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBFSzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjBFSzj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 13:55:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E8D13D50
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 10:55:38 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g9so9085979pfk.13
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 10:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ku5HC3MBrjgKt3lhJK9UersefNn/ygfik/wvT8v4kKE=;
        b=huDe+wEcr3GHeSkba/mlLfWaAjERc2BD1MmeU46vuQ23cXIQwHirB9Q8zzDdBl4OoI
         Pj/EAbuku5MtLAqys00Z42zKycE1lm51XSik0vQgJ1ScCIJ0fiKGJp8ZlYvNwEFugXgH
         ZKg3XWFVD3SkHRYioj40EBxtsPGqrqVkhLsslDWpG0EsmwGE66Ivv1839r9u/hJxVQ6D
         KR4uP/L+3jihiDBuRAVjRrTaOLs4KfEXIGFyW9LlO77iNZgnEmjYCtoKSx/ZtV3qPIhw
         Ef+/PWCPE0HVuIdqRB2TL2UiwaKk1n1IKGsjmHF8cvu7OsFVWaGLMIHbk71PCjJjwU18
         zVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ku5HC3MBrjgKt3lhJK9UersefNn/ygfik/wvT8v4kKE=;
        b=SGFBaEpvxeG2qQrwufYc/xRwveaN1M4Nq7lBd2WfGc+k9QVSXY0xQdBTxPmjqvLzBN
         4VFfKF1iL4KRXKpa/FU+K1gyZ+1A01b6can20RAsCpbiWGTwTI8oeD0PD3pFgwV3S44g
         WNrcsktB3bvTqdZQQK3eypYWqtasidGa9h6Yd8plwKQGOe+AoGhdhDU179PJH/We4pJi
         ToIrWwGTz1cKdPG4Va10GnQ5R0osM02j6ZGkfZsgzYfDQj1eICxKKc628+QUyYHNYMtZ
         xn77yxO1NYOTMZ8spkUV9n3cT9puoUjHZ/Ti+WGHc/Vw6VuJbm4JmCPVh2YDDebOJCmH
         KTwQ==
X-Gm-Message-State: AO0yUKVgJ6iqdoSj7x82QJMJYAN9SoG+542a0GJEMzqgUPkacFRI9Fen
        3NXgchic0TX5/x7dFcLWBLs=
X-Google-Smtp-Source: AK7set+hq1kVTNji7PZSTdqKIcProYsS3iR35wFrZJHQJ88f1WZ2P2UObD8kFGzRn0Iw4esY5MvZhg==
X-Received: by 2002:aa7:87cc:0:b0:594:1f1c:3d37 with SMTP id i12-20020aa787cc000000b005941f1c3d37mr10614590pfo.12.1675709737645;
        Mon, 06 Feb 2023 10:55:37 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0059252afc069sm7524128pfk.64.2023.02.06.10.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 10:55:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] cache-tree: fix strbuf growth in prime_cache_tree_rec()
References: <ff3ac119-9b00-746f-470c-8db18c9c61a1@web.de>
        <230205.86r0v37qdb.gmgdl@evledraar.gmail.com>
        <b1a3e684-26f9-0053-9446-751d73e83961@github.com>
Date:   Mon, 06 Feb 2023 10:55:36 -0800
In-Reply-To: <b1a3e684-26f9-0053-9446-751d73e83961@github.com> (Derrick
        Stolee's message of "Mon, 6 Feb 2023 10:27:53 -0500")
Message-ID: <xmqq357i8vyv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> -	int base_path_len = tree_path->len;
>>> +	size_t base_path_len = tree_path->len;
>>> ...
>>>  				strbuf_setlen(tree_path, base_path_len);
>>> -				strbuf_grow(tree_path, base_path_len + entry.pathlen + 1);
>>> +				strbuf_grow(tree_path, entry.pathlen + 1);
>>>  				strbuf_add(tree_path, entry.path, entry.pathlen);
>>> ...
>> 
>> The size_t conversion is trivially correct.
>
> I agree, and thanks for finding and fixing this issue.
> ...
>> One wonders if (even for this index-related code) we really need such
>> careful management of growth, and could instead do with:
>> 
>> 	strbuf_setlen(tree_path, base_path_len);
>> 	strbuf_add(tree_path, entry.path, entry.pathlen);
>> 	strbuf_addch(tree_path, '/');
>
> This would be my preferred way to go here.

Yup.  _setlen() is still very useful to truncate an existing
contents in a strbuf, but we should look at each use of _grow() with
suspicion that it might be an mistaken attempt to "optimize" where
there is not a room for optimization.

There may be cases where tight and exact allocation is desirable but
this is not such a codepath.  tree_path will not be overly long that
we want to avoid extra allocation for giving us slack to prepare for
reallocation.  And tree_path is passed to recusive calls to further
be grown, which is exactly why we would want to use ALLOW_GROW() kind
of allocation with slack to amortize the allocation cost.

Thanks.
