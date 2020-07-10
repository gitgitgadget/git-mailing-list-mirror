Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C01CC433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 08:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6562E2078B
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 08:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEnnjzKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgGJIOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJIOk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 04:14:40 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9472FC08C5CE
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 01:14:40 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id e15so2529320vsc.7
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZucHI+m36qW1BQl3SIZ7q3myvU5tVvoYGmvwwCAhsWU=;
        b=fEnnjzKx5RrNkpx1lDWU8qpVhTf//pD6m2nnwyK4U3zohw2KFHSmZWnOO4mjxvde6q
         apnv/GIRP7PNqMWy0FmbHbtpZKnzXgUwmP14Usrb38N0P7Ar/07NzkNJcuf91KB6qXNX
         +sGRTmPWGTUo9WOuKNYktKUewC9b887GXCC7+nnzV14/zDOTI7sVPEqdh9PE7WUtWHvH
         cIUkIl2IMI3FRqBWnUq4rqp59+G5FJGbrs2TsEZmZYlsqhf2MMresg8IYfJe3vynvbBZ
         59zAHvta3n2rL0vB6pF+qaUDlxg/RmyfFcm1wVM7ECjCBoIW2K4MCH7HGpMlSuSq6rdX
         +vaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZucHI+m36qW1BQl3SIZ7q3myvU5tVvoYGmvwwCAhsWU=;
        b=YVULyBpFFMhAAu2xFO+zQeUR9oOWDHWvhW4l+N5rqlPx7wauUITopEVeHw6peUMiSI
         2tgYp6Y9tzDld3E6S9BbDiUhdtz3f3IjxmLMMwqWSxU9SnjIH6pCfCS6rJeF+A4zOjkf
         GAmWNiYFXjea3uPuVUgluIgu2kSsDEBeUTPDNUmyFyOtI/WS3n3fHSHtJOqZ8D16WGZF
         nSbIfX2cSONXvP2LhUqfIzydhVuDCBKKHz7t4/9VD5o4RGi1mML7NxK+IN+MQxdB7HA8
         /BBw1oKTwPi1DPRT6v8CrK+gBGwoZB3fiwJfxi0ok1UmjyAysclsPVARyGhbELzq0C21
         MsGQ==
X-Gm-Message-State: AOAM533YfDXvOULezobbZCM2DX816ZwCOcX4mD8rfcm3j7aMcVhfj5gP
        CNiGP+IHwDTWUfVUpITl09sTw2udOHVtQR0g5gw=
X-Google-Smtp-Source: ABdhPJyuxSudxX1mrc8HUKTUpR/m9RotGFOO/VU7k83CfMBWLKJlDn+9bkdG9q1iI3kW5ZlsIC84M/pu739xAehWqqU=
X-Received: by 2002:a67:e046:: with SMTP id n6mr21127971vsl.6.1594368879654;
 Fri, 10 Jul 2020 01:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
In-Reply-To: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 10 Jul 2020 01:14:28 -0700
Message-ID: <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

it is easier to write specific "not match" using PCRE syntax, but
there are several other options to choose from combining as many
expressions as needed from the `git log` man page:

  git log -P --all-match --grep '12' --grep '\b(?!t123\b)\w+'

Carlo
