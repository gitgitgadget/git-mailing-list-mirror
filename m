Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDA5C433E6
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C502664E2F
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhBAGFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhBAFzr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 00:55:47 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF9AC061574
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 21:54:52 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id w8so17634707oie.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 21:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SlBddtHoZ8Mj6J9J5JcbGLBYbSquRrHL8/6JQlus8gg=;
        b=eTboOKer2mUaqXAcVB+zAglDcB3lD8iD2J2qNYfWRZVGjeAQL1SDr0QywWloyUEA66
         sRPH1KFzm8d5HzYfNWVI+P+PyEN7muAWN+4Aq+bIH+c2TT6S1uhbqfrW/5r70fU0Yv0V
         i+57VjH3XI+mXiZzDVGS13jwq9koEMdKL14PaoGxKeXkLk1FPfzRkDDlw06XFc11ZrJs
         r6OQr+9AhqmfCbOS7rIew2dXmbGYGBpIwjApb5/90QiZtRt1Upq+jDo3yncj/buicLDw
         wiwZjSIHAhpxIjkP3eExHYwN+6CbjnN45sX1qE4MVyCAiLY9jaT5gW8Ccw3fj8ssAdRM
         GlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SlBddtHoZ8Mj6J9J5JcbGLBYbSquRrHL8/6JQlus8gg=;
        b=CYM97hB0IzUaORwSbOMQ8F3AaTUPpvi8+F/p2f/0py/ZSTISYapjQVTnjLTXKPodYi
         aDI93c2wE6xK1j9lvtrPF1AlBJpzjZM2GuYk9xXq/UPTchtQrI4ATzbrTbCxzMIBYGDh
         D8b/yytALeDOzHN5wz2r4387vcBkvEVEsQdVrL9frzS7oeQHr2y93AgNA31sOtAEfGF4
         mrsLCoXQNs/tFmuiUPzlIz/QAQRarKBjYH6N3lJXWmdhMFm0DPSHer5dQt9KxD9RUX/k
         TaPbTkY9d7KUKX5EAy8U0Mb1BSzZuMMgSsYSqPYgIRex13QJB79It4+5GN+bfZxef9ZB
         H+EA==
X-Gm-Message-State: AOAM5312eJraLoZkLi0WvgFJtbO+45pZ2LizI5Sk5ecESFWCD6DqtgMX
        fGYYOsK/jDxfK9uZorT/zgC6f/FeOUtQ4BeH220=
X-Google-Smtp-Source: ABdhPJx/KdPY0MGKoEx+2tjeJIZl5HRjKQeVfDvps0h7IawNOx9Qwj0T/TQ3mCRpi8YePRi6BI+eUl+8Du7/0sABxYw=
X-Received: by 2002:aca:5290:: with SMTP id g138mr10328702oib.44.1612158891825;
 Sun, 31 Jan 2021 21:54:51 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POKSOaaq0A-L2RgQ+R+bJVo-KuZChEOcCuO8jP+Cm9QFPw@mail.gmail.com>
In-Reply-To: <CAGP6POKSOaaq0A-L2RgQ+R+bJVo-KuZChEOcCuO8jP+Cm9QFPw@mail.gmail.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Mon, 1 Feb 2021 13:56:55 +0800
Message-ID: <CAOLTT8SsmzNNvQHaP3+vQmuq0fdRbFNL8ukOvPW5Zw9+nPk32Q@mail.gmail.com>
Subject: Re: Recover a git repo after accidentally deleting some hash files
 located under .git/objects.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi=EF=BC=8CI don't think so unless you have the commit
 in github or gitlab which include this file=EF=BC=8C
maybe you can use git pull to get it.
By the way ,you can ask questions in irc chatroom #git or #git-devel.
There will be a good place to get help.
--
adlternative

Hongyi Zhao <hongyi.zhao@gmail.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8810:16=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> I accidentally deleted some hash files located under the project's
> .git/objects subdirectory. In this case, can I resume the project?
>
> Regards
> --
> Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
> Theory and Simulation of Materials
> Hebei Polytechnic University of Science and Technology engineering
> NO. 552 North Gangtie Road, Xingtai, China
