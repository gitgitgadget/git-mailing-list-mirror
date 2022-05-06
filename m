Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAF6C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 12:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391678AbiEFMQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 08:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389887AbiEFMQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 08:16:16 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB2164BF6
        for <git@vger.kernel.org>; Fri,  6 May 2022 05:12:34 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l9-20020a056830268900b006054381dd35so4791176otu.4
        for <git@vger.kernel.org>; Fri, 06 May 2022 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zx475DjljKG62JPPjVZpqEPtbzKYJvMSYioU3iV5J2A=;
        b=WKG5DLSSB9TcOq1MZYYzLkyUHSKLldBARVcCBCPsXYerKeYillH+Yv1du2E4xRv2pF
         44NREc8VFn6OCZfqSWCxFPR0BGUM3adGSSZMHlSLKmo+gzcIZgvpGdS+jKsblQrngH7r
         gLzn2fSgO1kOPUmUYIYt22ddiXX41znhjjVGPP6fK8pSux/Oie2V4QZbAINfDBJMQxuD
         soWgftQIYSAZz5ajlSYaNBFOk5bXioIVLMR0X+JYTs3AVgxPjCwZN1d974PLXmaf36Tq
         G/oQP61gi8skOJrAmBJds9+QgKNeFCfPzU6GEoaCr0LbmzRHoBx4egLuM6BmuBF9xhYE
         GvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zx475DjljKG62JPPjVZpqEPtbzKYJvMSYioU3iV5J2A=;
        b=UuqxAlQKi3zj8WL/GlBbiePrQ+ZwdjKdscGXgM1bKWE57Vt6DBWKQK3f172fcq8pCk
         kJ14qPFmpNXgjLC1CDQ0zzK9KEH1WzJzsaJMaDqX4AN1p/yE8bl+n7Pg+LdjVTjbsMR3
         lCovE/tW5/uQKP+NhzKgT9IU1mhJLoGfdhu3D/EvdaiKdIfqcmP0e3tydF12Y1x3S7Qp
         A24uai5b4WdvkynmsVl5nnFw3uKvjS/4dPnEoUGlz9mCe0azjClfxMCL+cJTO1f1GKKT
         gSRPyCP7F7h0C6CSHRR/9BKpz/4N2RpavANVJ0uTc7BRzgXox+Ch+jjD6TDIqX8cF3EK
         fr2g==
X-Gm-Message-State: AOAM532RlOFgmQmlE5UgeQQI4uJ8CcTXticogyZ9xLU0Wxjj6szrP4MD
        WIHQoZszYuUcfBTKGfL5SysNqOByMov2Mic9j+EEUPHD
X-Google-Smtp-Source: ABdhPJwTNz7hP2ORu8l2qeEuvQyR5yDg+subTCvoDr9omrahB4t+wDT9L/FyC60Ex/1aAVwMyDt9bIV1b9+PKGRRwIg=
X-Received: by 2002:a9d:4d8f:0:b0:606:210c:ccf5 with SMTP id
 u15-20020a9d4d8f000000b00606210cccf5mr908030otk.308.1651839153565; Fri, 06
 May 2022 05:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
 <CAP94bnMHggYR=FOh8462tncFAxOUJ-db=yj7YPoTJRS-VwjEgw@mail.gmail.com> <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB6019000A6C54CF97447E7B6EA5C59@AM0PR04MB6019.eurprd04.prod.outlook.com>
From:   =?UTF-8?Q?Christian_Gr=C3=BCn?= <christian.gruen@gmail.com>
Date:   Fri, 6 May 2022 14:12:22 +0200
Message-ID: <CAP94bnO9myHnSv7V15XdJDZY6WkvA85r5m_1=kyFi5=GCYMmeQ@mail.gmail.com>
Subject: Re: Resizing panels in the gitk window
To:     =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Halil Sen <halilsen@gmail.com>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Matthias, for the clarification. I=E2=80=99ll follow the discussion=
 on GitHub.


On Fri, May 6, 2022 at 2:00 PM Matthias A=C3=9Fhauer <mha1993@live.de> wrot=
e:
>
>
> On Thu, 5 May 2022, Christian Gr=C3=BCn wrote:
>
> > Resizing panels in the gitk window leads to a error message that=E2=80=
=99s
> > presented multiple times in a dialog:
> >
> > expected integer but got ""
> > expected integer but got ""
> >    while executing
> > "$win sash place 0 $sash0 [lindex $s0 1]"
> >    (procedure "resizeclistpanes" line 38)
> >    invoked from within
> > "resizeclistpanes .tf.histframe.pwclist 1834"
> >    (command bound to event)
> >
> > Is this a known bug?
>
> It looks like the issue at [1]. It sadly seems like nobody ever reviewed
> or applied thos suggested patches, but there is some more off-list
> discussion at [2].
>
> > I=E2=80=99ll be happy to give more details.
> > Best, Christian
> >
>
> Best regards
>
> Matthias
>
> [1] https://lore.kernel.org/git/pull.1219.git.git.1645386457.gitgitgadget=
@gmail.com/#t
> [2] https://github.com/git/git/pull/1219#issuecomment-1113122632
