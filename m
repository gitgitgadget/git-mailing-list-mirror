Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A321C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491A86142E
	for <git@archiver.kernel.org>; Thu, 13 May 2021 09:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhEMJGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 05:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhEMJGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 05:06:03 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D1C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:04:54 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e14so22446566ils.12
        for <git@vger.kernel.org>; Thu, 13 May 2021 02:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qHQ1lwJtIFaR3dRKraQ0MUnn5U8/CxLfTDaD2cmndhU=;
        b=D/Sqdla9lJJsPZh6lhf7k5tvLf9uu2PFal9RzG1b/y5nVYBdjfsHCFhdUcVTcB+Xmu
         n1x9Cad33kjF1OH5jAOfYPw9eeQkiOgYxTrenh0OSuDNvG0GQ4/CZxHcjUdWG+tu+2C9
         HVdSryyMS4Se2szJkoj4jR7TFgqn0HcM6YK7MPK87snWZrk+0gl3fXCSSO3D0o8ONfWk
         TwG7JFqEzVvOpIDRvlmSF0iE5PbD+zXQ7/3XYJiBpYhpS2yTH/4C/QQ/NE6ENZ+7yV3r
         VHV/FJxqhVA6BFCIjvBtt1x9OrDTCr8chtUQD6FeLq1yFA1yJk4yYc/d+NrUDDnnezHb
         6f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qHQ1lwJtIFaR3dRKraQ0MUnn5U8/CxLfTDaD2cmndhU=;
        b=tRCR0pD/YeEtfk/fQYf84BY+w4dSa6YUbYlcT4fpM3MAikYg0sKzgQGA1xrVlh7XNO
         sOyFVqkERZzPlCbZF3ebsuOEbyiUjbraVksury3qeVj1LKWZMTDyr+10eVZkTXvf/BP1
         uogSFuSNlVBNSEeHY8gxo0OkxZPlJgH+OLUXzbEbiko9HV4Cu3et1zV0lrtufnykwtfy
         29t4pUL38iz3dkau5Av4ySS6K21ggSWRfhQixHmy3tGIMh32wtF94dJ1Nu+hEKSNwDSo
         z/O3/CWw1f22zpk5ZhwHcIoFr+mQIlqfUEJrrujoW+YeFfaFiftTQMZngN59xpKl/1KF
         ZZtg==
X-Gm-Message-State: AOAM532y5G9XJzq/GayvRGi93HRcp6yDvKa9SobLw03zcZHqUVcRta+z
        LdOZrML6RaME+3Sn4IXiHl3JHIKPcQI6jGP4UW9pqDwIe2Dq4g==
X-Google-Smtp-Source: ABdhPJybrcGIRIlCQUC8Cn6/BFR+eW/Z4BfmgjxpGt5IzrCU6NpqhRYeW/NCThc8C/2klN80RixRlpmb/vRV8MmLlf8=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr35632040ilj.53.1620896693946;
 Thu, 13 May 2021 02:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
 <pull.951.v3.git.1620821464.gitgitgadget@gmail.com> <91ca57c9d04a822aa4955dbfe3962a6fb2444e81.1620821464.git.gitgitgadget@gmail.com>
 <xmqqpmxveee9.fsf@gitster.g>
In-Reply-To: <xmqqpmxveee9.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 13 May 2021 17:04:36 +0800
Message-ID: <CAOLTT8T9iwAk1vyQVa_kM5zdym6-UJ0Fi6gWJp=YnSAVOiCDsw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] [GSOC] ref-filter: add objectsize to used_atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=887:11=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Since "objectsize:size" is composed of two parts,
> > "type:attribute". However, the original implementation
>
> Y is missing in the above "Since X, Y".  Because it is composed of
> two parts, what?
>
> Dropping "Since " would make the sentence work better.  Also, I
> think it should be "objectsize:disk".
>

Oh, here is my typo.

> > did not decouple the two parts "type" and "attribute" well,
> > we still need to judge separately whether the atom is
> > "objectsize" or "objectsize:disk" in `grab_common_values()`.
>
> Perhaps
>
>         When the support for "objectsize:disk" was bolted onto the
>         existing support for "objectsize", it didn't follow the
>         usual pattern for handling "atomtype:modifier", which reads
>         the <modifier> part just once while parsing the format
>         string, and store the parsed result in the union in the
>         used_atom structure, so that the string form of it does not
>         have to be parsed over and over at runtime (e.g. in
>         grab_common_values()).
>

That=E2=80=99s great.

Thanks.
--
ZheNing Hu
