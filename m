Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD7E1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 11:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406320AbfHILZJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 07:25:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39304 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHILZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 07:25:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id r21so125259743otq.6
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 04:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wEQD+4/y0mmhDXHMEMExZWzSO29NSOvkeuoPwtneSQ0=;
        b=eS2KJZXDSqMVzLLWpq74azuX/5mLZvTiXLFN1RAjru8GMFQ5db3z6L+gcdJ8lIebGD
         9bbIaiuW0XXcCi+SQL5DvkBsPYeBat1StCed5EkqIlxfwmCy3CFXdBmG84lBVO+cbBS0
         oTbUs5DDJ3G+9BVW2bbguF/lKiVZBU3mK8c6APZmmo8GqpPTSf+iJtkieapEKgLZqUgj
         cGyRCQOw91RzM+5Dqj7ui5hVOMsOmWnVr9PUKHRKUZhY2fgozZIEVjb65BTTDkNAV1Wj
         LmR6rOtrynLKDhkvoSywujZWwC+ZlSSAfHozVmHLZcx0EgIAf+Bw9Wtd6nachqyYvaqg
         ho2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wEQD+4/y0mmhDXHMEMExZWzSO29NSOvkeuoPwtneSQ0=;
        b=C63xWqfYPSPKafOmQbgTL//fIe6Y8AodLJH2DB62MmIKN4/wefvEFk6YupJUBnkRn/
         3Gez5xrBwgAQ1WjoxsBuqBjO3Iq2+QVOFqsr1H9iITJEjjT++QazysWW+uLhB8ypsVoV
         LOHcb/Esl5AK4V7dyazPdTh3aUKcXBR7tWJ6M/zW7dubWF/1nCSuI25DLW0xlBCxetI3
         d4laPoNK5vShYIIi4e72A1eS6qjNRh5z8X+wITNBgAcODAkYfFNtJZZ3m8Rl5Ul1WOOs
         4Bv/zzpwjl3XVIkTig0AtANjtTT4KFrFn0yclchM6AzRJwjw8iDL7YtrgwbNTfZgGFlf
         CJ/Q==
X-Gm-Message-State: APjAAAXCG3xJVeqNUHPo5bnBFBtKHnkOq12Mv1qaVmplJfyqCxxzLYNd
        54ZHSuWKg8qy8tDpf7fKesp2fE5IDgPC5yXYkGvFhNyncIs=
X-Google-Smtp-Source: APXvYqyHFv7nv/MHb9Ku/CV2kKJv6CstZfikWrbDwNRWoC8FzFSVz5g6BlaMTXg23AzqHGhH6vqQtDp6N+b274G+yhA=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr20242100iof.162.1565349907695;
 Fri, 09 Aug 2019 04:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190807213945.10464-1-carenas@gmail.com> <20190809030210.18353-1-carenas@gmail.com>
In-Reply-To: <20190809030210.18353-1-carenas@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 9 Aug 2019 04:24:56 -0700
Message-ID: <CAPUEspiK7MTZPMktbU=_C_GPOH9vQiBmVUZp7GuR97RZS3onRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/3] grep: almost no more leaks, hopefully no crashes
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

disregard this version, it still broken (and wouldn't even build on
some cases), the reasons why are still unclear though but at least it
might
seem from the last known run in windows that segfaults were prevented
at last and something was still off enough to trigger a BUG (shouldn't
be a concern with V6 or later that do PCRE2 migration to NED fully, as
agreed)

Thanks to Dscho's github integration to Azure pipelines got finally a
RC[1] for V6 that at least passes all tests and will need to get in
shape for submission.

as Ren=C3=A9 pointed out in three my performance concerns might be a red
herring as well, but would be nice if someone with windows would
definitely get some numbers so we can't be sure there were truly no
regressions

Carlo

[1] https://github.com/carenas/git/tree/pcre2-chartables-leakfix
