Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F461F453
	for <e@80x24.org>; Mon, 15 Oct 2018 11:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbeJOSps (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 14:45:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34408 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeJOSps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 14:45:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id v69-v6so14727216oif.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h5RD2yOmwqY+MX/0i1oKmxp75WsQzDUwU2MXPB8fKqk=;
        b=IVsdHCSNrP5NrRMY62GI/czZKDQ+w4GOcou+iwRRjJcQjEGEsILhEdKQI54P1KHcOQ
         W8344+yx344xISECsbBvsmFXXODvigJxSTZkn++qGKEDUoOVMBmEnPbJzcEUhORU3gE9
         9mmFBBct8Sgc7e2vJ+pEqdNISygNF4TffvevY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h5RD2yOmwqY+MX/0i1oKmxp75WsQzDUwU2MXPB8fKqk=;
        b=Fuw3CAQTHBh1Q5++tWmRw5jsgWx3qyFghOdapLlBAwpODmO2tvrnqCSY8qN17HV2zQ
         kuXhYl5Fnzrkx6zwO6YKXVOt0Al1MwcgRhVYtth0lpIjfxXYjrUwpzDf7Ao5ZA8YXFZ9
         4khZYKCWZdI8FZtSypmGhXihVRHfhTI7b61+J9Yi+fB/woxF2x/YarMAkUoiEwFtQm8V
         Upt+K19OA9rKkXcCInPmpwHWSvPX6ZQD/eSSfIbodWpVvWx2+BuufO9KxCSqmNMnIkNg
         VDcFWgnSy4sL11LRYtGFJ4Z/SVIPcJkHtTdJEvH4eijT4dZiidkDaNNmrbvZrq0zTkke
         qn/Q==
X-Gm-Message-State: ABuFfoiLpcSjLxVPHfMRy1IOK/utZbA+HwcTB9EDvkUJLkh/OdNzrtbm
        3ZhmaP4P84pVaaTY+0y95EPgmZ6gSihGQD4muNVhoQ==
X-Google-Smtp-Source: ACcGV63QZg2s1oZF2T/94IvWczBpDgwPBqrDMxdhKSknyBzzFdj//y5zIsOnmdNdrQ7gKEQn6K64QREtyp2GR2gXhVg=
X-Received: by 2002:aca:3987:: with SMTP id g129-v6mr9061507oia.152.1539601261829;
 Mon, 15 Oct 2018 04:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com>
 <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 15 Oct 2018 12:00:50 +0100
Message-ID: <CAE5ih79cNkVVQOkaeJifSqkcp=HGmRb3a=jJC=g08iV8dYRyXg@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
To:     gitgitgadget@gmail.com
Cc:     Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 15 Oct 2018 at 11:12, Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This should be more reliable than the current method, and prepares the
> test suite for a consistent way to clean up before re-running the tests
> with different options.
>

I'm finding that it's leaving p4d processes lying around.

e.g.

$ ./t9820-git-p4-editor-handling.sh
<passes>
$ ./t9820-git-p4-editor-handling.sh
<fails>

And also

$ ./t9800-git-p4-basic.sh
<starts running tests, but I get bored easily>
Ctrl-C

$ ./t9800-git-p4-basic.sh
<fails>

$ ps | grep p4d
21392 pts/1    00:00:00 p4d  <<<<<


Luke
