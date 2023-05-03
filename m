Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B69BC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 04:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjECELh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 00:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjECELg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 00:11:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD474180
        for <git@vger.kernel.org>; Tue,  2 May 2023 21:11:31 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4edc114c716so5522715e87.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683087089; x=1685679089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpLbx5jEHWDAdaasIcM9gbxurwb1Uteu9AMTRrKTiY4=;
        b=DsgQSIV52LPMJIiWtXkk0DxWu1vxYVjUQ1kiiEhTfXCFQd6pI+EAJ0aqYW33h1GENT
         WBpvqwEi8M4o8LQSwsIp238KwLLrnZV3NBhprK/9/EHC8X5kWl4g4qbM2fHcLiGjQtRd
         zltJmKtfz6Y0yz6tHevKGI2s1YIT/ghst8vxVQLaf3rig6XGz06mHmNc4ZQxO7Z7s8k2
         rbsOuo4nfGUMT4KzL+4SORqWXZHSgv7GEtOiMiSBg92/WtINsdy2M+0B0B2MAlErjHPC
         OPdbenCn2mWkQdXA3p2HbPtx5i8IG8cGA487Rx+Ij6ScNd3MBfOFc4J5GLCPWS97A/vT
         WBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683087089; x=1685679089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpLbx5jEHWDAdaasIcM9gbxurwb1Uteu9AMTRrKTiY4=;
        b=QOhcWyciexeIJX13ZiNPf06FOGZsOxNFeGSWJnEnNIhwScYiMocDVrIvYjWM6aw7Oy
         k9T0cEQZjsUgdRReFKpR+DGy8y8N9OZe6SjYHwBrc+jRomOzEPaaWj8w6eMYgrSNhHDS
         7tqmf/lY7qyN9TsciDOwxc+db84yrYyBIFv39ZhzhmRzdVPKRos55KvMpZiqA2IoDO+u
         VaK+DGbtCt564YqnZuN3NP7r7OTwsTl7FSuk/nK6Zw7cmZG7sMpUSB8p0bY1t3ePiy6x
         KQWv/y19fyHoovl5VpU7ne8Qz/rw/fIA+fTr5y2NdtwNfNu3jGEDUpe89N5PaDQUzZHe
         4xKA==
X-Gm-Message-State: AC+VfDx+P6vf1ggSEFamhpiyReIa8zNEqPbQK4zELGS7AHxigZ5sZ6iO
        rGg0Din11DAgXkz4mshOyycoEy/D+wb50yqf7N913bC16+w=
X-Google-Smtp-Source: ACHHUZ6IMtlm+OLVESwCXGs1PWlEygPysmyhY245UFDU8WaGEfxh9LJSx1+J2na/NBO9CWqdUJXgMpYtvW4ko1iFOlc=
X-Received: by 2002:a19:f610:0:b0:4ea:f7af:7ee with SMTP id
 x16-20020a19f610000000b004eaf7af07eemr474614lfe.45.1683087089348; Tue, 02 May
 2023 21:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230403223338.468025-1-rybak.a.v@gmail.com> <20230417191044.909094-1-rybak.a.v@gmail.com>
 <xmqq8re74t3j.fsf@gitster.g>
In-Reply-To: <xmqq8re74t3j.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 21:11:16 -0700
Message-ID: <CABPp-BFCBPTBc9savP13gNFmBo_WCnZHUv_Z8bWE6T6GZOrs-Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] t: fix unused files, part 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2023 at 3:04=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Andrei Rybak <rybak.a.v@gmail.com> writes:
>
> > Creation of files from redirecting output of Git commands in tests has =
been
> > removed for files which aren't being used for assertions.  CC'ed are au=
thors of
> > the affected tests.
> >
> > v1 cover letter:
> >   https://lore.kernel.org/git/20230401212858.266508-1-rybak.a.v@gmail.c=
om/
> > v2 cover letter:
> >   https://lore.kernel.org/git/20230403223338.468025-1-rybak.a.v@gmail.c=
om/
>
> This round has not seen any further comments; shall we consider it
> pretty much done and ready to move to 'next' by now?

I think so.  I read through the series.  I also read =C3=86var's and
Andrei's extended comments on v2.  =C3=86var does bring up good points
about whether we should be testing more, but Andrei I think did a good
investigation, cc'ed original code authors (who would be the right
ones to comment on whether those other things should be tested), etc.
The tests as-is before this series are harder than necessary to
understand, and Andrei cleans them up.  It feels like good forward
progress to me, even if there _might_ be a better eventual optimal.

Reviewed-by: Elijah Newren <newren@gmail.com>
