Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A771EC433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E24B206F6
	for <git@archiver.kernel.org>; Fri, 22 May 2020 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrOhhff+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgEVPdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgEVPdK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 11:33:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A38C061A0E
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:33:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so13128676ljo.5
        for <git@vger.kernel.org>; Fri, 22 May 2020 08:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KJCX292Cp1G2nvNeHp5GtHkU4Cjc06KBUS0wGHDFuo0=;
        b=OrOhhff+f00H0qBnb3o8a4bGll8Zi+XCudNBazmK2ZZyuhpNC4huFt4FymoxEoF26z
         6I/7lrWPOPIYGe1m3yDVGcYK1K3d99KVODdYzcjyvTsSZliheaWyRl37XyOMlkxWMqHL
         gfMjtNoiEDtnpdnvF5ivzgrO36Su/E6FuaIKE9J0voi8a3yoYa43Gxh9ywtPsi09oexc
         K4TRp8ooDTlD9UxiIzBuK3ykXVKrJaGb4MYTSrS8NqZ4N8godkAV3J22mI6VF2WXaDGs
         pVTs/Sckz+gFRzrCucJVanMzrk2P/UrLXsVbzeJqXw9qxHIUQ5m3yfNLI1Et4NKc4D+R
         iNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KJCX292Cp1G2nvNeHp5GtHkU4Cjc06KBUS0wGHDFuo0=;
        b=icw76zohvDKEu9RDu+GtxP2NNGHej05s4uE6Ve7tLvIzRLbr2D3B1K8cg5Rn1CqDKq
         CD1hvGxzLuewX+A0o1VmUtMcETb1Fq7Kjyo4a/RhakDx63p3LRhwIRfURb9bQLjltYj1
         PGGm1GaTlYsC67ZxV8XGhOFyCuKZ8GNG1jvZ7YeEah4026nde61Y4GgrMAJaTwVd1bmX
         oQwtgJ2720y6TrldBWt+vI2WGWtgkjpv6J8T4PCwmol3dyZ7SfpHThJECzwCp98CLpSv
         BKHkN0Piqw0ORiK0WXlIi0MlaJ57/ObG48MIdo6R6ADtAXmqdQm5FvQ4RAlAliJXd4S7
         IHUA==
X-Gm-Message-State: AOAM532aPu7h4b6K29PCa8rnyGUXjGCC0m9jRUQZJCt09Gznivu0wcWu
        7FfeGdIp/c9nPO8kDA6Hj653OPmSc8IbA7lQAi1org==
X-Google-Smtp-Source: ABdhPJyWptjSihtgUbboFQnEVOhum++YmZ75c01wQg+yaiFI8OhwTbg8gWPhtNYyDGEVRHTOEtZVye3e2lYvYlU4niQ=
X-Received: by 2002:a2e:980d:: with SMTP id a13mr8028564ljj.277.1590161588182;
 Fri, 22 May 2020 08:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAGa9yXqOY0onB4cg4rjCY+RCL7qqxtYDBT+B9DoJ3nwpKh5_Hg@mail.gmail.com>
In-Reply-To: <CAGa9yXqOY0onB4cg4rjCY+RCL7qqxtYDBT+B9DoJ3nwpKh5_Hg@mail.gmail.com>
From:   John Carlissi <johncarlissi@gmail.com>
Date:   Fri, 22 May 2020 11:32:57 -0400
Message-ID: <CAGa9yXq1FwLJdFqnnino-34pMtTcvu8pZWhgHPoBY6mJBd=yfQ@mail.gmail.com>
Subject: Re: Git stable releases
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 4:25 PM John Carlissi <johncarlissi@gmail.com> wrote:
>
> I noticed that with 2.16.6 development stopped whereas with the latest
> security update, everything 2.17 and newer got the fix. Is there any
> formal definition as to when a minor version is EOL and no longer gets
> security updates?
> Thanks!

Does the silence mean there is no formal definition or did this
message just get lost in the pile?
