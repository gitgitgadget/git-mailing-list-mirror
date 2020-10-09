Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F79C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E41D5222C3
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 19:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqXu13sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbgJITbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 15:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388879AbgJITbg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 15:31:36 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D87DC0613D5
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 12:31:34 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n6so11115069wrm.13
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 12:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRvf1CbBZvbPWyKJUrca6kfPOWnbZKrUnoYG8c1cSgM=;
        b=dqXu13scBQFR5PL8XtTZ1YZU/rgPebRckhN3CDS3xEE3OzKx2ur6okKsYsOnnAhQhb
         MPxvk0mdNIx4U65kDPTrMB8cdgjHTgYb82vGr7+eNrSv3WDzteCqD7djvOOPMR6ZYhlv
         TLx+bRMsX5XF48DxIkg2nTx/GFNd58+axrB+VFwBaDe+2wbyiDB+hqEtoAclRWQIobyU
         Vgi8a0NwNXxyGy0rVYSNS7LqPV+se8ChqokuYt8uXQ4FMD5Sb1xxnO7FMmQ5JVzfc2Y0
         zVJNdOElCxFum1sbBggJ4SFoC3akcmym2hTMZ5DII45axtD4ecxqHPKSUy68nEzG3zQl
         PxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRvf1CbBZvbPWyKJUrca6kfPOWnbZKrUnoYG8c1cSgM=;
        b=DFA/BIYoWoY/arHypPr8Qyjl+146wQXf+U4b4+2wR5i2jw9JBEYosBO9PCZ3eadVzP
         akAu/c1k3tiz/mbQTEcsuJ0u7cae5hce5/690ouOjVQfrVO0GU2zQDbmF69LeIJaQFdG
         IwqofqHV26PDbPoXaZBZYBC7bT+NGhLzx8BZidMIeAdo8HwzZb0MdPp5bYGr8JiGNVj9
         qCvpvVHWBfrxeQG4Hv5GExcIzCgQrVWZmuW20d+0QC8c1SiFbf/97a4kEnM+bdMKN4oI
         y0PuLKseGc//LVdEoG6R/vcxpa1BqN/409lxX4NJCyFpCDFozCRsm/c2FXlnZjdSaKkC
         rIDA==
X-Gm-Message-State: AOAM531sjHSP5f9LIXzseFWYb32Hp+X0gLFSehHpXgGlHiGNKMSYiQMs
        1hc/XHifZjYowMCkfw+vjpJKihSauAUsjYSPD6A=
X-Google-Smtp-Source: ABdhPJzBBRWE0pU/GxOIv/Fiw+2ZfAxV7CIGPaCOThQejvxBUekkqOG8ppnce+BUGESZo0deiinDBYfn4YJ8aOmDkLA=
X-Received: by 2002:a05:6000:104c:: with SMTP id c12mr16022342wrx.133.1602271893041;
 Fri, 09 Oct 2020 12:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
 <20201009002541.GB2415320@google.com> <20201009014319.GA2429084@google.com> <20201009185727.GN331156@google.com>
In-Reply-To: <20201009185727.GN331156@google.com>
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Fri, 9 Oct 2020 20:29:56 +0100
Message-ID: <CAGxm6oWUdz3_t3iz5m30spLJVC_zX43FyW7VcKKu+dNFRLa+Hg@mail.gmail.com>
Subject: Re: Introduction - An Outreachy 2020 Applicant
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Noted, thank you.


On Fri, Oct 9, 2020 at 7:57 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Thu, Oct 08, 2020 at 06:43:19PM -0700, Jonathan Nieder wrote:
> >
> > Jonathan Nieder wrote:
> >
> > > +wireshark-dev@wireshark.org
> > > Hi Amanda,
> > >
> > > Amanda Shafack wrote:
> > >
> > >> I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
> > >> contribute to the "Add Git protocol support to Wireshark" project.
> > >>
> > >> In addition, I have some experience coding in C and I hope to enhance
> > >> my skill set by contributing to this project.
> > >>
> > >> I am currently going through the project description and contribution
> > >> guidelines.
> > >
> > > Welcome!
>
> Seconded! We're glad to have your interest. Jonathan and I tend to both
> be available on IRC (#git-devel on Freenode) if you find you would
> benefit from some real-time assistance; Jonathan goes by jrnieder and I
> go by nasamuffin there. In general, everyone on both projects is motivated
> to help you get through your application microproject as painlessly as
> possible, so don't be shy if you feel stuck!
>
>  - Emily



-- 

Cheers!

Amanda  Shafack
