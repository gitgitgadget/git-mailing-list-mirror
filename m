Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C88741FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 12:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758320AbdACMG7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 07:06:59 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34125 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758312AbdACMGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 07:06:54 -0500
Received: by mail-io0-f195.google.com with SMTP id n85so30234266ioi.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SDPbZafuTTyJYObrCUOt5DLfldc5EScZJpBu/miocIY=;
        b=mrCE8k1MYidcoXusmGzSoWF+Zkt9/QEbZaIBIWnoEwxfvl7Pg5FegV0vQ0pb3i9MgF
         xtRIXp1vtzOFh75xnLwbyFeDrwGP/HJ1JHdSiYoZUtLWiGhpOqYIcFvuzVNxDoKISiE8
         KLH/MY3K6PALQM6ormeMTen9DyoRVj+cAnrIX+cNQhOnhilsc2JPguTf9xNIqzA4SLqC
         iLwEuEiYPXU1gCQ5CIa93qwW0D/VB7kQwluC/4QFrP3Pk1+Kemo6rVKhGj4U0LTuXZ+Z
         r2SWW+U5yTdIQuBGdFhjYgVv5nERn+offUHpE3vnTSlHDYT+al7COd62Cg+NKzr53iUU
         56Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SDPbZafuTTyJYObrCUOt5DLfldc5EScZJpBu/miocIY=;
        b=UG60y9KzVSod1qnz5TQTconpD1Fbnm5paevQV9M4/LKGuWntxieL+aGfkqyHn5AUt4
         U4fZ7zGrR3JYw4LJ6NrpAKVyb2A2d6gLgCH8ySDXigtEvDGSLB79jPMF94G6Xm0Hbkzl
         Jjpp4v14Gkif3Qni4FNpDsh/ejOcona6VH+FP/K/2+LAQ9gTwNmfZiOZlAdSIJarOcxU
         gJfXfxxlFWbPxXSvvsBwoCLGbbEBnRRhyLEEIoDhVwFttHn4HAO0kDaKUz/f+8upBp/a
         qZz1A5iYJV/1qxfaAYeB4pI7IBRGBrPBT7OeSlC3kqzkvhSJLmPP9otDWpQmnx16YWl+
         +wDw==
X-Gm-Message-State: AIkVDXI8bOtOidzDCQgyMlK/Th9N6jPEQqNLY33nbQDhsXrzjw62C/6vfBY4KqNEsWAw5D+SK3F/5Pt6DP9DTQ==
X-Received: by 10.107.59.9 with SMTP id i9mr54816262ioa.176.1483445213255;
 Tue, 03 Jan 2017 04:06:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 3 Jan 2017 04:06:22 -0800 (PST)
In-Reply-To: <1481670870-66754-7-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com> <1481670870-66754-7-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 3 Jan 2017 19:06:22 +0700
Message-ID: <CACsJy8BnzE0Dis19RCddeFGhn-9Lm8R38NqN4T4qhHi1dRA8FQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] pathspec: copy and free owned memory
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2016 at 6:14 AM, Brandon Williams <bmwill@google.com> wrote:
>  void clear_pathspec(struct pathspec *pathspec)
>  {
> +       int i;
> +
> +       for (i = 0; i < pathspec->nr; i++) {
> +               free(pathspec->items[i].match);
> +               free(pathspec->items[i].original);
> +       }
>         free(pathspec->items);
>         pathspec->items = NULL;

We should set pathspec->nr to zero so that calling this function again
won't cause any harm.

>  }
-- 
Duy
