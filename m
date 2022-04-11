Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5024EC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 09:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbiDKJVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiDKJVS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 05:21:18 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1C6170
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 02:19:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id e10so8492075qka.6
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 02:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVk3ghw20Ir4qMnADB513tpvnI2OMVKw5BWl7VYvXCw=;
        b=in7vYIIDinIthntrI6Q/Bq3CffGaINUFpBXp2qvWogBe/bDW8gUAac9eeE5fMK1mwE
         sr3tgLoO/ttRqEMBxkyLNbmYpCZStBmyAI4x81bWDBsF4ZQWUZ7irwH4V3zEV01CG5hn
         4ymRENkPAanedebCFKEAYTg3w3QqLcYdCbUVXVWst+ltwhXVb3jsHUHvjdtn+SHyLCqV
         L4ed31MB5ysexqC9eNLUiRk4o5YUCgb0rQhqYuNoDo44cmX6n2c+iYn1JoHaheS0u033
         OPX85r80VoMgDc1wL4lBQonKxIScAmeZ7+wtOExOOeGiZBesph1R7VqTDWZs3hszAEAz
         578g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVk3ghw20Ir4qMnADB513tpvnI2OMVKw5BWl7VYvXCw=;
        b=nKBUOK/035H2guQVjGOGAJc276sUDHjf3Wgv6UTOD5CVCzHB2JkljLwtM+g8zyZD2d
         hNsonfSuOs5+ddTk2FMxBOa2gogEQQu20FrrJ7dZL09mhO3kLW84zklN90P26Z/nTZQz
         T/3OKl+HphK5JTv35fxKX2yhIT4ryn0/szIq4CLv057wY9YBh44TuW1jxwPBvPFsR5Of
         Aug7lYZDBtoaXc9xIqgLX4VBnW1u4n0uIgxI1rtc0YRCUn6V7lsCwEj+QwolU2xb7QkG
         zQVvAk1js8VGHawho0QOul/Q53HlyccNikRy1XJH0BNbJKBIedEz53JnSk5srp4wNo6j
         1SLQ==
X-Gm-Message-State: AOAM530yvvjD1eNU0dT+pHcC+ba4FwY4kgQIF0IzrtF+cUDOBG/2ApB6
        +bDUR5EUXC75YexORczgD9aQ+2LGCd3hzC39XW2YVFupelpilQ==
X-Google-Smtp-Source: ABdhPJwVUHDm1rUPqtfQLiJXe3H2olc28TCy68o/Cmmrw/bd3XfkOYNXx3XPTyOFBxw1h9qGfLTjdUoOTNyKk2Si9ms=
X-Received: by 2002:a05:620a:2848:b0:67d:35de:bb5b with SMTP id
 h8-20020a05620a284800b0067d35debb5bmr20728721qkp.499.1649668741812; Mon, 11
 Apr 2022 02:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu> <xmqq1qygy9nd.fsf@gitster.g>
 <Yk8Gvf/fjVca9hDB@vmiklos.hu> <xmqqv8vkpara.fsf@gitster.g>
 <xmqqtub3moa0.fsf@gitster.g> <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
 <YlPMuxhpngs+x9n8@vmiklos.hu>
In-Reply-To: <YlPMuxhpngs+x9n8@vmiklos.hu>
From:   demerphq <demerphq@gmail.com>
Date:   Mon, 11 Apr 2022 11:18:51 +0200
Message-ID: <CANgJU+U31g_27TdFGvZPy6wgk24OrnC8Z0+hZp2zVshEd7LgJg@mail.gmail.com>
Subject: Re: git log --since to not stop after first old commit?
To:     Miklos Vajna <vmiklos@vmiklos.hu>
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Apr 2022 at 08:37, Miklos Vajna <vmiklos@vmiklos.hu> wrote:
>
> Hi Yves,
>
> On Sat, Apr 09, 2022 at 06:02:44AM +0200, demerphq <demerphq@gmail.com> wrote:
> > When you do have the cycles perhaps it is worth considering whether
> > splitting it up, so that --as-filter is a modifier for traversal stoppers,
> > would avoid the problem of proliferating options.   Eg, instead of saying
> > --since-as-filter you would say --since ... --as-filter.
>
> [PATCH v3] in this thread is meant to implement this. I hope that helps.

That sounds good to me and IMO certainly preferable to a stack of
options with the suffix -as-filter. But please be aware that I am not
a person of significance to the git project and my opinion on this
probably isn't worth much. I just thought I would point out that it
might be a way to cleanly address Junio's concern about option
proliferation while still giving you what you want.

Cheers,
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
