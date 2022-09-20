Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC200C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 17:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiITRys (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiITRyq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 13:54:46 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61A212A95
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 10:54:45 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso2286945otq.1
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/LMmEYadGznBNCipz+sutB2JBdrur0RVp/sP7DjI++s=;
        b=K1SBtUVVGer4TyXse2/o1r4iOkrOKw0cb7C78cxelGmo0XgaIdBUHk+GiiV8+ThAOq
         vDCQWwsoO6mrDahe5kgreYZF+Wv9d+e/IlJQr7tV2B2Bn9ZM3dHT3UgHhuNPndGfRZzi
         HWCvWI6jEHJnkIKgbOGyWUtPBwiy7Hu+SD3+fmat4xhY9hiZeMrJLgfyXwo2XKY76SUc
         GA4B2tYzwMqdkb29qbfPQNSyII187SwMJy1svMO+Ag+vZxTDJhXVA2bqf18fKa76IhEP
         LWZ4adfiZfk4z8nQMnRz9upJN6R9vI712f3QZaC90M1XZE+VtQCyQouPYdsikKmZEOcW
         Q1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/LMmEYadGznBNCipz+sutB2JBdrur0RVp/sP7DjI++s=;
        b=3s9o5XuAS6lZjRPK9AWr2mVyMInBxCK/JaBzlGIVhCFeNZZEbgdH2N6ag3XX56PB13
         htEzn83/zvlV9DbvPTebsr8WXuZuKBQtyzsg+aVIppSQA2NctFNPGU78JCfWaWy4JZzD
         AULscGV1gxYc4j3G88uzm36TqvI5pX/MzzCC8luYyjQ7Wk3pakkoCACvjjd0485+DCZd
         GHg/AcCHDhwntqtNm5W1a8PZjbVto3h+BsJentT9HT4fzjYMgLAHZqBWaLF3LRGlrQxx
         g3mGr+9Q3OYLrBpRtAkse3OG9xjFtahcgS8lXINAtHQqCxqgP6ixv9/62Wg6IcdSNepY
         C/ig==
X-Gm-Message-State: ACrzQf3GLzNU2TjP2zsZWuvwfizdmAGnskGrufuJ6Em9xzJcpg92WwI9
        2qSiLp2ZygIaosW3yUaQNSrSEyPW3bwVVszqya06pQXS
X-Google-Smtp-Source: AMsMyM6ZGvViIZe7m9aRSSF6s/IvBSiJgwCVmBs4EoI6d7URjIirEobEAJXyHu3+cb95y7fHcYEOVjxipFSNDWn6kSQ=
X-Received: by 2002:a05:6830:3707:b0:636:913f:2313 with SMTP id
 bl7-20020a056830370700b00636913f2313mr10411921otb.290.1663696485081; Tue, 20
 Sep 2022 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220920050632.326307-1-alexhenrie24@gmail.com> <84848326-5cd9-b5b9-2dcb-a6d49879f47b@github.com>
In-Reply-To: <84848326-5cd9-b5b9-2dcb-a6d49879f47b@github.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 20 Sep 2022 11:54:33 -0600
Message-ID: <CAMMLpeRJ=4ES6d7pRP1Y232GyLx-jhN-ktfVernXrDiJuAC+tQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/diagnose.c: don't translate the two mode values
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, vdye@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 6:35 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> In diff.c, the descriptors exist in angle brackets, so the right thing
> would be N_("<mode>"). This seems non-standard compared to most other
> places.

I don't know which form is preferred in the code, but I did find that
usage_argh adds the angle brackets if they are not already present:

static int usage_argh(const struct option *opts, FILE *outfile)
{
    const char *s;
    int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) ||
        !opts->argh || !!strpbrk(opts->argh, "()<>[]|");
    if (opts->flags & PARSE_OPT_OPTARG)
        if (opts->long_name)
            s = literal ? "[=%s]" : "[=<%s>]";
        else
            s = literal ? "[%s]" : "[<%s>]";
    else
        s = literal ? " %s" : " <%s>";
    return utf8_fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
}

> Here is a similar stale translatable regex in diff.c:
>
>                 OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
>                                N_("select files by diff type"),
>
> So if you are looking into these kinds of replacements, it might be
> good to add instances like this. They are less important to the 2.38.0
> release, though.

Yeah, that one probably shouldn't be translatable either.

> This long-winded email is all just to say that I've looked into the
> standard way to handle this and agree that you are changing the code
> to match our best practices.

Thanks! I appreciate the feedback.

-Alex
