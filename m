Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C72C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443345AbiDVCdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443337AbiDVCdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:33:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376A055B4
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:30:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t11so13555224eju.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4Q62wsUXCSoGrc6I+bJ62DNqLRUnI/O6ifDnRd4df8=;
        b=NdVFfjse7EquNyHJMn8rQTdXo/IQSpQYJs4GURnQUkf/dYy82ui4cuUuUqsLe+3ihz
         lWS3YLh5ZnfXoxVzLqPGAWd+vqkvP/5UaJ2byKggwJ6AU8ADd5QjCxQAOUmIHMMUK3C+
         0kBQv4gco+xC5uTNcNfCI07oOe82+4l+/oWJ6IXkZMPQTa6JQGqq6XhbfAtadD9kVupX
         JjHltiJq3Spz4RNYc3FlYtDe4csehb4XYPhE5jn+k4Uagy/LRdrrkTigwohausN3o2ss
         fwKC7ZpJtprAY/HxWQdv1bszJoeOZ0dYkK1gO/IN3vot9eN02DXKwI3sX1E5qI1QOGt6
         3cZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4Q62wsUXCSoGrc6I+bJ62DNqLRUnI/O6ifDnRd4df8=;
        b=c61NoBsYxlMfGzdo1xxlaTUYBLxQ4qzEETw4neDOLEsxENbTlsN2uVuesfDGR0LhpK
         Wek510IvcxVqU301IFGTAzP7N4JK1Wa1hpo4kYVgGoVzKMu+BYvqErH8LfcGeAxkyBGv
         Nq51rja0LVV10ELZpAHEWgIe8LqgYjH0HXS3kZUv6Y43Zxv5iV2CN7HKdb/zGFnQuaAt
         Y1178SIWFWqsaz2RtQDyTOKsAbNHOw9NxiFxv+vYjD2ama1cmB+N3QBpojL/tpcu4hkF
         HFF1CHNlUZtOjcnAj10Xq8cgf0w0GqfWNZ7HAsGji3jHKzj+hNFn/qbJ10qea0KyQBzL
         Zzag==
X-Gm-Message-State: AOAM532hEvCkWJAD7w3ZK7YnD7Wi69HgTBlXnjI/yb1EoQyjX4SHITPM
        HHvU16YtJjualh5wGMmx++nmEs3RQjqZm8XTlY0=
X-Google-Smtp-Source: ABdhPJxY+q7LSnRLnnoPTHpnK7aNbulzp6jf6qYZCUzoijMT9vUOOHycBkkoivqfaE3/sS4z0X0RnSmD92dUXK4FIS8=
X-Received: by 2002:a17:907:6090:b0:6f0:2a64:2ef7 with SMTP id
 ht16-20020a170907609000b006f02a642ef7mr2111775ejc.476.1650594619799; Thu, 21
 Apr 2022 19:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com> <78028ecaa58f2c0b395b417cfa2543e73ab51fae.1647054681.git.gitgitgadget@gmail.com>
 <xmqqo828p7zt.fsf@gitster.g>
In-Reply-To: <xmqqo828p7zt.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Apr 2022 19:30:08 -0700
Message-ID: <CABPp-BE6bFsdSs1j4_M7T1EisT6vQOOoTPeRU8GJKprRqqeedw@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] git-sparse-checkout.txt: flesh out non-cone mode
 pattern discussion a bit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 14, 2022 at 1:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  INTERNALS -- FULL PATTERN SET
> >  -----------------------------
> >
> > -By default, the sparse-checkout file uses the same syntax as `.gitignore`
> > -files.
> > -
> > -While `$GIT_DIR/info/sparse-checkout` is usually used to specify what
> > -files are included, you can also specify what files are _not_ included,
> > -using negative patterns. For example, to remove the file `unwanted`:
> > +As noted above, the sparse-checkout file uses the same syntax as
> > +`.gitignore` files; see linkgit:gitignore[5] for details.  Here,
>
> Here, following the suggestion to fix the early part of "Cone mode
> patterns" section, move the "it is more flexible but requires more
> cycles to process" you had there to replace the "As noted above".

Makes sense; I'll restructure it with this and some of the other
modifications you mentioned earlier to simplify the cone mode
discussion.
