Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3706C77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 09:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjFAJLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjFAJL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 05:11:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAD9119
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 02:11:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so994663a12.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685610686; x=1688202686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TocJ16e2y4o0ezcU0g8mSt1FCzRhZ7GKWoTgyBcqpBE=;
        b=J/0vdLzeddUvTQ0lCzn5xFyJruf9WXDr1Xc64VuoiopBQhy6tdJ4nKd+MHkrIIlZbo
         4oKGyyp8HHF9cVbHHD/zB9C0bhn5RGN8evvcDI6CHAQDjb496ruGR9CnzthNn+Y4qKAN
         SKZ7eP07lXNVOEaYtM0fKuouFaEKx3jEINTtxUCgI4vlXNAdYJn/7kwcZYZG7U8s/0ph
         OsZwhnpCmVeoWvlJHjZGf1HtCnnDJ/xgkgMG1bf4gYvqrxWxTTtZ31JpROYOP3ZDhJg/
         z6W+LP8CT4kIcVGiiBp3f6wijuQA1OFYPziizq0V5lrmVY8Jdggu7SYfH6LdTerGrV/z
         2x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685610686; x=1688202686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TocJ16e2y4o0ezcU0g8mSt1FCzRhZ7GKWoTgyBcqpBE=;
        b=b/jk/DW198dZAS9ZWD9umZA1VLyZAWipJI1YIB8IPUliDzxWwLOBgJtYKZ7rd8JNk0
         0V9kq2LmhOeqsT319kTqEZ5PMjjbWSm7BNUK6DmKMgo6OT7ldQ8PpDYIgH5PhlzKpUkJ
         A60P7FZn/pT7cPeg/X5RWQOnV4qozj9bn5gHlPnzx30k4RXlfjvayZpG+mv7pKBR3pKh
         MBnjCIhMwqfvlFIJMQ/RVexaaB9ivpsTMoqZHGQIOQXZ2x70rh6Tmtdyy3rQvWvisTjM
         fDiA/XmRBT/PtATH1Cj9L8QN0eLzO+0eOQzN1AeDav5yXgNRMSNd5oJkam/hVCBdwvbH
         S4yA==
X-Gm-Message-State: AC+VfDwbJaPeE0s8mqCYmIa9bNOHlLjH1SpF3DPYUZ/ogqrba6hg9cSW
        uu2unLQ2R3iv1S1fT2bhj6W895MJVC6735cs3YPhp6CkMVw=
X-Google-Smtp-Source: ACHHUZ6nZPwFsDKls/kiKZgmZSZ3AKKZ7EU63eVp7STyO3QFhD/oct+JCLZJDap2veFrgGI3lv8o9woxCDzFy1SmN/c=
X-Received: by 2002:a05:6402:795:b0:50d:f9b1:6918 with SMTP id
 d21-20020a056402079500b0050df9b16918mr5356817edy.9.1685610686134; Thu, 01 Jun
 2023 02:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230529192209.17747-1-five231003@gmail.com>
In-Reply-To: <20230529192209.17747-1-five231003@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Jun 2023 11:11:14 +0200
Message-ID: <CAP8UFD1JDQ=A8T_MYCG2yRDvZBjN0iDSLE69mxb7deGRupbpKg@mail.gmail.com>
Subject: Re: [GSoC][PATCH 0/2] Add new "signature" atom
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2023 at 9:50=E2=80=AFPM Kousik Sanagavarapu
<five231003@gmail.com> wrote:

> PATCH 1/2 introduces a new prereq GPG2 for the purpose of testing stuff
> that breaks with GPG version <=3D v2. This is evident from the CI failure
> in [1] that was sent with the same subject as this series (more info
> below).
>
> PATCH 2/2 adds a new "signature" atom, which is a duplication of the %G*
> formats in pretty. This was sent before by Nsengiyumva Wilberforce and
> was in "seen" until May and was removed because of CI failure. I have
> built upon it and have done some minor changes to it. The CI jobs are
> now successful which can be found at [2].
>
> [1]: Patch
>
>         https://lore.kernel.org/git/20230311210607.64927-1-nsengiyumvawil=
berforce@gmail.com/

I don't think it's a big issue, but, as there are only minor change,
it might have been easier to refer to the previous work by just
calling this a v6 of the same patch series and using the
--in-reply-to=3D<message id> option of git format-patch to send it so it
would be in the same email thread as the previous work.

Now that a new series was started though, I think it makes more sense
for any improvement to this series to just be called v2 and be sent
using --in-reply-to=3D<message id> so that it is in the same thread as
this series.

Thanks!
