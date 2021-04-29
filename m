Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68811C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E18161419
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhD2MGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2MG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 08:06:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F006C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 05:05:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d14so14411936edc.12
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=nYFHROsTsmqEsQvDieLv7LYflIHD82OycYSCN/VeQ9s=;
        b=l1fF4q8RE1frZxJmi6tC2A/mp+Q15JB4wc8LfSW020y4XsCla6RK+3Adq3AaFPndxq
         rk4XyFUTSzjTNFBz1JkOZDbyhrGCQfVL16y54vDpPr9zWO0s01jWNYj+BqnuugFrHhx8
         DmvtsF2FCXNvEhQcVAH8jKdW2Lqqs1yvTtHVwo4RyPS/JFwGIeDyWEgudv989UTE+67U
         uZkQPbDjObzLJRVXZauZwK7aXG5nkesuRky37E67rFeKdGQsu8EVwuXDa9iWlXLxcu23
         WskFX1mh7xLbNch6JpT6PDpHKRDbebGgqL6FMoCFYzrMOfolqR0/FVTHlUOU6AlNqcoz
         Mx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=nYFHROsTsmqEsQvDieLv7LYflIHD82OycYSCN/VeQ9s=;
        b=EBrrNUPsJiTfJlBlmdzJfuFYs++2Q45f+EENQGqTBYnhmKcNLyyj59bjgRWHpzf4aH
         R2uSnHqhBfNwOU6E/CNvwnuTcIu0sxMfsWWD6t678xlVTizOlDaveGqswsn86n94/k/0
         b9FFGTeekXdSexlTj8OUb8aC9As7ls7kE8o9+RGSp60wkAi3MpULYG3NfRmlaUi01qGb
         yA0NskQNmqSvVM5SjyfFPdXrmlQHicpBU3wz9GHko8V3WMgvPPJdFgMedoy0tg/d3WxS
         mzHo/m6oh+NqfumA4+Ttm25UPysvWD2vgws4+diDabpfOdyUZOhDPWc/Hb1hlMWohT5b
         pucQ==
X-Gm-Message-State: AOAM533WVAXSJYg0He2oMJpoW1rO0xxuiAbyCDeLm1fuKEDDn5Ze/cCA
        r+TolnO5/z5uYopCpUQSk+4=
X-Google-Smtp-Source: ABdhPJwmzvvjwGyyQUA7M+SdWXo48RbDjskg9xd3bZ/tuRI8nIFtZWf67TWGutA+/4ySdBwirnTUxQ==
X-Received: by 2002:a05:6402:348d:: with SMTP id v13mr17677744edc.294.1619697941887;
        Thu, 29 Apr 2021 05:05:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w1sm2265829edt.89.2021.04.29.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:05:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 05/10] {commit,tree,blob,tag}.c: add a
 create_{commit,tree,blob,tag}()
Date:   Thu, 29 Apr 2021 14:01:47 +0200
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
 <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
 <patch-05.10-5213d500b9-20210420T124428Z-avarab@gmail.com>
 <xmqqa6ph8zsc.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqa6ph8zsc.fsf@gitster.g>
Message-ID: <875z05z46j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 29 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add a create_*() function for our built-in types as a handy but
>> trivial wrapper around their calls to create_object().
>>
>> This allows for slightly simplifying code added in
>> 96af91d410c (commit-graph: verify objects exist, 2018-06-27). The
>> remaining three functions are added for consistency for now.
>
> "for now" puzzles me.  As file-scope static functions, they do not
> hurt all that much, but on the other hand, having to say
> "create_object(r, oid, alloc_blob_node(r))" is not hurting at all.
>
> The worst part of this "consistency" is that callers cannot call
> create_blob() because it is not external, even though they learn
> create_commit() as a handy way to use the create_object() API, which
> is not consistent at all.
>
> And since most callers should be calling lookup_blob() etc., and
> should not be calling create_blob(), we shouldn't tempt people to
> push for making them externally available.

The API is for our own internal use. So I figured it was better to leave
the ones that aren't used elsewhere "static" for now, and if anyone
needed them in the future that commit could remove the "static".

> Which in turn makes me wonder if the use of create_object() added to
> the commit-graph.c was a good idea to begin with.

Yes we could just drop this and inline the various "alloc", i.e. not
this & similar in the future:

-		odb_commit =3D (struct commit *)create_object(r, &cur_oid, alloc_commit_=
node(r));
+		odb_commit =3D create_commit(r, &cur_oid);

It just seemed like a net improvement for maintenance/readability to
have the simpler wrapper for the allocation / object creation v.s. the
existing alloc_X_node() + cast.
