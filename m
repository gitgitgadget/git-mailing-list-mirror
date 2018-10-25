Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F111F453
	for <e@80x24.org>; Thu, 25 Oct 2018 18:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJZDYA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 23:24:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43178 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJZDYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 23:24:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so9452119eds.10
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51vGX3/qxW7+VCC911d7pvPX3rQJl5ZZWFnbWS6BDBk=;
        b=JSb5Aau9fnPEX2HrJlj1nyAM08vGCOIb2FTgex2UW47QENBs5TJLsU/+bQf5xezZDY
         kXa+VTiRBb34op8/NT9RQnmwUaj4xtfg2v+EJOVoMdA1Q4C6vkED/pxi+MOAH/K69B/Z
         0/AI+aXvVA9xMHGWtefkGERKXvXXg2tKLu6IwcM+imdhm8BlUiMwbYKmLw2MGMBY7qnj
         E/UAm6vt5YtVLpksdy1rD5xFs7B1GIFSOASE1jA9IdghJa6IBI6hQAOv4FigAXz2GVi3
         1hSn5fCuJRyOrVKuw/176X4oBdYFHg7aHEapV+LiM7B9GPknXYi58eyodrK7tO0cXsdN
         nL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51vGX3/qxW7+VCC911d7pvPX3rQJl5ZZWFnbWS6BDBk=;
        b=P2irpOyWzryGT/8SQOGU8mE6QcSrS7J+/aBKijRtTUyj0h4xyTqin8BDkpIs/onW+x
         MGzVpYMSmFZs8N0buS279pYD7Dgmuw9ZJ8RPm0o1opKZXCkj0jUJj7VTX33fCqTD9epB
         bnM5ouY+ipYL7JT2zNRFHc6+3OftzsmMBb+hHwEY2x/uELkVdrF9faeNB4ZlCiPKmCvK
         gAlATVNJTWqX+XoC33E7ZMd6KFH6ZpgSmSRh425pz9uhPjT8/wsd06SC/lUq8pAGuQQh
         vM7fujVirvUioV9EbTb1bRuTX0E/G9l95wB8j9zraybPvhB8FHj/qcgPjtmLo4Cg0pPT
         8SEg==
X-Gm-Message-State: AGRZ1gILG+20QPcI+iiEh3T7rxbGC+cjxeO9fz0jfiP+t3LODhcyjfwb
        a5paQfkmUknmYZQZoVItbZEGMG6T+odTwMd2cv/PiQ==
X-Google-Smtp-Source: AJdET5eA012XpcSSPxmp5063XNYZC2vNwImFnYyF61yuACpIkOFLzdaoJmlQbqMR3kfyrb4DFS3VLMffiNNiSxfAMzI=
X-Received: by 2002:a17:906:e287:: with SMTP id gg7-v6mr230474ejb.128.1540493402052;
 Thu, 25 Oct 2018 11:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181025161813.17252-1-ao2@ao2.it>
In-Reply-To: <20181025161813.17252-1-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Oct 2018 11:49:50 -0700
Message-ID: <CAGZ79kZvzLtSgAw8epGpG+T2f2Q7z2ZkXe=4gKMQTkM8ikwcog@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] Make submodules work if .gitmodules is not
 checked out
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In this series I am addressing the comments by Stefan Beller about the
> tests in patch 9.
>
> If the new tests look OK, I'd say we try moving the series to "next" and
> see what happens?

Sounds good to me.

Thanks,
Stefan
