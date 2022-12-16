Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC54EC4167B
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 16:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiLPQaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiLPQaG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 11:30:06 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AD525C8
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 08:30:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n20so7515682ejh.0
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9CrP7KqO0y3ee8ZMSkeAgKflpodAl+0ygeVDNbkHNho=;
        b=nTGzKcONTn4O0wF/HYEaMse6KvW+qgin/8mTx01rcBygUWa3dLI1qEnfgawPS6ExtR
         ER0SL3dcbKC0zTpl2qW98UtLVWu5P4SWNTHKSlFaTcSwTAqy0tTJbiKCdwhfpMWgV5MG
         ipiw8wPgg8cTV57OsDdYcdBKGm7uOEtztdxQt0OVj63IWw75jmKdLyxRMsJpcbFtECcc
         fOHXodGjm7x8z89Kj0hJspRaWqZHLuMSMbZ22+P/gzEcpcRVht6uhhVUcNkpgFU/JXJN
         rB52spU1wJTbcbEcB6mpU6WJQGpuabgD8aBA4pgMWPppairSejksmG1WGBs82N0pEcpZ
         9QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CrP7KqO0y3ee8ZMSkeAgKflpodAl+0ygeVDNbkHNho=;
        b=er7hqwNCxL/hEGS/ObrsjlwebmkHpnHm5OIUOMRpW0HzNrmxdx3QSv9o0ai9YXZWje
         hMq1n6dDA/aWcLTpSidEgnsFLRbJAZKQkCT9uGg3mBNhTqsx6Iuz0grMTXR0p0RQKEgx
         Txmo/mK8vczYxBiiozFIB8TCmdCxgpf7nUVg5wyAKzPGNWs+pkWRs7NEgDFvPH0ZfAKb
         nZ0Y94g+9WqdnEMJ9p/rEz6uvHOITH4qK9zsY40O83M6ezlh2TxB3h2uwZSXydU9er2d
         7N2hnugas/vNZ5l7ozUEDEDAHYGfonUfro9xzWfvnQVxR2b3WrFUNHF6E3Kgac2dwrTK
         bEaw==
X-Gm-Message-State: ANoB5pnH9zVNsF9WSmnqGRn2efeq0tdQI97B4e6b33KnKBSLXzwedm9H
        c3QcOAxNE0bqKqTKyEkKqcfAAdRD4G0=
X-Google-Smtp-Source: AA0mqf4QY9H/dPWOYUYJ6ftr9F9B2BXE6TLST6v1usA4qwd/K/S1HCUymqr3+XMsAmf9crsbDj/jDQ==
X-Received: by 2002:a17:906:411b:b0:7c0:a48b:2dff with SMTP id j27-20020a170906411b00b007c0a48b2dffmr18253060ejk.43.1671208203388;
        Fri, 16 Dec 2022 08:30:03 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906a10100b007a1d4944d45sm1029255ejy.142.2022.12.16.08.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:30:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p6Db0-006QsY-1x;
        Fri, 16 Dec 2022 17:30:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
Date:   Fri, 16 Dec 2022 17:17:48 +0100
References: <20221216093552.3171319-1-karthik.188@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221216093552.3171319-1-karthik.188@gmail.com>
Message-ID: <221216.86k02r1fcl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 16 2022, Karthik Nayak wrote:

> v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmail.com/
> v2: https://lore.kernel.org/git/CAOLa=ZSsFGBw3ta1jWN8cmUch2ca=zTEjp1xMA6Linafx9W53g@mail.gmail.com/T/#t

Could you please set the In-Reply-To header appropriately in the future,
so that each version of this series isn't in its own disconnected
thread?

> This series aims to add a new flag `-r|--revisions` to git-check-attr(1) which
> allows us to read gitattributes from the specified revision.

I didn't look at the v2, but expected at least the short form to be gone
here re
https://lore.kernel.org/git/CAOLa=ZTSzUh2Ma_EMHHWcDunGyKMaUW9BaG=QdegtMqLd+69Wg@mail.gmail.com/;

I'm still more partial to the alternate suggestion I had in
https://lore.kernel.org/git/221207.86lenja0zi.gmgdl@evledraar.gmail.com/;
I'm not sure what you meant in your reply at
https://lore.kernel.org/git/CAOLa=ZQua8TfApCdzoK06_2fkWb4ZCfWewXKOSaXno1fqFSq2A@mail.gmail.com/
(sorry about not following up at the time) with:

	"when being consistent we need to be fully consistent,
	i.e. <revision>:<path>, tweaking this slightly to be
	<revision>:<attr> is worse than breaking consistency."

Yes, it would, but isn't that by definition the case with any
proposal?

We don't have a way to refer to an attribute (or all attributes for -a)
for a given revision/path, the task of this series is to invent such a
syntax.

So we could invent that as this series currently does with:

	git check-attrs --revision <rev> <attr>... <path>...

Or, as I suggested:

        git check-attr [<rev>:]<attr>... -- <path>...

Or whatever. Here I'm not saying that one is better than the other, but
advocating for one on the basis of consistency doesn't make sense to me,
this is new syntax.

I think what you mean is that because the log family uses "<rev>:<path>"
we should not come up with a syntax that looks anything like
"<lhs>:<rhs>"., as the "<lhs>" in the mind of some users is going to be
"<rev>", and the "<rhs>" is "<path>", so it would be confusing to have
it be "<attr>" here, and have the "<path>..." come after the "--".

I'm not convinced by that. From refspecs to e.g. "git log"'s own "-L" we
have little mini-syntaxes in various places that use this sort of colon
notation. I find it more elegant than "--revision".

It's fine if you disagree, I'm just trying to understand the basis of
the disagreement.

