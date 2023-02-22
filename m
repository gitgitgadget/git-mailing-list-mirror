Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635A7C61DA3
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 01:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBVBl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBVBl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 20:41:26 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1F32524
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:41:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id bq17so6526100oib.8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 17:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/UPt1LX3u1BbSOW/hG1XDFgaQCoVb8CPr1L28OAZxk0=;
        b=DPa8ZtQV7pPciPwEiqLsfmBB0EPxJqxynAMG60mzB6Bn0yS19GqOufFJeb2AEvDRue
         4DWsznHe2sndjdBjwUeuUK/AjOPgm8TYKROtikCzHqZ5vu/Tzrhv++C9TuDTI+K8OfbH
         9iDNZEKEe7v/UfJwClIr75B9nobsaiktW/0hE9LpqkohUyHJVmJjfNmR7CTd36s+pciC
         KG3bfb7VrCfafUUfpRFlxDBq5TvMeSdDa/+dLN5cSVg8z+iidyIyJdORijCC+m45sba6
         cAW3lTSDuRhQxWw6NlhhehJlLLBk3DKUGW43ML4PHlEw5mUCzmf3DLAs1wOsYXPBW4UE
         B66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UPt1LX3u1BbSOW/hG1XDFgaQCoVb8CPr1L28OAZxk0=;
        b=GzDH0xLTPAfrv45XPilS8JZq2+cYtf+x7UJvk1H3na2xPYkoFS7GWhBRbHgxtlymPf
         Oh7IdZzmsysNkE5IFWaLk4Bf73rhaTUKMBF1xjViGkptXmhuAEYtaNftGfrz3nxFquX8
         k64mX/mEjbULpsfYJOeRAosVA1h533rXZvvr2A1Yjt+DOdDzI9y4mdJ+ahLhtxB9i8B3
         aIz38AYjgKHgz3qra6E3gx5jytHKNL2Bt6bamM4/gTzswJb+3lJcXfgQWl9eBBPOwA12
         zyiTNahjg3IG83gokmvTGsXMoDxsJAcuZDLl3nnsXaRyY+9iyD4lCoxR82yWXPErZHp2
         7MEQ==
X-Gm-Message-State: AO0yUKXthXjIMmAGStcHHx6UQUlZrJCsh2x9pNu9sblBj5iKtXFZjAIn
        K5UOZR7tHrD81zus2Kf47/MW7RNBM/Io4J7NaEU=
X-Google-Smtp-Source: AK7set8w2Mx8q1NPavy/l9aBj62WzbRUWIx9VOGUDCF3T72VOnVBycsxmdhVPfEYbRpSeSmjzh5P5UTvBMWb+PpZ6lg=
X-Received: by 2002:a05:6808:1795:b0:37d:8c44:93bf with SMTP id
 bg21-20020a056808179500b0037d8c4493bfmr655330oib.141.1677030084455; Tue, 21
 Feb 2023 17:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
 <20230221055805.210951-3-alexhenrie24@gmail.com> <852c6efd-49a7-f6f0-dd6a-b28cb0909784@dunelm.org.uk>
 <CAMMLpeQ9gEKNX5VtGCgLL_Qzk59ZYji57u-SPy-XeSRPuF2NwA@mail.gmail.com>
In-Reply-To: <CAMMLpeQ9gEKNX5VtGCgLL_Qzk59ZYji57u-SPy-XeSRPuF2NwA@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 21 Feb 2023 18:41:13 -0700
Message-ID: <CAMMLpeQ2QFrNm5Eh02P1tobQwr-L8YYSE5Cfrt4fpfo1Z9Z=EQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] rebase: stop accepting --rebase-merges=""
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 6:38 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> All the same, your comment made me realize that it would probably make
> more sense to simply change the default value of --rebase-cousins from
> "" to "no-rebase-cousins" in this patch

I meant --rebase-merges, sorry. --rebase-cousins obviously isn't a thing.

-Alex
